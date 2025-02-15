//
//  DummyData.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import Foundation


let admin = SuperAdmin(name: "John Doe", email: "admin@example.com")

let admin1 = Admin(name: "John Doe", email: "admin@example.com")

let library = Library(
    libraryImage: "library.png",
    libraryDescription: "A large public library with diverse collections.",
    libraryAddress: "123 Library St, City",
    libraryType: .publicLibrary,
    admin: admin1,
    libraryCode: Library.generateLibraryCode()
)

let librarian = Librarian(name: "Alice Smith", age: 35, email: "alice@example.com")


