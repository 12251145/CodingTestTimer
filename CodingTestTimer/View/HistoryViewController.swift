//
//  RecordsViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/14.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    convenience init(title: String, bgColor: UIColor) {
        self.init()
        self.title = title
        self.view.backgroundColor = bgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
