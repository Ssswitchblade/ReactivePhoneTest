import UIKit
import Foundation

protocol ImageGeneratorDisplayLogic: AnyObject {
    func displayImage(_ viewModel: ImageGeneratorModels.LoadImage.ViewModel)
    func displayError(_ viewModel: ImageGeneratorModels.PresentError.ViewModel)
}

final class ImageGeneratorViewController: UIViewController {
    
    private var interactor: ImageGeneratorBusinessLogic?
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .blue.withAlphaComponent(0.7)
        button.setTitle("Добавить изображение в избранное", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.isHidden = true
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите текст для картинки"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 15
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: .init(x: 0, y: 0, width: 5, height: 5))
        textField.delegate = self
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let requestButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .blue.withAlphaComponent(0.7)
        button.setTitle("Сгенерировать изображение", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.isEnabled = false
        return button
    }()
    
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
        setupUI()
        makeSubviewsLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getAllImages()
    }
    
    private func setup() {
        let interactor = ImageGeneratorInteractor()
        let presenter = ImageGeneratorPresenter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.interactor = interactor
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [
            favoriteButton,
            imageView,
            textField,
            requestButton
        ].forEach(view.addSubview)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        requestButton.addTarget(self, action: #selector(getImage), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
    }
    
    private func makeSubviewsLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        //FavoriteButton
        let favoriteButtonTopAnchor = favoriteButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30)
        let favoriteButtonLeadingAnchor = favoriteButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25)
        let favoriteButtonTrailingAnchor = favoriteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25)
        let favoriteButtonHeightAnchor = favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([favoriteButtonTopAnchor, favoriteButtonLeadingAnchor, favoriteButtonTrailingAnchor, favoriteButtonHeightAnchor])
        
        //ImageView
        let imageViewTopAnchor = imageView.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 20)
        let imageViewCenterX = imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        let imageViewHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: 250)
        let imageViewWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([imageViewTopAnchor, imageViewCenterX, imageViewHeightAnchor, imageViewWidthAnchor])
        
        //TextField
        let textFieldTopAnchor = textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
        let textFieldLeadingAnchor = textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25)
        let textFieldTrailingAnchor = textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25)
        let textFieldHeightAnchor = textField.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([textFieldTopAnchor, textFieldLeadingAnchor, textFieldTrailingAnchor, textFieldHeightAnchor])
        
        //RequestButton
        let requestButtonTopAnchor = requestButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30)
        let requestButtonLeadingAnchor = requestButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25)
        let requestButtonTrailingAnchor = requestButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25)
        let requestButtonHeightAnchor = requestButton.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([requestButtonTopAnchor, requestButtonLeadingAnchor, requestButtonTrailingAnchor, requestButtonHeightAnchor])
    }
    
    @objc func addToFavorite() {
        interactor?.addToFavorite()
        favoriteButton.isHidden = true 
    }
    
    
    
     @objc func getImage() {
         guard let text = textField.text else { return }
         let request = ImageGeneratorModels.LoadImage.Reguest(text: text)
         interactor?.getImage(request)
    }
}

extension ImageGeneratorViewController: ImageGeneratorDisplayLogic {
    func displayImage(_ viewModel: ImageGeneratorModels.LoadImage.ViewModel) {
        DispatchQueue.main.async {
            self.imageView.image = viewModel.image
            self.favoriteButton.isHidden = false
        }
    }
    
    func displayError(_ viewModel: ImageGeneratorModels.PresentError.ViewModel) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: viewModel.errorText, message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ImageGeneratorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        requestButton.isEnabled = textField.text != ""
        favoriteButton.isHidden = true
    }
}
