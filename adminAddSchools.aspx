<%@ Page Language="C#"  runat=server %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>

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
     
     
           //insert school not already in database with all info on the form
           // change password for school already in database, ignore other info entered on the form
      void schoolInsert (Object Src, EventArgs E){
            Page.Validate();
            if(!Page.IsValid){return;}
            
             OdbcCommand schoolIdSelAll=new OdbcCommand("SELECT school_id FROM xyzstart_db .dbo.schools", dbconn);
             
             OdbcCommand myOleDbInsComm = new OdbcCommand("INSERT INTO xyzstart_db .dbo.schools ([password], schoo, school_id, school_name,contact,email,phone, address) Values (@password, @school, @school_id, @school_name,@contact,@email,@phone,@school_addr)", dbconn);
//( ?,? ?, ?,?,?,?,?)", dbconn);
// ( @school,@password, @school_id, @school_name,@contact,@email,@phone,@school_addr)", dbconn);
             myOleDbInsComm.Parameters.Add(new OdbcParameter("@school", OdbcType.VarChar, 20));
             myOleDbInsComm.Parameters["@school"].Value = school.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@password", OdbcType.VarChar, 20));
             myOleDbInsComm.Parameters["@password"].Value = school.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@school_id", OdbcType.Int));
             //myOleDbInsComm.Parameters["@school_id"].Value = school_id.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@school_name", OdbcType.VarChar, 50));
             myOleDbInsComm.Parameters["@school_name"].Value = school_name.Text;


             myOleDbInsComm.Parameters.Add(new OdbcParameter("@contact", OdbcType.VarChar, 50));
             myOleDbInsComm.Parameters["@contact"].Value = contact.Text;


             myOleDbInsComm.Parameters.Add(new OdbcParameter("@email", OdbcType.VarChar, 50));
             myOleDbInsComm.Parameters["@email"].Value = email.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@phone", OdbcType.VarChar, 50));
             myOleDbInsComm.Parameters["@phone"].Value = phone.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@address", OdbcType.VarChar, 100));
             myOleDbInsComm.Parameters["@address"].Value = school_addr.Text;

             OdbcCommand schoolSelCmd=new OdbcCommand("SELECT school FROM xyzstart_db .dbo.schools WHERE school=?", dbconn);
             schoolSelCmd.Parameters.Add(new OdbcParameter("@school", OdbcType.VarChar, 20));
             schoolSelCmd.Parameters["@school"].Value = school.Text;

             OdbcCommand schoolIdSelCmd=new OdbcCommand("SELECT school_id FROM xyzstart_db .dbo.schools WHERE school_id=?", dbconn);
             schoolIdSelCmd.Parameters.Add(new OdbcParameter("@school_id", OdbcType.Int));
             //schoolIdSelCmd.Parameters["@school_id"].Value = school_id.Text;

             message.Text="";
             
            //* try
            //*   {
  
               dbconn.Open();
               
               OdbcDataReader schoolRead =schoolSelCmd.ExecuteReader();
               if(schoolRead.Read()){message.Text="This school already exists in record!";schoolRead.Close();}
               else{schoolRead.Close();

               OdbcDataReader allIdRead=schoolIdSelAll.ExecuteReader();
               ArrayList IdArray= new ArrayList();
               while(allIdRead.Read()){IdArray.Add(allIdRead.GetString(0));}
               allIdRead.Close();
               String schoolIdTry;int cid;
               do{schoolIdTry=(new Random()).Next(100,1000).ToString();
                  cid=0;
                  for(int i=0;i<IdArray.Count;i++)
                   {if(schoolIdTry==(String)IdArray[i]){cid++;}}
                           } while(cid>0);
             schoolIdSelCmd.Parameters["@school_id"].Value = schoolIdTry;

                OdbcDataReader schoolIdRead =schoolIdSelCmd.ExecuteReader();
                if(schoolIdRead.Read()){message.Text="This school_id already exists; please select again!";
                                        schoolIdRead.Close();}
                else{schoolIdRead.Close();
                     myOleDbInsComm.Parameters["@school_id"].Value = schoolIdTry;
                    myOleDbInsComm.ExecuteNonQuery();message.Text="the school has been added to the database!";}
                }
               
               
               //myOleDbCleanupComm.ExecuteNonQuery();
               
               
           //*    }
          //*  catch(Exception e)
           //*      { message.Text= "Couldn't add record: please ensure all fields are correctly filled out" ;
           //*      }
          //*  finally
          //*    {
             dbconn.Close();
         //*     }
             school.Text="";
             contact.Text="";email.Text="";phone.Text="";school_name.Text="";school_addr.Text="";
             BindGrid();
          }
     void BindGrid(){
        OdbcDataAdapter displayComm=new OdbcDataAdapter("SELECT school, school_id,school_name, contact, email, phone , address FROM xyzstart_db .dbo.schools ORDER BY school", dbconn);// 
        DataSet ds= new DataSet();
        displayComm.Fill(ds, "schools");
        schools.DataSource=ds.Tables["schools"].DefaultView;
        schools.DataBind();
                }
    </script>
  
   <% Session.Timeout=60; 
    %>
   <body>


   <table>
       <tr><td valign="top">
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
            EnableViewState="false"
          />
       </td>
       <td valign="top">
          

       <form method="post" runat=server >
          <table bgcolor="#eeeeee" cellpadding=10><tr align="center">
      
              Add a school</tr>
          
          <tr> 
              <td align="right">school:</td>
              <td><asp:textbox id="school"  MaxLength="20" align="center" runat="server" /><br />
                  <asp:RequiredFieldValidator id="schoolValidator" runat="server"
                      ControlToValidate="school"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> school field should not be empty
                  </asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator id="schoolRegValidator" runat="server"
                      ControlToValidate="school"
                      ValidationExpression="^([a-z])+$"
                      Display="Static"
                      Font-Name="Verdana" Font-Size="10pt">school field should consist of only lower-case letters
                  </asp:RegularExpressionValidator>
