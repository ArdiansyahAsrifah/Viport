//
//   MaintenanceReportView.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 03/05/25.
//

struct MaintenanceReport {
    var lokasi: String
    var kerusakan: String
    var akibat: String
    var tindakan: String
}

import SwiftUI

struct MaintenanceReportView: View {
    var report: MaintenanceReport
    var date: Date

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Laporan Maintenance")
                    .font(.title)
                    .bold()
                
                Text("Apple Developer Academy | Cek AC")
                    .font(.headline)
                
                Text("\(formattedDate(date)) – \(formattedTime(date))")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                reportCard(icon: "map", title: "Lokasi", content: report.lokasi)
                reportCard(icon: "exclamationmark.circle", title: "Kerusakan", content: report.kerusakan)
                reportCard(icon: "face.dashed", title: "Akibat", content: report.akibat)
                reportCard(icon: "magnifyingglass", title: "Tindakan", content: report.tindakan)

                Text("Bukti Pengerjaan")
                    .font(.headline)
                    .padding(.top)

                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(height: 150)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Back")
    }

    private func reportCard(icon: String, title: String, content: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .frame(width: 40)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(content)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemYellow).opacity(0.1))
        .cornerRadius(12)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: date)
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        return formatter.string(from: date)
    }
}

#Preview {
    MaintenanceReportView(
        report: MaintenanceReport(
            lokasi: "Ruang Server Lt. 2",
            kerusakan: "AC Tidak Dingin",
            akibat: "Ruangan Terlalu Panas",
            tindakan: "Membersihkan filter dan isi ulang freon"
        ),
        date: Date()
    )
}

