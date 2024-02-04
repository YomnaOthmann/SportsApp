//
//  NetworkRequestHandlerTests.swift
//  SportsAppTests
//
//  Created by Mac on 03/02/2024.
//

import XCTest
@testable import SportsApp
final class NetworkRequestHandlerTests: XCTestCase {

    let networkHandler = NetworkRequestHandler()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testfetchLeagues(){
        let expectation = expectation(description: "Test API")

        let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee"
        
        networkHandler.fetchData(url: url) { leagues, error in
            
            if let leagues : Leagues = leagues {
                if error != nil{
                    XCTAssertNil(leagues, "teams are not nil")
                    expectation.fulfill()
                }
                else{
                    XCTAssertNotNil(leagues, "team count are nil")
                    expectation.fulfill()
                }
            }
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchUpcomingEvents(){

        let expectation = expectation(description: "Test API")
        let url = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=3&from=2024-02-02&to=2025-02-02&APIkey=fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee"
        
        networkHandler.fetchData(url: url){ events, error in
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
        
        let expectation = expectation(description: "Test API")
        let url = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=3&from=2023-02-02&to=2025-02-02&APIkey=fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee"
        
        networkHandler.fetchData(url: url){ events, error  in
            guard let events:Events = events else{
                XCTAssertNil(events, "events are not nil")
                expectation.fulfill()
                return
            }
            XCTAssertNotNil(events, "events count are nil")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFetchTeam(){
        
        let expectation = expectation(description: "Test API")
        let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=168&teamId=91&APIkey=fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee"
        
        networkHandler.fetchData(url: url){ teams, error in
           
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
