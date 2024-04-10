//
//  SESMailComponentDriver.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import FeatherComponent
import SotoSESv2
import SotoCore

struct SESMailComponentFactory: ComponentFactory {

    func build(using config: ComponentConfig) throws -> Component {
        SESMailComponent(config: config)
    }
}
