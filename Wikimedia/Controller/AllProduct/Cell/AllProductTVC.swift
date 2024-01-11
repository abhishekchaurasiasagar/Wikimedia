//
//  AllProductTVC.swift
//  Wikimedia
//
//  Created by Abhishek on 10/01/24.
//

import UIKit

class AllProductTVC: UITableViewCell {

    @IBOutlet weak var prizeLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToCardAction(_ sender: Any) {
    }
}
