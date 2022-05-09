//
//  CategoryCollectionViewCell.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/18/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    //định danh cho collection View Cell thuộc danh mục
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    //outlet các component trong collection viewCell
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    //gán dữ liệu danh mục món ăn cho các component
    func setup(category: DishCategory){
        categoryTitleLbl.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }
}
