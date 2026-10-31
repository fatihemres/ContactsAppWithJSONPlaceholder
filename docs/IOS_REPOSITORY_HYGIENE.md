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
2. Inspect available Xcode schemes with `xcodebuild -list -workspace ContactsAppWithJSONPlaceholder.xcworkspace`. The independent [detail-fix PR #3](https://github.com/fatihemres/ContactsAppWithJSONPlaceholder/pull/3) introduces a committed `xcshareddata/xcschemes/ContactsAppWithJSONPlaceholder.xcscheme` and a hosted macOS unit-test workflow. Verify that #3 has been merged before relying on those files in `main`.
3. With compatible Xcode and CocoaPods installed, inspect the workspace and verify that the app, unit-test target and dependencies resolve. The shared scheme in PR #3 runs the unit-test target; it deliberately does not execute the UI-test target. Do not remove personal scheme-management files during this hygiene change.
4. Validate the current app deployment target (18.2) against the available simulator and the `Podfile` settings. Do not change either target merely to quiet a version mismatch.
5. Use the cloud macOS CI run from PR #3 as **build + unit-test evidence only**. Its initial [Xcode 16.4 / iOS 18.5 run](https://github.com/fatihemres/ContactsAppWithJSONPlaceholder/actions/runs/41180972580) succeeded for the exact candidate SHA recorded there. PR #3 removes the random detail failure. **UI tests still depend on live JSONPlaceholder data and are not run by the current workflow**; further simulator UI validation and physical-device assessment remain separate.
6. Only after the relevant verification and owner approval: back up local breakpoints/IDE state, review which *already tracked* user-specific paths can be untracked, and verify a fresh clone still opens, builds and tests. Be aware that a Git commit deleting tracked user files may remove them from other working trees when merged.
7. If changing vendoring policy later, test a clean clone with `pod install` (not `pod update`), compare `Podfile.lock`, ensure offline expectations are acceptable, and document the new setup before untracking `Pods/`.

## Scope of this PR

Only `.gitignore` and this maintenance note are introduced. There are **no application-code, Xcode project, Podfile, lockfile, dependency, test, UI, scheme or previously tracked file changes**. The `.gitignore` prevents *new* ignored files from being added accidentally; it cannot retroactively hide the eight already tracked paths.

References:
- [Official CocoaPods guidance on committing the Pods directory](https://guides.cocoapods.org/using/using-cocoapods.html)
- [Official GitHub Swift .gitignore template](https://github.com/github/gitignore/blob/main/Swift.gitignore)
