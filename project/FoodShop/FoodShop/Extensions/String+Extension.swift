//
//  String+Extension.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/18/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import Foundation
//extension chuyển string thành 1 url (Kingfisher library)
extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
