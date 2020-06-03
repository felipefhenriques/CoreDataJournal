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
    
    override func viewDidLoad() {
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

class cadastroPerguntas: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtNomeMae: UITextField!
    @IBOutlet weak var txtAmigo: UITextField!
    @IBOutlet weak var txtCidade: UITextField!
    @IBOutlet weak var txtPet: UITextField!
    @IBOutlet weak var txtSigno: UITextField!
    @IBOutlet weak var bttFinalizar: UIButton!
    @IBOutlet weak var labelVerifica: UILabel!
    @IBOutlet weak var labelSenha: UILabel!
    var defaults = UserDefaults()
    
    override func viewDidLoad() {
        bordas()
        delegate()
    }
    
    func bordas(){
        txtNomeMae.layer.cornerRadius = 28
        txtAmigo.layer.cornerRadius = 28
        txtCidade.layer.cornerRadius = 28
        txtPet.layer.cornerRadius = 28
        txtSigno.layer.cornerRadius = 28
        bttFinalizar.layer.cornerRadius = 30
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func bttSalvar(_ sender: UIButton) {
        if(contadorRespostas() < 3){
            labelVerifica.isHidden = false
            labelVerifica.text = "Responda ao menos três perguntas"
        } else {
            labelVerifica.isHidden = true
        }
    }
    
    func delegate(){
        txtNomeMae.delegate = self
        txtAmigo.delegate = self
        txtCidade.delegate = self
        txtPet.delegate = self
        txtSigno.delegate = self
        
    }
    
    func verifica(textField: UITextField) -> Bool {
        if textField.text == "" || textField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func contadorRespostas() -> Int{
        var conta = 0;
        var maeJaAdicionado: Bool = false;
        var amigoJaAdicionado: Bool = false;
        var cidadeJaAdicionado: Bool = false;
        var petJaAdicionado: Bool = false;
        var signoJaAdicionado: Bool = false;
        
        
        if(verifica(textField: txtNomeMae)){
            conta += 1
            maeJaAdicionado = true
        } else if maeJaAdicionado == true{
            conta -= 1
        }
            
        if(verifica(textField: txtAmigo)){
            conta += 1
            amigoJaAdicionado = true
        } else if amigoJaAdicionado == true{
            conta -= 1
        }
        
        if(verifica(textField: txtCidade)){
            conta += 1
            cidadeJaAdicionado = true
        } else if cidadeJaAdicionado == true{
            conta -= 1
        }
        
        if(verifica(textField: txtPet)){
            conta += 1
            petJaAdicionado = true
        } else if petJaAdicionado == true{
            conta -= 1
        }
        
        if(verifica(textField: txtSigno)){
            conta += 1
            signoJaAdicionado = true
        } else if signoJaAdicionado == true{
            conta -= 1
        }
        
        return conta;

}

}

 
