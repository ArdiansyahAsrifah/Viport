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


//MARK: - Variable Report
struct MaintenanceReport {
    var lokasi: String
    var kerusakan: String
    var akibat: String
    var tindakan: String
}



struct ContentView: View {
    // MARK: - Variable
    @State private var showReportPage = false
    @State private var isExpanded = false
    @State private var navigateToReportCheck = false
    @State private var selectedMode: String = "default"
    
    @ObservedObject var speechRecognizer: SpeechRecognizer
    @State var date: Date
    
    @State private var parsedReport: MaintenanceReport = MaintenanceReport(lokasi: "", kerusakan: "", akibat: "", tindakan: "")

    
    var report: MaintenanceReport
    
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var showCamera = false
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedTempat: String = ""
    let pilihanTempat = [
        "Apple Developer Academy",
        "Purwadika School",
        "Traveloka Campuss",
        "Sinar Mas Group",
        "Grha Unilever"
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("YellowColor").ignoresSafeArea()
                
                VStack(spacing: 16) {
                    headerView
                    Spacer()
                }
                .padding(.top)
            }
            .onAppear {
                speechRecognizer.requestPermissions()
            }
            .onChange(of: speechRecognizer.transcribedText) { newValue in
                parsedReport = parseReport(from: newValue)
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $selectedImage, sourceType: imagePickerSource)
            }
            .navigationDestination(isPresented: $showReportPage) {
                ContentView(
                    speechRecognizer: speechRecognizer,
                    date: Date(),
                    report: parsedReport
                )
            }
        }
    }
    
    var headerView: some View {
        ZStack {
            Image("WalkyTalkieV2")
                .resizable()
                .frame(width: 400, height: 950)
                .offset(x: 0, y: 200)
            
            mainCardView
        }
        .frame(height: 250)
        .shadow(radius: 5)
        .padding()
    }
    
