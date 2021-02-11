//
//  ViewController.swift
//  Timer
//
//  Created by Егор Никитин on 09.02.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private var updateColorTime: Int = 10
    
    private let colors: [UIColor] = [.green, .blue, .cyan, .orange, .darkGray, .systemPink, .yellow, .purple, .red, .magenta]
    
    private var iteration: Int = 0
    
    private let constInfo: String = "До обновления цвета view осталось: "
    
    @IBOutlet private var infoLabel: UILabel! {
        didSet{
            infoLabel.text = "\(constInfo)\(String(updateColorTime))"
        }
    }
    
    @IBOutlet private var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        updateColor()
    }
    
    private func updateColor() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            self.updateColorTime -= 1
            self.infoLabel.text = "\(self.constInfo)\(String(self.updateColorTime))"
            
            
            if self.updateColorTime < 0 {
                self.infoLabel.text = "\(self.constInfo)0"
            }
            
            if self.updateColorTime == 0 {

                UIView.animate(withDuration: 1) {
                    self.colorView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                } completion: { (bool) in
                    UIView.animate(withDuration: 1) {
                        self.colorView.transform = .identity
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.colorView.backgroundColor = self.colors[self.iteration]
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.updateColorTime = 10
                    self.infoLabel.text = "\(self.constInfo)\(String(self.updateColorTime))"
                }
                
                if self.iteration == self.colors.count - 1 {
                    self.iteration = 0
                } else {
                    self.iteration += 1
                }

           }
        }
    }
    
}

