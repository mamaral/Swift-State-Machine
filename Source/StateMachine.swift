//
//  StateMachine.swift
//  StateMachine
//
//  Created by Mike on 1/22/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import UIKit

class StateMachine: NSObject {

    // An array of all possible states this state machine has.
    //
    var states : [State] = []

    // The current state the state machine is in.
    //
    var currentState : State?

    // Handles changing state to a new state.
    //
    func changeState(newStateIndex : Int) {
        // Make sure the passed-in state index is in bounds.
        if newStateIndex < 0 || newStateIndex >= states.count {
            assertionFailure("Invalid state index.")
        }

        // If there's already a current state, tell it to exit.
        if let theCurrentState = currentState {
            theCurrentState.exitState()
        }

        // Update our state to the new state and tell that state to enter.
        let newState : State = states[newStateIndex]
        currentState = newState
        newState.enterState()
    }
}
