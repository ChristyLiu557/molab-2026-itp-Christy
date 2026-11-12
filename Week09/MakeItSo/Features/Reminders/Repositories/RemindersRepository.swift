//
// RemindersRepository.swift
// MakeItSo
//
// Created by Peter Friese on 23.05.23.
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

// Week09 adaptation: per-user paths and visible server errors.
import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

public class RemindersRepository: ObservableObject {
  @Published var reminders = [Reminder]()
  @Published var errorMessage: String?
  private var listenerRegistration: ListenerRegistration?
  private let collection: CollectionReference?

  init() {
    if let uid = Auth.auth().currentUser?.uid {
      collection = Firestore.firestore().collection("users").document(uid).collection("reminders")
    } else {
      collection = nil
    }
    subscribe()
  }

  deinit { listenerRegistration?.remove() }

  func subscribe() {
    guard listenerRegistration == nil else { return }
    guard let collection else {
      errorMessage = "Sign in before loading reminders."
      return
    }
    listenerRegistration = collection.addSnapshotListener { [weak self] snapshot, error in
      DispatchQueue.main.async {
        guard let self else { return }
        if let error {
          self.errorMessage = error.localizedDescription
          return
        }
        guard let documents = snapshot?.documents else { return }
        do {
          self.reminders = try documents.map { try $0.data(as: Reminder.self) }
            .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
          self.errorMessage = nil
        } catch {
          self.errorMessage = error.localizedDescription
        }
      }
    }
  }

  private func checkedCollection() throws -> CollectionReference {
    guard let collection else {
      throw NSError(domain: "Week09", code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "No authenticated Firebase user."])
    }
    return collection
  }

  private func report(_ error: Error?) {
    DispatchQueue.main.async { [weak self] in
      self?.errorMessage = error?.localizedDescription
    }
  }

  func addReminder(_ reminder: Reminder) throws {
    let target = try checkedCollection()
    _ = try target.addDocument(from: reminder) { [weak self] error in self?.report(error) }
  }

  func updateReminder(_ reminder: Reminder) throws {
    guard let id = reminder.id else {
      throw NSError(domain: "Week09", code: 2,
                    userInfo: [NSLocalizedDescriptionKey: "Wait for the reminder to receive an ID."])
    }
    try checkedCollection().document(id).setData(from: reminder, merge: true) { [weak self] error in
      self?.report(error)
    }
  }

  func removeReminder(_ reminder: Reminder) {
    guard let id = reminder.id else {
      report(NSError(domain: "Week09", code: 2,
                     userInfo: [NSLocalizedDescriptionKey: "This reminder has no document ID."]))
      return
    }
    do {
      try checkedCollection().document(id).delete { [weak self] error in self?.report(error) }
    } catch { report(error) }
  }
}

