//
//  UIViewController+Extension.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/19/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import Foundation
import UIKit
//extension khởi tạo định danh cho các View controller + dữ liệu 
extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    static func instantiateDetail() -> DishDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! DishDetailViewController
    }
    static func instantiateCategory() -> LishDishesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! LishDishesViewController
    }
}
