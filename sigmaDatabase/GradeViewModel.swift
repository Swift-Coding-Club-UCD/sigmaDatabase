//
//  GradeViewModel.swift
//  sigmaDatabase
//
//  Created by Mark Le on 3/2/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
//import FirebaseFirestoreSwift


struct Grade: Identifiable, Codable {
    @DocumentID var id: String?
    var ownerId: String = ""
    var className: String
    var grade: String
}

class GradesViewModel: ObservableObject {
    @Published var grades = [Grade]()
    private var db = Firestore.firestore()
    
    init() {
        fetchGrades()
    }
    
    // Read: Listen to Firestore for real-time updates
    func fetchGrades() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No authenticated user")
            return
        }
        
        db.collection("grades")
            .whereField("ownerId", isEqualTo: uid)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.grades = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Grade.self)
                }
            }
    }
    
    // Create: Add a new grade record
    func addGrade(grade: Grade) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No authenticated user")
            return
        }
        
        var newGrade = grade
        newGrade.ownerId = uid  // Set the owner ID automatically
        do {
            _ = try db.collection("grades").addDocument(from: newGrade)
        } catch {
            print("Error adding grade: \(error.localizedDescription)")
        }
        
    }
    
    // Update: Update an existing grade record
    func updateGrade(grade: Grade) {
        if let id = grade.id {
            do {
                try db.collection("grades").document(id).setData(from: grade)
            } catch {
                print("Error updating grade: \(error.localizedDescription)")
            }
        }
    }
    
    // Delete: Remove a grade record
    func deleteGrade(grade: Grade) {
        if let id = grade.id {
            db.collection("grades").document(id).delete { error in
                if let error = error {
                    print("Error deleting grade: \(error.localizedDescription)")
                }
            }
        }
    }
}
