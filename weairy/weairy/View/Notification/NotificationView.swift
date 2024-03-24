//
//  NotificationView.swift
//  weairy
//
//  Created by do hee kim on 2024/03/24.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var vm: NotificationViewModel
    
    @Binding var showNotificationView: Bool
    @Binding var isNotificationEnabled: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle("날씨 알람 받기", isOn: $vm.isNotificationEnabled)
                .padding(.top, 17)
                .padding(.horizontal, 25)
            
            DatePicker("알림 받을 시간을 설정해주세요.", 
                       selection: $vm.notificationTime,
                       displayedComponents: .hourAndMinute)
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
            .disabled(vm.isNotificationEnabled ? false : true)
            
            HStack {
                Button {
                    showNotificationView = false
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
                    vm.saveNotification()
                    
                    isNotificationEnabled = vm.isNotificationEnabled
                    showNotificationView = false
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
        .onAppear {
            vm.isNotificationEnabled = isNotificationEnabled
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
    NotificationView(
        vm: .init(services: StubServices()),
        showNotificationView: .constant(true), 
        isNotificationEnabled: .constant(false)
    )
}
