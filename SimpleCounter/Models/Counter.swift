//
//  Item.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23.
//

import Foundation
import SwiftData

@Model
final class Counter {
    var id = UUID()
    var counterName: String
    var currentValue: Int64 {
        didSet {
            updateDate = Date()
        }
    }
    var increment: Int64
    var hasGoal: Bool
    var valueGoal: Int64
    var creationDate: Date
    var updateDate: Date
    
    init(counterName: String, currentValue: Int64, increment: Int64, hasGoal: Bool, valueGoal: Int64) {
        self.counterName = counterName
        self.currentValue = currentValue
        self.increment = increment
        self.hasGoal = hasGoal
        self.valueGoal = valueGoal
        self.creationDate = Date()
        self.updateDate = Date()
    }
    
    public func stepUp() -> Bool {
        let prevValue = currentValue
        currentValue += increment
        
        return hasGoal && prevValue < valueGoal && currentValue >= valueGoal
    }
    
    public func stepDown() {
        self.currentValue -= self.increment
    }
}
