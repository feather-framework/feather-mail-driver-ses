//
//  SESMailComponentDriver.swift
//  FeatherMailDriverSES
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import FeatherComponent
import SotoSESv2
import SotoCore

/// A factory for creating SES mail components.
struct SESMailComponentFactory: ComponentFactory {

    /// Builds a SES mail component using the provided configuration.
    /// - Parameter config: The component configuration.
    /// - Throws: An error if the component cannot be built.
    /// - Returns: A SES mail component.
    func build(using config: ComponentConfig) throws -> Component {
        SESMailComponent(config: config)
    }
}
