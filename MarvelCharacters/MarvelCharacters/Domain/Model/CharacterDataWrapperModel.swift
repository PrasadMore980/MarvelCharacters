//
//  CharacterDataWrapperModel.swift
//  MarvelCharacters
//
//  Created by Prasad More on 18/07/22.
//

import Foundation
public struct CharacterDataWrapper: Equatable {
    public let code: Int?
    public let status: String?
    public let data: CharacterListEntity?
    
    public init(code: Int?, status: String?, data: CharacterListEntity?) {
        self.code = code
        self.status = status
        self.data = data
    }

}

