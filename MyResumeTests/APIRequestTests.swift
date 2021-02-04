//
//  APIRequestTests.swift
//  MyResumeTests
//
//  Created by Arthur Kleiber on 03/02/2021.
//

import XCTest
import Combine

class APIRequestTests: XCTestCase {
    
    var subscriber: AnyCancellable? = nil
    var publisher: AnyPublisher<APIResponse<Resume>, Error>? = nil
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        subscriber = nil
        publisher = nil
        
        super.tearDown()
    }
    
    func testRequestShouldGet200Success() {
        let expectation = XCTestExpectation(description: "Status code: 200")
        
        publisher = API.fetchResume()
        subscriber = publisher?.sink(receiveCompletion: { (completion) in
            switch (completion) {
            case .failure:
                XCTFail("Error: shouldn't have get request error.")
            case .finished:
                return
            }
        }, receiveValue: { (data) in
            if let httpResponse = data.response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    expectation.fulfill()
                } else {
                    XCTFail("Error: respone status code should have been 200 Success.")
                }
            } else {
                XCTFail("Error: response should have been casted to a HTTPUrlRespnse.")
            }
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRequestShouldGet404RessourceNotFoundError() {
        let expectation = XCTestExpectation(description: "Should get a 404 Ressource Not Found Error.")
        
        publisher = API.request(URL(string: "https://google.com/url_that_doesnt_exist")!, method: .get)
        subscriber = publisher?.sink(receiveCompletion: { (completion) in
            switch (completion) {
            case .failure(let error):
                if let error = error as? RessourceNotFoundError, error.statusCode == 404 {
                    expectation.fulfill()
                } else {
                    XCTFail("Error: the error should be a of type RessourceNotFoundError.")
                }
            case .finished:
                XCTFail("Error: should have get a failure but go success.")
            }
        }, receiveValue: { (data) in
            XCTFail("Error: shouldn't have been able to receive data but got some.")
        })
        
        wait(for: [expectation], timeout: 5)
    }
}
