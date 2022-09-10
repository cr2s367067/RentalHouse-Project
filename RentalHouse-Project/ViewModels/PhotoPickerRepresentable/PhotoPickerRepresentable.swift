//
//  PhotoPickerRepresentable.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/8.
//

import Foundation
import PhotosUI
import SwiftUI

struct PHPickerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    
    @Binding var selectLimit: Int
    @Binding var images: [UIImage]
    var itemProviders = [NSItemProvider]()
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = selectLimit
        configuration.filter = .images
        configuration.preferredAssetRepresentationMode = .automatic
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
        var parent: PHPickerRepresentable
        
        init(parent: PHPickerRepresentable) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true) {
                guard let result = results.first else { return }
                let assetid = result.assetIdentifier
                let prov = result.itemProvider
                let types = prov.registeredTypeIdentifiers
                self.parent.images = []
                self.parent.itemProviders = results.map(\.itemProvider)
                self.loadImage()
            }
        }
        
        private func loadImage() {
            for itemProvider in parent.itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        DispatchQueue.main.async {
                            if let image = image as? UIImage {
                                self.parent.images.append(image)
                            } else {
                                print("Couldn't load image", error?.localizedDescription ?? "")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}
