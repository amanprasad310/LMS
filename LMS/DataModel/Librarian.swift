//
//  Librarian.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import Foundation


struct Librarian {
    let name: String
    let age: Int
    let email: String

    // Function to get librarian details
    func getLibrarianDetails() -> [String: String] {
        return [
            "Name": name,
            "Age": "\(age)",
            "Email": email
        ]
    }
}
