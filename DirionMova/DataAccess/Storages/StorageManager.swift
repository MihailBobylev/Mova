//
//  RealmStorageManager.swift
//  DirionMova
//
//  Created by Юрий Альт on 21.12.2022.
//

import RealmSwift

//MARK: - StorageManager Protocol
protocol StorageManagerProtocol {
    func saveMovie(movie: NotificationMovie)
    func getMovie(movieId: Int) -> NotificationMovie?
    func checkMovie(id: Int) -> Bool
}

class StorageManager: StorageManagerProtocol {
    //MARK: - Private Properties
    private var realm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch {
                print("Could not access database: ", error)
            }
            return self.realm
        }
    }
    
    //MARK: - Public Methods
    func saveMovie(movie: NotificationMovie) {
        write {
            realm.add(movie)
        }
    }
    
    func getMovie(movieId: Int) -> NotificationMovie? {
        realm.objects(NotificationMovie.self).where { $0.id == movieId }.first
    }
    
    func checkMovie(id: Int) -> Bool {
        var isContains = false
        let objects = realm.objects(NotificationMovie.self)
        for object in objects {
            if object.id == id {
                isContains = true
            }
        }
        return isContains
    }
    
    //MARK: - Private Methods
    private func write(_ completion: () -> Void) {
        do {
            try realm.write { completion() }
        } catch let error {
            print(error)
        }
    }
}
