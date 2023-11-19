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

struct SESMailServiceContext: ServiceContext {

    let eventLoopGroup: EventLoopGroup
    let client: AWSClient
    let region: Region
    let partition: AWSPartition
    let endpoint: String?
    let timeout: TimeAmount?
    let byteBufferAllocator: ByteBufferAllocator

    func createDriver() throws -> ServiceDriver {
        SESMailServiceDriver()
    }
}
