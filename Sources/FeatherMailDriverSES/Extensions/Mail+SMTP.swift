//
//  File.swift
//
//
//  Created by Tibor Bodecs on 19/11/2023.
//

import Foundation
import FeatherMail

extension Mail.Address {

    /// Returns the MIME representation of the email address.
    var mime: String {
        if let name {
            return "\(name) <\(email)>"
        }
        return email
    }
}

extension Mail {

    /// Creates a unique boundary string for multipart messages.
    /// - Returns: A boundary string.
    func createBoundary() -> String {
        UUID().uuidString
            .replacingOccurrences(of: "-", with: "")
            .lowercased()
    }

    /// Converts the email message to SES format.
    /// - Returns: The email message in SES format.
    func convertToSES() -> String {
        let date = Date()
        let time = date.timeIntervalSince1970

        // NOTE: this is very inefficient
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        let dateFormatted = dateFormatter.string(from: date)

        let uuid = "<\(time)\(from.email.drop { $0 != "@" })>"
        var out: String = ""
        out += "From: \(from.mime)\r\n"
        let toAddresses = to.map(\.mime).joined(separator: ", ")
        out += "To: \(toAddresses)\r\n"
        let ccAddresses = cc.map(\.mime).joined(separator: ", ")
        out += "Cc: \(ccAddresses)\r\n"
        let replyToAddresses = replyTo.map(\.mime).joined(separator: ", ")
        out += "Reply-to: \(replyToAddresses)\r\n"
        out += "Subject: \(subject)\r\n"
        out += "Date: \(dateFormatted)\r\n"
        out += "Message-ID: \(uuid)\r\n"
        if let reference = reference {
            out += "In-Reply-To: \(reference)\r\n"
            out += "References: \(reference)\r\n"
        }

        let boundary = createBoundary()
        if !attachments.isEmpty {
            out += "Content-type: multipart/mixed; boundary=\"\(boundary)\"\r\n"
            out += "Mime-Version: 1.0\r\n\r\n"
        }

        switch body {
        case .plainText(let value):
            if !attachments.isEmpty {
                out += "--\(boundary)\r\n"
            }
            out += "Content-Type: text/plain; charset=\"UTF-8\"\r\n"
            out += "Mime-Version: 1.0\r\n\r\n"
            out += "\(value)\r\n\r\n"
        case .html(let value):
            if !attachments.isEmpty {
                out += "--\(boundary)\r\n"
            }
            out += "Content-Type: text/html; charset=\"UTF-8\"\r\n"
            out += "Mime-Version: 1.0\r\n\r\n"
            out += "\(value)\r\n"
        }

        for attachment in attachments {
            out += "--\(boundary)\r\n"
            out += "Content-type: \(attachment.contentType)\r\n"
            out += "Content-Transfer-Encoding: base64\r\n"
            out +=
                "Content-Disposition: attachment; filename=\"\(attachment.name)\"\r\n\r\n"
            out += "\(attachment.data.base64EncodedString())\r\n"
        }

        out += "\r\n"

        let utf8str = out.data(using: .utf8)
        if let base64Encoded = utf8str?
            .base64EncodedString(
                options: Data.Base64EncodingOptions(rawValue: 0)
            )
        {
            return base64Encoded
        }
        return ""
    }
}
