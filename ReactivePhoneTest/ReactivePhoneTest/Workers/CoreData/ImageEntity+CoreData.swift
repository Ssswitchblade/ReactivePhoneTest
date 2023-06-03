import Foundation
import CoreData

@objc(ImageEntity)
public class ImageEntity: NSManagedObject {

}

extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var request: String
    @NSManaged public var image: Data

}
