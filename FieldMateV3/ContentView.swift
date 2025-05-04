//
//  ContentView.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 01/05/25.
//

import SwiftUI
import AVFoundation
import Speech
import NaturalLanguage
import TipKit

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
    @State private var showReportPage = false
    @StateObject private var speechRecognizer = SpeechRecognizer()

    @State private var micTip = MicTip()
    @State private var folderTip = FolderTip()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // Backround
                Color("YellowColor")
                    .ignoresSafeArea()

                // Header
                VStack(spacing: 16) {

                    VStack {
                        TipView(micTip)
                            .offset(x: 0)
                        TipView(folderTip)
                            .offset(x: 0)
                        Text("Laporkan")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Maintenance")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.brown)
                    .padding(.horizontal)

                    // Area Laporan
                    ZStack(alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("YellowReport"))
                            .frame(height: 180)

                        ScrollView {
                            Text(speechRecognizer.transcribedText.isEmpty ? "..." : speechRecognizer.transcribedText)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(height: 180)

                        Text("Rekaman Laporan Kamu")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                    .padding(.horizontal)

                    
                    
                    // Walkie-Talkie
                    ZStack {
                        Image("WalkieTalkieComp")
                            .resizable()
                                    .frame(width: 250, height: 500)
                                    .offset(x: -0, y: 150)
                            
                        VStack(spacing: 8) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green.opacity(0.7))
                                .overlay(
                                    Text(speechRecognizer.isRecording ? "••••" : "82.33")
                                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                                        .foregroundColor(.black)
                                )
                                .frame(width: 200, height: 100)
                                .offset(x: -0, y: 140)

                            HStack {
                                Button(action: {
                                    if !speechRecognizer.isRecording && !speechRecognizer.transcribedText.isEmpty {
                                        showReportPage = true
                                    } else {
                                        withAnimation {
                                            speechRecognizer.toggleRecording()
                                        }
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: speechRecognizer.isRecording ? "folder.circle.fill" : "folder.circle.fill")
                                            .font(.system(size: 30))
                                    }
                                    .frame(width: 80, height: 40)
                                    .background(speechRecognizer.isRecording ? Color("GrayColor") : Color("GrayColor"))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .padding(.top, 160)
                                    .padding(.leading, 120)
                                }
                                

                                
                                Button(action: {
                                    withAnimation {
                                        speechRecognizer.toggleRecording()
                                        if !speechRecognizer.isRecording {
                                                    // Proses ringkasan ketika selesai merekam
                                                    speechRecognizer.makeSummary(from: speechRecognizer.transcribedText)
                                                }
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: speechRecognizer.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                                            .font(.system(size: 30))

                                    }
                                    .frame(width: 80, height: 40)
                                    .background(speechRecognizer.isRecording ? Color.red : Color("YellowColor"))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .padding(.top, 160)
                                    .padding(.leading, 10)

                                }
                                
                                
                                
                            }
                            .padding(.leading, -120)
                            .padding(.top, -10)
                            
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
            .navigationDestination(isPresented: $showReportPage) {
                        MaintenanceReportView(
                            report: parseReport(from: speechRecognizer.summaryText),
                            date: Date()
                        )
            }
        }
       
    }
    
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
