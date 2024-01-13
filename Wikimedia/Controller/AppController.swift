//
//  AppController.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation

enum appEnvironment {
    case DEBUG
    case PRODUCTION
}

class AppController{
    
    static var shared : AppController{
        let sharedObj = AppController()
        return sharedObj
    }
    
    var networkEnvironment : NetworkEnvironment = .production
    var getBaseURL: String {
        switch networkEnvironment {
        case .production:
            return "https://dummyjson.com/"
        case .staging:
            return "https://dummyjson.com/"
        case .uat:
            return "https://dummyjson.com/"
        }
    }
}
