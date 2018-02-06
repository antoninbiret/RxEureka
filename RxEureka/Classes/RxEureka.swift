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
    let source = Observable<Base.Cell.Value?>.create { [weak base] observer in
      if let _base = base {
        observer.onNext(_base.value)
        _base.onChange({ row in
          observer.onNext(row.value)
        })
      }
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
    let source = Observable<Bool>.create { [weak base] observer in
      if let _base = base {
        observer.onNext(_base.isHighlighted)
        _base.onCellHighlightChanged({ (_, row) in
          observer.onNext(row.isHighlighted)
        })
      }
      return Disposables.create {
        observer.onCompleted()
      }
    }
    let bindingObserver = BindableObserver(container: self.base) { (row, isHighlighted) in
      row.isHighlighted = isHighlighted
    }
    return ControlProperty(values: source, valueSink: bindingObserver)
  }

}
