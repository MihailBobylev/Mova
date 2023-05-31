//
//  UIColor+Extension.swift
//  DirionMova
//
//  Created by Юрий Альт on 03.10.2022.
//

import SwiftUI

extension Color {
    //Screens
    enum Biometric {
        static let background = UIColor.MOVA.WhiteDark1
    }
    
    enum Pin {
        static let background = UIColor.MOVA.WhiteDark1
        static let pinBoxBackgroundColor = Color(.MOVA.Greyscale50Dark2)
        static let pinBoxCornerColor = Color(.MOVA.Greyscale200Dark3)
        static let boxCornerErrorColor = Color(.MOVA.primary500)
        static let boxErrorColor = Color(.MOVA.transparentRed)
        static let pinDescriptionColor = Color(.MOVA.Greyscale900White)
        static let errorMessageColor = Color(.MOVA.primary500)
        static let pinKeyboardBack = UIColor.MOVA.Greyscale50Dark2
        static let pinKeyboardText = Color(.MOVA.Greyscale900White)
    }
    
    enum SplashScreen {
        static let background = UIColor.MOVA.WhiteDark1
        static let gradientMaxColor = Color(.MOVA.splashGradientMaxColor)
    }
    
    enum StartScreen {
        static let background = UIColor.MOVA.WhiteDark1
        static let devider = Color(.MOVA.Greyscale200Dark3)
        static let orText = Color(.MOVA.Greyscale700White)
        static let doNotHaveAccountText = Color(.MOVA.Greyscale500White)
    }
    
    enum CreateAccount {
        static let background = UIColor.MOVA.WhiteDark1
        static let devider = Color(.MOVA.Greyscale200Dark3)
    }
    
    enum Login {
        static let background = UIColor.MOVA.WhiteDark1
        static let devider = Color(.MOVA.Greyscale200Dark3)
        static let continueWithText = Color(.MOVA.Greyscale700White)
        static let doNotHaveAccountText = Color(.MOVA.Greyscale500White)
        static let errorText = Color(.MOVA.primary500)
        static let forgotThePasswordButtonText = Color(.MOVA.primary500)
        static let signUpButtonText = Color(.MOVA.primary500)
    }
    
    enum Profile {
        static let background = UIColor.MOVA.WhiteDark1
    }
    
    enum Notification {
        static let background = UIColor.MOVA.WhiteDark1
        static let titleText = Color(.MOVA.Greyscale900White)
        static let nameText = Color(.MOVA.Greyscale900White)
        static let dateText = Color(.MOVA.Greyscale700Greyscale300)
    }
    
    enum SelectResetContact {
        static let background = UIColor.MOVA.WhiteDark1
        static let titleText = Color(.MOVA.Greyscale900White)
        static let descriptionText = Color(.MOVA.Greyscale900White)
        static let contactDataText = Color(.MOVA.Greyscale900White)
        static let unselectedContactBorder = Color(.MOVA.Greyscale200Dark3)
        static let contactButtonBack = Color(.MOVA.WhiteDark1)
        static let selectedContactBorder = Color(.MOVA.primary500)
        static let contactCircle = Color(.MOVA.primary500.withAlphaComponent(0.08))
        static let contactTypeText = Color(.MOVA.Greyscale600Greyscale300)
    }
    
    enum EnterResetCode {
        static let background = UIColor.MOVA.WhiteDark1
        static let topInfoText = Color(.MOVA.Greyscale900White)
        static let timeCounterText = Color(.MOVA.Greyscale900White)
        static let counterSecondsText = Color(.MOVA.primary500)
        static let otpNumbersText = Color(.MOVA.Greyscale900White)
        static let otpElementBack = Color(.MOVA.Greyscale50Dark2)
        static let otpElementBackSelected = Color(.MOVA.primary500.withAlphaComponent(0.08))
        static let otpElementBorder = Color(.MOVA.Greyscale200Dark3)
        static let otpElementBorderSelected = Color(.MOVA.primary500)
    }
    