//    var mainCardView: some View {
//        VStack(spacing: 8) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color("BlueColor"))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.black, lineWidth: 6)
//                    )
//                    .frame(width: 330, height: isExpanded ? 500 : 380)
//                
//                ScrollView {
//                    VStack(alignment: .center, spacing: 20) {
//                        contentForSelectedMode()
//                    }
//                    .frame(width: 300)
//                }
//                .frame(width: 300, height: isExpanded ? 480 : 360)
//                
//                
//            }
//            .offset(x: 5, y: 490)
//            
//            Spacer(minLength: 15)
//            bottomControls
//        }
//    }
    
    var mainCardView: some View {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("BlueColor"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 6)
                        )
                        .frame(width: isExpanded ? 500 : 330, height: isExpanded ? 1300 : 380)

                    ScrollView {
                        VStack(alignment: .center, spacing: 20) {
                            contentForSelectedMode()
                        }
//                        .frame(width: 300)
                    }
                    .frame(width: isExpanded ? 370 : 300, height: isExpanded ? 480 : 360)
                }
                .offset(x: 5, y: 500)
                
                
                Button(action: {
                    
                    isExpanded.toggle()
                }) {
                    Image(systemName: isExpanded ? "house.fill" : "rectangle.expand.diagonal")
                        .font(isExpanded ? .title : .title2)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.clear)
                .cornerRadius(8)
                .offset(x: isExpanded ? 0 : 115, y: isExpanded ? 300 : 52)
                
                bottomControls
            }
            .animation(.easeInOut(duration: 0.3), value: isExpanded) 
        }
    
    func contentForSelectedMode() -> some View {
        Group {
            if selectedMode == "eksporPDF" {
                let displayText = speechRecognizer.transcribedText.isEmpty ? "Laporkan Maintenance" : speechRecognizer.transcribedText
                Text(displayText)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
            } else if selectedMode == "cekLaporan" {
                cekLaporanView
            } else if selectedMode == "riwayatLaporan" {
                riwayatView
            } else {
                let displayText = speechRecognizer.transcribedText.isEmpty ? "Laporkan Maintenance" : speechRecognizer.transcribedText
                Text(displayText)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
            }
        }
    }
    
    var cekLaporanView: some View {
        VStack(spacing: 10) {
            DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
                    .colorInvert()
                    .padding(.horizontal)
                    .padding(.top, 10)

            HStack(spacing: -6) {
                Text("Pilih Lokasi : ")
                    .font(.headline)
                    .foregroundStyle(.white)

                Picker("Pilih Lokasi", selection: $selectedTempat) {
                    ForEach(pilihanTempat, id: \.self) { tempat in
                        Text(tempat)
                          
                    }
                }
                .pickerStyle(.menu)
                .font(.title2)
               
            }

            reportCard(icon: "map", title: "Lokasi", content: $parsedReport.lokasi)
            reportCard(icon: "exclamationmark.circle", title: "Kerusakan", content: $parsedReport.kerusakan)
            reportCard(icon: "face.dashed", title: "Akibat", content: $parsedReport.akibat)
            reportCard(icon: "magnifyingglass", title: "Tindakan", content: $parsedReport.tindakan)

            Text("Bukti Pengerjaan")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)

            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(12)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("YellowReport"))
                    .frame(height: 150)
                    .overlay(
                        Text("Belum ada foto")
                            .foregroundColor(.gray)
                    )
            }
            
            HStack(spacing: 16) {
                Button(action: {
                    imagePickerSource = .camera
                    isShowingImagePicker = true
                }) {
                    VStack {
                        Image(systemName: "camera")
                            .font(.title2)
                        Text("Kamera")
                            .font(.caption)
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                
                Button(action: {
                    imagePickerSource = .photoLibrary
                    isShowingImagePicker = true
                }) {
                    VStack {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title2)
                        Text("Galeri")
                            .font(.caption)
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
            
            Button(action: {
                exportToPDF()
            }) {
                Label("Ekspor Ke PDF", systemImage: "doc.fill")
                    .font(.subheadline)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .frame(width: 300, height: 150)
            .padding(.top, -50)
        }
        
    }

    
    var riwayatView: some View {
        VStack(spacing: 10) {
            Text("Riwayat Laporan")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.top, 10)
            
            HistoryCard(title: "\(formattedDate(date))", content: selectedTempat, icon: "hand.rays.fill")
        }
    }
    
    var bottomControls: some View {
        HStack {
            VStack {
                actionButton(icon: "newspaper.fill", label: "Cek Laporan", mode: "cekLaporan")
                actionButton(icon: "clock.fill", label: "Riwayat Laporan", mode: "riwayatLaporan")
                actionButton(icon: "house.fill", label: "Beranda", mode: "eksporPDF")
            }
            .padding(.top, 220)
            .padding(.leading, 40)
            
            Button(action: {
                withAnimation {
                    speechRecognizer.toggleRecording()
                    if !speechRecognizer.isRecording {
                        parsedReport = parseReport(from: speechRecognizer.transcribedText)
                    }
                }
            }) {
                Image(systemName: speechRecognizer.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                    .font(.system(size: 50))
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
    
    func actionButton(icon: String, label: String, mode: String) -> some View {
        Button(action: {
            selectedMode = mode
        }) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .padding(.leading, 10)
                
                Text(label)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
            }
            .frame(width: 180, height: 40, alignment: .leading)
            .background(Color("BlackColor"))
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.leading, 120)
        }
    }
    
    //MARK: - Date Format
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: date)
    }
    
    //MARK: - Time Format
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        return formatter.string(from: date)
    }
    
    //MARK: - Report Card Function
    func reportCard(icon: String, title: String, content: Binding<String>) -> some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.trailing, 5)

                Spacer()
            }
            
            TextEditor(text: content)
                .padding(10)
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.white)
                .font(.body)
                .frame(minHeight: 100)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
    
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("BlueColor")))
        .shadow(radius: 5)
    }


    
    //MARK: - History Card Function
    private func HistoryCard(title: String, content: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(content)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Button(action: {
                selectedMode = "cekLaporan"
            }) {
                Image(systemName: icon)
                    .font(.title)
                    .frame(width: 20)
                    .foregroundColor(.gray)
            }
            .buttonStyle(PlainButtonStyle())

            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("YellowReport"))
        .cornerRadius(12)
    }
    
    //MARK: - Report Parsing
    func parseReport(from text: String) -> MaintenanceReport {
        let locationKeywords = ["lokasi", "di", "tempat", "area", "posisi", "ruang", "titik", "dekat"]
        let componentKeywords = ["komponen", "bagian", "mesin", "sistem", "perangkat"]
        let damageKeywords = ["kerusakan", "rusak", "pecah", "hilang", "terbakar", "akibat"]
        let actionKeywords = ["perbaikan", "tindakan", "solusi", "perbaiki", "mengganti", "memperbaiki"]

        var lokasi = "-"
        var kerusakan = "-"
        var akibat = "-"
        var tindakan = "-"

        let sentences = text.lowercased().components(separatedBy: CharacterSet(charactersIn: ".\n"))

        for sentence in sentences {
            let trimmed = sentence.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { continue }

            if lokasi == "-" && locationKeywords.contains(where: { trimmed.contains($0) }) {
                lokasi = trimmed
            }

            if kerusakan == "-" && componentKeywords.contains(where: { trimmed.contains($0) }) {
                kerusakan = trimmed
            }

            if akibat == "-" && damageKeywords.contains(where: { trimmed.contains($0) }) {
                akibat = trimmed
            }

            if tindakan == "-" && actionKeywords.contains(where: { trimmed.contains($0) }) {
                tindakan = trimmed
            }
        }

        return MaintenanceReport(
            lokasi: lokasi,
            kerusakan: kerusakan,
            akibat: akibat,
            tindakan: tindakan
        )
    }

    
    //MARK: - Export To PDF Function
    private func exportToPDF() {
        let hostingController = UIHostingController(rootView: cekLaporanView)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 595, height: 842)
        hostingController.view.backgroundColor = .clear

        if let window = UIApplication.shared.windows.first {
            window.addSubview(hostingController.view)
        }

        let renderer = UIGraphicsImageRenderer(size: hostingController.view.bounds.size)
        let image = renderer.image { context in
            hostingController.view.layer.render(in: context.cgContext)
        }

        hostingController.view.removeFromSuperview()

        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842))

        let pdfData = pdfRenderer.pdfData { context in
            context.beginPage()
            context.cgContext.setFillColor(UIColor(red: 39/255, green: 59/255, blue: 74/255, alpha: 1.0).cgColor)
            context.cgContext.fill(CGRect(x: 0, y: 0, width: 595, height: 842))

            let margin: CGFloat = 20.0
            let pageWidth = 595.0 - margin * 2
            let pageHeight = 842.0 - margin * 2

            let aspectWidth = pageWidth / image.size.width
            let aspectHeight = pageHeight / image.size.height
            let scaleFactor = min(aspectWidth, aspectHeight)

            let scaledSize = CGSize(width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)
            let imageOrigin = CGPoint(x: (pageWidth - scaledSize.width) / 2 + margin, y: (pageHeight - scaledSize.height) / 2 + margin)

            let headerText = "Laporan Maintenance"
            let headerFont = UIFont.boldSystemFont(ofSize: 40)
            let headerAttributes: [NSAttributedString.Key: Any] = [
                .font: headerFont,
                .foregroundColor: UIColor.white
            ]
            let headerSize = headerText.size(withAttributes: headerAttributes)
            let headerOrigin = CGPoint(x: (595 - headerSize.width) / 2, y: margin)
            headerText.draw(at: headerOrigin, withAttributes: headerAttributes)

            image.draw(in: CGRect(origin: imageOrigin, size: scaledSize))
        }

        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("MaintenanceReport.pdf")

        do {
            try pdfData.write(to: tempURL)
            let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true)
        } catch {
            print("Failed to write PDF data: \(error)")
        }
    }


}

#Preview {
    ContentView(
        speechRecognizer: SpeechRecognizer(), date: Date(), report: MaintenanceReport(
            lokasi: "Ruang Server Lt. 2",
            kerusakan: "AC Tidak Dingin",
            akibat: "Ruangan Terlalu Panas",
            tindakan: "Membersihkan filter dan isi ulang freon"
        )
    )
}



