//
//  NetworkManager.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation

public enum NetworkEnvironment {
    case production
    case staging
    case uat
}

enum NetworkType: String{
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}
