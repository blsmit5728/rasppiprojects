#include <Adafruit_ssd1306syp.h>
#define SDA_PIN 8
#define SCL_PIN 9
Adafruit_ssd1306syp display(SDA_PIN,SCL_PIN);
void setup()
{
  delay(1000);
  display.initialize();
}
void loop()
{
  display.drawLine(0, 0, 127, 63,BLACK);
  display.update();
  delay(1000);
  display.clear();
  display.setTextSize(10);
  display.setTextColor(WHITE);
  display.setCursor(0,0);
  display.println("Hello, world!");
  display.startscrollright(0x00, 0x0F);
  delay(2000);
  display.stopscroll();
 // display.update();
  delay(2000);
  display.clear();
}
