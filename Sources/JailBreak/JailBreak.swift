// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

fileprivate var filesPathToCheck: [String] {
    
    return ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/private/var/lib/apt",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/private/var/stash",
            "/private/var/tmp/cydia.log",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/usr/bin/sshd",
            "/usr/libexec/sftp-server",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/bin/bash",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/Applications/Cydia.app",
            "/Applications/blackra1n.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/Applications/SBSettings.app",
            "/Applications/WinterBoard.app"]
}

@MainActor
public class JailBreakDetector {
    
    //MARK: - Variable -
    public static var shared = JailBreakDetector()
    
    public var isJailbrokenDevice: Bool {
        
        if isCydiaAppInstalled() ||
            checkForDeviceJailbroken() ||
            isJailBrokenFilesPresentInTheDirectory() ||
            canEditSandboxFilesForJailBreakDetecttion() ||
            systemForkCall() {
            UserDefaults.standard.setValue("yzc", forKey: "testKTU")
            UserDefaults.standard.synchronize()
            return true
        } else {
            return false
        }
    }
    
    public var canAddFileOnJailBreakDevice: Bool {
        if let value = UserDefaults.standard.value(forKey: "testKTU") as? String, !value.isEmpty {
            return true
        } else {
            return false
        }
    }
}

//MARK: - Detect JailBreak -
private extension JailBreakDetector {
    
    @MainActor private func isCydiaAppInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    private func checkForDeviceJailbroken() -> Bool {
        let string = "Test file"
        do {
            try string.write(toFile: "/private/jailbreak.txt", atomically: true, encoding: .utf8)
            return true
        } catch {
            do {
                try FileManager.default.removeItem(atPath: "/private/jailbreak.txt")
            } catch {
                
            }
            return false
        }
    }
    
    private func canEditSandboxFilesForJailBreakDetecttion() -> Bool {
        let jailBreakTestText = "Test for JailBreak"
        do {
            try jailBreakTestText.write(toFile:"/private/jailBreakTestText.txt", atomically:true, encoding:String.Encoding.utf8)
            return true
        } catch {
            return false
        }
    }
    
    private func systemForkCall() -> Bool{
        
        let pid = getpgrp()
        
        if pid < 0 {
            return true
        } else {
            return false
        }
    }
    
    private func isJailBrokenFilesPresentInTheDirectory() -> Bool{
        var checkFileIfExist: Bool = false
        filesPathToCheck.forEach {
            checkFileIfExist =  FileManager.default.fileExists(atPath: $0) ? true : false
            if checkFileIfExist{
                return
            }
        }
        return checkFileIfExist
    }
}
