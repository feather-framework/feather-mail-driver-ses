//
//  FeatherMailDriverSESTests.swift
//  FeatherMailDriverSESTests
//
//  Created by Tibor Bodecs on 2023. 01. 16..
//

import NIO
import Logging
import Foundation
import XCTest
import FeatherComponent
import FeatherMail
import FeatherMailDriverSES
import XCTFeatherMail
import SotoCore

final class FeatherMailDriverSESTests: XCTestCase {

    var id: String {
        ProcessInfo.processInfo.environment["SES_ID"]!
    }

    var secret: String {
        ProcessInfo.processInfo.environment["SES_SECRET"]!
    }

    var region: String {
        ProcessInfo.processInfo.environment["SES_REGION"]!
    }

    var from: String {
        ProcessInfo.processInfo.environment["MAIL_FROM"]!
    }

    var to: String {
        ProcessInfo.processInfo.environment["MAIL_TO"]!
    }

    func testSESDriverUsingTestSuite() async throws {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        do {
            let registry = ComponentRegistry()

            let client = AWSClient(
                credentialProvider: .static(
                    accessKeyId: id,
                    secretAccessKey: secret
                ),
                logger: .init(label: "aws")
            )
            try await registry.addMail(
                SESMailComponentContext(
                    eventLoopGroup: eventLoopGroup,
                    client: client,
                    region: .init(rawValue: self.region)
                )
            )

            let mail = try await registry.mail()

            do {
                let suite = MailTestSuite(mail)
                try await suite.testAll(from: from, to: to)

                try await client.shutdown()
            }
            catch {
                try await client.shutdown()
                throw error
            }

        }
        catch {
            XCTFail("\(error)")
        }

        try await eventLoopGroup.shutdownGracefully()
    }

}
