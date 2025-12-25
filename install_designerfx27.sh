#!/bin/bash

# ====================================================
# DESIGNERFX27 PREMIUM PROXY - COMPLETE INSTALLATION
# One-Click Automatic Setup Script
# Creator: 𔒟𝘿𝙀𝙎𝙄𝙂𝙉𝙀𝙍🀛𝙛𝙭🀠𝟮𝟳
# Telegram: https://t.me/Designerfx27
# ====================================================

# ASCII ART BANNER
clear
echo ""
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                                                                              ║"
echo "║  ██████╗ ███████╗███████╗██╗ ██████╗ ███╗   ██╗███████╗███████╗██████╗       ║"
echo "║  ██╔══██╗██╔════╝██╔════╝██║██╔════╝ ████╗  ██║██╔════╝██╔════╝██╔══██╗      ║"
echo "║  ██║  ██║█████╗  ███████╗██║██║  ███╗██╔██╗ ██║█████╗  █████╗  ██████╔╝      ║"
echo "║  ██║  ██║██╔══╝  ╚════██║██║██║   ██║██║╚██╗██║██╔══╝  ██╔══╝  ██╔══██╗      ║"
echo "║  ██████╔╝███████╗███████║██║╚██████╔╝██║ ╚████║███████╗███████╗██║  ██║      ║"
echo "║  ╚═════╝ ╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═╝      ║"
echo "║                                                                              ║"
echo "║  ██████╗ ██████╗  ██████╗ ██╗  ██╗██╗   ██╗    ██████╗ ██████╗ ███████╗      ║"
echo "║  ██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔════╝      ║"
echo "║  ██████╔╝██████╔╝██║   ██║ ╚███╔╝  ╚████╔╝     ██████╔╝██████╔╝█████╗        ║"
echo "║  ██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗   ╚██╔╝      ██╔═══╝ ██╔══██╗██╔══╝        ║"
echo "║  ██║     ██║  ██║╚██████╔╝██╔╝ ██╗   ██║       ██║     ██║  ██║███████╗      ║"
echo "║  ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝╚══════╝      ║"
echo "║                                                                              ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "                          🚀 PREMIUM PROXY AUTO-INSTALLER"
echo "                     Telegram Support: https://t.me/Designerfx27"
echo ""

# ==================== CONFIGURATION ====================
BRAND_NAME="DESIGNERFX27 PREMIUM PROXY"
TELEGRAM_AD="𔒟𝘿𝙀𝙎𝙄𝙂𝙉𝙀𝙍🀛𝙛𝙭🀠𝟮𝟳"
TELEGRAM_LINK="https://t.me/Designerfx27"
AD_TITLE="🚀 DESIGNERFX27 PREMIUM PROXY SERVICE"
FLASK_PORT="9000"
INSTALL_DIR="/opt/DESIGNERFX27-proxy"
# =======================================================

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Print functions
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_step() { echo -e "${YELLOW}🔧 $1${NC}"; }
print_banner() { echo -e "${PURPLE}$1${NC}"; }
print_ad() { echo -e "${CYAN}📢 $1${NC}"; }

# Check root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run as root!"
        echo "Use: sudo bash $0"
        exit 1
    fi
}

# Get server IP
get_server_ip() {
    IP=$(curl -s ifconfig.me 2>/dev/null || hostname -I | awk '{print $1}')
    echo "$IP"
}

# Domain configuration
configure_domain() {
    echo ""
    print_info "🌐 DOMAIN CONFIGURATION"
    echo "========================================"
    echo ""
    echo "Choose your access method:"
    echo "1. Use domain name (e.g., proxy.yourdomain.com)"
    echo "2. Use IP address only (recommended for testing)"
    echo ""
    read -p "Enter your domain name (or press Enter for IP only): " USER_DOMAIN
    
    if [[ -n "$USER_DOMAIN" ]]; then
        DOMAIN_NAME="$USER_DOMAIN"
        print_success "Domain set to: $DOMAIN_NAME"
        print_info "Make sure DNS A record points to your server IP"
    else
        DOMAIN_NAME=""
        SERVER_IP=$(get_server_ip)
        print_info "Using IP address: $SERVER_IP"
    fi
    echo ""
}

