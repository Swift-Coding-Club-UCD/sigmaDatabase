//
//  EditGradeView.swift
//  sigmaDatabase
//
//  Created by Mark Le on 3/2/25.
//

import SwiftUI

struct EditGradeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var grade: Grade
    @ObservedObject var gradesVM: GradesViewModel
    @State private var className: String = ""
    @State private var gradeValue: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Class Info")) {
                TextField("Class Name", text: $className)
                TextField("Grade", text: $gradeValue)
            }
        }
        .navigationTitle("Edit Grade")
        
        .onAppear {
            className = grade.className
            gradeValue = grade.grade
        }
        
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    grade.className = className
                    grade.grade = gradeValue
                    gradesVM.updateGrade(grade: grade)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

