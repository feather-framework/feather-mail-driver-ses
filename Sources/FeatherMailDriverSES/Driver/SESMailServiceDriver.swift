//
//  SESMailServiceDriver.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import FeatherService
import SotoSESv2
import SotoCore

struct SESMailServiceDriver: ServiceDriver {

    func run(using config: ServiceConfig) throws -> Service {
        SESMailService(config: config)
    }
}