# Main installation function
main_installation() {
    clear
    print_banner "🚀 STARTING DESIGNERFX27 PREMIUM PROXY INSTALLATION"
    print_ad "Premium Service by: $TELEGRAM_AD"
    print_ad "Telegram Support: $TELEGRAM_LINK"
    echo ""
    
    # Check root
    check_root
    
    # Ask for domain
    configure_domain
    
    # Confirmation
    read -p "Continue with installation? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Installation cancelled."
        exit 1
    fi
    
    # ==================== STEP 1: SYSTEM UPDATE ====================
    print_step "STEP 1: UPDATING SYSTEM PACKAGES..."
    apt-get update -y
    apt-get upgrade -y
    apt-get install -y software-properties-common
    print_success "System updated successfully"
    
    # ==================== STEP 2: INSTALL PYTHON & FLASK ====================
    print_step "STEP 2: INSTALLING PYTHON AND FLASK..."
    apt-get install -y python3 python3-pip python3-venv python3-dev
    apt-get install -y build-essential libssl-dev libffi-dev
    apt-get install -y curl wget git nano ufw
    
    # Create installation directory
    mkdir -p $INSTALL_DIR
    cd $INSTALL_DIR
    
    # Create virtual environment
    python3 -m venv venv
    source venv/bin/activate
    
    # Install Python packages
    pip install --upgrade pip
    pip install flask requests gunicorn
    pip install cryptography
    
    deactivate
    print_success "Python and Flask installed"
    
    # ==================== STEP 3: INSTALL NGINX ====================
    print_step "STEP 3: INSTALLING AND CONFIGURING NGINX..."
    apt-get install -y nginx
    
    # Configure NGINX
    if [[ -n "$DOMAIN_NAME" ]]; then
        NGINX_CONFIG="server_name $DOMAIN_NAME;"
    else
        NGINX_CONFIG="server_name _;"
    fi
    
    cat > /etc/nginx/sites-available/DESIGNERFX27-proxy << EOF
server {
    listen 80;
    $NGINX_CONFIG
    
    # DESIGNERFX27 Proxy Logs
    access_log /var/log/nginx/DESIGNERFX27-access.log;
    error_log /var/log/nginx/DESIGNERFX27-error.log;
    
    location / {
        proxy_pass http://localhost:$FLASK_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        
        # DESIGNERFX27 Headers
        proxy_set_header X-Proxy-Provider "DESIGNERFX27 Premium Service";
        proxy_set_header X-Contact "Telegram: $TELEGRAM_AD";
        
        # WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        
        # Timeout settings
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 300s;
    }
}
EOF
    
    # Enable NGINX site
    ln -sf /etc/nginx/sites-available/DESIGNERFX27-proxy /etc/nginx/sites-enabled/
    rm -f /etc/nginx/sites-enabled/default
    
    # Test and restart NGINX
    nginx -t
    systemctl restart nginx
    systemctl enable nginx
    
    print_success "NGINX installed and configured"
    
    # ==================== STEP 4: CREATE FLASK APPLICATION ====================
    print_step "STEP 4: CREATING DESIGNERFX27 FLASK APPLICATION..."
    
    # Create the main application file
    cat > $INSTALL_DIR/DESIGNERFX27_app.py << 'EOF'
from flask import Flask, request, Response, render_template_string
import requests
import base64
import re

app = Flask(__name__)

# ==================== DESIGNERFX27 CONFIG ====================
TELEGRAM_AD = "𔒟𝘿𝙀𝙎𝙄𝙂𝙉𝙀𝙍🀛𝙛𝙭🀠𝟮𝟳"
TELEGRAM_LINK = "https://t.me/Designerfx27"
BRAND_NAME = "DESIGNERFX27 PREMIUM PROXY"
# =============================================================

def is_base64(text):
    """Check if text is base64 encoded."""
    pattern = r'^[A-Za-z0-9+/]*=*$'
    text = text.strip().replace('\n', '')
    return bool(re.match(pattern, text) and len(text) % 4 == 0)

def decode_if_base64(content):
    """Decode if content is base64."""
    cleaned = content.strip()
    if is_base64(cleaned):
        try:
            return base64.b64decode(cleaned).decode('utf-8')
        except:
            return content
    return content

# HTML Template
MAIN_HTML = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DESIGNERFX27 Premium Proxy</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: #0f172a; color: #e2e8f0; min-height: 100vh; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { text-align: center; padding: 2rem; background: rgba(30, 41, 59, 0.9); border-radius: 15px; margin-bottom: 2rem; border: 1px solid #3b82f6; }
        .ad-banner { background: linear-gradient(90deg, #1e3a8a, #3730a3); padding: 1rem; border-radius: 10px; margin: 1rem 0; text-align: center; }
        .panel { background: rgba(30, 41, 59, 0.7); padding: 1.5rem; border-radius: 10px; margin: 1rem 0; }
        input, textarea, button { width: 100%; padding: 0.8rem; margin: 0.5rem 0; border-radius: 5px; border: 1px solid #475569; background: rgba(15, 23, 42, 0.8); color: white; }
        button { background: #3b82f6; border: none; cursor: pointer; font-weight: bold; }
        button:hover { background: #2563eb; }
        .footer { text-align: center; margin-top: 2rem; color: #94a3b8; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 DESIGNERFX27 PREMIUM PROXY</h1>
            <p>High-performance proxy service for Marzban subscriptions</p>
        </div>
        
        <div class="ad-banner">
            <h3>💎 PREMIUM SERVICES BY {{ telegram_ad }}</h3>
            <p><a href="{{ telegram_link }}" target="_blank">📱 Contact on Telegram: {{ telegram_ad }}</a></p>
        </div>
        
        <div class="panel">
            <h2>🔧 Proxy Generator</h2>
            <input type="text" id="key" placeholder="Enter key (e.g., premium)" value="premium">
            <input type="text" id="url" placeholder="Enter Marzban subscription URL">
            <button onclick="generateProxy()">🚀 Generate Proxy</button>
        </div>
        
        <div class="panel">
            <h2>📄 Result</h2>
            <textarea id="result" rows="15" placeholder="Result will appear here..."></textarea>
        </div>
        
        <div class="footer">
            <p>© 2024 {{ brand }} | Powered by {{ telegram_ad }}</p>
            <p>Telegram Support: <a href="{{ telegram_link }}" style="color:#60a5fa;">{{ telegram_link }}</a></p>
        </div>
    </div>
    
    <script>
    function generateProxy() {
        const key = document.getElementById('key').value || 'premium';
        const url = document.getElementById('url').value;
        if (!url) { alert('Please enter URL!'); return; }
        
        document.getElementById('result').value = '⏳ Processing...';
        fetch('/macros/s/' + encodeURIComponent(key) + '/exec?url=' + encodeURIComponent(url))
            .then(r => r.text())
            .then(data => document.getElementById('result').value = data)
            .catch(e => document.getElementById('result').value = '❌ Error: ' + e);
    }
    </script>
</body>
</html>
'''

@app.route('/macros/s/<key>/exec')
def exec_macro(key):
    target_url = request.args.get('url')
    if not target_url:
        return 'Missing URL parameter. Use ?url=YOUR_URL', 400
    
    try:
        # Get target content
        r = requests.get(target_url, timeout=30)
        if r.status_code != 200:
            return f'Error: Target returned {r.status_code}', 502
        
        # Decode if base64
        content = r.text.strip()
        decoded = decode_if_base64(content)
        
        # Create metadata
        title_b64 = base64.b64encode("PREMIUM SUBSCRIPTION BY DESIGNERFX27".encode()).decode()
        announce_b64 = base64.b64encode("Renew subscription on time!".encode()).decode()
        
        metadata = f"""#profile-title: base64:{title_b64}
#profile-update-interval: 1
#profile-web-page-url: {TELEGRAM_LINK}
#support-url: {TELEGRAM_LINK}
#subscription-userinfo: upload=0; download=0; total=1073741824000; expire=2546244611
#announce: base64:{announce_b64}
#profile-icon: https://img.icons8.com/color/96/telegram-app.png
#profile-remarks: Created via {BRAND_NAME}

"""
        
        # Combine metadata + content
        result = metadata + decoded
        
        # Add DESIGNERFX27 footer
        result += f"\n\n# 🔥 PREMIUM PROXY SERVICE\n# 💎 Created by: {TELEGRAM_AD}\n# 📱 Telegram: {TELEGRAM_LINK}\n# 🚀 {BRAND_NAME}"
        
        return Response(result, mimetype='text/plain')
        
    except Exception as e:
        return f'Error: {str(e)}', 500

@app.route('/')
def index():
    return render_template_string(MAIN_HTML,
        brand=BRAND_NAME,
        telegram_ad=TELEGRAM_AD,
        telegram_link=TELEGRAM_LINK)

@app.route('/health')
def health():
    return '✅ DESIGNERFX27 Proxy is running', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000, debug=False)
EOF
    
    print_success "Flask application created"
    
    # ==================== STEP 5: CREATE SYSTEMD SERVICE ====================
    print_step "STEP 5: CREATING SYSTEMD SERVICE..."
    
    cat > /etc/systemd/system/DESIGNERFX27-proxy.service << EOF
[Unit]
Description=DESIGNERFX27 Premium Proxy Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=$INSTALL_DIR
Environment="PATH=$INSTALL_DIR/venv/bin"
ExecStart=$INSTALL_DIR/venv/bin/python $INSTALL_DIR/DESIGNERFX27_app.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
    
    systemctl daemon-reload
    systemctl start DESIGNERFX27-proxy
    systemctl enable DESIGNERFX27-proxy
    
    print_success "Systemd service created"
    
    # ==================== STEP 6: CONFIGURE FIREWALL ====================
    print_step "STEP 6: CONFIGURING FIREWALL..."
    
    ufw --force enable
    ufw allow 22/tcp
    ufw allow 80/tcp
    ufw reload
    
    print_success "Firewall configured"
    
    # ==================== STEP 7: FINAL SETUP ====================
    print_step "STEP 7: FINALIZING INSTALLATION..."
    
    # Get server IP
    SERVER_IP=$(get_server_ip)
    
    # Display completion message
    clear
    print_banner "🎉 INSTALLATION COMPLETED SUCCESSFULLY!"
    echo ""
    print_info "=== SERVICE INFORMATION ==="
    echo "🌐 Access URL: http://$SERVER_IP"
    if [[ -n "$DOMAIN_NAME" ]]; then
        echo "🌐 Domain URL: http://$DOMAIN_NAME"
    fi
    echo "🛠️ API Endpoint: http://$SERVER_IP/macros/s/key/exec?url=YOUR_URL"
    echo "❤️‍🩹 Health Check: http://$SERVER_IP/health"
    echo ""
    print_info "=== TEST COMMANDS ==="
    echo "📋 Test proxy:"
    echo "curl -s 'http://$SERVER_IP/macros/s/test/exec?url=https://google.com'"
    echo ""
    echo "📋 Test Marzban URL:"
    echo "curl -s 'http://$SERVER_IP/macros/s/premium/exec?url=http://sub.asmanow.online:8000/sub/EXAMPLE'"
    echo ""
    print_info "=== SERVICE STATUS ==="
    systemctl status DESIGNERFX27-proxy --no-pager | head -10
    echo ""
    print_ad "=== PREMIUM SUPPORT ==="
    echo "💎 For premium configurations and support:"
    echo "📱 Telegram: $TELEGRAM_AD"
    echo "🔗 $TELEGRAM_LINK"
    echo ""
    print_success "✅ DESIGNERFX27 Premium Proxy is now running!"
    print_success "✅ Open your browser and visit: http://$SERVER_IP"
    echo ""
    print_info "Installation log saved to: /var/log/DESIGNERFX27-install.log"
}

# Save installation log
exec > >(tee /var/log/DESIGNERFX27-install.log) 2>&1

# Run installation
main_installation

# Save this installer
cat > /root/install_DESIGNERFX27.sh << EOF
$(cat $0)
EOF

chmod +x /root/install_DESIGNERFX27.sh
print_info "Installer saved to: /root/install_DESIGNERFX27.sh"
echo ""
print_ad "Thank you for choosing DESIGNERFX27 Premium Proxy!"
