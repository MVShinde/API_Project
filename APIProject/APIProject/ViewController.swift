//
//  ViewController.swift
//  APIProject
//
//  Created by Mangesh Shinde on 24/03/21.
//

import UIKit

protocol TestInterface  {
    func showLoading()
    func hideLoading()
}

class ViewController: UIViewController {

    var presenter = TestPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter.attachView(view: self)
        // Do any additional setup after loading the view.
        if Reachability.isInternetAvailable() {
            self.apiTest()
        }
    }

    func apiTest() {
        let params = [
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

