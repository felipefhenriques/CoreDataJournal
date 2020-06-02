//
//  TableController.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 02/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit
import CoreData

    class ListaController: UITableViewController {
    public var notas:[NSManagedObject] = []
    var objetoGerenciado: NSManagedObjectContext?
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        //Recuperar dados
        lerEntradas()
        
        //Tabela
        
        
        //Estética
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
      lerEntradas()
      super.viewWillAppear(animated)
    }
    
    func lerEntradas(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")

        do {
          notas = try managedContext.fetch(fetchRequest)
//          for i in 0..<notas.count{
//              let entrada = self.notas[i]
//              print(entrada.value(forKey: "corpoTexto") as? String)
//          }
            tableView.reloadData()
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nota = notas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.text = nota.value(forKeyPath: "criadoEm") as? String
        cell.detailTextLabel?.text = nota.value(forKeyPath: "corpoTexto") as? String
        return cell
    }
    
}
