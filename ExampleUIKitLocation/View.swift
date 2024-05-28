//
//  View.swift
//  ExampleUIKit
//
//  Created by Mario Chiodi on 22/05/24.
//

import UIKit

protocol ViewDelegate: AnyObject {
    func didTapButton()
}

class View: UIView {
    // MARK: - Delegates
    weak var delegate: ViewDelegate?
    
    // MARK: - UI
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonSee: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    init() {
        // Chamamos um método da UIView para inicialização
        super.init(frame: .zero)
        setup()
    }

    // O método a seguir é obrigatório na classe UIView
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(labelText: String, buttonTitle: String, buttonSeeTitle: String) {
        label.text = labelText
        button.setTitle(buttonTitle, for: .normal)
        buttonSee.setTitle(buttonSeeTitle, for: .normal)
    }
    
    // MARK: - Actions

     @objc
     private func didTapButton() {
         delegate?.didTapButton()
     }
}

extension View: ViewCode {
    func addSubviews() {
        addSubview(label)
        addSubview(button)
        addSubview(buttonSee)
        
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),

            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buttonSee.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            buttonSee.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
