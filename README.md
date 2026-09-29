# Real-Time EMG-Controlled Arm Robot

Controlling a robot arm with hand gestures. Muscle (EMG) signals from a **Myo Armband** are streamed and classified in real time, and each recognized gesture is mapped to an arm movement.

[![Watch the demo on YouTube](https://img.youtube.com/vi/Y88WK2LawpA/hqdefault.jpg)](https://www.youtube.com/watch?v=Y88WK2LawpA)

▶️ **[Watch the demo on YouTube](https://www.youtube.com/watch?v=Y88WK2LawpA)**

---

## Overview

The goal was to control the movement of an arm robot using hand gestures by analysing and classifying EMG biosignals.

1. **Acquisition.** EMG signals are recorded with the Myo Armband and streamed with **Lab Streaming Layer (LSL)**. Recordings are saved as `.xdf` files for training.
2. **Pre-processing and features.** Training and real-time windows are filtered and converted to features (`preprocess_training_data.m`, `preprocess_realtime_data.m`, `extract_realtime.m`).
3. **Classification.** Three classifiers were trained and compared: **Random Forest (RF)**, **Support Vector Machine (SVM)** and **Linear Discriminant Analysis (LDA)**.
4. **Real-time control.** Live predictions drive the arm through a serial servo controller (`realtimemain.m`, `realtime_classification.m`, `botmove.m`), with a ROS interface in `ros_comm.m`.

## Skills and tools

`MATLAB` · `Machine learning` · `LDA / SVM / Random Forest` · `EMG signal processing` · `Lab Streaming Layer` · `ROS` · `Bio-robotics`

## Repository contents

All code is in `Finale/`:

| File(s) | What it does |
|---|---|
| `realtimemain.m`, `realtimemainwith2classifiers.m`, `realtimeprediction.m` | Real-time classification and control loop |
| `trainClassifier.m`, `LDAclassifier*.m`, `SVMLinearClassifier.m` | Classifier training |
| `preprocess_*.m`, `extract*.m` | Signal pre-processing and feature extraction |
| `ArmRobot.m`, `SSC32.m`, `SerialPort.m`, `botmove.m` | Arm kinematics and servo control |
| `*.xdf` | Recorded EMG sessions |
| `*.mat` | Trained classifier objects |
| `liblsl-Matlab/`, `load_xdf.m` | Lab Streaming Layer MATLAB bindings and XDF loader (third-party) |

## Context

Team project from my M.S. in Electrical Engineering at Rochester Institute of Technology. Also on [Portfolium](https://portfolium.com/entry/real-time-emg-controlled-arm-robot).
