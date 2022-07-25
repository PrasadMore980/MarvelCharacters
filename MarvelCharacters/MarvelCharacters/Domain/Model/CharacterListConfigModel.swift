//
//  CharacterRequestModel.swift
//  Domain
//
//  Created by Prasad More on 04/07/22.
//

import Foundation

public struct CharacterListConfigModel {
    public let offset: Int
    public let limit: Int
    
    public init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
}
