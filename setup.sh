#!/bin/bash
# ============================================================
#  Navigator-OptiLite — setup.sh
#
#  Run from the HOST (not inside docker):
#    git clone https://github.com/DEVIRORUN/Navigator-OptiLite.git
#    cd Navigator-OptiLite
#    bash setup.sh
#
#  What this does:
#  1. Copies the project into the Docker container (rocm)
#  2. Installs Python deps INSIDE the container
#  3. Pre-downloads YOLOv8 weights inside the container
#
#  Everything runs inside Docker because that's where
#  Jupyter + ROCm 7.2 actually live on this droplet.
# ============================================================

set -e

echo ""
echo "================================================="
echo "  Navigator-OptiLite Setup"
echo "  AMD MI300X | ROCm 7.2 | YOLOv8"
echo "================================================="
echo ""

# ── 1. Verify Docker container is running ───────────────────
echo "[1/4] Checking Docker container..."
if ! docker ps --format '{{.Names}}' | grep -q "^rocm$"; then
    echo "ERROR: 'rocm' container is not running."
    echo "Check with: docker ps"
    exit 1
fi
echo "Container 'rocm' is running ✓"
echo ""

# ── 2. Copy project into the container ─────────────────────
echo "[2/4] Copying project into container..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
docker exec rocm mkdir -p /root/Navigator-OptiLite
docker cp "$SCRIPT_DIR/." rocm:/root/Navigator-OptiLite/
echo "Project copied to container:/root/Navigator-OptiLite ✓"
echo ""

# ── 3. Install Python deps inside container ─────────────────
echo "[3/4] Installing Python deps inside container..."
docker exec rocm bash -c "
set -e

echo '  → Upgrading pip...'
pip install --upgrade pip -q

echo '  → PyTorch for ROCm (MI300X gfx942)...'
pip install torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/rocm6.2 -q

echo '  → YOLOv8 + CV stack...'
pip install \
    ultralytics \
    opencv-python-headless \
    Pillow \
    numpy \
    ipywidgets \
    jupyterlab-widgets \
    -q

echo '  All Python deps installed ✓'
"
echo ""

# ── 4. Pre-download YOLO weights inside container ───────────
echo "[4/4] Pre-downloading YOLOv8n weights..."
docker exec rocm python3 -c "
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
echo "  Open JupyterLab:"
echo "    http://129.212.189.8"
echo "    Token: check your SSH terminal welcome message"
echo ""
echo "  In JupyterLab:"
echo "    Open  Navigator-OptiLite/notebooks/yolo_detection.ipynb"
echo "    Kernel → Restart & Run All"
echo "    Click ▶ START STREAM → allow webcam"
echo ""
echo "  Save before destroying droplet:"
echo "    git add . && git commit -m 'checkpoint' && git push"
echo ""
echo "================================================="