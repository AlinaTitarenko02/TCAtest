//
//  UIViewRepresented.swift
//  test
//
//  Created by Alina Tytarenko on 10.05.2022.
//

import SwiftUI

// MARK: - Preview

public struct UIViewPreview<View>: UIViewRepresentable where View: UIView {

    let view: View

    public init(_ builder: @escaping () -> View) {
        self.view = builder()
    }

    public func makeUIView(context: Context) -> View {
        view
    }

    public func updateUIView(_ uiView: View, context: Context) {}
}

public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    private let viewController: ViewController

    public init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    public func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

