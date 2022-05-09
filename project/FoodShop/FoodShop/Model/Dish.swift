//
//  Dish.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/19/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import Foundation
//đối tượng món ăn
struct Dish {
    let id, name, description, image, category: String?
    let calories: Int?
    let popular: Int?
    let special: Int?
    //format giá món ăn
    var formattedCalories: String {
        return "\(calories ?? 0) calories"
    }
}
