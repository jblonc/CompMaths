<%@ Page Language="C#" runat=server debug="true" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Globalization" %>

<html>
   
     <script language="C#" runat="server">
         OdbcConnection dbconn;
         void Page_Load(Object Src, EventArgs E) {
         HttpCookie cookie = Request.Cookies["validation"];
          ViewState["Referer"] = Request.Headers["Referer"];
        if(cookie!=null){
         if((String)cookie.Values["valid_word"]!="allright"){Response.Redirect("adminLogin.aspx", true);} }
        else{Response.Redirect("adminLogin.aspx", true);}
         dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ufwryy6r0y.database.windows.net,1433;Database=xyzstart_db;Uid=xyzdb@ufwryy6r0y;Pwd=virAf89Hda;Encrypt=yes;Connection Timeout=30;");
         if(!IsPostBack)
         {
         BindGrid();
         Page.DataBind(); 
          }
        }
     
     
            void indGrades_Edit(Object sender, DataGridCommandEventArgs e)
        {participants.EditItemIndex = (int)e.Item.ItemIndex; BindGrid(); }
     void indGrades_Cancel(Object sender, DataGridCommandEventArgs e)
        {participants.EditItemIndex = -1; BindGrid(); }
     void indGrades_Update(Object sender, DataGridCommandEventArgs e)
        {
        
         String updateCmd="UPDATE participants SET student_id=@sid,score=@score WHERE student_id=@sid";

         OdbcCommand myUpdateCmd= new OdbcCommand(updateCmd, dbconn);
         myUpdateCmd.Parameters.Add(new OleDbParameter("@sid", OleDbType.VarChar, 9));
         
         myUpdateCmd.Parameters.Add(new OleDbParameter("@score", OleDbType.Double, 2));
         
         myUpdateCmd.Parameters["@sid"].Value=participants.DataKeys[(int)e.Item.ItemIndex];
         //String[] cols={"@sid","@tno","@cnt","@tstat","@school","@gg","@ag","@pg","@mg"};
         //int numCols=e.Item.Cells.Count;
         message.Text="";
         
             String colvalue=((System.Web.UI.WebControls.TextBox) e.Item.Cells[7].Controls[0]).Text;
             myUpdateCmd.Parameters["@score"].Value = Convert.ToDouble(colvalue);
             
          myUpdateCmd.Connection.Open();
          try{myUpdateCmd.ExecuteNonQuery();participants.EditItemIndex=-1;}
          catch(Exception ex){message.Text+="Exception with update!";}
          myUpdateCmd.Connection.Close();
          BindGrid();
         // message.Text+="working";
        }
     void BindGrid(){
        OdbcDataAdapter displayComm=new OdbcDataAdapter("SELECT student_id, name, category, roup, team_id, school, score FROM participants ORDER BY school, student_id", dbconn);
        DataSet ds= new DataSet();
        displayComm.Fill(ds, "participants");
        participants.DataSource=ds.Tables["participants"].DefaultView;
        participants.DataBind();
                }
     void updateFromExcel(Object Src, EventArgs E){
              OdbcCommand updateIndScoreCmd= new OdbcCommand("UPDATE participants SET student_id=@sid, score=@score WHERE student_id=@sid",dbconn);
              OdbcCommand selIndScoreCmd= new OdbcCommand("SELECT participants.student_id, indExcel.score FROM participants INNER JOIN indExcel ON participants.student_id=indExcel.student_id",dbconn);
              ArrayList SID= new ArrayList(); ArrayList SCORE=new ArrayList(); int numberCommon=0;
              dbconn.Open();
              OleDbDataReader dbread =selIndScoreCmd.ExecuteReader();
              while(dbread.Read()){SID.Add(dbread.GetString(0)); SCORE.Add(dbread.GetDouble(1));numberCommon++;}
              dbread.Close();
                           
               updateIndScoreCmd.Parameters.Add(new OleDbParameter("@sid", OleDbType.VarChar, 9));
               updateIndScoreCmd.Parameters.Add(new OleDbParameter("@score", OleDbType.Double, 2));
               
              for(int q=0; q<numberCommon; q++)
               {updateIndScoreCmd.Parameters["@sid"].Value=SID[q];
               updateIndScoreCmd.Parameters["@score"].Value=SCORE[q];
              // message.Text+=SID[q]+" "+SCORE[q]+"<br />";
               updateIndScoreCmd.ExecuteNonQuery();}
              dbconn.Close();
              BindGrid();
              /*OdbcCommand updateIndScoreCmd= new OdbcCommand("UPDATE participants SET score = indExcel.score FROM indExcel WHERE participants.student_id=indExcel.student_id",dbconn);
              dbconn.Open();
              updateIndScoreCmd.ExecuteNonQuery();
              dbconn.Close();*/
     }
    </script>
  

   <body>
<br />
<a href="admincontrol.aspx"> Back to the Control Page </a>

    <form method="post" runat=server >
          <br />
          Anytime the following button is clicked, individual competition scores will be overwritten by the table indExcel converted from Excel<br />
          So click this button first, then edit the individual rows in the following table unless you made a mistake on editing the table and you want to start from scratch by using data from indExcel -- <font color="red">the order is important</font>. <br /><br />
          <font color="red">Please double check places where score =0.</font> This could be caused by mistaken student_id by participants. Use the original excel file to correct those scores using participant names and error-checking built in the ids. <br /><br />
          <asp:button text="Update individual competition scores from table indExcel"  onClick="updateFromExcel" runat="server"/>
          <br /><br />
          <ASP:DataGrid id="participants" runat="server"
            Width="700"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="8pt"
            HeaderStyle-BackColor="#aaaadd"
            OnEditCommand="indGrades_Edit"
            OnCancelCommand="indGrades_Cancel"
            OnUpdateCommand="indGrades_Update"
            DataKeyField="student_id"
            AutoGenerateColumns="false"          
            
          >
          <Columns>
              <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update" ItemStyle-Wrap="false" />
              <asp:BoundColumn HeaderText="student_id" SortExpression="student_id" ReadOnly="True" DataField="student_id" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="name" SortExpression="name" ReadOnly="True" DataField="name" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="category" SortExpression="category" ReadOnly="True" DataField="category" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="group" SortExpression="group" ReadOnly="True" DataField="group" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="team_id" SortExpression="team_id" ReadOnly="True" DataField="team_id" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="school" SortExpression="school" ReadOnly="True" DataField="school" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="score" SortExpression="score" DataField="score" ItemStyle-Wrap="false"/>
             
          </Columns>
          </ASP:DataGrid>
          
   </form><asp:label id="message" forecolor="blue" runat=server />
   
          </body>
</html>