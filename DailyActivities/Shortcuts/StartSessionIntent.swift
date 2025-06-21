//
//  StartSessionIntent.swift
//  DailyActivities
//
//  Created by Theo Sementa on 21/06/2025.
//

import AppIntents

struct StartSessionIntent: AppIntent {
 
    static var title: LocalizedStringResource = "Lancer une session"
    static let description: LocalizedStringResource = "This is a shortcut to start a session in Daily Activities."
    
    @Parameter(
        title: "Nom de la catégorie",
        description: "Ce champs correspond à la catégorie de la session",
        requestValueDialog: "Choisissez une catégorie"
    )
    var category: CategoryModel?
    
    func perform() async throws -> some IntentResult {
        
        return .result(dialog: IntentDialog(stringLiteral: "Fail to launch session."))
    }
    
}

