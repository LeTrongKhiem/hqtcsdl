using System;
using System.IO;
using System.Windows.Forms;

namespace ConnectDatabase
{
   public partial class DislayDataForm : Form
   {
      public DislayDataForm()
      {
         InitializeComponent();
      }

      private void DislayDataForm_Load(object sender, EventArgs e)
      {
         cmbTables.Items.Clear();
         var dt = DataProvider.Instance.GetSchema();

         for (int i = 0; i < dt.Rows.Count; i++)
         {
            cmbTables.Items.Add(dt.Rows[i]["TABLE_NAME"]);
         }
      }

      private void cmbTables_SelectedIndexChanged(object sender, EventArgs e)
      {
         string tableName = cmbTables.Items[cmbTables.SelectedIndex].ToString();

         if (string.IsNullOrEmpty(tableName)) { return; }

         var query = $"select * from {tableName}";

         dgvResult.DataSource = DataProvider.Instance.ExecuteQuery(query);

         #region AutoSizeMode Column
         for (int i = 0; i < dgvResult.Columns.Count - 1; i++)
         {
            dgvResult.Columns[i].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
         }
         dgvResult.Columns[dgvResult.Columns.Count - 1].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
         #endregion
      }

      private void btnGenerate_Click(object sender, EventArgs e)
      {
         GenerateModel.ListTableNames.Clear();

         for (int i = 0; i < cmbTables.Items.Count; i++)
         {
            GenerateModel.ListTableNames.Add(cmbTables.Items[i].ToString());
         }

         string saveFolderPath = "";
         using (var fbd = new FolderBrowserDialog())
         {
            DialogResult result = fbd.ShowDialog();

            if (result == DialogResult.OK && !string.IsNullOrWhiteSpace(fbd.SelectedPath))
            {
               saveFolderPath = fbd.SelectedPath;
            }
         }

         GenerateModel.DAL(saveFolderPath);
         GenerateModel.DTO(saveFolderPath);
      }

      private void GenerateEF_Click(object sender, EventArgs e)
      {
         GenerateModel.ListTableNames.Clear();

         for (int i = 0; i < cmbTables.Items.Count; i++)
         {
            GenerateModel.ListTableNames.Add(cmbTables.Items[i].ToString());
         }

         string saveFolderPath = "";
         using (var fbd = new FolderBrowserDialog())
         {
            DialogResult result = fbd.ShowDialog();

            if (result == DialogResult.OK && !string.IsNullOrWhiteSpace(fbd.SelectedPath))
            {
               saveFolderPath = fbd.SelectedPath;
            }
         }

         GenerateModel.DTOForEF(saveFolderPath);
      }
   }
}
