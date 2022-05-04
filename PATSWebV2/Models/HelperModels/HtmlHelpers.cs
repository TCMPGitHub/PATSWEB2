using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Web.Routing;

namespace PATSWebV2.Models.HelperModels
{
    public static class HtmlHelpers : Object
    {
        public static IHtmlString NoEncodeActionLink(this HtmlHelper htmlHelper, string linkText, string action, object htmlAttributes)
        {
            TagBuilder builder;
            UrlHelper urlHelper;
            urlHelper = new UrlHelper(htmlHelper.ViewContext.RequestContext);
            builder = new TagBuilder("a");
            builder.InnerHtml = linkText;
            builder.Attributes["href"] = urlHelper.Action(action);
            builder.MergeAttributes(new RouteValueDictionary(htmlAttributes));
            return MvcHtmlString.Create(builder.ToString());
        }


        //    public static MvcHtmlString DisplayAddressFor<TModel, TProperty>(this HtmlHelper<TModel> helper,
        //    Expression<Func<TModel, TProperty>> expression, bool isEditable = false,
        //    object htmlAttributes = null)
        //    {
        //        var valueGetter = expression.Compile();
        //        var model = valueGetter(helper.ViewData.Model) as Address;
        //        var sb = new List<string>();
        //        if (model != null)
        //        {
        //            if (!string.IsNullOrEmpty(model.StreetAddress)) sb.Add(model.StreetAddress);
        //            //if (!string.IsNullOrEmpty(model.StreetAddress2)) sb.Add(model.StreetAddress2);    
        //            if (!string.IsNullOrEmpty(model.City) || !string.IsNullOrEmpty(model.State) ||
        //!string.IsNullOrEmpty(model.ZIPCode)) sb.Add(string.Format("{0}, {1} {2}", model.City,
        //model.State, model.ZIPCode));
        //            if (model.State_lkup != null) sb.Add(model.State_lkup.CountryCode);
        //            //            if (model.Latitude != null || model.Longitude != null) sb.Add(string.Format("{0}, {1}",
        //            //model.Latitude, model.Longitude));    
        //        }
        //        var delimeter = (isEditable) ? Environment.NewLine : "<br />";
        //        var addr = (isEditable) ? new TagBuilder("textarea") : new TagBuilder("address");
        //        addr.MergeAttributes(new System.Web.Routing.RouteValueDictionary(htmlAttributes));
        //        addr.InnerHtml = string.Join(delimeter, sb.ToArray());
        //        return MvcHtmlString.Create(addr.ToString());
        //    }

