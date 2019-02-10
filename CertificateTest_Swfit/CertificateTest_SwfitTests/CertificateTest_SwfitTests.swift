//
//  CertificateTest_SwfitTests.swift
//  CertificateTest_SwfitTests
//
//  Created by 이주형 on 11/02/2019.
//  Copyright © 2019 이주형. All rights reserved.
//

import XCTest
@testable import CertificateTest_Swfit

class CertificateTest_SwfitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let  certificate :CertificateTest = CertificateTest()
        do{
            try certificate.getSubjectList{ subject in
                for item in subject{
                    print(item.subject!)
                    print(item.value!)
                }
            }
            
        }catch{
            print("Error")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
