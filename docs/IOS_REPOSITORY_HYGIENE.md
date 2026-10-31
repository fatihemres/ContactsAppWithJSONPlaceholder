# iOS repository hygiene and validation

> Maintenance checkpoint: 2026-10-31. This note describes the existing repository and review requirements. It does not certify a build, a test run, or support for older iOS versions.

## Current source-control decisions

- **Keep CocoaPods checked in for now.** The current default branch tracks `Podfile`, `Podfile.lock`, the Xcode workspace, and **116 files under `Pods/`**. Retaining vendored dependencies permits the repository to be opened without first downloading them and avoids a disruptive change to the portfolio checkout. CocoaPods documents this as a supported strategy; reevaluate it only with a validated migration plan.
- **Ignore future Xcode user state.** The new root `.gitignore` ignores `xcuserdata/`, `*.xcuserstate`, local build output and `DerivedData/`, but **does not remove files that Git already tracks**. Currently eight tracked paths contain `xcuserdata/`; the workspace contains a personal `Breakpoints_v2.xcbkptlist` file. The current PR intentionally does not delete or untrack any of them.
- **Preserve the actual workspace and project.** The `.xcworkspace`, `.xcodeproj`, `Podfile`, and `Podfile.lock` stay versioned. Do not replace the workspace with the project file when using CocoaPods.
- **Do not force-align deployment targets.** The Xcode project has `IPHONEOS_DEPLOYMENT_TARGET = 18.2` in its current build configurations, while `Podfile` declares `platform :ios, '14.0'`. The former controls the app's target; the latter is the CocoaPods platform/dependency setting. A difference alone does not prove failure or authorize broadening device support. Confirm installed SDK, dependency build and runtime behavior before any change.
- **No automatic dependency upgrades.** `Podfile.lock` currently pins CombineCocoa 0.4.1, SnapKit 5.7.1, Then 3.0.0; changing versions requires separate testing and an intentional lockfile change.

## macOS verification checklist (before any further cleanup)

1. Use a clean/disposable clone or worktree; preserve the original developer checkout and personal breakpoints. Verify Git status and confirm the repository's main/development branch SHA.
2. Inspect available Xcode schemes with `xcodebuild -list -workspace ContactsAppWithJSONPlaceholder.xcworkspace`. The current tree has **no `xcshareddata/xcschemes/` files**, so do not assume headless CI can find a shared application/test scheme.
3. With compatible Xcode and CocoaPods installed, inspect the workspace in Xcode and check that the app, test target, and CocoaPods dependencies resolve. If the scheme is local-only, explicitly share it on a reviewed branch before attempting CI. Do not delete existing scheme-management files before verifying the replacement.
4. Validate the current app deployment target (18.2) against the available simulator and the `Podfile` settings. Do not change either target merely to quiet a version mismatch.
5. Run the existing XCTest unit and UI targets on an available iOS simulator. **The UI tests depend on live JSONPlaceholder data**, and the current default branch also simulates a random detail-screen failure. Treat a failure as a finding; do not claim stable passing tests without observed evidence.
6. Only after tests pass and the owner approves: back up local breakpoints/IDE state, review which *already tracked* user-specific paths can be untracked, and verify a fresh clone still opens, builds and tests. Be aware that a Git commit deleting tracked user files may remove them from other working trees when merged.
7. If changing vendoring policy later, test a clean clone with `pod install` (not `pod update`), compare `Podfile.lock`, ensure offline expectations are acceptable, and document the new setup before untracking `Pods/`.

## Scope of this PR

Only `.gitignore` and this maintenance note are introduced. There are **no application-code, Xcode project, Podfile, lockfile, dependency, test, UI, scheme or previously tracked file changes**. The `.gitignore` prevents *new* ignored files from being added accidentally; it cannot retroactively hide the eight already tracked paths.

References:
- [Official CocoaPods guidance on committing the Pods directory](https://guides.cocoapods.org/using/using-cocoapods.html)
- [Official GitHub Swift .gitignore template](https://github.com/github/gitignore/blob/main/Swift.gitignore)
