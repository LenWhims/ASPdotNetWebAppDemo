<%@ Page Title="GridView Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ASPdotNetWebAppDemo._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBound" OnRowCancelingEdit="GridView1_RowCancelingEdit"
        OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
        ShowHeaderWhenEmpty="True" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3"
        AllowPaging="true" PageSize="10"  OnPageIndexChanging="GridView1_PageIndexChanging"
        AllowSorting="true" OnSorting="GridView1_Sorting" EnableViewState=true>
        <Columns>
            <asp:TemplateField HeaderText="Edit" ShowHeader="True" ItemStyle-Width="150">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True"
                        CommandName="Update" Text="Update" ValidationGroup="EditFields"></asp:LinkButton>
                  <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                      CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                  <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True"
                      CommandName="Delete" Text="Delete"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                        CommandName="Edit" Text="Edit"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False"
                        CommandName="Delete" Text="Delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Id" Visible="false" ItemStyle-Width="0" >
                <EditItemTemplate>
                    <asp:Label ID="lbleditid" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblid" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Name" ItemStyle-Width="300" SortExpression="Name">
                <EditItemTemplate>
                    <asp:TextBox ID="txtname" runat="server" Text='<%# Bind("Name") %>' MaxLength="120" oninput="this.value=this.value.replace(/[^0-9A-Za-z\s]/g,'')"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="reqName"
                        ValidationGroup="EditFields" ControlToValidate="txtname" ErrorMessage="Required field" ValidationExpression="^[A-Za-z]*$" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblname" runat="server" Text='<%# Bind("Name") %>' style="overflow-wrap: anywhere;"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Identity" ItemStyle-Width="300" SortExpression="IdentityCard">
                <EditItemTemplate>
                    <asp:TextBox ID="txtIdentity" runat="server" Text='<%# Bind("IdentityCard") %>' 
                        oninput="this.value=this.value.replace(/[^0-9]/g,'')" MaxLength="20"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="reqIdentity" ControlToValidate="txtIdentity"
                        ValidationGroup="EditFields" ErrorMessage="Required field" ValidationExpression="\d+" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblIdentity" runat="server" Text='<%# Bind("IdentityCard") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Gender" ItemStyle-Width="200" SortExpression="Gender">
                <EditItemTemplate>
                    <asp:HiddenField ID="hdnGender" runat="server" Value='<%#Bind("Gender") %>' />
                    <asp:DropDownList ID="ddlGender" runat="server">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ID="reqGender" ControlToValidate="ddlGender"
                        ValidationGroup="EditFields"
                        ErrorMessage="Required field" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblGender" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#007DBB" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#00547E" />
    </asp:GridView>

    <table width="100%" backcolor="White" bordercolor="#CCCCCC" borderstyle="None" borderwidth="1px" cellpadding="3" style="margin-top: 0px">
        <tr>
            <td style="width: 150px">
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True"
                    OnClick="AddNew" Text="Add" ValidationGroup="AddNewFields"></asp:LinkButton>
            </td>
            <td style="width: 300px">
                <asp:TextBox ID="txtName1" runat="server" MaxLength="120" oninput="this.value=this.value.replace(/[^0-9A-Za-z\s]/g,'')"></asp:TextBox>
            </td>
            <td style="width: 300px;">
                <asp:TextBox ID="txtIdentity1" runat="server" oninput="this.value=this.value.replace(/[^0-9]/g,'')" MaxLength="20"></asp:TextBox>
            </td>
            <td style="width: 200px">
                <asp:DropDownList ID="ddlGender1" runat="server">
                    <asp:ListItem Selected="True"> </asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                    <asp:ListItem>Male</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <table width="100%" backcolor="White" borderstyle="None" cellpadding="3" style="margin-top: 0px">
        <tr style="border: 0">
            <td style="width: 150px"></td>
            <td style="width: 300px">
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ValidationExpression="^[A-Za-z]*$" ControlToValidate="txtname1" ValidationGroup="AddNewFields"
                    ErrorMessage="Required field" />
            </td>
            <td style="width: 300px;">
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtIdentity1" ValidationGroup="AddNewFields"
                    ErrorMessage="Required field" ValidationExpression="\d+" />
            </td>
            <td style="width: 200px">
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ValidationGroup="AddNewFields"
                    ControlToValidate="ddlGender1" ErrorMessage="Required field" />
            </td>
        </tr>
    </table>
</asp:Content>

