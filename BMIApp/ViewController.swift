//
//  ViewController.swift
//  BMIApp
//
//  Created by 김진주 on 2023/07/31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BMIButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    func configureUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        view.backgroundColor = .systemGray5
        
        titleLabel.text = "키와 몸무게를 입력해 주세요"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        heightLabel.text = "키"
        heightLabel.textAlignment = .center
        heightLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        
        weightLabel.text = "몸무게"
        weightLabel.textAlignment = .center
        weightLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        weightTextField.placeholder = "kg 단위로 입력해주세요"
        
        BMIButton.setTitle("BMI 계산하기", for: .normal)
        BMIButton.setTitleColor(.white, for: .normal)
        BMIButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        BMIButton.backgroundColor = .systemBlue
        BMIButton.layer.cornerRadius = 5
        BMIButton.clipsToBounds = true
    }
    
    
    @IBAction func BMIButtonTapped(_ sender: UIButton) {
        guard let resultVC = storyboard?.instantiateViewController(withIdentifier: "resultVC") as? ResultViewController else { return }
        
        if heightTextField.text == "" || weightTextField.text == "" {
            titleLabel.text = "키와 몸무게를 입력하세요!!!"
            titleLabel.textColor = .red
        } else {
            guard let height = Double(heightTextField.text!),
                  let weight = Double(weightTextField.text!) else { return }
            
            resultVC.bmi = calculateBMI(height: height, weight: weight)
            resultVC.modalPresentationStyle = .fullScreen
            
            // 다시 돌아왔을 때 칸 비워있도록
            heightTextField.text = ""
            weightTextField.text = ""
            
            present(resultVC,animated: true)
        }

    }
    
    func calculateBMI(height: Double, weight: Double) -> Double {
        var bmi = weight / (height * height) * 10000
        bmi = round(bmi * 10) / 10
        return bmi
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if Int(string) != nil || string == "" {
            return true
        }
        return false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두번째 텍스트 필드까지 입력 마치면 키보드 내려가기
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // 두번째 텍스트 필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 화면 터치하면 텍스트 필드를 종료 (키보드 내리기)
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}

