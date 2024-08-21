//
//  DurationField.swift
//  PickPack
//
//  Created by 추서연 on 8/21/24.
//

import SwiftUI
import Combine

struct DurationField: View {
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
                .foregroundColor(.indigo)
            
            
            HStack(spacing: 20) {
                HStack {
                    VStack {
                        
                        ZStack(alignment: .leading) {
                            Text(dateFormatter.string(from: startDate))
                                .padding()
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 0)
                                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.2)))
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
                                .onChange(of: startDate) { _ in
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
                                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.2)))
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
                                .onChange(of: endDate) { _ in
                                    showEndDatePicker = false
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
                
            }
        }
    }
}

#Preview {
    DurationField()
}
