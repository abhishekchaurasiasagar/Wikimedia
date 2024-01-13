//
//  BaseViewController.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation
import UIKit

protocol ViewTransitionEvents {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

protocol ReloadableView {
    func reloadView()
    func showLoading()
    func stopLoading()
}

class BaseViewController<VM>: UIViewController, ReloadableView
where VM: ViewTransitionEvents {
    
    let viewModel: VM
    
    init(_ viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func reloadView() {
        //
    }
    
    func showLoading() {
        BALoader.show(currentViewController: self)
    }
    
    func stopLoading() {
        BALoader.dismiss(currentViewController: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.viewDidDisappear()
    }
    
}
