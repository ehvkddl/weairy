//
//  NotificationView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/24.
//

import SwiftUI

struct NotificationView: View {
    @Binding var showNotificationView: Bool
    
    @State private var isOn: Bool = false
    @State private var wakeUp = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle("날씨 알람 받기", isOn: $isOn)
                .padding(.top, 17)
                .padding(.horizontal, 25)
            
            DatePicker("알림 받을 시간을 설정해주세요.", 
                       selection: $wakeUp,
                       displayedComponents: .hourAndMinute)
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
            .disabled(isOn ? false : true)
            
            HStack {
                Button {
                    withAnimation(.smooth) {
                        showNotificationView = false
                    }
                } label: {
                    Text("취소")
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.gray)
                        }
                }
                
                Button {
                    
                } label: {
                    Text("저장")
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.fancyBlue)
                        }
                }
            }
            .padding(12)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
        }
        .padding(30)
        .clearBackground()
        .backgroundColor(.black.opacity(0.6))
    }
}

#Preview {
    NotificationView(showNotificationView: .constant(true))
}
