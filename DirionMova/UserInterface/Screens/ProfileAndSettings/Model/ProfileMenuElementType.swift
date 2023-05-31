//
//  ProfileMenuElementType.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/28/22.
//

enum ProfileMenuElementType: CaseIterable {
    case editProfile, subscription, notification
    case download, security, language, darkMode
    case helpCenter, privacyPolicy, logOut
    case wifiOnly, smartDownloads, videoQuality
    case audioQuality, deleteAllDownloads, deleteCache
    case generlNotification, newArrival, newServicesAvailable
    case newReleasesMovie, appUpdates, subscriptionNotification
    case securityAlerts, manageDevices, managePermission
    case rememberMe, faceID, biometricID, googleAuthenticator
    
    var imageName: String {
        switch self {
        case .editProfile:
            return "profileClearColor"
        case .subscription:
            return "settingsClear"
        case .notification:
            return "notificationClear"
        case .download:
            return "downloadClear"
        case .security:
            return "securityClear"
        case .language:
            return "moreClear"
        case .darkMode:
            return "showClear"
        case .helpCenter:
            return "infoClear"
        case .privacyPolicy:
            return "dangerClear"
        case .logOut:
            return "logOutClear"
        case .wifiOnly:
            return "wifiClear"
        case .smartDownloads:
            return "downloadClear"
        case .videoQuality:
            return "cameraClear"
        case .audioQuality:
            return "microphoneClear"
        case .deleteAllDownloads:
            return "trashClear"
        case .deleteCache:
            return "trashClear"
        default:
            return ""
        }
    }
    
    var title: String {
        switch self {
        case .editProfile:
            return "Edit Profile"
        case .subscription:
            return "Subscription"
        case .notification:
            return "Notification"
        case .download:
            return "Download"
        case .security:
            return "Security"
        case .language:
        return "Language"
        case .darkMode:
            return "Dark Mode"
        case .helpCenter:
            return "Help Center"
        case .privacyPolicy:
            return "Privacy Policy"
        case .logOut:
            return "Log out"
        case .wifiOnly:
            return "Wi-Fi Only"
        case .smartDownloads:
            return "Smart Downloads"
        case .videoQuality:
            return "Video Quality"
        case .audioQuality:
            return "Audio Quality"
        case .deleteAllDownloads:
            return "Delete All Downloads"
        case .deleteCache:
            return "Delete Cache"
        case .generlNotification:
            return "General Notification"
        case .newArrival:
            return "New Arrival"
        case .newServicesAvailable:
            return "New Services Available"
        case .newReleasesMovie:
            return "New Releases Movie"
        case .appUpdates:
            return "App Updates"
        case .subscriptionNotification:
            return "Subscription"
        case .securityAlerts:
            return "Security Alerts"
        case .manageDevices:
            return "Manage Devices"
        case .managePermission:
            return "Manage Permission"
        case .rememberMe:
            return "Remember me"
        case .faceID:
            return "Face ID"
        case .biometricID:
            return "Biometric ID"
        case .googleAuthenticator:
            return "Google Authenticator"
        }
    }
}