        public static MvcHtmlString CheckBoxListFor<TModel, TValue>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TValue>> expression) where TValue : IEnumerable<object>
        {
            var name = expression.Body is ParameterExpression ? ((ParameterExpression)expression.Body).Name : ((MemberExpression)expression.Body).Member.Name;
            var sb = new StringBuilder("<ul class='checkboxlist'>");
            var values = ((IEnumerable<object>)expression.Compile().Invoke(htmlHelper.ViewData.Model)).Select(x => x.ToString());
            foreach (var value in values)
            {
                sb.Append(string.Format("<li>{0} <input type='checkbox' name='{1}' value='{2}' /></li>", value, name, value));
            }
            return new MvcHtmlString(sb.Append("</ul>").ToString());
        }
        public static MvcHtmlString CheckBoxListFor<TModel, TItem>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, IEnumerable<TItem>>> listExpression, Func<TItem, object> checkboxName, Func<TItem, object> checkboxValue)
        {
            var listName = listExpression.Body is ParameterExpression ? ((ParameterExpression)listExpression.Body).Name : ((MemberExpression)listExpression.Body).Member.Name;
            var sb = new StringBuilder("<ul class='checkboxlist'>");
            foreach (var value in listExpression.Compile().Invoke(htmlHelper.ViewData.Model))
            {
                sb.Append(string.Format("<li>{0} <input type='checkbox' name='{1}' value='{2}' /></li>", checkboxName.Invoke(value), listName, checkboxValue.Invoke(value)));
            }
            return new MvcHtmlString(sb.Append("</ul>").ToString());
        }

        public static MvcHtmlString CheckBoxListFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, MultiSelectList selectList)
        {
            return CheckBoxListFor<TModel, TProperty>(htmlHelper, expression, selectList, null, 1);
        }

        public static MvcHtmlString CheckBoxListFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, MultiSelectList selectList, int numberOfColumns)
        {
            return CheckBoxListFor<TModel, TProperty>(htmlHelper, expression, selectList, null, numberOfColumns);
        }

        public static MvcHtmlString CheckBoxListFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, MultiSelectList selectList,
            object htmlAttributes, int numberOfColumns)
        {
            return CheckBoxListFor<TModel, TProperty>(htmlHelper, expression, selectList, ((IDictionary<string, object>)new RouteValueDictionary(htmlAttributes)), numberOfColumns);
        }

        public static MvcHtmlString CheckBoxListFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, MultiSelectList selectList,
            IDictionary<string, object> htmlAttributes, string name, int numberOfColumns, string labelWidth)
        {
            //string name = ExpressionHelper.GetExpressionText(expression);
            //name = htmlHelper.ViewContext.ViewData.TemplateInfo.GetFullHtmlFieldName(name);

            // Get the property (and assume IEnumerable)
            IEnumerable currentValues = htmlHelper.ViewData.Model != null
                                            ? (IEnumerable)expression.Compile().Invoke(htmlHelper.ViewData.Model)
                                            : null;

            int columnCount = 0;
            var sb = new StringBuilder();
            foreach (SelectListItem option in selectList)
            {
                columnCount++;
                var builder = new TagBuilder("input");
                if (ShouldItemBeSelected(option, currentValues))
                    builder.MergeAttribute("checked", "checked");

                builder.MergeAttributes<string, object>(htmlAttributes);
                builder.MergeAttribute("type", "checkbox");
                builder.MergeAttribute("value", option.Value);
                builder.MergeAttribute("name", name);
                string style = "font-weight:700;Margin-left:10px;";
                if (columnCount == 1)
                    style = style + "Margin-Top:0px;";
                builder.MergeAttribute("style", style);
                sb.Append(builder.ToString(TagRenderMode.Normal));
                //add label to display text 
                var builder1 = new TagBuilder("Label");
                builder1.MergeAttributes<string, object>(htmlAttributes);
                builder1.MergeAttribute("id", "attendanceId");
                //builder.InnerHtml = option.Text;
                builder1.MergeAttribute("style", "font-weight:700;display:inline-table;Margin-left:5px;width:" + labelWidth);
                builder1.InnerHtml = option.Text;
                sb.Append(builder1.ToString(TagRenderMode.Normal));

                if (columnCount == numberOfColumns)
                {
                    columnCount = 0;
                    sb.Append("<br />");
                }
            }
            return MvcHtmlString.Create(sb.ToString());
        }

        private static bool ShouldItemBeSelected(SelectListItem item, IEnumerable selectedValues)
        {
            bool selected = false;
            if (null != selectedValues)
            {
                var enumerator = selectedValues.ToString().Split(',');
                foreach (var val in enumerator)
                {
                    //var currentValueAsString = (string)Convert.ChangeType(enumerator.Current, typeof(string));
                    selected = item.Value == val ? true : false;
                    if (selected)
                        break;
                }
            }
            return selected;
        }

        public static ModelStateDictionary ClearError(this ModelStateDictionary m, string fieldName)
        {
            if (m.ContainsKey(fieldName))
                m[fieldName].Errors.Clear();
            return m;
        }


        public static MvcHtmlString HtmlActionLink(this AjaxHelper helper, string html, string actionName, string controllerName, object routeValues, AjaxOptions ajaxOptions, object htmlAttributes)
        {
            var link = helper.ActionLink("[replace] ", actionName, controllerName, routeValues, ajaxOptions, htmlAttributes).ToHtmlString();
            return new MvcHtmlString(link.Replace("[replace]", html));
        }
    }
}