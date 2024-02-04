//
//  NetworkHandlerWithMockDataTests.swift
//  SportsAppTests
//
//  Created by Mac on 03/02/2024.
//

import XCTest

@testable import SportsApp
final class NetworkHandlerWithMockDataTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testfetchLeagues(){
        let networkMockData = NetworkHandlerWithMockData(hasError: false, resource: "leagueData")
        let expectation = expectation(description: "Test API")
        
        networkMockData.fetchData(url: "") { leagues, error in
            
            if let leagues : Leagues = leagues {
                if error != nil{
                    XCTAssertNotNil(leagues, "teams are nil")
                    expectation.fulfill()
                }
            }else{
                XCTAssertNil(leagues, "team count are not nil")
                expectation.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchUpcomingEvents(){
        let networkMockData = NetworkHandlerWithMockData(hasError: false, resource: "upcomingEventsData")
        let expectation = expectation(description: "Test API")
        
        networkMockData.fetchData(url: ""){ events, error in
            if let events:Events = events {
                XCTAssertNotNil(events, "events count are nil")
                expectation.fulfill()

            }else{
                XCTAssertNil(events, "events are not nil")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchLatestEvents(){
        let networkMockData = NetworkHandlerWithMockData(hasError: false, resource: "latestResultData")
        let expectation = expectation(description: "Test API")
        
        networkMockData.fetchData(url: ""){ events, error  in
            guard let events:Events = events else{
                XCTAssertNil(events, "events are not nil")
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(events, "events count are nil")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchTeam(){
        let networkMockData = NetworkHandlerWithMockData(hasError: false, resource: "teamData")
        let expectation = expectation(description: "Test API")

        networkMockData.fetchData(url: ""){ teams, error in
           
            if let teams : Teams = teams {
                XCTAssertNotNil(teams, "team count are nil")
                expectation.fulfill()
            }
            else{
                XCTAssertNil(teams, "team count are not nil")
                expectation.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
        
    }


}
