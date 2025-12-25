#!/bin/bash

# ============================================
# COMPLETE AUTOMATIC DESIGNERFX27 PROXY SETUP
# Premium Proxy Service by DESIGNERFX27
# Telegram: https://t.me/Designerfx27
# ============================================

echo ""
echo "██████╗ ███████╗███████╗██╗ ██████╗ ███╗   ██╗███████╗███████╗██████╗ ███████╗██╗  ██╗███████╗"
echo "██╔══██╗██╔════╝██╔════╝██║██╔════╝ ████╗  ██║██╔════╝██╔════╝██╔══██╗██╔════╝╚██╗██╔╝██╔════╝"
echo "██║  ██║█████╗  ███████╗██║██║  ███╗██╔██╗ ██║█████╗  █████╗  ██████╔╝█████╗   ╚███╔╝ ███████╗"
echo "██║  ██║██╔══╝  ╚════██║██║██║   ██║██║╚██╗██║██╔══╝  ██╔══╝  ██╔══██╗██╔══╝   ██╔██╗ ╚════██║"
echo "██████╔╝███████╗███████║██║╚██████╔╝██║ ╚████║███████╗███████╗██║  ██║███████╗██╔╝ ██╗███████║"
echo "╚═════╝ ╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝"
echo "╔══════════════════════════════════════════════════════════════════════════════════════════════╗"
echo "║                                    🚀 P R E M I U M  P R O X Y                                 ║"
echo "║                          Telegram: https://t.me/Designerfx27                                 ║"
echo "╚══════════════════════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "=== COMPLETE AUTOMATIC PROXY SETUP ==="
echo "✅ One script to install everything!"
echo "📞 Premium Support: https://t.me/Designerfx27"
echo ""

# ==================== CONFIGURATION ====================
BRAND_NAME="DESIGNERFX27 PREMIUM PROXY"
TELEGRAM_AD="𔒟𝘿𝙀𝙎𝙄𝙂𝙉𝙀𝙍🀛𝙛𝙭🀠𝟮𝟳"
TELEGRAM_LINK="https://t.me/Designerfx27"
AD_TITLE="🚀 DESIGNERFX27 PREMIUM PROXY SERVICE"
FLASK_PORT="9000"
NGINX_PORT="80"
INSTALL_DIR="/opt/DESIGNERFX27-proxy"
DOMAIN_NAME=""  # Leave empty for IP access
# =======================================================

# Color output functions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_step() { echo -e "${YELLOW}🔧 $1${NC}"; }
print_banner() { echo -e "${PURPLE}$1${NC}"; }
print_ad() { echo -e "${CYAN}📢 $1${NC}"; }

# Function to check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run as root!"
        echo "Use: sudo bash $0"
        exit 1
    fi
}

# Function to get server IP
get_server_ip() {
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    PUBLIC_IP=$(curl -s ifconfig.me || curl -s ipinfo.io/ip || echo "$LOCAL_IP")
    echo "$PUBLIC_IP"
}

# Function to install Python and Flask
install_python_flask() {
    print_step "Step 2: Installing Python and Flask..."
    apt-get install -y python3 python3-pip python3-venv python3-dev
    apt-get install -y build-essential libssl-dev libffi-dev
    apt-get install -y curl wget git nano htop ufw
    
    # Create virtual environment
    cd $INSTALL_DIR
    python3 -m venv venv
    source venv/bin/activate
    
    # Install Python packages
    pip install --upgrade pip
    pip install flask requests gunicorn
    pip install cryptography
    
    deactivate
    print_success "Python and Flask installed successfully"
}

