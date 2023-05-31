//
//  MovaError.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/3/22.
//

struct MovaError: Error, Decodable {
    let success: Bool
    let statusCode: ServerErrors
    let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
    init(success: Bool = false, statusCode: Int, statusMessage: String?) {
        self.success = success
        self.statusCode = ServerErrors(rawValue: statusCode) ?? .failed
        self.statusMessage = statusMessage
    }
    
    static func requestParsingFailure() -> MovaError {
        debugPrint("+++ Request parsing Failure")
        return MovaError(statusCode: ServerErrors.invalidParameter.rawValue, statusMessage: "Something went wrong!")
    }
}
