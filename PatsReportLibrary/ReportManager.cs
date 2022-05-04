namespace Telerik.Reporting.Pats.Reports
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Reflection;
    using System.Text;

    public class ReportInfo
    {
        string name;
        string description;
        Type reportType;
        int index;

        public string Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        public string Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        public string AssemblyQualifiedName
        {
            get
            {
                return this.reportType.AssemblyQualifiedName;
            }
        }

        public Type ReportType
        {
            get { return this.reportType; }
            set { this.reportType = value; }
        }

        public int Index
        {
            get { return this.index; }
            set { this.index = value; }
        }

        public ReportInfo(string name
            , string description
            , Type reportType
            , int index)
        {
            this.name = name;
            this.description = description;
            this.reportType = reportType;
            this.index = index;
        }
    }

    public class ReportManager
    {
        Assembly reportAssembly;

        public ReportManager()
            : this(typeof(ReportManager).Assembly)
        {
        }

        public ReportManager(Assembly reportAssembly)
        {
            this.reportAssembly = reportAssembly;
        }

        public IEnumerable<ReportInfo> GetReports()
        {
            if (null != this.reportAssembly)
            {
                List<Type> types = new List<Type>();
                foreach (Type t in this.reportAssembly.GetTypes())
                {
                    if (IsValidReportType(t))
                    {
                        types.Add(t);
                    }
                }

                types.Sort(delegate (Type t1, Type t2) { return t1.Name.CompareTo(t2.Name); });

                for (int i = 0; i < types.Count; i++)
                {
                    yield return CreateReportInfo(types[i], i);
                }
            }
        }

        static bool IsValidReportType(Type t)
        {
            if (typeof(Telerik.Reporting.IReportDocument).IsAssignableFrom(t) && !t.IsAbstract)
            {
                object[] attributes = t.GetCustomAttributes(typeof(BrowsableAttribute), false);
                if (attributes.Length > 0)
                {
                    return ((BrowsableAttribute)attributes[0]).Browsable;
                }
                else
                {
                    return true;
                }
            }
            return false;
        }

        static ReportInfo CreateReportInfo(Type t, int index)
        {
            string description = string.Empty;
            object[] attributes = null;

            attributes = t.GetCustomAttributes(typeof(DescriptionAttribute), false);
            if (attributes.Length > 0)
            {
                description = ((DescriptionAttribute)attributes[0]).Description;
            }

            var name = t.Name.Contains("_") ? t.Name.Replace("_", " ") : FormatName(t.Name);
            ReportInfo reportInfo = new ReportInfo(name
                 , FormatDescription(description)
                 , t
                 , index);

            return reportInfo;
        }

        static string FormatDescription(string text)
        {
            if (!text.EndsWith("."))
            {
                text += ".";
            }
            return text;
        }

        static string FormatName(string name)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < name.Length; i++)
            {
                char c = name[i];
                if (i == 0)
                {
                    c = Char.ToUpper(c);
                }
                else if (Char.IsUpper(c))
                {
                    sb.Append(" ");
                }
                sb.Append(c);
            }
            return sb.ToString();
        }
    }
}