//
//  DishPortraitCollectionViewCell.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/19/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {
    //định danh cho collection View Cell thuộc popular
    static let identifier = "DishPortraitCollectionViewCell"
    //outlet các component trong collection viewCell
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    //gán dữ liệu danh mục món ăn cho các component
    func setup(dish: Dish){
        titleLbl.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        caloriesLbl.text = dish.formattedCalories
        descriptionLbl.text = dish.description
    }
    
}
