//
//  AppError.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/20/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruhhh!!! I have no idea what go on"
        case .invalidUrrl:
            return "HEYYY!!! give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}
