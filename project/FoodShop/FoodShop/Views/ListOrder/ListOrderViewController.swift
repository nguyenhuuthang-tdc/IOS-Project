//
//  ListOrderViewController.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/20/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit
import FirebaseFirestore
class ListOrderViewController: UIViewController {
    //outlet của tableview
    @IBOutlet weak var tableView: UITableView!
    //tạo mảng chứa dữ liệu đơn hàng kiểu Order
    var orders: [Order] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ideas"
        registerCells()
        //gọi hàm lấy dữ liệu
        let db = Firestore.firestore()
        getAllOrder(db: db)
    }
    //hàm lấy toàn bộ dữ liệu các đơn hàng firebase
    private func getAllOrder(db : Firestore){
        db.collection("orders").getDocuments() { (snapshot,error) in
            //kiểm tra dữ liệu rỗng
            if error == nil && snapshot != nil {
                //dùng vòng for duyệt data
                for document in snapshot!.documents {
                    let data = document.data()
                    self.orders.append(Order(id: data["id"]! as? String, name: data["name"]! as? String,idea: data["idea"] as? String, dish: Dish(id: data["dish-id"]! as? String, name: data["dish-name"]! as? String, description: data["dish-description"]! as? String, image: data["dish-image"]! as? String, category: data["dish-category"]! as? String, calories: data["dish-calories"]! as? Int, popular: data["dish-popular"]! as? Int, special: data["dish-special"]! as? Int)))
                }
                //reload data
                self.tableView.reloadData()
            }
        }
    }
    private func registerCells(){
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}
//extension hiển thị các collectionViewCell và dữ liệu đơn hàng
extension ListOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    //xử lý khi click vào ý kiến bất kì bất kì => dẫn đến trang chi tiết của đơn hàng đó
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiateDetail()
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}
