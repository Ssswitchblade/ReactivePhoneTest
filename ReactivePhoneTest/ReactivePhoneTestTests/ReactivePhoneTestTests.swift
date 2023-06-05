//
//  ReactivePhoneTestTests.swift
//  ReactivePhoneTestTests
//
//  Created by Admin on 05.06.2023.
//

import XCTest
@testable import ReactivePhoneTest

final class ReactivePhoneTestTests: XCTestCase {
    
    let imageWorker = ImageNetworkWorker()

    func testExample() throws {
        
        let expectation = XCTestExpectation()
        
        imageWorker.getImageData("Tests", completion: { result in
            switch result {
            case .success(let data):
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
       wait(for: [expectation], timeout: 5)
       XCTAssertTrue(true)
    }

}
