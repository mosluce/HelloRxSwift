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

    lazy var disposeBag = DisposeBag()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getObservable() -> Observable<String?> {
        let req = URLRequest(url: URL(string: "https://www.google.c")!)
        return URLSession.shared.rx
            .data(request: req)
            .map({ String(data: $0, encoding: .utf8) })
    }
    
    @IBAction func withObservable() {
        getObservable().bind(to: textView.rx.text).disposed(by: disposeBag)
    }
    
    @IBAction func withDriver() {
        getObservable()
            .asDriver(onErrorRecover: { (error) in
                return Driver.just(error.localizedDescription)
            })
            .drive(textView.rx.text)
            .disposed(by: disposeBag)
    }
}
