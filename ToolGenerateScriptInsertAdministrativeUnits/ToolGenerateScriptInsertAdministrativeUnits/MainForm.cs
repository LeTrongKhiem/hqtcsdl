using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ToolGenerateScriptInsertAdministrativeUnits
{
   public partial class MainForm : Form
   {
      public MainForm()
      {
         InitializeComponent();
      }

      private void btnExcel_Click(object sender, EventArgs e)
      {
         var newPath = ShowOpenFileDialog("Select excel file path", "Excel | *.xlsx");
         if (newPath != "")
         {
            txtExcelFilePath.Text = newPath;
         }
      }

      private void btnScript_Click(object sender, EventArgs e)
      {
         var newPath = ShowSaveFileDialog("Save script file path", "SQL Files | *.sql | Text file | *.txt | All Files | *.*");
         if (newPath != "")
         {
            txtScriptFilePath.Text = newPath;
         }
      }

      private void btnStart_Click(object sender, EventArgs e)
      {
         if (Path.GetExtension(txtExcelFilePath.Text) != ".xlsx")
         {
            MessageBox.Show("Please select path to *.xlsx excel file");
            btnExcel.PerformClick();
            return;
         }

         if (string.IsNullOrEmpty(txtScriptFilePath.Text))
         {
            MessageBox.Show("Please select path save script");
            btnScript.PerformClick();
            return;
         }

         Generate(txtExcelFilePath.Text, txtScriptFilePath.Text);

         MessageBox.Show("Done");
         if (chkOpenAfter.Checked)
         {
            Process.Start(txtScriptFilePath.Text);
         }
      }

      public static string ShowSaveFileDialog(string title, string filter)
      {
         string filePath = "";
         SaveFileDialog dialog = new SaveFileDialog();

         if (!string.IsNullOrEmpty(title))
         {
            dialog.Title = title;
         }
         if (!string.IsNullOrEmpty(filter))
         {
            dialog.Filter = filter;
         }

         if (dialog.ShowDialog() == DialogResult.OK)
         {
            filePath = dialog.FileName;
         }

         return filePath;
      }

      public static string ShowOpenFileDialog(string title, string filter)
      {
         string filePath = "";
         OpenFileDialog dialog = new OpenFileDialog();

         if (!string.IsNullOrEmpty(title))
         {
            dialog.Title = title;
         }
         if (!string.IsNullOrEmpty(filter))
         {
            dialog.Filter = filter;
         }

         if (dialog.ShowDialog() == DialogResult.OK)
         {
            filePath = dialog.FileName;
         }

         return filePath;
      }

      public void Generate(string excellFilePath, string scriptFilePath)
      {
         try
         {
            using (StreamWriter scriptFile = new StreamWriter(scriptFilePath))
            {
               ExcelPackage.LicenseContext = OfficeOpenXml.LicenseContext.NonCommercial;
               var package = new ExcelPackage(new FileInfo(excellFilePath));
               ExcelWorksheet workSheet = package.Workbook.Worksheets[0];

               for (int i = workSheet.Dimension.Start.Row + 1; i <= workSheet.Dimension.End.Row; i++)
               {
                  try
                  {
                     if (workSheet.Cells[i, 1].Value == null) { continue; }

                     string communeId = workSheet.Cells[i, 1].Value.ToString();
                     (string, string) commune = GetCommune(workSheet.Cells[i, 2].Value.ToString().Trim());

                     if (commune == ("", "")) { continue; }

                     string districtId = workSheet.Cells[i, 5].Value.ToString();
                     (string, string) district = GetDistrict(workSheet.Cells[i, 6].Value.ToString());

                     if (district == ("", "")) { continue; }

                     string provinceId = workSheet.Cells[i, 7].Value.ToString();
                     (string, string) province = GetProvince(workSheet.Cells[i, 8].Value.ToString());

                     if (province == ("", "")) { continue; }

                     string query = $"EXEC dbo.USP_INSERT_COMMUNE @COMMUNE_ID = '{communeId}', @COMMUNE_NAME = N'{commune.Item1}', @COMMUNE_TYPE = '{commune.Item2}', @DISTRICT_ID = '{districtId}', @DISTRICT_NAME = N'{district.Item1}', @DISTRICT_TYPE = '{district.Item2}', @PROVINCE_ID = '{provinceId}', @PROVINCE_NAME = N'{province.Item1}', @PROVINCE_TYPE = '{province.Item2}'";
                     scriptFile.WriteLine(query);
                  }
                  catch (Exception exe)
                  {
                     MessageBox.Show(exe.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                  }
               }
            }
         }
         catch (Exception e)
         {
            MessageBox.Show(e.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
         }
      }

      (string, string) GetCommune(string communeName)
      {
         communeName = communeName.Replace("'", "''");

         //  W: Phường, V: xã, T: thị trấn

         if (communeName.StartsWith("Phường"))
         {
            return (communeName.Substring(6).Trim(), "W");
         }

         if (communeName.StartsWith("Xã"))
         {
            return (communeName.Substring(2).Trim(), "V");
         }

         if (communeName.StartsWith("Thị trấn"))
         {
            return (communeName.Substring(8).Trim(), "T");
         }

         return ("", "");
      }

      (string, string) GetDistrict(string districName)
      {
         districName = districName.Replace("'", "''");

         // C: thành phố trực thuộc tỉnh, D: quận, H: huyện, T: thị xã

         if (districName.StartsWith("Thành phố"))
         {
            return (districName.Substring(9).Trim(), "C");
         }

         if (districName.StartsWith("Quận"))
         {
            return (districName.Substring(4).Trim(), "D");
         }

         if (districName.StartsWith("Huyện"))
         {
            return (districName.Substring(5).Trim(), "H");
         }

         if (districName.StartsWith("Thị xã"))
         {
            return (districName.Substring(6).Trim(), "T");
         }

         return ("", "");
      }

      (string, string) GetProvince(string provinceName)
      {
         provinceName = provinceName.Replace("'", "''");

         // C: thành phố trực thuộc trung ương, P: tỉnh

         if (provinceName.StartsWith("Thành phố"))
         {
            return (provinceName.Substring(9).Trim(), "C");
         }

         if (provinceName.StartsWith("Tỉnh"))
         {
            return (provinceName.Substring(4).Trim(), "P");
         }

         return ("", "");
      }
   }
}
