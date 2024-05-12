package main

import (
    "fmt"
    "math/rand"
    "os"
    "os/exec"
    "strings"
    "time"
)

const (
    idleThreshold   = 10
    mouseMoveRange = 20
    punchCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:,.<>?"
)

func main() {
    fmt.Println("Anti-AFK script started. Press Ctrl+C to stop.")

    go moveMouse()
    go punchCharacters()

    for {
        select {
        case <-time.After(time.Second):
            if idleTime >= idleThreshold {
                stopScript()
                return
            }
            idleTime++
        }
    }
}

var idleTime int

func moveMouse() {
    rand.Seed(time.Now().UnixNano())

    for {
        time.Sleep(time.Duration(rand.Intn(11) + 5) * time.Second)
        dx := rand.Intn(2*mouseMoveRange) - mouseMoveRange
        dy := rand.Intn(2*mouseMoveRange) - mouseMoveRange
        exec.Command("xdotool", "mousemove_relative", "--", fmt.Sprintf("%d", dx), fmt.Sprintf("%d", dy)).Run()
    }
}

func punchCharacters() {
    rand.Seed(time.Now().UnixNano())

    for {
        time.Sleep(time.Second)
        if idleTime >= idleThreshold {
            randIndex := rand.Intn(len(punchCharacters))
            char := string(punchCharacters[randIndex])
            exec.Command("xdotool", "type", "--clearmodifiers", char).Run()
            idleTime = 0
        } else {
            idleTime++
        }
    }
}

func stopScript() {
    exec.Command("xdotool", "key", "ctrl+shift+esc").Run()
    fmt.Println("Anti-AFK script stopped.")
    os.Exit(0)
}
