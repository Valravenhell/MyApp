//
//  KeyCahinViewController.swift
//  JarvisConsept
//
//  Created by Artem Krasko on 06.10.2024.
//

import Security
import Foundation

class KeychainHelper {
    
    static let shared = KeychainHelper()
    
    func savePassword(service: String, account: String, password: String) {
        let passwordData = password.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: passwordData
        ]
        
        // Видаляємо старий пароль, якщо він існує
        SecItemDelete(query as CFDictionary)
        
        // Додаємо новий пароль у Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Error saving password: \(status)")
        }
    }
    
    func getPassword(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let passwordData = item as? Data {
            return String(data: passwordData, encoding: .utf8)
        } else {
            print("Error retrieving password: \(status)")
            return nil
        }
    }
    
    func deletePassword(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("Error deleting password: \(status)")
        }
    }
}
