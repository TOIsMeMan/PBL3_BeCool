﻿using System;
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
    public partial class LoginView : ChildForm
    {
        public LoginView(Form1 view)
        {
            this.parentForm = view;
            InitializeComponent();
        }
    }
}
