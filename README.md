# 🌐 ASP.NET Client-Server Architecture Project

An interactive Web Application built with **ASP.NET (.NET Framework 4.7.2)** demonstrating how a client (browser) sends an HTTP request to a backend server (IIS Express / ASP.NET Engine) and receives an HTTP response containing a server-generated flag.

---

## 🚀 Key Features & Workflow

- **Client-Side Interface**: Allows the user to enter a custom message/payload and send an HTTP POST request to the server.
- **Server-Side Execution**: Receives the request in `Default.aspx.cs`, processes request metadata (Timestamp, Client IP, Host Header, HTTP Method), and sets custom response headers.
- **Server Flag Output**: Generates and displays the flag: **`HELLO RINKU MAM`** upon successful server response.

---

## ⚡ System Architecture Diagram

```
+------------------+                    +-----------------------+                    +-----------------------+
|  Client Browser  |                    |      IIS Express      |                    |    ASP.NET Engine     |
| (Frontend Page)  |                    |     (Web Server)      |                    |     (C# Backend)      |
+--------+---------+                    +-----------+-----------+                    +-----------+-----------+
         |                                          |                                            |
         | ---- 1. Send HTTP POST Request --------> |                                            |
         |      (Payload: Client Message)           | ---- 2. Route Request to ASP.NET --------> |
         |                                          |                                            | ---- 3. Process Request
         |                                          |                                            |      & Set Server Flag
         |                                          |                                            |      "HELLO RINKU MAM"
         |                                          | <--- 4. Return Output -------------------- |
         | <--- 5. HTTP 200 OK Response ---------- |                                            |
         |      (Flag: HELLO RINKU MAM)             |                                            |
         v                                          v                                            v
```

---

## 📁 Project Structure

```
your project/
├── YourProject.sln                # Visual Studio Solution File
└── WebApplication5/               # ASP.NET Web Application Folder
    ├── Default.aspx               # Client UI Page
    ├── Default.aspx.cs            # Server C# Code-behind Logic
    ├── Default.aspx.designer.cs   # ASP.NET Web Forms Designer definitions
    └── Web.config                 # ASP.NET Configuration
```

---

## 💻 Server Code Highlight (`Default.aspx.cs`)

```csharp
protected void btnSend_Click(object sender, EventArgs e)
{
    // Set custom Response Header for client inspection
    Response.AddHeader("X-Server-Flag", "HELLO RINKU MAM");

    // Server-side flag generation
    string flag = "HELLO RINKU MAM";
    litFlag.Text = flag;

    // Retrieve client input payload
    string clientMsg = txtClientMessage.Text;
    lblResponseMessage.Text = "Server received and processed request payload: <strong>" + Server.HtmlEncode(clientMsg) + "</strong>";

    // Output server metadata
    lblTimestamp.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
    lblHttpMethod.Text = Request.HttpMethod;
    lblServerHost.Text = Request.Url.Host + ":" + Request.Url.Port;

    // Show response container
    pnlResponse.Visible = true;
}
```

---

## 🛠️ How to Run Locally

1. Clone or download this repository.
2. Open **`YourProject.sln`** in **Visual Studio**.
3. Press **F5** (or click **IIS Express**).
4. In your browser, click **Send Request to Server** to view the response and flag **`HELLO RINKU MAM`**.
