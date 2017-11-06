//
//  RxEurekaSpec.swift
//  RxEureka-Tests
//
//  Created by Antonin Biret on 08/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import Eureka
import RxEureka

class RxEurekaSpec: QuickSpec {
  
  override func spec() {
    let disposeBag = DisposeBag()
    
    let form = Form()
    
    
    let formViewController = FormViewController()
    formViewController.form = form
    
    describe("TextRow's rx value") {
      
      it("should stream the default value") {
        let defaultValue = "Some input"
        let row = TextRow()
        form +++ Section() <<< row
        
        row.value = defaultValue
        
        waitUntil { done in
          row.rx.value
            .asObservable()
            .subscribe(onNext: { v in
              expect(v).to(equal(defaultValue))
              done()
            })
            .disposed(by: disposeBag)
        }
      }
      
      context("if the value is changed") {
        it("should stream the new value") {
          let defaultValue = "Some input"
          let row = TextRow()
          form +++ Section() <<< row
          
          let _ = formViewController.view
          row.value = defaultValue
          
          let expectedValue = "A final input"
          waitUntil { done in
            row.rx.value
              .asObservable()
              .skip(1)
              .subscribe(onNext: { v in
                expect(v).to(equal(expectedValue))
                done()
              })
              .disposed(by: disposeBag)
            
            let cell = row.cell!
            let textfield = cell.textField!
            textfield.text = expectedValue
            cell.textFieldDidChange(textfield)
          }
          
        }
      }
      
    }
    
  }
}