# Function to install and configure NGINX
install_nginx() {
    print_step "Step 3: Installing and Configuring NGINX..."
    apt-get install -y nginx
    
    # Create NGINX configuration
    cat > /etc/nginx/sites-available/DESIGNERFX27-proxy << EOF
server {
    listen 80;
    server_name _;
    
    # DESIGNERFX27 Proxy Access Log
    access_log /var/log/nginx/DESIGNERFX27-access.log;
    error_log /var/log/nginx/DESIGNERFX27-error.log;
    
    location / {
        proxy_pass http://localhost:$FLASK_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        
        # DESIGNERFX27 Premium Proxy Headers
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
    
    # Block access to sensitive files
    location ~ /\. { deny all; }
    location ~ ~$ { deny all; }
}
EOF
    
    # Enable site and disable default
    ln -sf /etc/nginx/sites-available/DESIGNERFX27-proxy /etc/nginx/sites-enabled/
    rm -f /etc/nginx/sites-enabled/default
    
    # Test and restart NGINX
    nginx -t && systemctl restart nginx
    systemctl enable nginx
    
    print_success "NGINX installed and configured"
}

# Function to create Flask application
create_flask_app() {
    print_step "Step 4: Creating DESIGNERFX27 Flask Application..."
    
    # Create main application file
    cat > $INSTALL_DIR/DESIGNERFX27_app.py << EOF
from flask import Flask, request, Response, render_template_string
import requests
import base64
import re
import urllib.parse

app = Flask(__name__)

# ==================== DESIGNERFX27 CONFIGURATION ====================
TELEGRAM_AD = "$TELEGRAM_AD"
TELEGRAM_LINK = "$TELEGRAM_LINK"
BRAND_NAME = "$BRAND_NAME"
AD_TITLE = "$AD_TITLE"
# ====================================================================

def is_likely_base64(text):
    """Check if text is likely base64 encoded."""
    pattern = r'^[A-Za-z0-9+/]*=*$'
    text = text.strip().replace('\\n', '')
    return bool(re.match(pattern, text) and len(text) % 4 == 0)

def decode_if_base64(content):
    """Decode content if it's base64, otherwise return as is."""
    cleaned = content.strip()
    if is_likely_base64(cleaned):
        try:
            return base64.b64decode(cleaned).decode('utf-8')
        except:
            return content
    return content

# ==================== HTML TEMPLATES ====================
MAIN_HTML = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ brand }} - Premium Proxy Service</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', system-ui, sans-serif; }
        body { background: linear-gradient(135deg, #0f172a, #1e293b); color: #e2e8f0; min-height: 100vh; }
        
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        
        /* Header */
        .header { background: rgba(30, 41, 59, 0.9); backdrop-filter: blur(10px); border-bottom: 2px solid #3b82f6; padding: 1.5rem; border-radius: 0 0 20px 20px; margin-bottom: 2rem; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3); }
        .brand { display: flex; align-items: center; gap: 15px; margin-bottom: 1rem; }
        .logo { font-size: 2.8rem; background: linear-gradient(90deg, #8b5cf6, #3b82f6); -webkit-background-clip: text; -webkit-text-fill-color: transparent; filter: drop-shadow(0 0 10px rgba(139, 92, 246, 0.5)); }
        .brand-text h1 { font-size: 2.2rem; background: linear-gradient(90deg, #60a5fa, #a78bfa); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 0.3rem; }
        .brand-text p { color: #94a3b8; font-size: 1rem; }
        
        /* Ad Banner */
        .ad-banner { background: linear-gradient(90deg, #1e3a8a, #3730a3); border: 1px solid #4f46e5; border-radius: 12px; padding: 1.2rem; margin: 1.5rem 0; text-align: center; box-shadow: 0 0 25px rgba(79, 70, 229, 0.3); animation: pulse 2s infinite; }
        @keyframes pulse { 0% { box-shadow: 0 0 25px rgba(79, 70, 229, 0.3); } 50% { box-shadow: 0 0 35px rgba(79, 70, 229, 0.5); } 100% { box-shadow: 0 0 25px rgba(79, 70, 229, 0.3); } }
        .ad-banner h3 { color: #ffffff; font-size: 1.4rem; margin-bottom: 0.5rem; display: flex; align-items: center; justify-content: center; gap: 10px; }
        .ad-banner a { color: #60a5fa; text-decoration: none; font-weight: bold; font-size: 1.2rem; transition: color 0.3s; }
        .ad-banner a:hover { color: #38bdf8; text-decoration: underline; }
        
        /* Main Content */
        .main-content { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 2rem; }
        @media (max-width: 768px) { .main-content { grid-template-columns: 1fr; } }
        
        .panel { background: rgba(30, 41, 59, 0.7); border: 1px solid #475569; border-radius: 16px; padding: 1.8rem; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); }
        .panel h2 { color: #60a5fa; margin-bottom: 1.2rem; padding-bottom: 0.7rem; border-bottom: 2px solid #334155; font-size: 1.5rem; }
        
        /* Form */
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; color: #cbd5e1; margin-bottom: 0.5rem; font-weight: 500; }
        input[type="text"] { width: 100%; padding: 0.9rem 1.2rem; background: rgba(15, 23, 42, 0.8); border: 1px solid #475569; border-radius: 10px; color: #f1f5f9; font-size: 1rem; transition: all 0.3s; }
        input[type="text"]:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2); }
        .btn { background: linear-gradient(90deg, #3b82f6, #8b5cf6); color: white; border: none; padding: 1rem 2rem; border-radius: 10px; font-size: 1.1rem; font-weight: bold; cursor: pointer; transition: all 0.3s; width: 100%; margin-top: 0.5rem; }
        .btn:hover { background: linear-gradient(90deg, #2563eb, #7c3aed); transform: translateY(-2px); box-shadow: 0 7px 15px rgba(59, 130, 246, 0.4); }
        
        /* Examples */
        .examples { margin-top: 1.5rem; }
        .example-item { background: rgba(15, 23, 42, 0.5); border-left: 4px solid #8b5cf6; padding: 1rem; margin-bottom: 1rem; border-radius: 0 8px 8px 0; }
        .example-item code { color: #a78bfa; background: rgba(139, 92, 246, 0.1); padding: 0.2rem 0.5rem; border-radius: 4px; display: block; margin-top: 0.5rem; word-break: break-all; }
        
        /* Results */
        .result-area { margin-top: 1.5rem; }
        textarea { width: 100%; min-height: 300px; padding: 1.2rem; background: rgba(15, 23, 42, 0.9); border: 1px solid #475569; border-radius: 10px; color: #d1d5db; font-family: 'Cascadia Code', 'Monaco', monospace; font-size: 0.9rem; resize: vertical; line-height: 1.5; }
        
        /* Info Box */
        .info-box { background: rgba(22, 163, 74, 0.1); border: 1px solid #22c55e; border-radius: 10px; padding: 1.2rem; margin-top: 1.5rem; }
        .info-box h3 { color: #22c55e; margin-bottom: 0.7rem; }
        
        /* Footer */
        .footer { margin-top: 3rem; text-align: center; color: #64748b; font-size: 0.9rem; padding-top: 1.5rem; border-top: 1px solid #334155; }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <header class="header">
            <div class="brand">
                <div class="logo">🔮</div>
                <div class="brand-text">
                    <h1>{{ ad_title }}</h1>
                    <p>Powerful proxy service for processing Marzban subscriptions</p>
                </div>
            </div>
            
            <!-- Ad Banner -->
            <div class="ad-banner">
                <h3>🚀 <strong>PREMIUM SERVICES BY {{ telegram_ad }}</strong></h3>
                <p>High-quality proxy configurations, custom solutions, and technical support</p>
                <p><a href="{{ telegram_link }}" target="_blank">👉 Contact on Telegram: {{ telegram_ad }} 👈</a></p>
            </div>
        </header>

        <div class="main-content">
            <!-- Left Column: Form -->
            <div class="panel">
                <h2>🛠️ Proxy Generator</h2>
                <form id="proxyForm">
                    <div class="form-group">
                        <label for="key">Key (any word):</label>
                        <input type="text" id="key" value="premium" placeholder="e.g., premium, vip, proxy">
                    </div>
                    <div class="form-group">
                        <label for="url">Marzban Subscription URL:</label>
                        <input type="text" id="url" placeholder="http://sub.asmanow.online:8000/sub/YOUR_CODE" value="">
                    </div>
                    <button type="button" class="btn" onclick="generateProxy()">🚀 Generate Proxy</button>
                </form>
                
                <div class="examples">
                    <h3>📋 Example URLs:</h3>
                    <div class="example-item">
                        <p>Basic example:</p>
                        <code id="example1">/macros/s/premium/exec?url=https://example.com/sub/ID</code>
                    </div>
                    <div class="example-item">
                        <p>Your server:</p>
                        <code id="example2">/macros/s/vip/exec?url=http://sub.asmanow.online:8000/sub/SnNqZCwxNzY1Mzk3MDAwtXP8/M5U5J</code>
                    </div>
                </div>
            </div>

            <!-- Right Column: Result -->
            <div class="panel">
                <h2>📄 Result</h2>
                <div class="result-area">
                    <textarea id="resultOutput" placeholder="Result will appear here..."></textarea>
                </div>
                <div class="info-box">
                    <h3>ℹ️ How it works:</h3>
                    <p>1. Automatically decodes base64 from source URL</p>
                    <p>2. Adds premium metadata to subscription</p>
                    <p>3. Returns ready-to-use Marzban subscription</p>
                    <p>4. <strong>Support:</strong> {{ telegram_ad }}</p>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <p>© 2024 {{ brand }} | Enhanced Proxy Service | Developed by {{ telegram_ad }}</p>
            <p style="margin-top: 10px; font-size: 1.1rem;">
                <strong>💎 Premium Service Contact:</strong> 
                <a href="{{ telegram_link }}" target="_blank" style="color: #60a5fa;">{{ telegram_link }}</a>
            </p>
        </footer>
    </div>

    <script>
        function generateProxy() {
            const key = document.getElementById('key').value || 'premium';
            const url = document.getElementById('url').value;
            
            if (!url) {
                alert('Please enter subscription URL!');
                return;
            }
            
            const proxyUrl = \`/macros/s/\${encodeURIComponent(key)}/exec?url=\${encodeURIComponent(url)}\`;
            
            // Show loading
            document.getElementById('resultOutput').value = '⏳ Loading and processing subscription...';
            
            // API Request
            fetch(proxyUrl)
                .then(response => {
                    if (!response.ok) throw new Error(\`Error: \${response.status}\`);
                    return response.text();
                })
                .then(data => {
                    document.getElementById('resultOutput').value = data;
                })
                .catch(error => {
                    document.getElementById('resultOutput').value = \`❌ Error: \${error.message}\\n\\nContact \${'{{ telegram_ad }}'} for support.\`;
                });
        }
        
        // Set example URLs
        document.addEventListener('DOMContentLoaded', function() {
            const currentHost = window.location.origin;
            document.getElementById('example1').textContent = \`\${currentHost}/macros/s/premium/exec?url=https://example.com/sub/ID\`;
            document.getElementById('example2').textContent = \`\${currentHost}/macros/s/vip/exec?url=http://sub.asmanow.online:8000/sub/SnNqZCwxNzY1Mzk3MDAwtXP8/M5U5J\`;
        });
    </script>
</body>
</html>
'''

ERROR_HTML = '''
<!DOCTYPE html>
<html>
<head><title>Error</title><style>body{font-family:sans-serif;padding:2rem;background:#0f172a;color:white;}</style></head>
<body>
    <h1>❌ Error</h1>
    <p>{{ error }}</p>
    <p>Contact <a href="{{ telegram_link }}" style="color:#60a5fa;">{{ telegram_ad }}</a> for support.</p>
</body>
</html>
'''

@app.route('/macros/s/<key>/exec')
def exec_macro(key):
    target_url = request.args.get('url')
    if not target_url:
        return render_template_string(ERROR_HTML, 
            telegram_ad=TELEGRAM_AD,
            telegram_link=TELEGRAM_LINK,
            error="Missing URL parameter (?url=...)")

    try:
        # 1. Get data from target URL
        headers = {'User-Agent': 'Mozilla/5.0 (DESIGNERFX27 Proxy 1.0)'}
        response = requests.get(target_url, headers=headers, timeout=25)
        
        if response.status_code != 200:
            return f'Error: Target server returned {response.status_code}', 502
        
        # 2. Decode if it's base64
        original_content = response.text.strip()
        decoded_content = decode_if_base64(original_content)
        
        # 3. Create metadata (partially in base64)
        title_b64 = base64.b64encode("PREMIUM SUBSCRIPTION BY DESIGNERFX27".encode()).decode()
        announce_b64 = base64.b64encode("Renew your subscription on time!".encode()).decode()
        
        metadata = f"""#profile-title: base64:{title_b64}
#profile-update-interval: 1
#profile-web-page-url: {TELEGRAM_LINK}
#support-url: {TELEGRAM_LINK}
#subscription-userinfo: upload=0; download=0; total=1073741824000; expire=2546244611
#announce: base64:{announce_b64}
#profile-icon: https://img.icons8.com/color/96/000000/telegram-app.png
#profile-remarks: base64:{base64.b64encode(f"Created via {BRAND_NAME}".encode()).decode()}

"""
        
        # 4. Combine metadata and content
        final_output = metadata + decoded_content
        
        # 5. Add promotional comment at the end
        final_output += f"\\n\\n# 🔥 PREMIUM PROXY SERVICE\\n# 💎 Created by: {TELEGRAM_AD}\\n# 📱 Telegram Support: {TELEGRAM_LINK}\\n# 🚀 Powered by {BRAND_NAME}"
        
        return Response(final_output, mimetype='text/plain')
        
    except requests.exceptions.Timeout:
        return 'Error: Connection timeout', 504
    except Exception as e:
        return f'Error: {str(e)}', 500

@app.route('/')
def index():
    return render_template_string(MAIN_HTML,
        brand=BRAND_NAME,
        ad_title=AD_TITLE,
        telegram_ad=TELEGRAM_AD,
        telegram_link=TELEGRAM_LINK)

@app.route('/health')
def health():
    return '✅ Service is running', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=${FLASK_PORT}, debug=False)
EOF
    
    print_success "DESIGNERFX27 Flask application created"
}

# Function to create systemd service
create_systemd_service() {
    print_step "Step 5: Creating Systemd Service..."
    
    cat > /etc/systemd/system/DESIGNERFX27-proxy.service << EOF
[Unit]
Description=DESIGNERFX27 Premium Proxy Service
After=network.target
Wants=network.target

[Service]
Type=simple
User=root
WorkingDirectory=${INSTALL_DIR}
Environment="PATH=${INSTALL_DIR}/venv/bin"
ExecStart=${INSTALL_DIR}/venv/bin/python ${INSTALL_DIR}/DESIGNERFX27_app.py
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=DESIGNERFX27-proxy

# Security
NoNewPrivileges=true
ProtectSystem=strict
PrivateTmp=true
PrivateDevices=true

[Install]
WantedBy=multi-user.target
EOF
    
    systemctl daemon-reload
    systemctl start DESIGNERFX27-proxy
    systemctl enable DESIGNERFX27-proxy
    
    print_success "Systemd service created and started"
}

# Function to configure firewall
configure_firewall() {
    print_step "Step 6: Configuring Firewall..."
    
    # Install UFW if not present
    if ! command -v ufw &> /dev/null; then
        apt-get install -y ufw
    fi
  