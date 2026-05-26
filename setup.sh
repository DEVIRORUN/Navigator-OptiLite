#!/bin/bash
# ============================================================
#  Navigator-OptiLite — setup.sh
#  Run ONCE after SSHing into your MI300X droplet
#
#  What this does:
#  - Installs Python deps into the existing JupyterLab env
#  - Clones the repo into the right place
#  - Does NOT touch ROCm (already installed at 7.2)
#  - Does NOT reinstall Jupyter (already running)
#
#  Usage:
#    ssh root@YOUR_DROPLET_IP
#    git clone https://github.com/DEVIRORUN/Navigator-OptiLite.git
#    cd Navigator-OptiLite
#    bash setup.sh
# ============================================================

set -e

echo ""
echo "================================================="
echo "  Navigator-OptiLite Setup"
echo "  AMD MI300X | ROCm 7.2 | YOLOv8"
echo "================================================="
echo ""

# ── 1. Verify ROCm is present ───────────────────────────────
echo "[1/4] Checking ROCm 7.2..."
if command -v rocm-smi &> /dev/null; then
    rocm-smi --showproductname 2>/dev/null || echo "ROCm found"
    echo "ROCm OK ✓"
else
    echo "WARNING: rocm-smi not found in PATH."
    echo "This is fine if you're running inside the pre-configured JupyterLab env."
    echo "If YOLO can't find the GPU later, run: docker exec -it rocm /bin/bash"
fi
echo ""

# ── 2. Install Python deps ──────────────────────────────────
echo "[2/4] Installing Python dependencies..."
pip install --upgrade pip -q

# PyTorch for ROCm 7.2 (gfx942 = MI300X)
echo "  → PyTorch (ROCm 6.2.4 wheel — latest stable for MI300X)..."
pip install torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/rocm6.2 -q

echo "  → YOLOv8 + CV stack..."
pip install \
    ultralytics \
    opencv-python-headless \
    Pillow \
    numpy \
    ipywidgets \
    -q

echo "Python deps installed ✓"
echo ""

# ── 3. Enable ipywidgets in JupyterLab ─────────────────────
echo "[3/4] Enabling ipywidgets extension..."
jupyter labextension list 2>/dev/null | grep -q "jupyter-widgets" && \
    echo "ipywidgets already enabled ✓" || \
    pip install jupyterlab-widgets -q && \
    echo "ipywidgets enabled ✓"
echo ""

# ── 4. Pre-download YOLO model weights ─────────────────────
echo "[4/4] Pre-downloading YOLOv8n weights..."
python3 -c "
from ultralytics import YOLO
model = YOLO('yolov8n.pt')
print('YOLOv8n weights ready ✓')
"
echo ""

# ── Done ────────────────────────────────────────────────────
echo "================================================="
echo ""
echo "  Setup complete!"
echo ""
echo "  Next steps:"
echo "  1. Go to your Droplet page → copy IPv4 address"
echo "  2. Open http://YOUR_DROPLET_IP in browser"
echo "  3. Paste the token from your SSH terminal"
echo "  4. Open notebooks/yolo_detection.ipynb"
echo "  5. Run all cells → click Start Stream"
echo ""
echo "  To save work before destroying droplet:"
echo "    git add . && git commit -m 'checkpoint' && git push"
echo ""
echo "================================================="