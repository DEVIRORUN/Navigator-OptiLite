# 🎯 Navigator-OptiLite

Real-time object detection — semantic color-coded bounding boxes.
**AMD MI300X · ROCm 7.2 · YOLOv8 · JupyterLab**

---

## How the Droplet Works

This uses DigitalOcean's **AMD GPU 1-Click** droplet.
JupyterLab is **pre-installed and auto-starts** — you do NOT install it.

```
Droplet starts
    → JupyterLab is already running on port 80
    → SSH terminal shows your login Token
    → Open http://YOUR_DROPLET_IP in browser
    → Paste token → you're in
```

---

## First-Time Setup (do once per fresh droplet)

**Step 1 — SSH in via DigitalOcean web console**
> Droplet page → top right → "Web Console"
> Copy the Token from the welcome message

**Step 2 — In the terminal:**
```bash
cd /root
git clone https://github.com/DEVIRORUN/Navigator-OptiLite.git
cd Navigator-OptiLite
bash setup.sh
```

**Step 3 — Open JupyterLab:**
```
http://YOUR_DROPLET_IP
```
Paste token → Enter

**Step 4 — Open the notebook:**
```
notebooks/yolo_detection.ipynb
```
Run all cells → click **▶ START STREAM** → allow webcam

---

## Every Session After That (new droplet from scratch)

```bash
# In web console terminal:
git clone https://github.com/DEVIRORUN/Navigator-OptiLite.git
cd Navigator-OptiLite
bash setup.sh
```
Then open JupyterLab as above.
Setup takes ~5 mins. YOLO weights auto-download on first Cell 3 run.

---

## Save Before Destroying Droplet

```bash
cd /root/Navigator-OptiLite
git add .
git commit -m "checkpoint: what you did today"
git push origin main
```
Then destroy the droplet. Zero credits burned while you sleep.

---

## Color Legend

| Class | Color | Notes |
|---|---|---|
| person | 🔵 Blue-500 | |
| bear, elephant | 🔴 Red-900 | dangerous |
| dog, cat, horse, cow, sheep, bird, giraffe, zebra | 🟠 Orange-400 | safe animals |
| door (generic) | 🟢 Green-600 | |
| car door | 🟢 Green-300 | lightest |
| bus door | 🟢 Green-700 | |
| house door | 🟢 Green-900 | darkest |
| everything else | ⬜ Gray | |

> Door subtypes (car/bus/house) require LLaVA — coming in Phase 2.
> For now all doors detected by YOLO get Green-600.

---

## Roadmap

- [x] Phase 1 — YOLO + webcam + semantic colors + Jupyter display (3fps)
- [ ] Phase 2 — FER (facial expression recognition)
- [ ] Phase 3 — LLaVA for deep semantics (door subtypes, clothing, etc.)
- [ ] Phase 4 — TTS output + browser client on local PC
- [ ] Phase 5 — Distance estimation