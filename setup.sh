#!/bin/bash
# Navigator-OptiLite Setup Script
# AMD MI300X | ROCm | PyTorch | YOLOv8 | Jupyter
# Run this once on a fresh droplet: bash setup.sh

set -e
echo "========================================="
echo " Navigator-OptiLite - Droplet Setup"
echo "========================================="

# --- 1. System deps ---
echo "[1/7] Installing system dependencies..."
apt-get update -qq
apt-get install -y -qq \
    git curl wget unzip \
    python3-pip python3-venv \
    libgl1-mesa-glx libglib2.0-0 \
    ffmpeg libsm6 libxext6

# --- 2. ROCm check ---
echo "[2/7] Checking ROCm..."
if ! command -v rocm-smi &> /dev/null; then
    echo "ROCm not found - installing ROCm 6.x..."
    wget -q https://repo.radeon.com/amdgpu-install/6.1/ubuntu/jammy/amdgpu-install_6.1.60100-1_all.deb
    apt-get install -y ./amdgpu-install_6.1.60100-1_all.deb
    amdgpu-install -y --usecase=rocm --no-dkms
else
    echo "ROCm already installed: $(rocm-smi --version 2>/dev/null || echo 'found')"
fi

# --- 3. Python venv ---
echo "[3/7] Creating Python virtual environment..."
python3 -m venv /opt/navigator-env
source /opt/navigator-env/bin/activate

pip install --upgrade pip -q

# --- 4. PyTorch for ROCm ---
echo "[4/7] Installing PyTorch (ROCm 6.0)..."
pip install torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/rocm6.0 -q

# --- 5. YOLO + CV deps ---
echo "[5/7] Installing YOLOv8 and CV deps..."
pip install \
    ultralytics \
    opencv-python-headless \
    Pillow \
    numpy \
    ipywidgets \
    ipython \
    -q

# --- 6. Jupyter ---
echo "[6/7] Installing Jupyter Lab..."
pip install jupyterlab notebook -q

# --- 7. Jupyter config ---
echo "[7/7] Configuring Jupyter..."
jupyter notebook --generate-config -y

# Set password to 'navigator' (change this!)
python3 -c "
from jupyter_server.auth import passwd
print(passwd('navigator'))
" > /tmp/jpass.txt

HASHED=$(cat /tmp/jpass.txt)

cat >> ~/.jupyter/jupyter_notebook_config.py << EOF

c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False
c.NotebookApp.password = '$HASHED'
c.NotebookApp.allow_origin = '*'
c.NotebookApp.notebook_dir = '/root/navigator-optilite'
EOF

# --- Done ---
echo ""
echo "========================================="
echo " Setup complete!"
echo ""
echo " To start Jupyter:"
echo "   source /opt/navigator-env/bin/activate"
echo "   jupyter notebook"
echo ""
echo " Then open in browser:"
echo "   http://YOUR_DROPLET_IP:8888"
echo " Password: navigator"
echo "========================================="
