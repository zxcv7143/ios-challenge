//
//  MockAdListRouter.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
@testable import Ads
import UIKit

class MockAdListRouter: AdListRouterProtocol {
    
    var goToDetailAdCalled = false
    var goToMapViewCalled = false
    
    static func createAdListModule() -> UIViewController {
        return UIViewController()
    }
    
    func goToDetailAd(currentViewController: (any AdListViewControllerProtocol)?, ad: Ad) {
        goToDetailAdCalled = true
    }
    
    func goToMapView(currentViewController: (any AdListViewControllerProtocol)?, ad: [Ad]) {
        goToMapViewCalled = true
    }
}
