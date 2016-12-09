//
//  ViewController.swift
//  Example
//
//  Created by LeeChan on 12/6/16.
//  Copyright © 2016 MarkiiimarK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let statusBarHeight = 19
    
    let statusBarView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    var isMaximized:Bool = false {
        didSet {
            if isMaximized {
                maximizeView()
            } else {
                minimizeView()
            }
        }
    }
    
    let containerView:UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        v.layer.cornerRadius = 8.0
        v.layer.shadowOpacity = 0.5
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
    
    static let cellId = "tvCell"
    
    lazy var listView:UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.allowsSelection = false
        tv.isScrollEnabled = false
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.addSubview(button)
        containerView.addSubview(listView)
        
        setupContainerView()
        setupStatusBarView()
    }
    
    func setupContainerView() {
        
        
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 8.0
        containerView.layer.borderWidth = 0.5
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 244).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 156).isActive = true
        
        containerView.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: button)
        button.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        listView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellId)
        containerView.addConstraintsWithFormat("H:|[v0]|", views: listView)
        listView.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
    }
    
    func setupStatusBarView() {
        view.addSubview(statusBarView)
        view.addConstraintsWithFormat("H:|[v0]|", views: statusBarView)
        view.addConstraintsWithFormat("V:|[v0(18)]", views: statusBarView)
        
        statusBarView.backgroundColor = containerView.backgroundColor
        statusBarView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonPressed() {
        print("button pressed -> toggle isMaximized")
        isMaximized = !isMaximized
    }
    
    func maximizeView() {
        print("maximize!")
        button.setTitle("Minimize", for: .normal)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
            UIApplication.shared.statusBarStyle = .lightContent
            self.statusBarView.alpha = 1.0
            self.listView.isScrollEnabled = true
            
            self.view.addConstraintsWithFormat("H:|[v0]|", views: self.containerView)
            self.view.addConstraintsWithFormat("V:|-18-[v0]|", views: self.containerView)
            
            self.containerView.layer.masksToBounds = true
            self.containerView.layer.cornerRadius = 0.0
            self.containerView.layer.borderWidth = 0.0
            
            self.view.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()
            
        }) { (completed) in
            
        }
    }
    
    func minimizeView() {
        print("minimize!")
        button.setTitle("Maximize", for: .normal)
        
        self.removeLayoutConstraints(view: self.view)
        self.removeLayoutConstraints(view: self.containerView)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
            UIApplication.shared.statusBarStyle = .default
            self.statusBarView.alpha = 0
            self.listView.isScrollEnabled = false
            
            self.setupContainerView()
            self.setupStatusBarView()
            
            self.view.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()
            
        }) { (completed) in
            
        }
    }
    
    func removeLayoutConstraints(view:UIView) {
        view.removeConstraints(view.constraints)
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // MAKR: UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellId, for: indexPath)
        return cell
    }
    
}

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellId, for: indexPath)
//        return cell
//    }
//}

