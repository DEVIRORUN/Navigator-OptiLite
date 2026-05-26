#!/bin/bash
# ============================================================
#  Navigator-OptiLite — start_jupyter.sh
#
#  This script just reminds you how to connect and
#  prints your current token.
# ============================================================

echo ""
echo "================================================="
echo "  Navigator-OptiLite — How to Access JupyterLab"
echo "================================================="
echo ""
echo "  JupyterLab is already running on this droplet."
echo ""
echo "  1. Get your login token:"
echo "     Check your SSH terminal welcome message"
echo "     Look for the 'Token' field and copy it"
echo ""
echo "  2. Get your droplet IP:"
echo "     DigitalOcean dashboard → your droplet → IPv4"
echo ""
echo "  3. Open in browser:"
echo "     http://YOUR_DROPLET_IP"
echo ""
echo "  4. Paste token when prompted → Enter"
echo ""
echo "  ── Current token (if jupyter is running) ──────"
jupyter notebook list 2>/dev/null || \
jupyter server list 2>/dev/null || \
echo "  Run 'jupyter server list' to see active token"
echo ""
echo "  ── If JupyterLab stopped (rare) ───────────────"
echo "  Restart it with:"
echo "    jupyter lab --ip=0.0.0.0 --port=80 --no-browser --allow-root &"
echo ""
echo "================================================="