using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace ConnectDatabase
{
   public class DataProvider
   {
      private static DataProvider instance;

      private DataProvider() { }

      public static DataProvider Instance { get => instance ?? new DataProvider(); }

      public bool TestConnection(out string error)
      {
         bool result = false;
         error = "";

         try
         {
            using (SqlConnection sqlConnection = 
               new SqlConnection(DatabaseConnection.ConnectionString))
            {
               sqlConnection.Open();
               result = true;
               sqlConnection.Close();
            }
         }
         catch (System.Exception e) {  error = e.Message; }
         return result;
      }

      public DataTable GetSchema()
      {
         DataTable dataTable = new DataTable();
         using (SqlConnection sqlConnection = new 
            SqlConnection(DatabaseConnection.ConnectionString))
         {
            sqlConnection.Open();
            dataTable = sqlConnection.GetSchema("Tables");
            sqlConnection.Close();
         }
         return dataTable;
      }

      public DataTable ExecuteQuery(string query, List<object> parameter = null)
      {
         DataTable dataTable = new DataTable();
         using (SqlConnection sqlConnection = new 
            SqlConnection(DatabaseConnection.ConnectionString))
         {
            sqlConnection.Open();
            SqlCommand sqlCommand = new SqlCommand(query, sqlConnection);

            if (parameter != null)
            {
               string[] listPara = query.Split(' ');
               int i = 0;
               foreach (string item in listPara)
               {
                  if (item.Contains('@'))
                  {
                     sqlCommand.Parameters.AddWithValue(item, parameter[i]);
                     i++;
                  }
               }
            }
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);
            sqlDataAdapter.Fill(dataTable);
            sqlConnection.Close();
         }
         return dataTable;
      }

      public int ExecuteNonQuery(string query, object[] parameter = null)
      {
         int data = 0;
         using (SqlConnection sqlConnection = new SqlConnection(DatabaseConnection.ConnectionString))
         {
            sqlConnection.Open();
            SqlCommand sqlCommand = new SqlCommand(query, sqlConnection);

            if (parameter != null)
            {
               string[] listPara = query.Split(' ');
               int i = 0;
               foreach (string item in listPara)
               {
                  if (item.Contains('@'))
                  {
                     sqlCommand.Parameters.AddWithValue(item, parameter[i]);
                     i++;
                  }
               }
            }
            data = sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();
         }
         return data;
      }

      public object ExecuteScalar(string query, object[] parameter = null)
      {
         object data = 0;
         using (SqlConnection sqlConnection = new SqlConnection(DatabaseConnection.ConnectionString))
         {
            sqlConnection.Open();
            SqlCommand sqlCommand = new SqlCommand(query, sqlConnection);

            if (parameter != null)
            {
               string[] listPara = query.Split(' ');
               int i = 0;
               foreach (string item in listPara)
               {
                  if (item.Contains('@'))
                  {
                     sqlCommand.Parameters.AddWithValue(item, parameter[i]);
                     i++;
                  }
               }
            }
            data = sqlCommand.ExecuteScalar();
            sqlConnection.Close();
         }
         return data;
      }
   }
}
