//
//  SearchViewController.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/27/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import UIKit
import FirebaseFirestore
class SearchViewController: UIViewController {
    //
    @IBOutlet weak var tableView: UITableView!
    var dishes: [Dish] = []
    var search: [Dish] = []
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .white
        setUpNavBar()
        registerCells()
        let db = Firestore.firestore()
        getAllDishes(db: db)
        // Do any additional setup after loading the view.
    }
    //lấy dữ liệu các món phổ biến
    private func getAllDishes(db: Firestore) {
        db.collection("dishes").getDocuments { (snapshot,error) in
            //kiểm tra dữ liệu rỗng
            if error == nil && snapshot != nil {
                //dùng vòng for duyệt data
                for document in snapshot!.documents {
                    let data = document.data()
                    self.dishes += [Dish(id: data["id"] as? String, name: data["name"] as? String, description: data["description"] as? String, image: data["image"] as? String, category: data["category"] as? String, calories: data["calories"] as? Int, popular: data["popular"] as? Int, special: data["special"] as? Int)]
                }
//                for dish in self.dishes {
//                    print(dish.name)
//                }
                //reload (update data)
                self.tableView.reloadData()
            }
        }
    }
    private func registerCells(){
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func setUpNavBar() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search by "
        searchBar.tintColor = UIColor.lightGray
        searchBar.barTintColor = UIColor.lightGray
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
        searchBar.isTranslucent = true
    }
    
}
extension UIViewController: UISearchBarDelegate {
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        navigationItem.titleView = nil
        searchBar.showsCancelButton = false
    }
}
//extension hiển thị collectionViewCell và dữ liệu của listDish
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(dish: search[indexPath.row])
        return cell
    }
    //xử lý khi click vào cell dish bất kì => dẫn đến trang chi tiết của món đó
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiateDetail()
        controller.dish = search[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search = []
        if searchText == "" {
            search = dishes
        }
        else {
            for dish in dishes {
                if (dish.name?.lowercased().contains(searchText.lowercased()))! {
                    search.append(dish)
                }
            }
        }
        self.tableView.reloadData()
    }
}


