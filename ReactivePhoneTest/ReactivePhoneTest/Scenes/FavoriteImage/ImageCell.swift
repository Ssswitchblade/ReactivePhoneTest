import UIKit
import Foundation

final class ImageCell: UITableViewCell {
    
    static let reuseidentifier = "UITableViewCell"
    
    var buttonTapCallback: () -> ()  = { }
    
    var index: Int = 0
    
    private let requestLabel = UILabel()
    
    private let imageContainerView = UIImageView()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Удалить", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        makeSubviewsLayout()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [
            requestLabel,
            imageContainerView,
            deleteButton
        ].forEach(contentView.addSubview)
        selectionStyle = .none
        deleteButton.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
    }
    
    private func makeSubviewsLayout() {
        //RequestLabel
        requestLabel.translatesAutoresizingMaskIntoConstraints = false
        let requestLabelTopAnchor = requestLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        let requestLabelLeadingAnchor = requestLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25)
        let requestLabelTrailingAnchor = requestLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        NSLayoutConstraint.activate([requestLabelTopAnchor, requestLabelLeadingAnchor, requestLabelTrailingAnchor])
        
        //ImageContainerView
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewTopAnchor = imageContainerView.topAnchor.constraint(equalTo: requestLabel.bottomAnchor, constant: 10)
        let imageViewCenterXAnchor = imageContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let imageViewHeightAnchor = imageContainerView.heightAnchor.constraint(equalToConstant: 125)
        let imageViewWidhtAnchor = imageContainerView.widthAnchor.constraint(equalToConstant: 125)
        NSLayoutConstraint.activate([imageViewTopAnchor, imageViewCenterXAnchor, imageViewHeightAnchor, imageViewWidhtAnchor])
        
        //DeleteButton
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        let deleteBtnTopAnchor = deleteButton.topAnchor.constraint(equalTo: imageContainerView.topAnchor)
        let deleteBtnLeadingAnchor = deleteButton.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: 20)
        let deleteBtnWidthAnchor = deleteButton.widthAnchor.constraint(equalToConstant: 75)
        let deleteBtnHeightAnchor = deleteButton.heightAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([deleteBtnTopAnchor, deleteBtnLeadingAnchor, deleteBtnWidthAnchor, deleteBtnHeightAnchor])
    }
    
    func setupCell(image: ImageResponse) {
        imageContainerView.image = UIImage(data: image.data)
        requestLabel.text = image.text
    }
    
    @objc func deleteImage() {
        buttonTapCallback()
    }
}
