//
//  Utility.swift
//  inStudy_iOS
//
//  Created by luba_yaronskaya on 13.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

func loadUser() -> User? {
    return NSKeyedUnarchiver.unarchiveObjectWithFile(User.ArchiveURL.path!) as? User
}

func saveUser(user: User) {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(user, toFile: User.ArchiveURL.path!)
    if !isSuccessfulSave {
        print("Failed to save user.")
    }
}
