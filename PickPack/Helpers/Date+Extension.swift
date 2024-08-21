//
//  Date+Extension.swift
//  PickPack
//
//  Created by sseungwonnn on 8/22/24.
//

import Foundation

extension Date {
    /// Date 타입을 "2025.02.12 (월)" 형식의 문자열로 반환합니다.
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd (E)"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func getDuration(to: Date) -> String {
        // Calendar 객체 생성
        let calendar = Calendar.current
        
        // 날짜 차이 계산
        let components = calendar.dateComponents([.day], from: self, to: to)
        
        // 차이의 일(day) 값이 nil이 아니고 0 이상인 경우 처리
        guard let dayDifference = components.day, dayDifference > 0 else {
            return "0박 1일"
        }
        
        // 몇 박 며칠인지 계산
        let nights = dayDifference - 1
        let days = dayDifference
        
        return "\(nights)박 \(days)일"
    }

}
