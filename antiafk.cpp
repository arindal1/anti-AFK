#include <iostream>
#include <chrono>
#include <random>
#include <Windows.h>

class AntiAFK {
public:
    AntiAFK(int idleThreshold, std::pair<int, int> mouseMoveRange, std::string punchCharacters)
        : idleThreshold(idleThreshold), mouseMoveRange(mouseMoveRange), punchCharacters(punchCharacters) {}

    void start() {
        HANDLE punchThread = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)punchCharactersStatic, this, 0, NULL);
        HANDLE moveMouseThread = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)moveMouseStatic, this, 0, NULL);

        std::cout << "Anti-AFK script started. Press Ctrl+Shift+Esc to stop." << std::endl;

        while (true) {
            std::this_thread::sleep_for(std::chrono::seconds(1));
            if (idleTime >= idleThreshold) {
                keyPress(VK_CONTROL);
                keyPress(VK_SHIFT);
                keyPress(VK_ESCAPE);
                break;
            }
            else {
                idleTime++;
            }
        }
    }

private:
    int idleThreshold;
    std::pair<int, int> mouseMoveRange;
    std::string punchCharacters;
    int idleTime = 0;

    void keyPress(int key) {
        INPUT input;
        input.type = INPUT_KEYBOARD;
        input.ki.wVk = key;
        input.ki.dwFlags = 0;
        SendInput(1, &input, sizeof(INPUT));

        input.ki.dwFlags = KEYEVENTF_KEYUP;
        SendInput(1, &input, sizeof(INPUT));
    }

    static DWORD WINAPI moveMouseStatic(LPVOID lpParam) {
        AntiAFK* antiAFK = static_cast<AntiAFK*>(lpParam);
        return antiAFK->moveMouse();
    }

    DWORD moveMouse() {
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<int> disX(mouseMoveRange.first, mouseMoveRange.second);
        std::uniform_int_distribution<int> disY(mouseMoveRange.first, mouseMoveRange.second);

        while (true) {
            std::this_thread::sleep_for(std::chrono::seconds(std::rand() % 11 + 5));
            int dx = disX(gen);
            int dy = disY(gen);
            SetCursorPos(GetSystemMetrics(SM_CXSCREEN) / 2 + dx, GetSystemMetrics(SM_CYSCREEN) / 2 + dy);
        }
        return 0;
    }

    static DWORD WINAPI punchCharactersStatic(LPVOID lpParam) {
        AntiAFK* antiAFK = static_cast<AntiAFK*>(lpParam);
        return antiAFK->punchCharacters();
    }

    DWORD punchCharacters() {
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<int> dis(0, punchCharacters.length() - 1);

        while (true) {
            std::this_thread::sleep_for(std::chrono::seconds(1));
            if (idleTime >= idleThreshold) {
                keyPress(punchCharacters[dis(gen)]);
                idleTime = 0;
            }
            else {
                idleTime++;
            }
        }
        return 0;
    }
};

int main() {
    int idleThreshold = 10;
    std::pair<int, int> mouseMoveRange = std::make_pair(-20, 20);
    std::string punchCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:,.<>?";

    AntiAFK antiAFK(idleThreshold, mouseMoveRange, punchCharacters);
    antiAFK.start();

    return 0;
}
