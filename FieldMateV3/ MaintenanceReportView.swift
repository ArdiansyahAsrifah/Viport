////
////   MaintenanceReportView.swift
////  FieldMateV3
////
////  Created by Muhammad Ardiansyah Asrifah on 03/05/25.
////
//
////MARK: - Variable Report
//struct MaintenanceReport {
//    var lokasi: String
//    var kerusakan: String
//    var akibat: String
//    var tindakan: String
//}
//
//
////MARK: - Importing Framework
//import SwiftUI
//import PhotosUI
//
////MARK: - Maintenance Report View
//struct MaintenanceReportView: View {
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
//        ZStack {
//            
//            // MARK: - Backround
//            Color("YellowColor")
//                .ignoresSafeArea()
//            
//            
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    HStack {
//                        
//                        // MARK: - Tittle
//                        Text("Laporan Maintenance")
//                            .font(.title)
//                            .bold()
//                        
////                        
////                        Button(action: {
////                            exportToPDF()
////                        }) {
////                            Label("Ekspor Ke PDF", systemImage: "doc.fill")
////                                .font(.subheadline)
////                                .padding(10)
////                                .frame(maxWidth: .infinity)
////                                .background(Color.black)
////                                .foregroundColor(.white)
////                                .cornerRadius(12)
////                        }
////                        .frame(width: 100, height: 100)
//                        
//                    }
//                    //MARK: - Export To PDF Button
//                    Button(action: {
//                        exportToPDF()
//                    }) {
//                        Label("Ekspor ke PDF", systemImage: "doc.fill")
//                            .font(.headline)
//                            .padding(10)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.black)
//                            .foregroundColor(.white)
//                            .cornerRadius(12)
//                    }
//
//                    //MARK: - Choose Place
//                    HStack {
//                        Text("Pilih Lokasi : ")
//                            .font(.headline)
//
//                        Picker("Pilih Lokasi", selection: $selectedTempat) {
//                            ForEach(pilihanTempat, id: \.self) { tempat in
//                                Text(tempat)
//                            }
//                        }
//                        .pickerStyle(.menu)
//                        .font(.title2)
//                        .padding(.leading, -20)
//                    }
//                    
//
//                    //MARK: - Time
//                    Text("\(formattedDate(date)) – \(formattedTime(date))")
//                        .font(.subheadline)
//                        .foregroundColor(.black)
//                    
//                    //MARK: - ReportCard
//                    reportCard(icon: "map", title: "Lokasi", content: report.lokasi)
//                    reportCard(icon: "exclamationmark.circle", title: "Kerusakan", content: report.kerusakan)
//                    reportCard(icon: "face.dashed", title: "Akibat", content: report.akibat)
//                    reportCard(icon: "magnifyingglass", title: "Tindakan", content: report.tindakan)
//                    
//                    //MARK: - Evidence Report
//                    Text("Bukti Pengerjaan")
//                        .font(.headline)
//                        .padding(.top)
//                    
//                    if let image = selectedImage {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 150)
//                            .clipped()
//                            .cornerRadius(12)
//                    } else {
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color("YellowReport"))
//                            .frame(height: 150)
//                            .overlay(
//                                Text("Belum ada foto")
//                                    .foregroundColor(.gray)
//                            )
//                    }
//                    
//                    HStack(spacing: 16) {
//                        Button(action: {
//                            imagePickerSource = .camera
//                            isShowingImagePicker = true
//                        }) {
//                            VStack {
//                                Image(systemName: "camera")
//                                    .font(.title2)
//                                Text("Kamera")
//                                    .font(.caption)
//                            }
//                            .frame(width: 80, height: 80)
//                            .background(Color.black.opacity(0.05))
//                            .foregroundColor(.black)
//                            .cornerRadius(12)
//                        }
//
//                        Button(action: {
//                            imagePickerSource = .photoLibrary
//                            isShowingImagePicker = true
//                        }) {
//                            VStack {
//                                Image(systemName: "photo.on.rectangle")
//                                    .font(.title2)
//                                Text("Galeri")
//                                    .font(.caption)
//                            }
//                            .frame(width: 80, height: 80)
//                            .background(Color.black.opacity(0.05))
//                            .foregroundColor(.black)
//                            .cornerRadius(12)
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.top, 8)
//
//                    
//                }
//                .padding()
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("Back")
//        }
//        .sheet(isPresented: $isShowingImagePicker) {
//            ImagePicker(image: $selectedImage, sourceType: imagePickerSource)
//        }
//        .onAppear {
//            selectedTempat = report.lokasi
//        }
//    }
//    
//    //MARK: - Report Card Function
//    private func reportCard(icon: String, title: String, content: String) -> some View {
//        HStack(alignment: .top, spacing: 12) {
//            Image(systemName: icon)
//                .font(.title)
//                .frame(width: 40)
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
//}
//
//
//#Preview {
//    MaintenanceReportView(
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
