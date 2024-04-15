//
//  TextAccentView.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 13/04/24.
//

import SwiftUI

struct TextAccentView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title3)
            .bold()
            .foregroundStyle(.accent)
    }
}
