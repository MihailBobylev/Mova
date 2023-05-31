//
//  String+Extension.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/21/22.
//
extension String {
    enum ImageType {
        case poster(width: PosterWidth)
        case backdrop(width: BackdropWidth)
        case still(width: StillWidth)
        case profile(width: ProfileWidth)
        case logo(width: LogoWidth)
        
        enum PosterWidth: String {
            case w92 = "w92"
            case w154 = "w154"
            case w185 = "w185"
            case w342 = "w342"
            case w500 = "w500"
            case w780 = "w780"
            case original = "original"
        }
        
        enum BackdropWidth: String {
            case w300 = "w300"
            case w780 = "w780"
            case w1280 = "w1280"
            case original = "original"
        }
        
        enum StillWidth: String {
            case w92 = "w92"
            case w185 = "w185"
            case w300 = "w300"
            case original = "original"
        }
        
        enum ProfileWidth: String {
            case w45 = "w45"
            case w185 = "w185"
            case h632 = "w632"
            case original = "original"
        }
        
        enum LogoWidth: String {
            case w45 = "w45"
            case w92 = "w92"
            case w154 = "w154"
            case w185 = "w185"
            case w300 = "w300"
            case w500 = "w500"
            case original = "original"
        }
    }
    
    func getPosterImageURL(imageType: ImageType) -> String {
        switch imageType {
        case .poster(let width):
            return "\(ServerConstants.imagesBaseURL)/\(width.rawValue)\(self)"
        case .backdrop(let width):
            return "\(ServerConstants.imagesBaseURL)/\(width.rawValue)\(self)"
        case .still(let width):
            return "\(ServerConstants.imagesBaseURL)/\(width.rawValue)\(self)"
        case .profile(let width):
            return "\(ServerConstants.imagesBaseURL)/\(width.rawValue)\(self)"
        case .logo(let width):
            return "\(ServerConstants.imagesBaseURL)/\(width.rawValue)\(self)"
        }
    }
}
