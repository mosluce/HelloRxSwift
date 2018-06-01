//
//  SubjectViewController.swift
//  HelloRxSwift
//
//  Created by 默司 on 2018/6/1.
//  Copyright © 2018年 默司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SubjectViewController: UIViewController {
    
    lazy var disposeBag = DisposeBag()

    lazy var publish = PublishSubject<String>()
    lazy var behavior = BehaviorSubject<String>.init(value: "start")
    lazy var variable = Variable<String>.init("variable start")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
