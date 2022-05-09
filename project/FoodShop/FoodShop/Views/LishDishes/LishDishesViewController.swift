//
//  LishDishesViewController.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/20/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit
import FirebaseFirestore
class LishDishesViewController: UIViewController {
    //outlet tableview
    @IBOutlet weak var tableView: UITableView!
    //tạo biến category
    var category: DishCategory!
    //tạo mảng chứa dữ liệu các món kiểu dish
    var dishes: [Dish] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCells()
        //gọi hàm lấy dữ liệu món theo danh mục
        let db = Firestore.firestore()
        getCategoryDishes(db: db)
    }
    //lấy dữ liệu các món ăn theo danh mục
    private func getCategoryDishes(db: Firestore) {
        db.collection("dishes").whereField("category", isEqualTo: category.id!).getDocuments { (snapshot,error) in
            //kiểm tra dữ liệu rỗng
            if error == nil && snapshot != nil {
                //dùng vòng for duyệt data
                for document in snapshot!.documents {
                    let data = document.data()
                    self.dishes += [Dish(id: data["id"] as? String, name: data["name"] as? String, description: data["description"] as? String, image: data["image"] as? String, category: data["category"] as? String, calories: data["calories"] as? Int, popular: data["popular"] as? Int, special: data["special"] as? Int)]
                }
                self.tableView.reloadData()
            }
        }
    }
    private func registerCells(){
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}
//extension hiển thị collectionViewCell và dữ liệu của listDish
extension LishDishesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }
    //xử lý khi click vào cell dish bất kì => dẫn đến trang chi tiết của món đó
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiateDetail()
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
