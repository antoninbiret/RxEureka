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

extension BaseRow: ReactiveCompatible { }

public extension Reactive where Base: BaseRow, Base: RowType {

  public var value: ControlProperty<Base.Cell.Value?> {
    let source = Observable<Base.Cell.Value?>.create { observer in
      observer.onNext(self.base.value)
      self.base.onChange({ (row) in
        observer.onNext(row.value)
      })
      return Disposables.create {
        observer.onCompleted()
      }
    }
    let bindingObserver = BindableObserver(container: self.base) { (row, value) in
      row.value = value
    }
    return ControlProperty(values: source, valueSink: bindingObserver)
  }

}
