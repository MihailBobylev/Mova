//
//  PinStorage.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/14/22.
//

import Foundation
import KeychainSwift

protocol CredentialsStorage {
    var isFirstLaunch: Bool { get set }
    var username: String? { get }
    var password: String? { get }
    var pinCode: String? { get set }
    var listId: String? { get set }
    var pinExists: Bool { get }
    var sessionID: String? { get set }
    var accountID: String? { get set }
    var isBiometryOn: Bool? { get set }
    var isSubscribed: Bool? { get set }
    var addNewCard: Mocard? { get set }
    var guestSessionLastUpdate: Date? { get set }
    var isGuest: Bool { get }
    var fullName: String? { get set }
    var email: String? { get set }
    var userImage: UIImage? { get set }
    func store(username: String, password: String)
    func isLoggedIn() -> Bool
    func clearStorage()
    func deleteMocard()
}

final class CredentialStorageImplementation: CredentialsStorage {
    //MARK: - Private Storage Services
    private let storage: UserDefaults
    private let keychain = KeychainSwift()
    
    init(storage: UserDefaults = .standard) {
        self.storage = storage
    }
    
    fileprivate enum Key: String, CaseIterable {
        case sessionID = "KEY.USER.SESSION.ID"
        case guestSessionLastUpdate = "KEY.GUEST.LASTUPDATE"
        case accountID = "KEY.USER.ACCOUNT.ID"
        case pincode = "KEY.USER.PIN"
        case listId = "KEY.USER.LIST.ID"
        case username = "KEY.USER.USERNAME"
        case password = "KEY.USER.PASSWORD"
        case biometry = "KEY.USER.BIOMETRY"
        case isSubscribed = "KEY.USER.SUBSCRIBED"
        case addNewCard = "KEY.USER.CARD"
        case fullname = "KEY.USER.FULLNAME"
        case email = "KEY.USER.EMAIL"
        case userImage = "KEY.USER.USERIMAGE"
    }
    
    //MARK: - Storage Public Properties
    var pinExists: Bool {
        pinCode != nil
    }
    
    var pinCode: String? {
        get {
            guard let code = storage.value(forKey: Key.pincode.rawValue) as? String else {
                return nil
            }
            return code
        } set {
            storage.setValue(newValue, forKey: Key.pincode.rawValue)
        }
    }
    
    var isFirstLaunch: Bool {
        get {
            guard let launch = storage.value(forKey: "KEY.ISFIRSTLAUNCH") as? Bool else {
                return true
            }
            return launch
        } set {
            storage.setValue(newValue, forKey: "KEY.ISFIRSTLAUNCH")
        }
    }
    
    var username: String? {
        guard let email = keychain.get(Key.username.rawValue) else { return nil }
        return email
    }
    
    var password: String? {
        guard let email = keychain.get(Key.password.rawValue) else { return nil }
        return email
    }
    
    var listId: String? {
        get {
            guard let id = storage.value(forKey: Key.listId.rawValue) as? String else { return nil }
            return id
        } set {
            storage.setValue(newValue, forKey: Key.listId.rawValue)
        }
    }
    
    var sessionID: String? {
        get {
            guard let id = storage.value(forKey: Key.sessionID.rawValue) as? String else { return nil }
            return id
        } set {
            storage.setValue(newValue, forKey: Key.sessionID.rawValue)
        }
    }
    
    var accountID: String? {
        get {
            guard let id = storage.value(forKey: Key.accountID.rawValue) as? String else { return nil }
            return id
        } set {
            storage.setValue(newValue, forKey: Key.accountID.rawValue)
        }
    }
    
    var isBiometryOn: Bool? {
        get  {
            guard let state = storage.value(forKey: Key.biometry.rawValue) as? Bool else {
                return nil
            }
            return state
        } set {
            storage.setValue(newValue, forKey: Key.biometry.rawValue)
        }
    }
    
    var isSubscribed: Bool? {
        get  {
            guard let state = storage.value(forKey: Key.isSubscribed.rawValue) as? Bool else {
                return nil
            }
            return state
        } set {
            storage.setValue(newValue, forKey: Key.isSubscribed.rawValue)
        }
    }
    
    var addNewCard: Mocard? {
        get {
            guard let savedData = storage.object(forKey: Key.addNewCard.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Mocard else { return nil }
            return decodedModel
        }
        
        set {
            if let mocard = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: mocard, requiringSecureCoding: false) {
                    storage.set(savedData, forKey: Key.addNewCard.rawValue)
                }
            }
        }
    }
    
    var isGuest: Bool {
        guestSessionLastUpdate != nil
    }
    
    var guestSessionLastUpdate: Date? {
        get {
            guard let session = storage.value(forKey: Key.guestSessionLastUpdate.rawValue) as? Date else {
                return nil
            }
            return session
        } set {
            storage.setValue(newValue, forKey: Key.guestSessionLastUpdate.rawValue)
        }
    }
    
    var fullName: String? {
        get {
            guard let session = storage.value(forKey: Key.fullname.rawValue) as? String else {
                return nil
            }
            return session
        } set {
            DispatchQueue.main.async {
                self.storage.setValue(newValue, forKey: Key.fullname.rawValue)
            }
            
        }
    }
    
    var email: String? {
        get {
            guard let session = storage.value(forKey: Key.email.rawValue) as? String else {
                return nil
            }
            return session
        } set {
            DispatchQueue.main.async {
                self.storage.setValue(newValue, forKey: Key.email.rawValue)
            }
        }
    }
    
    var userImage: UIImage? {
        get {
            guard let data = storage.data(forKey: Key.userImage.rawValue) else { return UIImage(named: "person")}
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            return image
        } set {
            DispatchQueue.main.async {
                guard let data = newValue?.jpegData(compressionQuality: 0.5) else { return }
                let encoded = try! PropertyListEncoder().encode(data)
                self.storage.set(encoded, forKey: Key.userImage.rawValue)
            }
        }
    }
    //MARK: - Public Methods
    func store(username: String, password: String) {
        keychain.set(username, forKey: Key.username.rawValue)
        keychain.set(password, forKey: Key.password.rawValue)
    }
    
    func isLoggedIn() -> Bool {
        guard let _ = username else { return false }
        guard let _ = password else { return false }
        return true
    }
    
    func clearStorage() {
        keychain.clear()
        Key.allCases.forEach { key in
            storage.removeObject(forKey: key.rawValue)
            storage.synchronize()
        }
    }
    
    func deleteMocard() {
        storage.removeObject(forKey: Key.addNewCard.rawValue)
    }
}
