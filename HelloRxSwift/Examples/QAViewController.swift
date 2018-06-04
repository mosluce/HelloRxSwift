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

}
