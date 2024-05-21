//
//  SESMailComponent.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import Foundation
import FeatherComponent
import FeatherMail
import NIO
import SotoSESv2

/// A structure representing an SES mail component.
@dynamicMemberLookup
struct SESMailComponent {

    /// The configuration for the component.
    let config: ComponentConfig

    /// Retrieves values dynamically from the SES mail component context.
    subscript<T>(
        dynamicMember keyPath: KeyPath<SESMailComponentContext, T>
    ) -> T {
        let context = config.context as! SESMailComponentContext
        return context[keyPath: keyPath]
    }
}

extension SESMailComponent: MailComponent {

    /// Sends an email using SES.
    /// - Parameter email: The email to send.
    /// - Throws: An error if the email could not be sent.
    public func send(_ email: FeatherMail.Mail) async throws {
        let rawMessage = SESv2.RawMessage(
            data: AWSBase64Data.base64(email.convertToSES())
        )
        let request = SESv2.SendEmailRequest(
            content: .init(
                raw: rawMessage
            )
        )

        let ses = SESv2(
            client: self.client,
            region: self.region,
            partition: self.partition,
            endpoint: self.endpoint,
            timeout: self.timeout,
            byteBufferAllocator: self.byteBufferAllocator,
            options: []
        )

        _ = try await ses.sendEmail(
            request,
            logger: logger,
            on: self.eventLoopGroup.next()
        )
    }
}
