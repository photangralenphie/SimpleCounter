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
    var _id = UUID()
    var _counterName: String
    var _currentValue: Int64 {
        didSet {
            _updateDate = Date()
        }
    }
    var _increment: Int64
    var _hasGoal: Bool
    var _valueGoal: Int64
    var _creationDate: Date
    var _updateDate: Date
    
    init(counterName: String, currentValue: Int64, increment: Int64, hasGoal: Bool, valueGoal: Int64) {
        _counterName = counterName
        _currentValue = currentValue
        _increment = increment
        _hasGoal = hasGoal
        _valueGoal = valueGoal
        _creationDate = Date()
        _updateDate = Date()
    }
    
    public func stepUp() {
        _currentValue += _increment
    }
    
    public func stepDown() {
        _currentValue -= _increment
    }
}
