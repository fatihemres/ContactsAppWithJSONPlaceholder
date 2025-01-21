# ContactsAppWithJSONPlaceholder

ContactsAppWithJSONPlaceholder is an iOS application demonstrating the use of modern Swift architecture, clean coding practices, and robust UI/Unit testing. The app fetches user data from the [JSONPlaceholder](https://jsonplaceholder.typicode.com) API and displays it in a user-friendly interface.

---

## Features
- **User List:** Displays a list of users fetched from an API.
- **Search Functionality:** Enables users to search for contacts dynamically.
- **User Details:** Provides detailed information about each user, including email, phone, and website.
- **Custom Transitions:** Implements animated transitions for navigation.
- **Robust Testing:** Includes comprehensive Unit and UI test cases for reliability.

---

## Tech Stack

### Languages & Frameworks
- **Swift:** The primary programming language for iOS development.
- **UIKit:** Used for building the app’s user interface.
- **SnapKit:** Simplifies Auto Layout constraints using a declarative syntax.
- **Then:** Provides syntactic sugar for initializing objects.
- **SwiftUI:** Used for building reusable components, integrated into UIKit via `UIHostingController`.
- **XCTest:** Framework for writing Unit and UI tests.

### Architecture
The app follows the **Coordinator Pattern** for navigation, ensuring a modular and testable structure. This approach centralizes navigation logic, making it easier to manage transitions between screens and maintain a clean separation of concerns. It also employs a **ViewModel** layer to separate business logic from the view.

---

## Project Structure
```
ContactsAppWithJSONPlaceholder/
├── MainProject/
│   ├── AppConfig/           # Application configuration files
│   ├── Coordinator/         # Coordinator classes for navigation
│   ├── Extensions/          # Extensions for utilities and reusability
│   ├── Models/              # Data models (User, Address, Geo, Company)
│   ├── Network/             # Networking classes (EndPoint, UserRepository)
│   ├── Resources/           # Assets and configurations
│   ├── Screens/             # UIKit screens (User List, User Details)
│   ├── UIComponents/        # Reusable UI components
│   ├── Utils/               # General utility classes and helpers
│   ├── ViewModels/          # ViewModel classes for business logic
├── UnitTests/
│   ├── Mocks/               # Mock data and repositories for testing
│   ├── Tests/               # Unit test cases
├── UITests/                 # UI test cases
```

---

## Frameworks & Libraries

### SnapKit
**Why:** Simplifies Auto Layout constraints with a declarative syntax, making UI code cleaner and more maintainable.
```swift
containerView.snp.makeConstraints {
    $0.top.equalToSuperview().offset(16)
    $0.leading.trailing.equalToSuperview().inset(16)
}
```

### Then
**Why:** Reduces boilerplate code when initializing objects by allowing property configuration in a single block.
```swift
private let nameLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    $0.textColor = .label
}
```

### SwiftUI
**Why:** Enables the creation of reusable, declarative components, which can be seamlessly integrated into UIKit.
```swift
struct LoadingIndicator: View {
    var body: some View {
        ProgressView("Loading...")
    }
}
```

---

## Testing
The project includes comprehensive test coverage for both Unit and UI tests.

### Unit Tests
#### Framework: XCTest
Tests cover the following:
- **ViewModel Logic:** Validates state transitions and business logic.
- **Repository:** Ensures correct data fetching and error handling.

Example:
```swift
func testFetchUsersSuccess() {
    mockRepository.shouldReturnError = false
    let expectation = self.expectation(description: "Fetch users")
    mockRepository.fetchUsers { result in
        switch result {
        case .success(let users):
            XCTAssertEqual(users.count, 1)
        case .failure:
            XCTFail("Expected success, got failure")
        }
        expectation.fulfill()
    }
    waitForExpectations(timeout: 1.0)
}
```

### UI Tests
#### Framework: XCTest (XCUIApplication)
Tests cover:
- **User List Screen:** Verifies elements like the search bar and table view are displayed correctly.
- **Search Functionality:** Ensures accurate filtering of user results.
- **User Detail Navigation:** Validates navigation to and content of the detail screen.

Example:
```swift
func testUserDetailNavigation() {
    let cell = app.tables.cells.staticTexts["Leanne Graham"]
    XCTAssertTrue(cell.exists, "User cell should exist")
    cell.tap()
    let detailScreenTitle = app.staticTexts["User Details"]
    XCTAssertTrue(detailScreenTitle.exists, "User Details screen should be displayed")
}
```

---

## Installation

### Requirements
- **Xcode 14.0+**
- **iOS 15.0+**

### Steps
1. Clone the repository:
    ```bash
    git clone https://github.com/fatihemres/ContactsAppWithJSONPlaceholder.git
    ```
2. Open the workspace:
    ```bash
    cd ContactsAppWithJSONPlaceholder
    open ContactsAppWithJSONPlaceholder.xcworkspace
    ```
    > **Note:** Ensure you open the project using the workspace file. The project includes CocoaPods dependencies, and opening it directly through the `.xcodeproj` file may result in build errors.
3. Run the app on the simulator or a physical device.

---

## Screenshots

<div style="display: flex; justify-content: space-around;">
    <img src="https://github.com/user-attachments/assets/d689c566-5c3c-446d-b3b0-20ba0d4663ac" alt="User List Screen" width="25%"/>
    <img src="https://github.com/user-attachments/assets/f6503629-30b6-4f1b-afcb-ea9507fa0e6a" alt="User Detail Screen" width="25%"/>
</div>

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Acknowledgments
- [JSONPlaceholder](https://jsonplaceholder.typicode.com) for providing the mock API.
- The contributors who made this project possible.

---

## Contact
For questions or collaboration, please reach out at [fatihemresarman@gmail.com](mailto:fatihemresarman@gmail.com).
