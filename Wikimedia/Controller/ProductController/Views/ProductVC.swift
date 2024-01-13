//
//  ProductVC.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import UIKit

class ProductVC: UIViewController {

    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var productTV: UITableView!
    
    var productViews : [PageType] = []
    var searchResults: [PageType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.global(qos: .background).async {
//            self.getHomeAPIDtails()
//        }
        
        registerCell()
    }
    
    func registerCell(){
        productTV.dataSource = self
        productTV.delegate = self
        
        productSearchBar.delegate = self
        productTV.registerCell(type: ProductTVC.self)
    }
    
//    func getHomeAPIDtails(){
//        ApiProviderImpl.instance.productApi.getAllProductCategories { allProduct, error in
//            if error == nil{
//            let _ = allProduct?.query.pages.map({ (key: String, value: Page) in
//                self.productViews.append(PageType(title: value.title, thumbnail: value.thumbnail?.source ?? nil, extract: value.extract))
//                })
//                
//            }else{
//                print("Error \(String(describing: error))")
//            }
//            self.searchResults = self.productViews
//            self.productTV.reloadData()
//        }
//    }
}

extension ProductVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ProductVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchResults.isEmpty{
            return searchResults.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
        if !searchResults.isEmpty{
            let items = searchResults[indexPath.item]
            cell.titleLbl.text = items.title
            cell.subTitleLbl.text = items.extract
            if let imgURL = items.thumbnail{
                cell.imgView.isHidden = false
                cell.productImgView.load(url: imgURL)
            }
            else{cell.imgView.isHidden = true}
        }
        return cell
    }
}

extension ProductVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchResults = productViews
        }else{
            searchResults = productViews.filter({ item in
                if let title = item.title,title.uppercased().contains(searchText.uppercased()){
                    return true
                }else{
                    return false
                }
            })
        }
        self.productTV.reloadData()
    }
}
