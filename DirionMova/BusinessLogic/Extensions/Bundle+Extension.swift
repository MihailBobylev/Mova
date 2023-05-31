//
//  Bundle+Extension.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.10.2022.
//

import Foundation

extension Bundle {
    var serverBaseURL: String {
        return object(forInfoDictionaryKey: "serverBaseURL") as? String ?? ""
    }
    
    var serverWithImagesBaseURL: String {
        return object(forInfoDictionaryKey: "serverWithImagesBaseURL") as? String ?? ""
    }
    
    var serverWithDescriptionBaseURL: String {
        return object(forInfoDictionaryKey: "serverWithDescriptionBaseURL") as? String ?? ""
    }
    
    var apiKey: String {
        object(forInfoDictionaryKey: "apiKey") as? String ?? ""
    }
}