    enum EnterNewPassword {
        static let background = UIColor.MOVA.WhiteDark1
        static let topInfoText = Color(.MOVA.Greyscale900White)
    }
    
    //Views
    enum TexFields {
        static let background = Color(.MOVA.Greyscale50Dark2)
        static let text = Color(.MOVA.Greyscale900White)
        static let activeBackground = Color(.MOVA.primary500.withAlphaComponent(0.08))
        static let fieldText = Color(.MOVA.primary500)
        static let fieldCursor = Color(.MOVA.Greyscale900White)
    }
    
    enum GrayButton {
        static let background = Color(.MOVA.Primary100Dark3)
        static let text = Color(.MOVA.Primary500White)
    }
    
    enum AuthSocialNetworkButton {
        static let background = Color(.MOVA.WhiteDark2)
        static let borderColor = Color(.MOVA.Greyscale200Dark3)
        static let text = Color(.MOVA.Greyscale900White)
    }
    
    enum Logo {
        static let darkLine = Color(.MOVA.logoDarkRed)
        static let lightLine = Color(.MOVA.primary500)
    }
    
    enum LoadingIndicator {
        static let background = Color(.MOVA.primary500)
    }
    
    enum MovaButton {
        static let backgroundActive = Color(.MOVA.primary500)
        static let backgroundInactive = Color(.MOVA.primaryOp500)
        static let text = Color.white
    }
    
    enum MovaToggle {
        static let isOnBackground = Color(.MOVA.primary500)
        static let isOffBackground = Color(.MOVA.Greyscale200Dark3)
        static let handleBackground = Color(.MOVA.white)
    }
    
    enum PopupWithButtonView {
        static let background = Color(.MOVA.black.withAlphaComponent(0.7))
        static let mainViewBackground = Color(.MOVA.WhiteDark2)
        static let titleText = Color(.MOVA.primary500)
        static let subTitleText = Color(.MOVA.Greyscale900White)
    }
    
    enum TabBar {
        static let background = UIColor.MOVA.WhiteDarkHome
    }
    
    enum Home {
        static let background = UIColor.MOVA.WhiteDark1
        static let filmNameText = Color(.MOVA.white)
        static let filmTagsText = Color(.MOVA.white)
        static let buttonPrimary = Color(.MOVA.primary500)
        static let playButtonText = Color(.MOVA.white)
        static let tabBarBackground = UIColor.MOVA.WhiteDarkHome
        
        enum MovieColumnItem {
            static let categoriesText = Color(.MOVA.Greyscale900White)
            static let seeAllButtonText = Color(.MOVA.primary500)
        }
        enum MovieRowItem {
            static let ratingBackground = Color(.MOVA.primary500)
            static let ratingText = Color(.MOVA.white)
        }
    }
    
    enum ActionMenu {
        static let background = UIColor.MOVA.WhiteDark1
        static let title = Color(.MOVA.Greyscale900White)
    }
    
    enum Explore {
        static let background = UIColor.MOVA.WhiteDark1
        static let searchBarBack = UIColor.MOVA.Greyscale100Dark2
        static let detentHandle = Color(.MOVA.Greyscale300Dark3)
        static let sortTitlesText = Color(.MOVA.Greyscale800White)
        static let sortBackground = UIColor.MOVA.WhiteDark1
        static let sortBorder = UIColor.MOVA.Greyscale100Dark3
        static let sortFilterText = Color(.MOVA.error)
        static let sortDevider = Color(.MOVA.Greyscale200Dark3)
        static let notFoundBack = UIColor.MOVA.WhiteDark1
    }
    
    enum MyList {
        static let background = UIColor.MOVA.WhiteDark1
        static let titleText = Color(.MOVA.Greyscale900White)
        static let primaryText = Color(.MOVA.primary500)
        static let descriptionText = Color(.MOVA.Greyscale800White)
    }
    
