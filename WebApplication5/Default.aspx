<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication5.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Client-Server Architecture Demo - ASP.NET</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        :root {
            --bg-dark: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --border-color: rgba(255, 255, 255, 0.1);
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --accent: #10b981;
            --flag-gold: #f59e0b;
            --flag-glow: rgba(245, 158, 11, 0.4);
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-dark);
            background-image: 
                radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(16, 185, 129, 0.15) 0px, transparent 50%);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem 1rem;
        }

        .container {
            width: 100%;
            max-width: 900px;
        }

        header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #818cf8 0%, #c084fc 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        header p {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        /* Architecture Diagram Card */
        .arch-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
        }

        .arch-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .diagram {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            flex-wrap: wrap;
            padding: 1.5rem 1rem;
            background: rgba(15, 23, 42, 0.6);
            border-radius: 12px;
            border: 1px dashed rgba(255, 255, 255, 0.15);
        }

        .node {
            flex: 1;
            min-width: 160px;
            background: rgba(30, 41, 59, 0.9);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.25rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .node:hover {
            transform: translateY(-2px);
            border-color: var(--primary);
        }

        .node-icon {
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
            display: block;
        }

        .node-title {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--text-main);
        }

        .node-desc {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        .arrow-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 120px;
        }

        .arrow-line {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            margin: 0.25rem 0;
            width: 100%;
            justify-content: center;
        }

        .arrow-req {
            background: rgba(99, 102, 241, 0.2);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.3);
        }

        .arrow-res {
            background: rgba(16, 185, 129, 0.2);
            color: #6ee7b7;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        /* Action Form Card */
        .form-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-muted);
            margin-bottom: 0.5rem;
        }

        .input-text {
            width: 100%;
            padding: 0.85rem 1rem;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            background: rgba(15, 23, 42, 0.8);
            color: var(--text-main);
            font-family: inherit;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.2s;
        }

        .input-text:focus {
            border-color: var(--primary);
        }

        .btn-send {
            width: 100%;
            padding: 1rem;
            border-radius: 10px;
            border: none;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-hover) 100%);
            color: white;
            font-family: inherit;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-send:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 20px -3px rgba(99, 102, 241, 0.6);
        }

        .btn-send:active {
            transform: translateY(0);
        }

        /* Response Display & Flag */
        .response-card {
            background: rgba(15, 23, 42, 0.95);
            border: 1px solid rgba(16, 185, 129, 0.4);
            border-radius: 16px;
            padding: 2rem;
            margin-top: 1.5rem;
            animation: fadeIn 0.5s ease-out;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.15);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* SERVER FLAG BANNER */
        .flag-banner {
            background: linear-gradient(135deg, #b45309 0%, #78350f 100%);
            border: 2px solid var(--flag-gold);
            box-shadow: 0 0 25px var(--flag-glow);
            border-radius: 12px;
            padding: 1.25rem 1.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
            animation: pulseGlow 2s infinite alternate;
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 0 15px var(--flag-glow); }
            100% { box-shadow: 0 0 35px rgba(245, 158, 11, 0.8); }
        }

        .flag-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #fef08a;
            font-weight: 700;
            display: block;
            margin-bottom: 0.25rem;
        }

        .flag-text {
            font-size: 2rem;
            font-weight: 900;
            color: #ffffff;
            letter-spacing: 3px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
            display: block;
        }

        .meta-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .meta-item {
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid var(--border-color);
            padding: 0.85rem;
            border-radius: 10px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.85rem;
        }

        .meta-key {
            color: var(--text-muted);
            font-size: 0.75rem;
            display: block;
            margin-bottom: 0.25rem;
            font-family: 'Outfit', sans-serif;
            text-transform: uppercase;
        }

        .meta-val {
            color: var(--accent);
            font-weight: 600;
            word-break: break-all;
        }

        footer {
            text-align: center;
            margin-top: 3rem;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .badge-status {
            display: inline-block;
            background: rgba(16, 185, 129, 0.2);
            color: #34d399;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <header>
                <h1>ASP.NET Client-Server Architecture</h1>
                <p>Interactive demonstration of HTTP Request & Response processing in .NET</p>
            </header>

            <!-- Architecture Diagram -->
            <div class="arch-card">
                <div class="arch-title">
                    <span>⚡ System Workflow Architecture</span>
                </div>
                <div class="diagram">
                    <div class="node">
                        <span class="node-icon">🌐</span>
                        <div class="node-title">Client</div>
                        <div class="node-desc">Web Browser</div>
                    </div>

                    <div class="arrow-container">
                        <div class="arrow-line arrow-req">
                            <span>HTTP Request ➔</span>
                        </div>
                        <div class="arrow-line arrow-res">
                            <span>↵ HTTP Response</span>
                        </div>
                    </div>

                    <div class="node">
                        <span class="node-icon">🖥️</span>
                        <div class="node-title">IIS Express</div>
                        <div class="node-desc">Web Server</div>
                    </div>

                    <div class="arrow-container">
                        <div class="arrow-line arrow-req">
                            <span>Execute ➔</span>
                        </div>
                        <div class="arrow-line arrow-res">
                            <span>↵ Output</span>
                        </div>
                    </div>

                    <div class="node">
                        <span class="node-icon">⚙️</span>
                        <div class="node-title">ASP.NET Engine</div>
                        <div class="node-desc">C# Backend Logic</div>
                    </div>
                </div>
            </div>

            <!-- Client Request Action -->
            <div class="form-card">
                <div class="arch-title">
                    <span>📩 Send Client Request</span>
                </div>
                
                <div class="form-group">
                    <label for="txtClientMessage">Client Request Payload / Message:</label>
                    <asp:TextBox ID="txtClientMessage" runat="server" CssClass="input-text" Text="Hello Server, please process my request!"></asp:TextBox>
                </div>

                <asp:Button ID="btnSend" runat="server" Text="🚀 Send Request to Server" OnClick="btnSend_Click" CssClass="btn-send" />

                <!-- Server Response Panel -->
                <asp:Panel ID="pnlResponse" runat="server" Visible="false" CssClass="response-card">
                    <!-- SERVER FLAG -->
                    <div class="flag-banner">
                        <span class="flag-label">🚩 Server Flag Generated</span>
                        <span class="flag-text"><asp:Literal ID="litFlag" runat="server"></asp:Literal></span>
                    </div>

                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                        <h3 style="font-size: 1.2rem; font-weight: 700; color: white;">Server Response Received</h3>
                        <span class="badge-status">HTTP 200 OK</span>
                    </div>

                    <p style="color: #cbd5e1; font-size: 1rem; margin-bottom: 1rem;">
                        <asp:Label ID="lblResponseMessage" runat="server"></asp:Label>
                    </p>

                    <div class="meta-grid">
                        <div class="meta-item">
                            <span class="meta-key">Response Timestamp</span>
                            <span class="meta-val"><asp:Label ID="lblTimestamp" runat="server"></asp:Label></span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-key">Request Method</span>
                            <span class="meta-val"><asp:Label ID="lblHttpMethod" runat="server"></asp:Label></span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-key">Server Host</span>
                            <span class="meta-val"><asp:Label ID="lblServerHost" runat="server"></asp:Label></span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-key">Client IP</span>
                            <span class="meta-val"><asp:Label ID="lblClientIP" runat="server"></asp:Label></span>
                        </div>
                    </div>
                </asp:Panel>
            </div>

            <footer>
                <p>ASP.NET Client-Server Architecture Demonstration Project • Built with .NET Framework 4.7.2</p>
            </footer>
        </div>
    </form>
</body>
</html>
