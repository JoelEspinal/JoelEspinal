//
//  StringExt.swift
//  BB Quotes
//
//  Created by Joel Espinal on 11/8/24.
//

import Foundation

extension String {
     
    func removeSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpaces() -> String {
        return self.removeSpaces().lowercased()
    }

}
