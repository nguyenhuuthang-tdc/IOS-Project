//
//  HomeViewController.swift
//  FoodShop
//
//  Created by Nguyễn Thắng on 6/18/21.
//  Copyright © 2021 Nguyễn Thắng. All rights reserved.
//

import FirebaseFirestore
import UIKit
class HomeViewController: UIViewController{
    //
    
    //ánh xạ các collectionView ở HomeScreen
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    //tạo biến danh mục (mảng kiểu danh mục)
    var categories: [DishCategory] = []
    //tạo mảng dish phổ biến kiểu Dish
    var populars: [Dish] = []
    //tạo mảng dish đặc biệt kiểu Dish
    var specials: [Dish] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        registerCells()
        let db = Firestore.firestore()
        //gọi hàm get dữ liệu các món phổ biến từ firebase
        getPopularDishes(db: db)
        //gọi hàm get dữ liệu các món dặc biệt từ firebase
        getSpecialDishes(db: db)
        //gọi hàm get dữ liệu danh mục từ firebase
        getCategoryDishes(db: db)
    }
    //lấy dữ liệu các món phổ biến
    private func getPopularDishes(db: Firestore) {
        db.collection("dishes").whereField("popular", isEqualTo: 1).getDocuments { (snapshot,error) in
            //kiểm tra dữ liệu rỗng
            if error == nil && snapshot != nil {
                //dùng vòng for duyệt data
                for document in snapshot!.documents {
                    let data = document.data()
                    self.populars += [Dish(id: data["id"] as? String, name: data["name"] as? String, description: data["description"] as? String, image: data["image"] as? String, category: data["category"] as? String, calories: data["calories"] as? Int, popular: data["popular"] as? Int, special: data["special"] as? Int)]
                }
                //reload (update data)
                self.popularCollectionView.reloadData()
            }
        }
    }
    //lấy dữ liệu các món đặc biệt
    private func getSpecialDishes(db: Firestore) {
        db.collection("dishes").whereField("special", isEqualTo: 1).getDocuments { (snapshot,error) in
            //kiểm tra dữ liệu rỗng
            if error == nil && snapshot != nil {
                //dùng vòng for duyệt data
                for document in snapshot!.documents {
                    let data = document.data()
                    self.specials += [Dish(id: data["id"] as? String, name: data["name"] as? String, description: data["description"] as? String, image: data["image"] as? String, category: data["category"] as? String, calories: data["calories"] as? Int, popular: data["popular"] as? Int, special: data["special"] as? Int)]
                }
                //reload (update data)
                self.specialsCollectionView.reloadData()
            }
        }
    }
    //lấy dữ liệu danh mục món ăn
    private func getCategoryDishes(db: Firestore) {
        db.collection("categories").getDocuments() { (snapshot,error) in
            //kiểm tra dữ liệu rỗng
            if error == nil && snapshot != nil {
                //dùng vòng for duyệt data
                for document in snapshot!.documents {
                    let data = document.data()
                    self.categories += [DishCategory(id: data["id"] as? String, name: data["title"] as? String, image: data["image"] as? String)]
                }
                //reload (update data)
                self.categoryCollectionView.reloadData()
            }
        }
    }
    //dăng kí cho các collection view cell trong các collectionview
     func registerCells(){
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        //
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        //
        specialsCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}
//extension
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        case specialsCollectionView:
            return specials.count
        default: return 0
        }
    }
    //hiển thị các collectionViewCell cùng dữ liệu ra homeScreen
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setup(dish: populars[indexPath.row])
            return cell
        case specialsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    //hàm xử lý khi click collectionViewCell bất kì
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //xử lý nếu click collectionViewCell thuộc danh mục => dẫn đến trang các dish thuộc danh mục đó
        if collectionView == categoryCollectionView {
            let controller = LishDishesViewController.instantiateCategory()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
        //xử lý nếu click collectionViewCell thuộc món phổ biến và đặc biệt => dẫn đến trang chi tiết
        else {
            let controller = DishDetailViewController.instantiateDetail()
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

