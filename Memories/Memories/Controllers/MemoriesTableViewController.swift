//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by David Oliver Doswell on 8/1/18.
//  Copyright © 2018 David Oliver Doswell. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    
    let memoryController = MemoryController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoryController.loadFromPersistentStore()
        print("Got data")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memoryController.loadFromPersistentStore()
    }

    // data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryController.memories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let memory = memoryController.memories[indexPath.row]
        cell.textLabel?.text = memory.title
        cell.detailTextLabel?.text = memory.bodyText
        cell.imageView?.image = UIImage(data: memory.imageData)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let memory = memoryController.memories[indexPath.row]
            memoryController.deleteAMemory(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MemoryDetailViewController {
            vc.memoryController = memoryController
        }
    }

}
