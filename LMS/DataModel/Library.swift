//
//  Library.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import Foundation


struct Library {
    let libraryImage: String
    let libraryDescription: String
    let libraryAddress: String
    let libraryType: LibraryType
    let admin: Admin
    let libraryCode: String

    // Enum for Library Type Selection
    enum LibraryType: String {
        case publicLibrary = "Public"
        case privateLibrary = "Private"
    }
    
    // Function to generate a random 4-digit library code
    static func generateLibraryCode() -> String {
        return String(format: "%04d", Int.random(in: 1000...9999))
    }
    
    // Function to view library details
    func viewLibraryDetails() -> [String: String] {
        return [
            "Library Code": libraryCode,
            "Library Type": libraryType.rawValue,
            "Library Description": libraryDescription,
            "Library Address": libraryAddress,
            "Admin Name": admin.name,
            "Admin Email": admin.email
        ]
    }

    // Function to edit library details (returns a new instance with updated values)
    func editLibraryDetails(
        newImage: String? = nil,
        newDescription: String? = nil,
        newAddress: String? = nil,
        newLibraryType: LibraryType? = nil,
        newAdmin: Admin? = nil
    ) -> Library {
        return Library(
            libraryImage: newImage ?? self.libraryImage,
            libraryDescription: newDescription ?? self.libraryDescription,
            libraryAddress: newAddress ?? self.libraryAddress,
            libraryType: newLibraryType ?? self.libraryType,
            admin: newAdmin ?? self.admin,
            libraryCode: self.libraryCode // Keeping the same library code
        )
    }
}
