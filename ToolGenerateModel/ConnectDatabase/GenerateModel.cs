using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ConnectDatabase
{
   public class GenerateModel
   {
      public static List<string> ListTableNames = new List<string>();

      public static string Namespace = "DormitoryManagement.Model";
      public static string AccessModifiy = "public";
      

      public static void DTO(string folderPath)
      {
         string dtoPath = Path.Combine(folderPath, "DTO\\");
         Directory.CreateDirectory(dtoPath);
         foreach (var tb in ListTableNames)
         {
            DataTable dataTable = DataProvider.Instance.ExecuteQuery($"select TOP (0) * from [{tb}]");
            string className = FormatName(tb) + "DTO";
            string code = GenerateCodeDTO(dataTable, className);

            File.WriteAllText(dtoPath + $"{className}.cs", code);
         }
      }

      public static void DAL(string folderPath)
      {
         string dtoPath = Path.Combine(folderPath, "DAL\\");
         Directory.CreateDirectory(dtoPath);
         foreach (var tb in ListTableNames)
         {
            DataTable dataTable = DataProvider.Instance.ExecuteQuery($"select TOP (0) * from [{tb}]");
            string className = FormatName(tb) + "DAL";
            string code = GenerateCodeDAL(className);

            File.WriteAllText(dtoPath + $"{className}.cs", code);
         }
      }

      public static void DTOForEF(string folderPath)
      {
         string dtoPath = Path.Combine(folderPath, "DTO\\");
         Directory.CreateDirectory(dtoPath);
         foreach (var tb in ListTableNames)
         {
            DataTable dataTable = DataProvider.Instance.ExecuteQuery($"select TOP (0) * from [{tb}]");
            string className = FormatName(tb) + "DTO";
            string code = GenerateCodeDTO(dataTable, className);

            File.WriteAllText(dtoPath + $"{className}.cs", code);
         }
      }

      static string GenerateCodeDTO(DataTable dataTable, string className)
      {
         string property = "";
         string contructor = "";
         for (int i = 0; i < dataTable.Columns.Count; i++)
         {
            string name = FormatName(dataTable.Columns[i].ColumnName);
            string type = dataTable.Columns[i].DataType.ToString().Replace("System.", "");

            //property += "\t\tpublic " + type + " " + name + " { get; set; }\n";
            //contructor += "\t\t\tthis." + name + " = (" + type + ")dataRow[\"" + name + "\"];\n";
            switch (type)
            {
               case "Boolean":
                  property += "\t\tpublic bool " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToBoolean(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "DateTime":
                  property += "\t\tpublic DateTime " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToDateTime(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "Int32":
                  property += "\t\tpublic int " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToInt32(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "Int64":
                  property += "\t\tpublic long " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToInt64(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "String":
               default:
                  property += "\t\tpublic " + "string" + " " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToString(dr[\"" + dataTable.Columns[i].ColumnName + "\"]).Trim();\n";
                  break;
            }
         }
         string codeGenerate = "using System;\nusing System.Data;\n\n";
         codeGenerate += "namespace " + Namespace + "\n{\n";
         codeGenerate += "\t" + AccessModifiy + " class " + className + "\n\t{\n";
         codeGenerate += property;
         codeGenerate += "\t\tpublic " + className + "(DataRow dr)\n\t\t{\n";
         codeGenerate += contructor + "\t\t}\n\t}\n}";
         return codeGenerate;
      }

      static string GenerateCodeDAL(string className)
      {
         string codeGenerate = "using System;\nusing System.Data;\n\n";
         codeGenerate += "namespace " + Namespace + "\n{\n";
         codeGenerate += "\t" + AccessModifiy + " class " + className + "\n\t{\n";
         //codeGenerate += property;
         codeGenerate += "\t\tpublic " + className + "\n\t\t{\n";
         //codeGenerate += contructor + "\t\t}\n\t}\n}";
         return codeGenerate;
      }

      static string GenerateEF(DataTable dataTable, string className)
      {
         string property = "";
         string contructor = "";
         for (int i = 0; i < dataTable.Columns.Count; i++)
         {
            string name = FormatName(dataTable.Columns[i].ColumnName);
            string type = dataTable.Columns[i].DataType.ToString().Replace("System.", "");

            //property += "\t\tpublic " + type + " " + name + " { get; set; }\n";
            //contructor += "\t\t\tthis." + name + " = (" + type + ")dataRow[\"" + name + "\"];\n";
            switch (type)
            {
               case "Boolean":
                  property += "\t\tpublic bool " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToBoolean(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "DateTime":
                  property += "\t\tpublic DateTime " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToDateTime(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "Int32":
                  property += "\t\tpublic int " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToInt32(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "Int64":
                  property += "\t\tpublic long " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToInt64(dr[\"" + dataTable.Columns[i].ColumnName + "\"]);\n";
                  break;
               case "String":
               default:
                  property += "\t\tpublic " + "string" + " " + name + " { get; set; }\n";
                  contructor += "\t\t\tthis." + name + " = Convert.ToString(dr[\"" + dataTable.Columns[i].ColumnName + "\"]).Trim();\n";
                  break;
            }
         }
         string codeGenerate = "using System;\nusing System.Data;\n\n";
         codeGenerate += "namespace " + Namespace + "\n{\n";
         codeGenerate += "\t" + AccessModifiy + " class " + className + "\n\t{\n";
         codeGenerate += property;
         codeGenerate += "\t\tpublic " + className + "(DataRow dr)\n\t\t{\n";
         codeGenerate += contructor + "\t\t}\n\t}\n}";
         return codeGenerate;
      }

      static string FormatName(string defaultName)
      {
         defaultName = defaultName.Replace("#", "").Replace("$", "").Replace(" ", "-").Replace("+", "");

         string[] words = defaultName.Split('_'); ;
         if (defaultName.Contains("_"))
         {
            words = defaultName.Split('_');
         }
         else if (defaultName.Contains("-"))
         {
            words = defaultName.Split('-');
         }

         string result = "";
         for (int i = 0; i < words.Length; i++)
         {
            if (words[i].Length == 0) { continue; }
            var firtChart = Char.ToUpper(words[i][0]);
            if (!isUpcase(words[i]))
            {
               result += firtChart + words[i].Substring(1);
            }
            else { result += firtChart + words[i].Substring(1).ToLower(); }
         }

         if (Char.IsDigit(result, 0)) { result = "_" + result; }
         return result;
      }

      static bool isUpcase(string str)
      {
         foreach (var ch in str)
         {
            if (!char.IsUpper(ch)) { return false; }
         }
         return true;
      }
   }
}
