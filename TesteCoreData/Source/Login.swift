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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
        txtSenha.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        bttAcessar.layer.cornerRadius = 30
        txtSenha.layer.cornerRadius = 28
        txtSenha.delegate = self
        
    }
    
    @IBAction func bttAcesso(_ sender: UIButton) {
        if(verificaSenha() == true){
            transicao()
        } else {
            labelAviso.isHidden = false
            labelAviso.text = "Senha incorreta\n Dica: " + (defaults.value(forKey: "dicaUser") as! String)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        labelAviso.isHidden = true
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
    
    func transicao(){
        let transition = CATransition()
        transition.duration = 0.3222
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popToRootViewController(animated: false)
    }
}
