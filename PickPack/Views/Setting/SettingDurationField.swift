//
//  SettingDurationField.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//



import SwiftUI
import Combine

struct SettingDurationField: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var showStartDatePicker = false
    @State private var showEndDatePicker = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("여행 기간")
                .font(.callout)
                .padding(.horizontal, 30)
                .foregroundColor(.black)
            
            
            HStack(spacing: 20) {
                HStack {
                    Spacer()
                    VStack {
                        
                        ZStack(alignment: .leading) {
                            Text(dateFormatter.string(from: startDate))
                                .padding()
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 0)
                                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                                )
                                .onTapGesture {
                                    showStartDatePicker.toggle()
                                }
                            
                            if showStartDatePicker {
                                DatePicker(
                                    "",
                                    selection: $startDate,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(.compact)
                                .labelsHidden()
                                .background(Color.white)
                                .onChange(of: startDate) { oldValue, newValue in
                                    showStartDatePicker = false
                                }

                            }
                        }
                    }
                    Text("~")
                    VStack {
                        
                        ZStack(alignment: .leading) {
                            Text(dateFormatter.string(from: endDate))
                                .padding()
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 0)
                                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                                )
                                .onTapGesture {
                                    showEndDatePicker.toggle()
                                }
                            
                            if showEndDatePicker {
                                DatePicker(
                                    "",
                                    selection: $endDate,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(.compact)
                                .labelsHidden()
                                .background(Color.white)
                                .onChange(of: endDate) { oldValue, newValue in
                                    showEndDatePicker = false
                                }                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
                
            }
        }
    }
}

#Preview {
    SettingDurationField()
}
