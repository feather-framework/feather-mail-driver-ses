//
//  SESMailService.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import Foundation
import FeatherService
import FeatherMail
import NIO
import SotoSESv2

@dynamicMemberLookup
struct SESMailService {

    let config: ServiceConfig

    subscript<T>(
        dynamicMember keyPath: KeyPath<SESMailServiceContext, T>
    ) -> T {
        let context = config.context as! SESMailServiceContext
        return context[keyPath: keyPath]
    }

    init(config: ServiceConfig) {
        self.config = config
    }
}

extension SESMailService: MailService {

    public func send(_ email: FeatherMail.Mail) async throws {
        let rawMessage = SESv2.RawMessage(
            data: AWSBase64Data.base64(email.convetToSES())
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
