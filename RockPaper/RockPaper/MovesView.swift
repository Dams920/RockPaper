//
//  MovesView.swift
//  RockPaper
//
//  Created by Damien Chailloleau on 03/03/2021.
//

import SwiftUI

struct MovesView: View {
    let choice: String

    var body: some View {
        Text(choice)
            .font(.title)
            .foregroundColor(.white)
            .padding(5)
            .frame(width: 125, height: 50)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        MovesView(choice: "Rock")
            .previewLayout(.sizeThatFits)
    }
}
