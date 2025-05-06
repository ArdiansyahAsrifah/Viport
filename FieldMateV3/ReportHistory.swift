//
//  ReportHistory.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 06/05/25.
//

import SwiftUI


struct ReportHistory: View {
    var body: some View {
        ZStack {
            
            // MARK: - Backround
            Color("YellowColor")
                .ignoresSafeArea()
            
            VStack {
                // MARK: - Header
                HStack {
                    Text("Riwayat Laporan")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .padding(.top, -350)
                        .padding(.leading)
                    
                    Image(systemName: "slider.vertical.3")
                        .bold()
                        .font(.system(size: 50))
                        .padding(.top, -360)
                        .padding(.leading, 60)
                }

                // MARK: - Card
                
                
            }
            
            
        }
        
        
        
    }
    
//    private func card(title: String, content: String, icon: String) -> some View {
//        
//    }
    
}

#Preview {
    ReportHistory()
}
