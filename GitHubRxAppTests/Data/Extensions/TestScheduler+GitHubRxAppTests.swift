//
//  TestScheduler+GitHubRxAppTests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

import Foundation
import RxSwift
import RxTest

extension TestScheduler {
/**
    Creates a `TestableObserver` instance which immediately subscribes to the `source`
    */
   func record<O: ObservableConvertibleType>(
       _ source: O,
       disposeBag: DisposeBag
   ) -> TestableObserver<O.Element> {
       let observer = self.createObserver(O.Element.self)
       source
           .asObservable()
           .bind(to: observer)
           .disposed(by: disposeBag)
       return observer
   }
}
