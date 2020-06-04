//
//  Login.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 04/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit

class Login: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var bttAcessar: UIButton!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var labelAviso: UILabel!
    var defaults = UserDefaults()
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        txtSenha.attributedPlaceholder = NSAttributedString(string: "SENHA", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        bttAcessar.layer.cornerRadius = 30
        txtSenha.layer.cornerRadius = 28
        txtSenha.delegate = self
        
    }
    
    @IBAction func bttAcesso(_ sender: UIButton) {
        if(verificaSenha() == true){
            self.navigationController?.popToRootViewController(animated: false)
        } else {
            labelAviso.isHidden = false
            labelAviso.text = "Senha incorreta"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func verificaSenha() -> Bool{
        let senhaCorreta = defaults.value(forKey: "senha") as? String
        if(txtSenha.text == senhaCorreta){
            return true
        } else {
            return false
        }
    }
}
