//
//  OnboaringCollectionViewCell.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/17/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit

class OnboaringCollectionViewCell: UICollectionViewCell {
    //tạo định danh cho các collectionViewCell thuộc onboard
    static let identifier = String(describing: OnboaringCollectionViewCell.self)
    //outlet các component thuộc screen onboard
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    //gán dữ liệu onboarđing Slide cho các outlet
    func setup(_ slide: OnboardingSlide){
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}
