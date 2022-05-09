//
//  DishListTableViewCell.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/20/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    //tạo định danh cho danh sách món thuộc danh mục món
    static let identifier = "DishListTableViewCell"
    //outlet  của các table view cell
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    //gán dữ liệu món ăn cho các component thuộc danh sách món theo danh mục
    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
    }
    //gán dữ liệu món ăn và tên người đặt cho các component thuộc đơn hàng
    func setup(order: Order) {
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        titleLbl.text = order.name
        descriptionLbl.text = order.idea
    }
}
