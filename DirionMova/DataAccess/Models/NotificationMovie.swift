//
//  NotificationMovie.swift
//  DirionMova
//
//  Created by Юрий Альт on 21.12.2022.
//

import RealmSwift
import Foundation

class NotificationMovie: Object {
    @Persisted dynamic var id = 0
    @Persisted dynamic var posterPath = ""
    @Persisted dynamic var originalTitle = ""
    @Persisted dynamic var releaseDate = ""
}
