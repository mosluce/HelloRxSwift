//
//  TransformViewController.swift
//  HelloRxSwift
//
//  Created by 默司 on 2018/6/1.
//  Copyright © 2018年 默司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TransformViewController: UIViewController {
    
    lazy var disposeBag = DisposeBag()

    lazy var source = Observable.from([1, 1, 2, 3, 1, 4, 6, 5, 4, 4, 3, 2, 1, 6, 7, 8, 9, 9, 9, 0])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func map() {
        
    }
    
    @IBAction func flatMap() {
        
    }
    
    @IBAction func throttle() {
        
    }
    
    @IBAction func distinctUntilChanged() {
        
    }
    
    @IBAction func distinct() {
        
    }
    
    @IBAction func take() {
        
    }
    
    @IBAction func share() {
        
    }
}
