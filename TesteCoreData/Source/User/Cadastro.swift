//
//  Cadastro.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 02/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit

class cadastroSenha: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var fieldSenha: UITextField!
    @IBOutlet weak var bttProx: UIButton!
    var defaults = UserDefaults()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        fieldSenha.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        setNeedsStatusBarAppearanceUpdate()
        fieldSenha.layer.cornerRadius = 28
        bttProx.layer.cornerRadius = 30
        fieldSenha.delegate = self
    }
    
    @IBAction func bttSalvar(_ sender: UIButton) {
        defaults.set(fieldSenha.text, forKey: "senha")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

class cadastroDica: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtResposta: UITextField!
    
    @IBOutlet weak var bttFinalizar: UIButton!
    @IBOutlet weak var labelVerifica: UILabel!
    var defaults = UserDefaults()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        txtResposta.attributedPlaceholder = NSAttributedString(string: "Dica", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        setNeedsStatusBarAppearanceUpdate()
        txtResposta.layer.cornerRadius = 28
        bttFinalizar.layer.cornerRadius = 30
        txtResposta.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        labelVerifica.isHidden = true
        return false
    }
    
    @IBAction func bttSalvar(_ sender: UIButton) {
        if(verifica(textField: txtResposta)){
            defaults.set(txtResposta.text, forKey: "dicaUser")
            transicao()
            defaults.set(true, forKey: "cadastrou")
        } else {
            labelVerifica.isHidden = false
            labelVerifica.text = "A dica não pode estar vazia"
        }
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "idTabela") as! Lista
//            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    
    func transicao(){
        let transition = CATransition()
        transition.duration = 0.3222
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popToRootViewController(animated: false)
    }
}

    
    func verifica(textField: UITextField) -> Bool {
        if textField.text == "" || textField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        } else {
            return true
        }
        
    }



