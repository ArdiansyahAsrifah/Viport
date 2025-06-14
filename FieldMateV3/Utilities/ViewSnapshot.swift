//
//  ViewSnapshot.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 03/05/25.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        
        let controller = UIHostingController(rootView: self)
        let view = controller.view


        let targetSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear


        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}

