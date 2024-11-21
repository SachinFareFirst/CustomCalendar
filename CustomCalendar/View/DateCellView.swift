//
//  DateCell.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import SwiftUI

struct DateCell: View {
    var cellDate: Extension
    var body: some View {
        HStack {
            Text(cellDate.getText())
                .fontWeight(cellDate.getFontWeight())
                .foregroundStyle(cellDate.getTextColor())
                .frame(width: UIScreen.main.bounds.width/8, height: UIScreen.main.bounds.height/16)

                .font(.system(size: 15))

        }
        .background(RoundedRectangle(cornerRadius: 2)
            .fill(cellDate.getBackgroundColor()))
    }
}

#Preview {
    DateCell(cellDate:Extension(date: Date(), dateManager: DatePickerViewModel(calendar: .current, minimumDate: Date(), maximumDate: Date(), mode: 1)))
}

