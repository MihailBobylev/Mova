//
//  FAQViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.12.2022.
//

import Foundation
import UIKit

class FAQViewModel: ObservableObject {
    @Published var isFirstResponder = false
    @Published var componentsIndex = 0
    @Published var searchTitle = "" {
        didSet {
            if let _searchTitle = searchTitleIsValid(title: searchTitle) {
                searchTitle = _searchTitle
            }
        }
    }
    
    @Published var filteredFAQ = [FAQProblemModel]()
    @Published var filteredCategories = [FAQProblemModel]()
    @Published var openedProblemID = UUID()
    @Published var openedProblemTitle = ""
    @Published var openProblemToggle = false
    
    var searchTask: DispatchWorkItem?
    
    let categoriesFAQ: [ProblemType] = [.general, .account, .service, .video]
    let problemsFAQ = [
        FAQProblemModel(title: "What is MOVA?", description: "With MOVA apps, you can watch series and movies on Android and iOS. largest database of series and movies, whose users are always up to date with key industry events. The service application allows you to watch trailers. Users can view lists of actors involved in each project and brief descriptions of plots. With the help of the service, movies and series can be downloaded to your device or watched online. The user almost always has a choice of video quality and subtitles. Many films contain multiple audio tracks in different languages.", type: .general),
        FAQProblemModel(title: "Can I change/set/reset my password or email?", description: "Yes, you can. Click on your name in the top line, and select \"Personal Data\" in the menu that opens. All this can be configured there", type: .account),
        FAQProblemModel(title: "What can you watch for free?", description: "Part is available without subscription, series, movies and shows. If a subscription film appears, you will see an inscription by subscription", type: .general),
        FAQProblemModel(title: "I forgot my password. What should I do?", description: "If you entered an email – use the \"Remind password\" function in the login form", type: .account),
        FAQProblemModel(title: "How do I find a movie?", description: "Use the search tap on Explore– at the bottom.The search section opens, you need to click on the magnifying glass in the top row. If you know about the year of the film", type: .video),
        FAQProblemModel(title: "How can I download movies on my phone?", description: """
                                1. Make sure your device is connected to the internet;
                                2. Find the movie or TV episode you want to download;
                                3. Open movie details;
                                4. Tap on bottom Download;
                                5. Wait for the movie to download.
                                """, type: .video),
        FAQProblemModel(title: "How to add on My list movies?", description: "MOVA service users have the ability to add movies and series to My list to watch them later by clicking on the heart in the movie details", type: .video),
        FAQProblemModel(title: "Why do you need a subscription?", description: "New series and movies are released every week, some of which are available only on the MOVA service. If you subscribe, then do not miss the new episodes of your favorite series. The subscription is issued for 30 days or a year and is renewed automatically", type: .general),
        FAQProblemModel(title: "What is included in the subscription?", description: "The subscription includes all movies, series, shows and TV channels available on the MOVA service", type: .general),
        FAQProblemModel(title: "How to activate a subscription?", description: """
                                Open Profile tap to subscribe.
                                1. Select a subscription;
                                2. Select a payment method or add a card;
                                3. In the form that opens, enter the card number, expiration date and CVC/CVV code;
                                4. Confirm payment by card by entering the code from SMS into the form;
                                5. Done. You can watch your favorite movies and series!
                                """, type: .general),
        FAQProblemModel(title: "Problem launching app or video", description: "Check your TV's internet connection. Update your TV firmware to the latest version. Delete the app from your device memory and download it again from the app store. Log in again to the account on the device where you enter the code that is displayed on the TV. Re-enter your username (phone number) and password. Unplug the TV from power for a few minutes, then reinstall the app. Problem launching app or video", type: .video),
        FAQProblemModel(title: "When will my card be charged for the subscription?", description: "The subscription renews automatically for the next calendar month after the subscription you purchased expires. Money will be debited 1 day before the end of the subscription. See the profile for the date until which the current subscription is valid", type: .account),
        FAQProblemModel(title: "What cards can be used to pay for a subscription?", description: "The subscription can be paid on the territory of the Russian Federation using Russian banking MIR, Visa, Mastercard, Maestro. Transactions are encrypted and completely secure.", type: .account),
        FAQProblemModel(title: "Why you need to sign in?", description: "Only registered and authorized users can subscribe and watch shows, series, movies", type: .account),
        FAQProblemModel(title: "How to cancel a subscription?", description: "Go to my profile. Tap subscribe, tap unsubscribe", type: .general)
    ]
    
    func searchTitleIsValid(title: String) -> String? {
        var _title = String(title.prefix(64))
        let lenght = title.count
        
        _title = _title.replacingOccurrences(
            of: "^ ",
            with: "",
            options: .regularExpression
        )
        _title = _title.replacingOccurrences(
            of: " {2,}",
            with: " ",
            options: .regularExpression
        )
        
        if lenght == _title.count {
            return nil
        } else {
            return _title
        }
    }
    
    func getFilteredFAQ() -> [FAQProblemModel] {
        searchTask?.cancel()
        if !filteredCategories.elementsEqual(problemsFAQ) {
            filteredCategories = problemsFAQ
        }
        
        return problemsFAQ.filter(
            {
                searchTitle.isEmpty ? false : $0.title.lowercased().contains(searchTitle.lowercased())
            }
        )
    }
    
    func filterByCategory(categories: [ProblemType]) -> [FAQProblemModel] {
        if isFirstResponder {
            clearSearchState()
        }
        
        if categories == [.all] {
            return problemsFAQ
        }
        
        return problemsFAQ.filter({
            categories.contains($0.type)
        })
    }
    
    func makeSearchWithDelay() {
        searchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.filteredFAQ = self.getFilteredFAQ()
        }
        searchTask = task
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: task)
    }
    
    func clearSearchState() {
        UIApplication.shared.dismissKeyboard()
        filteredFAQ.removeAll()
    }
}
