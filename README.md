# 🧪 Dr. Mario — Assembly Game

A low-level implementation of a **Dr. Mario–style falling block puzzle game** written in **MIPS assembly**, featuring real-time gameplay, manual memory management, and bitmap-based rendering.

Built as part of **CSC258 (Computer Organization)** at the **University of Toronto**.

---

## 🎮 Overview

This project recreates the core mechanics of *Dr. Mario* on a bitmap display using **memory-mapped I/O** for both graphics and keyboard input. Players control falling capsules to eliminate viruses by matching four or more blocks of the same color vertically or horizontally.

All rendering, game logic, and timing are handled directly in assembly, emphasizing low-level system control.

---

## 🖼️ Preview

| Gameplay | Game Over |
|----------|-----------|
| ![Gameplay](images/gameplay.png) | ![Game Over](images/gameover.png) |

---

## ✨ Features

- Tile-based gameplay inside a medicine bottle
- Capsule movement, rotation, and collision detection
- Gravity system with increasing speed over time
- Line elimination for matching four or more blocks
- Pause and resume functionality
- Game over screen with retry option
- Next-capsule preview
- Background music playback
- Custom sprites for Dr. Mario and viruses

---

## 🛠️ Technical Details

- **Language:** MIPS Assembly  
- **Graphics:** Bitmap display via memory-mapped I/O  
- **Input:** Keyboard input via memory-mapped registers  
- **Concepts Used:**
  - Manual memory management
  - Low-level control flow
  - Game state management without high-level abstractions

All game mechanics — including rendering, input handling, collision detection, and timing — are implemented entirely at the assembly level.

---

## ▶️ How to Run

1. Open the project in a MIPS simulator that supports bitmap display and keyboard support (such as MARS or Saturn)
2. Assemble and run `drmario.asm`
3. Configure the bitmap display with:
   - **Unit width:** 2 pixels  
   - **Unit height:** 2 pixels  
   - **Display width:** 64 pixels  
   - **Display height:** 64 pixels  
   - **Base address:** `0x10008000`

---

## 🎮 Controls

- **A / D** — Move capsule left / right  
- **W** — Rotate capsule  
- **S** — Drop capsule faster  
- **P** — Pause / resume  
- **R** — Retry after game over  
- **Q** — Quit after game over  

---

## 👥 Contributors

- **Aref Malekanian**
- **Albert Jun**
