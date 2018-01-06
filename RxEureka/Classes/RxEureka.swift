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
    let source = Observable<String?>.create { observer in
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

  public var isHighlighted: ControlProperty<Bool> {
    var base: Base? = self.base

    let source = Observable<Bool>.create { observer in
      observer.onNext(base?.isHighlighted ?? false)

      base?.onCellHighlightChanged({ (_, row) in
        observer.onNext(row.isHighlighted)
      })

      return Disposables.create {
        base = nil
        observer.onCompleted()
      }
    }
    let bindingObserver = BindableObserver(container: self.base) { (row, isHighlighted) in
      row.isHighlighted = isHighlighted
    }
    return ControlProperty(values: source, valueSink: bindingObserver)
  }

}
