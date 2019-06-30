//
//  Model.swift
//  RxEureka
//
//  Created by Antonin Biret on 06/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import RxSwift

struct Model {
  let text: Variable<String?>
  let phone: Variable<String?>

  init(text: String?, phone: String?) {
    self.text = Variable(text)
    self.phone = Variable(phone)
  }
}
