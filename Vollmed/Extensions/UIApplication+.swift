//
//  UIApplication+.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 17/04/24.
//

import UIKit

extension UIApplication {
    //pega a window ativa pra colocar o bottom no snackbar valendo a safe area
    var getKeyWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
