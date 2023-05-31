//
//  GetAccountStatesResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 08.11.2022.
//

struct GetAccountStatesResponse: Decodable {
    let id: Int
    let favorite: Bool
    let rated: Bool
    let watchlist: Bool
}

struct GetAccountStatesRatedResponse: Decodable {
    let id: Int
    let favorite: Bool
    let rated: Rate
    let watchlist: Bool
}

struct Rate: Decodable {
    let value: Int
}
