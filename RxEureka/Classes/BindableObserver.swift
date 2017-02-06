//
//  BindableObserver.swift
//  Pods
//
//  Created by Antonin Biret on 06/02/2017.
//
//

import Foundation
import RxSwift

public class BindableObserver<ContainerType, ValueType>: ObserverType {
  
  private let _container: ContainerType
  
  private let _binding: (ContainerType, ValueType) -> Void
  
  public init(container: ContainerType, binding: @escaping (ContainerType, ValueType) -> Void) {
    self._container = container
    self._binding = binding
  }
  
  /**
   Binds next element
   */
  public func on(_ event: Event<ValueType>) {
    switch event {
    case .next(let element):
      self._binding(self._container, element)
    case .error: break
    case .completed: break
    }
  }
  
}
