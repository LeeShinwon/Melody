import SwiftUI
import UIKit

struct CameraSwiftUITransView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> CameraViewController {
        
        let cameraViewController = CameraViewController()
        return cameraViewController
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        
    }
}

