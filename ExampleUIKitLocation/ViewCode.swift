//
//  ViewCode.swift
//  ExampleUIKit
//
//  Created by Mario Chiodi on 22/05/24.
//

protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setup() {
        addSubviews()
        setupConstraints()
        setupStyle()
    }
}
