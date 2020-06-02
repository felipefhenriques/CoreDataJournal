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
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        //Recuperar dados
        lerEntradas()
        
        //Tabela
        listaNotas.delegate = self
        listaNotas.dataSource = self
        listaNotas.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Estética
        bttNotaDiaria.layer.cornerRadius = 40
        self.navigationController?.isNavigationBarHidden = true
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TesteVic")

        do {
            notas = try managedContext.fetch(fetchRequest).reversed()
//          for i in 0..<notas.count{
//              let entrada = self.notas[i]
//              print(entrada.value(forKey: "corpoTexto") as? String)
//          }
            self.listaNotas.reloadData()
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nota = notas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.text = nota.value(forKeyPath: "criadoEm") as? String
        cell.detailTextLabel?.text = nota.value(forKeyPath: "corpoTexto") as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)

        return cell
    }
    
}
