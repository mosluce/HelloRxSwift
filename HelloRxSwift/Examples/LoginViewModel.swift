//
//  LoginViewModel.swift
//  HelloRxSwift
//
//  Created by 默司 on 2018/6/1.
//  Copyright © 2018年 默司. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    lazy var account = BehaviorRelay<String?>(value: nil)
    lazy var password = BehaviorRelay<String?>(value: nil)
    
    var isLoginEnabled: Driver<Bool>!
    
    private lazy var loginFailureSubject = PublishSubject<String>()
    var loginFailure: Driver<String>!
    
    private lazy var loginSuccessSubject = PublishSubject<Bool>()
    var loginSuccess: Driver<Bool>!
    
    init() {
        self.isLoginEnabled = Observable.combineLatest(account, password)
            .map({ (t) -> Bool in
                guard let acc = t.0, let pass = t.1 else { return false }
                guard !acc.isEmpty, !pass.isEmpty else { return false }
                
                return true
            })
            .asDriver(onErrorJustReturn: false)
        
        self.loginFailure = loginFailureSubject.asDriver(onErrorJustReturn: "Unknow")
        self.loginSuccess = loginSuccessSubject.asDriver(onErrorJustReturn: false)
    }
    
    func login() {
        let account = self.account.value!
        let password = self.password.value!
        
        if account != "mosluce" {
            loginFailureSubject.on(.next("帳號不存在"))
            return
        }
        
        if password != "12345678" {
            loginFailureSubject.on(.next("密碼錯誤"))
            return
        }
        
        loginSuccessSubject.on(.next(true))
    }
}
