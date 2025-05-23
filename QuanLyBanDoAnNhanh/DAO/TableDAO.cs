﻿using QuanLyBanDoAnNhanh.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyBanDoAnNhanh.DAO
{
    public class TableDAO
    {
        private static TableDAO instance;
        public static TableDAO Instance
        {
            get { if (instance == null) instance = new TableDAO(); return TableDAO.instance; }   
            private set {TableDAO.instance = value; }
        }
        public static int TableWidth = 90;
        public static int TableHeight = 90;

        private TableDAO() { }
        public List<Table> LoadTableList()
        {
            List<Table> tableList = new List<Table>();

            DataTable data = DataProvider.Instance.ExecuteQuery("exec dbo.USP_GetTableList");
            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                tableList.Add(table);
               
            }
            return tableList;


        }

        public List<Table> GetListTable()
        {
            List<Table> list = new List<Table>();
            string query = "select * from TableFood ";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                list.Add(table);
            }
            return list;
        }

        /* public bool InsertTable( string name, string status)
         {
             status = "Trống";
             string query = string.Format("insert dbo.TableFood (name , status)  values (N'{0}' ,N'{1}')",  name, status);
             int result = DataProvider.Instance.ExecuteNonQuery(query);

             return result > 0;
         }*/
        public bool InsertTable(string name)
        {
            
            string query = string.Format("insert dbo.TableFood (name , status)  values (N'{0}' ,N' ')", name);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool UpdateTable(int idTable, string name, string status)
        {
            status = " ";
            string query = string.Format("update dbo.TableFood set name = N'{0}', status = N'{1}' where id = {2}", name, status, idTable);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool DeleteTable(int idTable)
        {
           
            string query = string.Format("Delete TableFood where id = {0}", idTable);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

    }
}
