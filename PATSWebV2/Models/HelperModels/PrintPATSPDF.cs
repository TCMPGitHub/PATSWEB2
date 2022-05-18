using IdentityManagement.Entities;
using IdentityManagement.Entities.Psychiatry;
using IdentityManagement.Entities.Appointment;
using iTextSharp.text;
using iTextSharp.text.pdf;
using PATSWebV2.Controllers;
using PATSWebV2.ViewModels;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using PATSWebV2.ViewModels.SocialWork;

namespace PATS.Models.HelperModels
{
    public static class PatsFont
    {
        public static BaseFont PatsFontBold { get { return BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED); } }
        public static BaseFont PatsFontNormal { get { return BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED); } }
        public static BaseFont PatsFontItalic { get { return BaseFont.CreateFont(BaseFont.TIMES_BOLDITALIC, BaseFont.CP1252, BaseFont.NOT_EMBEDDED); } }
        public static Font PatsHeadBold { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 16f, Font.BOLD, new BaseColor(0, 64, 128)); } }
        public static Font Pats12HeadBold { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 12f, Font.BOLD, new BaseColor(0, 64, 128)); } }
        public static Font PatsBold { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 12f, Font.BOLD, new BaseColor(0, 64, 128)); } }
        public static Font Pats14HeadBold { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 14f, Font.BOLD, BaseColor.BLACK); } }

        public static Font Pats10HeadBold { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 10f, Font.BOLD, BaseColor.BLACK); } }
        public static Font Pats14Normal { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 14f, Font.NORMAL, BaseColor.DARK_GRAY); } }
        public static Font Pats12Normal { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 12f, Font.NORMAL, BaseColor.DARK_GRAY); } }
        public static Font Pats10Normal { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 10f, Font.NORMAL, BaseColor.BLACK); } }
        public static Font PatsNormal { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 12f, Font.NORMAL, BaseColor.DARK_GRAY); } }
        public static Font PatsSmall { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 8f, Font.NORMAL, BaseColor.DARK_GRAY); } }
        public static Font PatsSmall6 { get { return new Font(BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 6f, Font.NORMAL, BaseColor.DARK_GRAY); } }
        public static Font CA6B1
        {
            get
            {
                return FontFactory.GetFont(BaseFont.TIMES_BOLD, 6, BaseColor.BLACK);
            }
        }
        public static Font CA8 { get { return FontFactory.GetFont(BaseFont.TIMES_ROMAN, 8, BaseColor.BLACK); } }
        public static Font CA8B { get { return FontFactory.GetFont(BaseFont.TIMES_BOLD, 8, BaseColor.BLACK); } }

        public static Font CA6BB { get { return FontFactory.GetFont(BaseFont.TIMES_BOLD, 6, BaseColor.BLACK); } }
        public static Font CA6B { get { return FontFactory.GetFont(BaseFont.TIMES_BOLD, 6, new BaseColor(0, 64, 128)); } }
        public static Font CA6 { get { return FontFactory.GetFont(BaseFont.TIMES_ROMAN, 6, new BaseColor(0, 64, 128)); } }
        public static Font CA5 { get { return FontFactory.GetFont(BaseFont.TIMES_ROMAN, 5, new BaseColor(0, 64, 128)); } }
        public static Font CA4 { get { return FontFactory.GetFont(BaseFont.TIMES_ROMAN, 4, new BaseColor(0, 64, 128)); } }

        public static Font PatsHHeadBold { get { return new Font(BaseFont.CreateFont(BaseFont.HELVETICA_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 14f, Font.BOLD, BaseColor.BLACK); } }
        public static Font PatsHHeadBold12 { get { return new Font(BaseFont.CreateFont(BaseFont.HELVETICA_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 12f, Font.BOLD, BaseColor.BLACK); } }

        public static Font PatsHHeadBold8 { get { return new Font(BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 8f, Font.BOLD, BaseColor.BLACK); } }
        public static Font PatsHNormal8 { get { return new Font(BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 8f, Font.BOLD, new BaseColor(0, 64, 128)); } }
        public static Font PatsHNormal6 { get { return new Font(BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED), 6f, Font.BOLD, new BaseColor(0, 64, 128)); } }
    }
   
    public class PrintPATSPDF
    {
        private void PATSCheckboxField(PdfStamper stamper, iTextSharp.text.Rectangle rect, String name, int pagenumber, bool isChecked)
        {

            RadioCheckField field = new RadioCheckField(stamper.Writer, rect, name, "Yes");
            field.CheckType = RadioCheckField.TYPE_CHECK;
            field.Checked = isChecked;
            field.BorderWidth = BaseField.BORDER_WIDTH_THIN;
            field.BorderColor = BaseColor.BLACK;
            field.BackgroundColor = BaseColor.WHITE;
            stamper.AddAnnotation(field.CheckField, pagenumber);
        }
        private string GetRomanNumber(int num)
        {
            switch (num)
            {
                case 1: return "I.";
                case 2: return "II.";
                case 3: return "III.";
                case 4: return "IV.";
                case 5: return "V.";
                case 6: return "VI.";
                case 7: return "VII.";
                case 8: return "VIII.";
                case 9: return "IX.";
                case 10: return "X.";
                case 11: return "XI.";
                case 12: return "XII.";
                case 13: return "XIII.";
                default: return "";
            }
        }
        //public Byte[] GeneratePrescriptionStream(string LoginUser, string PsychiatristName, string Watermark, MediCalInfor medInfo)
        //{
        //    Byte[] bytes;
        //    using (var ms = new MemoryStream())
        //    {
        //        using (var doc = new Document(PageSize.A5, 30, 30, 30, 60))
        //        {
        //            BaseFont bfTimes = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
        //            //BaseFont bfTimes = BaseFont.CreateFont(BaseFont.COURIER, BaseFont.CP1252, false);
        //            Font bold = new Font(bfTimes, 10f, Font.BOLD, new BaseColor(0, 64, 128));
        //            Font normal = new Font(bfTimes, 8f, Font.NORMAL, BaseColor.DARK_GRAY);
        //            Font small = new Font(bfTimes, 6f, Font.NORMAL, BaseColor.DARK_GRAY);

        //            var Helvetica6 = FontFactory.GetFont(BaseFont.HELVETICA_BOLD, 6, new BaseColor(0, 64, 128));
        //            var Helvetica6b = FontFactory.GetFont(BaseFont.HELVETICA, 6, BaseColor.BLACK);
        //            var Helvetica5b = FontFactory.GetFont(BaseFont.HELVETICA, 5, BaseColor.BLACK);
        //            var Helvetica4b = FontFactory.GetFont(BaseFont.HELVETICA, 4, BaseColor.BLACK);

        //            //Create a writer that's bound to our PDF abstraction and our stream
        //            using (var writer = PdfWriter.GetInstance(doc, ms))
        //            {
        //                writer.PageEvent = new HeaderFooter(LoginUser, PsychiatristName, medInfo, Watermark, 10f, 100f, 100f, 360f);

        //                //Open the document for writing
        //                doc.Open();

        //                PdfContentByte cb;
        //                cb = writer.DirectContent;

        //                //Create PdfTable object for episode
        //                PdfPTable pdfTab = new PdfPTable(4);
        //                string[] list = new string[4] { "MemberID", "Client Name", "Client DOB", "Rx Date" };
        //                //Row 1
        //                for (int i = 0; i < 4; i++)
        //                {
        //                    PrintRow(pdfTab, list[i], Helvetica6, 1, 0, 0);
        //                }

        //                //Row2
        //                string[] list1 = new string[4] { medInfo.CDCRNum, medInfo.ClientName, medInfo.BirthYM, medInfo.PrescriptionDate };
        //                for (int i = 0; i < 4; i++)
        //                {
        //                    PrintRow(pdfTab, list1[i], Helvetica6b, 1, 0, 0);
        //                }

        //                pdfTab.TotalWidth = doc.PageSize.Width / 2;
        //                pdfTab.WidthPercentage = 80;

        //                float[] tabwidths = { pdfTab.TotalWidth / 4 - 10, pdfTab.TotalWidth / 4 + 43, pdfTab.TotalWidth / 4 - 6, pdfTab.TotalWidth / 4 - 18 };
        //                pdfTab.GetRow(0).SetWidths(tabwidths);
        //                if (pdfTab.Rows.Count > 1)
        //                    pdfTab.GetRow(1).SetWidths(tabwidths);
        //                pdfTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 70, cb);


        //                //table for psychiatrist
        //                //Create PdfTable object
        //                PdfPTable pdfpsyTab = new PdfPTable(4);
        //                string[] list2 = new string[3] { "Psychiatrist Name", "Location", "Address" };
        //                for (int i = 0; i < 3; i++)
        //                {
        //                    if (i == 2)
        //                        PrintRow(pdfpsyTab, list2[i], Helvetica6, 2, 0, 0);
        //                    else
        //                        PrintRow(pdfpsyTab, list2[i], Helvetica6, 1, 0, 1);
        //                }

        //                string[] list3 = new string[3] { medInfo.PsychiatristName, medInfo.Location, medInfo.PrimAddress };
        //                for (int i = 0; i < 3; i++)
        //                {
        //                    if (i == 2)
        //                        PrintRow(pdfpsyTab, list3[i], Helvetica6b, 2, 0, 0);
        //                    else
        //                        PrintRow(pdfpsyTab, list3[i], Helvetica6b, 1, 0, 1);
        //                }

        //                pdfpsyTab.TotalWidth = doc.PageSize.Width / 2;
        //                pdfpsyTab.WidthPercentage = 80;

        //                float[] tabpsywidths = { pdfpsyTab.TotalWidth / 4 + 20, pdfpsyTab.TotalWidth / 4 - 20, pdfpsyTab.TotalWidth / 4, pdfpsyTab.TotalWidth / 4 + 10 };
        //                pdfpsyTab.GetRow(0).SetWidths(tabpsywidths);
        //                pdfpsyTab.GetRow(1).SetWidths(tabpsywidths);
        //                //call WriteSelectedRows of PdfTable. This writes rows from PdfWriter in PdfTable
        //                //first param is start row. -1 indicates there is no end row and all the rows to be included to write
        //                //Third and fourth param is x and y position to start writing
        //                pdfpsyTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 90, cb);

        //                //table 2 for pharmacy
        //                PdfPTable pdfTabPharm = new PdfPTable(2);
        //                PrintRow(pdfTabPharm, "Pharmacy", Helvetica6, 2, 0, 0);
        //                PrintRow(pdfTabPharm, "Address: ", Helvetica6, 0, 0, 1);
        //                PrintRow(pdfTabPharm, medInfo.PhAddress.Name, Helvetica6b, 1, 0, 1);
        //                PrintRow(pdfTabPharm, medInfo.PhAddress.Street + "  " + medInfo.PhAddress.City + " " + medInfo.PhAddress.State + " " + medInfo.PhAddress.ZipCode, Helvetica5b, 2, 0, 1);
        //                PrintRow(pdfTabPharm, "Phone Number: ", Helvetica6, 0, 0,
        //                    1);
        //                PrintRow(pdfTabPharm, medInfo.PhAddress.PhoneNumber, Helvetica6b, 1, 0, 1);
        //                PrintRow(pdfTabPharm, "Fax Number: ", Helvetica6, 0, 0, 1);
        //                PrintRow(pdfTabPharm, medInfo.PhAddress.FaxNumber, Helvetica6b, 1, 0, 1);

        //                pdfTabPharm.TotalWidth = doc.PageSize.Width / 2 - 80;
        //                pdfTabPharm.WidthPercentage = 80;
        //                float[] widths = { pdfTabPharm.TotalWidth / 2 - 10, pdfTabPharm.TotalWidth / 2 + 10 };
        //                pdfTabPharm.GetRow(1).SetWidths(widths);
        //                pdfTabPharm.GetRow(2).SetWidths(widths);
        //                pdfTabPharm.GetRow(3).SetWidths(widths);
        //                pdfTabPharm.GetRow(4).SetWidths(widths);
        //                //call WriteSelectedRows of PdfTable. This writes rows from PdfWriter in PdfTable
        //                //first param is start row. -1 indicates there is no end row and all the rows to be included to write
        //                //Third and fourth param is x and y position to start writing
        //                pdfTabPharm.WriteSelectedRows(0, -1, pdfTab.TotalWidth + 50, doc.PageSize.Height - 70, cb);

        //                //table for medication
        //                PdfPTable pdfdsmTab = new PdfPTable(2);
        //                PrintRow(pdfdsmTab, "ICD Code: ", Helvetica6, 1, 0, 1);
        //                PrintRow(pdfdsmTab, "DIAGNOSIS: ", Helvetica6, 1, 0, 1);


        //                pdfdsmTab.TotalWidth = doc.PageSize.Width - 60;
        //                pdfdsmTab.WidthPercentage = 80;
        //                float[] dsmwidths = { pdfdsmTab.TotalWidth / 12 * 2, pdfdsmTab.TotalWidth / 12 * 10 };
        //                pdfdsmTab.GetRow(0).SetWidths(dsmwidths);

        //                PrintRow(pdfdsmTab, medInfo.ICDCode, Helvetica6b, 1, 0, 1);
        //                PrintRow(pdfdsmTab, medInfo.DSMDesc, Helvetica6b, 1, 0, 1);
        //                pdfdsmTab.GetRow(1).SetWidths(dsmwidths);
        //                pdfdsmTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 120, cb);

        //                //table for medication
        //                PdfPTable pdfmedTab = new PdfPTable(6);
        //                int pdfmedTabRow = 0;
        //                string[] list4 = new string[6] { "Medication (Generic Name)", "Brand Name", "Dosage", "Units", "Refills", "Directions" };
        //                for (int i = 0; i < 6; i++)
        //                {
        //                    PrintRow(pdfmedTab, list4[i], Helvetica6, 1, 0, 1);
        //                }

        //                pdfmedTab.TotalWidth = doc.PageSize.Width - 60;
        //                pdfmedTab.WidthPercentage = 80;
        //                float[] medwidths = { pdfmedTab.TotalWidth / 12 * 3, pdfmedTab.TotalWidth / 12 * 3 ,
        //                                      pdfmedTab.TotalWidth / 12, pdfmedTab.TotalWidth / 12, pdfmedTab.TotalWidth / 12,
        //                                      pdfmedTab.TotalWidth / 12 * 3};
        //                pdfmedTab.GetRow(0).SetWidths(medwidths);

        //                if (medInfo.MediCalList.Count() > 0)
        //                {
        //                    foreach (var item in medInfo.MediCalList)
        //                    {
        //                        pdfmedTabRow++;
        //                        PrintRow(pdfmedTab, item.Medication.GenericName, Helvetica6b, 1, 0, 1);
        //                        PrintRow(pdfmedTab, item.Medication.BrandName, Helvetica6b, 1, 0, 1);
        //                        PrintRow(pdfmedTab, item.Medication.DosageForm, Helvetica6b, 1, 0, 1);
        //                        PrintRow(pdfmedTab, item.Units.ToString(), Helvetica6b, 1, 0, 1);
        //                        PrintRow(pdfmedTab, item.NumberofReFill.ToString(), Helvetica6b, 1, 0, 1);
        //                        PrintRow(pdfmedTab, item.Directions, Helvetica6b, 1, 0, 1);
        //                        pdfmedTab.GetRow(pdfmedTabRow).SetWidths(medwidths);
        //                    }
        //                }
        //                pdfmedTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 150, cb);

        //                //table for Memo
        //                if (!string.IsNullOrEmpty(medInfo.Memo))
        //                {
        //                    PdfPTable pdfmemoTab = new PdfPTable(2);
        //                    PrintRow(pdfmemoTab, "Memo: ", Helvetica6, 0, 0, 1);
        //                    PrintRow(pdfmemoTab, medInfo.Memo, Helvetica6b, 3, 0, 1);

        //                    pdfmemoTab.TotalWidth = doc.PageSize.Width;
        //                    pdfmemoTab.WidthPercentage = 80;

        //                    float[] widthmemo = { pdfmemoTab.TotalWidth / 12, pdfmemoTab.TotalWidth / 12 * 10 };
        //                    pdfmemoTab.GetRow(0).SetWidths(widthmemo);
        //                    pdfmemoTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 400, cb);
        //                }
        //                doc.Close();
        //            }

        //        }

        //        bytes = ms.ToArray();
        //        ms.Close();
        //    }
        //    return bytes;
        //}

        public Byte[] GenerateCaseNoteStream(string loginUser, CaseNoteInfo cmNoteList)
        {
            Byte[] bytes;
            using (var ms = new MemoryStream())
            {
                using (var doc = new Document(PageSize.A4, 30, 30, 30, 60))
                {
                    //Create a writer that's bound to our PDF abstraction and our stream
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        writer.PageEvent = new HeaderFooter(loginUser, cmNoteList, 10f, 100f, 100f, 360f);

                        //Open the document for writing
                        doc.Open();

                        PdfContentByte cb;
                        cb = writer.DirectContent;

                        //================================
                        List<string> lineData = new List<string>();
                        int linecount = GetLineData(cmNoteList.Note, 110, out lineData);
                        int itemnum = 44;
                        var pagecount = (lineData.Count / itemnum) + ((lineData.Count % itemnum) > 0 ? 1 : 0);
                        //should count to a new line if characters more than 135 characters
                        string[] strNewPage = new string[pagecount];

                        for (int p1 = 0; p1 < pagecount; p1++)
                        {
                            for (int it = (itemnum * p1);
                                     it < (p1 * itemnum) + itemnum; it++)
                            {
                                strNewPage[p1] += lineData[it];

                                if (it == (lineData.Count - 1))
                                {
                                    break;
                                }

                                if (it == ((p1 * itemnum) + itemnum - 1))
                                {
                                    strNewPage[p1] += "\n---Contine to next page.---";
                                }
                            }
                        }

                        for (var indx = 0; indx < pagecount; indx++)
                        {
                            //================================
                            //Create PdfTable object for episode
                            PdfPTable pdfHeadEpiTab = new PdfPTable(3);
                            string[] list = new string[3] { "CDC No", "Client Name", "Note Date" };
                            //Row 1
                            for (int i = 0; i < 3; i++)
                            {
                                PrintRow(pdfHeadEpiTab, list[i], PatsFont.CA6B, 1, 0, 1);
                            }

                            //Row2
                            string[] list1 = new string[3] { cmNoteList.CDCRNum, cmNoteList.ClientName, cmNoteList.NoteDate };
                            for (int i = 0; i < 3; i++)
                            {
                                PrintRow(pdfHeadEpiTab, list1[i], PatsFont.CA6, 0, 0, 1);
                            }
                            string[] list2 = new string[3] { "Note Type", "Contact Method", "Entered By" };
                            //Row 3
                            for (int i = 0; i < 3; i++)
                            {
                                PrintRow(pdfHeadEpiTab, list2[i], PatsFont.CA6B, 1, 0, 1);
                            }
                            //Row4
                            string[] list3 = new string[3] { cmNoteList.NoteType, cmNoteList.ContactMethod, cmNoteList.EnteredBy };
                            for (int i = 0; i < 3; i++)
                            {
                                PrintRow(pdfHeadEpiTab, list3[i], PatsFont.CA6, 0, 0, 1);
                            }
                            //row 5
                            string[] list4 = new string[3] { "Note", " ", " " };
                            for (int i = 0; i < 3; i++)
                            {
                                PrintRow(pdfHeadEpiTab, list4[i], PatsFont.CA6B, 1, 0, 1);
                            }

                            pdfHeadEpiTab.TotalWidth = doc.PageSize.Width / 2 + 150;
                            pdfHeadEpiTab.WidthPercentage = 80;

                            float[] tabtitlewidths = { 80, 110, doc.PageSize.Width - (190 + 60) };

                            pdfHeadEpiTab.GetRow(0).SetWidths(tabtitlewidths);
                            pdfHeadEpiTab.GetRow(1).SetWidths(tabtitlewidths);
                            pdfHeadEpiTab.GetRow(2).SetWidths(tabtitlewidths);
                            pdfHeadEpiTab.GetRow(3).SetWidths(tabtitlewidths);
                            pdfHeadEpiTab.GetRow(4).SetWidths(tabtitlewidths);
                            pdfHeadEpiTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 70, cb);

                            PdfPTable pdfCNTab = new PdfPTable(1);
                            PrintRow(pdfCNTab, strNewPage[indx], PatsFont.Pats14Normal,
                                    int.Parse((doc.PageSize.Height - 120).ToString()), 0, 1);
                            pdfCNTab.TotalWidth = doc.PageSize.Width - 60;
                            pdfCNTab.WidthPercentage = 80;
                            float[] tabNotewidths = { pdfCNTab.TotalWidth };

                            pdfCNTab.GetRow(0).SetWidths(tabNotewidths);
                            pdfCNTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 120, cb);

                            if (pagecount - indx == 1)
                            {
                                PdfPTable pdfSignTab = new PdfPTable(4);
                                PdfPCell pdfSignCell1 = new PdfPCell(new Phrase("Signature", PatsFont.Pats14Normal));
                                PdfPCell pdfSignCell2 = new PdfPCell(new Phrase("____________________________________", PatsFont.PatsNormal));
                                PdfPCell pdfSignCell3 = new PdfPCell(new Phrase("Date Filed", PatsFont.Pats14Normal));
                                PdfPCell pdfSignCell4 = new PdfPCell(new Phrase("_________________", PatsFont.PatsNormal));
                                //pdfTab1Cell3.HorizontalAlignment = Element.ALIGN_MIDDLE;

                                pdfSignCell1.Border = 0;
                                pdfSignCell2.Border = 0;
                                pdfSignCell3.Border = 0;
                                pdfSignCell4.Border = 0;
                                pdfSignTab.AddCell(pdfSignCell1);
                                pdfSignTab.AddCell(pdfSignCell2);
                                pdfSignTab.AddCell(pdfSignCell3);
                                pdfSignTab.AddCell(pdfSignCell4);

                                pdfSignTab.TotalWidth = doc.PageSize.Width;
                                pdfSignTab.WidthPercentage = 90;
                                float[] twidths = { (pdfSignTab.TotalWidth / 5) - 50,
                                    pdfSignTab.TotalWidth /5 + 120,
                                    (pdfSignTab.TotalWidth /5) -50,
                                    pdfSignTab.TotalWidth /5 + 80
                                };
                                pdfSignTab.GetRow(0).SetWidths(twidths);
                                pdfSignTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 780, cb);
                            }
                            doc.NewPage();
                            doc.PageCount = pagecount;
                        }
                        doc.Close();
                    }
                }

                bytes = ms.ToArray();
                ms.Close();
            }
            return bytes;
        }
        public Byte[] GenerateAppointmentStream(string LoginUser, string AppointmentTitle, List<ApptActivityInfo> ApptInfo)
        {
            Byte[] bytes;
            using (var ms = new MemoryStream())
            {
                using (var doc = new Document(PageSize.A4.Rotate(), 30, 30, 30, 60))
                {
                    BaseFont bfTimes = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                    //BaseFont bfTimes = BaseFont.CreateFont(BaseFont.COURIER, BaseFont.CP1252, false);
                    Font bold = new Font(bfTimes, 10f, Font.BOLD, new BaseColor(0, 64, 128));
                    Font normal = new Font(bfTimes, 8f, Font.NORMAL, BaseColor.DARK_GRAY);
                    Font small = new Font(bfTimes, 6f, Font.NORMAL, BaseColor.DARK_GRAY);

                    var Helvetica8 = FontFactory.GetFont(BaseFont.HELVETICA_BOLD, 10, new BaseColor(0, 64, 128));
                    var Helvetica8b = FontFactory.GetFont(BaseFont.HELVETICA, 10, BaseColor.BLACK);
                    var Helvetica5b = FontFactory.GetFont(BaseFont.HELVETICA, 5, BaseColor.BLACK);
                    var Helvetica4b = FontFactory.GetFont(BaseFont.HELVETICA, 4, BaseColor.BLACK);

                    //Create a writer that's bound to our PDF abstraction and our stream
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        writer.PageEvent = new HeaderFooter(LoginUser, AppointmentTitle, 10f, 100f, 100f);

                        //Open the document for writing
                        doc.Open();

                        PdfContentByte cb;
                        cb = writer.DirectContent;
                        if (ApptInfo != null && ApptInfo.Count() > 0)
                        {
                            int itemnum = 30;
                            var pagecount = (ApptInfo.Count() / itemnum) + ((ApptInfo.Count() % itemnum) > 0 ? 1 : 0);
                            doc.PageCount = pagecount;
                            for (int indx = 0; indx < pagecount; indx++)
                            {
                                //table for appointments
                                PdfPTable pdfApptTab = new PdfPTable(10);
                                int pdfApptTabRow = 0;
                                string[] list = new string[10] { "Client Name", "CDCR#", "Unit", "Location", "Start Time", "End Time", "Appt. Type", "Appt. Status", "Follow-up Appt.", "Primary#" };
                                for (int i = 0; i < 10; i++)
                                {
                                    PrintRow(pdfApptTab, list[i], Helvetica8, 1, 1, 0);
                                }

                                pdfApptTab.TotalWidth = doc.PageSize.Width - 55;
                                pdfApptTab.WidthPercentage = 80;
                                float[] widths = { pdfApptTab.TotalWidth / 18 * 3,
                                        (pdfApptTab.TotalWidth / 14)-10, pdfApptTab.TotalWidth / 15,
                                        pdfApptTab.TotalWidth / 20 * 2, pdfApptTab.TotalWidth / 14,
                                        pdfApptTab.TotalWidth / 14, pdfApptTab.TotalWidth /16 * 2,
                                        pdfApptTab.TotalWidth / 16 * 2, pdfApptTab.TotalWidth / 18 * 2,
                                        pdfApptTab.TotalWidth / 20 * 2 };
                                pdfApptTab.GetRow(0).SetWidths(widths);
                                pdfApptTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 85, cb);

                                for (int it = (itemnum * indx); it < (indx * itemnum) + itemnum - 1; it++)
                                {
                                    pdfApptTabRow++;
                                    PdfPTable pdfApptTab1 = new PdfPTable(10);

                                    string[] list1 = new string[10] {
                            ApptInfo[it].ClientName,
                            ApptInfo[it].CDCRNum,
                            ApptInfo[it].Location,
                            ApptInfo[it].Unit,
                            ApptInfo[it].StartTime,
                            ApptInfo[it].EndTime,
                            ApptInfo[it].ApptType,
                            ApptInfo[it].ApptStatus,
                            ApptInfo[it].FollowupAppt,
                            ApptInfo[it].ContactPh };

                                    for (int i = 0; i < 10; i++)
                                    {
                                        PrintRow(pdfApptTab1, list1[i], Helvetica8b, 1, 1, 1);
                                    }
                                    pdfApptTab1.TotalWidth = doc.PageSize.Width - 55;
                                    pdfApptTab1.WidthPercentage = 80;
                                    float[] widths1 = { pdfApptTab1.TotalWidth / 18 * 3,
                                        (pdfApptTab.TotalWidth / 14)-10, pdfApptTab.TotalWidth / 15,
                                        pdfApptTab.TotalWidth / 20 * 2, pdfApptTab1.TotalWidth / 14,
                                        pdfApptTab1.TotalWidth / 14, pdfApptTab1.TotalWidth /16 * 2,
                                        pdfApptTab1.TotalWidth / 16 * 2, pdfApptTab1.TotalWidth / 18 * 2,
                                        pdfApptTab.TotalWidth / 20 * 2 }; pdfApptTab1.GetRow(0).SetWidths(widths1);
                                    pdfApptTab1.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - (85 + (pdfApptTabRow * 15)), cb);
                                    if (it == ApptInfo.Count() - 1)
                                    {
                                        break;
                                    }
                                }
                                doc.NewPage();
                                doc.PageCount = pagecount;
                            }
                        }
                        doc.Close();
                    }
                }
                bytes = ms.ToArray();
                ms.Close();
            }
            return bytes;
        }
        public Byte[] GenerateParoleAppointmentStream(string LoginUser, string AppointmentTitle, List<ApptActivityInfo> ApptInfo)
        {
            Byte[] bytes;
            using (var ms = new MemoryStream())
            {
                using (var doc = new Document(PageSize.A4.Rotate(), 30, 30, 30, 60))
                {
                    BaseFont bfTimes = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                    //BaseFont bfTimes = BaseFont.CreateFont(BaseFont.COURIER, BaseFont.CP1252, false);
                    Font bold = new Font(bfTimes, 10f, Font.BOLD, new BaseColor(0, 64, 128));
                    Font normal = new Font(bfTimes, 8f, Font.NORMAL, BaseColor.DARK_GRAY);
                    Font small = new Font(bfTimes, 6f, Font.NORMAL, BaseColor.DARK_GRAY);

                    var Helvetica8 = FontFactory.GetFont(BaseFont.HELVETICA_BOLD, 10, new BaseColor(0, 64, 128));
                    var Helvetica8b = FontFactory.GetFont(BaseFont.HELVETICA, 10, BaseColor.BLACK);
                    var Helvetica5b = FontFactory.GetFont(BaseFont.HELVETICA, 5, BaseColor.BLACK);
                    var Helvetica4b = FontFactory.GetFont(BaseFont.HELVETICA, 4, BaseColor.BLACK);

                    //Create a writer that's bound to our PDF abstraction and our stream
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        writer.PageEvent = new HeaderFooter(LoginUser, AppointmentTitle, 10f, 100f, 100f);

                        //Open the document for writing
                        doc.Open();

                        PdfContentByte cb;
                        cb = writer.DirectContent;
                        if (ApptInfo != null && ApptInfo.Count() > 0)
                        {
                            int itemnum = 30;
                            var pagecount = (ApptInfo.Count() / itemnum) + ((ApptInfo.Count() % itemnum) > 0 ? 1 : 0);
                            doc.PageCount = pagecount;
                            for (int indx = 0; indx < pagecount; indx++)
                            {
                                //table for appointments
                                PdfPTable pdfApptTab = new PdfPTable(9);
                                int pdfApptTabRow = 0;
                                string[] list = new string[9] { "Staff Name", "Unit", "Location", "Start Time", "End Time", "Appt. Type", "Appt. Status", "Follow-up Appt.","Primary#" };
                                for (int i = 0; i < 9; i++)
                                {
                                    PrintRow(pdfApptTab, list[i], Helvetica8, 1, 1, 0);
                                }

                                pdfApptTab.TotalWidth = doc.PageSize.Width - 55;
                                pdfApptTab.WidthPercentage = 80;
                                float[] widths = { pdfApptTab.TotalWidth / 18 * 3, pdfApptTab.TotalWidth / 16 * 2,          pdfApptTab.TotalWidth / 16 * 2, pdfApptTab.TotalWidth / 14,
                                    pdfApptTab.TotalWidth / 14, pdfApptTab.TotalWidth / 20 * 2,
                                    pdfApptTab.TotalWidth / 20 * 2, (pdfApptTab.TotalWidth / 20 * 2) + 25,
                                    pdfApptTab.TotalWidth / 20 * 2 };
                                pdfApptTab.GetRow(0).SetWidths(widths);
                                pdfApptTab.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - 85, cb);

                                for (int it = (itemnum * indx); it < (indx * itemnum) + itemnum - 1; it++)
                                {
                                    pdfApptTabRow++;
                                    PdfPTable pdfApptTab1 = new PdfPTable(9);

                                    string[] list1 = new string[9] {
                            ApptInfo[it].StaffName,
                            ApptInfo[it].Location,
                            ApptInfo[it].Unit,
                            ApptInfo[it].StartTime,
                            ApptInfo[it].EndTime,
                            ApptInfo[it].ApptType,
                            ApptInfo[it].ApptStatus,
                            ApptInfo[it].FollowupAppt,
                            ApptInfo[it].ContactPh };

                                    for (int i = 0; i < 9; i++)
                                    {
                                        PrintRow(pdfApptTab1, list1[i], Helvetica8b, 1, 1, 1);
                                    }
                                    pdfApptTab1.TotalWidth = doc.PageSize.Width - 55;
                                    pdfApptTab1.WidthPercentage = 80;
                                    float[] widths1 = { pdfApptTab1.TotalWidth / 18 * 3,
                                    pdfApptTab1.TotalWidth / 16 * 2,   pdfApptTab1.TotalWidth / 16 * 2,
                                    pdfApptTab1.TotalWidth / 14, pdfApptTab1.TotalWidth / 14,
                                    pdfApptTab1.TotalWidth / 20 * 2, pdfApptTab1.TotalWidth / 20 * 2,
                                    (pdfApptTab1.TotalWidth / 20 * 2) + 25, pdfApptTab1.TotalWidth / 20 * 2 };
                                    pdfApptTab1.GetRow(0).SetWidths(widths1);
                                    pdfApptTab1.WriteSelectedRows(0, -1, 30, doc.PageSize.Height - (85 + (pdfApptTabRow * 15)), cb);
                                    if (it == ApptInfo.Count() - 1)
                                    {
                                        break;
                                    }
                                }
                                doc.NewPage();
                                doc.PageCount = pagecount;
                            }
                        }
                        doc.Close();
                    }
                }
                bytes = ms.ToArray();
                ms.Close();
            }
            return bytes;
        }
        public Byte[] GenerateDMS5Stream(string LoginUser, Dictionary<string, string> HeaderData, List<DMS5> DMS5Data)
        {
            Byte[] bytes = null;
            using (var ms = new MemoryStream())
            {
                using (var doc = new Document(PageSize.A4, 30, 30, 30, 60))
                {
                    //write header from dictionary
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        writer.PageEvent = new HeaderFooter(LoginUser, DMS5Data, 10f, 100f, 100f);

                        //Open the document for writing
                        doc.Open();
                        
                        PdfContentByte cb;
                        cb = writer.DirectContent;
                        if (DMS5Data != null)
                        {
                            var docY = doc.PageSize.Height;
                            var currentY = docY - 50;
                            int pagecount = 1;
                            doc.PageCount = pagecount;
                            PrintHeaderRowWithCheckBox(cb, doc, HeaderData, (int)currentY, (int)doc.PageSize.Width, (int)doc.PageSize.Height);
                           
                            PdfPTable pdfDMS52Tab = new PdfPTable(1);
                            Phrase phrase = new Phrase();
                            phrase.Add(new Chunk("Instructions: ", FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.BOLD)));
                            phrase.Add(new Chunk(@"The questions below ask about things that might have bothered you. For each question, 
circle the number that best describes how much(or how often) you have been bothered by each problem during the past", FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.NORMAL)));
                            phrase.Add(new Chunk(" TWO (2) WEEKS", FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.BOLD)));

                            PdfPCell pdfDMS52TabCell1 = new PdfPCell(phrase);
                            pdfDMS52TabCell1.Border = 0;
                            pdfDMS52TabCell1.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                            pdfDMS52Tab.AddCell(pdfDMS52TabCell1);

                            pdfDMS52Tab.TotalWidth = doc.PageSize.Width;
                            pdfDMS52Tab.WidthPercentage = 100;
                            pdfDMS52Tab.WriteSelectedRows(0, -1, 30, docY - 70, cb);

                            currentY = 90;
                            var tabFoneB = FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.BOLD);
                            var tabFone = FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.NORMAL);
                            PdfPTable pdfDMS53Tab = new PdfPTable(8);
                            pdfDMS53Tab.TotalWidth = doc.PageSize.Width;
                            float[] twidths = { (pdfDMS53Tab.TotalWidth / 8) / 4, (pdfDMS53Tab.TotalWidth /8) * 3,
                                                (pdfDMS53Tab.TotalWidth / 8) / 2  + 10, (pdfDMS53Tab.TotalWidth /8) / 2  + 10,
                                                (pdfDMS53Tab.TotalWidth / 8) / 2  + 10, (pdfDMS53Tab.TotalWidth /8) / 2  + 10,
                                                (pdfDMS53Tab.TotalWidth / 8) / 2  + 10, (pdfDMS53Tab.TotalWidth /8) / 2  + 10 };
                            //header line
                            PdfPCell cell1 = new PdfPCell(new Phrase(new Chunk(" ", tabFoneB)));                 
                            pdfDMS53Tab.AddCell(cell1);

                            cell1 = new PdfPCell(new Phrase(new Chunk("During the past TWO (2) WEEKS, how much (or how often) have you been bothered by the following problems? ", tabFoneB)));
                            pdfDMS53Tab.AddCell(cell1);

                            cell1 = new PdfPCell(new Phrase(new Chunk("None Not at all ", tabFoneB)));
                            cell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                            pdfDMS53Tab.AddCell(cell1);

                            cell1 = new PdfPCell(new Phrase(new Chunk("Slight Rare, less than a day or two", tabFoneB)));
                            cell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                            pdfDMS53Tab.AddCell(cell1);

                            cell1 = new PdfPCell(new Phrase(new Chunk("Mild Several days", tabFoneB)));
                            cell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                            pdfDMS53Tab.AddCell(cell1);

                            cell1 = new PdfPCell(new Phrase(new Chunk("Moderate More than half the days", tabFoneB)));
                            cell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                            pdfDMS53Tab.AddCell(cell1);

                            cell1 = new PdfPCell(new Phrase(new Chunk("Severe Nearly every day", tabFoneB)));
                            cell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                            pdfDMS53Tab.AddCell(cell1);

                            cell1 = new PdfPCell(new Phrase(new Chunk("Highest Domain Score (clinician)", tabFoneB)));
                            cell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                            pdfDMS53Tab.AddCell(cell1);                                                    
                            pdfDMS53Tab.GetRow(0).SetWidths(twidths);
                            //body lines
                            var rowCount = 0;
                            var list = DMS5Data.Select(s=>s.GroupID).Distinct().ToList();
                            for (int d = 0; d < list.Count(); d++)
                            {
                                var gid = list[d];                
                                var items = DMS5Data.Where(w => w.GroupID == gid).ToList();
                                var icount = items.Count;
                                var hscore = -1;
                                for (int h = 0; h < icount; h++)
                                {
                                    if (items[h].ItemScore > hscore)
                                        hscore = items[h].ItemScore;
                                }

                                for (int j= 0; j < icount; j++)
                                {                             
                                    PdfPCell cell2 = null;
                                    if (j == 0)
                                    {
                                        cell2 = new PdfPCell(new Phrase(new Chunk(GetRomanNumber(gid), tabFone)));
                                        cell2.Rowspan = icount;
                                        cell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                                        cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                        pdfDMS53Tab.AddCell(cell2);
                                    }

                                    cell2 = new PdfPCell(new Phrase(new Chunk(items[j].DMS5ItemDesc.TrimEnd(), tabFone)));
                                    if (rowCount == 22)
                                        cell2.FixedHeight = 45f;
                                    cell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                                    cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                    pdfDMS53Tab.AddCell(cell2);
                                    cell2 = new PdfPCell(new Phrase(new Chunk(items[j].ItemScore == 0 ? "[0]" : "0", tabFone)));
                                    cell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                                    cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                    pdfDMS53Tab.AddCell(cell2);
                                    cell2 = new PdfPCell(new Phrase(new Chunk(items[j].ItemScore == 1 ? "[1]" : "1", tabFone)));
                                    cell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                                    cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                    pdfDMS53Tab.AddCell(cell2);
                                    cell2 = new PdfPCell(new Phrase(new Chunk(items[j].ItemScore == 2 ? "[2]" : "2", tabFone)));
                                    cell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                                    cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                    pdfDMS53Tab.AddCell(cell2);
                                    cell2 = new PdfPCell(new Phrase(new Chunk(items[j].ItemScore == 3 ? "[3]" : "3", tabFone)));
                                    cell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                                    cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                    pdfDMS53Tab.AddCell(cell2);
                                    cell2 = new PdfPCell(new Phrase(new Chunk(items[j].ItemScore == 4 ? "[4]" : "4", tabFone)));
                                    cell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                                    cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                    pdfDMS53Tab.AddCell(cell2);
                                    if (j == 0)
                                    {
                                        cell2 = new PdfPCell(new Phrase(new Chunk(hscore == -1 ? " " : hscore.ToString(), tabFone)));
                                        cell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                                        cell2.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
                                        cell2.Rowspan = icount;
                                        pdfDMS53Tab.AddCell(cell2);
                                    }
                                    pdfDMS53Tab.GetRow(rowCount + 1).SetWidths(twidths);
                                    rowCount++;
                                }
                             
                            };
                            pdfDMS53Tab.SetExtendLastRow(false, false);
                            pdfDMS53Tab.WriteSelectedRows(0, -1, 30, docY - currentY, cb);
                            
                        }
                        doc.Close();
                    }

                }
                bytes = ms.ToArray();
                ms.Close();
            }
            return bytes;
        }
        public Byte[] GenerateEvaluationStream(string LoginUser, Dictionary<string, string> EvaluationData)
        {
            Byte[] bytes = null;
            using (var ms = new MemoryStream())
            {
                using (var doc = new Document(PageSize.A4, 30, 30, 30, 60))
                {
                    //write header from dictionary
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        writer.PageEvent = new HeaderFooter(LoginUser, 10f, 100f, 100f);

                        //Open the document for writing
                        doc.Open();

                        PdfContentByte cb;
                        cb = writer.DirectContent;
                        if (EvaluationData != null)
                        {
                            var docY = doc.PageSize.Height;
                            int pagecount = 1;
                            doc.PageCount = pagecount;
                            //print profile info tale
                            PdfPTable pdfEval1Tab = new PdfPTable(6);
                            string[] list = new string[6] {
                                "CDCR#", EvaluationData["CDCRNumber"],
                                "PAROLEE NAME", EvaluationData["ParoleName"],
                                "REGION", EvaluationData["ParoleRegion"]};
                            for (int idx = 0; idx < list.Length; idx++)
                            {
                                if (idx % 2 == 0)
                                    PrintRow(pdfEval1Tab, list[idx], PatsFont.CA6B, 0, 1, 1);
                                else
                                    PrintRow(pdfEval1Tab, list[idx], PatsFont.PatsSmall, 0, 1, 1);
                            }
                            pdfEval1Tab.TotalWidth = doc.PageSize.Width - 60;
                            pdfEval1Tab.WidthPercentage = 90;

                            float[] widths = {
                                (pdfEval1Tab.TotalWidth / 6) - 15,
                                (pdfEval1Tab.TotalWidth / 6) - 35,
                                (pdfEval1Tab.TotalWidth / 6) + 10,
                                (pdfEval1Tab.TotalWidth / 6) + 120,
                                (pdfEval1Tab.TotalWidth / 6) - 40,
                                (pdfEval1Tab.TotalWidth / 6) - 40 };
                            pdfEval1Tab.GetRow(0).SetWidths(widths);
                            pdfEval1Tab.WriteSelectedRows(0, -1, 30, docY - 70, cb);

                            PdfPTable pdfEval2Tab = new PdfPTable(4);
                            string[] list1 = new string[4] {
                                "PAROLE AGENT", EvaluationData["ParoleAgent"],
                                "PAROLE UNIT", EvaluationData["ParoleUnit"]};

                            for (int idx = 0; idx < list1.Length; idx++)
                            {
                                if (idx % 2 == 0)
                                    PrintRow(pdfEval2Tab, list1[idx], PatsFont.CA6B, 0, 1, 1);
                                else
                                    PrintRow(pdfEval2Tab, list1[idx], PatsFont.PatsSmall, 0, 1, 1);
                            }
                            string[] list2 = new string[4] {
                                "EVALUATION DATE", EvaluationData["EvaluationDate"],
                                "EVALUATED BY", EvaluationData["EvaluatedBy"]};
                            for (int idx = 0; idx < list2.Length; idx++)
                            {
                                if (idx % 2 == 0)
                                    PrintRow(pdfEval2Tab, list2[idx], PatsFont.CA6B, 0, 1, 1);
                                else
                                    PrintRow(pdfEval2Tab, list2[idx], PatsFont.PatsSmall, 0, 1, 1);
                            }
                            pdfEval2Tab.TotalWidth = doc.PageSize.Width - 60;
                            pdfEval2Tab.WidthPercentage = 90;

                            float[] widths1 = {
                                (pdfEval2Tab.TotalWidth / 4) - 60,
                                (pdfEval2Tab.TotalWidth / 4) + 40,
                                (pdfEval2Tab.TotalWidth / 4) - 60,
                                (pdfEval2Tab.TotalWidth / 4) + 80 };
                            pdfEval2Tab.GetRow(0).SetWidths(widths1);
                            pdfEval2Tab.GetRow(1).SetWidths(widths1);
                            pdfEval2Tab.WriteSelectedRows(0, -1, 30, docY - 85, cb);
                            var currY = 120; //85 + 15 + 15 + 5 
                            PdfPTable pdfEval3Tab = new PdfPTable(2);
                            PrintRow(pdfEval3Tab, "EVALUATION AREA", PatsFont.Pats10HeadBold, 0, 2, 2);
                            PrintRow(pdfEval3Tab, "NARRATIVE", PatsFont.Pats10HeadBold, 0, 2, 0);

                            pdfEval3Tab.TotalWidth = doc.PageSize.Width;
                            pdfEval3Tab.WidthPercentage = 90;
                            float[] twidths = { (pdfEval3Tab.TotalWidth / 5) - 10,
                                    pdfEval3Tab.TotalWidth /5 * 3 + 69
                            };
                            pdfEval3Tab.GetRow(0).SetWidths(twidths);
                            pdfEval3Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                            currY += 20;
                            List<string> lineData = new List<string>();
                            for (int evl1 = 0; evl1 < 13; evl1++)
                            {
                                var evlTitle = "";
                                var evlTitle1 = "";
                                #region 1
                                switch (evl1)
                                {
                                    case 0:
                                        {
                                            evlTitle = "Identifying Information";
                                            evlTitle1 = "IdentifyingInformation";
                                            break;
                                        }
                                    case 1:
                                        {
                                            evlTitle = "Reason for Referral";
                                            evlTitle1 = "ReasonforReferral";
                                            break;
                                        }
                                    case 2:
                                        {
                                            evlTitle = "Commitment Offense And Criminal History";
                                            evlTitle1 = "CommitmentOffenseAndCriminalHistory";
                                            break;
                                        }
                                    case 3:
                                        {
                                            evlTitle = "Substance Abuse History And Treatment";
                                            evlTitle1 = "SubstanceAbuseHistoryAndTreatment";
                                            break;
                                        }
                                    case 4:
                                        {
                                            evlTitle = "Personal History";
                                            evlTitle1 = "PersonalHistory";
                                            break;
                                        }
                                    case 5:
                                        {
                                            evlTitle = "Educational History";
                                            evlTitle1 = "EducationalHistory";
                                            break;
                                        }
                                    case 6:
                                        {
                                            evlTitle = "Relationship History";
                                            evlTitle1 = "RelationshipHistory";
                                            break;
                                        }
                                    case 7:
                                        {
                                            evlTitle = "Employment History";
                                            evlTitle1 = "EmploymentHistory";
                                            break;
                                        }
                                    case 8:
                                        {
                                            evlTitle = "Psychiatric History";
                                            evlTitle1 = "PsychiatricHistory";
                                            break;
                                        }
                                    case 9:
                                        {
                                            evlTitle = "Medical History";
                                            evlTitle1 = "MedicalHistory";
                                            break;
                                        }
                                    case 10:
                                        {
                                            evlTitle = "Mental Status Examination";
                                            evlTitle1 = "MentalStatusExamination";
                                            break;
                                        }
                                    case 11:
                                        {
                                            evlTitle = "Diagnostic Impression";
                                            evlTitle1 = "DiagnosticImpression";
                                            break;
                                        }
                                    case 12:
                                        {
                                            evlTitle = "Treatment Plan";
                                            evlTitle1 = "TreatmentPlan";
                                            break;
                                        }
                                }
                                #endregion 1
                                PdfPTable pdfEval4Tab = new PdfPTable(2);
                                float[] twidths1 = null;
                                //start evaluation body
                                lineData = new List<string>();
                                var colHeight = GetLineData(EvaluationData[evlTitle1], 68, out lineData);
                                if (docY - (38 + currY + (colHeight * 15)) < 40)
                                {
                                    var lines = (int)(docY - (38 + currY)) / 15;
                                    var temp = "";
                                    var temp1 = "";
                                    if (lines >= colHeight)
                                    {
                                        for (int ln1 = 0; ln1 < colHeight; ln1++)
                                        {
                                            temp += lineData[ln1];
                                        }
                                    }
                                    else
                                    {
                                        for (int ln1 = 0; ln1 < lines; ln1++)
                                        {
                                            temp += lineData[ln1];
                                        }
                                        for (int ln2 = lines; ln2 < colHeight; ln2++)
                                        {
                                            temp1 += lineData[ln2];
                                        }
                                    }
                                    //available lines
                                    PrintRow(pdfEval4Tab, evlTitle, PatsFont.Pats10HeadBold, 0, (int)lines, 2);
                                    PrintRow(pdfEval4Tab, temp,
                                        PatsFont.Pats14Normal, 0, (int)lines, 1);

                                    pdfEval4Tab.TotalWidth = doc.PageSize.Width;
                                    pdfEval4Tab.WidthPercentage = 90;
                                    twidths1 = new float[] { (pdfEval4Tab.TotalWidth / 5) - 10,
                                    pdfEval4Tab.TotalWidth /5 * 3 + 69 };
                                    pdfEval4Tab.GetRow(0).SetWidths(twidths1);
                                    pdfEval4Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);

                                    //new page=================
                                    currY = CreateNewPage(cb, doc);

                                    if (temp1.Length > 0)
                                    {
                                        var lens = colHeight - lines;
                                        int linelen = lens;
                                        if (lens < 3) linelen = 3;
                                        else if (lens == 3) linelen = 4;
                                        pdfEval4Tab = new PdfPTable(2);
                                        //available lines
                                        PrintRow(pdfEval4Tab, "", PatsFont.Pats10HeadBold, 0, linelen, 2);
                                        PrintRow(pdfEval4Tab, temp1,
                                            PatsFont.Pats14Normal, 0, linelen, 1);

                                        pdfEval4Tab.TotalWidth = doc.PageSize.Width;
                                        pdfEval4Tab.WidthPercentage = 90;
                                        twidths1 = new float[] { (pdfEval4Tab.TotalWidth / 5) - 10, pdfEval4Tab.TotalWidth / 5 * 3 + 69 };
                                        pdfEval4Tab.GetRow(0).SetWidths(twidths1);
                                        pdfEval4Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                                        currY += (linelen * 15);
                                        if ((docY - currY) < 50)
                                        {
                                            currY = CreateNewPage(cb, doc);
                                            continue;
                                        }
                                    }
                                }
                                else
                                {
                                    int colheights = colHeight;
                                    if (colHeight < 3) colheights = 3;
                                    else if (colHeight == 3) colheights = 4;

                                    var data = EvaluationData[evlTitle1] == null ? "N/A" : EvaluationData[evlTitle1];
                                    PrintRow(pdfEval4Tab, evlTitle, PatsFont.Pats10HeadBold, 0, colheights, 2);
                                    PrintRow(pdfEval4Tab, data,
                                        PatsFont.Pats14Normal, 0, colheights, 1);

                                    pdfEval4Tab.TotalWidth = doc.PageSize.Width;
                                    pdfEval4Tab.WidthPercentage = 90;
                                    twidths1 = new float[] { (pdfEval4Tab.TotalWidth / 5) - 10,
                                    pdfEval4Tab.TotalWidth /5 * 3 + 69};
                                    pdfEval4Tab.GetRow(0).SetWidths(twidths1);
                                    pdfEval4Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                                    currY += (colheights * 15);
                                    if ((docY - currY) < 50)
                                    {
                                        currY = CreateNewPage(cb, doc);
                                    }
                                }
                            }
                        }
                        doc.Close();
                    }

                }
                bytes = ms.ToArray();
                ms.Close();
            }
            return bytes;
        }
        public Byte[] GenerateMMAStream(string LoginUser, MMA MMAInfo)
        {
            Byte[] bytes;
            using (var ms = new MemoryStream())
            {
                using (var doc = new Document(PageSize.A4, 30, 30, 30, 60))
                {
                    //Create a writer that's bound to our PDF abstraction and our stream
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {
                        writer.PageEvent = new HeaderFooter(LoginUser, MMAInfo, 10f, 100f, 100f);

                        //Open the document for writing
                        doc.Open();

                        PdfContentByte cb;
                        cb = writer.DirectContent;
                        var docY = doc.PageSize.Height;
                        int pagecount = 1;
                        doc.PageCount = pagecount;
                        //print profile info tale
                        PdfPTable pdfMMA1Tab = new PdfPTable(8);
                        string[] list = new string[8] {
                            "CDCR", MMAInfo.CDCR, "PAROLEE NAME", MMAInfo.PAROLEENAME,
                            "WEIGHT",MMAInfo.WEIGHT,
                            "DATE", MMAInfo.MMADATE.ToString("MM/dd/yyyy")};

                        for (int idx = 0; idx < list.Length; idx++)
                        {
                            var font = PatsFont.PatsSmall;
                            var talign = Element.ALIGN_LEFT;
                            if (idx % 2 == 0)
                            {
                                font = PatsFont.CA6B;
                                talign = Element.ALIGN_RIGHT;
                            }
                            PrintCell(pdfMMA1Tab, list[idx], font, 1, 1, 1, talign, 15);
                        }
                        string[] list1 = new string[8] {
                            "D.O.B.", MMAInfo.DOB,"PAROLE OFFICE", MMAInfo.PAROLEOFFICE,
                            "PSYCHIATRIST", MMAInfo.PSYCHIATRIST,"", ""};
                        for (int idx = 0; idx < list1.Length; idx++)
                        {
                            var font = PatsFont.PatsSmall;
                            var talign = Element.ALIGN_LEFT;
                            if (idx > 4)
                            {
                                PrintCell(pdfMMA1Tab, list1[idx], font, 3, 1, 1, talign, 15);
                                break;
                            }

                            if (idx % 2 == 0)
                            {
                                font = PatsFont.CA6B;
                                talign = Element.ALIGN_RIGHT;
                            }
                            PrintCell(pdfMMA1Tab, list1[idx], font, 1, 1, 1, talign, 15);
                        }
                        var tmma1Width = pdfMMA1Tab.TotalWidth = doc.PageSize.Width - 60;
                        pdfMMA1Tab.WidthPercentage = 90;
                        float[] widths = {(tmma1Width / 8) - 40,(tmma1Width / 8) - 20,
                                        (tmma1Width / 8) + 10,(tmma1Width / 8) + 120,
                                        (tmma1Width / 8),(tmma1Width / 8) -30,
                                        (tmma1Width / 8) -40,(tmma1Width / 8)};
                        pdfMMA1Tab.GetRow(0).SetWidths(widths);
                        pdfMMA1Tab.GetRow(1).SetWidths(widths);
                        pdfMMA1Tab.WriteSelectedRows(0, -1, 30, docY - 70, cb);

                        //start do data
                        var currY = 105;
                        currY = PintTextRow(cb, doc, MMAInfo.DIAGNOSIS, "DIAGNOSIS", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.CHIEFCOMPLAINT, "CHIEF COMPLAINT", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.CURRENTMEDICATIONS, "CURRENT MEDICATIONS", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.DISCONTINUEDMEDICATIONS, "DISCONTINUED MEDICATIONS", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.MEDICATIONCHANGES, "MEDICATION CHANGES", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.MEDICATIONSIDEEFFECTS, "MEDICATION SIDE EFFECTS", docY, doc.PageSize.Width, currY);

                        currY = PrintSubTitle(cb, doc, "PSYCHIATRIC HISTORY", currY, docY);

                        PdfPTable pdfMMA2Tab = new PdfPTable(6);
                        string[] list2 = new string[6] {
                            "PREVS PSYCHIATRIC ADMISSIONS", MMAInfo.PREVPSYCHIATRICADMISSIONS,
                            "PREVS SUICIDE ATTEMPTS", MMAInfo.PREVSUICIDEATTEMPTS,
                            "YEARS OF OUTPATIENT PSYCHIATRIC CARE", MMAInfo.OUTPATIENTPSYCHIATRICCAREYEARS};

                        for (int idx = 0; idx < list2.Length; idx++)
                        {
                            var font = PatsFont.PatsSmall;
                            var talign = Element.ALIGN_LEFT;
                            if (idx % 2 == 0)
                            {
                                font = PatsFont.CA8B;
                                talign = Element.ALIGN_RIGHT;
                            }
                            PrintCell(pdfMMA2Tab, list2[idx], font, 1, 1, 1, talign, 20);
                        }
                        var tmma2Width = pdfMMA2Tab.TotalWidth = doc.PageSize.Width - 59;
                        pdfMMA2Tab.WidthPercentage = 90;
                        float[] mma2widths = {(tmma2Width / 6) + 40,(tmma2Width / 6) - 40,
                                          (tmma2Width / 6) + 40,(tmma2Width / 6) - 40,
                                          (tmma2Width / 6) + 40,(tmma2Width / 6) - 40};
                        pdfMMA2Tab.GetRow(0).SetWidths(mma2widths);
                        pdfMMA2Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                        currY += 20;
                        if ((docY - currY) < 60)
                        {
                            currY = 70;
                            doc.NewPage();
                        }
                        currY = PintTextRow(cb, doc, MMAInfo.PREVIOUSDIAGNOSIS, "PREVIOUS DIAGNOSIS", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.PREVIOUSPSYCHIATRICMEDICATIONS, "PREVIOUS PSYCHIATRIC MEDICATIONS", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.PREVDRUGDEPENDENCE, "PREVIOUS DRUG DEPENDENCE", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.CURRENTDRUGDEPENDENCE, "CURRENT DRUG DEPENDENCE", docY, doc.PageSize.Width, currY);

                        PdfPTable pdfMMA3Tab = new PdfPTable(4);
                        string[] list3 = new string[4] {
                            "DATE OF LAST DRUG USE", MMAInfo.DATEOFLASTDRUGUSE.HasValue ? MMAInfo.DATEOFLASTDRUGUSE.Value.ToString("MM/dd/yyyy") : "",
                            "YEARS OF DRUG USE", MMAInfo.YEARSOFDRUGUSE};

                        for (int idx = 0; idx < list3.Length; idx++)
                        {
                            var font = PatsFont.PatsSmall;
                            var talign = Element.ALIGN_LEFT;
                            if (idx % 2 == 0)
                            {
                                font = PatsFont.CA8B;
                                talign = Element.ALIGN_RIGHT;
                            }
                            PrintCell(pdfMMA3Tab, list3[idx], font, 1, 1, 1, talign, 20);
                        }
                        var tmma3Width = pdfMMA3Tab.TotalWidth = doc.PageSize.Width - 59;
                        pdfMMA3Tab.WidthPercentage = 90;
                        float[] mma3widths = {(tmma3Width / 4) + 40,(tmma3Width / 4) - 40,
                                              (tmma3Width / 4) + 40,(tmma3Width / 4) - 40};
                        pdfMMA3Tab.GetRow(0).SetWidths(mma3widths);
                        pdfMMA3Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                        currY += 20;
                        if ((docY - currY) < 60)
                        {
                            currY = 70;
                            doc.NewPage();
                        }
                        currY = PrintSubTitle(cb, doc, "MEDICAL HISTORY", currY, (int)docY);

                        currY = PintTextRow(cb, doc, MMAInfo.MEDICATIONALLERGIES, "MEDICATION ALLERGIES", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.HOSPITALIZATIONS, "HOSPITALIZATIONS", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.SURGERIES, "SURGERIES", docY, doc.PageSize.Width, currY);

                        var checkVal = GetCheckedValue(MMAInfo.HISTORYHEADTRAUMAYES, MMAInfo.HISTORYHEADTRAUMADENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HISTORY OF HEAD TRAUMA",
                            MMAInfo.HISTORYHEADTRAUMANOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HISTORYSTROKEYES, MMAInfo.HISTORYSTROKEDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HISTORY OF STROKE",
                            MMAInfo.HISTORYSTROKENOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HISTORYLOSSCONSCIOUSNESSYES, MMAInfo.HISTORYLOSSCONSCIOUSNESSDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HISTORY OF LOSS OF CONSCIOUSNESS", MMAInfo.HISTORYLOSSCONSCIOUSNESSNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.SPINALCORDINJURIESYES, MMAInfo.SPINALCORDINJURIESDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "SPINAL CORD INJURIES", MMAInfo.SPINALCORDINJURIESNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.SKELETALFRACTURESBRAKESYES, MMAInfo.SKELETALFRACTURESBRAKESDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "SKELETAL FRACTURES/BRAKES", MMAInfo.SKELETALFRACTURESBRAKESNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.MVAYES, MMAInfo.MVADENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "MVA", MMAInfo.MVANOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.GUNSHOTWOUNDSYES, MMAInfo.GUNSHOTWOUNDSDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "GUNSHOT WOUNDS", MMAInfo.GUNSHOTWOUNDSNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HISTORYOFSEIZURESYES, MMAInfo.HISTORYOFSEIZURESDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HISTORY OF SEIZURES", MMAInfo.HISTORYOFSEIZURESNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HISTORYMIGRAINEHAYES, MMAInfo.HISTORYMIGRAINEHADENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HISTORY OF MIGRAINE HA", MMAInfo.HISTORYMIGRAINEHANOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HEARTDISEASEYES, MMAInfo.HEARTDISEASEDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HEART DISEASE", MMAInfo.HEARTDISEASENOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.ASTHMAYES, MMAInfo.ASTHMADENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "ASTHMA", MMAInfo.ASTHMANOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.COPDYES, MMAInfo.COPDDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "COPD", MMAInfo.COPDNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.DIABETESYES, MMAInfo.DIABETESDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "DIABETES", MMAInfo.DIABETESNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HYPERLIPIDEMIAYES, MMAInfo.HYPERLIPIDEMIADENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HYPERLIPIDEMIA", MMAInfo.HYPERLIPIDEMIANOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HYPERTENSIONYES, MMAInfo.HYPERTENSIONDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HYPERTENSION", MMAInfo.HYPERTENSIONNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HEPATITISYES, MMAInfo.HEPATITISDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HEPATITIS", MMAInfo.HEPATITISNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.VDHIVYES, MMAInfo.VDHIVDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "VD/HIV", MMAInfo.VDHIVNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.ANEMIAYES, MMAInfo.ANEMIADENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "ANEMIA", MMAInfo.ANEMIANOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.THYROIDABNORMALITIESYES, MMAInfo.THYROIDABNORMALITIESDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "THYROID ABNORMALITIES", MMAInfo.THYROIDABNORMALITIESNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.GLAUCOMAYES, MMAInfo.GLAUCOMADENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "GLAUCOMA", MMAInfo.GLAUCOMANOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.ABNORMALLABRESULTSYES, MMAInfo.ABNORMALLABRESULTSDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "ABNORMAL LAB RESULTS", MMAInfo.ABNORMALLABRESULTSNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.ABNORMALEKGYES, MMAInfo.ABNORMALEKGDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "ABNORMAL EKG", MMAInfo.ABNORMALEKGNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.CURRENTPREGNANCYYES, MMAInfo.CURRENTPREGNANCYDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "CURRENT PREGNANCY", MMAInfo.CURRENTPREGNANCYNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.HISTORYPRIAPISMYES, MMAInfo.HISTORYPRIAPISMDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "HISTORY OF PRIAPISM", MMAInfo.HISTORYPRIAPISMNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        checkVal = GetCheckedValue(MMAInfo.OTHERCHRONICMEDICALILLNESSYES, MMAInfo.OTHERCHRONICMEDICALILLNESSDENIED);
                        currY = PrintRowWithCheckBox(cb, doc, "OTHER CHRONIC MEDICAL ILLNESS", MMAInfo.OTHERCHRONICMEDICALILLNESSNOTE, checkVal, currY, (int)docY, (int)doc.PageSize.Width);

                        PdfPTable pdfMMA4Tab = new PdfPTable(4);
                        string[] list4 = new string[4] {
                            "NUMBER OF PREGNANCIES", MMAInfo.NUMBERPREGNANCIES.ToString(),
                            "NUMBER OF DELIVERIES", MMAInfo.NUMBERDELIVERIES.ToString()};

                        for (int idx = 0; idx < list4.Length; idx++)
                        {
                            var font = PatsFont.PatsSmall;
                            var talign = Element.ALIGN_LEFT;
                            if (idx % 2 == 0)
                            {
                                font = PatsFont.CA8B;
                                talign = Element.ALIGN_RIGHT;
                            }
                            PrintCell(pdfMMA4Tab, list4[idx], font, 1, 1, 1, talign, 20);
                        }
                        var tmma4Width = pdfMMA4Tab.TotalWidth = doc.PageSize.Width - 59;
                        pdfMMA4Tab.WidthPercentage = 90;
                        float[] mma4widths = {(tmma4Width / 4) + 40,(tmma4Width / 4) - 40,
                                              (tmma4Width / 4) + 40,(tmma4Width / 4) - 40};
                        pdfMMA4Tab.GetRow(0).SetWidths(mma4widths);
                        pdfMMA4Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                        currY += 20;
                        if ((docY - currY) < 60)
                        {
                            currY = 70;
                            doc.NewPage();
                        }

                        currY = PrintSubTitle(cb, doc, "SOCIAL HISTORY", currY, (int)docY);

                        currY = PintTextRow(cb, doc, MMAInfo.CURRENTHOUSING, "CURRENT HOUSING", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.SUPPORTIVERELATIONSHIPS, "SUPPORTIVE RELATIONSHIPS", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.CURRENTEMPLOYMENT, "CURRENT EMPLOYMENT", docY, doc.PageSize.Width, currY);
                        currY = PintTextRow(cb, doc, MMAInfo.LASTEMPLOYED, "LAST EMPLOYED", docY, doc.PageSize.Width, currY);

                        currY = PrintSubTitle(cb, doc, "SCHOOL HISTORY", currY, docY);

                        currY = PintTextRow(cb, doc, MMAInfo.HIGHESTGRADECOMPLETED, "HIGHEST GRADE COMPLETED", docY, doc.PageSize.Width, currY);

                        PdfPTable pdfMMA5Tab = new PdfPTable(3);
                        //available lines
                        var identify = (MMAInfo.IDENTIFIEDLEARNINGDISABILITY ? "[ " + string.Empty.PadLeft(1) + " ]" : "[X]") + " None Identified";
                        PrintCell(pdfMMA5Tab, "IDENTIFIED LEARNING DISABILITY", PatsFont.CA8B, 1, 1, 1, Element.ALIGN_TOP, 30);
                        PrintCell(pdfMMA5Tab, identify, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_LEFT, 30);
                        PrintCell(pdfMMA5Tab, MMAInfo.IDENTIFIEDLEARNINGDISABILITYNOTE, PatsFont.Pats12Normal, 1, 1, 1, Element.ALIGN_LEFT, 30);

                        pdfMMA5Tab.TotalWidth = doc.PageSize.Width;
                        pdfMMA5Tab.WidthPercentage = 90;
                        float[] twidths5 = new float[] { (pdfMMA5Tab.TotalWidth / 4) - 50,(pdfMMA5Tab.TotalWidth /4)-60,
                                (pdfMMA5Tab.TotalWidth /4) + 200 };
                        pdfMMA5Tab.GetRow(0).SetWidths(twidths5);
                        pdfMMA5Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                        currY += 30;
                        if ((docY - currY) < 60)
                        {
                            currY = 70;
                            doc.NewPage();
                        }

                        PdfPTable pdfMMA6Tab = new PdfPTable(3);
                        var itellectual = (MMAInfo.INTELLECTUALIMPAIRMENTDENIED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Denied";
                        PrintCell(pdfMMA6Tab, "INTELLECTUAL IMPAIRMENT", PatsFont.CA8B, 1, 1, 1, Element.ALIGN_TOP, 30);
                        PrintCell(pdfMMA6Tab, itellectual, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_LEFT, 30);
                        PrintCell(pdfMMA6Tab, MMAInfo.INTELLECTUALIMPAIRMENT, PatsFont.Pats12Normal, 1, 1, 1, Element.ALIGN_LEFT, 30);

                        pdfMMA6Tab.TotalWidth = doc.PageSize.Width;
                        pdfMMA6Tab.WidthPercentage = 90;
                        float[] twidths6 = new float[] { (pdfMMA6Tab.TotalWidth / 4) - 50,(pdfMMA6Tab.TotalWidth /4)-60,
                                (pdfMMA6Tab.TotalWidth /4) + 200 };
                        pdfMMA6Tab.GetRow(0).SetWidths(twidths6);
                        pdfMMA6Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                        currY += 30;
                        if ((docY - currY) < 60)
                        {
                            currY = 70;
                            doc.NewPage();
                        }

                        currY = PrintSubTitle(cb, doc, "ARREST HISTORY", currY, (int)docY);

                        currY = PintTextRow(cb, doc, MMAInfo.HISOTRYINCARCERATION, "HISTORY OF INCARCERATION", docY, doc.PageSize.Width, currY);

                        PdfPTable pdfMMA7Tab = new PdfPTable(3);
                        var male = MMAInfo.SEXPREFERENCEMALE ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]";
                        var female = MMAInfo.SEXPREFERENCEFEMALE ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]";
                        var str = male + " Male  " + female + " Female";
                        PrintCell(pdfMMA7Tab, "SEXUAL PREFERENCE:", PatsFont.CA8B, 1, 1, 1, Element.ALIGN_TOP, 30);
                        PrintCell(pdfMMA7Tab, str, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_LEFT, 30);
                        PrintCell(pdfMMA7Tab, MMAInfo.SEXPREFERENCENOTE, PatsFont.Pats12Normal, 1, 1, 1, Element.ALIGN_LEFT, 30);

                        pdfMMA7Tab.TotalWidth = doc.PageSize.Width;
                        pdfMMA7Tab.WidthPercentage = 90;
                        float[] twidths7 = new float[] { (pdfMMA7Tab.TotalWidth / 4) - 50,(pdfMMA7Tab.TotalWidth /4)-60,
                                (pdfMMA7Tab.TotalWidth /4) + 200 };
                        pdfMMA7Tab.GetRow(0).SetWidths(twidths7);
                        pdfMMA7Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);
                        currY += 30;
                        if ((docY - currY) < 60)
                        {
                            currY = 70;
                            doc.NewPage();
                        }

                        currY = PrintSubTitle(cb, doc, "MENTAL STATUS EXAMINATION", currY, docY);

                        var appearance = (MMAInfo.APPEARANCEDISHEVELED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Disheveled  " + string.Empty.PadLeft(1) +
                            (MMAInfo.APPEARANCEGROOMED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Well Groomed  " + string.Empty.PadLeft(1) +
                            (MMAInfo.APPEARANCENOURISHED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Well-Nourished  " + string.Empty.PadLeft(1) +
                            (MMAInfo.APPEARANCEOBESE ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Obese  ";
                        currY = PrintNoBorderRow(cb, doc, "APPEARANCE:", appearance, currY, docY);

                        var activity = (MMAInfo.PSYCHOMOTORACTIVITYWNL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " WNL " + string.Empty.PadLeft(1) +
                           (MMAInfo.PSYCHOMOTORACTIVITYABNORMAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Abnormal  ";
                        currY = PrintNoBorderRow(cb, doc, "PSYCHOMOTOR ACTIVITY:", activity, currY, docY);

                        var abnormal = (MMAInfo.ABNORMALINVOLUNTARYMOVEMENTPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) +
                            (MMAInfo.ABNORMALINVOLUNTARYMOVEMENTABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "ABNORMAL INVOLUNTARY MOVEMENT:", abnormal, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "DISTRACTIBILITY:", MMAInfo.DISTRACTIBILITY, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "IMPULSIVITY:", MMAInfo.IMPULSIVITY, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "CONCENTRATION:", MMAInfo.CONCENTRATION, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "MEMORY REGISTRATION:", MMAInfo.MEMORYREGISTRATION, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "ANXIETY LEVEL:", MMAInfo.ANXIETYLEVEL, currY, docY);

                        var childrenhood = (MMAInfo.CHILDHOODMEMORIESPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.CHILDHOODMEMORIESABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "CHILDHOOD MEMORIES OF PHYSICAL, SEXUAL, OR EMOTIONAL ABUSE:", childrenhood, currY, docY);

                        var adult = (MMAInfo.AUDITORYHALLUCINATIONSPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.AUDITORYHALLUCINATIONSABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "ADULT MEMORIES OF PREVIOUS TRAUMATIC EVENT:", adult, currY, docY);

                        var intense = (MMAInfo.RPTINTENSEPSYREACTTRAUMEMOPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.RPTINTENSEPSYREACTTRAUMEMOABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "REPORTS INTENSE PSYCHOLOGICAL REACTION TO TRAUMATIC MEMORIES:", intense, currY, docY);

                        var avoidance = (MMAInfo.RPTAVOIDSTIMULIPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.RPTAVOIDSTIMULIABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "REPORTS AVOIDANCE OF STIMULI ASSOCIATED WITH TRAUMATIC MEMORIES:", avoidance, currY, docY);

                        var flashbacks = (MMAInfo.RPTFLASHBACKSTRAUMATICMEMPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.RPTFLASHBACKSTRAUMATICMEMABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "REPORTS FLASHBACKS OF TRAUMATIC MEMORIES:", flashbacks, currY, docY);

                        var distress = (MMAInfo.RPTRECURRDISTRESSNMTRAUPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.RPTRECURRDISTRESSNMTRAUABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "REPORTS RECURRENT DISTRESSING NIGHTMARES OF THE TRAUMATIC EVENTS:", distress, currY, docY);

                        var obsess = (MMAInfo.OBSESSIONSCOMPULSIONSYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes  " + string.Empty.PadLeft(1) + (MMAInfo.OBSESSIONSCOMPULSIONSDENIED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Denied    ";
                        currY = PrintNoBorderRow(cb, doc, "OBSESSIONS & COMPULSIONS:", obsess, currY, docY);

                        var anhedonia = (MMAInfo.ANHEDONIAPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Present  " + string.Empty.PadLeft(1) + (MMAInfo.ANHEDONIAABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Absent     ";
                        currY = PrintNoBorderRow(cb, doc, "ANHEDONIA:", anhedonia, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "MOOD:", MMAInfo.MOOD, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "EUPHORIA:", MMAInfo.EUPHORIA, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "DEMEANOR:", MMAInfo.DEMEANOR, currY, docY);

                        var sleep = (MMAInfo.SLEEPINSOMINA ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Initial Insomnia   " + string.Empty.PadLeft(1) + (MMAInfo.SLEEPINTERRUPED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Interrupted      " + string.Empty.PadLeft(1) + (MMAInfo.SLEEPNORMAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Normal      ";
                        currY = PrintNoBorderRow(cb, doc, "SLEEP:", sleep, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "PERIODS OF TIME TOO ENERGIZED TO SLEEP:", MMAInfo.PERIODSTIMETOOENERGIZEDTOSLEEP, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "APPETITE:", MMAInfo.APPETITE, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "ENERGY LEVEL:", MMAInfo.ENERGYLEVEL, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "LIBIDO:", MMAInfo.LIBIDO, currY, docY);

                        var irritable = (MMAInfo.IRRITABILITYPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Present   " + string.Empty.PadLeft(1) + (MMAInfo.IRRITABILITYABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent  ";
                        currY = PrintNoBorderRow(cb, doc, "IRRITABILITY:", irritable, currY, docY);

                        var rangaffect = (MMAInfo.RANGEAFFECTFULL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Full  " + string.Empty.PadLeft(1) + (MMAInfo.RANGEAFFECTCONSTRICTED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Constricted   " + (MMAInfo.RANGEAFFECTFLAT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Flat   ";
                        currY = PrintNoBorderRow(cb, doc, "RANGE OF AFFECT:", rangaffect, currY, docY);

                        var speech = (MMAInfo.APPROPRIATECONTENTSPEECHYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes  " + string.Empty.PadLeft(1) + (MMAInfo.APPROPRIATECONTENTSPEECHNO ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " No  ";
                        currY = PrintNoBorderRow(cb, doc, string.Empty.PadRight(10) + "APPROPRIATE TO CONTENT OF SPEECH:", speech, currY, docY);

                        var mood = (MMAInfo.MOODCONGRUENTYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes  " + string.Empty.PadLeft(1) + (MMAInfo.MOODCONGRUENTNO ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " No  ";
                        currY = PrintNoBorderRow(cb, doc, string.Empty.PadRight(10) + "MOOD CONGRUENT:" + string.Empty.PadLeft(18), speech, currY, docY);

                        var homicidal = (MMAInfo.HOMICIDALIDEATIONPLANUNTENTPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) +
                            (MMAInfo.HOMICIDALIDEATIONPLANUNTENTABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "HOMICIDAL IDEATION PLAN OR UNTENT:", homicidal, currY, docY);

                        var suicidal = (MMAInfo.SUICIDALIDEATIONPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) +
                            (MMAInfo.SUICIDALIDEATIONABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "SUICIDAL IDEATION:", suicidal, currY, docY);

                        var suicidalp = (MMAInfo.SUICIDALPLANPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.SUICIDALPLANABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "SUICIDAL PLAN:", suicidalp, currY, docY);

                        var suicidali = (MMAInfo.SUICIDALINTENTPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Present  " + string.Empty.PadLeft(1) + (MMAInfo.SUICIDALINTENTABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent   ";
                        currY = PrintNoBorderRow(cb, doc, "SUICIDAL INTENT:", suicidali, currY, docY);

                        currY = PrintNoBorderRow(cb, doc, "SPEECH AND LANGUAGE:", string.Empty, currY, docY);

                        var articulation = (MMAInfo.ARTICULATIONNORMAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Normal  " + string.Empty.PadLeft(1) + (MMAInfo.ARTICULATIONABNORMAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Abnormal  ";
                        currY = PrintNoBorderRow(cb, doc, string.Empty.PadRight(10) + "ARTICULATION:", articulation, currY, docY);

                        var rate = (MMAInfo.ARTICULATIONNORMAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Normal  " + string.Empty.PadLeft(1) + (MMAInfo.ARTICULATIONABNORMAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Pressured ";
                        currY = PrintNoBorderRow(cb, doc, string.Empty.PadRight(10) + "RATE:" + string.Empty.PadLeft(8), rate, currY, docY);

                        var visual1 = (MMAInfo.VISUALHALLUCINATIONSPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Present " + string.Empty.PadLeft(1) + (MMAInfo.VISUALHALLUCINATIONSABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent ";
                        currY = PrintNoBorderRow(cb, doc, "VISUAL HALLUCINATIONS:", rate, currY, docY);

                        var auditory = (MMAInfo.AUDITORYHALLUCINATIONSPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Present " + string.Empty.PadLeft(1) + (MMAInfo.AUDITORYHALLUCINATIONSABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent ";
                        currY = PrintNoBorderRow(cb, doc, "AUDITORY HALLUCINATIONS:", auditory, currY, docY);

                        var appears = (MMAInfo.APPEARSRESPONDINTERNALSTIMULUSYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes " + string.Empty.PadLeft(1) + (MMAInfo.APPEARSRESPONDINTERNALSTIMULUSNO ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " No ";
                        currY = PrintNoBorderRow(cb, doc, "APPEARS TO BE RESPONDING TO AN INTERNAL STIMULUS:", appears, currY, docY);

                        var thought1 = (MMAInfo.THOUGHTPROCESSESLAGD ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Linear and Goal Directed  " + string.Empty.PadLeft(1) + (MMAInfo.THOUGHTPROCESSESDISORGANIZED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Disorganized  " +
                        string.Empty.PadLeft(1) + (MMAInfo.THOUGHTPROCESSESCIRCUMSTANTIAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Circumstantial " +
                        string.Empty.PadLeft(1) + (MMAInfo.THOUGHTPROCESSESTANGENTIAL ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Tangential ";
                        currY = PrintNoBorderRow(cb, doc, "THOUGHT PROCESSES:", thought1, currY, docY);

                        var racing = (MMAInfo.RACINGTHOUGHTSPRESENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Present " + string.Empty.PadLeft(1) + (MMAInfo.RACINGTHOUGHTSABSENT ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Absent ";
                        currY = PrintNoBorderRow(cb, doc, "RACING THOUGHTS:", racing, currY, docY);

                        currY = PintTextRow(cb, doc, MMAInfo.DELUSIONS, "DELUSIONS", docY, doc.PageSize.Width, currY);

                        var guarded = (MMAInfo.GUARDEDSUSPICIOUSYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes " + string.Empty.PadLeft(1) + (MMAInfo.GUARDEDSUSPICIOUSNO ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " No ";
                        currY = PrintNoBorderRow(cb, doc, "GUARDED AND SUSPICIOUS:", guarded, currY, docY);

                        var vigilant = (MMAInfo.HYPERVIGILANTYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes " + string.Empty.PadLeft(1) + (MMAInfo.HYPERVIGILANTNO ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " No ";
                        currY = PrintNoBorderRow(cb, doc, "HYPER-VIGILANT:", vigilant, currY, docY);

                        var preoccupy = (MMAInfo.PREOCCUPATIONSYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes " + string.Empty.PadLeft(1) + (MMAInfo.PREOCCUPATIONSDENIED ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Denied ";
                        currY = PrintNoBorderRow(cb, doc, "PREOCCUPATIONS:", preoccupy, currY, docY);

                        var insight = (MMAInfo.INSIGHTGOOD ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Good " + string.Empty.PadLeft(1) + (MMAInfo.INSIGHTPOOR ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + "  Poor ";
                        currY = PrintNoBorderRow(cb, doc, "INSIGHT:", insight, currY, docY);

                        currY = PintTextRow(cb, doc, MMAInfo.JUDGEMENT, "JUDGEMENT", docY, doc.PageSize.Width, currY);

                        var exagg = (MMAInfo.APPEARSEXAGGERATEPSYSYMPTOMSYES ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " Yes " + string.Empty.PadLeft(1) + (MMAInfo.APPEARSEXAGGERATEPSYSYMPTOMSNO ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + " No ";
                        currY = PrintNoBorderRow(cb, doc, "APPEARS TO BE EXAGGERATING PSYCHIATRIC SYMPTOMS:", exagg, currY, docY);

                        currY = PrintSubTitle(cb, doc, "MEDICATION TARGET SYMPTOMS", currY, docY);

                        var caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS1 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Auditory hallucinations";
                        var caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS12 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + " Impulsivity";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS2 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Visual hallucinations";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS13 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Depressed mood";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS3 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Delusional thinking";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS14 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Suicidal thoughts";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS4 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + " Tangential thought process";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS15 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Low energy";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS5 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Circumstantial thought process";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS16 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Insomnia ";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS6 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Flat affect";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS17 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Tearfulness";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS7 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Disruptive behavior";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS18 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Mood Lability";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS8 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Assaultive behavior";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS19 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Irritability";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS9 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Angry outburst";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS20 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Flashbacks";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS10 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Pressured speech";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS21 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "High anxiety";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        caption1 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS11 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Racing thoughts";
                        caption2 = string.Empty.PadLeft(10) + (MMAInfo.MEDICATIONTARGETSYMPTOMS22 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Other";
                        currY = PrintMedTargetRow(cb, doc, caption1, caption2, currY, docY);

                        currY = PrintSubTitle(cb, doc, "FUNCATIONAL IMPAIRMENT", currY, (int)docY);

                        var caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT1 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Patient requires a significant degree of assistance and direction to perform activities of task.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT2 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Depression impairs concentration which is needed to complete tasks in a reasonable amount of time.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT3 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Suicidal ideation causes emotional dysregulation.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT4 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Hallucinations and delusions are indistinguishable from reality at times and they disrupt emotional stability.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT5 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "The level of paranoia and anxiety is such that the client cannot tolerate being around people due to the fear of being attacked or followed.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT6 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Flashbacks disrupt concentration and leave the client emotionally unstable.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT7 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Recurrent nightmares interfere with sleep.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT8 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Anxiety level is such that task completion is impaired.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT9 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) +
                            "Impulsivity is such that the client does not process risks and benefits of the behaviors prior to engaging in them and can lead to impaired focus, decision making and task completion.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT10 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + " Supervision of the clients work could lead to emotional decompensation.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT11 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Capacity to interact appropriately with others, communicate effectively, concentrate, complete tasks, and adapt to stressors common to the work environment (including the pressures of time, supervision, and decision making), are significantly impaired.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.FUNCIMPAIRMENT12 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Functional capacity: The ability to engage in productive work for a significant period of time fluctuates due to the mental state and functional impairments as noted.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        currY = PrintSubTitle(cb, doc, "RECOMMENDATIONS", currY, (int)docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.RECOMMENDATIONS1 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "The client is able to work.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.RECOMMENDATIONS2 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "The client is not able to work.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.RECOMMENDATIONS3 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "The client has a permanent mental health illness which interferes with the ability to work. I expect this illness to be impairing form today’s date until one year from today and beyond. Please help this very impaired client secure the assistance that is needed for emergency support and SSI.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.RECOMMENDATIONS4 ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "No recommendations at this time.";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        currY = PrintSubTitle(cb, doc, "LABS REQUESTED", currY, (int)docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.LABSREQUESTEDCBC ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "CBC";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.LABSREQUESTEDCHEM ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "CHEM";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.LABSREQUESTEDA1C ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "A1C";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.LABSREQUESTEDSTUDY ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Thyroid Studies";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.LABSREQUESTEDOTHER ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Other";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        currY = PrintSubTitle(cb, doc, "DISCUSSED", currY, (int)docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.DISCUSSEDPLAN ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Treatment Plan";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.DISCUSSEDSIDE ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Side Effects";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.DISCUSSEDFOLLOW ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Follow Up Plan";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + (MMAInfo.DISCUSSEDDIET ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "Diet and Healthy Weight";
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        caption = string.Empty.PadLeft(10) + "RTC=" +
                        (MMAInfo.RTC1MONTH ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "1-Month" + string.Empty.PadRight(2) +
                        (MMAInfo.RTC2MONTH ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "2-Months" + string.Empty.PadRight(2) + (MMAInfo.RTC3MONTH ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + "3-Month" + string.Empty.PadRight(2) +
                        (MMAInfo.RTCWEEKS ? "[X]" : "[ " + string.Empty.PadLeft(1) + " ]") + string.Empty.PadRight(2) + MMAInfo.RTCAMOUNTWEEKS.ToString() + "  Weeks" + string.Empty.PadRight(2);
                        currY = PrintIMPAIRMENTRow(cb, doc, caption, currY, docY);

                        //Rectangle _rect;
                        //PdfFormField _Field1;

                        //PdfAppearance[] onOff = new PdfAppearance[2];
                        //onOff[0] = cb.CreateAppearance(12, 12);
                        //onOff[0].Rectangle(1, 1, 12, 12);
                        //onOff[0].Stroke();

                        //onOff[1] = cb.CreateAppearance(12, 12);
                        //onOff[1].SetRGBColorFill(255, 128, 128);
                        //onOff[1].Rectangle(1, 1, 11, 11);
                        //onOff[1].FillStroke();
                        //onOff[1].MoveTo(1, 1);
                        //onOff[1].LineTo(12, 12);
                        //onOff[1].MoveTo(1, 12);
                        //onOff[1].LineTo(12, 1);
                        //onOff[1].Stroke();

                        //pdfMMA6Tab.AddCell(pdfMMA6TabCell1);
                        //pdfMMA6Tab.TotalWidth = doc.PageSize.Width;
                        //pdfMMA6Tab.WidthPercentage = 90;
                        //pdfMMA6Tab.WriteSelectedRows(0, -1, 30, docY - currY, cb);

                        //RadioCheckField _checkbox1;
                        //string[] captions = new string[3]
                        //{
                        //    "test1", "test2", "test3"
                        //};
                        //for (int i = 0; i < 3; i++)
                        //{
                        //    _rect = new Rectangle(30, 80 - i * 12, 42, 92 - i * 12);
                        //    _checkbox1 = new RadioCheckField(writer, _rect, captions[i], "on");
                        //    _Field1 = _checkbox1.CheckField;
                        //    _Field1.SetAppearance(PdfAnnotation.APPEARANCE_NORMAL, "Off", onOff[0]);
                        //    _Field1.SetAppearance(PdfAnnotation.APPEARANCE_NORMAL, "On", onOff[1]);
                        //    writer.AddAnnotation(_Field1);

                        //    ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, new Phrase(captions[i], new Font(Font.FontFamily.HELVETICA, 12)), 44, 82 - i * 12, 0);
                        //}

                        //WriteCheckbox(ref cb, 30, 102, "My Test", true );

                        doc.Close();
                    }
                }
                bytes = ms.ToArray();
                ms.Close();
            }
            return bytes;
        }
        private int PrintIMPAIRMENTRow(PdfContentByte cb, Document doc, string caption, int CurrentY, float DocY)
        {
            int currY = CurrentY;
            PdfPTable pdfMMATab = new PdfPTable(1);
            PrintCell(pdfMMATab, caption, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_LEFT, 12);
            pdfMMATab.TotalWidth = doc.PageSize.Width - 60;
            pdfMMATab.WidthPercentage = 90;
            float[] twidths = new float[] { pdfMMATab.TotalWidth };
            pdfMMATab.GetRow(0).SetWidths(twidths);
            pdfMMATab.WriteSelectedRows(0, -1, 30, DocY - currY, cb);
            currY += 12;
            if ((DocY - currY) < 60)
            {
                currY = 70;
                doc.NewPage();
            }
            return currY;
        }
        private int PrintMedTargetRow(PdfContentByte cb, Document doc, string caption, string caption1, int CurrentY, float DocY)
        {
            int currY = CurrentY;
            PdfPTable pdfMMATab = new PdfPTable(2);
            PrintCell(pdfMMATab, caption, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_LEFT, 12);
            PrintCell(pdfMMATab, caption1, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_LEFT, 12);
            pdfMMATab.TotalWidth = doc.PageSize.Width - 60;
            pdfMMATab.WidthPercentage = 90;
            float[] twidths = new float[] { pdfMMATab.TotalWidth / 2, pdfMMATab.TotalWidth / 2 };
            pdfMMATab.GetRow(0).SetWidths(twidths);
            pdfMMATab.WriteSelectedRows(0, -1, 30, DocY - currY, cb);
            currY += 12;
            if ((DocY - currY) < 60)
            {
                currY = 70;
                doc.NewPage();
            }
            return currY;
        }
        private int PrintNoBorderRow(PdfContentByte cb, Document doc, string caption, string text, int CurrentY, float DocY)
        {
            int currY = CurrentY;
            Font ft = PatsFont.Pats10Normal;
            int lineH = 20;
            int col1len = caption.Length;
            if (col1len < 11) col1len = 11;
            else if (col1len >= 11 && col1len < 35) col1len = caption.Length;
            else if (col1len >= 35 && col1len < 44) col1len = caption.Length - 10;
            else col1len = caption.Length - 15;

            int firstlen = col1len * 8;
            if (!string.IsNullOrEmpty(text) && text.IndexOf("]") > 0)
            {
                ft = PatsFont.CA8B;
                lineH = 12;
            }

            int boaderR = PdfPCell.RIGHT_BORDER;
            int borderL = PdfPCell.LEFT_BORDER;
            if (caption == "RANGE OF AFFECT:" ||
                caption == "SPEECH AND LANGUAGE:")
            {
                boaderR = 10;
                borderL = 6;
                lineH = 12;
            }
            else if (caption.IndexOf("APPROPRIATE TO CONTENT OF SPEECH:") > 0 ||
                     caption.IndexOf("ARTICULATION:") > 0 ||
                     caption.IndexOf("RATE:") > 0)
            {
                boaderR = 11;
                borderL = 7;
                lineH = 12;
            }
            else if (caption.IndexOf("MOOD CONGRUENT:") > 0 ||
                     caption.IndexOf("RHYTHM:") > 0)
            {
                boaderR = 9;
                borderL = 5;
                lineH = 12;
            }
            PdfPTable pdfMMATab = new PdfPTable(2);
            PrintCell(pdfMMATab, caption, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_TOP, lineH, boaderR);
            PrintCell(pdfMMATab, text, ft, 1, 1, 1, Element.ALIGN_LEFT, lineH, borderL);
            pdfMMATab.TotalWidth = doc.PageSize.Width - 60;
            pdfMMATab.WidthPercentage = 90;
            float[] twidths = new float[] { firstlen - 20,
                           (pdfMMATab.TotalWidth - firstlen + 21) };
            pdfMMATab.GetRow(0).SetWidths(twidths);
            pdfMMATab.WriteSelectedRows(0, -1, 30, DocY - currY, cb);
            currY += lineH;
            if ((DocY - currY) < 60)
            {
                currY = 70;
                doc.NewPage();
            }
            return currY;
        }
        private int PrintSubTitle(PdfContentByte cb, Document doc, string caption, int CurrentY, float DocY)
        {
            int currY = CurrentY;
            PdfPTable pdfMMASubTab = new PdfPTable(1);
            PdfPCell pdfMMASubTabCell1 = new PdfPCell(new Phrase(caption, PatsFont.Pats12HeadBold));
            pdfMMASubTabCell1.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfMMASubTabCell1.Border = 0;
            pdfMMASubTab.AddCell(pdfMMASubTabCell1);
            pdfMMASubTab.TotalWidth = doc.PageSize.Width - 60;
            pdfMMASubTab.WidthPercentage = 90;
            pdfMMASubTab.WriteSelectedRows(0, -1, 30, DocY - currY, cb);
            currY += 20;
            if ((DocY - currY) < 60)
            {
                currY = 70;
                doc.NewPage();
            }
            return currY;
        }
        private string GetCheckedValue(bool YesValue, bool NoValue)
        {
            var checkVal = "";
            if (YesValue == true)
            {
                checkVal = "[X] Yes  [ " + string.Empty.PadLeft(1) + " ] Denied:";
            }
            else if (NoValue == true)
            {
                checkVal = "[ " + string.Empty.PadLeft(1) + " ] Yes  [X] Denied:";
            }
            else
            {
                checkVal = "[ " + string.Empty.PadLeft(1) + " ] Yes [ " + string.Empty.PadLeft(1) + " ] Denied:";
            }

            return checkVal;
        }
        private string GetGenderValue(string Value)
        {
            var checkVal = "";
            if (Value == "2")
            {
                checkVal = "[X] Male  [ " + string.Empty.PadLeft(1) + " ] Female ";
            }
            else if (Value == "1")
            {
                checkVal = "[ " + string.Empty.PadLeft(1) + " ] Male  [X] Female ";
            } 
            else
            {
                checkVal = "[ " + string.Empty.PadLeft(1) + " ] Male  [ " + string.Empty.PadLeft(1) + " ] Female ";
            }
            return checkVal;
        }
        private int PrintRowWithCheckBox(PdfContentByte cb, Document doc, string caption, string note, string CheckeVal, int CurrentY, int DocY, int DocX)
        {
            PdfPTable Tab = new PdfPTable(3);
            float[] twidths1 = null;

            int currY = CurrentY;
            //available lines
            PrintCell(Tab, caption, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_TOP, 15);
            PrintCell(Tab, CheckeVal, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_LEFT, 15);
            PrintCell(Tab, note, PatsFont.Pats12Normal, 1, 1, 1, Element.ALIGN_LEFT, 15);

            Tab.TotalWidth = DocX;
            Tab.WidthPercentage = 90;
            twidths1 = new float[] { (Tab.TotalWidth / 4) + 20,(Tab.TotalWidth /4)-60,
                                (Tab.TotalWidth /4) + 130 };
            Tab.GetRow(0).SetWidths(twidths1);
            Tab.WriteSelectedRows(0, -1, 30, DocY - currY, cb);
            currY += 15;
            if ((DocY - currY) < 60)
            {
                currY = 70;
                doc.NewPage();
            }

            return currY;
        }
        private int PrintHeaderRowWithCheckBox(PdfContentByte cb, Document doc, Dictionary<string, string> header, int CurrentY, int DocX, int DocY)
        {
            int currY = CurrentY;
            PdfPTable Tab = new PdfPTable(8);
            PdfPCell cell = new PdfPCell(new Phrase(new Chunk("Name: ", FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.BOLD))));
            cell.Border = 0;
            Tab.AddCell(cell);
            cell = new PdfPCell(new Phrase(new Chunk(header["Name"], FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.UNDERLINE))));
            cell.Border = 0;
            cell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            Tab.AddCell(cell);

            cell = new PdfPCell(new Phrase(new Chunk("Age: ", FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.BOLD))));
            cell.Border = 0;
            Tab.AddCell(cell);
            cell = new PdfPCell(new Phrase(new Chunk(header["Age"], FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.NORMAL))));
            cell.Border = 0;
            cell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            Tab.AddCell(cell);

            cell = new PdfPCell(new Phrase(new Chunk("Sex: ", FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.BOLD))));
            cell.Border = 0;
            Tab.AddCell(cell);

            var chunk = new Chunk(GetGenderValue(header["Sex"]), FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.NORMAL));
            cell = new PdfPCell(new Phrase(chunk));
            cell.Border = 0;
            Tab.AddCell(cell);

            cell = new PdfPCell(new Phrase(new Chunk("Date: ", FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.BOLD))));
            cell.Border = 0;
            Tab.AddCell(cell);
            cell = new PdfPCell(new Phrase(new Chunk(header["Date"], FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.NORMAL))));
            cell.Border = 0;
            cell.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
            Tab.AddCell(cell);

            Tab.TotalWidth = DocX;
            //Tab.WidthPercentage = 90;
            //float[] widths = {
            //    (pdfDSM51Tab.TotalWidth / 8) / 4 + 20,
            //    (pdfDSM51Tab.TotalWidth / 8),
            //    (pdfDSM51Tab.TotalWidth / 8) / 4,
            //    (pdfDSM51Tab.TotalWidth / 8) / 2,
            //    (pdfDSM51Tab.TotalWidth / 8) / 4,
            //    (pdfDSM51Tab.TotalWidth / 8),
            //    (pdfDSM51Tab.TotalWidth / 8) / 4,
            //    (pdfDSM51Tab.TotalWidth / 8)};
            float[] twidths1 = new float[] { (Tab.TotalWidth / 32) + 10, (Tab.TotalWidth / 8),
                                     (Tab.TotalWidth / 32), (Tab.TotalWidth / 32),
                                     (Tab.TotalWidth / 32), (Tab.TotalWidth / 8),
                                     (Tab.TotalWidth / 32), (Tab.TotalWidth / 8)};
            Tab.GetRow(0).SetWidths(twidths1);
            Tab.WriteSelectedRows(0, -1, 30, DocY - 50, cb);

            return currY += 15;
        }

        public static int PintTextRow(PdfContentByte cb, Document doc, string Text, string Title, float DocY, float DocX, int CurrentY)
        {
            PdfPTable Tab = new PdfPTable(2);
            float[] twidths1 = null;

            int currY = CurrentY;
            var colHeight = 2;
            var lineData = new List<string>();
            Text = string.IsNullOrEmpty(Text) ? "" : Text;
            colHeight = GetLineData(Text, 95, out lineData);
            var colheights = (colHeight < 2 ? 2 : colHeight);
            if (DocY - (38 + currY + (colHeight * 15)) < 40)
            {
                var lines = (int)(DocY - (38 + currY)) / 15;
                var temp = "";
                var temp1 = "";
                if (lines >= colHeight)
                {
                    for (int ln1 = 0; ln1 < colHeight; ln1++)
                    {
                        temp += lineData[ln1];
                    }
                }
                else
                {
                    for (int ln1 = 0; ln1 < lines; ln1++)
                    {
                        temp += lineData[ln1];
                    }
                    for (int ln2 = (int)lines; ln2 < colHeight; ln2++)
                    {
                        temp1 += lineData[ln2];
                    }
                }
                //available lines
                PrintCell(Tab, Title, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_TOP, lines * 15);
                PrintCell(Tab, temp, PatsFont.Pats12Normal, 1, 1, 1, Element.ALIGN_LEFT, lines * 15);
            }
            else
            {
                var data = string.IsNullOrEmpty(Text) ? "N/A" : Text;
                PrintCell(Tab, Title, PatsFont.CA8B, 1, 1, 1, Element.ALIGN_TOP, colheights * 15);
                PrintCell(Tab, data, PatsFont.Pats12Normal, 1, 1, 1, Element.ALIGN_LEFT, colheights * 15);
            }

            Tab.TotalWidth = DocX;
            Tab.WidthPercentage = 90;
            twidths1 = new float[] { (Tab.TotalWidth / 6) - 15,
                                (Tab.TotalWidth /5 * 3) + 95 };
            Tab.GetRow(0).SetWidths(twidths1);
            Tab.WriteSelectedRows(0, -1, 30, DocY - currY, cb);
            currY += (colheights * 15);
            if ((DocY - currY) < 60)
            {
                currY = 70;
                doc.NewPage();
            }

            return currY;
        }
        public static int CreateNewPage(PdfContentByte cb, Document doc)
        {
            int currY = 70;
            doc.NewPage();
            //=========================
            var pdfEval3Tab = new PdfPTable(2);
            PrintRow(pdfEval3Tab, "EVALUATION AREA", PatsFont.Pats10HeadBold, 0, 2, 2);
            PrintRow(pdfEval3Tab, "NARRATIVE", PatsFont.Pats10HeadBold, 0, 2, 0);

            pdfEval3Tab.TotalWidth = doc.PageSize.Width;
            pdfEval3Tab.WidthPercentage = 90;
            float[] twidths =  { (pdfEval3Tab.TotalWidth / 5) - 10,
                                    pdfEval3Tab.TotalWidth /5 * 3 + 69 };
            pdfEval3Tab.GetRow(0).SetWidths(twidths);
            pdfEval3Tab.WriteSelectedRows(0, -1, 30, (doc.PageSize.Height - currY), cb);
            return currY += 20;
        }
        public static int GetLineData(string sourceString, int charLength, out List<string> lineData)
        {
            lineData = new List<string>();
            if (string.IsNullOrEmpty(sourceString))
            {
                lineData.Add("N/A");
                return 1;
            }

            string[] lines = sourceString.Split('\n');
            if (lines != null && lines.Length > 0 && lines[0].Length > 0)
            {
                for (int i = 0; i < lines.Length; i++)
                {
                    var tempstring = lines[i];
                    if (tempstring.Trim() == "")
                    {
                        lineData.Add("\n");
                        continue;
                    }

                    if (tempstring.Length < charLength || tempstring.Length == charLength)
                    {
                        lineData.Add(tempstring + "\n");
                        continue;
                    }

                    do
                    {
                        var str = tempstring.Substring(0, charLength);
                        int len = charLength;
                        if (tempstring.Substring(charLength, 1) != " ")
                        {
                            len = str.LastIndexOf(" ");
                            if (len > 0)
                                str = tempstring.Substring(0, len);
                            else
                                len = str.Length;
                        }
                        lineData.Add(str);
                        tempstring = tempstring.Substring(len, tempstring.Length - str.Length);
                    } while (tempstring.Length > charLength);

                    if (tempstring.Length > 0)
                    {
                        lineData.Add(tempstring + "\n");
                    }
                }
            }
            return lineData.Count();
        }
        public static void PrintCell(PdfPTable pdfTab, string phraseTitle, Font font, int ColSpan, int RowSpan, int Border, int TextAlign, int FixH, int NoBord)
        {
            PdfPCell pdfCell = new PdfPCell(new Phrase(phraseTitle, font));
            pdfCell.FixedHeight = FixH;
            pdfCell.HorizontalAlignment = TextAlign;
            pdfCell.Colspan = ColSpan;
            pdfCell.Rowspan = RowSpan;

            if (Border > 0)
            {
                if (NoBord == PdfPCell.RIGHT_BORDER)
                    pdfCell.Border = PdfPCell.LEFT_BORDER | PdfPCell.TOP_BORDER | PdfPCell.BOTTOM_BORDER;
                else if (NoBord == PdfPCell.LEFT_BORDER)
                    pdfCell.Border = PdfPCell.RIGHT_BORDER | PdfPCell.TOP_BORDER | PdfPCell.BOTTOM_BORDER;
                else if (NoBord == 10) //no RIGHT_BORDER + BOTTOM_BORDER/
                    pdfCell.Border = PdfPCell.TOP_BORDER | PdfPCell.LEFT_BORDER;
                else if (NoBord == 6) //no LEFT_BORDER + BOTTOM_BORDER
                    pdfCell.Border = PdfPCell.TOP_BORDER | PdfPCell.RIGHT_BORDER;
                else if (NoBord == 11) //no TOP_BORDER + RIGHT_BORDER + BOTTOM_BORDER
                    pdfCell.Border = PdfPCell.LEFT_BORDER;
                else if (NoBord == 7) //no TOP_BORDER + LEFT_BORDER + BOTTOM_BORDER
                    pdfCell.Border = PdfPCell.RIGHT_BORDER;
                else if (NoBord == 5) //no TOP_BORDER + LEFT_BORDER 
                    pdfCell.Border = PdfPCell.BOTTOM_BORDER | PdfPCell.RIGHT_BORDER;
                else if (NoBord == 9) //no TOP_BORDER + RIGHT_BORDER 
                    pdfCell.Border = PdfPCell.BOTTOM_BORDER | PdfPCell.LEFT_BORDER;
            }
            else
                pdfCell.Border = Border;

            pdfTab.AddCell(pdfCell);
        }
        public static void PrintCell(PdfPTable pdfTab, string phraseTitle, Font font, int ColSpan, int RowSpan, int Border, int TextAlign, int FixH)
        {
            PdfPCell pdfCell = new PdfPCell(new Phrase(phraseTitle, font));
            pdfCell.FixedHeight = FixH;
            pdfCell.HorizontalAlignment = TextAlign;
            pdfCell.Colspan = ColSpan;
            pdfCell.Rowspan = RowSpan;

            pdfCell.Border = Border > 0 ? PdfPCell.LEFT_BORDER | PdfPCell.RIGHT_BORDER | PdfPCell.TOP_BORDER | PdfPCell.BOTTOM_BORDER : Border;
            pdfTab.AddCell(pdfCell);
        }
        public static void PrintRow(PdfPTable pdfTab, string phraseTitle, Font font, int ColSpan, int Border, int TextAlign)
        {
            PdfPCell pdfCell = new PdfPCell(new Phrase(phraseTitle, font));

            if (Border == 0) pdfCell.FixedHeight = 10;
            else if (Border == 1) pdfCell.FixedHeight = 15;
            else if (Border == 2) pdfCell.FixedHeight = 20;
            else if (Border == 3) pdfCell.FixedHeight = 45;
            else pdfCell.FixedHeight = Border * 15;

            pdfCell.HorizontalAlignment = Element.ALIGN_LEFT;
            if (font.Color.ToString() == "Color value[FF004080]")
            {
                if (ColSpan > 0)
                    pdfCell.BackgroundColor = BaseColor.LIGHT_GRAY;
                pdfCell.HorizontalAlignment = Element.ALIGN_TOP;
            }
            pdfCell.Colspan = ColSpan;
            if (ColSpan == 2)
            {
                pdfCell.HorizontalAlignment = Element.ALIGN_CENTER;
            }
            else if (ColSpan == 3)
            {
                pdfCell.FixedHeight = 30;
            }
            else if (ColSpan > 3)
            {
                pdfCell.FixedHeight = ColSpan;
            }
            if (TextAlign == 1)
                pdfCell.HorizontalAlignment = Element.ALIGN_LEFT;
            else if (TextAlign == 2)
                pdfCell.HorizontalAlignment = Element.ALIGN_TOP;
            else if (TextAlign == 3)
                pdfCell.HorizontalAlignment = Element.ALIGN_RIGHT;
            else if (TextAlign == 4)
                pdfCell.HorizontalAlignment = Element.ALIGN_BOTTOM;
            else
                pdfCell.HorizontalAlignment = Element.ALIGN_CENTER;

            pdfCell.Border = Border > 0 ? PdfPCell.LEFT_BORDER | PdfPCell.RIGHT_BORDER | PdfPCell.TOP_BORDER | PdfPCell.BOTTOM_BORDER : Border;
            pdfTab.AddCell(pdfCell);
        }
        public static void PrintRow(PdfPTable pdfTab, string phraseTitle, Font font, int ColSpan)
        {
            PdfPCell pdfCell = new PdfPCell(new Phrase(phraseTitle, font));

            if (font == PatsFont.PatsSmall) pdfCell.FixedHeight = 10;
            else pdfCell.FixedHeight = 15;

            pdfCell.HorizontalAlignment = Element.ALIGN_LEFT;
            pdfCell.Colspan = ColSpan;

            pdfCell.Border = PdfPCell.LEFT_BORDER | PdfPCell.RIGHT_BORDER | PdfPCell.TOP_BORDER | PdfPCell.BOTTOM_BORDER;
            pdfTab.AddCell(pdfCell);
        }
        public class HeaderFooter : PdfPageEventHelper, IPdfPageEvent
        {
            PdfContentByte cb;
            PdfTemplate template;
            DateTime PrintTime = DateTime.Now;

            string watermarkText;
            //float fontSize = 80f;
            float xPosition = 300f;
            float yPosition = 800f;
            float angle = 45f;

            #region Fields
            private string _header;
            #endregion

            #region Properties
            public string Header
            {
                get { return _header; }
                set { _header = value; }
            }

            public string LoginUser { get; set; }
            public int TotalPages { get; set; }
            public string AppointmentTitle { get; set; }
            //public MediCalInfor MedBillInfo { get; set; }
            public CaseNoteInfo CaseNoteInfo { get; set; }
            public List<DMS5> DSM5Data { get; set; }

            public MMA MMAInfo { get; set; }
            public Dictionary<string, string> ProfileInfo { get; set; }
            #endregion
            public HeaderFooter(string loginUser, float fontSize = 40f, float xPosition = 200f, float yPosition = 300f)
            {
                this.xPosition = xPosition;
                this.yPosition = yPosition;
                LoginUser = loginUser;
            }
            public HeaderFooter(string loginUser, CaseNoteInfo noteInfo, float fontSize = 40f, float xPosition = 200f, float yPosition = 300f, float angle = 45f)
            {
                this.watermarkText = string.Empty;
                this.xPosition = xPosition;
                this.yPosition = yPosition;
                this.angle = angle;
                LoginUser = loginUser;
                CaseNoteInfo = noteInfo;
            }


            public HeaderFooter(string loginUser, MMA mmaInfo, float fontSize = 40f, float xPosition = 200f, float yPosition = 300f, float angle = 45f)
            {
                this.watermarkText = string.Empty;
                this.xPosition = xPosition;
                this.yPosition = yPosition;
                this.angle = angle;
                LoginUser = loginUser;
                MMAInfo = mmaInfo;
            }
            public HeaderFooter(string loginUser, List<DMS5> dsm5data, float fontSize = 40f, float xPosition = 200f, float yPosition = 300f, float angle = 45f)
            {
                this.watermarkText = string.Empty;
                this.xPosition = xPosition;
                this.yPosition = yPosition;
                this.angle = angle;
                LoginUser = loginUser;
                DSM5Data = dsm5data;
            }
            //public HeaderFooter(string loginUser, string psychiatristName, MediCalInfor medInfor, string watermarkText, float fontSize = 40f, float xPosition = 200f, float yPosition = 300f, float angle = 45f)
            //{
            //    this.watermarkText = watermarkText;
            //    this.xPosition = xPosition;
            //    this.yPosition = yPosition;
            //    this.angle = angle;
            //    this.TotalPages = 1;
            //    LoginUser = loginUser;
            //    MedBillInfo = medInfor;
            //}

            public HeaderFooter(string loginUser, string AppointmentTitle, float fontSize = 40f, float xPosition = 100f, float yPosition = 300f)
            {
                this.xPosition = xPosition;
                this.yPosition = yPosition;
                this.LoginUser = loginUser;
                this.TotalPages = 1;
                this.AppointmentTitle = AppointmentTitle;
            }
            public override void OnOpenDocument(PdfWriter writer, Document document)
            {
                try
                {
                    //PrintTime = DateTime.Now;                    
                    //BaseFont baseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);
                    //cb = writer.DirectContent;
                    //if (!string.IsNullOrEmpty(watermarkText))
                    //{
                    //    cb.BeginText();
                    //    cb.SetColorFill(BaseColor.LIGHT_GRAY);
                    //    cb.SetColorFill(new BaseColor(236, 234, 234));
                    //    cb.SetFontAndSize(baseFont, 60f);
                    //    cb.ShowTextAligned(PdfContentByte.ALIGN_CENTER, watermarkText, xPosition, yPosition, angle);  //for referrnce
                    //    cb.ShowTextAligned(PdfContentByte.ALIGN_CENTER, "", 200f, 400f, 45f);
                    //    cb.EndText();
                    //}
                    cb = writer.DirectContent;
                    template = cb.CreateTemplate(40, 40);

                }
                catch (DocumentException de)
                {

                }
                catch (System.IO.IOException ioe)
                {

                }
            }

            public override void OnEndPage(PdfWriter writer, Document document)
            {
                base.OnEndPage(writer, document);
                var bf = PatsFont.PatsFontBold;
                //if (MedBillInfo != null)
                //{
                //    PsychiatryHeadFooter(writer, document);
                //}
                if (!string.IsNullOrEmpty(AppointmentTitle))
                {
                    AppointmentHeadFooter(writer, document);
                }
                else if (CaseNoteInfo != null)
                {
                    CaseNoteHeadFooter(writer, document);
                }
                else if (MMAInfo != null)
                {
                    PsychiatryMMAHeadFooter(writer, document);
                }
                else if (MMAInfo != null)
                {
                    PsychiatryMMAHeadFooter(writer, document);
                }
                else if (DSM5Data != null)
                {
                    DSM5HeadFooter(writer, document);
                }
                else
                {
                    EvaluationHeadFooter(writer, document);
                }
            }

            public override void OnCloseDocument(PdfWriter writer, Document document)
            {
                base.OnCloseDocument(writer, document);

                template.BeginText();
                template.SetFontAndSize(PatsFont.PatsFontBold, 8f);
                template.SetTextMatrix(0, 0);
                template.ShowText("" + (writer.PageNumber));
                template.EndText();

            }

            public void PsychiatryHeadFooter(PdfWriter writer, Document document)
            {
                var bf = PatsFont.PatsFontBold;
                string header1 = "Psychiatric Medication Prescription";
                string header2 = "California Department of Corrections and Rehabilitation";
                Phrase p1Header = new Phrase(header1, PatsFont.PatsHeadBold);
                Phrase p2Header = new Phrase(new Chunk(header2, PatsFont.PatsSmall));
                //Create PdfTable object
                PdfPTable pdfTab = new PdfPTable(4);

                //We will have to create separate cells to include image logo and 2 separate strings
                //Row 1
                PdfPCell pdfCell1 = new PdfPCell(p1Header);
                pdfCell1.Colspan = 4;
                pdfCell1.HorizontalAlignment = Element.ALIGN_LEFT;
                //Row 2
                PdfPCell pdfCell2 = new PdfPCell(p2Header);
                pdfCell2.Colspan = 4;
                pdfCell2.HorizontalAlignment = Element.ALIGN_LEFT;

                //Row 3
                PdfPCell pdfCell3 = new PdfPCell(new Phrase(""));
                PdfPCell pdfCell4 = new PdfPCell(new Phrase("Printed: " + PrintTime.ToShortDateString() + string.Format(" {0:t}", DateTime.Now), PatsFont.PatsSmall));
                string title = string.Format("       {0} {1}", "By", LoginUser);
                if (!string.IsNullOrEmpty(AppointmentTitle))
                    title = string.Format("       {0} {1}", "By", LoginUser);
                PdfPCell pdfCell5 = new PdfPCell(new Phrase(title, PatsFont.PatsSmall));
                pdfCell4.HorizontalAlignment = Element.ALIGN_CENTER;
                pdfCell5.HorizontalAlignment = Element.ALIGN_CENTER;
                pdfCell5.Colspan = 2;
                //if (MedBillInfo != null)
                //{
                //    Phrase p3Header = new Phrase(new Chunk(MedBillInfo.Memo, PatsFont.PatsNormal));
                //}

                pdfCell1.Border = 0;
                pdfCell2.Border = 0;
                pdfCell3.Border = 0;
                pdfCell4.Border = 0;
                pdfCell5.Border = 0;

                //add all three cells into PdfTable
                pdfTab.AddCell(pdfCell1);
                pdfTab.AddCell(pdfCell2);
                pdfTab.AddCell(pdfCell3);
                pdfTab.AddCell(pdfCell4);
                pdfTab.AddCell(pdfCell5);

                pdfTab.TotalWidth = document.PageSize.Width;
                pdfTab.WidthPercentage = 90;

                //Third and fourth param is x and y position to start writing
                pdfTab.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 30, writer.DirectContent);

                int size1 = string.IsNullOrEmpty(AppointmentTitle) ? 5 : 8;
                cb.BeginText();
                cb.SetFontAndSize(bf, size1);
                cb.SetTextMatrix(document.PageSize.Width / 2 - 20, document.PageSize.GetBottom(30));
                cb.ShowText("Page " + writer.CurrentPageNumber + " of " + document.PageNumber);
                cb.EndText();

                cb.BeginText();
                cb.SetFontAndSize(bf, size1);
                cb.SetTextMatrix(document.PageSize.Width / 2 + 55, document.PageSize.GetBottom(30));
                cb.ShowText("California Department of Corrections and Rehabilitation");
                cb.EndText();

                cb.MoveTo(30, document.PageSize.Height - 68);
                cb.SetLineWidth(1.0f);
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.Height - 68);
                cb.Stroke();

                //if (MedBillInfo != null)
                //{
                    //    cb.MoveTo((document.PageSize.Width - document.PageSize.Width / 2) + 180, document.PageSize.Height - 90);
                    //    cb.SetLineWidth(0.5f);
                    //    cb.LineTo(document.PageSize.Width - ((document.PageSize.Width - document.PageSize.Width / 2)) + 100, document.PageSize.Height - 90);
                    //    cb.Stroke();

                    //    cb.MoveTo((document.PageSize.Width - document.PageSize.Width / 2) + 50, document.PageSize.Height - 100);
                    //    cb.SetLineWidth(0.5f);
                    //    cb.LineTo(document.PageSize.Width - ((document.PageSize.Width - document.PageSize.Width / 2)) + 180, document.PageSize.Height - 100);
                    //    cb.Stroke();

                    //    cb.MoveTo((document.PageSize.Width - document.PageSize.Width / 2) + 180, document.PageSize.Height - 110);
                    //    cb.SetLineWidth(0.5f);
                    //    cb.LineTo(document.PageSize.Width - ((document.PageSize.Width - document.PageSize.Width / 2)) + 100, document.PageSize.Height - 110);
                    //    cb.Stroke();

                    //    cb.MoveTo((document.PageSize.Width - document.PageSize.Width / 2) + 180, document.PageSize.Height - 120);
                    //    cb.SetLineWidth(0.5f);
                    //    cb.LineTo(document.PageSize.Width - ((document.PageSize.Width - document.PageSize.Width / 2)) + 100, document.PageSize.Height - 120);
                    //    cb.Stroke();

                    //    //if (MedBillInfo != null)
                    //    //{
                    //    if (MedBillInfo.MedPayCode == "2")
                    //    {
                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                    //        cb.SetTextMatrix(30, document.PageSize.GetBottom(120));
                    //        cb.ShowText("Bill To Medi-Cal Only");
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontBold, 6);
                    //        cb.SetTextMatrix(200, document.PageSize.GetBottom(120));
                    //        cb.ShowText("MediCal Billing Information");
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontBold, 6);
                    //        cb.SetTextMatrix(200, document.PageSize.GetBottom(114));
                    //        cb.ShowText("RECIPIENT ID:");
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontBold, 6);
                    //        cb.SetTextMatrix(300, document.PageSize.GetBottom(114));
                    //        cb.ShowText(MedBillInfo.RecipentId);
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontBold, 6);
                    //        cb.SetTextMatrix(200, document.PageSize.GetBottom(108));
                    //        cb.ShowText("RECIPIENT GENDER:");
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontNormal, 6);
                    //        cb.SetTextMatrix(300, document.PageSize.GetBottom(108));
                    //        cb.ShowText(MedBillInfo.RecipentGender);
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontBold, 6);
                    //        cb.SetTextMatrix(200, document.PageSize.GetBottom(102));
                    //        cb.ShowText("BIRTH YEAR-MONTH:");
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontNormal, 6);
                    //        cb.SetTextMatrix(300, document.PageSize.GetBottom(102));
                    //        cb.ShowText(MedBillInfo.BirthYM);
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontBold, 6);
                    //        cb.SetTextMatrix(200, document.PageSize.GetBottom(96));
                    //        cb.ShowText("ISSUE DATE:");
                    //        cb.EndText();

                    //        cb.BeginText();
                    //        cb.SetFontAndSize(PatsFont.PatsFontNormal, 6);
                    //        cb.SetTextMatrix(300, document.PageSize.GetBottom(96));
                    //        cb.ShowText(MedBillInfo.IssueDate);
                    //        cb.EndText();
                    //    }
                    //    else
                    //    {
                    //cb.BeginText();
                    //cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                    //cb.SetTextMatrix(30, document.PageSize.GetBottom(102));
                    //cb.ShowText("Bill To MagellanRx");
                    //cb.EndText();

                    //cb.BeginText();
                    //cb.SetFontAndSize(PatsFont.PatsFontItalic, 6);
                    //cb.SetTextMatrix(30, document.PageSize.GetBottom(96));
                    //cb.ShowText("Billing details on page footer");
                    //cb.EndText();
                    //}

                    //add string to footer befor
                    //cb.BeginText();
                    //cb.SetFontAndSize(bf, 5);
                    //cb.SetTextMatrix(30, document.PageSize.GetBottom(65));
                    //cb.ShowText("Physician Signature (" + MedBillInfo.PsychiatristName + " - Psychiatrist)");
                    //cb.EndText();

                    //cb.BeginText();
                    //cb.SetFontAndSize(bf, 5);
                    //cb.SetTextMatrix((document.PageSize.Width / 4) * 3 - 50, document.PageSize.GetBottom(65));
                    //cb.ShowText("NPI No. " + MedBillInfo.DEANumber);
                    //cb.EndText();

                    //cb.BeginText();
                    //cb.SetFontAndSize(bf, 5);
                    //cb.SetTextMatrix((document.PageSize.Width / 4) * 3 + 30, document.PageSize.GetBottom(65));
                    //cb.ShowText("Date");
                    //cb.EndText();

                    //cb.BeginText();
                    //cb.SetFontAndSize(PatsFont.PatsFontItalic, 5);
                    //cb.SetTextMatrix(30, document.PageSize.GetBottom(55));
                    //cb.ShowText("For questions regarding the patient, the prescribing physician or the prescribed medications, please call " + MedBillInfo.PhoneNumber);
                    //cb.EndText();

                    //cb.BeginText();
                    //cb.SetFontAndSize(PatsFont.PatsFontItalic, 5);
                    //cb.SetTextMatrix(30, document.PageSize.GetBottom(45));
                    //cb.ShowText("The State of California Department of Corrections and Rehabilitation has a contract with MagellanRx, LLC for prescriptions. The billing should be processed ");
                    //cb.EndText();

                    //cb.BeginText();
                    //cb.SetFontAndSize(PatsFont.PatsFontItalic, 5);
                    //cb.SetTextMatrix(30, document.PageSize.GetBottom(40));
                    //cb.ShowText("through MagellanRx bin number 016523 and PCN number 22347 Group CADAPO. Pharmacists needing to verify this information can call: (800)424-5950.");
                    //cb.EndText();

                    //else
                    //{
                //    cb.BeginText();
                //    cb.SetFontAndSize(bf, 5);
                //    cb.SetTextMatrix(30, document.PageSize.GetBottom(65));
                //    cb.ShowText("Signature");
                //    cb.EndText();


                //    cb.BeginText();
                //    cb.SetFontAndSize(bf, 5);
                //    cb.SetTextMatrix((document.PageSize.Width / 4) * 3 + 30, document.PageSize.GetBottom(65));
                //    cb.ShowText("Date Filed");
                //    cb.EndText();
                //}

                //Move the pointer and draw line to separate footer section from rest of page
                cb.MoveTo(30, document.PageSize.GetBottom(70));
                cb.SetLineWidth(0.5f);
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(70));
                cb.Stroke();
                cb.MoveTo(30, document.PageSize.GetBottom(38));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(38));
                cb.Stroke();
                cb.MoveTo(30, document.PageSize.GetBottom(37));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(37));
                cb.Stroke();
            }

            public void AppointmentHeadFooter(PdfWriter writer, Document document)
            {
                //Create PdfTable object
                PdfPTable pdfHead1Tab = new PdfPTable(1);
                //Row 1
                PdfPCell pdfHeadCell1 = new PdfPCell(new Phrase("Daily Activity Record", PatsFont.PatsHeadBold));
                pdfHeadCell1.HorizontalAlignment = Element.ALIGN_LEFT;
                //Row 2
                PdfPCell pdfHeadCell2 = new PdfPCell(new Phrase("Parole Automation Tracking System", PatsFont.PatsSmall));
                pdfHeadCell2.HorizontalAlignment = Element.ALIGN_LEFT;

                pdfHeadCell1.Border = 0;
                pdfHeadCell2.Border = 0;
                pdfHead1Tab.AddCell(pdfHeadCell1);
                pdfHead1Tab.AddCell(pdfHeadCell2);

                pdfHead1Tab.TotalWidth = document.PageSize.Width;
                pdfHead1Tab.WidthPercentage = 90;
                pdfHead1Tab.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 30, writer.DirectContent);

                //Create PdfTable object for head 2
                var pdfHead2Tab = new PdfPTable(3);
                //cell 1
                PdfPCell pdfHead1TabCell1 = new PdfPCell(new Phrase(""));
                //cell 2
                PdfPCell pdfHead1TabCell2 = new PdfPCell(new Phrase("Printed: " + PrintTime.ToShortDateString() + string.Format(" {0:t}", DateTime.Now), PatsFont.PatsSmall));
                pdfHead1TabCell2.HorizontalAlignment = Element.ALIGN_LEFT;
                //cell 3
                PdfPCell pdfHead1TabCell3 = new PdfPCell(new Phrase(string.Format("{0} {1}", "By", LoginUser), PatsFont.PatsSmall));
                pdfHead1TabCell3.HorizontalAlignment = Element.ALIGN_MIDDLE;

                pdfHead1TabCell1.Border = 0;
                pdfHead1TabCell2.Border = 0;
                pdfHead1TabCell3.Border = 0;
                pdfHead2Tab.AddCell(pdfHead1TabCell1);
                pdfHead2Tab.AddCell(pdfHead1TabCell2);
                pdfHead2Tab.AddCell(pdfHead1TabCell3);

                pdfHead2Tab.TotalWidth = document.PageSize.Width;
                pdfHead2Tab.WidthPercentage = 90;
                pdfHead2Tab.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 55, writer.DirectContent);
                //===============================================
                // head line
                cb.MoveTo(30, document.PageSize.Height - 68);
                cb.SetLineWidth(1.0f);
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.Height - 68);
                cb.Stroke();

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 9);
                cb.SetTextMatrix(30, document.PageSize.Height - 80);
                cb.ShowText(AppointmentTitle);
                cb.EndText();

                int size1 = 8;
                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, size1);
                cb.SetTextMatrix(30, document.PageSize.GetBottom(30));
                cb.ShowText("PATS Report - Daily Activity Record(DAR)");
                cb.EndText();

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, size1);
                cb.SetTextMatrix(document.PageSize.Width / 2 - 20, document.PageSize.GetBottom(30));
                cb.ShowText("Page " + writer.CurrentPageNumber + " of " + document.PageNumber);
                cb.EndText();

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, size1);
                cb.SetTextMatrix(document.PageSize.Width / 2 + 180, document.PageSize.GetBottom(30));
                cb.ShowText("California Department of Corrections and Rehabilitation");
                cb.EndText();

                //Move the pointer and draw line to separate footer section from rest of page
                cb.MoveTo(30, document.PageSize.GetBottom(39));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(38));
                cb.Stroke();
                cb.MoveTo(30, document.PageSize.GetBottom(38));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(37));
                cb.Stroke();
            }
            public void CaseNoteHeadFooter(PdfWriter writer, Document document)
            {
                //Head 1
                //=====================================
                Phrase p1Header = new Phrase("Client Case Notes", PatsFont.PatsHeadBold);
                Phrase p2Header = new Phrase(new Chunk("Parole Automation Tracking System", PatsFont.PatsSmall));
                //Create Table object for head 1
                PdfPTable pdfTab = new PdfPTable(1);
                //Row 1
                PdfPCell pdfTabCell1 = new PdfPCell(p1Header);
                pdfTabCell1.HorizontalAlignment = Element.ALIGN_LEFT;
                //Row 2
                PdfPCell pdfTabCell2 = new PdfPCell(p2Header);
                pdfTabCell2.HorizontalAlignment = Element.ALIGN_LEFT;

                pdfTabCell1.Border = 0;
                pdfTabCell2.Border = 0;
                pdfTab.AddCell(pdfTabCell1);
                pdfTab.AddCell(pdfTabCell2);

                pdfTab.TotalWidth = document.PageSize.Width;
                pdfTab.WidthPercentage = 90;
                pdfTab.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 30, writer.DirectContent);
                //=====================================

                //=====================================
                //head 2
                //Create PdfTable object for head 2
                var pdfTab1 = new PdfPTable(3);
                //cell 1
                PdfPCell pdfTab1Cell1 = new PdfPCell(new Phrase(""));
                //cell 2
                PdfPCell pdfTab1Cell2 = new PdfPCell(new Phrase("Printed: " + PrintTime.ToShortDateString() + string.Format(" {0:t}", DateTime.Now), PatsFont.PatsSmall));
                pdfTab1Cell2.HorizontalAlignment = Element.ALIGN_LEFT;
                //cell 3
                PdfPCell pdfTab1Cell3 = new PdfPCell(new Phrase(string.Format("{0} {1}", "By", LoginUser), PatsFont.PatsSmall));
                pdfTab1Cell3.HorizontalAlignment = Element.ALIGN_MIDDLE;

                pdfTab1Cell1.Border = 0;
                pdfTab1Cell2.Border = 0;
                pdfTab1Cell3.Border = 0;
                pdfTab1.AddCell(pdfTab1Cell1);
                pdfTab1.AddCell(pdfTab1Cell2);
                pdfTab1.AddCell(pdfTab1Cell3);

                pdfTab1.TotalWidth = document.PageSize.Width;
                pdfTab1.WidthPercentage = 90;
                pdfTab1.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 55, writer.DirectContent);
                //===============================================
                // head line
                cb.MoveTo(30, document.PageSize.Height - 68);
                cb.SetLineWidth(1.0f);
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.Height - 68);
                cb.Stroke();

                //footer - Move the pointer and draw line to separate footer section 
                cb.MoveTo(30, document.PageSize.GetBottom(38));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(38));
                cb.Stroke();
                cb.MoveTo(30, document.PageSize.GetBottom(37));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(37));
                cb.Stroke();
                // footer section
                string text = "Page " + writer.CurrentPageNumber + " of ";
                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(document.PageSize.Width / 2 - 20, document.PageSize.GetBottom(30));
                cb.ShowText(text);
                cb.EndText();

                cb.AddTemplate(template, (document.PageSize.Width / 2) + text.Length + 5, document.PageSize.GetBottom(30));

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(30, document.PageSize.GetBottom(30));
                cb.ShowText("PATS Report - EpisodeCaseNote");
                cb.EndText();

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(document.PageSize.Width / 2 + 70, document.PageSize.GetBottom(30));
                cb.ShowText("California Department of Corrections and Rehabilitation");
                cb.EndText();
            }
            public void DSM5HeadFooter(PdfWriter writer, Document document)
            {
                //Head 1
                //=====================================
                Phrase p1Header = new Phrase();
                p1Header.Add(new Chunk("DMS-5 Self-Rated Level 1 Cross-Cutting Symptom Measure—Adult", FontFactory.GetFont(BaseFont.HELVETICA, 12, Font.BOLD, BaseColor.BLACK)));
                PdfPTable pdfTab = new PdfPTable(1);
                //Row 1
                PdfPCell pdfTabCell1 = new PdfPCell(p1Header);
                pdfTabCell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;              
                pdfTabCell1.Border = 0;
                pdfTab.AddCell(pdfTabCell1);
                
                pdfTab.TotalWidth = document.PageSize.Width;
                pdfTab.WidthPercentage = 100;
                pdfTab.WriteSelectedRows(0, -1, 0, document.PageSize.Height - 20, writer.DirectContent);
                //=====================================

                //=====================================
                //row 2
                var pdfTab1 = new PdfPTable(1);
                PdfPCell pdfTab1Cell = new PdfPCell(new Phrase("Printed: " + PrintTime.ToShortDateString() + string.Format(" {0:t}", DateTime.Now), FontFactory.GetFont(BaseFont.HELVETICA, 6, Font.NORMAL, BaseColor.BLACK)));
                pdfTab1Cell.HorizontalAlignment = PdfPCell.ALIGN_CENTER;                
                pdfTab1Cell.Border = 0;
                pdfTab1.AddCell(pdfTab1Cell);
                               
                pdfTab1.TotalWidth = document.PageSize.Width;
                pdfTab1.WidthPercentage = 100;
                pdfTab1.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 37, writer.DirectContent);
              
                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontNormal, 6);
                cb.SetTextMatrix((document.PageSize.Width / 2 + 70), document.PageSize.GetBottom(30));
                cb.ShowText("Copyright © 2013 American Psychiatric Association. All Rights Reserved.");
                cb.EndText();

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontNormal, 8);
                cb.SetTextMatrix(document.PageSize.Width / 2 - 105, document.PageSize.GetBottom(20));
                cb.ShowText("This material can be reproduced without permission by researchers and by clinicians for use with their patients.");
                cb.EndText();
            }
            public void EvaluationHeadFooter(PdfWriter writer, Document document)
            {
                //Head 1
                //=====================================
                Phrase p1Header = new Phrase("INITIAL EVALUATION", PatsFont.PatsHeadBold);
                Phrase p2Header = new Phrase(new Chunk("Parole Automation Tracking System", PatsFont.PatsSmall));
                //Create Table object for head 1
                PdfPTable pdfTab = new PdfPTable(1);
                //Row 1
                PdfPCell pdfTabCell1 = new PdfPCell(p1Header);
                pdfTabCell1.HorizontalAlignment = Element.ALIGN_LEFT;
                //Row 2
                PdfPCell pdfTabCell2 = new PdfPCell(p2Header);
                pdfTabCell2.HorizontalAlignment = Element.ALIGN_LEFT;

                pdfTabCell1.Border = 0;
                pdfTabCell2.Border = 0;
                pdfTab.AddCell(pdfTabCell1);
                pdfTab.AddCell(pdfTabCell2);

                pdfTab.TotalWidth = document.PageSize.Width;
                pdfTab.WidthPercentage = 90;
                pdfTab.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 30, writer.DirectContent);
                //=====================================

                //=====================================
                //head 2
                //Create PdfTable object for head 2
                var pdfTab1 = new PdfPTable(3);
                //cell 1
                PdfPCell pdfTab1Cell1 = new PdfPCell(new Phrase(""));
                //cell 2
                PdfPCell pdfTab1Cell2 = new PdfPCell(new Phrase("Printed: " + PrintTime.ToShortDateString() + string.Format(" {0:t}", DateTime.Now), PatsFont.PatsSmall));
                pdfTab1Cell2.HorizontalAlignment = Element.ALIGN_LEFT;
                //cell 3
                PdfPCell pdfTab1Cell3 = new PdfPCell(new Phrase(string.Format("{0} {1}", "By", LoginUser), PatsFont.PatsSmall));
                pdfTab1Cell3.HorizontalAlignment = Element.ALIGN_MIDDLE;

                pdfTab1Cell1.Border = 0;
                pdfTab1Cell2.Border = 0;
                pdfTab1Cell3.Border = 0;
                pdfTab1.AddCell(pdfTab1Cell1);
                pdfTab1.AddCell(pdfTab1Cell2);
                pdfTab1.AddCell(pdfTab1Cell3);

                pdfTab1.TotalWidth = document.PageSize.Width;
                pdfTab1.WidthPercentage = 90;
                pdfTab1.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 55, writer.DirectContent);
                //===============================================
                // head line
                cb.MoveTo(30, document.PageSize.Height - 68);
                cb.SetLineWidth(1.0f);
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.Height - 68);
                cb.Stroke();

                //footer - Move the pointer and draw line to separate footer section 
                cb.MoveTo(30, document.PageSize.GetBottom(38));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(38));
                cb.Stroke();
                cb.MoveTo(30, document.PageSize.GetBottom(37));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(37));
                cb.Stroke();
                // footer section
                string text = "Page " + writer.CurrentPageNumber + " of ";
                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(document.PageSize.Width / 2 - 20, document.PageSize.GetBottom(30));
                cb.ShowText(text);
                cb.EndText();

                cb.AddTemplate(template, (document.PageSize.Width / 2) + text.Length + 6, document.PageSize.GetBottom(30));

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(30, document.PageSize.GetBottom(30));
                cb.ShowText("PATS Report - EpisodeEvaluation");
                cb.EndText();

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(document.PageSize.Width / 2 + 70, document.PageSize.GetBottom(30));
                cb.ShowText("California Department of Corrections and Rehabilitation");
                cb.EndText();
            }
            public void PsychiatryMMAHeadFooter(PdfWriter writer, Document document)
            {
                //Header 1
                //=====================================
                PdfPTable pdfHeadTab = new PdfPTable(3);
                //Row 1 cell1
                PdfPCell pdfHeadTabCell1 = new PdfPCell(new Phrase("STATE OF CALIFORNIA", PatsFont.PatsSmall6));
                pdfHeadTabCell1.HorizontalAlignment = Element.ALIGN_LEFT;
                PdfPCell pdfHeadTabCell2 = new PdfPCell(new Phrase("", PatsFont.PatsSmall6));
                pdfHeadTabCell2.HorizontalAlignment = Element.ALIGN_LEFT;
                //Row 1 cell2
                PdfPCell pdfHeadTabCell3 = new PdfPCell(new Phrase("DEPARTMENT OF CORRECTIONS AND REHABILITATION ", PatsFont.PatsSmall6));
                pdfHeadTabCell3.HorizontalAlignment = Element.ALIGN_LEFT;
                //=====================================

                //Row 2 cell1
                PdfPCell pdfHeadTabCell4 = new PdfPCell(new Phrase("MEDICATION MANAGEMENT ASSESSMENT", PatsFont.Pats12HeadBold));
                pdfHeadTabCell4.HorizontalAlignment = Element.ALIGN_LEFT;
                PdfPCell pdfHeadTabCell5 = new PdfPCell(new Phrase("", PatsFont.PatsSmall6));
                pdfHeadTabCell5.HorizontalAlignment = Element.ALIGN_LEFT;
                //Row 2 cell2
                PdfPCell pdfHeadTabCell6 = new PdfPCell(new Phrase("DIVISION OF ADULT PAROLE OPERATIONS ", PatsFont.PatsSmall6));
                pdfHeadTabCell6.HorizontalAlignment = Element.ALIGN_LEFT;

                pdfHeadTabCell1.Border = 0;
                pdfHeadTabCell2.Border = 0;
                pdfHeadTabCell3.Border = 0;
                pdfHeadTabCell4.Border = 0;
                pdfHeadTabCell5.Border = 0;
                pdfHeadTabCell6.Border = 0;
                pdfHeadTab.AddCell(pdfHeadTabCell1);
                pdfHeadTab.AddCell(pdfHeadTabCell2);
                pdfHeadTab.AddCell(pdfHeadTabCell3);
                pdfHeadTab.AddCell(pdfHeadTabCell4);
                pdfHeadTab.AddCell(pdfHeadTabCell5);
                pdfHeadTab.AddCell(pdfHeadTabCell6);

                pdfHeadTab.TotalWidth = document.PageSize.Width;
                pdfHeadTab.WidthPercentage = 90;
                var width = pdfHeadTab.TotalWidth;
                float[] widthes = { (width / 3) + 80, (width / 3) - 80, (width / 3) + 30 };
                pdfHeadTab.SetWidths(widthes);
                pdfHeadTab.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 30, writer.DirectContent);
                //=====================================
                //header 2
                //Create PdfTable object for head 2
                var pdfTab1 = new PdfPTable(3);
                //cell 1
                PdfPCell pdfTab1Cell1 = new PdfPCell(new Phrase("Parole Automation Tracking System", PatsFont.PatsSmall));
                //cell 2
                PdfPCell pdfTab1Cell2 = new PdfPCell(new Phrase("Printed: " + PrintTime.ToShortDateString() + string.Format(" {0:t}", DateTime.Now), PatsFont.PatsSmall));
                pdfTab1Cell2.HorizontalAlignment = Element.ALIGN_LEFT;
                //cell 3
                PdfPCell pdfTab1Cell3 = new PdfPCell(new Phrase(string.Format("  {0} {1}", "By", LoginUser), PatsFont.PatsSmall));
                pdfTab1Cell3.HorizontalAlignment = Element.ALIGN_LEFT;

                pdfTab1Cell1.Border = 0;
                pdfTab1Cell2.Border = 0;
                pdfTab1Cell3.Border = 0;
                pdfTab1.AddCell(pdfTab1Cell1);
                pdfTab1.AddCell(pdfTab1Cell2);
                pdfTab1.AddCell(pdfTab1Cell3);

                pdfTab1.TotalWidth = document.PageSize.Width;
                pdfTab1.WidthPercentage = 90;
                pdfTab1.WriteSelectedRows(0, -1, 30, document.PageSize.Height - 55, writer.DirectContent);
                //===============================================
                // head line
                cb.MoveTo(30, document.PageSize.Height - 68);
                cb.SetLineWidth(1.0f);
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.Height - 68);
                cb.Stroke();

                //footer - Move the pointer and draw line to separate footer section
                cb.MoveTo(30, document.PageSize.GetBottom(38));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(38));
                cb.Stroke();
                cb.MoveTo(30, document.PageSize.GetBottom(37));
                cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(37));
                cb.Stroke();
                // footer section
                string text = "Page " + writer.CurrentPageNumber + " of ";
                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(document.PageSize.Width / 2 - 20, document.PageSize.GetBottom(30));
                cb.ShowText(text);
                cb.EndText();

                cb.AddTemplate(template, (document.PageSize.Width / 2) + text.Length + 5, document.PageSize.GetBottom(30));

                cb.AddTemplate(template, (document.PageSize.Width / 2) + text.Length + 5, document.PageSize.GetBottom(30));

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(30, document.PageSize.GetBottom(30));
                cb.ShowText("DISTRIBUTION ORGINAL TO REENTRY CASE FILE");
                cb.EndText();

                cb.BeginText();
                cb.SetFontAndSize(PatsFont.PatsFontBold, 8);
                cb.SetTextMatrix(document.PageSize.Width / 2 + 70, document.PageSize.GetBottom(30));
                cb.ShowText("California Department of Corrections and Rehabilitation");
                cb.EndText();
            }
        }
    }
}


