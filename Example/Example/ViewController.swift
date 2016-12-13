//
//  ViewController.swift
//  Example
//
//  Created by LeeChan on 12/6/16.
//  Copyright © 2016 MarkiiimarK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var maximizableView:MaximizableView = {
        let mv = MaximizableView(frame: .zero)
        mv.mvWidth = 244
        mv.mvHeight = 300
        mv.xOffset = 20
        mv.yOffset = 40
        mv.viewController = self
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(maximizableView)
        setupViews()
    }
    
    func setupViews() {
        maximizableView.containerView.backgroundColor = .red
        maximizableView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: maximizableView.xOffset).isActive = true
        maximizableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: maximizableView.yOffset).isActive = true
        maximizableView.widthAnchor.constraint(equalToConstant: maximizableView.mvWidth).isActive = true
        maximizableView.heightAnchor.constraint(equalToConstant: maximizableView.mvHeight).isActive = true
    }

}
