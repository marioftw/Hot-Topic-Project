//
//  Constants.swift
//  Vitality
//
//  Created by Mario Aguirre on 1/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

struct Constants {
    
    struct Images {
        static let logo = "VitalityLogo.png"
        static let logoWordsOnly = "VitalityLogo_1.png"
    }
    
    // MARK: Identifiers
    struct SegueId {
        static let registerSegue = "RegisterToHome"
        static let loginSegue = "LoginToHome"
    }
    
    struct CellId {
        static let messageCell = "MessageTableViewCell"
        static let messageNibCell = "MessageCell"
    }
    
    struct Message {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct Profile {
        static let collectionName = "users"
    }
}
