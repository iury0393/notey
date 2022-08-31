//
//  TextViewController.swift
//  Notey
//
//  Created by Iury Vasconcelos on 31/08/22.
//

import UIKit

class TextViewController: UIViewController {
    
    var selectedCategory: NoteyCategory? {
        didSet {
            //loadText()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
