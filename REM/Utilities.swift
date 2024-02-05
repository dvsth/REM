//
//  Utilities.swift
//  REM
//
//  Created by Dev Seth on 2/4/24.
//

import Foundation

// Utility function to create a Date from year, month, and day
func createDate(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date.now
}
