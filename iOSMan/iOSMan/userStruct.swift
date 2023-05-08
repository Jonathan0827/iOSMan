//
//  userStruct.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import Foundation

struct UserData: Codable {
    let login: String
    let id: Int
    let type: String
    let name, company: String?
    let blog: String?
    let location: String?
    let bio: String?
}
