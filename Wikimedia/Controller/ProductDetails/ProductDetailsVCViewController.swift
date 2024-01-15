//
//  ProductDetailsVCViewController.swift
//  Wikimedia
//
//  Created by Abhishek on 15/01/24.
//

import UIKit

class ProductDetailsVCViewController: UIViewController {

    
    @IBOutlet weak var productCV: UICollectionView!
    @IBOutlet weak var titleProductLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var descrptionLbl: UILabel!
    @IBOutlet weak var prizeLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    
    var selectedProduct: Brand?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        configation()
        
        putProductDetails()
    }

    @IBAction func buyNowAction(_ sender: Any) {
    }
    
    
    @IBAction func addCartAction(_ sender: Any) {
    }
}

extension ProductDetailsVCViewController{
    
    func putProductDetails(){
        self.titleProductLbl.text = selectedProduct?.title
        self.brandLbl.text = selectedProduct?.brand
        self.descrptionLbl.text = selectedProduct?.description
        if let price = selectedProduct?.price, let discount = selectedProduct?.discountPercentage{
            self.prizeLbl.text = "\(price)"
            self.discountLbl.text = "\(discount)%"
        }
    }
    
    func configation(){
        productCV.dataSource = self
        productCV.delegate = self
        
        productCV.register(UINib(nibName: "ProductDetailsCVC", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsCVC")
    }
}


extension ProductDetailsVCViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
}

extension ProductDetailsVCViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedProduct?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCVC", for: indexPath) as! ProductDetailsCVC
        
        if let imgURL = selectedProduct?.images[indexPath.item]{
            cell.productImageView.load(url: imgURL)
        }
        
        return cell
    }
}
