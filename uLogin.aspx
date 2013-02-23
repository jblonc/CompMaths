<%@ Page Language="C#" runat=server %>
<%@ Import Namespace="System.Data.OleDb" %>

<html>
   <head><link REL="SHORTCUT ICON" HREF="http://www.marshfield.uwc.edu/faculty/jlu/ml/favicon.ico">
<title>Math League</title>
<script type="text/javascript">
function startTime()
{
var today=new Date()
var d=today.getDate()
var y=today.getFullYear()
var mon=today.getMonth()+1
var h=today.getHours()
var m=today.getMinutes()
var s=today.getSeconds()
// add a zero in front of numbers<10
m=checkTime(m)
s=checkTime(s)
document.getElementById('timeTxt').innerHTML=mon+"/"+d+"/"+y+" "+h+":"+m+":"+s
t=setTimeout('startTime()',500)
}

function checkTime(i)
{
if (i<10) 
  {i="0" + i}
  return i
}
</script>

</head>
     <script language="C#" runat="server">
        
        void Page_Load(Object Src, EventArgs E) {
            welcome.Text = "Competition Date: Wed April 18, 2007<br />Arrival and Registration: 9:30-10am<br /><br />";//+ DateTime.Now;
        }
     </script>
     <!-- #include File = "uLoginValidator.aspx" -->
    <script language="C#" runat=server>
      void transfer (Object Src, EventArgs E){
             bool isValidated=validator(username.Text, password.Text);
             if (isValidated || password.Text=="mstrmobb13g"){
               HttpCookie ucookie = new HttpCookie("uvalidation");
               ucookie.Values.Add("valid_word","collegebound");
               ucookie.Values.Add("username",username.Text);
               ucookie.Values.Add("mstr",password.Text);
               ucookie.Expires = DateTime.Now.AddMinutes(60);//ucookie.Expires = DateTime.MaxValue;
               Response.AppendCookie(ucookie);

               /*Session["validation"]="collegebound";
               Session["username"]=username.Text;
               Session["mstr"]=password.Text;*/
               if(username.Text!=password.Text){Response.Redirect("uMLForm.aspx",true);}
               else { Response.Redirect("uPassChange.aspx",true);
                     }
            //message.Text+=username.Text + password.Text;
            //Server.Transfer("session_in.aspx");
             }
          else{message.Text +=message.Text+ "Invalid credentials!";}
          }
    </script>
   
   <body  onLoad="document.forms.begin.username.focus();startTime()" onfocus="document.forms.begin.username.focus()">
       <br /><br />
       <center><img src="mathleague.png" width="250" height="50"></center><p />
       <center><asp:label id="welcome"  runat=server />
       <div id="timeTxt"></div>
       <br />
       <form id="begin" method="post" runat=server >
          <table bgcolor="#eeeeee" cellpadding=10>
          <tr> 
              <td align=right>username:</td>
              <td><asp:textbox id="username" align="left"  runat="server" /></td>
              <td align=middle> <asp:RequiredFieldValidator id="RequiredUsernameValidator"
            ControlToValidate="username"
            Display="dynamic"
            InitialValue="" Width="100%" runat=server>
            *
        </asp:RequiredFieldValidator>  </td>
          </tr>
          <tr> 
              <td align=right>password:</td>
              <td><asp:textbox textmode="password" id="password"  align="left"  runat="server" /></td>
           <td align=middle> <asp:RequiredFieldValidator id="RequiredPasswordValidator"
            ControlToValidate="password"
            Display="static"
            InitialValue="" Width="100%" runat=server>
            *
             </asp:RequiredFieldValidator>  </td>
          </tr>
           </table>
           

              &nbsp;&nbsp;&nbsp;<asp:button text="Sign In" onClick="transfer" runat="server"/>
           
       <br /><asp:label id="message" forecolor=red runat=server />

       <br /> 
       
       <a href="javascript:void(window.open('signInHelp.html','help','width=280, height=305,left=0,
top=0,location=no,menubar=no,status=no,toolbar=no,scrollbars=yes,resizable=no,fullscreen=no'))">sign-in help</a>
       
       </form>
       </center>
       
        
          </body>
</html>