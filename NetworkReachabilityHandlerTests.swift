//
//  NetworkReachabilityHandlerTests.swift
//  SportsAppTests
//
//  Created by Mac on 27/01/2024.
//

import XCTest
@testable import SportsApp
final class NetworkReachabilityHandlerTests: XCTestCase {
    let reachability = NetworkReachabilityHandler()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStartNetworkMonitoringReachable(){
        let expectation = expectation(description: "Test Reachability")
        reachability.startNetworkMonitoring()
        
        XCTAssertTrue(reachability.getReachable(), "Not Reachable")
        expectation.fulfill()
        
    }
    
    
    func testStartNetworkMonitoringShouldFail(){
        
        let expectation = expectation(description: "Test Reachability")
        reachability.startNetworkMonitoring()
        
        
        XCTAssertTrue(reachability.getReachable(), "Not Reachable")
        expectation.fulfill()
        
    }
}
