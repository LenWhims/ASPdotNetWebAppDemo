using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace ASPdotNetWebAppDemo
{
    public partial class _Default : Page
    {
        private readonly string conString = ConfigurationManager.ConnectionStrings["localDBCon"].ConnectionString;
        SqlDataAdapter ad = new SqlDataAdapter();
        DataTable dt;
        private List<String> genderList = new List<string>{"","Female","Male"};
        private string SortDirection
        {
            get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind();
            }
        }
        public void Bind(string sortExpression = null, int pageNumber = 0)
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("Select * from Employees"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            if (sortExpression != null)
                            {
                                DataView dv = dt.AsDataView();
                                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";

                                dv.Sort = sortExpression + " " + this.SortDirection;
                                GridView1.DataSource = dv;
                            }
                            else
                            {
                                GridView1.DataSource = dt;
                            }
                            GridView1.PageIndex = pageNumber;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Find the DropDownList in the Row
                DropDownList ddlGender = (e.Row.FindControl("ddlGender") as DropDownList);
                if (ddlGender != null)
                {
                    ddlGender.DataSource = genderList;
                    ddlGender.DataBind();
                    HiddenField hdngen = (HiddenField)e.Row.FindControl("hdnGender");
                    ddlGender.Items.FindByValue(hdngen.Value).Selected = true;
                }
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            Bind();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
           
            TextBox txtName = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtname");
            TextBox txtIdentity = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtidentity");
            DropDownList txtGender = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlGender");
            Label lblid = (Label)GridView1.Rows[e.RowIndex].FindControl("lbleditid");

            ad = new SqlDataAdapter("UPDATE Employees SET Name ='" + txtName.Text + "',IdentityCard ='" + txtIdentity.Text + "',Gender ='" + txtGender.Text + "'  WHERE Id='" + Convert.ToInt32(lblid.Text) + "'", conString);
            dt = new DataTable();
            ad.Fill(dt);
            GridView1.EditIndex = -1;
            Bind();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
           
            ad = new SqlDataAdapter("DELETE FROM Employees WHERE Id=" + Convert.ToInt32(((Label)GridView1.Rows[e.RowIndex].FindControl("lblid")).Text) + "", conString);
            dt = new DataTable();
            ad.Fill(dt);
            Bind();
        }
        protected void AddNew(object sender, EventArgs e)
        {
            string txtName = txtName1.Text;
            string txtIdentity = txtIdentity1.Text;
            string txtGender = ddlGender1.Text;
            ad = new SqlDataAdapter("INSERT INTO Employees(Name,IdentityCard,Gender) Values('" + txtName + "', '" + txtIdentity + "', '" + txtGender + "')", conString);
            dt = new DataTable();
            ad.Fill(dt);
            Bind();
            txtName1.Text = String.Empty;
            txtIdentity1.Text = String.Empty;
            ddlGender1.Text = String.Empty;
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            Bind();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Bind(null,e.NewPageIndex);
        }
        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.Bind(e.SortExpression);
        }
    }

}