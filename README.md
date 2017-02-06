# RxEureka

[![CI Status](http://img.shields.io/travis/antoninbiret/RxEureka.svg?style=flat)](https://travis-ci.org/antoninbiret/RxEureka)
[![Version](https://img.shields.io/cocoapods/v/RxEureka.svg?style=flat)](http://cocoapods.org/pods/RxEureka)
[![License](https://img.shields.io/cocoapods/l/RxEureka.svg?style=flat)](http://cocoapods.org/pods/RxEureka)
[![Platform](https://img.shields.io/cocoapods/p/RxEureka.svg?style=flat)](http://cocoapods.org/pods/RxEureka)

This library is a small Rx wrapper around [__Eureka__](https://eurekacommunity.github.io)

**Table of contents:**

1. Observing row value changes
2. Binding row value changes to variables
3. Example app
4. Requirements
5. Installation
6. Author
7. License
8. References

## Observing row value changes

RxEureka can be used to create `Observable`s from the value property of `Eureka`'s rows :

```swift
let row = TextRow() { row in
     row.title = "Text Row"
     row.placeholder = "Enter text here"
   }

let disposeBag = DisposeBag()

row
  .asObservable()
  .subscribe(onNext: { value in
    print("Row value did change to \(value)")
  })
  .addDisposableTo(disposeBag)
```

## Binding row value changes to variables

With RxEureka you can also bind the `Eureka`'s rows values to your variables :

```swift
let row = TextRow() { row in
     row.title = "Text Row"
     row.placeholder = "Enter text here"
   }

let myVariable: Variable<String?> = Variable(nil)

let disposeBag = DisposeBag()

row.rx.value
  .asObservable()
  .bindTo(myVariable)
  .addDisposableTo(disposeBag)
```

## Example app

To run the example project, clone the repo, and run `pod install` from the Example directory first.
The app uses`RxSwift`, `RxCocoa` to observe values from `Eureka`.

## Requirements

* Xcode 8.x
* Swift 3.0

## Installation

RxEureka is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RxEureka", :git => 'git@github.com/antoninbiret/RxEureka', :branch => 'master'
```

Tested with version __1.2.0__

## Author

__Antonin Biret__
* https://twitter.com/Antonin_brt
* https://github.com/antoninbiret

## License

RxEureka is available under the MIT license. See the [LICENSE file](LICENSE.md) for more info.

## References

* [https://github.com/xmartlabs/Eureka](https://github.com/xmartlabs/Eureka)
* [https://github.com/ReactiveX/RxSwift](https://github.com/ReactiveX/RxSwift)
