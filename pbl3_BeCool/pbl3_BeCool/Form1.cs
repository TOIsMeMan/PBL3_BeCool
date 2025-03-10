using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pbl3_BeCool
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            this.showLoginView();
        }
        private void switchView(Form view)
        {
            panel1.Controls.Clear();    // Xoá View cũ
            view.TopLevel = false;              // Để View hoạt động trong Panel
            view.FormBorderStyle = FormBorderStyle.None;
            view.Dock = DockStyle.Fill;         // Đổ đầy Panel
            panel1.Controls.Add(view);
            view.Show();
        }
        public void showLoginView()
        {
            LoginView loginView = new LoginView(this);
            this.switchView(loginView);
        }
    }
}
