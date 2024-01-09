//
//  String+Extension.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import Foundation
import UIKit
//import SDWebImage

extension UIImageView {
    func load(url: String){
        guard let url = URL(string: url) else {return}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


//extension UIImageView{
//    enum DefaultPlaceholderImg: String{
//        case dummyBankImage = "bank_PlaceholderImg"
//        case profileDummyImage = "profile_PlaceholderImg"
//    }
//    
//    func imageFromUrl(strUrl: String, placeholder: DefaultPlaceholderImg) {
//        let url = URL(string: strUrl)
//        sd_setImage(with: url, placeholderImage: UIImage(named: placeholder.rawValue), options: .refreshCached, context: nil)
//    }
//    
//}
