import random
import time
import threading
import keyboard
from pynput import mouse, keyboard as kb

class AntiAFK:
    def __init__(self, listener, idle_threshold=10, mouse_move_range=(-20, 20), punch_characters='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:,.<>?'):
        self.idle_time = 0
        self.notepad_opened = False
        self.active = True
        self.listener = listener
        self.idle_threshold = idle_threshold
        self.mouse_move_range = mouse_move_range
        self.punch_characters = punch_characters

    def on_mouse_move(self, x, y):
        self.idle_time = 0

    def on_mouse_click(self, x, y, button, pressed):
        self.idle_time = 0

    def on_keyboard_press(self, key):
        self.idle_time = 0

        if key == kb.Key.ctrl_l or key == kb.Key.shift_l or key == kb.Key.esc:
            self.stop()

    def stop(self):
        self.active = False
        print("Anti-AFK script stopped.")
        self.listener.stop()

    def open_notepad(self):
        if not self.notepad_opened:
            try:
                print("Opening Notepad...")
                keyboard.send('win+r')
                time.sleep(0.5)
                keyboard.write('notepad')
                time.sleep(0.5)
                keyboard.send('enter')
                self.notepad_opened = True
            except Exception as e:
                print(f"Error opening Notepad: {e}")
                self.stop()

    def punch_characters(self):
        while self.active:
            time.sleep(1)
            if self.idle_time >= self.idle_threshold:
                self._perform_afk_actions()
            else:
                self.idle_time += 1

    def _perform_afk_actions(self):
        self.open_notepad()
        try:
            random_char = random.choice(self.punch_characters)
            keyboard.write(random_char)
            self._move_mouse()
        except Exception as e:
            print(f"Error performing AFK actions: {e}")
            self.stop()

    def _move_mouse(self):
        time.sleep(random.randint(5, 15))
        if self.idle_time >= self.idle_threshold:
            try:
                dx = random.randint(*self.mouse_move_range)
                dy = random.randint(*self.mouse_move_range)
                mouse_controller = mouse.Controller()
                mouse_controller.move(dx, dy)
            except Exception as e:
                print(f"Error moving mouse: {e}")
                self.stop()

    def start(self):
        mouse_listener = mouse.Listener(on_move=self.on_mouse_move, on_click=self.on_mouse_click)
        mouse_listener.start()

        keyboard_listener = kb.Listener(on_press=self.on_keyboard_press)
        keyboard_listener.start()

        punch_thread = threading.Thread(target=self.punch_characters)
        punch_thread.start()

        print("Anti-AFK script started. Press Ctrl+Shift+Esc to stop.")

if __name__ == "__main__":
    # Define configurable parameters
    idle_threshold = 10
    mouse_move_range = (-20, 20)
    punch_characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:,.<>?'

    # Create keyboard listener
    keyboard_listener = kb.Listener(on_press=lambda key: None)

    # Create AntiAFK instance with configurable parameters
    anti_afk = AntiAFK(keyboard_listener, idle_threshold, mouse_move_range, punch_characters)
    anti_afk.start()
