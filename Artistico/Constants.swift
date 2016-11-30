//
//  Constants.swift
//  Artistico
//
//  Created by kaushal on 11/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import Foundation
import UIKit

struct Global {
    
    static let kEmptyString = ""
}


struct RestConstraint {
    
    static let baseURLString = "http://54.215.151.55/wb/api/v1"
    
}

struct NotificationKeys {
    static let SignedIn = "onSignInCompleted"
}

struct SegueIdentifier {
    static let SignInToFp = "SignInToFP"
    static let FpToSignIn = "FPToSignIn"
}


struct TextStyleGuide {
    
    static let kHelveticaNeueRegular = "HelveticaNeue"
    static let kHelveticaNuneBold   = "HelveticaNeue-Bold"
    static let kHelveticaNuneMedium = "HelveticaNeue-Medium"
    static let kHelveticaNeueLight = "HelveticaNeue-Light"
    static let kHelveticaNeueLightItalic = "HelveticaNeue-LightItalic"
    static let kHelveticaNeueMediumItalic = "HelveticaNeue-MediumItalic"
    
    static let kSFUITextRegular = "SFUIText-Regular"
    static let  kSFUITextMedium = "SFUIText-Medium"
    static let kSFUITextLightItalic = "SFUIText-LightItalic"
    static let  kSFUITextItalic =  "SFUIText-Italic"
    static let kSFUITextBold =  "SFUIText-Bold"
    static let kSFUIDisplayRegular = "SFUIDisplay-Regular"
    static let kSFUIDisplayBold = "SFUIDisplay-Bold"
    
}


struct ColorStyle {
    
    static let backgroundColor:UIColor = UIColor.hexStringToUIColor(hex: "00C895")
    
}


struct LayoutPadding {
    
}


struct GenericErrorMsg {
    
}


struct ActionTitle {
    
    static let kCancel = NSLocalizedString("Cancel", comment:"Cancel title")
    static let kSend = NSLocalizedString("Send", comment:"Send title")
    static let kInternetConnectionNotAvailable = NSLocalizedString("Internet connection appears to be offline", comment:"Internet connection appears to be offline")

}


struct TableActionTitle {
    static let kDelete = NSLocalizedString("Delete", comment:"Delete title")

}

