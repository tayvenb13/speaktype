import Foundation

/// Lightweight helpers for displaying the running app version.
enum AppVersion {
    /// Get current app version from bundle
    static var currentVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    /// Get current build number from bundle
    static var currentBuildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
}
