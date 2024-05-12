# Anti-AFK Script

This repository contains anti-AFK (Away From Keyboard) scripts implemented in various programming languages. These scripts prevent the system from becoming idle by:
- simulating mouse movements at regular intervals
- opens notepad and continuously types random characters in it

The `python` script [antiafk.py](https://github.com/arindal1/anti-AFK/blob/main/antiafk.py) is the most efficient and optimized, has the least bugs and vulnerabilities. You can read about the other scripts in **[README2](README2.md)**.

## Main Script: [antiafk.py](https://github.com/arindal1/anti-AFK/blob/main/antiafk.py)
> Python3

This Python script uses the `pynput` and `keyboard` library to listen for mouse and keyboard activities. It opens Notepad and types random characters to keep the system active. It also moves the mouse randomly to prevent idle detection.

### Purpose

- You're working and need to leave your system for a few minutes.
- You're in some online game where being idle for too long gets you kicked/banned.

### Usage

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

## Contact

If you have any questions, suggestions, or just want to connect, feel free to reach out:

- GitHub: [arindal1](https://github.com/arindal1)
- LinkedIn: [arindalchar](https://www.linkedin.com/in/arindalchar/)
- Twitter: [arindal_17](https://twitter.com/arindal_17)

## License

These scripts are provided under the [MIT License](LICENSE).

## Keep Coding 🚀
