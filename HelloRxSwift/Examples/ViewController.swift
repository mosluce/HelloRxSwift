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
        Observable.from([1, 2, 3, 4, 5])
            .subscribe(onNext: { (n) in
                print(n)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
//        Observable.just([1, 2, 3, 4, 5, 6])
//            .subscribe(onNext: { (ns) in
//                print(ns)
//            }, onError: nil, onCompleted: nil, onDisposed: nil)
//            .disposed(by: disposeBag)
    }
    
    @IBAction func createObservable() {
        let source = Observable<String>.create { (observer) -> Disposable in
            
            let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (_) in
                observer.on(.next("hello world"))
                observer.on(.completed)
            })
            
            return Disposables.create {
                print("dispose!!")
                timer.invalidate()
            }
        }.observeOn(MainScheduler.asyncInstance) // 回到 Main Thread
        
        source.subscribe { (event) in
            switch event {
            case .next(let msg):
                print(msg)
            case .error(_):
                break
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    ///  http://rxmarbles.com/#combineLatest
    @IBAction func combineObservable() {
        let x = Observable.from([1, 2, 3, 4, 5])
        let y = Observable.from([6, 7, 8, 9, 10, 888, 999])
        
        Observable.combineLatest(x, y)
            .subscribe(onNext: { (nn) in
                print("\(nn.0), \(nn.1)")
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
    }
}

