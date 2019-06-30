//
//  Model.swift
//  RxEureka
//
//  Created by Antonin Biret on 06/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa
struct Model {
    let text: BehaviorRelay<String?>
    let phone: BehaviorRelay<String?>
    
    init(text: String?, phone: String?) {
        self.text = BehaviorRelay(value: text)
        self.phone = BehaviorRelay(value: phone)
    }
}
