//
//  ColorSetting.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import SwiftUI
import Foundation

class ColorSetting {
    
    // foreground colors
    @Published var textColor: Color = Color.primary
    @Published var todayColor: Color = Color.startAndEnd
    @Published var selectedColor: Color = Color.white
    @Published var disabledColor: Color = Color.gray
    @Published var betweenStartAndEndColor: Color = Color.white
    
    // background colors
    @Published var textBackColor: Color = Color.cellBackground
    @Published var todayBackColor: Color = Color.cellBackground
    @Published var selectedBackColor: Color = Color.startAndEnd
    @Published var disabledBackColor: Color = Color.cellBackground.opacity(0.7)
    @Published var betweenStartAndEndBackColor: Color = Color.dateRange
    
    // headers foreground colors
    @Published var weekdayHeaderColor: Color = Color.primary
    @Published var monthHeaderColor: Color = Color.primary
    
    // headers background colors
    @Published var weekdayHeaderBackColor: Color = Color.clear
    @Published var monthBackColor: Color = Color.clear
    
}
