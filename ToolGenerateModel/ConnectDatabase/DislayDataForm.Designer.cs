namespace ConnectDatabase
{
   partial class DislayDataForm
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
         this.dgvResult = new System.Windows.Forms.DataGridView();
         this.label1 = new System.Windows.Forms.Label();
         this.cmbTables = new System.Windows.Forms.ComboBox();
         this.btnGenerate = new System.Windows.Forms.Button();
         this.GenerateEF = new System.Windows.Forms.Button();
         this.tableLayoutPanel1.SuspendLayout();
         ((System.ComponentModel.ISupportInitialize)(this.dgvResult)).BeginInit();
         this.SuspendLayout();
         // 
         // tableLayoutPanel1
         // 
         this.tableLayoutPanel1.ColumnCount = 2;
         this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
         this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
         this.tableLayoutPanel1.Controls.Add(this.dgvResult, 0, 1);
         this.tableLayoutPanel1.Controls.Add(this.label1, 0, 0);
         this.tableLayoutPanel1.Controls.Add(this.cmbTables, 1, 0);
         this.tableLayoutPanel1.Controls.Add(this.btnGenerate, 1, 2);
         this.tableLayoutPanel1.Controls.Add(this.GenerateEF, 0, 2);
         this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
         this.tableLayoutPanel1.Name = "tableLayoutPanel1";
         this.tableLayoutPanel1.RowCount = 3;
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
         this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
         this.tableLayoutPanel1.Size = new System.Drawing.Size(800, 450);
         this.tableLayoutPanel1.TabIndex = 0;
         // 
         // dgvResult
         // 
         this.dgvResult.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
         this.tableLayoutPanel1.SetColumnSpan(this.dgvResult, 2);
         this.dgvResult.Dock = System.Windows.Forms.DockStyle.Fill;
         this.dgvResult.Location = new System.Drawing.Point(10, 45);
         this.dgvResult.Margin = new System.Windows.Forms.Padding(10, 5, 10, 10);
         this.dgvResult.Name = "dgvResult";
         this.dgvResult.RowHeadersWidth = 51;
         this.dgvResult.RowTemplate.Height = 24;
         this.dgvResult.Size = new System.Drawing.Size(780, 355);
         this.dgvResult.TabIndex = 0;
         // 
         // label1
         // 
         this.label1.AutoSize = true;
         this.label1.Dock = System.Windows.Forms.DockStyle.Fill;
         this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.label1.Location = new System.Drawing.Point(3, 0);
         this.label1.Name = "label1";
         this.label1.Size = new System.Drawing.Size(114, 40);
         this.label1.TabIndex = 1;
         this.label1.Text = "Select table";
         this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
         // 
         // cmbTables
         // 
         this.cmbTables.Dock = System.Windows.Forms.DockStyle.Fill;
         this.cmbTables.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
         this.cmbTables.FormattingEnabled = true;
         this.cmbTables.Location = new System.Drawing.Point(123, 8);
         this.cmbTables.Margin = new System.Windows.Forms.Padding(3, 8, 20, 3);
         this.cmbTables.Name = "cmbTables";
         this.cmbTables.Size = new System.Drawing.Size(657, 26);
         this.cmbTables.TabIndex = 2;
         this.cmbTables.SelectedIndexChanged += new System.EventHandler(this.cmbTables_SelectedIndexChanged);
         // 
         // btnGenerate
         // 
         this.btnGenerate.Dock = System.Windows.Forms.DockStyle.Right;
         this.btnGenerate.Location = new System.Drawing.Point(659, 413);
         this.btnGenerate.Margin = new System.Windows.Forms.Padding(3, 3, 10, 3);
         this.btnGenerate.Name = "btnGenerate";
         this.btnGenerate.Size = new System.Drawing.Size(131, 34);
         this.btnGenerate.TabIndex = 3;
         this.btnGenerate.Text = "Generate model";
         this.btnGenerate.UseVisualStyleBackColor = true;
         this.btnGenerate.Click += new System.EventHandler(this.btnGenerate_Click);
         // 
         // GenerateEF
         // 
         this.GenerateEF.Dock = System.Windows.Forms.DockStyle.Fill;
         this.GenerateEF.Location = new System.Drawing.Point(3, 413);
         this.GenerateEF.Name = "GenerateEF";
         this.GenerateEF.Size = new System.Drawing.Size(114, 34);
         this.GenerateEF.TabIndex = 4;
         this.GenerateEF.Text = "Generate EF";
         this.GenerateEF.UseVisualStyleBackColor = true;
         this.GenerateEF.Click += new System.EventHandler(this.GenerateEF_Click);
         // 
         // DislayDataForm
         // 
         this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
         this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
         this.ClientSize = new System.Drawing.Size(800, 450);
         this.Controls.Add(this.tableLayoutPanel1);
         this.Name = "DislayDataForm";
         this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
         this.Text = "DiaplayDataForm";
         this.Load += new System.EventHandler(this.DislayDataForm_Load);
         this.tableLayoutPanel1.ResumeLayout(false);
         this.tableLayoutPanel1.PerformLayout();
         ((System.ComponentModel.ISupportInitialize)(this.dgvResult)).EndInit();
         this.ResumeLayout(false);

      }

      #endregion

      private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
      private System.Windows.Forms.Label label1;
      private System.Windows.Forms.ComboBox cmbTables;
      private System.Windows.Forms.DataGridView dgvResult;
      private System.Windows.Forms.Button btnGenerate;
      private System.Windows.Forms.Button GenerateEF;
   }
}