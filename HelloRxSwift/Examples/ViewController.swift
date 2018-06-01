//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by 默司 on 2018/6/1.
//  Copyright © 2018年 默司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func basic() {
        
    }
    
    @IBAction func createObservable() {
        
    }
    
    @IBAction func combineObservable() {
        let x = Observable.from([1, 2, 3, 4, 5])
        let y = Observable.from([6, 7, 8, 9, 10])
    }
}

