//
//  AllProductVC.swift
//  Wikimedia
//
//  Created by Abhishek on 10/01/24.
//

import UIKit

class AllProductVC: UIViewController {

    @IBOutlet weak var navTitleView: NavigationCustomView!
    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var phoneProductTV: UITableView!
    @IBOutlet weak var catogaryProductTV: UITableView!
    var allProduct: [Brand] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitleView.navTitle.text = "Product"
        DispatchQueue.global(qos: .background).async {
            self.getHomeAPIDtails()
        }
        registerCell()
    }
    
    func registerCell(){
        catogaryProductTV.delegate = self
        catogaryProductTV.dataSource = self
        catogaryProductTV.register(UINib(nibName: "AllProductTVC", bundle: nil), forCellReuseIdentifier: "AllProductTVC")
    }
    
    func getHomeAPIDtails(){
        ApiProviderImpl.instance.allCategaryProductApi.getAllProductCategories { product, error in
            if error == nil{
                guard let pro = product?.products else {return}
                self.allProduct = pro
                print(self.allProduct)
            }else{
                print("Error \(String(describing: error))")
            }
            self.catogaryProductTV.reloadData()
        }
    }

}

extension AllProductVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AllProductVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !allProduct.isEmpty{
            return allProduct.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllProductTVC", for: indexPath) as! AllProductTVC
        if !allProduct.isEmpty{
            let items = allProduct[indexPath.row]
            let imgURL = items.thumbnail
            cell.productImageView.load(url: imgURL)
            cell.productNameLbl.text = items.title
            cell.detailLbl.text = items.description
            cell.prizeLbl.text = "\(String(describing: items.price))"
            cell.ratingLbl.text =  "\(String(describing: items.rating))"
        }
        return cell
    }
}
