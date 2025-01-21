//
//  UsersTableViewCell.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit
import SnapKit
import Then
import SwiftUI

final class UserTableViewCell: UITableViewCell {
    static let identifier = "UserTableViewCell"

    // MARK: - ViewModel
    public class ViewModel {
        let name: String
        let email: String

        init(name: String, email: String) {
            self.name = name
            self.email = email
        }
    }

    // MARK: - Subviews
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .mainBackground
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
    }

    private let avatarImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = .systemGray
    }

    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .label
    }

    private let emailLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
    }

    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .ringTwo
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Initialization
    /// Initializes the cell and sets up the UI and gestures.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupGesture()
    }

    // MARK: - Configuration
    /// Configures the cell with the user's data.
    /// - Parameter viewModel: The view model containing the user's name and email.
    public func configure(with viewModel: ViewModel) {
        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
    }

    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(arrowImageView)

        setupConstraints()
    }
    
    /// Defines the layout constraints for the subviews using SnapKit.
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-8)
        }

        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().inset(12)
        }

        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
    }

    // MARK: - Gesture
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        tapGesture.cancelsTouchesInView = false
        containerView.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapCell() {
        UIView.animate(withDuration: 0.1, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.containerView.transform = .identity
            }
        }
    }
}

// MARK: - Preview
/// Provides a preview of the cell design using SwiftUI.
/// - This preview is for testing and visualizing how the cell will appear in a table view. But it's usable only debug mode.
struct UserTableViewCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = UserTableViewCell(style: .default, reuseIdentifier: "UserTableViewCell")

        let mockViewModel = UserTableViewCell.ViewModel(name: "John Doe", email: "johndoe@example.com")
        cell.configure(with: mockViewModel)
        cell.frame = CGRect(x: 0, y: 0, width: 375, height: 60)
        return cell
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct UserTableViewCellPreview_Previews: PreviewProvider {
    static var previews: some View {
        UserTableViewCellPreview()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
