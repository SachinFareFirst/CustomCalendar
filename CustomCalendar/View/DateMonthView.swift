//
//  DateMonthView.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import SwiftUI

struct DateMonthView: View {
    
    @EnvironmentObject var datePickerManager: DatePickerViewModel
    var monthVM: DateMonthManager
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text(monthVM.getMonthHeader())
                .foregroundStyle(datePickerManager.colors.monthHeaderColor)
            VStack (alignment: .center) {
                ForEach(monthVM.monthsArray, id: \.self) {
                    row in
                    HStack {
                        ForEach(row , id: \.self) {
                            column in
                            if monthVM.isThisMonth(date: column) {
                                DateCell(cellDate: Extension(date: column, dateManager: datePickerManager, isDisabled: !monthVM.isEnabled(date: column), isToday: monthVM.isToday(date: column), isSelected: monthVM.isSpecialDate(date: column), isBetweenStartAndEnd: monthVM.isBetweenStartAndEnd(date: column)))
                                
                                    .onTapGesture {
                                        monthVM.dateTapped(date: column )
                                    }
                            }
                            else {
                                HStack{
                                    Rectangle().fill(.clear)
                                    Spacer()
                                }   .background(RoundedRectangle(cornerRadius: 2)
                                    .fill(.clear))
                                .frame(width: UIScreen.main.bounds.width/8, height: UIScreen.main.bounds.height/16)
                            }
                        }
                    }
                }
            }
        }
    }
    
}


#Preview {
    DateMonthView( monthVM: DateMonthManager(datePickerViewmModel: DatePickerViewModel(calendar: .current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 1), monthOffset: 0)).environmentObject(DatePickerViewModel(calendar: .current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 1))
}
