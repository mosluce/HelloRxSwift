//
//  QAViewController.swift
//  HelloRxSwift
//
//  Created by 默司 on 2018/6/4.
//  Copyright © 2018年 默司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class QAViewController: UIViewController {

    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var customRequestButton: UIButton!
    
    lazy var disposeBag = DisposeBag()
    
    let url = "http://tpdb.speed2.hinet.net/test_020m.zip"
    var prev: Disposable?
    var indicator: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.requestButton.rx.tap
            .throttle(1, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: {[unowned self] () in
                print("START => \(self.indicator)")
                self.sendRequest(self.indicator)
                self.indicator += 1
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        self.customRequestButton.rx.tap
            .throttle(1, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: {[unowned self] () in
                print("START => \(self.indicator)")
                self.sendRequest(self.indicator)
                self.indicator += 1
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
//        Observable.combineLatest(self.requestButton.rx.tap, self.customRequestButton.rx.tap)
//            .throttle(1, scheduler: MainScheduler.asyncInstance)
//            .subscribe(onNext: {[unowned self] (_) in
//                print("START => \(self.indicator)")
//                self.sendRequest(self.indicator)
//                self.indicator += 1
//            }, onError: nil, onCompleted: nil, onDisposed: nil)
//            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendRequest(_ ind: Int) {
        prev?.dispose()
        
        let req = URLRequest(url: URL(string: url)!)
        prev = URLSession.shared.rx.data(request: req)
            .subscribe(onNext: { (_) in
                print("NEXT => \(ind)")
            }, onError: { (_) in
                print("ERROR => \(ind)")
            }, onCompleted: {
                print("COMPLETED => \(ind)")
            }, onDisposed: {
                print("DISPOSED => \(ind)")
            })
        prev?.disposed(by: disposeBag)
    }
    
    func sendCustomRequest(_ ind: Int) {
        prev?.dispose()
        
        prev = createHttpRequest(ind)
            .subscribe(onNext: { (_) in
                print("NEXT => \(ind)")
            }, onError: { (_) in
                print("ERROR => \(ind)")
            }, onCompleted: {
                print("COMPLETED => \(ind)")
            }, onDisposed: {
                print("DISPOSED => \(ind)")
            })
        prev?.disposed(by: disposeBag)
    }
    
    func createHttpRequest(_ ind: Int) -> Observable<Data> {
        return Observable.create({[unowned self] (obs) -> Disposable in
            let req = URLRequest(url: URL(string: self.url)!)
            let task = URLSession.shared.dataTask(with: req, completionHandler: { (data, res, error) in
                guard error == nil else {
                    obs.on(.error(error!))
                    obs.on(.completed)
                    return
                }
                
                /// TODO: 處理 Data, Response
                if let data = data {
                    obs.on(.next(data))
                }
                
                obs.on(.completed)
            })
            
            task.resume()
            
            return Disposables.create {
                // 被 Dispose 時進行的動作
                print("CUSTOM DISPOSE ACTION => \(ind)")
                task.cancel()
            }
        })
    }

}
