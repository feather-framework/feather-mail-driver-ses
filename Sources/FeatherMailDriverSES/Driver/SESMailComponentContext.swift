//
//  SESMailComponentContext.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import NIO
import SotoCore
import Logging
import FeatherComponent

/// A structure representing the context for the SES mail component.
public struct SESMailComponentContext: ComponentContext {

    /// The event loop group.
    let eventLoopGroup: EventLoopGroup
    /// The AWS client.
    let client: AWSClient
    /// The AWS region.
    let region: Region
    /// The AWS partition.
    let partition: AWSPartition
    /// The endpoint.
    let endpoint: String?
    /// The timeout.
    let timeout: TimeAmount?
    /// The byte buffer allocator.
    let byteBufferAllocator: ByteBufferAllocator

    /// Initializes the SES mail component context.
    /// - Parameters:
    ///   - eventLoopGroup: The event loop group.
    ///   - client: The AWS client.
    ///   - region: The AWS region.
    ///   - partition: The AWS partition. Default is `.aws`.
    ///   - endpoint: The endpoint. Default is nil.
    ///   - timeout: The timeout. Default is nil.
    ///   - byteBufferAllocator: The byte buffer allocator. Default is a new instance.
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

    /// Creates a component factory.
    /// - Throws: An error if the component factory cannot be created.
    /// - Returns: A component factory.
    public func make() throws -> ComponentFactory {
        SESMailComponentFactory()
    }
}
