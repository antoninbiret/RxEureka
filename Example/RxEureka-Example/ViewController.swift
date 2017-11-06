//
//  ViewController.swift
//  RxEureka-Exemple
//
//  Created by Antonin Biret on 06/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Eureka

class ViewController: FormViewController {

  let viewModel: ViewModeling = ViewModel(model: Model(text: "RxEureka", phone: "0000"))
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.form = self.viewModel.form
    
  }

}

