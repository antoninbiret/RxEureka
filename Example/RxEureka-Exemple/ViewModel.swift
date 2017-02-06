//
//  ViewModel.swift
//  RxEureka
//
//  Created by Antonin Biret on 06/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Eureka
import RxEureka
import RxSwift

protocol ViewModeling {
  
  /// The form
  var form: Form { get }
  
}

struct ViewModel: ViewModeling {
  
  /// The form
  let form: Form
  
  /// Text row
  private let _textRow: TextRow
  
  /// Phone row
  private let _phoneRow: PhoneRow
  
  /// The model
  private let model: Model
  
  /// The dispose bag
  private let _disposeBag = DisposeBag()
  
  init(model: Model) {
    
    self.model = model
    
    self.form = Form()
    
    self._textRow = TextRow() { row in
      row.title = "Text Row"
      row.placeholder = "Enter text here"
    }
    
    self._phoneRow = PhoneRow() { row in
      row.title = "Phone Row"
      row.placeholder = "And numbers here"
    }
    
    self.form
      +++ Section()
      <<< self._textRow
      <<< self._phoneRow
    
    self._configureBindings()
    
  }
  
  private func _configureBindings() {
    
    //Text row
    self.model.text
      .asObservable()
      .bindTo(self._textRow.rx.value)
      .addDisposableTo(self._disposeBag)
    
      self._textRow.rx.value
      .asObservable()
      .bindTo(self.model.text)
      .addDisposableTo(self._disposeBag)
    
    //Phone row
    self.model.phone
      .asObservable()
      .bindTo(self._phoneRow.rx.value)
      .addDisposableTo(self._disposeBag)
    
    self._phoneRow.rx.value
      .asObservable()
      .bindTo(self.model.phone)
      .addDisposableTo(self._disposeBag)
    
    //Change logger
    
    self.model.text
      .asObservable()
      .subscribe(onNext: { v in
        print("Model.text did change to \(v)")
      })
      .addDisposableTo(self._disposeBag)
    
    self.model.phone
      .asObservable()
      .subscribe(onNext: { v in
        print("Model.phone did change to \(v)")
      })
      .addDisposableTo(self._disposeBag)
  }
  
}
