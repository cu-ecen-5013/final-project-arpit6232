#include "helper.h"
#include "person_detect_model_data.h"

const char* kCategoryLabels[kCategoryCount] = {
    "notperson",
    "person",
};

// Get an image from the camera module
TfLiteStatus GetImage(tflite::ErrorReporter* error_reporter, int image_width,
                      int image_height, int channels, int8_t* image_data) {

  byte data[QCIF_x * QCIF_y * kNumChannels];

  static bool g_is_camera_initialized = false;
  static bool serial_is_initialized = false;

  // Initialize camera if necessary
  if (!g_is_camera_initialized) {
    if (!Camera.begin(QCIF, GRAYSCALE, 5, OV7675)) {
      TF_LITE_REPORT_ERROR(error_reporter, "Failed to initialize camera!");
      return kTfLiteError;
    }
    g_is_camera_initialized = true;
  }

  // Read camera data
  Camera.readFrame(data);

  int min_x = (QCIF_x - kNumRows) / 2;
  int min_y = (QCIF_y - kNumCols) / 2;
  int index = 0;

  /**
   * Crop to 96x96 image and convert TF input image to signed 8-bit
   * The easiest and quickest way to convert from unsigned to
   * signed 8-bit integers is to subtract 128 from the unsigned value to get a
   * signed value.
   */
  for (int col_idx = min_y; col_idx < min_y + kNumCols; col_idx++) {
    for (int row_idx = min_x; row_idx < min_x + kNumRows; row_idx++) {
      image_data[index++] = static_cast<int8_t>(data[(col_idx * QCIF_x) + row_idx] - 128); 
    }
  }

  return kTfLiteOk;
}


// Flash the blue LED after each inference
void RespondToDetection(tflite::ErrorReporter* error_reporter,
                        int8_t person_score, int8_t no_person_score) {
  static bool is_initialized = false;
  if (!is_initialized) {
    // Pins for the built-in RGB LEDs on the Arduino Nano 33 BLE Sense
    pinMode(LEDR, OUTPUT);
    pinMode(LEDG, OUTPUT);
    pinMode(LEDB, OUTPUT);
    is_initialized = true;
  }

  // Note: The RGB LEDs on the Arduino Nano 33 BLE
  // Sense are on when the pin is LOW, off when HIGH.

  // Switch the person/not person LEDs off
  digitalWrite(LEDG, HIGH);
  digitalWrite(LEDR, HIGH);

  // Flash the blue LED after every inference.
  digitalWrite(LEDB, LOW);
  delay(100);
  digitalWrite(LEDB, HIGH);

  // Switch on the green LED when a person is detected,
  // the red when no person is detected
  if (person_score > no_person_score) {
    digitalWrite(LEDG, LOW);
    digitalWrite(LEDR, HIGH);
  } else {
    digitalWrite(LEDG, HIGH);
    digitalWrite(LEDR, LOW);
  }

  TF_LITE_REPORT_ERROR(error_reporter, "Person score: %d No person score: %d",
                       person_score, no_person_score);
}

