//
//  ProductTVC.swift
//  Wikimedia
//
//  Created by Abhishek on 08/01/24.
//

import UIKit

class ProductTVC: UITableViewCell {

    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
