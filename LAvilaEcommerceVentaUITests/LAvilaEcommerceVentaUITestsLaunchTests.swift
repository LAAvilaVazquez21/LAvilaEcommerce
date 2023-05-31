//
//  LAvilaEcommerceVentaUITestsLaunchTests.swift
//  LAvilaEcommerceVentaUITests
//
//  Created by MacBookMBA16 on 30/05/23.
//

import XCTest

final class LAvilaEcommerceVentaUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let validar = app.buttons["INICIAR SESION"]
        XCTAssertTrue(validar.exists)
        validar.tap()
        
        let validar1 = app.buttons["Registrar Usuario"]
        XCTAssertTrue(validar1.exists)
        validar1.tap()
       
        let user = app.textFields["Textuser"]
        //user.exists
        XCTAssertTrue(user.exists)
        user.typeText("laavila21@gmail.com")

        let password = app.textFields["Textpassword"]
        //password.exists
        XCTAssertTrue(password.exists)
        password.typeText("luis210221")

        

//        let attachment = XCTAttachment(screenshot: app.screenshot())
//        attachment.name = "Launch Screen"
//        attachment.lifetime = .keepAlways
//        add(attachment)
    }
}
