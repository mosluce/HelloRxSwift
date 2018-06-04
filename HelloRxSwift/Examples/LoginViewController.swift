//
//  LoginViewController.swift
//  HelloRxSwift
//
//  Created by 默司 on 2018/6/1.
//  Copyright © 2018年 默司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    lazy var viewModel = LoginViewModel()
    lazy var disposeBag = DisposeBag()
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.accountField.rx.text.bind(to: viewModel.account).disposed(by: disposeBag)
        self.passwordField.rx.text.bind(to: viewModel.password).disposed(by: disposeBag)
        
        self.viewModel.isLoginEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        self.loginButton.rx.tap.subscribe(onNext: viewModel.login).disposed(by: disposeBag)
        
        self.viewModel.loginSuccess.drive(onNext: {[weak self] (_) in
            let vc = UIAlertController(title: "登入成功", message: nil, preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            self?.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        self.viewModel.loginFailure.drive(onNext: {[weak self] (message) in
            let vc = UIAlertController(title: "登入失敗", message: message, preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            self?.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
