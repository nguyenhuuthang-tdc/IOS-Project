//
//  DishLandscapeCollectionViewCell.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/19/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {
    //định danh cho collection View Cell thuộc special dish
    static let identifier = String(describing: DishLandscapeCollectionViewCell.self)
    //outlet các component trong collection viewCell
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    //gán dữ liệu danh mục món ăn cho các component
    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }

}
