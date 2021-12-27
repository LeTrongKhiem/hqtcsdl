namespace ConnectDatabase
{
   public class DatabaseConnection
   {
      public static string ServerName
      {
         get => string.IsNullOrEmpty(serverName) ? "(local)" : serverName;
         set => serverName = value;
      }
      public static bool IsSQLAuthentication { get => isSQLAuthentication; set => isSQLAuthentication = value; }
      public static string Username { get => username; set => username = value; }
      public static string Password { get => password; set => password = value; }
      public static string DatabaseName { get => databaseName; set => databaseName = value; }

      public static string ConnectionString
      {
         get
         {
            string connStr = "";
            if (IsSQLAuthentication)
            {
               connStr = $"Data Source={ServerName};"
                  + $"Initial Catalog={DatabaseName};"
                  + "Integrated Security=False;"
                  + $"User ID={Username};"
                  + $"Password={Password};";
            }
            else
            {
               connStr = $"Data Source={ServerName};"
                  + $"Initial Catalog={DatabaseName};"
                  + "Integrated Security=True";
            }
            return connStr;
         }
      }

      private static string serverName;
      private static bool isSQLAuthentication = false;
      private static string username;
      private static string password;
      private static string databaseName;
   }
}
