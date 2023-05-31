//
//  ServerErrors.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/3/22.
//

enum ServerErrors: Int, Codable {
    case success = 1
    case updateSuccess = 12
    case deleteSuccess = 13
    case invalidService = 2
    case permissionDenied = 3
    case invalidFormat = 4
    case invalidParameter = 5
    case invalidIdOrNotExist = 6
    case invalidApiKey = 7
    case duplicateEntered = 8
    case serviceOffline = 9
    case suspendedApi = 10
    case internalError = 11
    case authFailed = 14
    case failed = 15
    case deviceDenied = 16
    case sessionDenied = 17
    case validationFailed = 18
    case invalidHeader = 19
    case invalidDateRange = 20
    case entryNotFound = 21
    case invalidPage = 22
    case invalidDate = 23
    case serverTimeOut = 24
    case requestOverLimit = 25
    case usernameAndPasswordFailure = 26
    case maxNumberOfRemoteCalls = 27
    case invalidTimeZone = 28
    case confirmationFailed = 29
    case loginFailure = 30
    case accountDisabled = 31
    case emailVerificationFailure = 32
    case tokenExpiredOrInvalid = 33
    case resourceNotExist = 34
    case invalidToken = 35
    case tokenNotGranted = 36
    case sessionNotFound = 37
    case notHavePermissionToEdit = 38
    case privateResource = 39
    case updateEmpty = 40
    case notApprovedToken = 41
    case notSupportedMethod = 42
    case connectionFailure = 43
    case invalidId = 44
    case suspendedUser = 45
    case apiMaintenanceError = 46
    case notValidInput = 47
}
