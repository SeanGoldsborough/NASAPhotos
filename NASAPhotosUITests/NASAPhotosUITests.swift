//
//  NASAPhotosUITests.swift
//  NASAPhotosUITests
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import XCTest
var app: XCUIApplication!

class NASAPhotosUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavBarTitle() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let navTitleIdentifier = "NASA Photos"
        let navigationTitleElement = app.navigationBars.matching(identifier: navTitleIdentifier).firstMatch
        XCTAssert(navigationTitleElement.exists)
                                                                
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
