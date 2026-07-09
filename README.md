# NuruTouch

NuruTouch is an **offline-first, AI-assisted Flutter application** designed to teach Braille literacy to blind and low-vision children in Sub-Saharan Africa (specifically targeting learners aged 7-14).

Currently, the hardware required to learn Braille (like Perkins Braillers or refreshable displays) is prohibitively expensive for most families in low-resource environments. NuruTouch solves this by utilizing the vibration motor, speaker, and touchscreen of standard, budget Android smartphones to deliver an interactive, multi-sensory educational curriculum.

## 🌟 Core Features

*   **Blind-First Interaction Model:** The application is designed to be fully navigable without sight. Every screen inherits from a global gesture and haptic framework.
*   **Temporal Haptic Encoding:** Adapts Braille characters into unique rhythmic vibration patterns optimized for standard Eccentric Rotating Mass (ERM) motors found in budget smartphones.
*   **Teacher Amina (AI Instructor):** A context-aware narration engine that guides the learner using semantic dialogue templates. She provides encouragement, explains mistakes, and drives the lesson forward entirely via audio.
*   **Adaptive Learning (Q-Table):** Utilizes a lightweight, SQLite-backed reinforcement learning engine. It tracks accuracy, response latency, and hesitation to dynamically calculate the optimal review schedule and lesson difficulty using the Bellman equation.
*   **Hybrid Voice Recognition (ASR):** Incorporates constrained-vocabulary speech recognition (Sherpa-ONNX Zipformer) to allow learners to practice pronunciation offline, with an optional cloud-sync fallback.
*   **Strict User Isolation:** Separate portals for Learners, Teachers (TVIs), and Parents. The Teacher and Parent dashboards are locked behind hidden multi-finger gestures and numeric PINs.
*   **Fully Offline:** No internet connection, cloud backend, or account creation is required for the core learning experience.

## 🏗️ Technical Architecture

The application strictly adheres to a **Feature-First, Domain-Driven Architecture**.

*   **Framework:** Flutter (Dart 3.x)
*   **State Management:** Riverpod (`NotifierProvider`, `FutureProvider`)
*   **Navigation:** GoRouter (with ShellRoutes for isolated branch security)
*   **Local Storage:** SQLite (via `sqflite`) for Q-Tables, Progress, Analytics, and Profiles
*   **Hardware Interfacing:** `vibration` (Haptics), `flutter_tts` (Audio)

### The Lesson State Machine
Lessons are not hardcoded. They are data-driven structures (JSON) pushed through a 14-phase state machine (Welcome -> Introduce -> Listen -> Feel -> Discover -> Master -> Practice -> Quiz -> Celebrate). The UI dynamically renders the appropriate tactile interface (like the 6-dot `BrailleGridWidget`) based on the current phase.

## 🤝 Research Context
This application serves as the technical artifact for the Capstone project: *"Helping Blind and Low-Vision Children in Africa Learn Braille Through AI-Powered, Offline Smartphone Instruction."* It includes deep analytics tracking for a planned 6-week pilot to measure Braille recognition improvement and System Usability Scale (SUS) scores.

## 🚀 Getting Started

Please see [INSTALLATION.md](INSTALLATION.md) for detailed instructions on how to build and run the NuruTouch application.
