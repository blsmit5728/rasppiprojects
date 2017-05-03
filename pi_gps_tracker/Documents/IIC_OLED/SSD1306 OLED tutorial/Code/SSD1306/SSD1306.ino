#include <Adafruit_ssd1306syp.h>
#define SDA_PIN 9
#define SCL_PIN 8
Adafruit_ssd1306syp display(SDA_PIN,SCL_PIN);
void setup()
{
  delay(1000);
  display.initialize();
}
void loop()
{
  
  display.setTextSize(2);
  display.setTextColor(WHITE);
  display.setCursor(0,0);
  display.println("DIYMALLS");  
  display.update();
  delay(2000);
  display.clear();
}
