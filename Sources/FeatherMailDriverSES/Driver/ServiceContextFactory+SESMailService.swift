//
//  ServiceContextFactory+SESMailService.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import NIO
import SotoCore
import FeatherService

public extension ServiceContextFactory {

    static func sesMail(
        eventLoopGroup: EventLoopGroup,
        client: AWSClient,
        region: Region,
        partition: AWSPartition = .aws,
        endpoint: String? = nil,
        timeout: TimeAmount? = nil,
        byteBufferAllocator: ByteBufferAllocator = .init()
    ) -> Self {
        .init {
            SESMailServiceContext(
                eventLoopGroup: eventLoopGroup,
                client: client,
                region: region,
                partition: partition,
                endpoint: endpoint,
                timeout: timeout,
                byteBufferAllocator: byteBufferAllocator
            )
        }
    }
}
