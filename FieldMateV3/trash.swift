//
//  trash.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 09/05/25.
//

//MARK: - TRASHCODE
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
    //                    // MARK: - Walkie-Talkie
    //                    ZStack {
    //
    //                        Image("WalkyTalkieV2")
    //                            .resizable()
    //                            .frame(width: 400, height: 950)
    //                            .offset(x: -0, y: 200)
    //
    //                        Image(systemName: "house.fill")
    //                            .resizable()
    //                            .foregroundStyle(.white)
    //                            .frame(width: 25, height: 25)
    //                            .padding(.top, -160)
    //                            .padding(.leading, 230)
    //
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
    //                                        if selectedMode == "eksporPDF" {
    //                                            Text("Laporan berhasil diekspor.")
    //                                                .onAppear {
    //                                                    exportToPDF()
    //                                                }                                }else if selectedMode == "cekLaporan" {
    //                                                    Text("\(formattedDate(date)) – \(formattedTime(date))")
    //                                                        .font(.system(size: 18, weight: .semibold, design: .default))
    //                                                        .foregroundColor(.white)
    //
    //                                                    HStack(spacing: -6) {
    //                                                        Text("Pilih Lokasi : ")
    //                                                            .font(.headline)
    //                                                            .foregroundStyle(.white)
    //
    //                                                        Picker("Pilih Lokasi", selection: $selectedTempat) {
    //                                                            ForEach(pilihanTempat, id: \.self) { tempat in
    //                                                                Text(tempat)
    //                                                            }
    //                                                            .foregroundColor(Color.white)
    //                                                        }
    //                                                        .pickerStyle(.menu)
    //                                                        .font(.title2)
    //
    //
    //
    //                                                    }
    //
    //                                                    //MARK: - ReportCard
    //                                                    reportCard(icon: "map", title: "Lokasi", content: parseReport.lokasi)
    //                                                    reportCard(icon: "exclamationmark.circle", title: "Kerusakan", content: parseReport.kerusakan)
    //                                                    reportCard(icon: "face.dashed", title: "Akibat", content: parseReport.akibat)
    //                                                    reportCard(icon: "magnifyingglass", title: "Tindakan", content: parseReport.tindakan)
    //
    //
    //                                                    Text("Bukti Pengerjaan")
    //                                                        .font(.system(size: 18, weight: .bold, design: .default))
    //                                                        .padding(.top)
    //                                                        .foregroundStyle(.white)
    //
    //                                                    if let image = selectedImage {
    //                                                        Image(uiImage: image)
    //                                                            .resizable()
    //                                                            .scaledToFill()
    //                                                            .frame(height: 150)
    //                                                            .clipped()
    //                                                            .cornerRadius(12)
    //                                                    } else {
    //                                                        RoundedRectangle(cornerRadius: 12)
    //                                                            .fill(Color("YellowReport"))
    //                                                            .frame(height: 150)
    //                                                            .overlay(
    //                                                                Text("Belum ada foto")
    //                                                                    .foregroundColor(.gray)
    //                                                            )
    //                                                    }
    //
    //                                                }else if selectedMode == "riwayatLaporan" {
    //                                                    Text("Riwayat Laporan")
    //                                                        .foregroundColor(.white)
    //                                                        .font(.system(size: 20, weight: .bold))
    //                                                        .multilineTextAlignment(.center)
    //                                                        .padding(.horizontal, 16)
    //                                                        .padding(.top, 10)
    //
    //                                                    HistoryCard(title: "\(formattedDate(date))", content: report.lokasi, icon: "hand.rays.fill")
    //
    //                                                }else {
    //
    //                                                    let displayText = speechRecognizer.transcribedText.isEmpty ? "Laporkan Maintenance" : speechRecognizer.transcribedText
    //
    //                                                    Text(displayText)
    //                                                        .foregroundColor(.white)
    //                                                        .font(.system(size: 20, weight: .bold))
    //                                                        .multilineTextAlignment(.center)
    //                                                        .padding(.horizontal, 16)
    //                                                        .padding(.top, 10)
    //
    //                                                }
    //
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
    //
    //                                    Button(action: {
    //                                        selectedMode = "cekLaporan"
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
    //                                        selectedMode = "riwayatLaporan"
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
    //                                        selectedMode = "eksporPDF"
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
    //            //            .navigationDestination(isPresented: $showReportPage) {
    //            //                ContentView(
    //            //                    speechRecognizer: SpeechRecognizer(), date: Date(), report: parseReport(from: speechRecognizer.summaryText)
    //            //                )
    //            //            }
    //            .navigationDestination(isPresented: $showReportPage) {
    //                ContentView(speechRecognizer: speechRecognizer, date: Date(), report: parseReport(from: speechRecognizer.summaryText))
    //            }
    //
    //        }
            
        
        
        
        
        //    private func parseReport(from text: String) -> MaintenanceReport {
        //        func extract(_ key: String) -> String {
        //            let pattern = "\(key):\\s*(.*?)(\\n|$)"
        //            if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
        //                let range = NSRange(text.startIndex..., in: text)
        //                if let match = regex.firstMatch(in: text, options: [], range: range) {
        //                    if let valueRange = Range(match.range(at: 1), in: text) {
        //                        return String(text[valueRange]).trimmingCharacters(in: .whitespacesAndNewlines)
        //                    }
        //                }
        //            }
        //            return "Tidak Ditemukan"
        //        }
        //
        //        let lokasi = extract("Lokasi")
        //        let kerusakan = extract("Kerusakan")
        //        let akibat = extract("Akibat")
        //        let tindakan = extract("Tindakan")
        //
        //        return MaintenanceReport(lokasi: lokasi, kerusakan: kerusakan, akibat: akibat, tindakan: tindakan)
        //    }
