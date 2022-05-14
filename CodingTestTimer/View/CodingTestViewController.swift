//
//  TimerViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/14.
//

import Foundation
import UIKit

class CodingTestViewController: UIViewController {
    private let countDownTimer = UIDatePicker()
    private var startButton: UIButton?
    
    convenience init(title: String, bgColor: UIColor) {
        self.init()
        self.title = title
        self.view.backgroundColor = bgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCountDown()
        setStartButton()
    }
    
    
    // MARK: - countDownTimer
    
    func setCountDown() {
        setCountDownAttributes()
        setCountDownConstraints()
    }
    
    func setCountDownAttributes() {
        countDownTimer.preferredDatePickerStyle = .automatic
        countDownTimer.locale = NSLocale.current
        countDownTimer.datePickerMode = .countDownTimer
        countDownTimer.addTarget(self, action: #selector(test), for: .valueChanged)
    }
    
    func setCountDownConstraints() {
        view.addSubview(countDownTimer)
        countDownTimer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countDownTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            countDownTimer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            countDownTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownTimer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
    }
    
    // MARK: - startButton
    
    func setStartButton() {
        setStartButtonConfiguration()
        setStartButtonConstraints()
    }
    
    func setStartButtonConfiguration() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.title = "시작"
        config.background.backgroundColor = .buttonBlue
        
        startButton = UIButton(configuration: config)
    }
    
    func setStartButtonConstraints() {
        guard let startButton = startButton else { return }

        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: countDownTimer.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - actions
    @objc
    private func test(_ sender: UIDatePicker) {
        print(sender.countDownDuration)
    }
}
