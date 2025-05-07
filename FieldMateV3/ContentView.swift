////
////  ContentView.swift
////  FieldMateV3
////
////  Created by Muhammad Ardiansyah Asrifah on 01/05/25.
////
//
////MARK: - Importing Framework
//import SwiftUI
//import AVFoundation
//import Speech
//import NaturalLanguage
//import TipKit
//
////MARK: - MicTipView
//struct MicTip: Tip {
//    var title: Text {
//        Text("Tekan untuk Merekam")
//    }
//    
//    var message: Text? {
//        Text("Gunakan tombol ini untuk mulai merekam laporan maintenance.")
//    }
//    
//    var image: Image? {
//        Image(systemName: "mic.circle.fill")
//    }
//}
//
////MARK: - FolderTipView
//struct FolderTip: Tip {
//    var title: Text {
//        Text("Lihat Laporan Kamu")
//    }
//    
//    var message: Text? {
//        Text("Jika sudah selesai merekam, tekan tombol ini untuk melihat ringkasan laporan.")
//    }
//    
//    var image: Image? {
//        Image(systemName: "folder.circle.fill")
//    }
//}
//
//
//struct ContentView: View {
//    // MARK: - Variable
//    @State private var showReportPage = false
//    @StateObject private var speechRecognizer = SpeechRecognizer()
//    @State private var micTip = MicTip()
//    @State private var folderTip = FolderTip()
//    @State private var isExpanded = false
//    @State private var navigateToReportCheck = false
//    @State private var selectedMode: String = "default"
//    
//    var body: some View {
//        
//        NavigationStack {
//            ZStack {
//                // MARK: - Backround
//                Color("YellowColor")
//                    .ignoresSafeArea()
//                
//                // MARK: - Header
//                VStack(spacing: 16) {
//                    
//                    VStack {
//                        TipView(micTip)
//                            .offset(x: 0)
//                        TipView(folderTip)
//                            .offset(x: 0)
//                        
//                    }
//                    .padding(.horizontal)
//                    
//                    
//                    // MARK: - Walkie-Talkie
//                    ZStack {
//                        Image("WalkyTalkieV2")
//                            .resizable()
//                            .frame(width: 400, height: 950)
//                            .offset(x: -0, y: 200)
//                        
//                        VStack(spacing: 8) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color("BlueColor"))
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.black, lineWidth: 6)
//                                    )
//                                    .frame(width: 330, height: isExpanded ? 500 : 380)
//
//                                ScrollView {
//                                    VStack(alignment: .center, spacing: 20) {
//                                        Text(speechRecognizer.transcribedText.isEmpty ? "Laporkan Maintenance" : speechRecognizer.transcribedText)
//                                            .foregroundColor(.white)
//                                            .font(.system(size: 20, weight: .bold))
//                                            .multilineTextAlignment(.center)
//                                            .padding(.horizontal, 16)
//                                            .padding(.top, 10)
//
//                                    
//                                    }
//                                    .frame(width: 300)
//                                }
//                                .frame(width: 300, height: isExpanded ? 480 : 360)
//                            }
//                            .offset(x: 5, y: 490)
//
//
//                            
//                            Spacer(minLength: 15)
//                            
//                            HStack {
//                                VStack {
//                                    
//                                    Button(action: {
//                                        if !speechRecognizer.isRecording && !speechRecognizer.transcribedText.isEmpty {
//                                            navigateToReportCheck = true
//                                        } else {
//                                            withAnimation {
//                                                speechRecognizer.toggleRecording()
//                                            }
//                                        }
//                                    }) {
//                                        HStack(spacing: 5) {
//                                            Image(systemName: speechRecognizer.isRecording ? "newspaper.fill" : "newspaper.fill")
//                                                .font(.system(size: 18))
//                                                .padding(.leading, 10)
//                                            
//                                            Text("Cek Laporan")
//                                                .font(.system(size: 15))
//                                                .fontWeight(.bold)
//                                            
//                                        }
//                                        .frame(width: 180, height: 40, alignment: .leading)
//                                        .background(speechRecognizer.isRecording ? Color("BlackColor") : Color("BlackColor"))
//                                        .foregroundColor(.white)
//                                        .cornerRadius(12)
//                                        .padding(.leading, 120)
//                                        
//                                        
//                                    }
//                                    
//                                    Button(action: {
//                                        if !speechRecognizer.isRecording && !speechRecognizer.transcribedText.isEmpty {
//                                            showReportPage = true
//                                        } else {
//                                            withAnimation {
//                                                speechRecognizer.toggleRecording()
//                                            }
//                                        }
//                                    }) {
//                                        HStack(spacing: 8) {
//                                            Image(systemName: speechRecognizer.isRecording ? "clock.fill" : "clock.fill")
//                                                .font(.system(size: 18))
//                                                .padding(.leading, 10)
//                                            
//                                            Text("Riwayat Laporan")
//                                                .font(.system(size: 15))
//                                                .fontWeight(.bold)
//                                        }
//                                        .frame(width: 180, height: 40, alignment: .leading)
//                                        .background(speechRecognizer.isRecording ? Color("BlackColor") : Color("BlackColor"))
//                                        .foregroundColor(.white)
//                                        .cornerRadius(12)
//                                        //                                        .padding(.top, 160)
//                                        .padding(.leading, 120)
//                                    }
//                                    
//                                    Button(action: {
//                                        if !speechRecognizer.isRecording && !speechRecognizer.transcribedText.isEmpty {
//                                            showReportPage = true
//                                        } else {
//                                            withAnimation {
//                                                speechRecognizer.toggleRecording()
//                                            }
//                                        }
//                                    }) {
//                                        HStack(spacing: 10) {
//                                            Image(systemName: speechRecognizer.isRecording ? "doc.fill" : "doc.fill")
//                                                .font(.system(size: 18))
//                                                .padding(.leading, 10)
//                                            
//                                            Text("Ekspor ke PDF")
//                                                .font(.system(size: 15))
//                                                .fontWeight(.bold)
//                                        }
//                                        .frame(width: 180, height: 40, alignment: .leading)
//                                        .background(speechRecognizer.isRecording ? Color("BlackColor") : Color("BlackColor"))
//                                        .foregroundColor(.white)
//                                        .cornerRadius(12)
//                                        //                                        .padding(.top, 160)
//                                        .padding(.leading, 120)
//                                    }
//                                }
//                                .padding(.top, 220)
//                                .padding(.leading, 40)
//                                
//                                
//                                Button(action: {
//                                    withAnimation {
//                                        speechRecognizer.toggleRecording()
//                                        if !speechRecognizer.isRecording {
//                                            speechRecognizer.makeSummary(from: speechRecognizer.transcribedText)
//                                        }
//                                    }
//                                }) {
//                                    HStack {
//                                        Image(systemName: speechRecognizer.isRecording ? "stop.circle.fill" : "mic.circle.fill")
//                                            .font(.system(size: 50))
//                                        
//                                    }
//                                    .frame(width: 134, height: 254)
//                                    .background(speechRecognizer.isRecording ? Color.red : Color("YellowColor"))
//                                    .foregroundColor(.white)
//                                    .cornerRadius(12)
//                                    .padding(.top, 100)
//                                    .padding(.leading, 10)
//                                    
//                                }
//                                
//                                
//                                
//                            }
//                            .padding(.leading, -150)
//                            .padding(.top, 420)
//                            
//                        }
//                    }
//                    .frame(height: 250)
//                    .shadow(radius: 5)
//                    
//                    .padding()
//                    
//                    Spacer()
//                }
//                .padding(.top)
//            }
//            .onAppear {
//                speechRecognizer.requestPermissions()
//            }
//            .navigationDestination(isPresented: $navigateToReportCheck) {
//                ReportCheck(
//                    report: parseReport(from: speechRecognizer.summaryText),
//                    date: Date()
//                )
//            }
//        }
//        
//    }
//    
//    //MARK: - Report Parsing
//    private func parseReport(from text: String) -> MaintenanceReport {
//        func extract(_ key: String) -> String {
//            let pattern = "\(key):\\s*(.*?)(\\n|$)"
//            if let range = text.range(of: pattern, options: .regularExpression) {
//                let line = text[range]
//                if let colonIndex = line.firstIndex(of: ":") {
//                    return String(line[line.index(after: colonIndex)...]).trimmingCharacters(in: .whitespacesAndNewlines)
//                }
//            }
//            return "-"
//        }
//        
//        return MaintenanceReport(
//            lokasi: extract("Lokasi"),
//            kerusakan: extract("Kerusakan"),
//            akibat: extract("Akibat"),
//            tindakan: extract("Tindakan")
//        )
//    }
//    
//}
//
//#Preview {
//    ContentView()
//}
//
//
//
//
//


