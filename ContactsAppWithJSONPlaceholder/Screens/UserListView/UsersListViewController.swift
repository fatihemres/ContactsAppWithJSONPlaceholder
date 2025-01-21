//
//  UsersListViewController.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit
import SnapKit
import Then

/// `UserListBuilder` is responsible for constructing the `UserListViewController`.
/// This ensures the initialization process is encapsulated and consistent.
final class UserListBuilder: NSObject {
    private var coordinator: UserListViewCoordinator

    /// Initializes the builder with a `UserListViewCoordinator`.
    /// - Parameter coordinator: The coordinator responsible for handling navigation from this view.
    init(coordinator: UserListViewCoordinator) {
        self.coordinator = coordinator
    }
    
    /// Builds and returns an instance of `UserListViewController`.
    /// - Returns: A fully initialized `UserListViewController`.
    func build() -> UIViewController {
        let viewController = UserListViewController(coordinator: coordinator)
        return viewController
    }
}

final class UserListViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: UsersListViewModel
    private var coordinator: UserListViewCoordinator

    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "Search users"
        $0.delegate = self
        $0.barTintColor = .mainBackground
        $0.accessibilityIdentifier = "SearchBar"
    }
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .mainBackground
        $0.accessibilityIdentifier = "UserListTableView"
    }
    
    private lazy var noDataLabel = UILabel().then {
        $0.text = "No users found"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .gray
        $0.isHidden = true
        $0.accessibilityIdentifier = "NoDataLabel"
    }
    
    // MARK: - Initialization
    /// Initializes the view controller with its coordinator and sets up the view model.
    /// - Parameter coordinator: The coordinator for handling navigation from this view.
    init(coordinator: UserListViewCoordinator) {
        self.coordinator = coordinator
        self.viewModel = UsersListViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindState()
        viewModel.start()
    }
    
    // MARK: - UI Setup
    /// Configures the initial UI layout and adds subviews.
    private func setupUI() {
        title = "User List"
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(noDataLabel)
    }
    
    /// Sets up the layout constraints for subviews using SnapKit.
    private func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        noDataLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - State Binding
    /// Binds the view model's state changes to the view.
    private func bindState() {
        viewModel.stateChangeHandler = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                self.showLoadingIndicator()
            case .success:
                self.hideLoadingIndicator()
                self.noDataLabel.isHidden = true
                self.tableView.reloadData()
            case .empty:
                self.hideLoadingIndicator()
                self.noDataLabel.isHidden = false
                self.tableView.reloadData()
            case .error(let errorMessage):
                self.hideLoadingIndicator()
                self.showAlert(title: "Error", message: errorMessage)
            }
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.identifier,
            for: indexPath
        ) as? UserTableViewCell,
              let user = viewModel.user(at: indexPath.row) else {
            return UITableViewCell()
        }

        let cellViewModel = UserTableViewCell.ViewModel(name: user.name, email: user.email)
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = viewModel.user(at: indexPath.row) else { return }
        coordinator.goToUserDetailScreen(with: user)
    }
}

// MARK: - SearchBar Delegate
extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchUsers(with: searchText)
    }
}

#if DEBUG
import SwiftUI

/// Provides a preview of the `UserListViewController` for design and testing purposes.
struct UserListViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UserListViewController {
        let navigationController = UINavigationController()
        let coordinator = UserListViewCoordinator(navigationController: navigationController)
        return UserListViewController(coordinator: coordinator)
    }
    
    func updateUIViewController(_ uiViewController: UserListViewController, context: Context) {}
}

struct UserListViewController_Previews: PreviewProvider {
    static var previews: some View {
        UserListViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
