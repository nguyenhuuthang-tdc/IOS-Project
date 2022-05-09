//
//  CardView.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/18/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import Foundation
import UIKit
//hàm thêm shadow + chỉnh sửa ui cho các collectionViewcell
class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    //khởi tạo
    required init?(coder: NSCoder){
        super.init(coder: coder)
        initialSetup()
    }
    //thiết lập các thuộc tính bo góc + đổ bóng
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        cornerRadius = 10
    }
}
