//
//  CourseDetailView.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct CourseDetailView: View {
    let course: String
    let detail: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(course)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(detail)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Detail Materi")
    }
}
