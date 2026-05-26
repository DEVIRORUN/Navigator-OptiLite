# 🎯 Navigator-OptiLite

Real-time object detection with semantic color coding.
**Stack:** AMD MI300X · ROCm · YOLOv8 · Jupyter · Python

---

## First-Time Droplet Setup

```bash
# SSH into your droplet
ssh root@YOUR_DROPLET_IP

# Clone the repo
git clone https://github.com/DEVIRORUN/Navigator-OptiLite.git
cd Navigator-OptiLite

# Run setup (takes ~5-10 mins)
chmod +x setup.sh
bash setup.sh
```

---

## Every Time You Start the Droplet

```bash
cd /root/Navigator-OptiLite
chmod +x start_jupyter.sh
bash start_jupyter.sh
```

Then open in your browser:
```
http://YOUR_DROPLET_IP:8888
```
Password: `navigator`  ← change this in setup.sh before running!

---

## Usage

1. Open `notebooks/yolo_detection.ipynb`
2. Run all cells top to bottom (Kernel → Restart & Run All)
3. Click **▶ Start Stream** in the widget
4. Allow webcam access in your browser
5. YOLO detects at 3fps with custom color-coded boxes

---

## Color System

| Object | Color |
|---|---|
| Person / Human | 🔵 Blue |
| Dangerous animal (bear, elephant) | 🔴 Red-900 (dark) |
| Safe animal (dog, cat, horse...) | 🟠 Orange |
| Door (generic) | 🟢 Green-600 |
| Car door | 🟢 Green-300 (light) |
| Bus door | 🟢 Green-700 |
| House door | 🟢 Green-900 (dark) |
| Other | ⬜ Gray |

---

## Saving Your Work (Free — No Snapshot Needed)

```bash
cd /root/Navigator-OptiLite
git add .
git commit -m "checkpoint: describe what you did"
git push origin main
```

Then you can safely **destroy the droplet** to stop credits burning.  
Next time: spin up a fresh MI300X, clone, run `bash setup.sh`, done.

---

## Roadmap

- [x] Phase 1: YOLO + webcam + custom colors + Jupyter display
- [ ] Phase 2: FER (facial emotion recognition) integration
- [ ] Phase 3: LLaVA for deep semantic understanding
- [ ] Phase 4: TTS output + full browser client on local PC
- [ ] Phase 5: Distance estimation
