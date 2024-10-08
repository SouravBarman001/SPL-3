
# NeuroScan - Brain Tumor Detection App

## Overview
NeuroScan is a mobile application that leverages deep learning and MRI imaging to detect and classify brain tumors. The app is built using Flutter for the front end, while the back end is powered by Python's Flask framework. NeuroScan uses a two-stage classification approach: it first determines whether a tumor is present, and if detected, further classifies it into specific types (Glioma, Meningioma, Pituitary). The app offers a user-friendly medical interface, features Grad-CAM visualizations, and provides detailed reports with tumor descriptions and doctor suggestions.

## Features
- **Brain Tumor Classification**: Detects whether a brain tumor is present, and classifies the tumor into three categories: Glioma, Meningioma, and Pituitary.
- **Grad-CAM Visualization**: Provides heatmaps to localize the tumor within MRI images, allowing radiologists and users to better understand the affected region.
- **User Information Management**: Collects and stores user information (Name, Address, Phone, Weight, Blood Group, Email) before classification, allowing the app to generate personalized diagnostic reports.
- **Real-Time Results and Accuracy**: Displays the classification result and prediction accuracy.
- **Email Sharing**: Sends diagnostic reports, including the Grad-CAM visualization, user data, and classification results, via email.
- **Professional Medical UI**: Designed with a clean, responsive interface suitable for medical purposes, featuring rounded edges, indigo buttons with icons, and shadow effects.

## Architecture
The project is designed with a modular architecture, integrating the following components:

1. **Flutter Frontend**:
    - Implements a professional, user-friendly medical UI.
    - Manages image selection (via gallery or camera), tumor classification results, and Grad-CAM visualizations.
    - State management is handled using the Provider package.

2. **Flask Backend**:
    - Provides REST API endpoints for tumor classification and Grad-CAM generation.
    - The backend processes the MRI images through a two-stage classification model:
        - **Binary Classification**: Detects the presence of a tumor.
        - **Multiclass Classification**: Classifies the tumor type if detected.

## Technologies Used
- **Frontend**: Flutter, Dart
    - **State Management**: Provider
    - **Packages**: http, provider, font_awesome_flutter, image_picker, http, path_provider
- **Backend**: Python, Flask
    - **Machine Learning**: TensorFlow, Keras
    - **Grad-CAM**: Custom Grad-CAM helper for visualization
- **APIs**: Flask API for image classification
- **Deep Learning Models**: Custom-trained models for tumor detection and classification

## Installation

### Prerequisites
- Flutter 3.16.3 • channel stable • https://github.com/flutter/flutter.git
  Framework • revision b0366e0a3f (10 months ago) • 2023-12-05 19:46:39 -0800
  Engine • revision 54a7145303
  Tools • Dart 3.2.3 • DevTools 2.28.4
- Python 3.11.7 with Flask 2.2.5
- TensorFlow and Keras for model handling

### Steps to Run

1. **Clone the Repository**:
   ```bash
   git clone [https://github.com/yourusername/neuroscan.git](https://github.com/SouravBarman001/SPL-3/tree/main)
   cd neuroscan
   ```

2. **Flutter Setup**:
   - Install Flutter dependencies:
     ```bash
     flutter pub get
     ```

3. **Backend Setup**:
   - Navigate to the backend directory:
     ```bash
     cd backend
     ```
   - Install the required Python dependencies:
     ```bash
     pip install -r requirements.txt
     ```
   - Run the Flask server:
     ```bash
     python app.py
     ```

4. **Run the Flutter App**:
   - Make sure you have an emulator or a connected device.
   - Launch the app:
     ```bash
     flutter run
     ```

## Usage
1. **Add User Information**: On the home screen, users can input their details like name, phone number, weight, and email.
2. **Image Classification**: Users can select an MRI image from their gallery or capture it using the camera. The app will then process the image and display the classification result along with a Grad-CAM visualization.
3. **Report Generation**: After classification, the user can send the report, including the predicted tumor type, accuracy, Grad-CAM image, and user details, via email.

## Future Work
- **Enhanced Accuracy**: Improve the classification model's accuracy by experimenting with different architectures and larger datasets.
- **Multi-language Support**: Implement multi-language support to make the app accessible to non-English speakers.
- **Real-Time MRI Scanning Integration**: Explore integrating real-time MRI image scanning via medical devices for live analysis.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

### Contributors
- [Your Name](https://github.com/SouravBarman001)

---
![App Demo](https://drive.google.com/drive/folders/1bCdaybjFXeevvDnlkUD6ySrF_72lmYUT?usp=drive_link)

