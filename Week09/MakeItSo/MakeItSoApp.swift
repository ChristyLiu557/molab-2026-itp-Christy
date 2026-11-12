//
// MakeItSoApp.swift
// MakeItSo
//
// Created by Peter Friese on 01.03.23.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Week09 adaptation: Christy Liu, with AI assistance.
// Uses the student's Firebase project and anonymous per-user data.
import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

struct CloudEntryView: View {
  @State private var ready = false
  @State private var errorMessage: String?
  @State private var connecting = false

  var body: some View {
    Group {
      if ready {
        RemindersListView().navigationTitle("Color Walk Tasks")
      } else {
        VStack(spacing: 20) {
          Text("Color Walk Tasks").font(.largeTitle.bold())
          Text("A MakeItSo study project for planning small creative walks.")
            .multilineTextAlignment(.center)
          if connecting { ProgressView("Connecting to Firebase…") }
          if let errorMessage {
            Text(errorMessage).foregroundStyle(.red)
            Button("Try again") { Task { await connect() } }
          }
        }.padding()
      }
    }.task { await connect() }
  }

  @MainActor
  private func connect() async {
    guard !ready, !connecting else { return }
    connecting = true
    errorMessage = nil
    defer { connecting = false }
    do {
      if Auth.auth().currentUser == nil {
        _ = try await Auth.auth().signInAnonymously()
      }
      ready = true
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

@main
struct MakeItSoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  var body: some Scene {
    WindowGroup {
      NavigationStack { CloudEntryView() }
    }
  }
}

