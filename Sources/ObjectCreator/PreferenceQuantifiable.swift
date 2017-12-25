//
//  ViabilityScoreable.swift
//  ObjectCreatorPackageDescription
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation

protocol PreferenceQuantifiable {
    
    var preference: Double { get }
}

extension PreferenceQuantifiable {
    
    func isPrefered(over other: PreferenceQuantifiable) -> Bool {
        
        return preference > other.preference
    }
}
