//
//  CDPState.swift
//  StateMachine
//
//  Created by Mike on 1/25/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import Foundation

class CDPState: State {

    // Define the shared actions amongst all CD Player states - simply tell the state machine
    // to change to the approprate step.
    //
    func play() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.changeState(stateMachine.playingStateIndex)
    }

    func pause() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.changeState(stateMachine.pausedStateIndex)
    }

    func stop() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.changeState(stateMachine.stoppedStateIndex)
    }

    // These methods don't require state changes, but are implemented
    // differently in each subclas.
    //
    func nextTrack() {}
    func prevTrack() {}
}
