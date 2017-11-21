# RxEureka

[![Build Status](https://travis-ci.org/antoninbiret/RxEureka.svg?branch=master)](https://travis-ci.org/antoninbiret/RxEureka)

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

row.rx.value
  .asObservable()
  .subscribe(onNext: { value in
    print("Row value did change to \(value)")
  })
  .disposed(by: disposeBag)
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
  .bind(to: myVariable)
  .disposed(by: disposeBag)
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
pod "RxEureka", :git => 'https://github.com/antoninbiret/RxEureka.git', :branch => 'master'
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
