//
//  SettingRoomColorField.swift
//  PickPack
//
//  Created by 추서연 on 8/21/24.
//

import SwiftUI

struct SettingRoomColorField: View {
    @State private var showModal = false
    @State private var selectedColor: Color = .indigo
    var body: some View {
        VStack {
            HStack {
                Text("방 색상")
                    .font(.callout)
                    .padding(.horizontal, 30)
                    .foregroundColor(.black)
                
                Spacer()
                
                ZStack(alignment: .trailing) {
                    HStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedColor)
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .padding(10)
                    }
                    .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 0)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                        .frame(width: 80, height: 44)
                        .onTapGesture {
                            showModal.toggle()
                        }
                    )
                }
                .padding(.horizontal, 15)
            }
            
        }
        .sheet(isPresented: $showModal) {
            ColorPickerView(selectedColor: $selectedColor)
                .presentationDetents(
                    [.medium, .large]
                )
        }
    }
}

struct SettingColorPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedColor: Color // Binding to the parent's color state
    
    var body: some View {
        VStack(alignment: .center) {
            Text("방 색상 선택")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(30)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == .green ? Color.gray : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectColor(.green)
                    }
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.teal)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == .teal ? Color.gray : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectColor(.teal)
                    }
                    .padding(.horizontal,20)
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == .blue ? Color.gray : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectColor(.blue)
                    }
                
            }
            .padding(.bottom)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.indigo)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == .indigo ? Color.gray : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectColor(.indigo)
                    }
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.purple)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == .purple ? Color.gray : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectColor(.purple)
                    }
                    .padding(.horizontal,20)
                
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.pink)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == .pink ? Color.gray : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectColor(.pink)
                    }
            }
            
            Spacer()
        }
        .onChange(of: selectedColor) { 
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func selectColor(_ color: Color) {
        selectedColor = color
    }
}
//
//#Preview {
//    SettingColorPickerView(selectedColor: .constant(.indigo))
//}


#Preview {
    SettingRoomColorField()
}

