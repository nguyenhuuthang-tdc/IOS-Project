//
//  DishDetailViewController.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/19/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit
import FirebaseFirestore
class DishDetailViewController: UIViewController {

    
    //ánh xạ các component của detailScreen
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ideaField: UITextField!
    //tạo biến dish
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gọi hàm gán dữ liệu
        populateView()
        nameField.delegate = self as? UITextFieldDelegate
        ideaField.delegate = self as? UITextFieldDelegate
    }
    //hàm gán dữ liệu dish từ các collectionViewCell dược click cho các outlet của detail screen
    private func populateView(){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }
    
    @IBAction func placeOrderBtnClicked(_ sender: UIButton) {
        //kiểm tra không nhập tên trong input
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            nameField.text = ""
            return
        }
        guard let idea = ideaField.text?.trimmingCharacters(in: .whitespaces), !idea.isEmpty else {
            ideaField.text = ""
            return
        }
        //tạo biến firestore và gọi hàm up data
        let db = Firestore.firestore()
        addOrder(db: db)
        nameField.text = ""
        ideaField.text = ""
        print("Your idea has been received!")
    }
    //hàm up dữ liệu order
    private func addOrder(db: Firestore) {
        //hàm random
        func randomString(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).map{ _ in letters.randomElement()! })
        }
        // random id
        let id = randomString(length: 10)
        let name = nameField.text!
        let idea = ideaField.text!
        //up dữ liệu order (tên + món ăn) vào firebase
        db.collection("orders").addDocument(data: ["id": id, "name": name,"idea": idea, "dish-id": dish.id, "dish-name": dish.name, "dish-description": dish.description, "dish-image": dish.image, "dish-calories": dish.calories, "dish-category": dish.category, "dish-popular": dish.popular, "dish-special": dish.special])
    }
    
}
//extension ẩn bàn phím sau khi click nút Done
extension DishDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
