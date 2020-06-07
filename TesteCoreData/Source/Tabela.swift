//
//  Tabela.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 02/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Lista: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var labelOla: UILabel!
    @IBOutlet weak var bttNotaDiaria: UIButton!
    public var notas:[NSManagedObject] = []
    @IBOutlet weak var listaNotas: UITableView!
    var objetoGerenciado: NSManagedObjectContext?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    @IBOutlet weak var lblDataTabela: UILabel!
    @IBOutlet weak var lblTituloTabela: UILabel!
    
    
    var defaults = UserDefaults.standard
    var primeiroAcesso: Bool = false
    
    override func viewDidLoad() {
        self.listaNotas.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.isNavigationBarHidden = true
        if(defaults.value(forKey: "cadastrou") == nil){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Cadastro", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "cadastroSenha") as! cadastroSenha
            self.navigationController?.pushViewController(newViewController, animated: false)
        } else if (defaults.value(forKey: "cadastrou") as? Bool == true) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! Login
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        //Recuperar dados
        lerEntradas()
        
        //Tabela
        listaNotas.delegate = self
        listaNotas.dataSource = self
        listaNotas.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Estética
        bttNotaDiaria.layer.cornerRadius = 40
    }
    
    override func viewWillAppear(_ animated: Bool) {
      lerEntradas()
      listaNotas.delegate = self
      listaNotas.dataSource = self
      super.viewWillAppear(animated)
    }
    
    func lerEntradas(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diario")

        do {
            notas = try managedContext.fetch(fetchRequest).reversed()
            self.listaNotas.reloadData()
        } catch let error as NSError {
          print("Não foi possível carregar os dados. \(error), \(error.userInfo)")
        }
        
        
    }

    @IBAction func bttConfigs(_ sender: UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nota = notas[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if cell == nil || cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.text = nota.value(forKeyPath: "criadoEm") as? String
        cell.detailTextLabel?.text = nota.value(forKeyPath: "corpoTexto") as? String
        cell.detailTextLabel?.numberOfLines = 3
        cell.detailTextLabel?.textAlignment = .right
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nota = self.notas[indexPath.row]
        self.performSegue(withIdentifier: "CarregaNota", sender: nota)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CarregaNota"){
            let carregaNotaVC  = segue.destination as! reverEntradas
            carregaNotaVC.nota = sender as? NSManagedObject
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

 