    enum ProfileAndSettingsView {
        static let background = UIColor.MOVA.WhiteDark1
        static let titleText = Color(.MOVA.Greyscale900White)
        static let fullNameText = Color(.MOVA.Greyscale900White)
        static let userNameText = Color(.MOVA.Greyscale900White)
        static let joinPremiumBorder = Color(.MOVA.primary500)
        static let joinPremiumText = Color(.MOVA.primary500)
        static let descriptionPremiumText = Color(.MOVA.Greyscale700Greyscale300)
        static let menuElementText = Color(.MOVA.Greyscale900White)
        static let logOutMenuElementText = Color(.MOVA.primary500)
    }
    
    enum Downloads {
        static let titleText = Color(.MOVA.Greyscale900White)
        static let filmNameText = Color(.MOVA.Greyscale900White)
        static let durationText = Color(.MOVA.Greyscale800Greyscale300)
        static let fileSizeText = Color(.MOVA.primary500)
        static let movieSizeBackground = Color(.MOVA.transparentRed)
    }
    
    enum MovieDetails {
        static let background = UIColor.MOVA.WhiteDark1
        static let titleText = Color(.MOVA.Greyscale900White)
        static let ratingLabelText = Color(.MOVA.primary500)
        static let yearLabelText = Color(.MOVA.Greyscale800Greyscale300)
        static let parametersViewBorder = Color(.MOVA.primary500)
        static let parametersViewText = Color(.MOVA.primary500)
        static let genresText = Color(.MOVA.Greyscale900White)
        static let descriptionText = Color(.MOVA.Greyscale800Greyscale300)
        static let downloadButtonText = Color(.MOVA.primary500)
        static let downloadButtonFrame = Color(.MOVA.primary500)
        static let playButtonBack = Color(.MOVA.primary500)
        static let playButtonText = Color(.MOVA.white)
        static let castNameText = Color(.MOVA.Greyscale900White)
        static let castRoleText = Color(.MOVA.Greyscale700Greyscale300)
        static let movieVideoDetailsButtonText = UIColor.MOVA.Greyscale500Greyscale700
    }
    
    enum RatingBottomSheet {
        static let background = UIColor.MOVA.WhiteDark1
        static let detentHandle = Color(.MOVA.Greyscale300Dark3)
        static let titleText = Color(.MOVA.Greyscale900White)
        static let horizontalDevider = Color(.MOVA.Greyscale200Dark3)
        static let verticalDevider = Color(.MOVA.greyscale200)
        static let ratingHIndicatorBack = Color(.MOVA.greyscale300)
        static let numberOfLevelText = Color(.MOVA.greyscale900)
        static let ratingHGradientStart = Color(.MOVA.primary300)
        static let ratingHGradientEnd = Color(.MOVA.primary500)
        static let currentValueText = Color(.MOVA.Greyscale900White)
        static let totalValueText = Color(.MOVA.Greyscale700Greyscale300)
        static let votesCountText = Color(.MOVA.Greyscale800Greyscale300)
        static let ratingFilledStarText = Color(.MOVA.white)
        static let ratingEmptyStarText = Color(.MOVA.primary500)
    }
    
    enum SmallBottomSheet {
        static let background = UIColor.MOVA.WhiteDark1
        static let detentHandle = Color(.MOVA.Greyscale300Dark3)
        static let titleText = Color(.MOVA.error)
        static let descriptionText = Color(.MOVA.Greyscale800Greyscale300)
        static let tmp = UIColor.MOVA.Greyscale500White
    }
    
    enum EditProfile {
        static let background = Color(.MOVA.WhiteDark1)
    }
    
    enum Download {
        static let background = Color(.MOVA.WhiteDark1)
    }
    
    enum SubscribeToPremium {
        static let background = Color(.MOVA.WhiteDark1)
        static let rateBackground = Color(.MOVA.Greyscale50Dark2)
        static let rateBackgroundPressed = Color(.MOVA.primary100)
        static let subscribeToPremiumText = Color(.MOVA.primary500)
        static let priceColor = Color(.MOVA.Greyscale900White)
        static let descriptionPremiumText = Color(.MOVA.Greyscale700Greyscale300)
        static let horisontalDevider = Color(.MOVA.greyscale200)
        static let rowText = Color(.MOVA.Greyscale800Greyscale300)
    }
    
