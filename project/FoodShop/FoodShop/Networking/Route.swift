//
//  Route.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/20/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import Foundation

enum Route {
    static let baseUrl = "https:://yummie.glitch.me/"
    
    case temp
    
    var description: String {
        switch self {
        case .temp: return "/dish-categories"
        }
    }
}
