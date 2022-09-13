//
//  Coffee.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import Foundation


struct Coffee : Equatable{
    
    var name  : String
    var icon  : String?
    var price : Float
    
    static func == (lhs : Coffee , rhs : Coffee) -> Bool{
        return lhs.name == rhs.name
    }
    
}
