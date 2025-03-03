//
//  AddGradeView.swift
//  sigmaDatabase
//
//  Created by Mark Le on 3/2/25.
//

import SwiftUI

struct AddGradeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var gradesVM: GradesViewModel
    @State private var className = ""
    @State private var grade = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Class Info")) {
                    TextField("Class Name", text: $className)
                    TextField("Grade", text: $grade)
                }
            }
            .navigationTitle("Add Grade")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newGrade = Grade(className: className, grade: grade)
                        gradesVM.addGrade(grade: newGrade)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

