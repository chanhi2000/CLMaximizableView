//
//  MaximizableView.swift
//  Example
//
//  Created by LeeChan on 12/6/16.
//  Copyright © 2016 MarkiiimarK. All rights reserved.
//

import UIKit

class MaximizableView: UIView, UITableViewDataSource, UITableViewDelegate  {
    
    static let statusBarHeight:CGFloat = 19
    
    var mvWidth:CGFloat = 244
    var mvHeight:CGFloat = 156
    var xOffset:CGFloat = 0
    var yOffset:CGFloat = 0
    var containerColor:UIColor = .blue
    
    var isMaximized:Bool = false {
        didSet {
            UIApplication.shared.statusBarStyle = isMaximized ? .lightContent : .default
            button.setTitle(isMaximized ? "Minimize" : "Maximize", for: .normal)
            setupLayers(isMaximized)
            if isMaximized {
                maximizeView()
            } else {
                minimizeView()
            }
        }
    }
    
    var viewController: ViewController?
    
    let containerView:UIView = {
        let v = UIView()
        v.layer.cornerRadius = 8.0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var button:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Maximize", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var listView:UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.isScrollEnabled = false
        tv.allowsSelection = false
        tv.dataSource = self
        tv.delegate = self
        tv.layer.masksToBounds = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.backgroundColor = containerColor
        containerView.addSubview(button)
        containerView.addSubview(listView)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
        setupContainerView()
        setupLayers(false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupView() {
        
        widthAnchor.constraint(equalToConstant: mvWidth).isActive = true
        heightAnchor.constraint(equalToConstant: mvHeight).isActive = true
        if let rootView = self.superview {
            centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: xOffset).isActive = true
            centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: yOffset).isActive = true
        }
        
    }
    
    fileprivate func setupContainerView() {
        
        addConstraintsWithFormat("H:|[v0]|", views: containerView)
        addConstraintsWithFormat("V:|[v0]|", views: containerView)
        
        containerView.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: button)
        button.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        listView.register(UITableViewCell.self, forCellReuseIdentifier: MaximizableView.cellId)
        containerView.addConstraintsWithFormat("H:|[v0]|", views: listView)
        listView.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
    }
    
    fileprivate func setupLayers(_ bool:Bool) {
        layer.masksToBounds = bool
        layer.borderWidth = bool ? 0.0 : 0.5
        layer.cornerRadius = bool ? 0.0 : 8.0
        layer.shadowRadius = bool ? 0.0 : 8.0
        layer.shadowOpacity = bool ? 0.0 : 8.0
        
        listView.isScrollEnabled = bool
        listView.allowsSelection = bool
        
        containerView.layer.masksToBounds = !bool
        containerView.layer.cornerRadius = bool ? 0.0 : 8.0
    }
    
    func buttonPressed() {
        print("button pressed -> toggle isMaximized")
        isMaximized = !isMaximized
    }
    
    fileprivate func maximizeView() {
        if let vc = viewController, let rootView = vc.view {
            
            rootView.layoutIfNeeded()
            rootView.addConstraintsWithFormat("V:|[v0]|", views: self)
            rootView.addConstraintsWithFormat("H:|[v0]|", views: self)
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: MaximizableView.statusBarHeight).isActive = true
            listView.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
            
            updateWithCustomAnimation(view: rootView, message: "maximize!")
        }
    }
    
    fileprivate func minimizeView() {
        if let vc = viewController, let rootView = vc.view {
            
            rootView.layoutIfNeeded()
            removeLayoutConstraints(views: self, rootView)
            setupView()
            setupContainerView()
            
            updateWithCustomAnimation(view: rootView, message: "minimize")
        }
    }
    
    fileprivate func updateWithCustomAnimation(view:UIView, message:String?) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            view.setNeedsUpdateConstraints()
            view.layoutIfNeeded()
        }) { (completed) in
            if let msg = message {
                print(msg)
            }
        }
    }
    
    fileprivate func removeLayoutConstraints(views:UIView...) {
        for v in views {
            v.removeConstraints(v.constraints)
        }
    }
    
    
    // MARK: UITableView
    static let cellId = "tvCell"
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // MAKR: UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaximizableView.cellId, for: indexPath)
        return cell
    }
}
