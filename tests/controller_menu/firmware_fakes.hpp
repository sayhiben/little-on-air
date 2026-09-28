// SPDX-License-Identifier: MIT
// Only platform boundaries are replaced; tests include the actual application loop.
#pragma once
#include <algorithm>
#include <cstdint>
#include <cstring>
#include <map>
#include <string>
#include <strings.h>
#include <vector>

static uint32_t fakeNow = 1;
static int fakeButton = 1;
inline uint32_t millis() {
    return fakeNow;
}
inline void delay(unsigned ms) {
    fakeNow += ms;
}
inline uint32_t esp_random() {
    return 42;
}
inline int esp_reset_reason() {
    return 0;
}
using gpio_num_t = int;
inline int gpio_get_level(int) {
    return 1;
}
inline int digitalRead(int pin) {
    return pin == 4 ? fakeButton : 1;
}
inline void pinMode(int, int) {}
inline int digitalPinToInterrupt(int pin) {
    return pin;
}
inline void attachInterrupt(int, void (*)(), int) {}
#define IRAM_ATTR
#define INPUT_PULLUP 0
#define CHANGE 0
#define LOW 0
using portMUX_TYPE = int;
#define portMUX_INITIALIZER_UNLOCKED 0
inline void portENTER_CRITICAL(int *) {}
inline void portEXIT_CRITICAL(int *) {}
inline void portENTER_CRITICAL_ISR(int *) {}
inline void portEXIT_CRITICAL_ISR(int *) {}
struct FakeSerial {
    void begin(int) {}
    void setTxBufferSize(int) {}
    void setTxTimeoutMs(int) {}
    void printf(const char *, ...) {}
    void println(const char *) {}
    int available() {
        return 0;
    }
    int read() {
        return 0;
    }
};
static FakeSerial Serial;
struct FakeESP {
    unsigned getFreeHeap() {
        return 100000;
    }
};
static FakeESP ESP;
struct FakeWire {
    void begin(int, int) {}
    void setTimeOut(int) {}
    void beginTransmission(int) {}
    int endTransmission() {
        return 0;
    }
};
static FakeWire Wire;
class Preferences {
  public:
    bool fail = false;
    unsigned writes = 0;
    std::map<std::string, std::vector<uint8_t>> records;
    bool begin(const char *, bool) {
        return true;
    }
    bool isKey(const char *key) {
        return records.count(key) != 0;
    }
    bool remove(const char *key) {
        return records.erase(key) != 0;
    }
    size_t putBytes(const char *key, const void *data, size_t size) {
        ++writes;
        if (fail)
            return 0;
        const auto *bytes = static_cast<const uint8_t *>(data);
        records[key] = std::vector<uint8_t>(bytes, bytes + size);
        return size;
    }
    size_t getBytesLength(const char *key) {
        return records[key].size();
    }
    size_t getBytes(const char *key, void *data, size_t size) {
        size = std::min(size, records[key].size());
        memcpy(data, records[key].data(), size);
        return size;
    }
};
#define NEO_GRB 0
#define NEO_KHZ800 0
class Adafruit_NeoPixel {
  public:
    int brightness = -1;
    uint32_t color = 0;
    unsigned frames = 0;
    Adafruit_NeoPixel(int, int, int) {}
    void begin() {}
    void setBrightness(int b) {
        brightness = b;
    }
    void clear() {
        color = 0;
    }
    void show() {
        ++frames;
    }
    uint32_t Color(uint8_t r, uint8_t g, uint8_t b) {
        return (r << 16) | (g << 8) | b;
    }
    void setPixelColor(int, uint32_t value) {
        color = value;
    }
};
#define SSD1306_WHITE 1
#define SSD1306_DISPLAYON 0xAF
#define SSD1306_DISPLAYOFF 0xAE
#define SSD1306_SETCONTRAST 0x81
#define SSD1306_SWITCHCAPVCC 2
class Adafruit_SSD1306 {
  public:
    std::vector<int> commands;
    Adafruit_SSD1306(int, int, FakeWire *, int) {}
    bool begin(int, int, bool, bool) {
        return true;
    }
    void ssd1306_command(int value) {
        commands.push_back(value);
    }
    void clearDisplay() {}
    void display() {}
    void setTextColor(int) {}
    void setTextWrap(bool) {}
    void setTextSize(int) {}
    void setCursor(int, int) {}
    void print(const char *) {}
    template <class... A> void drawFastHLine(A...) {}
    template <class... A> void drawRoundRect(A...) {}
    template <class... A> void drawRect(A...) {}
    template <class... A> void drawLine(A...) {}
    template <class... A> void drawCircle(A...) {}
    template <class... A> void fillCircle(A...) {}
    template <class... A> void fillRoundRect(A...) {}
    template <class... A> void drawPixel(A...) {}
};
