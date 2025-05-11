////
////  ReportCheck.swift
////  FieldMateV3
////
////  Created by Muhammad Ardiansyah Asrifah on 07/05/25.
//
//
////MARK: - Importing Framework
//import SwiftUI
//import AVFoundation
//import Speech
//import NaturalLanguage
//import TipKit
//
//
//struct ReportCheck: View {
//    // MARK: - Variable
//    @State private var showReportPage = false
//    @StateObject private var speechRecognizer = SpeechRecognizer()
//    @State private var micTip = MicTip()
//    @State private var folderTip = FolderTip()
//    @State private var isExpanded = false
//    
//    var report: MaintenanceReport
//    var date: Date
//    
//    @State private var selectedImage: UIImage?
//    @State private var isShowingImagePicker = false
//    @State private var showCamera = false
//    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
//    @State private var selectedTempat: String = ""
//    let pilihanTempat = [
//        "Apple Developer Academy",
//        "Purwadika School",
//        "Traveloka Campuss",
//        "Sinar Mas Group",
//        "Grha Unilever"
//    ]
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
//                                        
//                                        Text("\(formattedDate(date)) – \(formattedTime(date))")
//                                            .font(.system(size: 18, weight: .semibold, design: .default))
//                                            .foregroundColor(.white)
//                                        
//                                        HStack(spacing: 8) {
//                                            Text("Pilih Lokasi : ")
//                                                .font(.headline)
//                                                .foregroundStyle(.white)
//
//                                            Picker("Pilih Lokasi", selection: $selectedTempat) {
//                                                ForEach(pilihanTempat, id: \.self) { tempat in
//                                                    Text(tempat)
//                                                }
//                                            }
//                                            .pickerStyle(.menu)
//                                            .font(.title2)
//                                            .padding(.leading, -20)
//                                        }
//                                        .padding(.leading, -140)
//                                        
//                                        //MARK: - ReportCard
//                                        reportCard(icon: "map", title: "Lokasi", content: report.lokasi)
//                                        reportCard(icon: "exclamationmark.circle", title: "Kerusakan", content: report.kerusakan)
//                                        reportCard(icon: "face.dashed", title: "Akibat", content: report.akibat)
//                                        reportCard(icon: "magnifyingglass", title: "Tindakan", content: report.tindakan)
//                                        
//                                    
//                                        Text("Bukti Pengerjaan")
//                                            .font(.system(size: 18, weight: .bold, design: .default))
//                                            .padding(.top)
//                                            .foregroundStyle(.white)
//                                        
//                                        if let image = selectedImage {
//                                            Image(uiImage: image)
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(height: 150)
//                                                .clipped()
//                                                .cornerRadius(12)
//                                        } else {
//                                            RoundedRectangle(cornerRadius: 12)
//                                                .fill(Color("YellowReport"))
//                                                .frame(height: 150)
//                                                .overlay(
//                                                    Text("Belum ada foto")
//                                                        .foregroundColor(.gray)
//                                                )
//                                        }
//                                        
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
//                                    Button(action: {
//                                        if !speechRecognizer.isRecording && !speechRecognizer.transcribedText.isEmpty {
//                                            showReportPage = true
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
//            .navigationDestination(isPresented: $showReportPage) {
//                MaintenanceReportView(
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
//    //MARK: - Date Format
//    private func formattedDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE, dd MMMM yyyy"
//        formatter.locale = Locale(identifier: "id_ID")
//        return formatter.string(from: date)
//    }
//
//    //MARK: - Time Format
//    private func formattedTime(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH.mm"
//        return formatter.string(from: date)
//    }
//    
//    //MARK: - Report Card Function
//    private func reportCard(icon: String, title: String, content: String) -> some View {
//        HStack(alignment: .top, spacing: 12) {
//            Image(systemName: icon)
//                .font(.title)
//                .frame(width: 20)
//                .foregroundColor(.gray)
//            VStack(alignment: .leading) {
//                Text(title)
//                    .font(.headline)
//                Text(content)
//                    .font(.body)
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(Color("YellowReport"))
//        .cornerRadius(12)
//    }
//    
//    //MARK: - Export To PDF Function
//    private func exportToPDF() {
//        let image = self.body.snapshot()
//        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: image.size))
//        
//        let pdfData = pdfRenderer.pdfData { context in
//            context.beginPage()
//            image.draw(at: .zero)
//        }
//        
//        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("MaintenanceReport.pdf")
//        
//        do {
//            try pdfData.write(to: tempURL)
//            let av = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
//            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
//        } catch {
//            print("Failed to write PDF data: \(error)")
//        }
//    }
//    
//}
//
//#Preview {
//    ReportCheck(
//        report: MaintenanceReport(
//            lokasi: "Ruang Server Lt. 2",
//            kerusakan: "AC Tidak Dingin",
//            akibat: "Ruangan Terlalu Panas",
//            tindakan: "Membersihkan filter dan isi ulang freon"
//        ),
//        date: Date()
//    )
//}
//
//
//// MARK: - ALLAHUAKBARRRR
//
