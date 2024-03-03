using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null)
            {
                loginheader.Visible = true;
                logoutheader.Visible = false;
                signupheader.Visible = true;
                profileheader.Visible = false;
            }
            else if (Session["role"].ToString() == "admin")
            {
                loginheader.Visible = false;
                logoutheader.Visible = true;
                signupheader.Visible = false;
                profileheader.Visible = false;
            }
            else if (Session["role"] != null)
            {
                loginheader.Visible = false;
                logoutheader.Visible = true;
                signupheader.Visible = false;
                profileheader.Visible = true;
            }
            
        }

    }
}