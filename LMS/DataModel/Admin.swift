//
//  Admin.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import Foundation

struct Admin {
    let name: String
    let email: String
    
    func getSuperAdminDetails() -> [String] {
        return [name,email]
       }
}


