//
//  SpeechRecognizer.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 01/05/25.
//

import Foundation
import AVFoundation
import Speech
import NaturalLanguage

class SpeechRecognizer: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "id-ID"))!
    private var recognitionTask: SFSpeechRecognitionTask?
    
    @Published var isRecording = false
    @Published var transcribedText = ""
    @Published var summaryText = ""

    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus != .authorized {
                    print("Speech recognition not authorized")
                }
            }
        }

        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if !granted {
                print("Microphone permission not granted")
            }
        }
    }

    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    func startRecording() {
        transcribedText = ""
        summaryText = ""

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session error: \(error.localizedDescription)")
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode


        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create recognition request")
        }

        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                self.transcribedText = result.bestTranscription.formattedString
            }

            if let error = error {
                print("Recognition error: \(error.localizedDescription)")
                self.stopRecording()
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
            isRecording = true
        } catch {
            print("Audio engine couldn't start: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        isRecording = false

        makeSummary(from: transcribedText)
    }

    func makeSummary(from text: String) {
        let locationKeywords = ["lokasi", "di", "tempat", "area", "posisi"]
        let componentKeywords = ["komponen", "bagian", "mesin", "sistem", "perangkat"]
        let damageKeywords = ["kerusakan", "rusak", "pecah", "hilang", "terbakar"]
        let actionKeywords = ["perbaikan", "tindakan", "solusi", "perbaiki", "mengganti", "memperbaiki"]

        var location = ""
        var component = ""
        var damageType = ""
        var actionTaken = ""


        let sentences = text.split(whereSeparator: { $0 == "." })

        for sentence in sentences {
            let trimmedSentence = sentence.trimmingCharacters(in: .whitespacesAndNewlines)
            

            if locationKeywords.contains(where: { trimmedSentence.lowercased().contains($0) }) {
                location = trimmedSentence
            }

            if componentKeywords.contains(where: { trimmedSentence.lowercased().contains($0) }) {
                component = trimmedSentence
            }


            if damageKeywords.contains(where: { trimmedSentence.lowercased().contains($0) }) {
                damageType = trimmedSentence
            }


            if actionKeywords.contains(where: { trimmedSentence.lowercased().contains($0) }) {
                actionTaken = trimmedSentence
            }
        }

        var summary = ""
        if !location.isEmpty {
            summary += "Lokasi: \(location)\n"
        }
        if !component.isEmpty {
            summary += "Kerusakan: \(component)\n"
        }
        if !damageType.isEmpty {
            summary += "Akibat: \(damageType)\n"
        }
        if !actionTaken.isEmpty {
            summary += "Tindakan: \(actionTaken)\n"
        }

        self.summaryText = summary.trimmingCharacters(in: .whitespacesAndNewlines)
    }


}