    enum Payment {
        static let tileBack = Color(.MOVA.tileBack)
        static let paymentBackground = Color(.MOVA.paymentdBack)
        static let textColor = Color(.MOVA.Greyscale900White)
        static let rowText = Color(.MOVA.Greyscale800Greyscale300)
        static let backgroundButton = Color(.MOVA.Primary100Dark3)
        static let foregroundColorButton = Color(.MOVA.Primary500White)
    }
    
    enum AddNewCard {
        static let background = Color(.MOVA.WhiteDark1)
        static let textColor = Color(.MOVA.Greyscale900White)
    }
    
    enum ReviewSummary {
        static let background = Color(.MOVA.tileBack)
        static let descriprionText = Color(.MOVA.Greyscale50Dark2)
    }
    
    enum HelpCenter {
        static let background = Color(.MOVA.WhiteDarkHome)
        static let tileBack = Color(.MOVA.tileBack)
        static let titleText = Color(.MOVA.Greyscale900White)
        static let descriprionText = Color(.MOVA.Greyscale800White)
        static let divider = Color(.MOVA.greyscale200)
        static let tileShadow = Color(.MOVA.tileShadow)
        static let searchBarBackground = Color(.MOVA.primary500)
        static let searchBarBackgroundWithAlpha = Color(.MOVA.primary500.withAlphaComponent(0.08))
    }
    
    enum ProgressPopUp {
        static let accentColor = Color(.MOVA.primary500)
        static let foregroundColor = Color(.MOVA.greyscale300)
    }

    enum Security {
        static let tileControlText = Color(.MOVA.Greyscale900White)
        static let tileSecurityText = Color(.MOVA.Greyscale800White)
    }
}

