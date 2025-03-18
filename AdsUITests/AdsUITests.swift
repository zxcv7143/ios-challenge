//
//  AdListUITests.swift
//  AdListUITests
//
//  Created by Anton Zuev on 13/3/25.
//

import XCTest

final class AdListUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    @MainActor
    func testMapButtonOnList() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 0).buttons["mapButton"].exists)
    }
   
    @MainActor
    func testFavouriteButton() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 0).buttons["favouriteButton"].exists)
    }
    
    @MainActor
    func testNavigationToDetailPage() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).staticTexts.element(boundBy: 0).tap()
        XCTAssert(app.buttons["detailMapButton"].exists)
        XCTAssert(app.buttons["detailFavouriteButton"].exists)
    }
    
    @MainActor
    func testDetailMapView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).staticTexts.element(boundBy: 0).tap()
        app.buttons["detailMapButton"].tap()
        XCTAssert(app.otherElements["mapView"].exists)
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
