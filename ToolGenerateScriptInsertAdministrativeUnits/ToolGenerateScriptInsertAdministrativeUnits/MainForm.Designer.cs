namespace ToolGenerateScriptInsertAdministrativeUnits
{
   partial class MainForm
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
         this.btnStart = new System.Windows.Forms.Button();
         this.label1 = new System.Windows.Forms.Label();
         this.label2 = new System.Windows.Forms.Label();
         this.btnExcel = new System.Windows.Forms.Button();
         this.btnScript = new System.Windows.Forms.Button();
         this.txtExcelFilePath = new System.Windows.Forms.TextBox();
         this.txtScriptFilePath = new System.Windows.Forms.TextBox();
         this.label3 = new System.Windows.Forms.Label();
         this.chkOpenAfter = new System.Windows.Forms.CheckBox();
         this.tableLayoutPanel1.SuspendLayout();
         this.SuspendLayout();
         // 
         // tableLayoutPanel1
         // 
         this.tableLayoutPanel1.ColumnCount = 3;
         this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
         this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
         this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
         this.tableLayoutPanel1.Controls.Add(this.btnStart, 1, 4);
         this.tableLayoutPanel1.Controls.Add(this.label1, 0, 2);
         this.tableLayoutPanel1.Controls.Add(this.label2, 0, 1);
         this.tableLayoutPanel1.Controls.Add(this.btnExcel, 2, 1);
         this.tableLayoutPanel1.Controls.Add(this.btnScript, 2, 2);
         this.tableLayoutPanel1.Controls.Add(this.txtExcelFilePath, 1, 1);
         this.tableLayoutPanel1.Controls.Add(this.txtScriptFilePath, 1, 2);
         this.tableLayoutPanel1.Controls.Add(this.label3, 0, 0);
         this.tableLayoutPanel1.Controls.Add(this.chkOpenAfter, 1, 3);
         this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
         this.tableLayoutPanel1.Name = "tableLayoutPanel1";
         this.tableLayoutPanel1.RowCount = 6;
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
         this.tableLayoutPanel1.Size = new System.Drawing.Size(731, 305);
         this.tableLayoutPanel1.TabIndex = 0;
         // 
         // btnStart
         // 
         this.btnStart.Dock = System.Windows.Forms.DockStyle.Right;
         this.btnStart.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.btnStart.Location = new System.Drawing.Point(536, 197);
         this.btnStart.Margin = new System.Windows.Forms.Padding(5);
         this.btnStart.Name = "btnStart";
         this.btnStart.Size = new System.Drawing.Size(90, 30);
         this.btnStart.TabIndex = 4;
         this.btnStart.Text = "Start";
         this.btnStart.UseVisualStyleBackColor = true;
         this.btnStart.Click += new System.EventHandler(this.btnStart_Click);
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.label1.Location = new System.Drawing.Point(3, 112);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(94, 40);
         this.label1.TabIndex = 0;
         this.label1.Text = "File script";
         this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // label2
         // 
         this.label2.AutoSize = true;
         this.label2.Dock = System.Windows.Forms.DockStyle.Fill;
         this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.label2.Location = new System.Drawing.Point(3, 72);
         this.label2.Name = "label2";
         this.label2.Size = new System.Drawing.Size(94, 40);
         this.label2.TabIndex = 0;
         this.label2.Text = "File excel";
         this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // btnExcel
         // 
         this.btnExcel.Dock = System.Windows.Forms.DockStyle.Fill;
         this.btnExcel.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.btnExcel.Location = new System.Drawing.Point(636, 77);
         this.btnExcel.Margin = new System.Windows.Forms.Padding(5);
         this.btnExcel.Name = "btnExcel";
         this.btnExcel.Size = new System.Drawing.Size(90, 30);
         this.btnExcel.TabIndex = 1;
         this.btnExcel.Text = "Browse";
         this.btnExcel.UseVisualStyleBackColor = true;
         this.btnExcel.Click += new System.EventHandler(this.btnExcel_Click);
         // 
         // btnScript
         // 
         this.btnScript.Dock = System.Windows.Forms.DockStyle.Fill;
         this.btnScript.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.btnScript.Location = new System.Drawing.Point(636, 117);
         this.btnScript.Margin = new System.Windows.Forms.Padding(5);
         this.btnScript.Name = "btnScript";
         this.btnScript.Size = new System.Drawing.Size(90, 30);
         this.btnScript.TabIndex = 1;
         this.btnScript.Text = "Browse";
         this.btnScript.UseVisualStyleBackColor = true;
         this.btnScript.Click += new System.EventHandler(this.btnScript_Click);
         // 
         // txtExcelFilePath
         // 
         this.txtExcelFilePath.Dock = System.Windows.Forms.DockStyle.Fill;
         this.txtExcelFilePath.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.txtExcelFilePath.Location = new System.Drawing.Point(103, 80);
         this.txtExcelFilePath.Margin = new System.Windows.Forms.Padding(3, 8, 3, 3);
         this.txtExcelFilePath.Name = "txtExcelFilePath";
         this.txtExcelFilePath.Size = new System.Drawing.Size(525, 24);
         this.txtExcelFilePath.TabIndex = 2;
         // 
         // txtScriptFilePath
         // 
         this.txtScriptFilePath.Dock = System.Windows.Forms.DockStyle.Fill;
         this.txtScriptFilePath.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.txtScriptFilePath.Location = new System.Drawing.Point(103, 120);
         this.txtScriptFilePath.Margin = new System.Windows.Forms.Padding(3, 8, 3, 3);
         this.txtScriptFilePath.Name = "txtScriptFilePath";
         this.txtScriptFilePath.ReadOnly = true;
         this.txtScriptFilePath.Size = new System.Drawing.Size(525, 24);
         this.txtScriptFilePath.TabIndex = 2;
         // 
         // label3
         // 
         this.label3.AutoSize = true;
         this.tableLayoutPanel1.SetColumnSpan(this.label3, 3);
         this.label3.Dock = System.Windows.Forms.DockStyle.Fill;
         this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.label3.Location = new System.Drawing.Point(3, 0);
         this.label3.Name = "label3";
         this.label3.Size = new System.Drawing.Size(725, 72);
         this.label3.TabIndex = 3;
         this.label3.Text = "TOOL GENERATE SCRIPT\r\nFOR INSERT ADMINISTRATIVE UNITS";
         this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
         // 
         // chkOpenAfter
         // 
         this.chkOpenAfter.AutoSize = true;
         this.chkOpenAfter.Location = new System.Drawing.Point(103, 155);
         this.chkOpenAfter.Name = "chkOpenAfter";
         this.chkOpenAfter.Size = new System.Drawing.Size(181, 21);
         this.chkOpenAfter.TabIndex = 5;
         this.chkOpenAfter.Text = "Open file after generate";
         this.chkOpenAfter.UseVisualStyleBackColor = true;
         // 
         // MainForm
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.ClientSize = new System.Drawing.Size(731, 305);
         this.Controls.Add(this.tableLayoutPanel1);
         this.MaximizeBox = false;
         this.MinimizeBox = false;
         this.Name = "MainForm";
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
         this.Text = "Generate Script";
         this.tableLayoutPanel1.ResumeLayout(false);
         this.tableLayoutPanel1.PerformLayout();
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.Label label2;
      private System.Windows.Forms.Button btnExcel;
      private System.Windows.Forms.Button btnScript;
      private System.Windows.Forms.TextBox txtExcelFilePath;
      private System.Windows.Forms.TextBox txtScriptFilePath;
      private System.Windows.Forms.Label label3;
      private System.Windows.Forms.Button btnStart;
      private System.Windows.Forms.CheckBox chkOpenAfter;
   }
}