</td></tr>
          



          <tr>
              <td align="right">school name:</td>
              <td><asp:textbox id="school_name" MaxLength="50" align="center" runat="server" /><br />
              <asp:RequiredFieldValidator id="schoolNameValidator" runat="server"
                      ControlToValidate="school_name"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> school_name field should not be empty
                  </asp:RequiredFieldValidator>
</td></tr>
          <tr>   
              <td align="right">contact:</td>
              <td><asp:textbox id="contact"  MaxLength="50" align="center" runat="server" /><br />
              <asp:RequiredFieldValidator id="contactIdValidator" runat="server"
                      ControlToValidate="contact"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> contact field should not be empty
                  </asp:RequiredFieldValidator>
</td></tr>
          <tr>   
              <td align="right">contact email:</td>
              <td><asp:textbox id="email"  align="center" runat="server" /><br />
              <asp:RequiredFieldValidator id="emailValidator" runat="server"
                      ControlToValidate="email"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> email field should not be empty
                  </asp:RequiredFieldValidator>
</td></tr>
          <tr>   
              <td align="right">contact phone:</td>
              <td><asp:textbox id="phone"  align="center" runat="server" /><br />
              <asp:RequiredFieldValidator id="phoneValidator" runat="server"
                      ControlToValidate="phone"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> phone field should not be empty
                  </asp:RequiredFieldValidator>
</td></tr>

          <tr>
              <td align="right">address:</td>
              <td><asp:textbox id="school_addr" MaxLength="100" align="center" runat="server" /></td></tr>

             <tr><td /><td align="left">
             <asp:button text="Add" onClick="schoolInsert" runat="server"/></td></tr>
              
             <tr><td /><td>
<a href="admincontrol.aspx"> Back to Control Page </a></td></tr>
         
          <tr><td /><td><asp:label id="message" forecolor="blue" runat=server /></td></tr>
         </table> 
       </form>
       
       </td>
   </tr>
   </table>

          </body>
</html>