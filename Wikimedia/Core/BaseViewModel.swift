//
//  BaseViewModel.swift
//  Wikimedia
//
//  Created by Abhishek on 11/01/24.
//

import Foundation


//protocol ViewModel {
//    var apiProvider: ApiProvider { get set }
//}
//
//class BaseViewModel: ViewModel, ViewTransitionEvents {
//
//    var apiProvider: ApiProvider
//
//    var viewHandler: BaseViewHandler?
//    var depricatedApiProvider: APIDataProvider
//    
//    init(apiDataProvider: ApiProvider = ApiProviderImpl.instance) {
//        self.apiProvider = apiDataProvider
//    }
//    
//    func viewDidLoad() {
//        //To be implemented by child
//    }
//    
//    func viewWillAppear() {
//        //To be implemented by child
//    }
//    
//    func viewDidAppear() {
//        //To be implemented by child
//    }
//    
//    func viewWillDisappear() {
//        //To be implemented by child
//    }
//    
//    func viewDidDisappear() {
//        //To be implemented by child
//    }
//    
//    func handleError(error: AFError?) {
//        if error?.responseCode == 401 {
//            self.viewHandler?.logout()
//        } else {
//            self.viewHandler?.showToast(with: "Something went wrong! Please try again!")
//        }
//    }
//}
