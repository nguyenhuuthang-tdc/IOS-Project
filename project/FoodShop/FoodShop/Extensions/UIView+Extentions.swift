//
//  UIView+Extentions.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/17/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    //khởi tạo thuộc tính cornerRadiú cho toàn bộ component
    @IBInspectable var cornerRadius: CGFloat{
        get{ return cornerRadius }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
