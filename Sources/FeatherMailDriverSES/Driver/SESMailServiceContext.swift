//
//  SESMailServiceContext.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import NIO
import SotoCore
import Logging
import FeatherService

public struct SESMailServiceContext: ServiceContext {

    let eventLoopGroup: EventLoopGroup
    let client: AWSClient
    let region: Region
    let partition: AWSPartition
    let endpoint: String?
    let timeout: TimeAmount?
    let byteBufferAllocator: ByteBufferAllocator

    public init(
        eventLoopGroup: EventLoopGroup,
        client: AWSClient,
        region: Region,
        partition: AWSPartition = .aws,
        endpoint: String? = nil,
        timeout: TimeAmount? = nil,
        byteBufferAllocator: ByteBufferAllocator = .init()
    ) {
        self.eventLoopGroup = eventLoopGroup
        self.client = client
        self.region = region
        self.partition = partition
        self.endpoint = endpoint
        self.timeout = timeout
        self.byteBufferAllocator = byteBufferAllocator
    }

    public func createDriver() throws -> ServiceDriver {
        SESMailServiceDriver()
    }
}
