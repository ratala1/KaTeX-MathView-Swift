//
//  ViewController.swift
//  Example
//
//  Created by rajeswari on 5/8/19.
//  Copyright © 2019 Rajeswari ratala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let latex: String = "Find the value of $k$, if $x + 6$ is a factor of $- k + x^{3} + 16 x^{2} + 76 x$ Find the value of $k$, if $x + 6$ is a factor of $- k + x^{3} + 16 x^{2} + 76 x$ Find the value of $k$, if $x + 6$ is a factor of $- k + x^{3} + 16 x^{2} + 76 x$ Find the value of $k$, if $x + 6$ is a factor of $- k + x^{3} + 16 x^{2} + 76 x$ Find the value of $k$, if $x + 6$ is a factor of $- k + x^{3} + 16 x^{2} + 76 x$"
    
    @IBOutlet weak var mathView: KatexMathView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mathView.loadLatex(latex)
    }


}

