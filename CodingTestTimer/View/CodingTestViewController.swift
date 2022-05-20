//
//  TimerViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/14.
//

import Combine
import Foundation
import UIKit

class CodingTestViewController: UIViewController {
    var viewModel = CodingTestViewModel()
    
    private var timeDisplay: UILabel!
    private var timeIncreaseButton: UIButton!
    
    convenience init(title: String, bgColor: UIColor) {
        self.init()
        self.title = title
        self.view.backgroundColor = bgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTimeDisplayLabel()
        setTimeIncreaseButton()
        
        self.viewModel.$timeLimit
            .sink { value in
                self.timeDisplay.text = "\(value)"
            }
            .store(in: &viewModel.subscriptions)
    }
    
    // MARK: - 시간 설정 Label
    func setTimeDisplayLabel() {
        timeDisplay = UILabel()
        timeDisplay.text = "\(viewModel.timeLimit)"
        timeDisplay.font = UIFont.systemFont(ofSize: 70, weight: .semibold)

        timeDisplay.textAlignment = .center
        timeDisplay.clipsToBounds = true
        
        view.addSubview(timeDisplay)
        
        timeDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeDisplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            timeDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeDisplay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            timeDisplay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    // MARK: - 시간 증가 버튼
    func setTimeIncreaseButton() {
        timeIncreaseButton = UIButton.init(primaryAction: UIAction(handler: { _ in
            self.viewModel.increaseTimeLimit(0.5)
        }))
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .buttonBlue
        config.buttonSize = .large
        config.title = "+0.5"
        
        timeIncreaseButton.configuration = config
        
        view.addSubview(timeIncreaseButton)
        
        timeIncreaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeIncreaseButton.topAnchor.constraint(equalTo: timeDisplay.bottomAnchor, constant: 30),
            timeIncreaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }

}
