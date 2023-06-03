import CoreData
import Foundation

final class CoreDataWorker {
    
    static let constants = (name: "ReactivePhoneTest", maxItems: 20)
    
    private static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataWorker.constants.name)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveImage(data: Data, request: String) {
        let context: NSManagedObjectContext = CoreDataWorker.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let objects = (try? context.fetch(fetchRequest)) ?? []
        
        if let object = objects.first, objects.count >= CoreDataWorker.constants.maxItems {
            context.delete(object)
        }
        
        let imageEntity = ImageEntity(context: context)
        imageEntity.image = data
        imageEntity.request = request
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getImages() -> [ImageEntity] {
        let context: NSManagedObjectContext = CoreDataWorker.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let objects = (try? context.fetch(fetchRequest)) ?? []
        return objects
    }
    
    func deleteImage(_ image: ImageResponse) {
        let context: NSManagedObjectContext = CoreDataWorker.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let objects = (try? context.fetch(fetchRequest)) ?? []
        
        for object in objects {
            if image.text == object.request {
                context.delete(object)
                break
            }
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
