use rand::Rng;
use std::process::{Command, exit};
use std::thread;
use std::time::Duration;

const IDLE_THRESHOLD: u64 = 10;
const MOUSE_MOVE_RANGE: i32 = 20;
const PUNCH_CHARACTERS: &str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:,.<>?";

fn main() {
    println!("Anti-AFK script started. Press Ctrl+C to stop.");

    let mut idle_time = 0;
    let mut move_mouse_handle = thread::spawn(move_mouse);
    let mut punch_characters_handle = thread::spawn(move || punch_characters(&mut idle_time));

    loop {
        thread::sleep(Duration::from_secs(1));
        idle_time += 1;

        if idle_time >= IDLE_THRESHOLD {
            stop_script();
            return;
        }
    }
}

fn move_mouse() {
    let mut rng = rand::thread_rng();

    loop {
        thread::sleep(Duration::from_secs(rng.gen_range(5..16)));
        let dx = rng.gen_range(-MOUSE_MOVE_RANGE..=MOUSE_MOVE_RANGE);
        let dy = rng.gen_range(-MOUSE_MOVE_RANGE..=MOUSE_MOVE_RANGE);
        
        Command::new("xdotool")
            .arg("mousemove_relative")
            .arg("--")
            .arg(dx.to_string())
            .arg(dy.to_string())
            .output()
            .expect("Failed to move mouse");
    }
}

fn punch_characters(idle_time: &mut u64) {
    let mut rng = rand::thread_rng();

    loop {
        thread::sleep(Duration::from_secs(1));
        if *idle_time >= IDLE_THRESHOLD {
            let rand_index = rng.gen_range(0..PUNCH_CHARACTERS.len());
            let ch = &PUNCH_CHARACTERS[rand_index..=rand_index];

            Command::new("xdotool")
                .arg("type")
                .arg("--clearmodifiers")
                .arg(ch)
                .output()
                .expect("Failed to punch characters");
                
            *idle_time = 0;
        } else {
            *idle_time += 1;
        }
    }
}

fn stop_script() {
    Command::new("xdotool")
        .arg("key")
        .arg("ctrl+shift+esc")
        .output()
        .expect("Failed to stop script");
        
    println!("Anti-AFK script stopped.");
    exit(0);
}
