//
//  SupabaseClientManager.swift
//  blink
//
//  Created by Baily Case on 3/9/23.
//

import Foundation
import Supabase

class SupabaseClientManager {
    static let shared = SupabaseClientManager()

    let supabaseClient: SupabaseClient

    private init() {
        let supabaseUrl = URL(string: "https://secnndlumlgmciifjwih.supabase.co")!
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlY25uZGx1bWxnbWNpaWZqd2loIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg0MTYxNzksImV4cCI6MTk5Mzk5MjE3OX0.pN37xLGFm8XdRjQU_Cp5H9sMEzshu8Fwh1uSi6-6m1U"
        self.supabaseClient = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey:supabaseKey)
    }
}
