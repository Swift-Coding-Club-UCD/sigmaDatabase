//
//  GradesListView.swift
//  sigmaDatabase
//
//  Created by Mark Le on 3/2/25.
//

import SwiftUI

struct GradesListView: View {
    @StateObject var gradesVM = GradesViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showingAddGrade = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gradesVM.grades) { grade in
                    NavigationLink(destination: EditGradeView(grade: grade, gradesVM: gradesVM)) {
                        VStack(alignment: .leading) {
                            Text(grade.className)
                                .font(.headline)
                            Text("Grade: \(grade.grade)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteGrade)
                
            }
            .navigationTitle("Grades")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") {
                        authViewModel.signOut()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddGrade = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddGrade) {
                AddGradeView(gradesVM: gradesVM)
            }
        }
    }
    
    private func deleteGrade(at offsets: IndexSet) {
        offsets.forEach { index in
            let grade = gradesVM.grades[index]
            gradesVM.deleteGrade(grade: grade)
        }
    }
}
#Preview {
    GradesListView()
}
