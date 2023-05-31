//
//  RatingBottomSheetViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 07.11.2022.
//

import Foundation

class RatingBottomSheetViewModel: ObservableObject {
    //MARK: - Binding Properties
    @Published var rateValue = 0
    @Published var tempRateValue = 0
    
    //MARK: - Private Properties
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    private let moviesRateService = MovieRateServic()
    
    //MARK: - Public Methods
    func getAccountStates(movieId: Int) {
        guard let sessionId = storage.sessionID else { return }
        moviesRateService.getAccountStates(movieId: movieId, sessionId: sessionId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let responseData = try JSONDecoder().decode(GetAccountStatesRatedResponse.self, from: response.data)
                    self.rateValue = responseData.rated.value
                    self.tempRateValue = responseData.rated.value
                    debugPrint("+++++ getAccountStates succeed")
                    print(responseData)
                } catch {
                    do {
                        let responseData = try JSONDecoder().decode(GetAccountStatesResponse.self, from: response.data)
                        debugPrint("+++++ getAccountStates succeed")
                        print(responseData)
                    } catch(let error) {
                        print("Error decoding response data from GetAccountStates Response - \(error)")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func rateMovie(movieId: Int, rateValue: Double) {
        guard let sessionId = storage.sessionID else { return }
        let request = RateMovieRequest(value: rateValue)
        if let requestData = try? JSONEncoder().encode(request) {
            moviesRateService.rateMovie(movieId: movieId, sessionId: sessionId, request: requestData) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    debugPrint("+++++ rateMovie \(Int(rateValue)) for \(movieId) succeed with message: \(data.statusMessage) and code \(data.statusCode)")
                    self.tempRateValue = Int(rateValue)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func deleteRating(movieId: Int) {
        guard let sessionId = storage.sessionID else { return }
        moviesRateService.deleteRating(movieId: movieId, sessionId: sessionId) { result in
            switch result {
            case .success(let data):
                debugPrint("+++++ deleteRating for \(movieId) succeed with message: \(data.statusMessage) and code \(data.statusCode)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImageNameForRatingStar(star number: Int, voteAverage: Double) -> String {
        var imageName = ""
        let filledStars = Int(voteAverage)
        
        if number <= filledStars && voteAverage > 0 {
            imageName = "filledBoldStarRed"
        } else if number == filledStars + 1 && voteAverage > 0 {
            if let starImageNumber = voteAverage.roundedStringValue.last {
                if let number = starImageNumber.wholeNumberValue {
                    if number == 0 {
                        imageName = "filledBoldStarRed"
                    } else {
                        imageName = "starRate\(starImageNumber)"
                    }
                }
            }
        } else {
            imageName = "boldStarWhite"
        }
        return imageName
    }
}
