//
//  ResultViewController.swift
//  BMIApp
//
//  Created by 김진주 on 2023/08/03.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var comentLabel: UILabel!
    

    @IBOutlet weak var calgulateButton: UIButton!
    
    var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray5
        
        titleLabel.text = "BMI 결과값"
        titleLabel.textAlignment = .center
        
        guard let bmi = bmi else { return }
        BMILabel.text = String(bmi)
        BMILabel.textAlignment = .center
        BMILabel.font = UIFont.boldSystemFont(ofSize: 20)
        BMILabel.backgroundColor = .gray
        BMILabel.layer.cornerRadius = 8
        BMILabel.clipsToBounds = true
        
        setCometLabelBackgroundColor(bmi: bmi)
        comentLabel.textAlignment = .center
        
        calgulateButton.setTitle("다시 계산하기", for: .normal)
        calgulateButton.setTitleColor(.white, for: .normal)
        calgulateButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        calgulateButton.backgroundColor = .systemBlue
        calgulateButton.layer.cornerRadius = 5
        calgulateButton.clipsToBounds = true
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func setCometLabelBackgroundColor(bmi: Double) {
        switch bmi {
        case ..<18.5:
            BMILabel.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
            comentLabel.text = "저체중"
        case 18.6...22.9:
            BMILabel.backgroundColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
            comentLabel.text = "표준"
        case 23.0...24.9:
            BMILabel.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            comentLabel.text = "과체중"
        case 25.0...29.9:
            BMILabel.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            comentLabel.text = "중도 비만"
        case 30...:
            BMILabel.backgroundColor = .red
            comentLabel.text = "고도 비만"
        default:
            BMILabel.backgroundColor = .black
        }
    }
}
