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
    var totalItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitleView.navTitle.text = "Product"
        loadData(skip: 0)
        registerCell()
    }
    
    func loadData(skip: Int){
        DispatchQueue.global(qos: .background).async {
            self.getHomeAPIDtails(skip: skip)
        }
    }
    
    func registerCell(){
        catogaryProductTV.delegate = self
        catogaryProductTV.dataSource = self
        catogaryProductTV.register(UINib(nibName: "AllProductTVC", bundle: nil), forCellReuseIdentifier: "AllProductTVC")
    }
    
    func getHomeAPIDtails(skip:Int){
        ApiProviderImpl.instance.allCategaryProductApi.getLimitedProduct(limit: 10, skip: skip) { product, error in
            if error == nil{
                if let product = product{
                    self.allProduct.append(contentsOf: product.products)
                    self.totalItem = product.total
                    print(self.allProduct)
                }
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
        
        //Pagination
        let totolLocal = allProduct.count
        if indexPath.row ==  totolLocal - 1{
            if totalItem > totolLocal{
                loadData(skip: totolLocal)
            }
        }
        return cell
    }
}
