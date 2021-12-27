using System;
using System.Windows.Forms;

namespace ConnectDatabase
{
   public partial class ConnectForm : Form
   {
      public ConnectForm()
      {
         InitializeComponent();
      }

      private void ConnectForm_Load(object sender, EventArgs e)
      {

      }

      private void txtServername_TextChanged(object sender, EventArgs e)
      {
         DatabaseConnection.ServerName = txtServername.Text;
      }

      private void rbtnWindowAu_CheckedChanged(object sender, EventArgs e)
      {
         DatabaseConnection.IsSQLAuthentication = false;
         grpSQLAu.Enabled = false;
      }

      private void rbtnSQLAu_CheckedChanged(object sender, EventArgs e)
      {
         DatabaseConnection.IsSQLAuthentication = true;
         grpSQLAu.Enabled = true;
      }

      private void txtUsername_TextChanged(object sender, EventArgs e)
      {
         DatabaseConnection.Username = txtUsername.Text;
      }

      private void txtPassword_TextChanged(object sender, EventArgs e)
      {
         DatabaseConnection.Password = txtPassword.Text;
      }

      private void chkShowPass_CheckedChanged(object sender, EventArgs e)
      {
         txtPassword.PasswordChar = txtPassword.PasswordChar == '\0' ? '•' : '\0';
      }

      private void txtDatabaseName_TextChanged(object sender, EventArgs e)
      {
         DatabaseConnection.DatabaseName = txtDatabaseName.Text;
      }

      private void btnTestConnect_Click(object sender, EventArgs e)
      {
         tableLayoutPanel1.Enabled = false;
         if (DataProvider.Instance.TestConnection(out var connectError))
         {
            MessageBox.Show("Test connection succeeded", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
         }
         else
         {
            MessageBox.Show("Cannot connect to database.\n\r" + connectError, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
         }
         tableLayoutPanel1.Enabled = true;
      }

      private void btnStart_Click(object sender, EventArgs e)
      {
         tableLayoutPanel1.Enabled = false;
         //if (string.IsNullOrEmpty(DatabaseConnection.ServerName))
         //{
         //   MessageBox.Show("You must enter \"Server name\"", "Missing input", MessageBoxButtons.OK, MessageBoxIcon.Error);
         //   txtServername.Text = "";
         //   txtServername.Focus();
         //   return;
         //}

         //if (string.IsNullOrEmpty(DatabaseConnection.DatabaseName))
         //{
         //   MessageBox.Show("You must enter \"Database name\"", "Missing input", MessageBoxButtons.OK, MessageBoxIcon.Error);
         //   tableLayoutPanel1.Enabled = true;
         //   txtDatabaseName.Text = "";
         //   txtDatabaseName.Focus();
         //   return;
         //}

         if (DataProvider.Instance.TestConnection(out var connectError))
         {
            this.Hide();
            DislayDataForm dislayDataForm = new DislayDataForm()
            {
               Text = DatabaseConnection.IsSQLAuthentication ? "SQL Authentication - User " + DatabaseConnection.Username : "Windows Authentication",
            };
            dislayDataForm.ShowDialog();
            this.Show();
         }
         else
         {
            MessageBox.Show("Cannot connect to database.\n\r" + connectError, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
         }

         tableLayoutPanel1.Enabled = true;
      }
   }
}
