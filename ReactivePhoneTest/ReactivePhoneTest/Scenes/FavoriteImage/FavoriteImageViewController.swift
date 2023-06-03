import UIKit
import Foundation

protocol FavoriteImageDisplayLogic: AnyObject {
    func displayImages(_ viewModel: FavoriteImagesModels.GetData.ViewModel)
}

final class FavoriteImageViewController: UIViewController {
    
    private var interactor: FavoriteImageBusinessLogic?
    
    private var imagesData: [ImageResponse] = []
    
    private lazy var tableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setup()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurTableView()
        setupUI()
        makeSubviewsLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func makeSubviewsLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewTopAnchor = tableView.topAnchor.constraint(equalTo: safeArea.topAnchor)
        let tableViewLeadingAnchor = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableViewTrailingAnchor = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        NSLayoutConstraint.activate([tableViewTopAnchor, tableViewLeadingAnchor, tableViewTrailingAnchor, tableViewBottomAnchor])
    }
    
    private func configurTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseidentifier)
    }
    
    private func setup() {
        let interactor = FavoriteImageInteractor()
        let presenter = FavoriteImagePresenter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
    }
    
    func deleteImage(index: Int){
        let request = FavoriteImagesModels.DeleteImage.Request(image: imagesData[index])
        interactor?.deleteImage(request)
        imagesData.remove(at: index)
        tableView.reloadData()
    }
}

extension FavoriteImageViewController: FavoriteImageDisplayLogic {
    func displayImages(_ viewModel: FavoriteImagesModels.GetData.ViewModel) {
        imagesData = viewModel.images
        tableView.reloadData()
    }
}

extension FavoriteImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseidentifier, for: indexPath) as! ImageCell
        cell.setupCell(image: imagesData[indexPath.row])
        cell.index = indexPath.row
        cell.buttonTapCallback = { [weak self] in
            self?.deleteImage(index: cell.index)
        }
        return cell
    }
    
}

extension FavoriteImageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
