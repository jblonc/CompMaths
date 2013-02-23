<script language="C#" runat="server">

void Session_Start(object sender, EventArgs e) {
  //Response.Write("Session is Starting...<br>");
  Session.Timeout = 60;
}
</script>