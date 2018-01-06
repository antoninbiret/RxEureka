//
//  Eureka+Rx.swift
//  Timesheet
//
//  Created by Antonin Biret on 23/01/2017.
//  Copyright © 2017 antoninbiret. All rights reserved.
//

import Eureka
import RxSwift
import RxCocoa

extension RowOf: ReactiveCompatible { }

public extension Reactive where Base: RowOf<String>, Base: RowType {

  public var value: ControlProperty<String?> {
    var base: Base? = self.base
	
    let source = Observable<String?>.create { observer in
      observer.onNext(base?.value)
	
      base?.onChange({ (row) in
        observer.onNext(row.value)
      })

      return Disposables.create {
        base = nil
        observer.onCompleted()
      }
    }
    let bindingObserver = BindableObserver(container: self.base) { (row, value) in
      row.value = value
    }
    return ControlProperty(values: source, valueSink: bindingObserver)
  }

}
