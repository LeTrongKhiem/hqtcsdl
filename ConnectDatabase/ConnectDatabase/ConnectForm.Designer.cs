namespace ConnectDatabase
{
   partial class ConnectForm
   {
      /// <summary>
      /// Required designer variable.
      /// </summary>
      private System.ComponentModel.IContainer components = null;

      /// <summary>
      /// Clean up any resources being used.
      /// </summary>
      /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
      protected override void Dispose(bool disposing)
      {
         if (disposing && (components != null))
         {
            components.Dispose();
         }
         base.Dispose(disposing);
      }

      #region Windows Form Designer generated code

      /// <summary>
      /// Required method for Designer support - do not modify
      /// the contents of this method with the code editor.
      /// </summary>
      private void InitializeComponent()
      {
         this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
         this.groupBox1 = new System.Windows.Forms.GroupBox();
         this.txtServername = new System.Windows.Forms.TextBox();
         this.groupBox2 = new System.Windows.Forms.GroupBox();
         this.txtDatabaseName = new System.Windows.Forms.TextBox();
         this.groupBox3 = new System.Windows.Forms.GroupBox();
         this.rbtnSQLAu = new System.Windows.Forms.RadioButton();
         this.rbtnWindowAu = new System.Windows.Forms.RadioButton();
         this.grpSQLAu = new System.Windows.Forms.GroupBox();
         this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
         this.label1 = new System.Windows.Forms.Label();
         this.label2 = new System.Windows.Forms.Label();
         this.txtUsername = new System.Windows.Forms.TextBox();
         this.txtPassword = new System.Windows.Forms.TextBox();
         this.chkShowPass = new System.Windows.Forms.CheckBox();
         this.groupBox4 = new System.Windows.Forms.GroupBox();
         this.btnTestConnect = new System.Windows.Forms.Button();
         this.btnStart = new System.Windows.Forms.Button();
         this.tableLayoutPanel1.SuspendLayout();
         this.groupBox1.SuspendLayout();
         this.groupBox2.SuspendLayout();
         this.groupBox3.SuspendLayout();
         this.grpSQLAu.SuspendLayout();
         this.tableLayoutPanel2.SuspendLayout();
         this.groupBox4.SuspendLayout();
         this.SuspendLayout();
         // 
         // tableLayoutPanel1
         // 
         this.tableLayoutPanel1.ColumnCount = 1;
         this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
         this.tableLayoutPanel1.Controls.Add(this.groupBox1, 0, 1);
         this.tableLayoutPanel1.Controls.Add(this.groupBox2, 0, 4);
         this.tableLayoutPanel1.Controls.Add(this.groupBox3, 0, 2);
         this.tableLayoutPanel1.Controls.Add(this.grpSQLAu, 0, 3);
         this.tableLayoutPanel1.Controls.Add(this.groupBox4, 0, 5);
         this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
         this.tableLayoutPanel1.Name = "tableLayoutPanel1";
         this.tableLayoutPanel1.RowCount = 7;
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 84F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 96F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 112F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 79F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 79F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
         this.tableLayoutPanel1.Size = new System.Drawing.Size(430, 577);
         this.tableLayoutPanel1.TabIndex = 0;
         // 
         // groupBox1
         // 
         this.groupBox1.Controls.Add(this.txtServername);
         this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.groupBox1.Location = new System.Drawing.Point(11, 74);
         this.groupBox1.Margin = new System.Windows.Forms.Padding(11, 11, 11, 6);
         this.groupBox1.Name = "groupBox1";
         this.groupBox1.Padding = new System.Windows.Forms.Padding(22, 9, 11, 3);
         this.groupBox1.Size = new System.Drawing.Size(408, 67);
         this.groupBox1.TabIndex = 0;
         this.groupBox1.TabStop = false;
         this.groupBox1.Text = "Server name";
         // 
         // txtServername
         // 
         this.txtServername.Dock = System.Windows.Forms.DockStyle.Fill;
         this.txtServername.Location = new System.Drawing.Point(22, 26);
         this.txtServername.Name = "txtServername";
         this.txtServername.Size = new System.Drawing.Size(375, 24);
         this.txtServername.TabIndex = 0;
         this.txtServername.TextChanged += new System.EventHandler(this.txtServername_TextChanged);
         // 
         // groupBox2
         // 
         this.groupBox2.Controls.Add(this.txtDatabaseName);
         this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
         this.groupBox2.Location = new System.Drawing.Point(11, 361);
         this.groupBox2.Margin = new System.Windows.Forms.Padding(11, 6, 11, 6);
         this.groupBox2.Name = "groupBox2";
         this.groupBox2.Padding = new System.Windows.Forms.Padding(22, 9, 11, 3);
         this.groupBox2.Size = new System.Drawing.Size(408, 67);
         this.groupBox2.TabIndex = 0;
         this.groupBox2.TabStop = false;
         this.groupBox2.Text = "Database name";
         // 
         // txtDatabaseName
         // 
         this.txtDatabaseName.Dock = System.Windows.Forms.DockStyle.Fill;
         this.txtDatabaseName.Location = new System.Drawing.Point(22, 26);
         this.txtDatabaseName.Name = "txtDatabaseName";
         this.txtDatabaseName.Size = new System.Drawing.Size(375, 24);
         this.txtDatabaseName.TabIndex = 0;
         this.txtDatabaseName.TextChanged += new System.EventHandler(this.txtDatabaseName_TextChanged);
         // 
         // groupBox3
         // 
         this.groupBox3.Controls.Add(this.rbtnSQLAu);
         this.groupBox3.Controls.Add(this.rbtnWindowAu);
         this.groupBox3.Dock = System.Windows.Forms.DockStyle.Fill;
         this.groupBox3.Location = new System.Drawing.Point(11, 153);
         this.groupBox3.Margin = new System.Windows.Forms.Padding(11, 6, 11, 6);
         this.groupBox3.Name = "groupBox3";
         this.groupBox3.Padding = new System.Windows.Forms.Padding(22, 9, 11, 3);
         this.groupBox3.Size = new System.Drawing.Size(408, 84);
         this.groupBox3.TabIndex = 1;
         this.groupBox3.TabStop = false;
         this.groupBox3.Text = "Authentication";
         // 
         // rbtnSQLAu
         // 
         this.rbtnSQLAu.AutoSize = true;
         this.rbtnSQLAu.Dock = System.Windows.Forms.DockStyle.Top;
         this.rbtnSQLAu.Location = new System.Drawing.Point(22, 48);
         this.rbtnSQLAu.Margin = new System.Windows.Forms.Padding(3, 11, 3, 3);
         this.rbtnSQLAu.Name = "rbtnSQLAu";
         this.rbtnSQLAu.Size = new System.Drawing.Size(375, 22);
         this.rbtnSQLAu.TabIndex = 1;
         this.rbtnSQLAu.Text = "SQL Server Authentication";
         this.rbtnSQLAu.UseVisualStyleBackColor = true;
         this.rbtnSQLAu.CheckedChanged += new System.EventHandler(this.rbtnSQLAu_CheckedChanged);
         // 
         // rbtnWindowAu
         // 
         this.rbtnWindowAu.AutoSize = true;
         this.rbtnWindowAu.Checked = true;
         this.rbtnWindowAu.Dock = System.Windows.Forms.DockStyle.Top;
         this.rbtnWindowAu.Location = new System.Drawing.Point(22, 26);
         this.rbtnWindowAu.Name = "rbtnWindowAu";
         this.rbtnWindowAu.Size = new System.Drawing.Size(375, 22);
         this.rbtnWindowAu.TabIndex = 0;
         this.rbtnWindowAu.TabStop = true;
         this.rbtnWindowAu.Text = "Windows Authentication";
         this.rbtnWindowAu.UseVisualStyleBackColor = true;
         this.rbtnWindowAu.CheckedChanged += new System.EventHandler(this.rbtnWindowAu_CheckedChanged);
         // 
         // grpSQLAu
         // 
         this.grpSQLAu.Controls.Add(this.tableLayoutPanel2);
         this.grpSQLAu.Dock = System.Windows.Forms.DockStyle.Fill;
         this.grpSQLAu.Enabled = false;
         this.grpSQLAu.Location = new System.Drawing.Point(11, 249);
         this.grpSQLAu.Margin = new System.Windows.Forms.Padding(11, 6, 11, 6);
         this.grpSQLAu.Name = "grpSQLAu";
         this.grpSQLAu.Size = new System.Drawing.Size(408, 100);
         this.grpSQLAu.TabIndex = 2;
         this.grpSQLAu.TabStop = false;
         this.grpSQLAu.Text = "SQL Server Authentication";
         // 
         // tableLayoutPanel2
         // 
         this.tableLayoutPanel2.ColumnCount = 3;
         this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 112F));
         this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
         this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 34F));
         this.tableLayoutPanel2.Controls.Add(this.label1, 0, 0);
         this.tableLayoutPanel2.Controls.Add(this.label2, 0, 1);
         this.tableLayoutPanel2.Controls.Add(this.txtUsername, 1, 0);
         this.tableLayoutPanel2.Controls.Add(this.txtPassword, 1, 1);
         this.tableLayoutPanel2.Controls.Add(this.chkShowPass, 2, 1);
         this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
         this.tableLayoutPanel2.Location = new System.Drawing.Point(3, 20);
         this.tableLayoutPanel2.Name = "tableLayoutPanel2";
         this.tableLayoutPanel2.RowCount = 2;
         this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
         this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
         this.tableLayoutPanel2.Size = new System.Drawing.Size(402, 77);
         this.tableLayoutPanel2.TabIndex = 0;
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.label1.Location = new System.Drawing.Point(3, 0);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(106, 38);
         this.label1.TabIndex = 0;
         this.label1.Text = "Username";
         this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Dock = System.Windows.Forms.DockStyle.Fill;
         this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.label2.Location = new System.Drawing.Point(3, 38);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(106, 39);
         this.label2.TabIndex = 0;
         this.label2.Text = "Password";
         this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // txtUsername
         // 
         this.tableLayoutPanel2.SetColumnSpan(this.txtUsername, 2);
         this.txtUsername.Dock = System.Windows.Forms.DockStyle.Fill;
         this.txtUsername.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.txtUsername.Location = new System.Drawing.Point(115, 7);
         this.txtUsername.Margin = new System.Windows.Forms.Padding(3, 7, 3, 3);
         this.txtUsername.Name = "txtUsername";
         this.txtUsername.Size = new System.Drawing.Size(284, 24);
         this.txtUsername.TabIndex = 1;
         this.txtUsername.TextChanged += new System.EventHandler(this.txtUsername_TextChanged);
         // 
         // txtPassword
         // 
         this.txtPassword.Dock = System.Windows.Forms.DockStyle.Fill;
         this.txtPassword.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.txtPassword.Location = new System.Drawing.Point(115, 45);
         this.txtPassword.Margin = new System.Windows.Forms.Padding(3, 7, 3, 3);
         this.txtPassword.Name = "txtPassword";
         this.txtPassword.PasswordChar = '•';
         this.txtPassword.Size = new System.Drawing.Size(250, 24);
         this.txtPassword.TabIndex = 1;
         this.txtPassword.TextChanged += new System.EventHandler(this.txtPassword_TextChanged);
         // 
         // chkShowPass
         // 
         this.chkShowPass.AutoSize = true;
         this.chkShowPass.Dock = System.Windows.Forms.DockStyle.Fill;
         this.chkShowPass.Location = new System.Drawing.Point(371, 41);
         this.chkShowPass.Name = "chkShowPass";
         this.chkShowPass.Size = new System.Drawing.Size(28, 33);
         this.chkShowPass.TabIndex = 2;
         this.chkShowPass.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
         this.chkShowPass.UseVisualStyleBackColor = true;
         this.chkShowPass.CheckedChanged += new System.EventHandler(this.chkShowPass_CheckedChanged);
         // 
         // groupBox4
         // 
         this.groupBox4.Controls.Add(this.btnTestConnect);
         this.groupBox4.Controls.Add(this.btnStart);
         this.groupBox4.Dock = System.Windows.Forms.DockStyle.Fill;
         this.groupBox4.Location = new System.Drawing.Point(11, 434);
         this.groupBox4.Margin = new System.Windows.Forms.Padding(11, 0, 11, 11);
         this.groupBox4.Name = "groupBox4";
         this.groupBox4.Padding = new System.Windows.Forms.Padding(11, 3, 11, 11);
         this.groupBox4.Size = new System.Drawing.Size(408, 68);
         this.groupBox4.TabIndex = 3;
         this.groupBox4.TabStop = false;
         // 
         // btnTestConnect
         // 
         this.btnTestConnect.Dock = System.Windows.Forms.DockStyle.Right;
         this.btnTestConnect.Location = new System.Drawing.Point(127, 20);
         this.btnTestConnect.Margin = new System.Windows.Forms.Padding(9, 3, 3, 3);
         this.btnTestConnect.Name = "btnTestConnect";
         this.btnTestConnect.Size = new System.Drawing.Size(135, 37);
         this.btnTestConnect.TabIndex = 0;
         this.btnTestConnect.Text = "Test connection";
         this.btnTestConnect.UseVisualStyleBackColor = true;
         this.btnTestConnect.Click += new System.EventHandler(this.btnTestConnect_Click);
         // 
         // btnStart
         // 
         this.btnStart.Dock = System.Windows.Forms.DockStyle.Right;
         this.btnStart.Location = new System.Drawing.Point(262, 20);
         this.btnStart.Margin = new System.Windows.Forms.Padding(9, 3, 3, 3);
         this.btnStart.Name = "btnStart";
         this.btnStart.Size = new System.Drawing.Size(135, 37);
         this.btnStart.TabIndex = 0;
         this.btnStart.Text = "Start";
         this.btnStart.UseVisualStyleBackColor = true;
         this.btnStart.Click += new System.EventHandler(this.btnStart_Click);
         // 
         // ConnectForm
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 18F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.ClientSize = new System.Drawing.Size(430, 577);
         this.Controls.Add(this.tableLayoutPanel1);
         this.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.MaximizeBox = false;
         this.MinimizeBox = false;
         this.Name = "ConnectForm";
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
         this.Text = "SQL Server Database connection - Group 1";
         this.Load += new System.EventHandler(this.ConnectForm_Load);
         this.tableLayoutPanel1.ResumeLayout(false);
         this.groupBox1.ResumeLayout(false);
         this.groupBox1.PerformLayout();
         this.groupBox2.ResumeLayout(false);
         this.groupBox2.PerformLayout();
         this.groupBox3.ResumeLayout(false);
         this.groupBox3.PerformLayout();
         this.grpSQLAu.ResumeLayout(false);
         this.tableLayoutPanel2.ResumeLayout(false);
         this.tableLayoutPanel2.PerformLayout();
         this.groupBox4.ResumeLayout(false);
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
      private System.Windows.Forms.GroupBox groupBox1;
      private System.Windows.Forms.TextBox txtServername;
      private System.Windows.Forms.GroupBox groupBox2;
      private System.Windows.Forms.TextBox txtDatabaseName;
      private System.Windows.Forms.GroupBox groupBox3;
      private System.Windows.Forms.RadioButton rbtnSQLAu;
      private System.Windows.Forms.RadioButton rbtnWindowAu;
      private System.Windows.Forms.GroupBox grpSQLAu;
      private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.Label label2;
      private System.Windows.Forms.TextBox txtUsername;
      private System.Windows.Forms.TextBox txtPassword;
      private System.Windows.Forms.CheckBox chkShowPass;
      private System.Windows.Forms.GroupBox groupBox4;
      private System.Windows.Forms.Button btnTestConnect;
      private System.Windows.Forms.Button btnStart;
   }
}

