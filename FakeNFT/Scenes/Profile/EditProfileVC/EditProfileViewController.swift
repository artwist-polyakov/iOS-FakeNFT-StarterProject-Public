import Kingfisher
import UIKit

final class EditProfileViewController: UIViewController {
    weak var delegate: ProfileViewControllerDelegate?
    var profile: Profile?

    private var photoLink: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupConstrains()
        guard let imageUrl = URL(string: profile?.avatar ?? "") else { return }
        KingfisherManager.shared.retrieveImage(with: imageUrl) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let imageResult):
                self.editAvatarButton.setImage(imageResult.image, for: .normal)
            case .failure(let error):
                let errorString = HandlingErrorService().handlingHTTPStatusCodeError(error: error)
                self.showNotificationBanner(with: errorString ?? "")
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let profile else { return }
        let updateProfile = Profile(name: nameTextField.text ?? "",
                                    avatar: photoLink ?? profile.avatar,
                                    description: descriptionTextField.text ?? profile.description,
                                    website: siteTextField.text ?? profile.website,
                                    nfts: profile.nfts,
                                    likes: profile.likes,
                                    id: profile.id)
        delegate?.updateProfile(profile: updateProfile)
    }
    
    // MARK: - SetupUI
    
    private func setupBackground() {
        view.backgroundColor = .ypWhiteWithDarkMode
        view.tintColor = .ypBlackWithDarkMode
    }
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(Resources.Images.NFTBrowsing.cancellButton, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        return closeButton
    }()
    
    private lazy var editAvatarButton: UIButton = {
        let editAvatarButton = UIButton()
        editAvatarButton.backgroundColor = .ypLightGreyWithDarkMode
        editAvatarButton.layer.cornerRadius = 35
        editAvatarButton.setTitle("Сменить фото", for: .normal)
        editAvatarButton.titleLabel?.numberOfLines = 0
        editAvatarButton.titleLabel?.font = .systemFont(ofSize: 10)
        editAvatarButton.setTitleColor(.white, for: .normal)
        editAvatarButton.titleLabel?.textAlignment = .center
        editAvatarButton.clipsToBounds = true
        editAvatarButton.layer.zPosition = 2
        editAvatarButton.addTarget(self, action: #selector(editAvatarButtonTapped), for: .touchUpInside)
        editAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editAvatarButton)
        return editAvatarButton
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Имя"
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        return nameLabel
    }()
    
    private lazy var nameUnderView: UIView = {
        let nameUnderView = UIView()
        nameUnderView.layer.cornerRadius = 12
        nameUnderView.backgroundColor = .ypLightGreyWithDarkMode
        nameUnderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameUnderView)
        return nameUnderView
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nameTextField.textAlignment = .left
        nameTextField.text = profile?.name
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameUnderView.addSubview(nameTextField)
        return nameTextField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Описание"
        descriptionLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        return descriptionLabel
    }()
    
    private lazy var descriptionUnderView: UIView = {
        let descriptionUnderView = UIView()
        descriptionUnderView.layer.cornerRadius = 12
        descriptionUnderView.backgroundColor = .ypLightGreyWithDarkMode
        descriptionUnderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionUnderView)
        return descriptionUnderView
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let descriptionTextField = UITextField()
        descriptionTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        descriptionTextField.textAlignment = .left
        descriptionTextField.contentVerticalAlignment = .top
        descriptionTextField.text = profile?.description
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionUnderView.addSubview(descriptionTextField)
        return descriptionTextField
    }()
    
    private lazy var siteLabel: UILabel = {
        let siteLabel = UILabel()
        siteLabel.text = "Cайт"
        siteLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        siteLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(siteLabel)
        return siteLabel
    }()
    
    private lazy var siteUnderView: UIView = {
        let siteUnderView = UIView()
        siteUnderView.layer.cornerRadius = 12
        siteUnderView.backgroundColor = .ypLightGreyWithDarkMode
        siteUnderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(siteUnderView)
        return siteUnderView
    }()
    
    private lazy var siteTextField: UITextField = {
        let siteTextField = UITextField()
        siteTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        siteTextField.text = profile?.website
        siteTextField.translatesAutoresizingMaskIntoConstraints = false
        siteUnderView.addSubview(siteTextField)
        return siteTextField
    }()
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 42),
            closeButton.widthAnchor.constraint(equalToConstant: 42),
            
            editAvatarButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 22),
            editAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editAvatarButton.heightAnchor.constraint(equalToConstant: 70),
            editAvatarButton.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: editAvatarButton.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            nameUnderView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameUnderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameUnderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameUnderView.heightAnchor.constraint(equalToConstant: 44),
            
            nameTextField.leadingAnchor.constraint(equalTo: nameUnderView.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: nameUnderView.trailingAnchor, constant: -16),
            nameTextField.centerYAnchor.constraint(equalTo: nameUnderView.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameUnderView.bottomAnchor, constant: 22),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            descriptionUnderView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionUnderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionUnderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionUnderView.heightAnchor.constraint(equalToConstant: 135),
            
            descriptionTextField.leadingAnchor.constraint(equalTo: descriptionUnderView.leadingAnchor, constant: 16),
            descriptionTextField.trailingAnchor.constraint(equalTo: descriptionUnderView.trailingAnchor, constant: -16),
            descriptionTextField.topAnchor.constraint(equalTo: descriptionUnderView.topAnchor, constant: 11),
            descriptionTextField.bottomAnchor.constraint(equalTo: descriptionUnderView.bottomAnchor, constant: 11),
            
            siteLabel.topAnchor.constraint(equalTo: descriptionUnderView.bottomAnchor, constant: 22),
            siteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            siteUnderView.topAnchor.constraint(equalTo: siteLabel.bottomAnchor, constant: 8),
            siteUnderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            siteUnderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            siteUnderView.heightAnchor.constraint(equalToConstant: 44),
            
            siteTextField.leadingAnchor.constraint(equalTo: siteUnderView.leadingAnchor, constant: 16),
            siteTextField.trailingAnchor.constraint(equalTo: siteUnderView.trailingAnchor, constant: -16),
            siteTextField.centerYAnchor.constraint(equalTo: siteUnderView.centerYAnchor)
        ])
    }
    
    // MARK: - Alert
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
    
    private func showURLInputAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("profile.editScreen.addPicture", tableName: "Localizable", comment: "add picture"),
            message: NSLocalizedString("profile.editScreen.pointLink", tableName: "Localizable", comment: "point Link"),
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = NSLocalizedString("profile.editScreen.enterLink", tableName: "Localizable", comment: "enter link")
        }
        let okAction = UIAlertAction(
            title: NSLocalizedString("general.OK", tableName: "Localizable", comment: "OK"),
            style: .default) { [weak self] _ in
                self?.photoLink = alert.textFields?.first?.text ?? ""
            }
        
        let cancelAction = UIAlertAction(
            title: NSLocalizedString("general.cancel", tableName: "Localizable", comment: "OK"),
            style: .cancel
        )
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func editAvatarButtonTapped() {
        showURLInputAlert()
    }

}
