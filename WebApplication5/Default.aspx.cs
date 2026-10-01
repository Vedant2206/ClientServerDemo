using System;
using System.Web;
using System.Web.UI;

namespace WebApplication5
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            // Set custom Response Header for client inspection
            Response.AddHeader("X-Server-Flag", "HELLO RINKU MAM");

            // Server-side flag generation
            string flag = "HELLO RINKU MAM";
            litFlag.Text = flag;

            // Retrieve client input safely
            string clientMsg = txtClientMessage.Text;
            if (string.IsNullOrWhiteSpace(clientMsg))
            {
                clientMsg = "Empty request sent from client.";
            }

            // Construct Server Response message
            lblResponseMessage.Text = "Server received and processed request payload: <strong>" + Server.HtmlEncode(clientMsg) + "</strong>";

            // Server metadata
            lblTimestamp.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");
            lblHttpMethod.Text = Request.HttpMethod;
            lblServerHost.Text = Request.Url.Host + ":" + Request.Url.Port;
            lblClientIP.Text = string.IsNullOrEmpty(Request.UserHostAddress) ? "127.0.0.1" : Request.UserHostAddress;

            // Display response panel
            pnlResponse.Visible = true;
        }
    }
}
