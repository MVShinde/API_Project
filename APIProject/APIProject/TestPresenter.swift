//
//  TestPresenter.swift
//  APIProject
//
//  Created by Mangesh Shinde on 25/03/21.
//

import UIKit

struct TestPresenter {
    var view : UIView?
    
//    func attachView(view : ViewController) {
//        self.view = view
//    }
    
    func apiTest() {
        let params = [
            "test" : "test",
            "test" : "test"
        ]
        print(params)
        TestServices().postSignUp(parameters: params, success: { result in
            DispatchQueue.main.async {

            }
        }, failure: { fail in
            print(fail.description)
           // self.showAlertWith(title: "Error", message: AppConstMessages.SOMETHING_WENT_WRONG_MSG)
        })
    }
    
}
