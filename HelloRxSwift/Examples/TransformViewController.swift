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
    
    @IBOutlet weak var throttleInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.throttleInput.rx.text
            .throttle(3, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { print("\(Date()) : \($0 ?? "")") })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func map() {
        source.map{( $0 * 10 )}.subscribe(onNext: {print($0)}).disposed(by: disposeBag)
    }
    
    @IBAction func flatMap() {
        source
            .flatMap { (n) -> Observable<(Int, Data)> in
                return URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://www.google.com/search?q=\(n)")!)).map({(n, $0)})
            }
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {print($0.0)})
            .disposed(by: disposeBag)
    }
    
    @IBAction func distinctUntilChanged() {
        source.distinctUntilChanged()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
    }
        
    @IBAction func share() {
        let shared = source.distinctUntilChanged().flatMap { (n) -> Observable<(Int, Data)> in
            return URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://www.google.com/search?q=\(n)")!)).map({(n, $0)})
        }.observeOn(MainScheduler.asyncInstance).share()
        
        shared.subscribe(onNext: {print($0.0)}).disposed(by: disposeBag)
        shared.subscribe(onNext: {print($0.0)}).disposed(by: disposeBag)
        shared.subscribe(onNext: {print($0.0)}).disposed(by: disposeBag)
    }
}
