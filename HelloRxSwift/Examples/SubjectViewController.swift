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

    lazy var publish = PublishSubject<String?>()
    lazy var behavior = BehaviorSubject<String?>.init(value: "start")
//    lazy var variable = Variable<String?>.init("variable start")
    lazy var relay = BehaviorRelay<String?>.init(value: "relay start")
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var publishLabel: UILabel!
    @IBOutlet weak var behaviorLabel: UILabel!
    @IBOutlet weak var variableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        publish.subscribe(onNext: {[unowned self] (txt) in
            if txt == "hello" {
                self.publishLabel.text = "Publish => Y"
            } else {
                self.publishLabel.text = "Publish => N"
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        behavior.subscribe(onNext: {[unowned self] (txt) in
            if txt == "hello" {
                self.behaviorLabel.text = "Behavior => Y"
            } else {
                self.behaviorLabel.text = "Behavior => N"
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        relay.subscribe(onNext: {[unowned self] (txt) in
            if txt == "hello" {
                self.variableLabel.text = "Variable => Y"
            } else {
                self.variableLabel.text = "Variable => N"
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        relay.skip(1).subscribe(onNext: {print("\($0 ?? "nil")")}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
//        input.rx.text.bind(to: publish).disposed(by: disposeBag)
//        input.rx.text.bind(to: behavior).disposed(by: disposeBag)
//        input.rx.text.bind(to: relay).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
