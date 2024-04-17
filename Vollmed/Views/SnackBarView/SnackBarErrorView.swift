//
//  SnackBarErrorView.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 17/04/24.
//

import SwiftUI

struct SnackBarErrorView: View {
    
    @Binding var isShowing: Bool
    
    var message: String
    
    var body: some View {
        VStack {
            Spacer() // jogar tudo para baixo
            if isShowing {
                //olha como um text resolve tudo
                Text(message)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .transition(.move(edge: .bottom)) //transicao da animação
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity) //toda largura disponivel
        .padding(.horizontal) //espaços na horizontal
        .padding(.bottom, isShowing ? UIApplication.shared.getKeyWindow?.safeAreaInsets.bottom ?? 0 : -100) //usando isso para pegar o bottom correto caso tenha safearea
    }
}

#Preview {
    SnackBarErrorView(
        isShowing: .constant(true),
        message: "Ops! ocorreu um erro, mas ja estamos trabalhando para solucionar"
    )
}
