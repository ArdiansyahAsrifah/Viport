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

struct ContentView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()

    var body: some View {
        ZStack {
            // Backround
            Color("YellowColor")
                .ignoresSafeArea()

            // Header
            VStack(spacing: 16) {

                VStack {
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
                                withAnimation {
                                    speechRecognizer.toggleRecording()
                                }
                            }) {
                                HStack {
                                    Image(systemName: speechRecognizer.isRecording ? "stop.circle.fill" : "folder.circle.fill")
                                        .font(.system(size: 30))

                                }
                                .frame(width: 80, height: 40)
                                .background(speechRecognizer.isRecording ? Color.red : Color("GrayColor"))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.top, 160)
                                .padding(.leading, 120)

                            }
                            
                            Button(action: {
                                withAnimation {
                                    speechRecognizer.toggleRecording()
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
    }
}

#Preview {
    ContentView()
}