//
//  ContentView.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 01/05/25.
//

//MARK: - Importing Framework
import SwiftUI
import AVFoundation
import Speech
import NaturalLanguage
import TipKit

//MARK: - MicTipView
struct MicTip: Tip {
    var title: Text {
        Text("Tekan untuk Merekam")
    }
    
    var message: Text? {
        Text("Gunakan tombol ini untuk mulai merekam laporan maintenance.")
    }
    
    var image: Image? {
        Image(systemName: "mic.circle.fill")
    }
}

//MARK: - FolderTipView
struct FolderTip: Tip {
    var title: Text {
        Text("Lihat Laporan Kamu")
    }
    
    var message: Text? {
        Text("Jika sudah selesai merekam, tekan tombol ini untuk melihat ringkasan laporan.")
    }
    
    var image: Image? {
        Image(systemName: "folder.circle.fill")
    }
}


struct ContentView: View {
    // MARK: - Variable
    @State private var showReportPage = false
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var micTip = MicTip()
    @State private var folderTip = FolderTip()
    @State private var isExpanded = false
    @State private var navigateToReportCheck = false
    @State private var selectedMode: String = "default"
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // MARK: - Backround
                Color("YellowColor")
                    .ignoresSafeArea()
                
                // MARK: - Header
                VStack(spacing: 16) {
                    
                    VStack {
                        TipView(micTip)
                            .offset(x: 0)
                        TipView(folderTip)
                            .offset(x: 0)
                        
                    }
                    .padding(.horizontal)
                    
                    
                    // MARK: - Walkie-Talkie
                    ZStack {
                        Image("WalkyTalkieV2")
                            .resizable()
                            .frame(width: 400, height: 950)
                            .offset(x: -0, y: 200)
                        
                        VStack(spacing: 8) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("BlueColor"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 6)
                                    )
                                    .frame(width: 330, height: isExpanded ? 500 : 380)

                                ScrollView {
                                    VStack(alignment: .center, spacing: 20) {
                                        
                                        if selectedMode == "voice" {
                                            Text(speechRecognizer.transcribedText.isEmpty ? "Laporkan Maintenance" : speechRecognizer.transcribedText)
                                                .foregroundColor(.white)
                                                .font(.system(size: 20, weight: .bold))
                                                .multilineTextAlignment(.center)
                                                .padding(.horizontal, 16)
                                                .padding(.top, 10)
                                        }else if selectedMode == "cekLaporan" {
                                            Text("cek laporan")
                                        }else if Selector(selectedMode) == Selector(("riwayatLaporan")) {
                                            Text("riwayat laporan")
                                        }else {
                                            Text("ekspor")
                                        }
                                        
                                        

                                    
                                    }
                                    .frame(width: 300)
                                }
                                .frame(width: 300, height: isExpanded ? 480 : 360)
                            }
                            .offset(x: 5, y: 490)


                            
                            Spacer(minLength: 15)
                            
