<%@ Page Language="C#" runat=server debug="true" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Globalization" %>

<html>
   
     <script language="C#" runat="server">
         OleDbConnection dbconn;
         void Page_Load(Object Src, EventArgs E) {
         //if(Session["validation"]!="allright"){Response.Redirect("adminLogin.aspx", true);} 
         dbconn = new OleDbConnection("Provider=SQLNCLI10; Server=tcp:ufwryy6r0y.database.windows.net,1433; Database=[xyzstart_db]; Uid=[xyzdb@ufwryy6r0y]; Pwd=[virAf89Hda];");
         if(!IsPostBack)
         {
         BindGrid();
         Page.DataBind(); 
          }
        }
     
     
           //insert school not already in database with all info on the form
           // change password for school already in database, ignore other info entered on the form
      /* void schoolInsert (Object Src, EventArgs E){
            Page.Validate();
            if(!Page.IsValid){return;}
            

             
             OleDbCommand myOleDbInsComm = new OleDbCommand("INSERT INTO schools ( school,[password], school_id, school_name,contact,contact_detail, address) Values ( @school,@password, @school_id, @school_name,@contact,@contact_det,@school_addr)", dbconn);
             myOleDbInsComm.Parameters.Add(new OleDbParameter("@school", OleDbType.VarChar, 20));
             myOleDbInsComm.Parameters["@school"].Value = school.Text;

             myOleDbInsComm.Parameters.Add(new OleDbParameter("@password", OleDbType.VarChar, 20));
             myOleDbInsComm.Parameters["@password"].Value = password.Text;

             myOleDbInsComm.Parameters.Add(new OleDbParameter("@school_id", OleDbType.Integer, 10));
             myOleDbInsComm.Parameters["@school_id"].Value = school_id.Text;

             myOleDbInsComm.Parameters.Add(new OleDbParameter("@school_name", OleDbType.VarChar, 50));
             myOleDbInsComm.Parameters["@school_name"].Value = school_name.Text;


             myOleDbInsComm.Parameters.Add(new OleDbParameter("@contact", OleDbType.VarChar, 50));
             myOleDbInsComm.Parameters["@contact"].Value = contact.Text;


             myOleDbInsComm.Parameters.Add(new OleDbParameter("@contact_det", OleDbType.LongVarWChar));
             myOleDbInsComm.Parameters["@contact_det"].Value = contact_det.Text;

             myOleDbInsComm.Parameters.Add(new OleDbParameter("@school_addr", OleDbType.VarChar, 100));
             myOleDbInsComm.Parameters["@school_addr"].Value = school_addr.Text;

             message.Text="";
             
             try
               {
  
               dbconn.Open();
               myOleDbInsComm.ExecuteNonQuery();
               
               //myOleDbCleanupComm.ExecuteNonQuery();
               
               
               }
            catch(Exception e)
                 {
                   message.Text= "Couldn't insert record: " + e.ToString();
                 }
            finally
              {
             dbconn.Close();
              }
             school.Text="";password.Text="";school_id.Text="";
             contact.Text="";contact_det.Text="";school_name.Text="";school_addr.Text="";
             BindGrid();
          }*/
     void schools_Edit(Object sender, DataGridCommandEventArgs e)
        {schools.EditItemIndex = (int)e.Item.ItemIndex; BindGrid(); }
     void schools_Cancel(Object sender, DataGridCommandEventArgs e)
        {schools.EditItemIndex = -1; BindGrid(); }
     void schools_Update(Object sender, DataGridCommandEventArgs e)
        {
         String updateCmd="UPDATE schools SET school=@Nschool, [password]=@Npassword, school_id=@Nschool_id,school_name=@Nschool_name,last_login=@Nlast_login, contact=@Ncontact, contact_detail=@Ncontact_det,part_status=@Npart_status, address=@Nschool_addr WHERE school=@Nschool";
         OleDbCommand myUpdateCmd= new OleDbCommand(updateCmd, dbconn);
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Nschool", OleDbType.VarChar, 20));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Npassword", OleDbType.VarChar, 20));  
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Nschool_id", OleDbType.Integer, 10));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Nschool_name", OleDbType.VarChar, 50));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Nlast_login", OleDbType.VarChar, 50));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Ncontact", OleDbType.VarChar, 50));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Ncontact_det", OleDbType.LongVarWChar));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Npart_status", OleDbType.Boolean));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@Nschool_addr", OleDbType.VarChar, 100));
         myUpdateCmd.Parameters["@Nschool"].Value=schools.DataKeys[(int)e.Item.ItemIndex];
         String[] cols={"@Nschool","@Npassword","@Nschool_id","@Nschool_name","@Nlast_login","@Ncontact","@Ncontact_det","@Npart_status","@Nschool_addr"};
         int numCols=e.Item.Cells.Count;
         message.Text="";
         for (int i=2; i<numCols-1;i++)
            {
             String colvalue=((System.Web.UI.WebControls.TextBox) e.Item.Cells[i].Controls[0]).Text;
             myUpdateCmd.Parameters[cols[i-1]].Value = colvalue;
             message.Text+=colvalue+"<br />";
            }
          myUpdateCmd.Connection.Open();
          try{myUpdateCmd.ExecuteNonQuery();schools.EditItemIndex=-1;}
          catch(Exception ex){message.Text+="what's going on?";}
          myUpdateCmd.Connection.Close();
          BindGrid();
          message.Text+="working";
        }
     void BindGrid(){
        OleDbDataAdapter displayComm=new OleDbDataAdapter("SELECT * FROM schools", dbconn);
        DataSet ds= new DataSet();
        displayComm.Fill(ds, "schools");
        schools.DataSource=ds.Tables["schools"].DefaultView;
        schools.DataBind();
                }
    </script>
  
   <% Session.Timeout=60; %>
   <body>
    <form method="post" runat=server >
   
          <ASP:DataGrid id="schools" runat="server"
            Width="700"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="8pt"
            HeaderStyle-BackColor="#aaaadd"
            OnEditCommand="schools_Edit"
            OnCancelCommand="schools_Cancel"
            OnUpdateCommand="schools_Update"
            DataKeyField="school"
            AutoGenerateColumns="false"          
            
          >
          <Columns>
              <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update" ItemStyle-Wrap="false" />
              <asp:BoundColumn HeaderText="school" SortExpression="school" ReadOnly="True" DataField="school" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="password" SortExpression="password" DataField="password" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="school_id" SortExpression="school_id" DataField="school_id" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="school_name" SortExpression="school_name" DataField="school_name" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="last_login" SortExpression="last_login"  DataField="last_login" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="contact" SortExpression="contact" DataField="contact" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="contact_detail" SortExpression="contact_detail" DataField="contact_detail" ItemStyle-Wrap="true"/>
              <asp:BoundColumn HeaderText="part_status" SortExpression="part_status" DataField="part_status" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="address" SortExpression="address" DataField="address" ItemStyle-Wrap="true"/>
          </Columns>
          </ASP:DataGrid>
          
   </form><asp:label id="message" forecolor="blue" runat=server />
          </body>
</html>