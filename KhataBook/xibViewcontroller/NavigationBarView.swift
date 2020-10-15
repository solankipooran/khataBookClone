//
//  NavigationBarView.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 30/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {

    @IBOutlet var View: UIView!
    
    // first: load the view hierarchy to get proper outlets
    Bundle.main.loadNibNamed(“NavigationBar”, owner: self, options: nil)
    view.translatesAutoresizingMaskIntoConstraints = false
    // next: append the container to our view
    addSubview(view)
    NSLayoutConstraint.activate(
       [
          view.topAnchor.constraint(equalTo: topAnchor),
          view.leadingAnchor.constraint(equalTo: leadingAnchor),
          view.bottomAnchor.constraint(equalTo: bottomAnchor),
          view.trailingAnchor.constraint(equalTo: trailingAnchor),
       ]
     )

}