                            HStack {
                                VStack {
                                    
                                    Button(action: {
                                        selectedMode = "cekLaporan"
                                    }) {
                                        HStack(spacing: 5) {
                                            Image(systemName: speechRecognizer.isRecording ? "newspaper.fill" : "newspaper.fill")
                                                .font(.system(size: 18))
                                                .padding(.leading, 10)
                                            
                                            Text("Cek Laporan")
                                                .font(.system(size: 15))
                                                .fontWeight(.bold)
                                            
                                        }
                                        .frame(width: 180, height: 40, alignment: .leading)
                                        .background(speechRecognizer.isRecording ? Color("BlackColor") : Color("BlackColor"))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        .padding(.leading, 120)
                                        
                                        
                                    }
                                    
                                    Button(action: {
                                        selectedMode = "riwayatLaporan"
                                    }) {
                                        HStack(spacing: 8) {
                                            Image(systemName: speechRecognizer.isRecording ? "clock.fill" : "clock.fill")
                                                .font(.system(size: 18))
                                                .padding(.leading, 10)
                                            
                                            Text("Riwayat Laporan")
                                                .font(.system(size: 15))
                                                .fontWeight(.bold)
                                        }
                                        .frame(width: 180, height: 40, alignment: .leading)
                                        .background(speechRecognizer.isRecording ? Color("BlackColor") : Color("BlackColor"))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        //                                        .padding(.top, 160)
                                        .padding(.leading, 120)
                                    }
                                    
                                    Button(action: {
                                        selectedMode = "eksporPDF"
                                    }) {
                                        HStack(spacing: 10) {
                                            Image(systemName: speechRecognizer.isRecording ? "doc.fill" : "doc.fill")
                                                .font(.system(size: 18))
                                                .padding(.leading, 10)
                                            
                                            Text("Ekspor ke PDF")
                                                .font(.system(size: 15))
                                                .fontWeight(.bold)
                                        }
                                        .frame(width: 180, height: 40, alignment: .leading)
                                        .background(speechRecognizer.isRecording ? Color("BlackColor") : Color("BlackColor"))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        //                                        .padding(.top, 160)
                                        .padding(.leading, 120)
                                    }
                                }
                                .padding(.top, 220)
                                .padding(.leading, 40)
                                
                                
                                Button(action: {
                                    selectedMode = "voice"
                                }) {
                                    HStack {
                                        Image(systemName: speechRecognizer.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                                            .font(.system(size: 50))
                                        
                                    }
                                    .frame(width: 134, height: 254)
                                    .background(speechRecognizer.isRecording ? Color.red : Color("YellowColor"))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .padding(.top, 100)
                                    .padding(.leading, 10)
                                    
                                }
                                
                                
                                
                            }
                            .padding(.leading, -150)
                            .padding(.top, 420)
                            
                        }
                    }
                    .frame(height: 250)
                    .shadow(radius: 5)
                    
                    .padding()
                    
                    Spacer()
                }
                .padding(.top)
            }
            .onAppear {
                speechRecognizer.requestPermissions()
            }
            .navigationDestination(isPresented: $navigateToReportCheck) {
                ReportCheck(
                    report: parseReport(from: speechRecognizer.summaryText),
                    date: Date()
                )
            }
        }
        
    }
    
    //MARK: - Report Parsing
    private func parseReport(from text: String) -> MaintenanceReport {
        func extract(_ key: String) -> String {
            let pattern = "\(key):\\s*(.*?)(\\n|$)"
            if let range = text.range(of: pattern, options: .regularExpression) {
                let line = text[range]
                if let colonIndex = line.firstIndex(of: ":") {
                    return String(line[line.index(after: colonIndex)...]).trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            return "-"
        }
        
        return MaintenanceReport(
            lokasi: extract("Lokasi"),
            kerusakan: extract("Kerusakan"),
            akibat: extract("Akibat"),
            tindakan: extract("Tindakan")
        )
    }
    
}

#Preview {
    ContentView()
}





