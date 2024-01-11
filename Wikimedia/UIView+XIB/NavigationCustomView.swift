//
//  NavigationCustomView.swift
//  Wikimedia
//
//  Created by Abhishek on 10/01/24.
//

import UIKit

class NavigationCustomView: UIView {

    @IBOutlet var navView: UIView!
    @IBOutlet weak var navTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    private func commitInit(){
        Bundle.main.loadNibNamed("NavigationCustomView", owner: self)
        addSubview(navView)
        navView.frame = self.bounds
        navView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
