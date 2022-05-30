//
//  UIStackView.swift
//  test
//
//  Created by Alina Tytarenko on 12.05.2022.
//

import UIKit

extension UIStackView {
    
    public static func vertical(_ arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
    
    public static func horizontal(_ arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }
}
