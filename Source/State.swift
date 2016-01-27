//
//  State.swift
//  StateMachine
//
//  Created by Mike on 1/22/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import UIKit

class State: NSObject {

    // Reference to the parent state machine.
    //
    var stateMachine : StateMachine?

    // Custom initializer with a passed-in reference to the parent
    // state machine.
    //
    init(_ stateMachine : StateMachine) {
        super.init()

        self.stateMachine = stateMachine
    }

    // Shared enter and exit state functions to be implemented by subclasses.
    //
    func enterState() {}
    func exitState() {}
}
