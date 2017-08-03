import UIKit
import XCTest
import YAlert

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization() {
        let vc = AlertViewController(bannerImageName: nil, title: nil, message: nil, primaryButtonTitle: nil, secondaryButtonTitle: nil)
        XCTAssertNotNil(vc, "not nil")
    }
    
    func testPerformance() {
        self.measure() {
            let vc = AlertViewController(bannerImageName: "test-image", title: "test title", message: "this is a very long test message. this is a very long test message. this is a very long test message. this is a very long test message. this is a very long test message. this is a very long test message. this is a very long test message. this is a very long test message. this is a very long test message. this is a very long test message.", primaryButtonTitle: "Ok", secondaryButtonTitle: "Nevermind")
            vc.present()
        }
    }
    
}
