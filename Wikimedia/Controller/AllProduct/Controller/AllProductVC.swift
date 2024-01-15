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
    
    private var viewModel = AllProductVM()
    private var searchVM = SearchProductVM()
    private var cellType: ProductList = .searchproduct
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitleView.navTitle.text = "Product"
//        configuration()
        registerCell()
    }
    
    func registerCell(){
        catogaryProductTV.delegate = self
        catogaryProductTV.dataSource = self
        catogaryProductTV.register(UINib(nibName: "AllProductTVC", bundle: nil), forCellReuseIdentifier: "AllProductTVC")
        catogaryProductTV.register(UINib(nibName: "TitleTVC", bundle: nil), forCellReuseIdentifier: "TitleTVC")
    }
}

extension AllProductVC{
    
    func configuration() {
        loadData(skip: 0)
        observeEvent()
    }
    
    func loadData(skip: Int){
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getHomeAPIDtails(skip: skip)
        }
    }
    
    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    
                    self.catogaryProductTV.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension AllProductVC{
    
   @MainActor func loadSearchData(searchText: String){
        self.searchVM.searchProduct(searchText: searchText)
        searchObserveEvent()
    }
    
    func searchObserveEvent() {
        searchVM.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                /// Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    
                    self.catogaryProductTV.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
}

extension AllProductVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        switch cellType{
            case .searchTitle:
                searchVM.searchProduct(searchText: item.title)
                cellType = .searchproduct
                catogaryProductTV.reloadData()
            case .searchproduct:
                break
            }
    }
}

extension AllProductVC: UITableViewDataSource{
    var items:[Brand] {return searchVM.allSearchProduct}
//    var totalItem:Int {return viewModel.totalItem}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellType{
        case .searchTitle:
            return items.count
        case .searchproduct:
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellType{
            case .searchTitle:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTVC", for: indexPath) as! TitleTVC
                let item = items[indexPath.row]
                cell.productTitle.text = item.title
                return cell
                
            case .searchproduct:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AllProductTVC", for: indexPath) as! AllProductTVC
                let item = items[indexPath.row]
                let imgURL = item.thumbnail
                cell.productImageView.load(url: imgURL)
                cell.productNameLbl.text = item.title
                cell.detailLbl.text = item.description
                cell.prizeLbl.text = "\(String(describing: item.price))"
                cell.ratingLbl.text =  "\(String(describing: item.rating))"
                
                //Pagination
//                let totolLocal = items.count
//                if indexPath.row ==  totolLocal - 1{
//                    if totalItem > totolLocal{
//                        loadData(skip: totolLocal)
//                    }
//                }
                return cell
            }
    }
}

extension AllProductVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cellType = .searchTitle
        loadSearchData(searchText: searchText)
    }
}

enum ProductList{
    case searchTitle
    case searchproduct
}
