//
//  DriverViewController.swift
//  HelloRxSwift
//
//  Created by 默司 on 2018/6/1.
//  Copyright © 2018年 默司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DriverViewController: UIViewController {

    enum MyError: Error {
        case demo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getObservable() -> Observable<String> {
        return Observable<String>.create({ (o) -> Disposable in
            
            o.on(.error(MyError.demo))
            
            return Disposables.create {}
        })
    }
    
    @IBAction func withObservable() {
    
    }
    
    @IBAction func withDriver() {
        
    }
}
