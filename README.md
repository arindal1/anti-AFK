# Anti-AFK Script

This repository contains anti-AFK (Away From Keyboard) scripts implemented in various programming languages. These scripts prevent the system from becoming idle by:
- simulating mouse movements at regular intervals
- opens notepad and continuously types random characters in it

The `python` script [antiafk.py](https://github.com/arindal1/anti-AFK/blob/main/antiafk.py) is the most efficient and optimized, has the least bugs and vulnerabilities.

## Scripts

### Python (Python 3)

#### Script: [antiafk.py](https://github.com/arindal1/anti-AFK/blob/main/antiafk.py)

This Python script uses the `pynput` and `keyboard` library to listen for mouse and keyboard activities. It opens Notepad and types random characters to keep the system active. It also moves the mouse randomly to prevent idle detection.

## Usage

1. Make sure you have Python installed on your system.
2. Install the required dependencies using pip:
   ```
   pip install pynput
   pip install keyboard
   ```
3. Run the script using the following command:
   ```
   python antiafk.py
   ```
4. The script will start running. Press **Ctrl** or **Shift** or **Esc** at any time to stop the script.

---

### C++ (Windows)

#### Script: [antiafk.cpp](https://github.com/arindal1/anti-AFK/blob/main/antiafk.cpp)

This C++ script uses the Windows API to simulate keyboard input and mouse movement. It prevents the system from going idle by moving the mouse cursor randomly within a specified range and typing random characters.

## Usage

1. Open the script (`antiafk.cpp`) in a C++ development environment.
2. Compile the script to generate an executable file.
3. Run the generated executable file.
4. The script will start preventing the system from going idle.
5. Press Ctrl+Shift+Esc at any time to stop the script.

## Configuration

- You can modify the `idleThreshold`, `mouseMoveRange`, and `punchCharacters` constants in the script to adjust the behavior according to your preferences.
---

### Shell (Linux)

#### Script: [antiafk.sh](https://github.com/arindal1/anti-AFK/blob/main/antiafk.sh)

This shell script utilizes xdotool to simulate mouse movements and keyboard inputs. It keeps the system active by moving the mouse cursor randomly and typing random characters.

## Usage

1. **Ensure xdotool is installed**: The script relies on the `xdotool` command-line tool to simulate mouse movements and keyboard inputs. If it's not installed, you can install it using your package manager. For example, on Debian/Ubuntu systems, you can install it with the following command:

    ```bash
    sudo apt-get install xdotool
    ```

2. **Make the script executable**: Before you can run the script, you need to make it executable. You can do this with the following command:

    ```bash
    chmod +x antiafk.sh
    ```

3. **Run the script**: Once the script is executable, you can run it by executing the following command:

    ```bash
    ./antiafk.sh
    ```

4. **Stopping the script**: To stop the script, you can simply press `Ctrl+C`. This will terminate the script and restore normal system behavior.

---

### Batch (Windows)

#### Script: [antiafk.bat](https://github.com/arindal1/anti-AFK/blob/main/antiafk.bat)

This batch script uses PowerShell commands to simulate mouse movements and keyboard inputs. It prevents the system from becoming idle by moving the mouse cursor randomly and typing random characters.

### Usage

1. Ensure that you have PowerShell installed on your Windows system.
2. Run the `antiafk.bat` script by double-clicking on it or executing it from the command line.
3. The script will start simulating mouse movements and typing random characters to keep the system active.
4. Press `Ctrl+Shift+Esc` at any time to stop the script and prevent further activity.

<p>This setup utilizes PowerShell to simulate mouse movement and keyboard input. Save both scripts in the same directory, and then run AntiAFK.bat to start the anti-AFK functionality. Pressing Ctrl+C will terminate the script. Ensure that PowerShell execution policy allows running scripts (Set-ExecutionPolicy RemoteSigned can be used to allow running local scripts). Additionally, please note that this script might not work as expected on systems with UAC enabled due to restrictions on simulating input events.</p>

---

### Go

#### Script: [antiafk.go](https://github.com/arindal1/anti-AFK/blob/main/antiafk.go)

This Go script utilizes goroutines to perform anti-AFK actions concurrently. It uses the xdotool command-line tool to simulate mouse movements and keyboard inputs.

## Usage

1. Ensure you have Go installed on your system.
2. Compile the script using the `go build` command:
   ```
   go build antiafk.go
   ```
3. Run the compiled binary:
   ```
   ./antiafk
   ```
4. The script will start running, preventing the system from going idle. Press Ctrl+C to stop the script.

---

## Contact

If you have any questions, suggestions, or just want to connect, feel free to reach out:

- GitHub: [arindal1](https://github.com/arindal1)
- LinkedIn: [arindalchar](https://www.linkedin.com/in/arindalchar/)
- Twitter: [arindal_17](https://twitter.com/arindal_17)

## License

These scripts are provided under the [MIT License](LICENSE).

## Keep Coding 🚀
