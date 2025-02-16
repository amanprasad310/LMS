//
//  Librarian.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import Foundation
import UIKit

struct Librarian: Identifiable {
    var id = UUID()
    let name: String
    let age: Int
    let email: String
    var image: UIImage?
    
    init(id: UUID = UUID(), name: String, age: Int, email: String, image: UIImage? = nil) {
        self.id = id
        self.name = name
        self.age = age
        self.email = email
        self.image = image
    }


    // Function to get librarian details
    func getLibrarianDetails() -> [String: String] {
        return [
            "Name": name,
            "Age": "\(age)",
            "Email": email
        ]
    }
}
