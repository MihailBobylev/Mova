//
//  CreateListRequest.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/2/22.
//

struct CreateListRequest: Codable {
    let name: String
    let description: String
    let language: String
    
    static func buildDefaultRequest() -> CreateListRequest {
        return CreateListRequest(name: "MyList", description: "MyList description", language: "en_US")
    }
}
