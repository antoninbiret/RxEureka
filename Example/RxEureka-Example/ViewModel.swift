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

    self._textRow = TextRow { row in
      row.title = "Text Row"
      row.placeholder = "Enter text here"
    }

    self._phoneRow = PhoneRow { row in
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
      .bind(to: self._textRow.rx.value)
      .disposed(by: self._disposeBag)

      self._textRow.rx.value
      .asObservable()
      .bind(to: self.model.text)
      .disposed(by: self._disposeBag)

    self._textRow.rx.isHighlighted.subscribe(onNext: {
      print("TextRow.isHighlighted:", $0)
    }).disposed(by: self._disposeBag)

    //Phone row
    self.model.phone
      .asObservable()
      .bind(to: self._phoneRow.rx.value)
      .disposed(by: self._disposeBag)

    self._phoneRow.rx.value
      .asObservable()
      .bind(to: self.model.phone)
      .disposed(by: self._disposeBag)

    self._phoneRow.rx.isHighlighted.subscribe(onNext: {
      print("PhoneRow.isHighlighted:", $0)
    }).disposed(by: self._disposeBag)

    //Change logger

    self.model.text
      .asObservable()
      .subscribe(onNext: { v in
        print("Model.text did change to \(String(describing: v))")
      })
      .disposed(by: self._disposeBag)

    self.model.phone
      .asObservable()
      .subscribe(onNext: { v in
        print("Model.phone did change to \(String(describing: v))")
      })
      .disposed(by: self._disposeBag)
  }

}