// MARK: - UNO Color Palette
extension UIColor {
    enum MOVA {
        //Appearance
        static let WhiteDark1 = UIColor(named: "WhiteDark1")!
        static let Greyscale50Dark2 = UIColor(named: "Greyscale50Dark2")!
        static let Greyscale100Dark2 = UIColor(named: "Greyscale100Dark2")!
        static let Greyscale100Dark3 = UIColor(named: "Greyscale100Dark3")!
        static let Greyscale200Dark3 = UIColor(named: "Greyscale200Dark3")!
        static let Greyscale300Dark3 = UIColor(named: "Greyscale300Dark3")!
        static let Greyscale500White = UIColor(named: "Greyscale500White")!
        static let Greyscale600Greyscale300 = UIColor(named: "Greyscale600Greyscale300")!
        static let Greyscale500Greyscale700 = UIColor(named: "Greyscale500Greyscale700")!
        static let Greyscale700White = UIColor(named: "Greyscale700White")!
        static let Greyscale700Greyscale300 = UIColor(named: "Greyscale700Greyscale300")!
        static let Greyscale800Greyscale300 = UIColor(named: "Greyscale800Greyscale300")!
        static let Greyscale800White = UIColor(named: "Greyscale800White")!
        static let Greyscale900White = UIColor(named: "Greyscale900White")!
        static let WhiteDarkHome = UIColor(named: "WhiteDarkHome")!
        static let WhiteClear = UIColor(named: "WhiteClear")!
        static let WhiteDark2 = UIColor(named: "WhiteDark2")!
        static let Primary100Dark3 = UIColor(named: "Primary100Dark3")!
        static let Primary500White = UIColor(named: "Primary500White")!
        static let paymentdBack = UIColor(named: "paymentBack")!
        static let tileBack = UIColor(named: "tileBack")!
        //Main
        static let primary100 = UIColor(named: "Primary100")!
        static let primary200 = UIColor(named: "Primary200")!
        static let primary300 = UIColor(named: "Primary300")!
        static let primary400 = UIColor(named: "Primary400")!
        static let primary500 = UIColor(named: "Primary500")!
        static let primaryOp500 = UIColor(named: "PrimaryOp500")!
        static let secondary100 = UIColor(named: "Secondary100")!
        static let secondary200 = UIColor(named: "Secondary200")!
        static let secondary300 = UIColor(named: "Secondary300")!
        static let secondary400 = UIColor(named: "Secondary400")!
        static let secondary500 = UIColor(named: "Secondary500")!
        //Alert & Status
        static let disabled = UIColor(named: "Disabled")!
        static let disabledButton = UIColor(named: "DisabledButton")!
        static let error = UIColor(named: "Error")!
        static let info = UIColor(named: "Info")!
        static let success = UIColor(named: "Success")!
        static let warning = UIColor(named: "Warning")!
        //Greyscale
        static let greyscale50 = UIColor(named: "Greyscale50")!
        static let greyscale100 = UIColor(named: "Greyscale100")!
        static let greyscale200 = UIColor(named: "Greyscale200")!
        static let greyscale300 = UIColor(named: "Greyscale300")!
        static let greyscale400 = UIColor(named: "Greyscale400")!
        static let greyscale500 = UIColor(named: "Greyscale500")!
        static let greyscale600 = UIColor(named: "Greyscale600")!
        static let greyscale700 = UIColor(named: "Greyscale700")!
        static let greyscale800 = UIColor(named: "Greyscale800")!
        static let greyscale900 = UIColor(named: "Greyscale900")!
        //Dark Colors
        static let dark1 = UIColor(named: "Dark1")!
        static let dark2 = UIColor(named: "Dark2")!
        static let dark3 = UIColor(named: "Dark3")!
        //Others
        static let white = UIColor(named: "White")!
        static let black = UIColor(named: "Black")!
        static let red = UIColor(named: "Red")!
        static let pink = UIColor(named: "Pink")!
        static let purple = UIColor(named: "Purple")!
        static let deepPurple = UIColor(named: "DeepPurple")!
        static let indigo = UIColor(named: "Indigo")!
        static let blue = UIColor(named: "Blue")!
        static let lightBlue = UIColor(named: "LightBlue")!
        static let cyan = UIColor(named: "Cyan")!
        static let teal = UIColor(named: "Teal")!
        static let green = UIColor(named: "Green")!
        static let lightGreen = UIColor(named: "LightGreen")!
        static let lime = UIColor(named: "Lime")!
        static let yellow = UIColor(named: "Yellow")!
        static let amber = UIColor(named: "Amber")!
        static let orange = UIColor(named: "Orange")!
        static let deepOrange = UIColor(named: "deepOrange")!
        static let brown = UIColor(named: "Brown")!
        static let blueGrey = UIColor(named: "BlueGrey")!
        static let clear = UIColor.clear
        //Background
        static let backgroundBlue = UIColor(named: "BackgroundBlue")!
        static let backgroundGreen = UIColor(named: "BackgroundGreen")!
        static let backgroundOrange = UIColor(named: "BackgroundOrange")!
        static let backgroundPink = UIColor(named: "BackgroundPink")!
        static let backgroundPurple = UIColor(named: "BackgroundPurple")!
        static let backgroundRed = UIColor(named: "BackgroundRed")!
        static let backgroundYellow = UIColor(named: "BackgroundYellow")!
        //Transparent
        static let transparentBlue = UIColor(named: "TransparentBlue")!
        static let transparentCyan = UIColor(named: "TransparentCyan")!
        static let transparentGreen = UIColor(named: "TransparentGreen")!
        static let transparentOrange = UIColor(named: "TransparentOrande")!
        static let transparentPurple = UIColor(named: "TransparentPurple")!
        static let transparentRed = UIColor(named: "TransparentRed")!
        static let transparentYellow = UIColor(named: "TransparentYellow")!
        //Missing in the Figma Design System
        static let logoDarkRed = UIColor(named: "LogoDarkRed")!
        
        //Gradient
        static let splashGradientMaxColor = UIColor(named: "splashGradientMaxColor")!
        static let pinCircleMinGradient = UIColor(named: "pinCircleMinGradient")!
        
        //Shadows
        static let tileShadow = UIColor(named: "tileShadow")!
    }
}
