import Foundation
#if os(iOS)
import UIKit
#endif

/// Jailbreak されているかどうかのチェックに、Jailbreak されているときに見つかる URL スキーマが検知できるか、Jailbreak されているときに見つかるファイルが検知できるか、Jailbreak されている時にできてしまうサンドボックス外への書き込みができるかのチェックを使うことができます。
public enum JailbreakDetectType {
    case url
    case file
    case sandbox
}

/// Jailbreak されているかどうかを確認できます
public struct JailbreakDetector {
    public private(set) var text = "Hello, World!"
    public private(set) var isJB = false

    /// Jailbreak されているかどうかが確認できた場合、この値が true になります。
    /// - Returns: Jailbreak されている場合
    public func isJailbreaked() -> Bool {
        isJB
    }

    public init(types: [JailbreakDetectType]) {
        let urlCheck = types.contains(.url) ? detectCydiaURLScheme() : false
        let fileCheck = types.contains(.file) ? detectJBFiles() : false
        let sandboxCheck = types.contains(.sandbox) ? detectOutsideSandbox() : false
        isJB = urlCheck || fileCheck || sandboxCheck
    }

    private func detectCydiaURLScheme() -> Bool {
        #if os(iOS)
        guard let url = URL(string: "cydia://") else { return false }
        return UIApplication.shared.canOpenURL(url)
        #else
        return false
        #endif
    }

    private func detectJBFiles() -> Bool {
        #if targetEnvironment(simulator)
        let targetFiles = [
            "/private/var/lib/apt",
            "/Applications/Cydia.app",
            "/Applications/RockApp.app",
            "/Applications/Icy.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
        #else
        let targetFiles = [
            "/private/var/lib/apt",
            "/Applications/Cydia.app",
            "/Applications/RockApp.app",
            "/Applications/Icy.app",
            "/bin/sh",
            "/usr/libexec/sftp-server",
            "/usr/libexec/ssh-keysign",
            "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
        #endif
        if let existFile = targetFiles.first(where: { path in
                FileManager.default.fileExists(atPath: path)
        }) {
            print("Jailbreak detected: target file: \(existFile)")
            return true
        }
        return false
    }

    private func detectOutsideSandbox() -> Bool {
        do {
            try "failbreak".write(toFile: "/private/jailbreak.txt",
                                  atomically: true,
                                  encoding: .utf8)
        } catch {
            return false
        }
        return true
    }
}
