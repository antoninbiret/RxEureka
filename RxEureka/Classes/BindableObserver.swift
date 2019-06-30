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
    
    private var _container: ContainerType?
    
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
            guard let _container = self._container else {
                fatalError("No _container in BindableObserver at time of a .Next event")
            }
            self._binding(_container, element)
        case .error:
            self._container = nil
        case .completed:
            self._container = nil
        }
    }
    
    deinit {
        self._container = nil
    }
}
