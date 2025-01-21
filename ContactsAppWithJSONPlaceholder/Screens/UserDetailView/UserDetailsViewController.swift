//
//  UserDetailsViewController.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit
import SnapKit
import Then

/// `UserDetailBuilder` is responsible for constructing the `UserDetailViewController`.
/// It ensures that the controller is properly initialized with its dependencies.
final class UserDetailBuilder: NSObject, Buildable {
    private var coordinator: UserDetailViewCoordinator
    private var user: User

    /// Initializes the builder with a coordinator and user.
    /// - Parameters:
    ///   - coordinator: The coordinator managing navigation for the user detail view.
    ///   - user: The user whose details are to be displayed.
    init(coordinator: UserDetailViewCoordinator, user: User) {
        self.coordinator = coordinator
        self.user = user
    }

    /// Constructs and returns a fully initialized `UserDetailViewController`.
    /// - Returns: A configured `UIViewController`.
    func build() -> UIViewController {
        let viewController = UserDetailViewController(coordinator: coordinator, user: user)
        return viewController
    }
}

/// `UserDetailViewController` displays detailed information about a specific user.
/// It includes the user's avatar, name, email, phone, and website, with interactive actions for each.
final class UserDetailViewController: BaseViewController {
    // MARK: - Properties
    private var coordinator: UserDetailViewCoordinator
    private var viewModel: UserDetailViewModel

    // MARK: - Subviews
    private let containerView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 8
    }

    private let avatarImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 60
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = .systemGray
        $0.accessibilityIdentifier = "AvatarImageView"
    }

    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.textColor = .label
        $0.textAlignment = .center
        $0.accessibilityIdentifier = "NameLabel"
    }

    private let emailButton = UIButton(type: .system).then {
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        $0.tintColor = .systemBlue
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        $0.accessibilityIdentifier = "EmailButton"
    }

    private let phoneButton = UIButton(type: .system).then {
        $0.setTitleColor(.systemGreen, for: .normal)
        $0.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        $0.tintColor = .systemGreen
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        $0.accessibilityIdentifier = "PhoneButton"
    }

    private let websiteButton = UIButton(type: .system).then {
        $0.setTitleColor(.systemOrange, for: .normal)
        $0.setImage(UIImage(systemName: "link"), for: .normal)
        $0.tintColor = .systemOrange
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        $0.accessibilityIdentifier = "WebsiteButton"
    }

    // MARK: - Initialization
    /// Initializes the view controller with a coordinator and user details.
    /// - Parameters:
    ///   - coordinator: The coordinator managing navigation for this view.
    ///   - user: The user whose details will be displayed.
    init(coordinator: UserDetailViewCoordinator, user: User) {
        self.coordinator = coordinator
        self.viewModel = UserDetailViewModel(user: user)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Details"
        setupUI()
        setupConstraints()
        bindState()
        viewModel.loadUserDetails()
    }

    // MARK: - UI Setup
    /// Configures the initial UI and adds subviews.
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailButton)
        containerView.addSubview(phoneButton)
        containerView.addSubview(websiteButton)

        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        phoneButton.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        websiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
    }

    /// Configures the layout constraints for all subviews.
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(websiteButton.snp.bottom).offset(32)
        }

        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        emailButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        phoneButton.snp.makeConstraints {
            $0.top.equalTo(emailButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        websiteButton.snp.makeConstraints {
            $0.top.equalTo(phoneButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }

    // MARK: - State Binding
    /// Binds the ViewModel's state changes to the view and updates the UI accordingly.
    private func bindState() {
        viewModel.stateChangeHandler = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .loading:
                self.showLoadingIndicator()
                self.toggleContentVisibility(isHidden: true)

            case .success:
                self.hideLoadingIndicator()
                self.toggleContentVisibility(isHidden: false)
                self.updateUI()

            case .error(let errorMessage):
                self.hideLoadingIndicator {
                    self.showAlert(title: "Error", message: errorMessage)
                    self.toggleContentVisibility(isHidden: true)
                }
            }
        }
    }

    // MARK: - UI Update
    /// Updates the UI with user details from the ViewModel.
    private func updateUI() {
        let user = viewModel.getUser()
        nameLabel.text = user.name
        emailButton.setTitle(user.email, for: .normal)
        phoneButton.setTitle(user.phone, for: .normal)
        websiteButton.setTitle(user.website, for: .normal)
    }
    
    /// Toggles the visibility of the content views based on the loading state.
    private func toggleContentVisibility(isHidden: Bool) {
        containerView.isHidden = isHidden
        avatarImageView.isHidden = isHidden
        nameLabel.isHidden = isHidden
        emailButton.isHidden = isHidden
        phoneButton.isHidden = isHidden
        websiteButton.isHidden = isHidden
    }

    // MARK: - Actions
    @objc private func emailButtonTapped() {
        guard let email = viewModel.getUser().email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "mailto:\(email)") else {
            showAlert(title: "Error", message: "Unable to open email client.")
            return
        }
        UIApplication.shared.open(url)
    }

    @objc private func phoneButtonTapped() {
        guard let phone = viewModel.getUser().phone.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "tel:\(phone)") else {
            showAlert(title: "Error", message: "Unable to make a call.")
            return
        }
        UIApplication.shared.open(url)
    }

    @objc private func websiteButtonTapped() {
        let website = viewModel.getUser().website
        guard let url = URL(string: website.hasPrefix("http") ? website : "https://\(website)") else {
            showAlert(title: "Error", message: "Invalid website URL.")
            return
        }
        UIApplication.shared.open(url)
    }
}
