/*
* TelerikReporting v13.0.19.222 (http://www.telerik.com/products/reporting.aspx)
* Copyright 2019 Telerik AD. All rights reserved.
*
* Telerik Reporting commercial licenses may be obtained at
* http://www.telerik.com/purchase/license-agreement/reporting.aspx
* If you do not own a commercial license, this file shall be governed by the trial license terms.
*/
(function(window, undefined) {
    "$:nomunge";
    var $ = window.jQuery || window.Cowboy || (window.Cowboy = {}), jq_throttle;
    $.throttle = jq_throttle = function(delay, no_trailing, callback, debounce_mode) {
        var timeout_id, last_exec = 0;
        if (typeof no_trailing !== "boolean") {
            debounce_mode = callback;
            callback = no_trailing;
            no_trailing = undefined;
        }
        function wrapper() {
            var that = this, elapsed = +new Date() - last_exec, args = arguments;
            function exec() {
                last_exec = +new Date();
                callback.apply(that, args);
            }
            function clear() {
                timeout_id = undefined;
            }
            if (debounce_mode && !timeout_id) {
                exec();
            }
            timeout_id && clearTimeout(timeout_id);
            if (debounce_mode === undefined && elapsed > delay) {
                exec();
            } else if (no_trailing !== true) {
                timeout_id = setTimeout(debounce_mode ? clear : exec, debounce_mode === undefined ? delay - elapsed : delay);
            }
        }
        if ($.guid) {
            wrapper.guid = callback.guid = callback.guid || $.guid++;
        }
        return wrapper;
    };
    $.debounce = function(delay, at_begin, callback) {
        return callback === undefined ? jq_throttle(delay, at_begin, false) : jq_throttle(delay, callback, at_begin !== false);
    };
})(window);

(function(trv, $, window, document, undefined) {
    "use strict";
    var stringFormatRegExp = /{(\w+?)}/g;
    var specialKeys = {
        DELETE: 46,
        BACKSPACE: 8,
        TAB: 9,
        ESC: 27,
        LEFT: 37,
        UP: 38,
        RIGHT: 39,
        DOWN: 40,
        END: 35,
        HOME: 36
    };
    function getCheckSpecialKeyFn() {
        var userAgent = window.navigator.userAgent.toLowerCase();
        if (userAgent.indexOf("firefox") > -1) {
            var specialKeysArray = Object.keys(specialKeys);
            var specialKeysLength = specialKeysArray.length;
            return function(keyCode) {
                for (var i = 0; i < specialKeysLength; i++) {
                    if (specialKeys[specialKeysArray[i]] == keyCode) {
                        return true;
                    }
                }
            };
        }
        return function(keyCode) {
            return false;
        };
    }
    var utils = trv.utils = {
        trim: function(s, charlist) {
            return this.rtrim(this.ltrim(s, charlist), charlist);
        },
        replaceAll: function(str, find, replace) {
            return str.replace(new RegExp(find, "g"), replace);
        },
        ltrim: function(s, charlist) {
            if (charlist === undefined) {
                charlist = "s";
            }
            return s.replace(new RegExp("^[" + charlist + "]+"), "");
        },
        rtrim: function(s, charlist) {
            if (charlist === undefined) {
                charlist = "s";
            }
            return s.replace(new RegExp("[" + charlist + "]+$"), "");
        },
        stringFormat: function(template, data) {
            var isArray = Array.isArray(data);
            return template.replace(stringFormatRegExp, function($0, $1) {
                return data[isArray ? parseInt($1) : $1];
            });
        },
        escapeHtml: function(str) {
            return $("<div>").text(str).html();
        },
        isSpecialKey: getCheckSpecialKeyFn(),
        tryParseInt: function(value) {
            if (/^(\-|\+)?([0-9]+)$/.test(value)) {
                return Number(value);
            }
            return NaN;
        },
        tryParseFloat: function(value) {
            if (/^(\-|\+)?([0-9]+(\.[0-9]+)?)$/.test(value)) {
                return Number(value);
            }
            return NaN;
        },
        parseToLocalDate: function(date) {
            if (date instanceof Date) return date;
            var isUtc = /Z|[\+\-]\d\d:?\d\d/i.test(date);
            if (!isUtc) {
                date += "Z";
            }
            return new Date(date);
        },
        adjustTimezone: function(date) {
            return new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds()));
        },
        unadjustTimezone: function(date) {
            return new Date(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds(), date.getUTCMilliseconds());
        },
        areEqual: function(v1, v2) {
            if (v1 instanceof Date && v2 instanceof Date) {
                if (v1.getTime() !== v2.getTime()) {
                    return false;
                }
            } else if (v1 !== v2) {
                return false;
            }
            return true;
        },
        reportSourcesAreEqual: function(rs1, rs2) {
            if (rs1 && rs2 && rs1.report === rs2.report) {
                var params1String = "";
                if (rs1.parameters) {
                    params1String = JSON.stringify(rs1.parameters);
                }
                var params2String = "";
                if (rs2.parameters) {
                    params2String = JSON.stringify(rs2.parameters);
                }
                return params1String === params2String;
            }
            return false;
        },
        areEqualArrays: function(array1, array2) {
            if (array1 === null) {
                if (array2 !== null) {
                    return false;
                } else {
                    return true;
                }
            } else {
                if (array2 === null) {
                    return false;
                }
            }
            if (array1.length !== array2.length) {
                return false;
            }
            for (var j = array1.length - 1; j >= 0; j--) {
                if (!utils.areEqual(array1[j], array2[j])) {
                    return false;
                }
            }
            return true;
        },
        isSvgSupported: function isSvgSupported() {
            var matches = /Version\/(\d+.\d+.\d+) Safari/.exec(navigator.userAgent);
            if (matches && matches.length > 1) {
                var version = parseFloat(matches[1]);
                return version >= 6;
            }
            return true;
        },
        isInvalidClientException: function(xhr) {
            return utils.isExceptionOfType(xhr, "Telerik.Reporting.Services.Engine.InvalidClientException");
        },
        isExceptionOfType: function(xhr, exceptionType) {
            if (!xhr) return false;
            if (!xhr.responseText) return false;
            var json = utils.parseJSON(xhr.responseText);
            if (!json) return false;
            if (!json.exceptionType) return false;
            return json.exceptionType === exceptionType;
        },
        parseJSON: function(json) {
            try {
                return JSON.parse(json, function(key, value) {
                    if (key && value) {
                        var firstChar = key.charAt(0);
                        if (firstChar == firstChar.toUpperCase()) {
                            var newPropertyName = firstChar.toLowerCase() + key.slice(1);
                            this[newPropertyName] = value;
                        }
                    }
                    return value;
                });
            } catch (e) {
                return null;
            }
        },
        extend: function() {
            var src, copy, name, options, target, i = 0, length = arguments.length;
            target = length > 1 ? arguments[i++] || {} : {};
            for (;i < length; i++) {
                if ((options = arguments[i]) != null) {
                    for (name in options) {
                        src = target[name];
                        copy = options[name];
                        if (target === copy) {
                            continue;
                        }
                        if (copy !== undefined) {
                            target[name] = copy;
                        }
                    }
                }
            }
            return target;
        },
        each: function(obj, callback) {
            var length, i = 0;
            if (utils.isArray(obj)) {
                length = obj.length;
                for (;i < length; i++) {
                    if (callback.call(obj[i], i, obj[i]) === false) {
                        break;
                    }
                }
            } else {
                for (i in obj) {
                    if (callback.call(obj[i], i, obj[i]) === false) {
                        break;
                    }
                }
            }
            return obj;
        },
        selector: function() {
            return document.querySelectorAll(arguments[0]);
        },
        isArray: function(obj) {
            if (Array.isArray(obj)) return true;
            var length = !!obj && "length" in obj && obj.length;
            if (typeof length === "number") {
                return true;
            }
            return false;
        },
        loadScript: function(src, done) {
            var js = document.createElement("script");
            js.src = src;
            js.onload = function() {
                done();
            };
            js.onerror = function() {
                done(new Error("Failed to load script " + src));
            };
            document.head.appendChild(js);
        },
        filterUniqueLastOccurance: function(array) {
            function onlyLastUnique(value, index, self) {
                return self.lastIndexOf(value) === index;
            }
            return array.filter(onlyLastUnique);
        },
        logError: function(error) {
            var console = window.console;
            if (console && console.error) {
                console.error(error);
            }
        },
        findElement: function(selectorChain) {
            if (selectorChain.constructor != Array) {
                selectorChain = [ selectorChain ];
            }
            var $area = $(selectorChain[0]);
            for (var i = 1; i < selectorChain.length; i++) {
                $area = $area.find(selectorChain[i]);
            }
            return $area;
        }
    };
    trv.domUtils = function() {
        function toPixels(value) {
            return parseInt(value, 10) || 0;
        }
        return {
            getMargins: function(dom) {
                var $target = $(dom);
                return {
                    left: toPixels($target.css("marginLeft")),
                    right: toPixels($target.css("marginRight")),
                    top: toPixels($target.css("marginTop")),
                    bottom: toPixels($target.css("marginBottom"))
                };
            },
            getPadding: function(dom) {
                var $target = $(dom);
                return {
                    left: toPixels($target.css("paddingLeft")),
                    right: toPixels($target.css("paddingRight")),
                    top: toPixels($target.css("paddingTop")),
                    bottom: toPixels($target.css("paddingBottom"))
                };
            },
            getBorderWidth: function(dom) {
                var $target = $(dom);
                return {
                    left: toPixels($target.css("borderLeftWidth")),
                    right: toPixels($target.css("borderRightWidth")),
                    top: toPixels($target.css("borderTopWidth")),
                    bottom: toPixels($target.css("borderBottomWidth"))
                };
            },
            scale: function(dom, scaleX, scaleY, originX, originY) {
                scaleX = scaleX || 1;
                scaleY = scaleY || 1;
                originX = originX || 0;
                originY = originY || 0;
                var scale = utils.stringFormat("scale({0}, {1})", [ scaleX, scaleY ]), origin = utils.stringFormat("{0} {1}", [ originX, originY ]);
                $(dom).css("transform", scale).css("-moz-transform", scale).css("-ms-transform", scale).css("-webkit-transform", scale).css("-o-transform", scale).css("-moz-transform-origin", origin).css("-webkit-transform-origin", origin).css("-o-transform-origin", origin).css("-ms-transform-origin", origin).css("transform-origin", origin);
            }
        };
    }();
})(window.telerikReportViewer = window.telerikReportViewer || {}, window.jQuery, window, document);

(function(trv) {
    "use strict";
    var sr = {
        controllerNotInitialized: "Controller is not initialized.",
        noReportInstance: "No report instance.",
        missingTemplate: "!obsolete resource!",
        noReport: "No report.",
        noReportDocument: "No report document.",
        missingOrInvalidParameter: "Missing or invalid parameter value. Please input valid data for all parameters.",
        invalidParameter: "Please input a valid value.",
        invalidDateTimeValue: "Please input a valid date.",
        parameterIsEmpty: "Parameter value cannot be empty.",
        cannotValidateType: "Cannot validate parameter of type {type}.",
        loadingFormats: "Loading...",
        loadingReport: "Loading report...",
        preparingDownload: "Preparing document to download. Please wait...",
        preparingPrint: "Preparing document to print. Please wait...",
        errorLoadingTemplates: "Error loading the report viewer's templates. (templateUrl = '{0}').",
        errorServiceUrl: "Cannot access the Reporting REST service. (serviceUrl = '{0}'). Make sure the service address is correct and enable CORS if needed. (https://enable-cors.org)",
        loadingReportPagesInProgress: "Loading...  {0} pages loaded so far...",
        loadedReportPagesComplete: "Done. Total {0} pages loaded.",
        noPageToDisplay: "No page to display.",
        errorDeletingReportInstance: "Error deleting report instance: '{0}'.",
        errorRegisteringViewer: "Error registering the viewer with the service.",
        noServiceClient: "No serviceClient has been specified for this controller.",
        errorRegisteringClientInstance: "Error registering client instance.",
        errorCreatingReportInstance: "Error creating report instance (Report = '{0}').",
        errorCreatingReportDocument: "Error creating report document (Report = '{0}'; Format = '{1}').",
        unableToGetReportParameters: "Unable to get report parameters.",
        errorObtainingAuthenticationToken: "Error obtaining authentication token.",
        clientExpired: "Click 'Refresh' to restore client session.",
        parameterEditorSelectNone: "clear selection",
        parameterEditorSelectAll: "select all",
        parametersAreaPreviewButton: "Preview",
        menuNavigateBackwardText: "Navigate Backward",
        menuNavigateBackwardTitle: "Navigate Backward",
        menuNavigateForwardText: "Navigate Forward",
        menuNavigateForwardTitle: "Navigate Forward",
        menuRefreshText: "Refresh",
        menuRefreshTitle: "Refresh",
        menuFirstPageText: "First Page",
        menuFirstPageTitle: "First Page",
        menuLastPageText: "Last Page",
        menuLastPageTitle: "Last Page",
        menuPreviousPageTitle: "Previous Page",
        menuNextPageTitle: "Next Page",
        menuPageNumberTitle: "Page Number Selector",
        menuDocumentMapTitle: "Toggle Document Map",
        menuParametersAreaTitle: "Toggle Parameters Area",
        menuZoomInTitle: "Zoom In",
        menuZoomOutTitle: "Zoom Out",
        menuPageStateTitle: "Toggle FullPage/PageWidth",
        menuPrintText: "Print...",
        menuContinuousScrollText: "Toggle Continuous Scrolling",
        menuSendMailText: "Send an email",
        menuPrintTitle: "Print",
        menuContinuousScrollTitle: "Toggle Continuous Scrolling",
        menuSendMailTitle: "Send an email",
        menuExportText: "Export",
        menuExportTitle: "Export",
        menuPrintPreviewText: "Toggle Print Preview",
        menuPrintPreviewTitle: "Toggle Print Preview",
        menuSearchText: "Search",
        menuSearchTitle: "Toggle Search",
        menuSideMenuTitle: "Toggle Side Menu",
        sendEmailFromLabel: "From:",
        sendEmailToLabel: "To:",
        sendEmailCCLabel: "CC:",
        sendEmailSubjectLabel: "Subject:",
        sendEmailFormatLabel: "Format:",
        sendEmailSendLabel: "Send",
        sendEmailCancelLabel: "Cancel",
        ariaLabelPageNumberSelector: "Page number selector. Showing page {0} of {1}.",
        ariaLabelPageNumberEditor: "Page number editor",
        ariaLabelExpandable: "Expandable",
        ariaLabelSelected: "Selected",
        ariaLabelParameter: "parameter",
        ariaLabelErrorMessage: "Error message",
        ariaLabelParameterInfo: "Contains {0} options",
        ariaLabelMultiSelect: "Multiselect",
        ariaLabelMultiValue: "Multivalue",
        ariaLabelSingleValue: "Single value",
        ariaLabelParameterDateTime: "DateTime",
        ariaLabelParameterString: "String",
        ariaLabelParameterNumerical: "Numerical",
        ariaLabelParameterBoolean: "Boolean",
        ariaLabelParametersAreaPreviewButton: "Preview the report",
        ariaLabelMainMenu: "Main menu",
        ariaLabelCompactMenu: "Compact menu",
        ariaLabelSideMenu: "Side menu",
        ariaLabelDocumentMap: "Document map area",
        ariaLabelPagesArea: "Report contents area",
        ariaLabelSearchDialogArea: "Search area",
        ariaLabelSendEmailDialogArea: "Send email area",
        ariaLabelSearchDialogStop: "Stop search",
        ariaLabelSearchDialogOptions: "Search options",
        ariaLabelSearchDialogNavigateUp: "Navigate up",
        ariaLabelSearchDialogNavigateDown: "Navigate down",
        ariaLabelSearchDialogMatchCase: "Match case",
        ariaLabelSearchDialogMatchWholeWord: "Match whole word",
        ariaLabelSearchDialogUseRegex: "Use regex",
        ariaLabelMenuNavigateBackward: "Navigate backward",
        ariaLabelMenuNavigateForward: "Navigate forward",
        ariaLabelMenuRefresh: "Refresh",
        ariaLabelMenuFirstPage: "First page",
        ariaLabelMenuLastPage: "Last page",
        ariaLabelMenuPreviousPage: "Previous page",
        ariaLabelMenuNextPage: "Next page",
        ariaLabelMenuPageNumber: "Page number selector",
        ariaLabelMenuDocumentMap: "Toggle document map",
        ariaLabelMenuParametersArea: "Toggle parameters area",
        ariaLabelMenuZoomIn: "Zoom in",
        ariaLabelMenuZoomOut: "Zoom out",
        ariaLabelMenuPageState: "Toggle FullPage/PageWidth",
        ariaLabelMenuPrint: "Print",
        ariaLabelMenuContinuousScroll: "Continuous scrolling",
        ariaLabelMenuSendMail: "Send an email",
        ariaLabelMenuExport: "Export",
        ariaLabelMenuPrintPreview: "Toggle print preview",
        ariaLabelMenuSearch: "Search in report contents",
        ariaLabelMenuSideMenu: "Toggle side menu",
        ariaLabelSendEmailFrom: "From email address",
        ariaLabelSendEmailTo: "Recipient email address",
        ariaLabelSendEmailCC: "Carbon Copy email address",
        ariaLabelSendEmailSubject: "Email subject:",
        ariaLabelSendEmailFormat: "Report format:",
        ariaLabelSendEmailSend: "Send email",
        ariaLabelSendEmailCancel: "Cancel sending email",
        searchDialogTitle: "Search in report contents",
        searchDialogSearchInProgress: "searching...",
        searchDialogNoResultsLabel: "No results",
        searchDialogResultsFormatLabel: "Result {0} of {1}",
        searchDialogStopTitle: "Stop Search",
        searchDialogNavigateUpTitle: "Navigate Up",
        searchDialogNavigateDownTitle: "Navigate Down",
        searchDialogMatchCaseTitle: "Match Case",
        searchDialogMatchWholeWordTitle: "Match Whole Word",
        searchDialogUseRegexTitle: "Use Regex",
        searchDialogCaptionText: "Find",
        sendEmailDialogTitle: "Send Email",
        sendEmailValidationEmailRequired: "Email field is required",
        sendEmailValidationEmailFormat: "Email format is not valid",
        sendEmailValidationSingleEmail: "The field accepts a single email address only",
        sendEmailValidationFormatRequired: "Format field is required",
        errorSendingDocument: "Error sending report document (Report = '{0}')."
    };
    trv.sr = trv.utils.extend(sr, trv.sr);
})(window.telerikReportViewer = window.telerikReportViewer || {});

(function(trv, $, window, document, undefined) {
    "use strict";
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    var Scroll = {
        controller: {},
        $placeholder: null,
        $pageContainer: null,
        pageContainer: null,
        $pageWrapper: null,
        pageWrapper: null,
        viewMode: null,
        loadedPage: {},
        scrollInProgress: false,
        enabled: false,
        pageCount: 0,
        additionalTopOffset: 130,
        pageDistance: 20,
        oldScrollTopPosition: 0,
        skeletonTemplate: '<div class="trv-report-page trv-skeleton-page trv-skeleton-{0}" style="{1}" data-page="{0}">' + '<div class="trv-skeleton-wrapper" style="{2}"></div></div>',
        init: function init(placeholder, options) {
            var that = this;
            that.$placeholder = $("#" + options.viewerSelector).find(placeholder);
            that.$pageContainer = this.$placeholder.find(".trv-page-container");
            that.pageContainer = this.$pageContainer[0];
            that.$pageWrapper = this.$placeholder.find(".trv-page-wrapper");
            that.pageWrapper = this.$pageWrapper[0];
            that.controller = options.controller;
            that.controller.scale(function(e, args) {
                if (this.enabled) {
                    setTimeout(function() {
                        that._loadMorePages();
                        that._keepCurrentPageInToView();
                    }, 100);
                }
            }).onLoadedReportChange(function(args) {
                if (that.enabled) {
                    that.clear();
                    if (args !== "trv.ON_LOADED_REPORT_CHANGE") {
                        setTimeout(function() {
                            that.controller.getPageData(1).then(function(newPage) {
                                that.renderPage(newPage);
                            });
                        });
                    }
                }
            }).viewModeChanged(function(args) {
                if (that.enabled) {
                    that.clear();
                }
            }).interactiveActionExecuting(function(e, args) {
                var actionType = args.action.Type;
                if (that.enabled && (actionType === "sorting" || actionType === "toggleVisibility")) {
                    that.clear();
                }
            }).updatePageDimensionsReady(function(event, args) {
                if (that.enabled && that._currentPageNumber() > 0) {
                    that._keepCurrentPageInToView();
                }
            }).pageCountChange(function(event, args) {
                if (that.enabled && that.pageCount !== args) {
                    if (that._currentPageNumber() > 0 && !that.scrollInProgress) {
                        that._loadMorePages();
                    }
                    if (args > 1) {
                        that._initEvents();
                    }
                    that.pageCount = args;
                }
            });
        },
        isEnabled: function isEnabled() {
            return this.enabled;
        },
        clear: function clear() {
            this.$pageWrapper.empty();
            this.enabled = false;
            this.loadedPage = {}, this.$placeholder.removeClass("scrollable");
        },
        renderPage: function renderPage(page) {
            var that = this, pageViewMode = that.controller.viewMode(), renderedPage = that.$placeholder.find('[data-page="' + page.pageNumber + '"]');
            if (!that.enabled) {
                that.enabled = true;
                that.$placeholder.addClass("scrollable");
                if (pageViewMode !== that.viewMode || !renderedPage.length) {
                    that._updatePageArea(page);
                } else {
                    that._render(page, true);
                    this.$pageContainer.scrollTop(3);
                    that._setCurrentPage(page.pageNumber);
                }
                that.viewMode = that.controller.viewMode();
                that._loadMorePages();
            } else {
                if (pageViewMode !== that.viewMode || !renderedPage.length) {
                    that._updatePageArea(page);
                } else {
                    that._navigateToPage(page, renderedPage);
                }
                that.viewMode = that.controller.viewMode();
            }
        },
        navigateToElement: function navigateToElement(offsetTop, pageNumber) {
            var that = this;
            that.scrollInProgress = true;
            if (that._isSkeletonScreen(null, pageNumber)) {
                that.controller.getPageData(pageNumber).then(function(newPage) {
                    that._render(newPage, false);
                    that.$pageContainer.animate({
                        scrollTop: offsetTop
                    }, 500, function() {
                        that._setCurrentPage(pageNumber);
                        setTimeout(function() {
                            that.scrollInProgress = false;
                        }, 100);
                    });
                });
            } else {
                that.$pageContainer.animate({
                    scrollTop: offsetTop
                }, 500, function() {
                    that._setCurrentPage(pageNumber);
                    setTimeout(function() {
                        that.scrollInProgress = false;
                    }, 100);
                });
            }
        },
        _setCurrentPage: function _setCurrentPage(pageNumber) {
            var that = this;
            if (pageNumber !== that._currentPageNumber()) {
                that.controller.currentPageNumber(pageNumber);
            }
            if (that.controller.pageCount() > 1) {
                that.$placeholder.find(".k-state-default").removeClass("k-state-default");
                that.$placeholder.find('[data-page="' + pageNumber + '"]').addClass("k-state-default");
            }
            that._loadNextPreviousPage(pageNumber);
        },
        _updatePageArea: function _updatePageArea(page) {
            var that = this, scrollTo = 0, pageNumber = page.pageNumber;
            that.scrollInProgress = true;
            if (pageNumber > 1) {
                that._generateSkeletonScreens(pageNumber);
            }
            that._render(page, false);
            that._setCurrentPage(page.pageNumber);
            setTimeout(function() {
                scrollTo = pageNumber > 1 ? that.$placeholder.find('[data-page="' + pageNumber + '"]').position().top : 0;
                that.$pageContainer.animate({
                    scrollTop: scrollTo
                }, 0, function() {
                    that.scrollInProgress = false;
                });
            }, 100);
        },
        _navigateToPage: function _navigateToPage(page, renderedPage) {
            var that = this;
            that.scrollInProgress = true;
            var scrollTo = renderedPage.position().top, pages = that.$placeholder.find(".trv-report-page"), pageNumber = page.pageNumber, pageHeight = $(pages[0]).height();
            if (that._isSkeletonScreen(renderedPage, pageNumber)) {
                that.controller.getPageData(pageNumber).then(function(newPage) {
                    that._render(newPage, false);
                    that.$pageContainer.animate({
                        scrollTop: scrollTo
                    }, 500, function() {
                        setTimeout(function() {
                            _setCurrentPage(newPage.pageNumber);
                            scrollInProgress = false;
                        });
                    });
                });
            } else {
                that._updatePageContent(page, renderedPage);
                that.$pageContainer.animate({
                    scrollTop: scrollTo
                }, 500, function() {
                    setTimeout(function() {
                        _setCurrentPage(page.pageNumber);
                        scrollInProgress = false;
                    });
                });
            }
        },
        _updatePageContent: function _updatePageContent(page, renderedPage) {
            var that = this, pageNumber = page.pageNumber, wrapper = $($.parseHTML(page.pageContent)), $pageContent = wrapper.find("div.sheet"), $page = that.$placeholder.find('<div class="trv-report-page" data-page="' + pageNumber + '"></div>');
            $pageContent.css("margin", 0);
            $page.append($pageContent).append($('<div class="trv-page-overlay"></div>'));
            renderedPage.replaceWith($page);
            that._updatePageStyle(page);
            that.controller.scrollPageReady({
                page: page,
                target: $page
            });
        },
        _currentPageNumber: function _currentPageNumber() {
            return this.controller.currentPageNumber();
        },
        _isSkeletonScreen: function _isSkeletonScreen(page, pageNumber) {
            if (!page) {
                page = this.$placeholder.find('[data-page="' + pageNumber + '"]');
            }
            return page.hasClass("trv-skeleton-" + pageNumber);
        },
        _addSkeletonScreen: function _addSkeletonScreen(pageNumber, position) {
            var that = this, pageStyleNumber = position ? parseInt(pageNumber + 1) : parseInt(pageNumber - 1), pageStyleBaseDom = that.$placeholder.find('[data-page="' + pageStyleNumber + '"]'), pageStyle = pageStyleBaseDom.attr("style"), contentStyle = pageStyleBaseDom.find("sheet").attr("style"), skeletonEl = utils.stringFormat(that.skeletonTemplate, [ pageNumber, pageStyle, contentStyle ]);
            if (position) {
                that.$pageWrapper.prepend(skeletonEl);
            } else {
                that.$pageWrapper.append(skeletonEl);
            }
        },
        _generateSkeletonScreens: function _generateSkeletonScreens(upToPageNumber) {
            var that = this, skeletonEl = "", pageStyleBaseDom = this.$placeholder.find('[data-page="1"]'), pageStyle = pageStyleBaseDom.attr("style"), contentStyle = pageStyleBaseDom.find("sheet").attr("style"), lastPage = that.$placeholder.find(".trv-report-page").last().attr("data-page"), index = lastPage ? parseInt(lastPage) + 1 : 1;
            for (index; index < upToPageNumber; index++) {
                skeletonEl = skeletonEl + utils.stringFormat(that.skeletonTemplate, [ index, pageStyle, contentStyle ]);
            }
            that.$pageWrapper.append($(skeletonEl));
        },
        _loadMorePages: function _loadMorePages() {
            var that = this, pageCount = that.controller.pageCount(), isViewPortBiggerThanPageHeight = that.$pageContainer.innerHeight() > that.$pageWrapper.innerHeight();
            if (pageCount > 1) {
                if (isViewPortBiggerThanPageHeight) {
                    that.scrollInProgress = true;
                    var lastPage = parseInt(that.$placeholder.find(".trv-report-page").last().attr("data-page")), nextPage = lastPage + 1;
                    if (nextPage <= pageCount) {
                        that.controller.getPageData(nextPage).then(function(newPage) {
                            that._render(newPage, false);
                            that._loadMorePages();
                            that.scrollInProgress = false;
                        });
                    }
                } else {
                    that._loadVisiblePages();
                    that.scrollInProgress = false;
                }
            }
        },
        _loadVisiblePages: function _loadVisiblePages() {
            var that = this, pages = that.$placeholder.find(".trv-report-page");
            $.each(pages, function(index, value) {
                var pageItem = $(value), pageNumber = parseInt(pageItem.attr("data-page"));
                if (that._scrolledInToView(pageItem) && that._isSkeletonScreen(pageItem, pageNumber)) {
                    that.controller.getPageData(pageNumber).then(function(newPage) {
                        that._render(newPage, false);
                    });
                }
            });
        },
        _scrolledInToView: function _scrolledInToView(elem) {
            var pageCoords = elem[0].getBoundingClientRect(), parentCoords = elem.closest(".trv-pages-area")[0].getBoundingClientRect(), parentTop = parentCoords.top, parentBottom = parentCoords.top + parentCoords.height, pageTop = pageCoords.top, pageBottom = pageTop + elem.outerHeight(true), additionalTopOffset = this.additionalTopOffset + parentTop, topVisible = pageTop > 0 && pageTop < parentBottom, bottomVisible = pageBottom < parentBottom && pageBottom > additionalTopOffset;
            return topVisible || bottomVisible;
        },
        _render: function _render(page, empty) {
            var that = this, pageNumber = page.pageNumber, pageItem = that.$placeholder.find('[data-page="' + pageNumber + '"]');
            if (!empty && pageItem && pageItem.length && !that._isSkeletonScreen(pageItem, pageNumber)) {
                return;
            }
            var wrapper = $($.parseHTML(page.pageContent)), $pageContent = wrapper.find("div.sheet"), $page = $('<div class="trv-report-page" data-page="' + pageNumber + '"></div>');
            $pageContent.css("margin", 0);
            $page.append($pageContent).append($('<div class="trv-page-overlay"></div>'));
            if (empty) {
                that.$pageWrapper.empty();
            }
            that.$pageWrapper.removeData().data("pageNumber", pageNumber);
            var $skeletonPage = that.$placeholder.find(".trv-skeleton-" + pageNumber);
            if ($skeletonPage.length) {
                $skeletonPage.replaceWith($page);
            } else {
                that.$pageWrapper.append($page);
            }
            that.loadedPage[pageNumber] = page;
            that.controller.scrollPageReady({
                page: page,
                target: $page
            });
            that._updatePageStyle(page);
        },
        _updatePageStyle: function _updatePageStyle(page) {
            var that = this, lastLoadedPage = that.loadedPage[that._lastLoadedPage()], styleId = "trv-" + that.controller.clientId() + "-styles", pageStyles;
            $("#" + styleId).remove();
            pageStyles = $("<style id=" + styleId + "></style>");
            pageStyles.append(lastLoadedPage.pageStyles);
            pageStyles.appendTo("head");
        },
        _lastLoadedPage: function _lastLoadedPage() {
            var that = this, lastKey;
            for (var key in that.loadedPage) {
                if (that.loadedPage.hasOwnProperty(key)) {
                    lastKey = key;
                }
            }
            return lastKey;
        },
        _loadNextPreviousPage: function _loadNextPreviousPage(pageNumber) {
            var that = this, nextPage, previousPage, nextItem, previousItem;
            if (pageNumber < that.controller.pageCount()) {
                nextPage = pageNumber + 1;
                nextItem = that.$placeholder.find('[data-page="' + nextPage + '"]');
            }
            if (pageNumber > 1) {
                previousPage = pageNumber - 1;
                previousItem = that.$placeholder.find('[data-page="' + previousPage + '"]');
            }
            if (previousItem && previousItem.length && that._isSkeletonScreen(previousItem, previousPage)) {
                that.controller.getPageData(previousPage).then(function(newPage) {
                    that._render(newPage, false);
                });
            }
            if (nextItem && nextItem.length && that._isSkeletonScreen(nextItem, nextPage)) {
                that.controller.getPageData(nextPage).then(function(newPage) {
                    that._render(newPage, false);
                });
            }
        },
        _clickPage: function _clickPage(pageDom) {
            var that = this, currentPage = that._currentPageNumber(), pageNumber = parseInt(pageDom.attr("data-page"));
            if (currentPage !== pageNumber) {
                if (that._isSkeletonScreen(pageDom, pageNumber)) {
                    that.controller.getPageData(pageNumber).then(function(newPage) {
                        that._render(newPage, false, true);
                        that._setCurrentPage(newPage.pageNumber);
                    });
                } else {
                    that._setCurrentPage(pageNumber);
                }
            }
        },
        _initEvents: function _initEvents() {
            var that = this;
            that.$pageContainer.off("click", ".trv-report-page").on("click", ".trv-report-page", function(e) {
                that._clickPage($(e.currentTarget));
            });
            that.$pageContainer.off("scroll");
            that.$pageContainer.scroll($.throttle(250, function() {
                var pages = that.$placeholder.find(".trv-report-page"), scrollPosition = parseInt((that.$pageContainer.scrollTop() + that.$pageContainer.innerHeight()).toFixed(0));
                if (!that.scrollInProgress && that.oldScrollTopPosition !== scrollPosition) {
                    if (that.oldScrollTopPosition > scrollPosition) {
                        that._scrollUp(pages);
                    } else {
                        that._scrollDown(pages, scrollPosition);
                    }
                }
                that.oldScrollTopPosition = scrollPosition;
            }));
            that.$pageContainer.scroll($.debounce(250, function() {
                var pages = that.$placeholder.find(".trv-report-page"), scrollPosition = parseInt((that.$pageContainer.scrollTop() + that.$pageContainer.innerHeight()).toFixed(0));
                if (!that.scrollInProgress && pages.length && that.oldScrollTopPosition !== scrollPosition) {
                    that._advanceCurrentPage(pages);
                }
            }));
        },
        _advanceCurrentPage: function _advanceCurrentPage(pages) {
            var that = this;
            var newCurrentPage = that._findNewCurrentPage(pages), pageNumber, currentPageNumber = that._currentPageNumber(), currentPageIsInToView = that._scrolledInToView(that.$placeholder.find('[data-page="' + currentPageNumber + '"]'));
            if (newCurrentPage !== -1) {
                newCurrentPage = $(newCurrentPage);
                pageNumber = parseInt(newCurrentPage.attr("data-page"));
                if (currentPageNumber !== pageNumber && !currentPageIsInToView) {
                    if (that._isSkeletonScreen(newCurrentPage, pageNumber)) {
                        that.controller.getPageData(pageNumber).then(function(newPage) {
                            that._render(newPage, false, true);
                            that._setCurrentPage(newPage.pageNumber);
                        });
                    } else {
                        that._setCurrentPage(pageNumber);
                    }
                }
            } else {
                console.log("Page not found - ", newCurrentPage);
            }
        },
        _findNewCurrentPage: function _findNewCurrentPage(pages) {
            var that = this, middleIndex = Math.floor(pages.length / 2), result = that._findPageInViewPort(middleIndex, pages);
            if (pages.length === 1) {
                return pages[0];
            }
            if (result === 0) {
                return pages[middleIndex];
            } else if (result < 0 && pages.length > 1) {
                return that._findNewCurrentPage(pages.splice(middleIndex, Number.MAX_VALUE));
            } else if (result > 0 && pages.length > 1) {
                return that._findNewCurrentPage(pages.splice(0, middleIndex));
            } else {
                return -1;
            }
        },
        _findPageInViewPort: function _findPageInViewPort(index, pages) {
            var pageItem = this.$placeholder.find(pages[index]), pageCoords = pageItem[0].getBoundingClientRect(), parentCoords = pageItem.closest(".trv-pages-area")[0].getBoundingClientRect(), parentTop = parentCoords.top, parentBottom = parentCoords.top + parentCoords.height, pageTop = pageCoords.top, pageBottom = pageTop + pageItem.outerHeight(true), additionalTopOffset = this.additionalTopOffset + parentTop, isCurentPage = pageTop <= additionalTopOffset && additionalTopOffset < pageBottom;
            if (isCurentPage) {
                return 0;
            }
            if (pageBottom < additionalTopOffset) {
                return -1;
            } else {
                return 1;
            }
        },
        _scrollDown: function _scrollDown(pages, scrollPosition) {
            var that = this;
            if (scrollPosition >= that.pageContainer.scrollHeight) {
                var lastPage = parseInt($(pages[pages.length - 1]).attr("data-page")), nextPage = lastPage + 1;
                if (that._currentPageNumber() < nextPage && nextPage <= that.controller.pageCount()) {
                    that._addSkeletonScreen(nextPage, false);
                    that.controller.getPageData(nextPage).then(function(newPage) {
                        that._render(newPage, false);
                    });
                }
            } else {
                that._advanceCurrentPage(pages);
                that._loadVisiblePages();
            }
        },
        _scrollUp: function _scrollUp(pages) {
            var that = this;
            if (that.$pageContainer.scrollTop() === 0) {
                var firstPage = $(pages[0]), pageNumber = parseInt(firstPage.attr("data-page")), previousPage = pageNumber - 1;
                if (that._currentPageNumber() > previousPage && previousPage >= 1) {
                    that._addSkeletonScreen(previousPage, true);
                    that.controller.getPageData(previousPage).then(function(newPage) {
                        that._render(newPage, false);
                        that.$pageContainer.scrollTop(3);
                    });
                }
            } else {
                that._advanceCurrentPage(pages);
                that._loadVisiblePages();
            }
        },
        _keepCurrentPageInToView: function _keepCurrentPageInToView() {
            var that = this, currentPage = that.$placeholder.find('[data-page="' + that._currentPageNumber() + '"]'), currentPagePosition = currentPage.position().top, currentPageHeight = currentPage.innerHeight(), pageContainerHeight = that.$pageContainer.innerHeight(), emptyView;
            that.scrollInProgress = true;
            if (currentPageHeight < pageContainerHeight) {
                emptyView = (pageContainerHeight - currentPageHeight) / 2;
                currentPagePosition = parseInt(currentPagePosition - emptyView);
            }
            that.$pageContainer.animate({
                scrollTop: currentPagePosition
            }, 0, function() {
                setTimeout(function() {
                    that.scrollInProgress = false;
                }, 100);
            });
        }
    };
    trv.scroll = Scroll;
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, window, document, undefined) {
    "use strict";
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    function IEHelper() {
        function getPdfPlugin() {
            var classIds = [ "AcroPDF.PDF.1", "PDF.PdfCtrl.6", "PDF.PdfCtrl.5" ];
            var plugin = null;
            utils.each(classIds, function(index, classId) {
                try {
                    plugin = new ActiveXObject(classId);
                    if (plugin) {
                        return false;
                    }
                } catch (ex) {}
            });
            return plugin;
        }
        return {
            hasPdfPlugin: function() {
                return getPdfPlugin() !== null;
            }
        };
    }
    function FirefoxHelper() {
        function hasPdfPlugin() {
            var matches = /Firefox[\/\s](\d+\.\d+)/.exec(navigator.userAgent);
            if (null !== matches && matches.length > 1) {
                var version = parseFloat(matches[1]);
                if (version >= 19) {
                    return false;
                }
            }
            var pdfPlugins = navigator.mimeTypes["application/pdf"];
            var pdfPlugin = pdfPlugins !== null ? pdfPlugins.enabledPlugin : null;
            if (pdfPlugin) {
                var description = pdfPlugin.description;
                return description.indexOf("Adobe") !== -1 && (description.indexOf("Version") === -1 || parseFloat(description.split("Version")[1]) >= 6);
            }
            return false;
        }
        return {
            hasPdfPlugin: function() {
                return hasPdfPlugin();
            }
        };
    }
    function ChromeHelper() {
        function hasPdfPlugin() {
            var navPlugins = navigator.plugins;
            var found = false;
            utils.each(navPlugins, function(key, value) {
                if (navPlugins[key].name === "Chrome PDF Viewer" || navPlugins[key].name === "Adobe Acrobat") {
                    found = true;
                    return false;
                }
            });
            return found;
        }
        return {
            hasPdfPlugin: function() {
                return hasPdfPlugin();
            }
        };
    }
    function SafariHelper() {
        function hasPdfPlugin() {
            var navPlugins = navigator.plugins;
            var found = false;
            utils.each(navPlugins, function(key, value) {
                if (navPlugins[key].name === "WebKit built-in PDF" || navPlugins[key].name === "Adobe Acrobat") {
                    found = true;
                    return false;
                }
            });
            return found;
        }
        return {
            hasPdfPlugin: function() {
                return hasPdfPlugin();
            }
        };
    }
    function OtherBrowserHelper() {
        return {
            hasPdfPlugin: function() {
                return false;
            }
        };
    }
    function selectBrowserHelper() {
        if (window.navigator) {
            var userAgent = window.navigator.userAgent.toLowerCase();
            if (userAgent.indexOf("msie") > -1 || userAgent.indexOf("mozilla") > -1 && userAgent.indexOf("trident") > -1) return IEHelper(); else if (userAgent.indexOf("firefox") > -1) return FirefoxHelper(); else if (userAgent.indexOf("chrome") > -1) return ChromeHelper(); else if (userAgent.indexOf("safari") > -1) return SafariHelper(); else return OtherBrowserHelper();
        }
        return null;
    }
    var helper = selectBrowserHelper();
    var hasPdfPlugin = helper ? helper.hasPdfPlugin() : false;
    trv.printManager = function() {
        var iframe;
        function printDesktop(src) {
            if (!iframe) {
                iframe = document.createElement("IFRAME");
                iframe.style.display = "none";
            }
            iframe.src = src;
            document.body.appendChild(iframe);
        }
        function printMobile(src) {
            window.open(src, "_self");
        }
        var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
        var printFunc = isMobile ? printMobile : printDesktop;
        return {
            print: function(src) {
                printFunc(src);
            },
            getDirectPrintState: function() {
                return hasPdfPlugin;
            }
        };
    }();
})(window.telerikReportViewer = window.telerikReportViewer || {}, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    var defaultOptions = {};
    function SendEmail(placeholder, options, otherOptions) {
        options = $.extend({}, defaultOptions, options);
        var controller = options.controller, initialized = false, viewerOptions = otherOptions, dialogVisible = false, $placeholder, $sendFormPlaceholder, kendoSendEmailDialog, selector = viewerOptions.viewerSelector, inputFrom, inputTo, inputCC, inputSubject, docFormat, docFormatEl, bodyEditorEl, bodyEditor, docFormatList, optionsCommandSet, windowLocation, reportViewerWrapper = $("#" + selector).find(".trv-report-viewer");
        if (!controller) {
            throw "No controller (telerikReporting.ReportViewerController) has been specified.";
        }
        if (!otherOptions.sendEmail || !otherOptions.sendEmail.enabled) {
            var toolbarSendEmailItem = $(".k-menu").find("a[data-command='telerik_ReportViewer_toggleSendEmailDialog']").closest(".k-item ");
            toolbarSendEmailItem.hide();
            return;
        }
        controller.getSendEmailDialogState(function(event, args) {
            args.visible = dialogVisible;
        }).setSendEmailDialogVisible(function(event, args) {
            toggle(args.visible);
        }).setSearchDialogVisible(function(event, args) {
            if (args.visible && dialogVisible) {
                toggle(!dialogVisible);
            }
        }).beginLoadReport(closeAndClear).viewModeChanged(closeAndClear);
        controller.getDocumentFormats().then(function(formats) {
            docFormatList = formats;
        });
        function closeAndClear() {
            toggle(false);
        }
        function toggle(show) {
            dialogVisible = show;
            if (show) {
                ensureInitialized();
                setDefaultValues(otherOptions.sendEmail);
                kendoSendEmailDialog.open();
            } else {
                if (kendoSendEmailDialog && kendoSendEmailDialog.options.visible) {
                    kendoSendEmailDialog.close();
                }
            }
        }
        function getBody() {
            return bodyEditor ? bodyEditor.value() : bodyText.val();
        }
        function ensureInitialized() {
            if (!initialized) {
                $placeholder = $(placeholder);
                inputFrom = $placeholder.find("[name='from']");
                inputTo = $placeholder.find("[name='to']");
                inputCC = $placeholder.find("[name='cc']");
                inputSubject = $placeholder.find("[name='subject']");
                docFormatEl = $placeholder.find("[name='format']");
                bodyEditorEl = $placeholder.find("textarea");
                setAttrs();
                initCommands();
                replaceStringResources($placeholder);
                kendoSendEmailDialog = reportViewerWrapper.find(".trv-send-email-window").kendoWindow({
                    title: sr.sendEmailDialogTitle,
                    minWidth: 350,
                    minHeight: 350,
                    maxHeight: 900,
                    modal: true,
                    close: function() {
                        storeDialogPosition();
                        clearValidation();
                    },
                    open: function() {
                        adjustDialogSize();
                        adjustDialogPosition();
                    },
                    deactivate: function() {
                        controller.setSendEmailDialogVisible({
                            visible: false
                        });
                    },
                    activate: function() {
                        kendoSendEmailDialog.wrapper.find(".trv-send-email-fields input[type='email']:visible").first().focus();
                        setTimeout(function() {
                            setValidation();
                        }, 250);
                    }
                }).data("kendoWindow");
                kendoSendEmailDialog.wrapper.addClass("trv-send-email");
                docFormat = docFormatEl.kendoComboBox({
                    dataTextField: "localizedName",
                    dataValueField: "name",
                    dataSource: docFormatList || [],
                    filter: "startswith",
                    dataBound: function() {
                        this.select(0);
                        this.trigger("change");
                    }
                }).data("kendoComboBox");
                $placeholder.on("keydown", '[name="format_input"]', function(e) {
                    var tabkey = 9;
                    if (e.keyCode === tabkey && bodyEditor) {
                        setTimeout(function() {
                            bodyEditor.focus();
                        });
                    }
                });
                bodyEditor = bodyEditorEl.kendoEditor({
                    tools: [ "bold", "italic", "underline", "strikethrough", "justifyLeft", "justifyCenter", "justifyRight", "justifyFull", "insertUnorderedList", "insertOrderedList", "indent", "outdent", "createLink", "unlink", "cleanFormatting", "formatting", "fontName", "fontSize", "foreColor", "backColor", "subscript", "superscript" ]
                }).data("kendoEditor");
                setDefaultValues(otherOptions.sendEmail);
                initialized = true;
            }
        }
        $(window).resize(function() {
            if (kendoSendEmailDialog && kendoSendEmailDialog.options.visible) {
                storeDialogPosition();
                adjustDialogSize();
                adjustDialogPosition();
            }
        });
        function setAttrs() {
            $placeholder.find(".trv-send-email-field input").each(function() {
                var el = $(this), attrName = el.attr("name");
                el.attr("id", selector + "-" + attrName);
            });
            $placeholder.find(".trv-send-email-label label").each(function() {
                var el = $(this), attrName = el.attr("for");
                el.attr("for", selector + "-" + attrName);
            });
        }
        function storeDialogPosition() {
            var kendoWindow = kendoSendEmailDialog.element.parent(".k-window");
            windowLocation = kendoWindow.offset();
        }
        function adjustDialogSize() {
            var kendoWindow = kendoSendEmailDialog.element.parent(".k-window"), windowWidth = $(window).width(), kendoWindowWidth = 350;
            if (windowWidth > 800) {
                kendoWindowWidth = 720;
            }
            kendoWindow.css({
                width: kendoWindowWidth
            });
            kendoSendEmailDialog.refresh({
                width: kendoWindowWidth
            });
        }
        function adjustDialogPosition() {
            if (!windowLocation) {
                kendoSendEmailDialog.center();
            } else {
                var padding = 10, windowWidth = $(window).innerWidth(), windowHeight = $(window).innerHeight(), kendoWindow = kendoSendEmailDialog.wrapper, width = kendoWindow.outerWidth(true), height = kendoWindow.outerHeight(true), left = windowLocation.left, top = windowLocation.top, right = left + width, bottom = top + height;
                if (right > windowWidth - padding) {
                    left = Math.max(padding, windowWidth - width - padding);
                    kendoWindow.css({
                        left: left
                    });
                }
                if (bottom > windowHeight - padding) {
                    top = Math.max(padding, windowHeight - height - padding);
                    kendoWindow.css({
                        top: top
                    });
                }
            }
        }
        var commandNames = {
            Send: "sendEmail_Send",
            Cancel: "sendEmail_Cancel"
        };
        function initCommands() {
            optionsCommandSet = {
                sendEmail_Cancel: new command(function() {
                    closeWindow();
                }),
                sendEmail_Send: new command(function(e) {
                    sendingEmail();
                })
            };
            var binder = trv.binder;
            binder.bind($placeholder.find(".trv-send-email-actions"), {
                controller: controller,
                commands: optionsCommandSet
            }, viewerOptions);
        }
        function sendingEmail(cmd, args) {
            var sendEmailArgs = {
                from: inputFrom.val(),
                to: inputTo.val(),
                cc: inputCC.val(),
                subject: inputSubject.val(),
                format: docFormat.value(),
                body: getBody(),
                deviceInfo: {}
            };
            if (validateFields()) {
                controller.sendReport(sendEmailArgs);
                closeWindow();
            }
        }
        function setValidation() {
            inputFrom.off("blur").on("blur", function(e) {
                if (!isEmpty($(this))) {
                    isValidEmail($(this), false);
                }
            });
            inputTo.off("blur").on("blur", function(e) {
                if (!isEmpty($(this))) {
                    isValidEmail($(this), true);
                }
            });
            inputCC.off("blur").on("blur", function(e) {
                if ($(this).val().length) {
                    isValidEmail($(this), true);
                } else {
                    hideError($(this));
                }
            });
        }
        function validateFields() {
            var fromIsValid = isEmpty(inputFrom) || !isValidEmail(inputFrom, false), toIsValid = isEmpty(inputTo) || !isValidEmail(inputTo, true), ccIsValid = inputCC.val().length && !isValidEmail(inputCC, true), hasFormat = docFormat.value().length;
            if (!hasFormat) {
                showError(docFormatEl, "data-required-msg");
            }
            if (fromIsValid || toIsValid || ccIsValid || !hasFormat) {
                return false;
            }
            return true;
        }
        function setDefaultValues(sendEmail) {
            inputFrom.val(sendEmail && sendEmail.from || "");
            inputTo.val(sendEmail && sendEmail.to || "");
            inputCC.val(sendEmail && sendEmail.cc || "");
            inputSubject.val(sendEmail && sendEmail.subject || "");
            if (sendEmail && sendEmail.format) {
                docFormat.value(sendEmail.format);
            } else {
                docFormat.select(0);
            }
            docFormat.trigger("change");
            bodyEditor.value(sendEmail && sendEmail.body || "");
        }
        function isEmpty($el) {
            if (!$el.val().length) {
                showError($el, "data-required-msg");
                return true;
            }
            hideError($el);
            return false;
        }
        function showError($el, tag) {
            var validationMsg = sr[$el.attr(tag)];
            $('[data-for="' + $el.attr("name") + '"]').addClass("-visible").html(validationMsg);
        }
        function hideError($el) {
            $('[data-for="' + $el.attr("name") + '"]').removeClass("-visible");
        }
        function isValidEmail($el, moreThenOneEmail) {
            var inputValue = $el.val();
            if (moreThenOneEmail) {
                var listEmailsAddress = inputValue.split(/[\s,;]+/);
                for (var i = 0; i < listEmailsAddress.length; i++) {
                    if (!_validateEmail(listEmailsAddress[i].trim(), $el)) {
                        return false;
                    }
                }
                return true;
            } else {
                return _validateEmail(inputValue, $el);
            }
        }
        function _validateEmail(email, $el) {
            var regexEmail = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
            if (email.indexOf(",") > -1 || email.indexOf(";") > -1) {
                showError($el, "data-single-email-msg");
                return false;
            }
            if (!regexEmail.test(email)) {
                showError($el, "data-email-msg");
                return false;
            }
            return true;
        }
        function closeWindow() {
            kendoSendEmailDialog.close();
        }
        function clearValidation() {
            $(".k-invalid-msg").removeClass("-visible");
        }
        function replaceStringResources($sendEmailDialog) {
            if (!$sendEmailDialog) {
                return;
            }
            var labels = $sendEmailDialog.find(".trv-replace-string"), ariaLabel = $sendEmailDialog.find("[aria-label]"), titles = $sendEmailDialog.find("[title]");
            if (labels.length) {
                $.each(labels, function(key, value) {
                    replaceText($(value));
                });
            }
            if (ariaLabel.length) {
                $.each(ariaLabel, function(key, value) {
                    replaceAttribute($(value), "aria-label");
                });
            }
            if (titles.length) {
                $.each(titles, function(key, value) {
                    replaceAttribute($(value), "title");
                });
            }
        }
        function replaceText($el) {
            if ($el) {
                $el.text(sr[$el.text()]);
            }
        }
        function replaceAttribute($el, attribute) {
            if ($el) {
                $el.attr(attribute, sr[$el.attr(attribute)]);
            }
        }
        function command(execCallback) {
            var enabledState = true;
            var checkedState = false;
            var cmd = {
                enabled: function(state) {
                    if (arguments.length === 0) {
                        return enabledState;
                    }
                    var newState = Boolean(state);
                    enabledState = newState;
                    $(this).trigger("enabledChanged");
                    return cmd;
                },
                checked: function(state) {
                    if (arguments.length === 0) {
                        return checkedState;
                    }
                    var newState = Boolean(state);
                    checkedState = newState;
                    $(this).trigger("checkedChanged");
                    return cmd;
                },
                exec: execCallback
            };
            return cmd;
        }
    }
    var pluginName = "telerik_ReportViewer_SendEmail";
    $.fn[pluginName] = function(options, otherOptions) {
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new SendEmail(this, options, otherOptions));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, undefined) {
    "use strict";
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReporting.utils";
    }
    var JSON_MIME_TYPE = "application/json", JSON_CONTENT_TYPE = "application/json; charset=UTF-8", URLENCODED_CONTENT_TYPE = "application/x-www-form-urlencoded; charset=UTF-8", HTTP_GET = "GET", HTTP_POST = "POST", HTTP_PUT = "PUT", HTTP_DELETE = "DELETE";
    var defaultOptions = {};
    trv.ServiceClient = function(options) {
        options = utils.extend({}, defaultOptions, options);
        var baseUrl = utils.rtrim(options.serviceUrl || options.baseUrl, "\\/"), loginPromise;
        var _ajax = $ajax;
        function validateClientID(clientID) {
            if (!clientID) throw "Invalid cliendID";
        }
        function urlFromTemplate(template, args) {
            args = utils.extend({}, {
                baseUrl: baseUrl
            }, args);
            return utils.stringFormat(template, args);
        }
        function getHeaderSettings(authorizationToken) {
            return authorizationToken ? {
                headers: {
                    Authorization: "Bearer " + authorizationToken
                }
            } : {};
        }
        function login() {
            if (!loginPromise) {
                var loginInfo = options.loginInfo;
                if (loginInfo && loginInfo.url && (loginInfo.username || loginInfo.password)) {
                    loginPromise = _ajax({
                        url: loginInfo.url,
                        type: HTTP_POST,
                        data: {
                            grant_type: "password",
                            username: loginInfo.username,
                            password: loginInfo.password
                        },
                        dataType: "json",
                        contentType: URLENCODED_CONTENT_TYPE
                    }).then(function(result) {
                        return result.access_token;
                    });
                } else {
                    loginPromise = Promise.resolve();
                }
            }
            return loginPromise;
        }
        function $ajax(ajaxSettings) {
            return new Promise(function(resolve, reject) {
                $.ajax(ajaxSettings).done(function(data) {
                    return resolve(data);
                }).fail(function(xhr, status, error) {
                    reject(toXhrErrorData(xhr, status, error));
                });
            });
        }
        function toXhrErrorData(xhr, status, error) {
            return {
                xhr: xhr,
                status: status,
                error: error
            };
        }
        return {
            _urlFromTemplate: urlFromTemplate,
            registerClient: function(settings) {
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_POST,
                        url: urlFromTemplate("{baseUrl}/clients"),
                        dataType: "json",
                        data: JSON.stringify({
                            timeStamp: Date.now()
                        })
                    });
                    return _ajax(ajaxSettings);
                }).then(function(clientData) {
                    return clientData.clientId;
                });
            },
            unregisterClient: function(clientID, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_DELETE,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}", {
                            clientID: clientID
                        })
                    });
                    return _ajax(ajaxSettings);
                });
            },
            getParameters: function(clientID, report, parameterValues, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_POST,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/parameters", {
                            clientID: clientID
                        }),
                        contentType: JSON_CONTENT_TYPE,
                        dataType: "json",
                        data: JSON.stringify({
                            report: report,
                            parameterValues: parameterValues
                        })
                    });
                    return _ajax(ajaxSettings);
                });
            },
            createReportInstance: function(clientID, report, parameterValues, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_POST,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances", {
                            clientID: clientID
                        }),
                        contentType: JSON_CONTENT_TYPE,
                        dataType: "json",
                        data: JSON.stringify({
                            report: report,
                            parameterValues: parameterValues
                        })
                    });
                    return _ajax(ajaxSettings);
                }).then(function(instanceData) {
                    return instanceData.instanceId;
                });
            },
            deleteReportInstance: function(clientID, instanceID, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_DELETE,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}", {
                            clientID: clientID,
                            instanceID: instanceID
                        })
                    });
                    return _ajax(ajaxSettings);
                });
            },
            createReportDocument: function(clientID, instanceID, format, deviceInfo, useCache, baseDocumentID, actionID, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    deviceInfo = deviceInfo || {};
                    deviceInfo["BasePath"] = baseUrl;
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_POST,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents", {
                            clientID: clientID,
                            instanceID: instanceID
                        }),
                        contentType: JSON_CONTENT_TYPE,
                        dataType: "json",
                        data: JSON.stringify({
                            format: format,
                            deviceInfo: deviceInfo,
                            useCache: useCache,
                            baseDocumentID: baseDocumentID,
                            actionID: actionID
                        })
                    });
                    return _ajax(ajaxSettings);
                }).then(function(documentData) {
                    return documentData.documentId;
                });
            },
            sendDocument: function(clientID, instanceID, documentID, mailArgs, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_POST,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents/{documentID}/send", {
                            clientID: clientID,
                            instanceID: instanceID,
                            documentID: documentID
                        }),
                        contentType: JSON_CONTENT_TYPE,
                        data: JSON.stringify({
                            from: mailArgs.from,
                            to: mailArgs.to,
                            cc: mailArgs.cc,
                            subject: mailArgs.subject,
                            body: mailArgs.body
                        })
                    });
                    return _ajax(ajaxSettings);
                });
            },
            deleteReportDocument: function(clientID, instanceID, documentID, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_DELETE,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents/{documentID}", {
                            clientID: clientID,
                            instanceID: instanceID,
                            documentID: documentID
                        })
                    });
                    return _ajax(ajaxSettings);
                });
            },
            getDocumentInfo: function(clientID, instanceID, documentID, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_GET,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents/{documentID}/info", {
                            clientID: clientID,
                            instanceID: instanceID,
                            documentID: documentID
                        }),
                        dataType: "json"
                    });
                    return _ajax(ajaxSettings);
                });
            },
            getPage: function(clientID, instanceID, documentID, pageNumber, settings) {
                validateClientID(clientID);
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_GET,
                        url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents/{documentID}/pages/{pageNumber}", {
                            clientID: clientID,
                            instanceID: instanceID,
                            documentID: documentID,
                            pageNumber: pageNumber
                        }),
                        dataType: "json"
                    });
                    return _ajax(ajaxSettings);
                });
            },
            get: function(url) {
                var ajaxSettings = {
                    type: HTTP_GET,
                    url: url
                };
                return _ajax(ajaxSettings);
            },
            formatDocumentUrl: function(clientID, instanceID, documentID, queryString) {
                var url = urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents/{documentID}", {
                    clientID: clientID,
                    instanceID: instanceID,
                    documentID: documentID
                });
                if (queryString) {
                    url += "?" + queryString;
                }
                return url;
            },
            getDocumentFormats: function(settings) {
                var ajaxSettings = utils.extend({}, settings, {
                    type: HTTP_GET,
                    url: urlFromTemplate("{baseUrl}/formats"),
                    dataType: "json"
                });
                return _ajax(ajaxSettings);
            },
            getResource: function(clientID, instanceID, documentID, resourceID, settings) {
                validateClientID(clientID);
                var ajaxSettings = utils.extend({}, settings, {
                    type: HTTP_GET,
                    url: urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents/{documentID}/resources/{resourceID}", {
                        clientID: clientID,
                        instanceID: instanceID,
                        documentID: documentID,
                        resourceID: resourceID
                    }),
                    dataType: "json"
                });
                return _ajax(ajaxSettings);
            },
            getSearchResults: function(clientID, instanceID, documentID, searchToken, matchCase, matchWholeWord, useRegex, settings) {
                validateClientID(clientID);
                var searchUrl = urlFromTemplate("{baseUrl}/clients/{clientID}/instances/{instanceID}/documents/{documentID}/search", {
                    clientID: clientID,
                    instanceID: instanceID,
                    documentID: documentID
                });
                return login().then(function(authorizationToken) {
                    var ajaxSettings = utils.extend(getHeaderSettings(authorizationToken), settings, {
                        type: HTTP_POST,
                        url: searchUrl,
                        contentType: JSON_CONTENT_TYPE,
                        dataType: "json",
                        data: JSON.stringify({
                            searchToken: searchToken,
                            matchCase: matchCase,
                            matchWholeWord: matchWholeWord,
                            useRegularExpressions: useRegex
                        })
                    });
                    return _ajax(ajaxSettings);
                });
            },
            setAccessToken: function(accessToken) {
                loginPromise = Promise.resolve(accessToken);
            },
            login: login
        };
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery);

(function(trv, window, document, undefined) {
    "use strict";
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    var printManager = trv.printManager;
    if (!printManager) {
        throw "Missing telerikReportViewer.printManager";
    }
    trv.ViewModes = {
        INTERACTIVE: "INTERACTIVE",
        PRINT_PREVIEW: "PRINT_PREVIEW"
    };
    trv.PrintModes = {
        AUTO_SELECT: "AUTO_SELECT",
        FORCE_PDF_PLUGIN: "FORCE_PDF_PLUGIN",
        FORCE_PDF_FILE: "FORCE_PDF_FILE"
    };
    trv.PageModes = {
        SINGLE_PAGE: "SINGLE_PAGE",
        CONTINUOUS_SCROLL: "CONTINUOUS_SCROLL"
    };
    trv.ParameterEditorTypes = {
        COMBO_BOX: "COMBO_BOX",
        LIST_VIEW: "LIST_VIEW"
    };
    var defaultOptions = {
        pagePollIntervalMs: 500,
        documentInfoPollIntervalMs: 2e3
    };
    function ReportViewerController(options) {
        var controller = {}, clientId, reportInstanceId, reportDocumentId, registerClientPromise, registerInstancePromise, documentFormatsPromise, report, parameterValues, currentPageNumber, pageCount, viewMode = trv.ViewModes.INTERACTIVE, pageMode = trv.PageModes.CONTINUOUS_SCROLL, loader, printMode = trv.PrintModes.AUTO_SELECT, bookmarkNodes, clientHasExpired = false, parameterValidators = trv.parameterValidators, events = new Events();
        clearReportState();
        options = utils.extend({}, defaultOptions, options);
        if (options.settings.printMode) {
            printMode = options.settings.printMode();
        }
        var client = options.serviceClient;
        if (!client) {
            throw sr.noServiceClient;
        }
        clientId = options.settings.clientId();
        function setClientId(id) {
            clientId = id;
            options.settings.clientId(clientId);
        }
        function clearClientId() {
            clientId = null;
            registerClientPromise = null;
            options.settings.clientId(null);
        }
        function getFormat() {
            if (viewMode === trv.ViewModes.PRINT_PREVIEW) {
                return "HTML5";
            }
            return "HTML5Interactive";
        }
        function handleRequestError(xhrData, localizedMessage, suppressErrorBubbling) {
            if (utils.isInvalidClientException(xhrData.xhr)) {
                onClientExpired();
            }
            raiseError(formatXhrError(xhrData.xhr, xhrData.status, xhrData.error, localizedMessage));
            if (!suppressErrorBubbling) {
                throw "Error shown. Throwing promises chain stop error.";
            }
        }
        function initializeClientAsync() {
            if (!registerClientPromise) {
                registerClientPromise = client.registerClient().catch(function(xhrErrorData) {
                    handleRequestError(xhrErrorData, sr.errorRegisteringViewer);
                }).then(function(clientId) {
                    setClientId(clientId);
                }).catch(clearClientId);
            }
            return registerClientPromise;
        }
        function registerInstanceAsync() {
            if (!registerInstancePromise) {
                registerInstancePromise = createReportInstanceAsync(report, parameterValues).then(function(instanceId) {
                    reportInstanceId = instanceId;
                });
                registerInstancePromise.catch(function(errorMessage) {
                    registerInstancePromise = null;
                });
            }
            return registerInstancePromise;
        }
        function clearReportState() {
            reportDocumentId = null;
            reportInstanceId = null;
            registerInstancePromise = null;
            currentPageNumber = pageCount = 0;
        }
        function formatError(args) {
            var len = args.length;
            if (len === 1) {
                return args[0];
            }
            if (len > 1) {
                return utils.stringFormat(args[0], Array.prototype.slice.call(args, 1));
            }
            return "";
        }
        function raiseError() {
            var error = formatError(arguments);
            controller.error(error);
        }
        function createReportInstanceAsync(report, parameterValues) {
            throwIfNotInitialized();
            return client.createReportInstance(clientId, report, parameterValues).catch(function(xhrErrorData) {
                handleRequestError(xhrErrorData, utils.stringFormat(sr.errorCreatingReportInstance, [ utils.escapeHtml(report) ]));
            });
        }
        function registerDocumentAsync(format, deviceInfo, useCache, baseDocumentId, actionId) {
            throwIfNotInitialized();
            throwIfNoReportInstance();
            return client.createReportDocument(clientId, reportInstanceId, format, deviceInfo, useCache, baseDocumentId, actionId).catch(function(xhrErrorData) {
                handleRequestError(xhrErrorData, utils.stringFormat(sr.errorCreatingReportDocument, [ utils.escapeHtml(report), utils.escapeHtml(format) ]));
            });
        }
        function sendDocumentAsync(documentId, args) {
            throwIfNotInitialized();
            throwIfNoReportInstance();
            return client.sendDocument(clientId, reportInstanceId, documentId, args).catch(function(xhrErrorData) {
                handleRequestError(xhrErrorData, utils.stringFormat(sr.errorSendingDocument, [ utils.escapeHtml(report) ]));
            });
        }
        function getDocumentInfoRecursive(clientId, instanceId, documentId, options) {
            if (instanceId === reportInstanceId) {
                return client.getDocumentInfo(clientId, instanceId, documentId).catch(handleRequestError).then(function(info) {
                    if (info && info.documentReady) {
                        return info;
                    } else {
                        info["promise"] = new Promise(function(resolve, reject) {
                            window.setTimeout(resolve, options.documentInfoPollIntervalMs);
                        }).then(function() {
                            return getDocumentInfoRecursive(clientId, instanceId, documentId, options);
                        });
                        return info;
                    }
                });
            } else {
                return Promise.reject();
            }
        }
        function ReportLoader(reportHost, useCache, baseDocumentId, actionId) {
            var loaderOptions = {};
            function onReportDocumentRegistered(id) {
                if (reportHost) {
                    reportDocumentId = id;
                    onBeginLoadReport();
                    getReportDocumentReady();
                }
            }
            function onBeforeLoadReport(args) {
                loaderOptions.documentInfoPollIntervalMs = options.pagePollIntervalMs;
                if (reportHost) {
                    reportHost.beforeLoadReport(args);
                }
            }
            function onBeginLoadReport() {
                if (reportHost) {
                    reportHost.beginLoadReport();
                }
            }
            function onReportLoadComplete(info) {
                if (reportHost) {
                    reportHost.onReportLoadComplete(info);
                }
            }
            function onReportLoadProgress(info) {
                if (reportHost) {
                    pageCount = info.pageCount;
                    reportHost.reportLoadProgress(info);
                }
            }
            function getReportDocumentReady() {
                throwIfNotInitialized();
                throwIfNoReportInstance();
                throwIfNoReportDocument();
                progressReportDocumentReady(getDocumentInfoRecursive(clientId, reportInstanceId, reportDocumentId, loaderOptions));
            }
            function progressReportDocumentReady(getDocumentReadyPromise) {
                getDocumentReadyPromise.then(function(info) {
                    if (info.documentReady) {
                        onReportLoadComplete(info);
                    } else {
                        onReportLoadProgress(info);
                        progressReportDocumentReady(info.promise);
                    }
                });
            }
            function onError() {
                if (reportHost) {
                    reportHost.raiseError.apply(this, arguments);
                }
            }
            function getPageAsync(pageNo) {
                return new Promise(function(resolve, reject) {
                    var fn = function() {
                        client.getPage(clientId, reportInstanceId, reportDocumentId, pageNo).catch(handleRequestError).then(function(pageInfo) {
                            if (pageInfo.pageReady) {
                                resolve(pageInfo);
                            } else {
                                window.setTimeout(fn, options.pagePollIntervalMs);
                            }
                        });
                    };
                    fn();
                });
            }
            function onBeginLoadPage(pageNo) {
                if (reportHost) {
                    reportHost.beginLoadPage(pageNo);
                }
            }
            var loadPromise;
            function loadAsync() {
                if (!loadPromise) {
                    var format = getFormat();
                    var deviceInfo = createPreviewDeviceInfo();
                    onBeforeLoadReport({
                        deviceInfo: deviceInfo
                    });
                    loadPromise = initializeClientAsync().then(registerInstanceAsync).then(function() {
                        return registerDocumentAsync(format, deviceInfo, useCache, baseDocumentId, actionId);
                    }).then(onReportDocumentRegistered);
                }
                return loadPromise;
            }
            function createPreviewDeviceInfo() {
                var deviceInfo = createDeviceInfo();
                deviceInfo.ContentOnly = true;
                deviceInfo.UseSVG = utils.isSvgSupported();
                return deviceInfo;
            }
            return {
                beginLoad: function() {
                    loadAsync();
                },
                beginGetPage: function(pageNo) {
                    throwIfNotInitialized();
                    loadAsync().then(function() {
                        onBeginLoadPage(pageNo);
                        return getPageAsync(pageNo);
                    }).then(function(pageInfo) {
                        loaderOptions.documentInfoPollIntervalMs = options.documentInfoPollIntervalMs;
                        if (reportHost) {
                            reportHost.pageReady(pageInfo);
                        }
                    });
                },
                getPageData: function(pageNo) {
                    throwIfNotInitialized();
                    return loadAsync().then(function() {
                        return getPageAsync(pageNo);
                    });
                },
                dispose: function() {
                    reportHost = null;
                }
            };
        }
        function createDeviceInfo() {
            var enableAcc = options.settings.enableAccessibility();
            var deviceInfo = {
                enableAccessibility: enableAcc
            };
            if (enableAcc) {
                deviceInfo.contentTabIndex = options.settings.contentTabIndex;
            }
            var args = {};
            controller.getSearchDialogState(args);
            var searchInitiated = args.visible;
            var searchMetadataOnDemand = options.settings.searchMetadataOnDemand();
            var enableSearch = !searchMetadataOnDemand || searchInitiated;
            deviceInfo.enableSearch = enableSearch;
            return deviceInfo;
        }
        function resolveErrorByExceptionType(exceptionType) {
            switch (exceptionType) {
              case "Telerik.Reporting.Services.Engine.InvalidParameterException":
                return sr.missingOrInvalidParameter;

              default:
                return "";
            }
        }
        function formatXhrError(xhr, status, error, localizedMessage) {
            var parsedXhr = utils.parseJSON(xhr.responseText);
            var result = "";
            if (parsedXhr) {
                var errorMessage = resolveErrorByExceptionType(parsedXhr.exceptionType || parsedXhr.error);
                if (errorMessage) {
                    return errorMessage;
                }
                result = parsedXhr.message;
                var exceptionMessage = parsedXhr.exceptionMessage || parsedXhr.error_description;
                if (exceptionMessage) {
                    if (result) {
                        result += "<br/>" + exceptionMessage;
                    } else {
                        result = exceptionMessage;
                    }
                }
            } else {
                result = xhr.responseText;
            }
            if (localizedMessage || error) {
                if (result) {
                    result = "<br/>" + result;
                }
                result = (localizedMessage ? localizedMessage : error) + result;
            }
            if (utils.isInvalidClientException(xhr)) {
                result += "<br />" + sr.clientExpired;
            }
            return result;
        }
        function getReportPage(pageNo) {
            if (loader) {
                loader.beginGetPage(pageNo);
            }
        }
        function loadReportAsync(ignoreCache, baseDocumentId, actionId) {
            if (!report) {
                raiseError(sr.noReport);
                return;
            }
            if (loader) {
                loader.dispose();
                loader = null;
            }
            clearReportState();
            loader = new ReportLoader(controller, !ignoreCache, baseDocumentId, actionId);
            loader.beginLoad();
        }
        function onExportStarted(args) {
            controller.exportStarted(args);
        }
        function onExportDocumentReady(args) {
            controller.exportReady(args);
        }
        function onSendEmailStarted(args) {
            controller.sendEmailStarted(args);
        }
        function onSendEmailDocumentReady(args) {
            controller.sendEmailReady(args);
        }
        function onPrintStarted(args) {
            controller.printStarted(args);
        }
        function onPrintDocumentReady(args) {
            controller.printReady(args);
        }
        function showNotification(args) {
            controller.showNotification(args);
        }
        function hideNotification(args) {
            controller.hideNotification(args);
        }
        function setUIState(args) {
            controller.setUIState(args);
        }
        function printReport() {
            throwIfNoReport();
            var deviceInfo = {
                ImmediatePrint: true
            }, printStartArgs = {
                deviceInfo: deviceInfo,
                handled: false
            };
            onPrintStarted(printStartArgs);
            if (!printStartArgs.handled) {
                setUIState({
                    operationName: "PrintInProgress",
                    inProgress: true
                });
                showNotification({
                    stringResources: "preparingPrint"
                });
                var canUsePlugin = getCanUsePlugin(), contentDisposition = canUsePlugin ? "inline" : "attachment", queryString = "response-content-disposition=" + contentDisposition;
                exportAsync("PDF", deviceInfo).then(function(info) {
                    var url = client.formatDocumentUrl(info.clientId, info.instanceId, info.documentId, queryString), printEndArgs = {
                        url: url,
                        handled: false
                    };
                    onPrintDocumentReady(printEndArgs);
                    hideNotification();
                    setUIState({
                        operationName: "PrintInProgress",
                        inProgress: false
                    });
                    if (!printEndArgs.handled) {
                        printManager.print(url);
                    }
                });
            }
        }
        function getCanUsePlugin() {
            switch (printMode) {
              case trv.PrintModes.FORCE_PDF_FILE:
              case false:
                return false;

              case trv.PrintModes.FORCE_PDF_PLUGIN:
              case true:
                return true;

              default:
                return printManager.getDirectPrintState();
            }
        }
        function exportReport(format, deviceInfo) {
            throwIfNoReport();
            if (!deviceInfo) {
                deviceInfo = createDeviceInfo();
            }
            var exportStartArgs = {
                format: format,
                deviceInfo: deviceInfo,
                handled: false
            };
            onExportStarted(exportStartArgs);
            if (!exportStartArgs.handled) {
                var queryString = "response-content-disposition=attachment";
                setUIState({
                    operationName: "ExportInProgress",
                    inProgress: true
                });
                showNotification({
                    stringResources: "preparingDownload"
                });
                exportAsync(format, exportStartArgs.deviceInfo).then(function(info) {
                    var url = client.formatDocumentUrl(info.clientId, info.instanceId, info.documentId, queryString), exportEndArgs = {
                        url: url,
                        format: format,
                        handled: false,
                        windowOpenTarget: "_self"
                    };
                    onExportDocumentReady(exportEndArgs);
                    hideNotification();
                    setUIState({
                        operationName: "ExportInProgress",
                        inProgress: false
                    });
                    if (!exportEndArgs.handled) {
                        window.open(url, exportEndArgs.windowOpenTarget);
                    }
                });
            }
        }
        function sendReport(args) {
            throwIfNoReport();
            if (!args.deviceInfo) {
                args.deviceInfo = createDeviceInfo();
            }
            var sendEmailStartArgs = {
                deviceInfo: args.deviceInfo,
                handled: false,
                format: args.format
            };
            onSendEmailStarted(sendEmailStartArgs);
            var queryString = "response-content-disposition=attachment";
            if (!sendEmailStartArgs.handled) {
                exportAsync(args.format, args.deviceInfo).then(function(info) {
                    var url = client.formatDocumentUrl(info.clientId, info.instanceId, info.documentId, queryString);
                    args["url"] = url;
                    args["handled"] = false;
                    onSendEmailDocumentReady(args);
                    delete args.deviceInfo;
                    if (!args.handled) {
                        sendDocumentAsync(info.documentId, args);
                    }
                });
            }
        }
        function exportAsync(format, deviceInfo) {
            throwIfNoReport();
            return initializeClientAsync().then(registerInstanceAsync).then(function() {
                return registerDocumentAsync(format, deviceInfo, true, reportDocumentId);
            }).then(function(documentId) {
                return waitReportDocumentReady(clientId, reportInstanceId, documentId, options);
            });
        }
        function waitReportDocumentReady(clientId, reportInstanceId, documentId, options) {
            return new Promise(function(resolve, reject) {
                var fn = function(promise) {
                    promise.then(function(info) {
                        if (info.documentReady) {
                            resolve({
                                clientId: clientId,
                                instanceId: reportInstanceId,
                                documentId: documentId
                            });
                        } else {
                            fn(info.promise);
                        }
                    });
                };
                fn(getDocumentInfoRecursive(clientId, reportInstanceId, documentId, options));
            });
        }
        function execServerAction(actionId) {
            throwIfNoReport();
            throwIfNoReportInstance();
            throwIfNoReportDocument();
            onServerActionStarted();
            controller.refreshReportCore(false, reportDocumentId, actionId);
        }
        function throwIfNotInitialized() {
            if (!clientId) {
                throw sr.controllerNotInitialized;
            }
        }
        function throwIfNoReportInstance() {
            if (!reportInstanceId) {
                throw sr.noReportInstance;
            }
        }
        function throwIfNoReportDocument() {
            if (!reportDocumentId) {
                throw sr.noReportDocument;
            }
        }
        function throwIfNoReport() {
            if (!report) {
                throw sr.noReport;
            }
        }
        function getEventHandlerFromArguments(args) {
            var arg0;
            if (args && args.length) {
                arg0 = args[0];
            }
            if (typeof arg0 === "function") {
                return arg0;
            }
            return null;
        }
        function eventFactory(event, args) {
            var h = getEventHandlerFromArguments(args);
            if (h) {
                events.on(event, h);
            } else {
                events.trigger(event, args);
            }
            return controller;
        }
        function Events() {
            var events = {};
            function resolveEvent(eventName) {
                var event = events[eventName];
                if (!event) {
                    events[eventName] = event = new Event(eventName);
                }
                return event;
            }
            return {
                on: function(eventName, handler) {
                    resolveEvent(eventName).on(handler);
                },
                trigger: function(eventName, args) {
                    resolveEvent(eventName).trigger(args);
                }
            };
            function Event(eventName) {
                var callbacks = [];
                var event = {
                    on: function(callback) {
                        callbacks.push(callback);
                    },
                    trigger: function(args) {
                        var a = [].slice.call(args);
                        a.unshift(eventName);
                        for (var i = 0; i < callbacks.length; i++) {
                            callbacks[i].apply(controller, a);
                        }
                    }
                };
                return event;
            }
        }
        function loadParametersAsync(report, paramValues) {
            return initializeClientAsync().then(function() {
                return client.getParameters(clientId, report, paramValues || parameterValues || {}).catch(function(xhrErrorData) {
                    handleRequestError(xhrErrorData, sr.unableToGetReportParameters);
                });
            });
        }
        function getDocumentFormatsAsync() {
            if (!documentFormatsPromise) {
                documentFormatsPromise = client.getDocumentFormats().catch(handleRequestError);
            }
            return documentFormatsPromise;
        }
        function getPageForBookmark(nodes, id) {
            if (nodes) {
                for (var i = 0, len = nodes.length; i < len; i++) {
                    var node = nodes[i];
                    if (node.id === id) {
                        return node.page;
                    } else {
                        var page = getPageForBookmark(node.items, id);
                        if (page) {
                            return page;
                        }
                    }
                }
            }
            return null;
        }
        function fixDataContractJsonSerializer(arr) {
            var dict = {};
            if (Array.isArray(arr)) {
                arr.forEach(function(pair) {
                    dict[pair.Key] = pair.Value;
                });
            }
            return dict;
        }
        function changeReportSource(rs) {
            setStateReportSource(rs);
            controller.reportSourceChanged();
        }
        function setStateReportSource(rs) {
            if (options.settings.reportSource) {
                options.settings.reportSource(rs);
            }
        }
        function changePageNumber(pageNr) {
            options.settings.pageNumber(pageNr);
            controller.currentPageChanged();
        }
        var actionHandlers = {
            sorting: function(action) {
                execServerAction(action.Id);
            },
            toggleVisibility: function(action) {
                execServerAction(action.Id);
            },
            navigateToReport: function(action) {
                var args = action.Value;
                onServerActionStarted();
                controller.reportSource({
                    report: args.Report,
                    parameters: fixDataContractJsonSerializer(args.ParameterValues)
                });
                controller.refreshReport(false);
            },
            navigateToUrl: function(action) {
                var args = action.Value;
                window.open(args.Url, args.Target);
            },
            navigateToBookmark: function(action) {
                var id = action.Value, page = getPageForBookmark(bookmarkNodes, id);
                controller.navigateToPage(page, {
                    type: "bookmark",
                    id: id
                });
            },
            customAction: function(action) {}
        };
        function onInteractiveActionExecuting(interactiveActionArgs) {
            controller.interactiveActionExecuting(interactiveActionArgs);
        }
        function executeReportAction(interactiveActionArgs) {
            var action = interactiveActionArgs.action;
            var handler = actionHandlers[action.Type];
            if (typeof handler === "function") {
                window.setTimeout(function() {
                    onInteractiveActionExecuting(interactiveActionArgs);
                    if (!interactiveActionArgs.cancel) {
                        handler(action);
                    }
                }, 0);
            }
        }
        function onServerActionStarted() {
            controller.serverActionStarted();
        }
        function onReportActionEnter(args) {
            controller.interactiveActionEnter({
                action: args.action,
                element: args.element
            });
        }
        function onReportActionLeave(args) {
            controller.interactiveActionLeave({
                action: args.action,
                element: args.element
            });
        }
        function clientExpired() {
            return eventFactory(controller.Events.CLIENT_EXPIRED, arguments);
        }
        function onClientExpired() {
            clientHasExpired = true;
            controller.clientExpired();
        }
        function onReportToolTipOpening(args) {
            controller.toolTipOpening(args);
        }
        function getSearchResultsAsync(args) {
            if (!args.searchToken || args.searchToken === "") {
                return Promise.resolve(null);
            }
            return client.getSearchResults(clientId, reportInstanceId, reportDocumentId, args.searchToken, args.matchCase, args.matchWholeWord, args.useRegex).catch(handleSearchResultsError);
        }
        function handleSearchResultsError(xhrData) {
            if (!utils.isExceptionOfType(xhrData.xhr, "System.ArgumentException")) {
                handleRequestError(xhrData, null, true);
                throw null;
            }
            var exceptionDetails = utils.parseJSON(xhrData.xhr.responseText);
            throw exceptionDetails.exceptionMessage;
        }
        controller.Events = {
            ERROR: "trv.ERROR",
            EXPORT_STARTED: "trv.EXPORT_STARTED",
            EXPORT_DOCUMENT_READY: "trv.EXPORT_DOCUMENT_READY",
            PRINT_STARTED: "trv.PRINT_STARTED",
            PRINT_DOCUMENT_READY: "trv.PRINT_DOCUMENT_READY",
            BEFORE_LOAD_PARAMETERS: "trv.BEFORE_LOAD_PARAMETERS",
            ON_LOADED_REPORT_CHANGE: "trv.ON_LOADED_REPORT_CHANGE",
            BEFORE_LOAD_REPORT: "trv.BEFORE_LOAD_REPORT",
            BEGIN_LOAD_REPORT: "trv.BEGIN_LOAD_REPORT",
            REPORT_LOAD_COMPLETE: "trv.REPORT_LOAD_COMPLETE",
            REPORT_LOAD_PROGRESS: "trv.REPORT_LOAD_PROGRESS",
            REPORT_LOAD_FAIL: "trv.REPORT_LOAD_FAIL",
            BEGIN_LOAD_PAGE: "trv.BEGIN_LOAD_PAGE",
            PAGE_READY: "trv.PAGE_READY",
            VIEW_MODE_CHANGED: "trv.VIEW_MODE_CHANGED",
            PAGE_MODE_CHANGED: "trv.PAGE_MODE_CHANGED",
            PRINT_MODE_CHANGED: "trv.PRINT_MODE_CHANGED",
            REPORT_SOURCE_CHANGED: "trv.REPORT_SOURCE_CHANGED",
            NAVIGATE_TO_PAGE: "trv.NAVIGATE_TO_PAGE",
            CURRENT_PAGE_CHANGED: "trv.CURRENT_PAGE_CHANGED",
            GET_DOCUMENT_MAP_STATE: "trv.GET_DOCUMENT_MAP_STATE",
            SET_DOCUMENT_MAP_VISIBLE: "trv.SET_DOCUMENT_MAP_VISIBLE",
            GET_PARAMETER_AREA_STATE: "trv.GET_PARAMETER_AREA_STATE",
            SET_PARAMETER_AREA_VISIBLE: "trv.SET_PARAMETER_AREA_VISIBLE",
            PAGE_SCALE: "trv.PAGE_SCALE",
            GET_PAGE_SCALE: "trv.GET_PAGE_SCALE",
            SERVER_ACTION_STARTED: "trv.SERVER_ACTION_STARTED",
            SET_TOGGLE_SIDE_MENU: "trv.SET_TOGGLE_SIDE_MENU",
            GET_TOGGLE_SIDE_MENU: "trv.GET_TOGGLE_SIDE_MENU",
            UPDATE_UI: "trv.UPDATE_UI",
            CSS_LOADED: "trv.CSS_LOADED",
            RELOAD_PARAMETERS: "trv.RELOAD_PARAMETERS",
            INTERACTIVE_ACTION_EXECUTING: "trv.INTERACTIVE_ACTION_EXECUTING",
            INTERACTIVE_ACTION_ENTER: "trv.INTERACTIVE_ACTION_ENTER",
            INTERACTIVE_ACTION_LEAVE: "trv.INTERACTIVE_ACTION_LEAVE",
            UPDATE_UI_INTERNAL: "trv.UPDATE_UI_INTERNAL",
            CLIENT_EXPIRED: "trv.CLIENT_EXPIRED",
            TOOLTIP_OPENING: "trv.TOOLTIP_OPENING",
            PAGE_NUMBER: "trv.PAGE_NUMBER",
            PAGE_COUNT: "trv.PAGE_COUNT",
            GET_SEARCH_DIALOG_STATE: "trv.GET_SEARCH_DIALOG_STATE",
            SET_SEARCH_DIALOG_VISIBLE: "trv.SET_SEARCH_DIALOG_VISIBLE",
            SET_SEND_EMAIL_DIALOG_VISIBLE: "trv.SET_SEND_EMAIL_DIALOG_VISIBLE",
            SEND_EMAIL_STARTED: "trv.SEND_EMAIL_STARTED",
            SEND_EMAIL_READY: "trv.SEND_EMAIL_READY",
            SHOW_NOTIFICATION: "trv.SHOW_NOTIFICATION",
            HIDE_NOTIFICATION: "trv.HIDE_NOTIFICATION",
            UI_STATE: "trv.UI_STATE",
            SCROLL_PAGE_READY: "trv.SCROLL_PAGE_READY",
            UPDATE_SCROLL_PAGE_DIMENSIONS_READY: "trv.UPDATE_SCROLL_PAGE_DIMENSIONS_READY",
            MISSING_OR_INVALID_PARAMETERS: "MISSING_OR_INVALID_PARAMETERS"
        };
        utils.extend(controller, {
            getPageData: function(pageNumber) {
                if (loader) {
                    return loader.getPageData(pageNumber);
                }
                return;
            },
            reportSource: function(rs) {
                if (null === rs) {
                    report = parameterValues = null;
                    clearReportState();
                    changeReportSource(rs);
                    return this;
                } else if (rs) {
                    report = rs.report;
                    parameterValues = rs.parameters;
                    changeReportSource(rs);
                    return this;
                } else {
                    if (report === null) {
                        return null;
                    }
                    return {
                        report: report,
                        parameters: utils.extend({}, parameterValues)
                    };
                }
            },
            updateSettings: function(settings) {
                options.settings = utils.extend({}, settings, options.settings);
            },
            clearReportSource: function() {
                report = parameterValues = null;
                clearReportState();
                changeReportSource(undefined);
                return this;
            },
            reportDocumentIdExposed: function() {
                return reportDocumentId;
            },
            setParameters: function(paramValues) {
                parameterValues = paramValues;
            },
            pageCount: function() {
                return pageCount;
            },
            currentPageNumber: function(pageNo) {
                if (pageNo === undefined) return currentPageNumber;
                var num = utils.tryParseInt(pageNo);
                if (num !== currentPageNumber) {
                    currentPageNumber = num;
                    changePageNumber(num);
                }
                return this;
            },
            viewMode: function(vm) {
                var vmode = controller.setViewMode(vm);
                if (typeof vmode === "string") {
                    return vmode;
                }
                if (report) {
                    controller.refreshReportCore(false, reportDocumentId);
                }
                return controller;
            },
            setViewMode: function(vm) {
                if (!vm) {
                    return viewMode;
                }
                if (viewMode !== vm) {
                    viewMode = vm;
                    controller.viewModeChanged(vm);
                }
                return controller;
            },
            pageMode: function(psm) {
                var psmode = controller.setPageMode(psm);
                if (typeof psmode === "string") {
                    return psmode;
                }
                if (report) {
                    controller.refreshReportCore(false, reportDocumentId);
                }
                return controller;
            },
            setPageMode: function(psm) {
                if (!psm) {
                    return pageMode;
                }
                if (pageMode !== psm) {
                    pageMode = psm;
                    controller.pageModeChanged(psm);
                }
                return controller;
            },
            printMode: function(pm) {
                if (!pm) {
                    return printMode;
                }
                if (printMode !== pm) {
                    printMode = pm;
                    controller.printModeChanged(pm);
                }
                return controller;
            },
            previewReport: function(ignoreCache, baseDocumentId, actionId) {
                controller.onLoadedReportChange();
                controller.refreshReportCore(ignoreCache, baseDocumentId, actionId);
            },
            refreshReportCore: function(ignoreCache, baseDocumentId, actionId) {
                loadReportAsync(ignoreCache, baseDocumentId, actionId);
            },
            refreshReport: function(ignoreCache, baseDocumentId, actionId) {
                controller.onLoadedReportChange();
                if (clientHasExpired) {
                    clientHasExpired = false;
                    clearClientId();
                }
                if (!report) {
                    raiseError(sr.noReport);
                    return;
                }
                var loadParametersPromise = controller.loadParameters(null);
                loadParametersPromise.then(function(parameters) {
                    var parameterValues = {};
                    var hasError = false;
                    utils.each(parameters || [], function() {
                        try {
                            parameterValues[this.id] = parameterValidators.validate(this, this.value);
                        } catch (e) {
                            hasError = true;
                            return;
                        }
                    });
                    if (hasError) {
                        controller.missingOrInvalidParameters();
                    } else {
                        controller.setParameters(parameterValues);
                        controller.refreshReportCore(ignoreCache, baseDocumentId, actionId);
                    }
                });
                controller.reloadParameters(loadParametersPromise);
            },
            exportReport: function(format, deviceInfo) {
                exportReport(format, deviceInfo);
            },
            sendReport: function(args) {
                sendReport(args);
            },
            printReport: function() {
                printReport();
            },
            getReportPage: function(pageNumber) {
                getReportPage(pageNumber);
            },
            executeReportAction: function(interactiveActionArgs) {
                executeReportAction(interactiveActionArgs);
            },
            reportActionEnter: function(args) {
                onReportActionEnter(args);
            },
            reportActionLeave: function(args) {
                onReportActionLeave(args);
            },
            reportToolTipOpening: function(args) {
                onReportToolTipOpening(args);
            },
            loadParameters: function(paramValues) {
                if (report === null) {
                    return {};
                }
                controller.beforeLoadParameters(paramValues === null);
                return loadParametersAsync(report, paramValues);
            },
            getDocumentFormats: function() {
                return getDocumentFormatsAsync();
            },
            setAuthenticationToken: function(token) {
                client.setAccessToken(token);
            },
            clientId: function() {
                return clientId;
            },
            onReportLoadComplete: function(info) {
                pageCount = info.pageCount;
                bookmarkNodes = info.bookmarkNodes;
                setStateReportSource(controller.reportSource());
                controller.reportLoadComplete(info);
            },
            raiseError: raiseError,
            getSearchResults: function(args, results) {
                return getSearchResultsAsync(args, results);
            },
            on: events.on,
            showNotification: function() {
                return eventFactory(controller.Events.SHOW_NOTIFICATION, arguments);
            },
            hideNotification: function() {
                return eventFactory(controller.Events.HIDE_NOTIFICATION, arguments);
            },
            setUIState: function() {
                return eventFactory(controller.Events.UI_STATE, arguments);
            },
            error: function() {
                return eventFactory(controller.Events.ERROR, arguments);
            },
            reloadParameters: function() {
                return eventFactory(controller.Events.RELOAD_PARAMETERS, arguments);
            },
            exportStarted: function() {
                return eventFactory(controller.Events.EXPORT_STARTED, arguments);
            },
            exportReady: function() {
                return eventFactory(controller.Events.EXPORT_DOCUMENT_READY, arguments);
            },
            sendEmailStarted: function() {
                return eventFactory(controller.Events.SEND_EMAIL_STARTED, arguments);
            },
            sendEmailReady: function() {
                return eventFactory(controller.Events.SEND_EMAIL_READY, arguments);
            },
            printStarted: function() {
                return eventFactory(controller.Events.PRINT_STARTED, arguments);
            },
            printReady: function() {
                return eventFactory(controller.Events.PRINT_DOCUMENT_READY, arguments);
            },
            beforeLoadParameters: function() {
                return eventFactory(controller.Events.BEFORE_LOAD_PARAMETERS, arguments);
            },
            onLoadedReportChange: function() {
                return eventFactory(controller.Events.ON_LOADED_REPORT_CHANGE, arguments);
            },
            beforeLoadReport: function() {
                return eventFactory(controller.Events.BEFORE_LOAD_REPORT, arguments);
            },
            beginLoadReport: function() {
                return eventFactory(controller.Events.BEGIN_LOAD_REPORT, arguments);
            },
            reportLoadComplete: function() {
                return eventFactory(controller.Events.REPORT_LOAD_COMPLETE, arguments);
            },
            reportLoadProgress: function() {
                return eventFactory(controller.Events.REPORT_LOAD_PROGRESS, arguments);
            },
            reportLoadFail: function() {
                return eventFactory(controller.Events.REPORT_LOAD_FAIL, arguments);
            },
            beginLoadPage: function() {
                return eventFactory(controller.Events.BEGIN_LOAD_PAGE, arguments);
            },
            pageReady: function() {
                return eventFactory(controller.Events.PAGE_READY, arguments);
            },
            viewModeChanged: function() {
                return eventFactory(controller.Events.VIEW_MODE_CHANGED, arguments);
            },
            pageModeChanged: function() {
                return eventFactory(controller.Events.PAGE_MODE_CHANGED, arguments);
            },
            printModeChanged: function() {
                return eventFactory(controller.Events.PRINT_MODE_CHANGED, arguments);
            },
            reportSourceChanged: function() {
                return eventFactory(controller.Events.REPORT_SOURCE_CHANGED, arguments);
            },
            navigateToPage: function() {
                return eventFactory(controller.Events.NAVIGATE_TO_PAGE, arguments);
            },
            currentPageChanged: function() {
                return eventFactory(controller.Events.CURRENT_PAGE_CHANGED, arguments);
            },
            getDocumentMapState: function() {
                return eventFactory(controller.Events.GET_DOCUMENT_MAP_STATE, arguments);
            },
            setDocumentMapVisible: function() {
                return eventFactory(controller.Events.SET_DOCUMENT_MAP_VISIBLE, arguments);
            },
            getParametersAreaState: function() {
                return eventFactory(controller.Events.GET_PARAMETER_AREA_STATE, arguments);
            },
            setParametersAreaVisible: function() {
                return eventFactory(controller.Events.SET_PARAMETER_AREA_VISIBLE, arguments);
            },
            setSideMenuVisible: function() {
                return eventFactory(controller.Events.SET_TOGGLE_SIDE_MENU, arguments);
            },
            getSideMenuVisible: function() {
                return eventFactory(controller.Events.GET_TOGGLE_SIDE_MENU, arguments);
            },
            scale: function() {
                return eventFactory(controller.Events.PAGE_SCALE, arguments);
            },
            getScale: function() {
                return eventFactory(controller.Events.GET_PAGE_SCALE, arguments);
            },
            serverActionStarted: function() {
                return eventFactory(controller.Events.SERVER_ACTION_STARTED, arguments);
            },
            cssLoaded: function() {
                return eventFactory(controller.Events.CSS_LOADED, arguments);
            },
            interactiveActionExecuting: function() {
                return eventFactory(controller.Events.INTERACTIVE_ACTION_EXECUTING, arguments);
            },
            interactiveActionEnter: function() {
                return eventFactory(controller.Events.INTERACTIVE_ACTION_ENTER, arguments);
            },
            interactiveActionLeave: function() {
                return eventFactory(controller.Events.INTERACTIVE_ACTION_LEAVE, arguments);
            },
            updateUI: function() {
                return eventFactory(controller.Events.UPDATE_UI, arguments);
            },
            updateUIInternal: function() {
                return eventFactory(controller.Events.UPDATE_UI_INTERNAL, arguments);
            },
            toolTipOpening: function() {
                return eventFactory(controller.Events.TOOLTIP_OPENING, arguments);
            },
            pageNumberChange: function() {
                return eventFactory(controller.Events.PAGE_NUMBER, arguments);
            },
            pageCountChange: function() {
                return eventFactory(controller.Events.PAGE_COUNT, arguments);
            },
            getSearchDialogState: function() {
                return eventFactory(controller.Events.GET_SEARCH_DIALOG_STATE, arguments);
            },
            getSendEmailDialogState: function() {
                return eventFactory(controller.Events.GET_SEND_EMAIL_DIALOG_STATE, arguments);
            },
            setSearchDialogVisible: function() {
                return eventFactory(controller.Events.SET_SEARCH_DIALOG_VISIBLE, arguments);
            },
            setSendEmailDialogVisible: function() {
                return eventFactory(controller.Events.SET_SEND_EMAIL_DIALOG_VISIBLE, arguments);
            },
            scrollPageReady: function() {
                return eventFactory(controller.Events.SCROLL_PAGE_READY, arguments);
            },
            updatePageDimensionsReady: function() {
                return eventFactory(controller.Events.UPDATE_SCROLL_PAGE_DIMENSIONS_READY, arguments);
            },
            missingOrInvalidParameters: function() {
                return eventFactory(controller.Events.MISSING_OR_INVALID_PARAMETERS, arguments);
            },
            clientExpired: clientExpired
        });
        return controller;
    }
    trv.ReportViewerController = ReportViewerController;
})(window.telerikReportViewer = window.telerikReportViewer || {}, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    trv.touchBehavior = function(dom, options) {
        var startDistance, ignoreTouch;
        init(dom);
        function init(element) {
            if (typeof $.fn.kendoTouch === "function") {
                $(element).mousedown(function() {
                    ignoreTouch = true;
                }).mouseup(function() {
                    ignoreTouch = false;
                }).kendoTouch({
                    multiTouch: true,
                    enableSwipe: true,
                    swipe: function(e) {
                        if (!ignoreTouch) {
                            onSwipe(e);
                        }
                    },
                    gesturestart: function(e) {
                        if (!ignoreTouch) {
                            onGestureStart(e);
                        }
                    },
                    gestureend: function(e) {
                        if (!ignoreTouch) {
                            onGestureEnd(e);
                        }
                    },
                    gesturechange: function(e) {
                        if (!ignoreTouch) {
                            onGestureChange(e);
                        }
                    },
                    doubletap: function(e) {
                        if (!ignoreTouch) {
                            onDoubleTap(e);
                        }
                    },
                    touchstart: function(e) {
                        if (!ignoreTouch) {
                            fire("touchstart");
                        }
                    }
                });
            }
        }
        function onDoubleTap(e) {
            fire("doubletap", e);
        }
        function onGestureStart(e) {
            startDistance = kendo.touchDelta(e.touches[0], e.touches[1]).distance;
        }
        function onGestureEnd(e) {}
        function onGestureChange(e) {
            var current = kendo.touchDelta(e.touches[0], e.touches[1]).distance;
            onPinch({
                distance: current,
                lastDistance: startDistance
            });
            startDistance = current;
        }
        function onSwipe(e) {
            fire("swipe", e);
        }
        function onPinch(e) {
            fire("pinch", e);
        }
        function fire(func, args) {
            var handler = options[func];
            if (typeof handler === "function") {
                handler(args);
            }
        }
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    var domUtils = trv.domUtils;
    var touchBehavior = trv.touchBehavior;
    if (!touchBehavior) {
        throw "Missing telerikReportViewer.touch";
    }
    var defaultOptions = {};
    var scaleModes = trv.ScaleModes = {
        FIT_PAGE_WIDTH: "FIT_PAGE_WIDTH",
        FIT_PAGE: "FIT_PAGE",
        SPECIFIC: "SPECIFIC"
    };
    function PagesArea(placeholder, options, otherOptions) {
        options = $.extend({}, defaultOptions, options, otherOptions);
        var controller = options.controller;
        if (!controller) throw "No controller (telerikReportViewer.reportViewerController) has been specified.";
        var $placeholder = $(placeholder), $pageContainer = $placeholder.find(".trv-page-container"), pageContainer = $pageContainer[0], $pageWrapper = $placeholder.find(".trv-page-wrapper"), pageWrapper = $pageWrapper[0], $errorMessage = $placeholder.find(".trv-error-message"), actions, pendingElement, pageScaleMode = scaleModes.SPECIFIC, pageScale = 1, minPageScale = .1, maxPageScale = 8, documentReady = true, navigateToPageOnDocReady, navigateToElementOnDocReady, isNewReportSource, showErrorTimeoutId, showPageAreaImage = false, reportPageIsLoaded = false, pageAreaImageStyle = '.trv-page-container {background: #ffffff url("{0}") no-repeat center 50px}', pageAreaImageID = "trv-initial-image-styles", scroll = utils.extend({}, trv.scroll, {});
        init();
        if (scroll) {
            scroll.init(placeholder, options);
        }
        function init() {
            replaceStringResources($placeholder);
        }
        function replaceStringResources($pagesArea) {
            $pagesArea.attr("aria-label", sr[$pagesArea.attr("aria-label")]);
        }
        $(window).on("resize", function(event, args) {
            if (shouldAutosizePage()) {
                updatePageDimensions();
            }
        });
        enableTouch($placeholder);
        function clearPendingTimeoutIds() {
            if (showErrorTimeoutId) {
                window.clearTimeout(showErrorTimeoutId);
            }
        }
        function invalidateCurrentlyLoadedPage() {
            var page = findPage(navigateToPageOnDocReady);
            if (page) {
                pageNo(page, -1);
            }
        }
        function navigateWhenPageAvailable(pageNumber, pageCount) {
            if (pageNumber && pageNumber <= pageCount) {
                navigateToPage(pageNumber, navigateToElementOnDocReady);
            }
        }
        function navigateOnLoadComplete(pageNumber, pageCount) {
            if (pageNumber) {
                pageNumber = Math.min(pageNumber, pageCount);
                navigateToPage(pageNumber, navigateToElementOnDocReady);
            }
        }
        function clearPage() {
            clear(isNewReportSource);
            isNewReportSource = false;
        }
        controller.reportSourceChanged(function() {
            isNewReportSource = true;
            navigateToPageOnDocReady = null;
            navigateToElementOnDocReady = null;
            documentReady = false;
        }).beforeLoadParameters(function(event, initial) {
            if (initial) {
                showError(sr.loadingReport);
            }
        }).beforeLoadReport(function() {
            documentReady = false;
            if (!navigateToPageOnDocReady) navigateToPageOnDocReady = 1;
            clearPendingTimeoutIds();
            clear();
            disablePagesArea(true);
            showError(sr.loadingReport);
        }).beginLoadReport(function(event, args) {
            documentReady = true;
            invalidateCurrentlyLoadedPage();
        }).reportLoadProgress(function(event, args) {
            navigateWhenPageAvailable(navigateToPageOnDocReady, args.pageCount);
            showError(utils.stringFormat(sr.loadingReportPagesInProgress, [ args.pageCount ]));
        }).reportLoadComplete(function(event, args) {
            if (0 === args.pageCount) {
                clearPage();
                showError(sr.noPageToDisplay);
            } else {
                navigateOnLoadComplete(navigateToPageOnDocReady, args.pageCount);
                showError(utils.stringFormat(sr.loadedReportPagesComplete, [ args.pageCount ]));
                showErrorTimeoutId = window.setTimeout(showError, 2e3);
                enableInteractivity();
            }
        }).navigateToPage(function(event, pageNumber, targetElement) {
            navigateToPage(pageNumber, targetElement);
        }).pageReady(function(event, page) {
            if (controller.pageMode() === trv.PageModes.SINGLE_PAGE) {
                if (scroll.isEnabled()) {
                    scroll.clear();
                }
                setPageContent(page);
            } else {
                scroll.renderPage(page);
            }
            if (!reportPageIsLoaded) {
                reportPageIsLoaded = true;
            }
            if (showPageAreaImage) {
                clearPageAreaImage();
            }
            disablePagesArea(false);
        }).error(function(event, error) {
            disablePagesArea(false);
            clearPage();
            showError(error);
        }).showNotification(function(event, args) {
            showError(sr[args.stringResources]);
        }).hideNotification(function(event, args) {
            showError();
        }).scale(function(event, args) {
            setPageScale(args);
        }).getScale(function(event, args) {
            var page = getCurrentPage();
            var scale = $(page).data("pageScale") || pageScale;
            args.scale = scale;
            args.scaleMode = pageScaleMode;
        }).setDocumentMapVisible(function() {
            if (shouldAutosizePage()) {
                setTimeout(function() {
                    updatePageDimensions();
                });
            }
        }).setParametersAreaVisible(function() {
            if (shouldAutosizePage()) {
                setTimeout(function() {
                    updatePageDimensions();
                });
            }
        }).serverActionStarted(function() {
            disablePagesArea(true);
            showError(sr.loadingReport);
        }).scrollPageReady(function(event, args) {
            setScrollablePage(args);
        }).missingOrInvalidParameters(function(event, args) {
            if (options.initialPageAreaImageUrl && !reportPageIsLoaded) {
                clearPage();
                setPageAreaImage();
            } else {
                controller.raiseError(sr.missingOrInvalidParameter);
            }
        });
        function enableTouch(dom) {
            var allowSwipeLeft, allowSwipeRight;
            touchBehavior(dom, {
                swipe: function(e) {
                    var pageNumber = controller.currentPageNumber();
                    if (allowSwipeLeft && e.direction === "left") {
                        if (pageNumber < controller.pageCount()) {
                            controller.navigateToPage(pageNumber + 1);
                        }
                    } else if (allowSwipeRight && e.direction === "right") {
                        if (pageNumber > 1) {
                            controller.navigateToPage(pageNumber - 1);
                        }
                    }
                },
                pinch: function(e) {
                    var page = getCurrentPage();
                    var scale = $(page).data("pageScale") || pageScale;
                    var f = e.distance / e.lastDistance;
                    setPageScale({
                        scale: scale * f,
                        scaleMode: trv.ScaleModes.SPECIFIC
                    });
                },
                doubletap: function(e) {
                    options.commands.toggleZoomMode.exec();
                },
                touchstart: function(e) {
                    var el = pageWrapper;
                    allowSwipeRight = 0 === el.scrollLeft;
                    allowSwipeLeft = el.scrollWidth - el.offsetWidth === el.scrollLeft;
                }
            });
        }
        function shouldAutosizePage() {
            return -1 !== [ scaleModes.FIT_PAGE, scaleModes.FIT_PAGE_WIDTH ].indexOf(pageScaleMode);
        }
        function updatePageDimensions() {
            for (var i = 0, children = $pageContainer.find(".trv-report-page"), len = children.length; i < len; i++) {
                var pageNumber = parseInt($(children[i]).attr("data-page"));
                setPageDimensions(children[i], pageScaleMode, pageScale, pageNumber);
            }
            controller.updatePageDimensionsReady();
        }
        function setPageScale(options) {
            pageScaleMode = options.scaleMode || pageScaleMode;
            var scale = pageScale;
            if ("scale" in options) {
                scale = options.scale;
            }
            pageScale = Math.max(minPageScale, Math.min(maxPageScale, scale));
            updatePageDimensions();
        }
        function clear(clearPageWrapper) {
            disableInteractivity();
            pendingElement = undefined;
            if (clearPageWrapper) {
                $pageWrapper.empty();
            }
            showError();
        }
        function getCurrentPage() {
            return findPage(controller.currentPageNumber());
        }
        function findPage(pageNumber) {
            var page;
            if (controller.pageMode() === trv.PageModes.SINGLE_PAGE) {
                utils.each($pageContainer.children(), function(index, page1) {
                    if (pageNo(page1) === pageNumber) {
                        page = page1;
                    }
                    return !page;
                });
            } else {
                var allPages = $pageContainer.find(".trv-report-page");
                $.each(allPages, function(index, pageDom) {
                    var dataPageNumber = parseInt($(pageDom).attr("data-page"));
                    if (dataPageNumber === pageNumber) {
                        page = pageDom;
                    }
                });
            }
            return page;
        }
        function navigateToPage(pageNumber, targetElement) {
            if (documentReady) {
                navigateToPageCore(pageNumber, targetElement);
            } else {
                navigateToPageOnDocumentReady(pageNumber, targetElement);
            }
        }
        function navigateToPageOnDocumentReady(pageNumber, targetElement) {
            navigateToPageOnDocReady = pageNumber;
            navigateToElementOnDocReady = targetElement;
        }
        function navigateToPageCore(pageNumber, targetElement) {
            var page = findPage(pageNumber);
            if (page) {
                if (targetElement) {
                    navigateToElement(targetElement, pageNumber);
                }
                if (scroll.isEnabled() && !targetElement) {
                    scroll.navigateToElement(page.offsetTop, pageNumber);
                }
            } else {
                pendingElement = targetElement;
                beginLoadPage(pageNumber);
            }
        }
        function navigateToElement(targetElement, pageNumber) {
            if (targetElement) {
                var el = $pageContainer.find("[data-" + targetElement.type + "-id=" + targetElement.id + "]")[0];
                if (el) {
                    if (options.enableAccessibility) {
                        var $nextFocusable = findNextFocusableElement($(el));
                        if ($nextFocusable) {
                            $nextFocusable.focus();
                        }
                    }
                    var container = $pageContainer[0], offsetTop = 0, offsetLeft = 0;
                    while (el && el !== container) {
                        if ($(el).is(".trv-page-wrapper")) {
                            var scale = $(el).data("pageScale");
                            if (typeof scale === "number") {
                                offsetTop *= scale;
                                offsetLeft *= scale;
                            }
                        }
                        offsetTop += el.offsetTop;
                        offsetLeft += el.offsetLeft;
                        el = el.offsetParent;
                    }
                    if (scroll.isEnabled() && pageNumber) {
                        scroll.navigateToElement(offsetTop, pageNumber);
                    } else {
                        container.scrollTop = offsetTop;
                        container.scrollLeft = offsetLeft;
                    }
                } else {
                    if (scroll.isEnabled() && pageNumber) {
                        scroll.navigateToElement($placeholder.find('[data-page="' + pageNumber + '"]')[0].offsetTop, pageNumber);
                    }
                }
            }
        }
        function findNextFocusableElement(element) {
            if (!element || element.length === 0) {
                return null;
            }
            var num = utils.tryParseInt(element.attr("tabindex"));
            if (!isNaN(num) && num > -1) {
                return element;
            }
            return findNextFocusableElement(element.next());
        }
        function disablePagesArea(disable) {
            (disable ? $.fn.addClass : $.fn.removeClass).call($placeholder, "trv-loading");
        }
        function showError(error) {
            $errorMessage.html(error);
            (error ? $.fn.addClass : $.fn.removeClass).call($placeholder, "trv-error");
        }
        function pageNo(page, no) {
            var $page = page.$ ? page : $(page), dataKey = "pageNumber";
            if (no === undefined) {
                return $page.data(dataKey);
            }
            $page.data(dataKey, no);
            return page;
        }
        function beginLoadPage(pageNumber) {
            disablePagesArea(true);
            window.setTimeout(controller.getReportPage.bind(controller, pageNumber), 1);
            navigateToPageOnDocReady = null;
        }
        function setPageDimensions(page, scaleMode, scale, pageNumber) {
            var $target = $(page), $page = pageNumber ? $target : $target.find("div.trv-report-page"), $pageContent = $page.find("div.sheet"), $pageSkeletonContent = $page.find("div.trv-skeleton-wrapper"), pageContent = $pageContent[0] || $pageSkeletonContent[0], pageSkeletonContent = $pageSkeletonContent[0];
            if (!pageContent) return;
            var pageWidth, pageHeight, box = $target.data("box");
            if (!box) {
                var margins = domUtils.getMargins($target), borders = domUtils.getBorderWidth($page), padding = domUtils.getPadding($page);
                box = {
                    padLeft: margins.left + borders.left + padding.left,
                    padRight: margins.right + borders.right + padding.right,
                    padTop: margins.top + borders.top + padding.top,
                    padBottom: margins.bottom + borders.bottom + padding.bottom
                };
                $target.data("box", box);
            }
            if ($target.data("pageWidth") === undefined) {
                pageWidth = pageContent.offsetWidth;
                pageHeight = pageContent.offsetHeight;
                $target.data("pageWidth", pageWidth);
                $target.data("pageHeight", pageHeight);
            } else {
                pageWidth = $target.data("pageWidth");
                pageHeight = $target.data("pageHeight");
            }
            var scrollBarV = pageHeight > pageWidth && scaleMode === scaleModes.FIT_PAGE_WIDTH ? 20 : 0, scaleW = (pageContainer.clientWidth - scrollBarV - box.padLeft - box.padRight) / pageWidth, scaleH = (pageContainer.clientHeight - 1 - box.padTop - box.padBottom) / pageHeight;
            if (scaleMode === scaleModes.FIT_PAGE_WIDTH) {
                scale = scaleW;
            } else if (!scale || scaleMode === scaleModes.FIT_PAGE) {
                scale = Math.min(scaleW, scaleH);
            }
            $target.data("pageScale", scale);
            if (!pageSkeletonContent) {
                domUtils.scale($pageContent, scale, scale);
            }
            $page.css({
                height: scale * pageHeight,
                width: scale * pageWidth
            });
        }
        function enableInteractivity() {
            $pageContainer.on("click", "[data-reporting-action]", onInteractiveItemClick);
            $pageContainer.on("mouseenter", "[data-reporting-action]", onInteractiveItemEnter);
            $pageContainer.on("mouseleave", "[data-reporting-action]", onInteractiveItemLeave);
            $pageContainer.on("mouseenter", "[data-tooltip-title],[data-tooltip-text]", onToolTipItemEnter);
            $pageContainer.on("mouseleave", "[data-tooltip-title],[data-tooltip-text]", onToolTipItemLeave);
        }
        function disableInteractivity() {
            $pageContainer.off("click", "[data-reporting-action]", onInteractiveItemClick);
            $pageContainer.off("mouseenter", "[data-reporting-action]", onInteractiveItemEnter);
            $pageContainer.off("mouseleave", "[data-reporting-action]", onInteractiveItemLeave);
            $pageContainer.off("mouseenter", "[data-tooltip-title],[data-tooltip-text]", onToolTipItemEnter);
            $pageContainer.off("mouseleave", "[data-tooltip-title],[data-tooltip-text]", onToolTipItemLeave);
        }
        function onInteractiveItemClick(event) {
            var $eventTarget = $(this);
            var actionId = $eventTarget.attr("data-reporting-action"), action = getAction(actionId);
            if (action) {
                navigateToPageOnDocReady = getNavigateToPageOnDocReady(event, action.Type);
                controller.executeReportAction({
                    element: event.currentTarget,
                    action: action,
                    cancel: false
                });
            }
            event.stopPropagation();
        }
        function getNavigateToPageOnDocReady(event, actionType) {
            if (scroll.isEnabled() && (actionType === "sorting" || actionType === "toggleVisibility")) {
                return $(event.target).closest(".trv-report-page").attr("data-page") || controller.currentPageNumber();
            }
            return controller.currentPageNumber();
        }
        function onInteractiveItemEnter(args) {
            var $t = $(this);
            var actionId = $t.attr("data-reporting-action");
            var a = getAction(actionId);
            if (a !== null && args.currentTarget === this) {
                controller.reportActionEnter({
                    element: args.currentTarget,
                    action: a
                });
            }
        }
        function onInteractiveItemLeave(args) {
            var $t = $(this);
            var actionId = $t.attr("data-reporting-action");
            var a = getAction(actionId);
            if (a !== null && args.currentTarget === this) {
                controller.reportActionLeave({
                    element: args.currentTarget,
                    action: a
                });
            }
        }
        function getAction(actionId) {
            if (actions) {
                var action;
                utils.each(actions, function() {
                    if (this.Id === actionId) {
                        action = this;
                    }
                    return action === undefined;
                });
                return action;
            }
            return null;
        }
        function onToolTipItemEnter(args) {
            var $t = $(this);
            var title = $t.attr("data-tooltip-title");
            var text = $t.attr("data-tooltip-text");
            if (!title && !text) {
                return;
            }
            var toolTipArgs = {
                element: args.currentTarget,
                toolTip: {
                    title: title || "",
                    text: text || ""
                },
                cancel: false
            };
            controller.reportToolTipOpening(toolTipArgs);
            if (toolTipArgs.cancel) {
                return;
            }
            var content = applyToolTipTemplate(toolTipArgs);
            var viewportElement = args.currentTarget.viewportElement;
            var ktt = getToolTip($t, content);
            ktt.show($t);
            if (viewportElement && viewportElement.nodeName === "svg") {
                positionToolTip(ktt, args);
            }
        }
        function applyToolTipTemplate(toolTipArgs) {
            var toolTipTemplate = options.templates["trv-pages-area-kendo-tooltip"];
            var $container = $(toolTipTemplate);
            var $titleSpan = $container.find(".trv-pages-area-kendo-tooltip-title");
            var $textSpan = $container.find(".trv-pages-area-kendo-tooltip-text");
            $titleSpan.text(toolTipArgs.toolTip.title);
            $textSpan.text(toolTipArgs.toolTip.text);
            return $container.clone().wrap("<p>").parent().html();
        }
        function positionToolTip(toolTip, e) {
            var x = e.pageX;
            var y = e.pageY;
            toolTip.popup.element.parent().css({
                left: x + 10,
                top: y + 5
            });
        }
        function getToolTip(target, toolTipContent) {
            var ktt = target.data("kendoTooltip");
            if (!ktt) {
                ktt = target.kendoTooltip({
                    content: toolTipContent,
                    autohide: true,
                    callout: false
                }).data("kendoTooltip");
            }
            return ktt;
        }
        function onToolTipItemLeave(args) {
            var $t = $(this);
            var toolTip = $t.data("kendoTooltip");
            if (toolTip) {
                toolTip.hide();
            }
        }
        function updatePageStyle(page) {
            var styleId = "trv-" + controller.clientId() + "-styles";
            $("#" + styleId).remove();
            var pageStyles = $("<style id=" + styleId + "></style>");
            pageStyles.append(page.pageStyles);
            pageStyles.appendTo("head");
        }
        function setPageContent(page) {
            actions = JSON.parse(page.pageActions);
            updatePageStyle(page);
            var pageNumber = page.pageNumber, wrapper = $($.parseHTML(page.pageContent)), $pageContent = wrapper.find("div.sheet"), $page = $('<div class="trv-report-page" data-page="' + pageNumber + '"></div>');
            $pageContent.css("margin", 0);
            $page.append($pageContent).append($('<div class="trv-page-overlay"></div>'));
            var $target = $pageWrapper.empty().removeData().data("pageNumber", pageNumber).append($page);
            controller.currentPageNumber(pageNumber);
            if (controller.viewMode() === trv.ViewModes.INTERACTIVE) {
                $placeholder.removeClass("printpreview");
                $placeholder.addClass("interactive");
            } else {
                $placeholder.removeClass("interactive");
                $placeholder.addClass("printpreview");
            }
            setPageDimensions($target, pageScaleMode, pageScale);
            $pageContainer.scrollTop(0);
            $pageContainer.scrollLeft(0);
            navigateToElement(pendingElement);
        }
        function setScrollablePage(args) {
            var pageActions = JSON.parse(args.page.pageActions);
            if (!actions) {
                actions = pageActions;
            } else {
                actions = actions.concat(pageActions);
            }
            if (controller.viewMode() === trv.ViewModes.INTERACTIVE) {
                $placeholder.removeClass("printpreview");
                $placeholder.addClass("interactive");
            } else {
                $placeholder.removeClass("interactive");
                $placeholder.addClass("printpreview");
            }
            setPageDimensions(args.target, pageScaleMode, pageScale, args.page.pageNumber);
        }
        function setPageAreaImage() {
            var pageStyles = $("<style id=" + pageAreaImageID + "></style>");
            clearPageAreaImage();
            pageStyles.append(utils.stringFormat(pageAreaImageStyle, [ options.initialPageAreaImageUrl ]));
            pageStyles.appendTo("head");
            showPageAreaImage = true;
        }
        function clearPageAreaImage() {
            $("#" + pageAreaImageID).remove();
        }
    }
    var pluginName = "telerik_ReportViewer_PagesArea";
    $.fn[pluginName] = function(options, otherOptions) {
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new PagesArea(this, options, otherOptions));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var defaultOptions = {};
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    function DocumentMapArea(placeholder, options, otherOptions) {
        options = $.extend({}, defaultOptions, options, otherOptions);
        var controller = options.controller;
        if (!controller) {
            throw "No controller (telerikReporting.reportViewerController) has been specified.";
        }
        var $placeholder = $(placeholder), $documentMap;
        var documentMapVisible = options.documentMapVisible !== false;
        var enableAccessibility = options.enableAccessibility;
        init();
        function init() {
            $documentMap = $('<div id="' + options.viewerSelector + '-documentMap"></div>');
            $documentMap.appendTo(placeholder);
            attach();
            replaceStringResources($placeholder);
        }
        function onTreeViewSelectionChanged(e) {
            var documentMapNode = this.dataItem(e.node), page = documentMapNode.page, id = documentMapNode.id;
            controller.navigateToPage(page, {
                type: "bookmark",
                id: id
            });
        }
        function onTreeViewNodeExpand(e) {
            if (enableAccessibility) {
                window.setTimeout(function() {
                    setNodeAccessibilityAttributes(e.node);
                }, 100);
            }
        }
        function setNodeAccessibilityAttributes(node) {
            var $items = $(node).find("li");
            utils.each($items, function() {
                var $li = $(this);
                $li.attr("aria-label", $li[0].innerText);
            });
        }
        function clearDocumentMap() {
            displayDocumentMap([]);
        }
        function displayDocumentMap(documentMap) {
            var hasDocumentMap = documentMap && !$.isEmptyObject(documentMap);
            var $treeView = $documentMap.data("kendoTreeView");
            if (!$treeView) {
                $documentMap.kendoTreeView({
                    dataTextField: "text",
                    select: onTreeViewSelectionChanged
                });
                $treeView = $documentMap.data("kendoTreeView");
            }
            $treeView.setDataSource(documentMap);
            setAccessibilityAttributes($treeView);
            showDocumentMap(hasDocumentMap);
        }
        function setAccessibilityAttributes(treeView) {
            if (enableAccessibility) {
                treeView.bind("expand", onTreeViewNodeExpand);
                treeView.element.attr("aria-label", "Document map area");
                var listItems = treeView.element.find("ul");
                utils.each(listItems, function() {
                    setNodeAccessibilityAttributes(this);
                });
            }
        }
        function isVisible() {
            var args = {};
            controller.getDocumentMapState(args);
            return args.visible;
        }
        function beginLoad() {
            $placeholder.addClass("trv-loading");
        }
        function endLoad() {
            $placeholder.removeClass("trv-loading");
        }
        var currentReport = null;
        var documentMapNecessary = false;
        function showDocumentMap(show) {
            var splitter = trv[options.viewerSelector + "-" + "splitter"];
            if (splitter) {
                (documentMapNecessary ? $.fn.removeClass : $.fn.addClass).call($placeholder.next(), "trv-hidden");
                splitter.toggle(".trv-document-map", show);
            }
        }
        function attach() {
            controller.beginLoadReport(function() {
                beginLoad();
                var r = controller.reportSource().report;
                var clearMapItems = currentReport !== r || !isVisible();
                currentReport = r;
                if (clearMapItems) {
                    clearDocumentMap();
                }
            }).reportLoadComplete(function(event, args) {
                if (args.documentMapAvailable) {
                    documentMapNecessary = true;
                    displayDocumentMap(args.documentMapNodes);
                    controller.setDocumentMapVisible({
                        enabled: true,
                        visible: documentMapVisible
                    });
                } else {
                    documentMapNecessary = false;
                    showDocumentMap(false);
                }
                endLoad();
            }).error(function(event, error) {
                endLoad();
                clearDocumentMap();
            }).getDocumentMapState(function(event, args) {
                args.enabled = documentMapNecessary;
                args.visible = documentMapVisible;
            }).setDocumentMapVisible(function(event, args) {
                documentMapVisible = args.visible;
                showDocumentMap(args.visible && documentMapNecessary);
            });
        }
        function replaceStringResources($documentMap) {
            var $documentMapOverlay = $documentMap.find(".trv-document-map-overlay");
            if (!$documentMapOverlay) {
                return;
            }
            $documentMapOverlay.attr("aria-label", sr[$documentMapOverlay.attr("aria-label")]);
        }
    }
    var pluginName = "telerik_ReportViewer_DocumentMapArea";
    $.fn[pluginName] = function(options, otherOptions) {
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new DocumentMapArea(this, options, otherOptions));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    trv.ParameterTypes = {
        INTEGER: "System.Int64",
        FLOAT: "System.Double",
        STRING: "System.String",
        DATETIME: "System.DateTime",
        BOOLEAN: "System.Boolean"
    };
    trv.parameterEditorsMatch = {
        MultiSelect: function(parameter, editorsType) {
            return Boolean(parameter.availableValues) && parameter.multivalue && (!editorsType || !editorsType.multiSelect || editorsType.multiSelect !== trv.ParameterEditorTypes.COMBO_BOX);
        },
        MultiSelectCombo: function(parameter, editorsType) {
            return Boolean(parameter.availableValues) && parameter.multivalue && (editorsType && editorsType.multiSelect && editorsType.multiSelect === trv.ParameterEditorTypes.COMBO_BOX);
        },
        SingleSelect: function(parameter, editorsType) {
            return Boolean(parameter.availableValues) && !parameter.multivalue && (!editorsType || !editorsType.singleSelect || editorsType.singleSelect !== trv.ParameterEditorTypes.COMBO_BOX);
        },
        SingleSelectCombo: function(parameter, editorsType) {
            return Boolean(parameter.availableValues) && !parameter.multivalue && (editorsType && editorsType.singleSelect && editorsType.singleSelect === trv.ParameterEditorTypes.COMBO_BOX);
        },
        MultiValue: function(parameter) {
            return Boolean(parameter.multivalue);
        },
        DateTime: function(parameter) {
            return parameter.type === trv.ParameterTypes.DATETIME;
        },
        String: function(parameter) {
            return parameter.type === trv.ParameterTypes.STRING;
        },
        Number: function(parameter) {
            switch (parameter.type) {
              case trv.ParameterTypes.INTEGER:
              case trv.ParameterTypes.FLOAT:
                return true;

              default:
                return false;
            }
        },
        Boolean: function(parameter) {
            return parameter.type === trv.ParameterTypes.BOOLEAN;
        },
        Default: function(parameter) {
            return true;
        }
    };
    var sr = trv.sr, utils = trv.utils;
    var multivalueUtils = function() {
        var lineSeparator = "\n";
        return {
            formatValue: function(value) {
                var text = "";
                if (value) {
                    [].concat(value).forEach(function(val) {
                        if (text.length > 0) {
                            text += lineSeparator;
                        }
                        text += val;
                    });
                }
                return text;
            },
            parseValues: function(text) {
                return ("" + text).split(lineSeparator);
            }
        };
    }();
    function integerInputBehavior(input) {
        function isValid(newValue) {
            return /^(\-|\+)?([0-9]*)$/.test(newValue);
        }
        function onKeyPress(event) {
            if (utils.isSpecialKey(event.keyCode)) {
                return true;
            }
            return isValid($(input).val() + String.fromCharCode(event.charCode));
        }
        function onPaste(event) {}
        function attach(input) {
            $(input).on("keypress", onKeyPress).on("paste", onPaste);
        }
        function detach(input) {
            $(input).off("keypress", onKeyPress).off("paste", onPaste);
        }
        attach(input);
        return {
            dispose: function() {
                detach(input);
            }
        };
    }
    function floatInputBehavior(input) {
        function isValid(newValue) {
            return /^(\-|\+)?([0-9]*(\.[0-9]*)?)$/.test(newValue);
        }
        function onKeyPress(event) {
            if (utils.isSpecialKey(event.keyCode)) {
                return true;
            }
            return isValid($(input).val() + String.fromCharCode(event.charCode));
        }
        function onPaste(event) {}
        function attach(input) {
            $(input).on("keypress", onKeyPress).on("paste", onPaste);
        }
        function detach(input) {
            $(input).off("keypress", onKeyPress).off("paste", onPaste);
        }
        attach(input);
        return {
            dispose: function() {
                detach(input);
            }
        };
    }
    function applyClass(apply, cssClass, item) {
        var fn = apply ? $.fn.addClass : $.fn.removeClass;
        fn.call(item, cssClass);
    }
    function enableItem(item, enable) {
        applyClass(!enable, "k-state-disabled", item);
    }
    function selectItem(item, select) {
        applyClass(select, "k-state-selected", item);
        item.attr("aria-selected", select);
    }
    function addAccessibilityAttributes(editor, type, caption, additionalInfo, error) {
        if (!additionalInfo) {
            additionalInfo = "";
        }
        var label = utils.stringFormat("{0}. {1} {2}. {3}", [ caption, type, sr.ariaLabelParameter, additionalInfo ]);
        editor.attr("aria-label", label);
        setAccessibilityErrorAttributes(editor, error);
    }
    var containerTabIndex;
    var editorsIndex = 0;
    function setEditorTabIndex(editor) {
        if (!containerTabIndex) {
            var $container = $("div.trv-parameters-area-content");
            if ($container.length > 0) {
                var tabIndexAttr = $container.attr("tabIndex");
                if (tabIndexAttr) {
                    containerTabIndex = utils.tryParseInt(tabIndexAttr);
                }
            }
            if (!containerTabIndex || isNaN(containerTabIndex)) {
                containerTabIndex = 300;
            }
        }
        var wrapper = editor.closest(".trv-parameter-value"), selectAll = wrapper.find(".trv-select-all"), clearSelection = wrapper.find(".trv-select-none"), widgetParent = editor.closest(".k-widget"), hasFocusableElement = widgetParent.find(".k-input"), isComboWidget = hasFocusableElement && hasFocusableElement.length;
        if (selectAll && selectAll.length) {
            selectAll.attr("tabindex", containerTabIndex + ++editorsIndex);
        }
        if (clearSelection && clearSelection.length) {
            clearSelection.attr("tabindex", containerTabIndex + ++editorsIndex);
        }
        if (isComboWidget) {
            hasFocusableElement.attr("tabindex", containerTabIndex + ++editorsIndex);
        } else {
            editor.attr("tabindex", containerTabIndex + ++editorsIndex);
        }
    }
    function setAccessibilityErrorAttributes(editor, error) {
        var errToken = utils.stringFormat(" {0}:", [ sr.ariaLabelErrorMessage ]);
        var label = editor.attr("aria-label");
        if (!label) {
            return;
        }
        var errIdx = label.indexOf(errToken);
        if (errIdx > -1) {
            label = label.substring(0, errIdx);
        }
        if (error && error !== "") {
            editor.attr("aria-required", true);
            editor.attr("aria-invalid", true);
            label += errToken + error;
        } else {
            editor.removeAttr("aria-invalid");
        }
        editor.attr("aria-label", label);
    }
    function navigatableEnabledForList(enableAccessibility) {
        return kendo.version >= "2017.3.1018" || enableAccessibility;
    }
    trv.parameterEditors = [ {
        match: trv.parameterEditorsMatch.MultiSelect,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder);
            var enabled = true;
            $placeholder.html(options.templates["trv-parameter-editor-available-values-multiselect"]);
            var $list = $placeholder.find(".trv-list"), $selectAll = $placeholder.find(".trv-select-all"), $selectNone = $placeholder.find(".trv-select-none"), listView, parameter, updateTimeout, valueChangeCallback = options.parameterChanged, initialized;
            $selectAll.text(sr[$selectAll.text()]);
            $selectAll.click(function(e) {
                e.preventDefault();
                if (!enabled) return;
                setSelectedItems(parameter.availableValues.map(function(av) {
                    return av.value;
                }));
            });
            $selectNone.text(sr[$selectNone.text()]);
            $selectNone.click(function(e) {
                e.preventDefault();
                if (!enabled) return;
                setSelectedItems([]);
            });
            function onSelectionChanged(selection) {
                if (initialized) {
                    applyAriaSelected(selection);
                    notifyParameterChanged(selection);
                }
            }
            function applyAriaSelected(selection) {
                var children = listView.element.children();
                utils.each(children, function() {
                    var $item = $(this);
                    var isSelected = selection.filter($item).length > 0;
                    $item.attr("aria-selected", isSelected);
                });
            }
            function notifyParameterChanged(selection) {
                var availableValues = parameter.availableValues, values = $.map(selection, function(item) {
                    return availableValues[$(item).index()].value;
                });
                clearPendingChange();
                var immediateUpdate = !parameter.autoRefresh && !parameter.childParameters;
                updateTimeout = window.setTimeout(function() {
                    if (!utils.areEqualArrays(parameter.value, values)) {
                        valueChangeCallback(parameter, values);
                    }
                    updateTimeout = null;
                }, immediateUpdate ? 0 : 1e3);
            }
            function clearPendingChange() {
                if (updateTimeout) {
                    window.clearTimeout(updateTimeout);
                }
            }
            function getSelectedItems() {
                return $(listView.element).find(".k-state-selected");
            }
            function onItemClick() {
                if (!enabled) return;
                $(this).toggleClass("k-state-selected");
                onSelectionChanged(getSelectedItems());
            }
            function onKeydown(event) {
                if (!enabled) return;
                if (event.which !== 32) {
                    return;
                }
                var focused = $(listView.element).find(".k-state-focused");
                if (focused.length > 0) {
                    focused.toggleClass("k-state-selected");
                    onSelectionChanged(getSelectedItems());
                    event.preventDefault();
                }
            }
            function init() {
                setEditorTabIndex($list);
                setSelectedItems(parameter.value);
                var element = $(listView.element);
                element.on("mousedown", ".trv-listviewitem", onItemClick);
                element.on("keydown", onKeydown);
                initialized = true;
            }
            function clear() {
                initialized = false;
                if (listView) {
                    $(listView.element).off("click", ".trv-listviewitem", onItemClick);
                    $(listView.element).off("keydown", onKeydown);
                }
            }
            function setSelectedItems(items) {
                setSelectedItemsCore(items);
                onSelectionChanged(getSelectedItems());
            }
            function setSelectedItemsCore(items) {
                if (!Array.isArray(items)) {
                    items = [ items ];
                }
                var children = listView.element.children();
                utils.each(parameter.availableValues, function(i, av) {
                    var selected = false;
                    utils.each(items, function(j, v) {
                        var availableValue = av.value;
                        if (v instanceof Date) {
                            availableValue = utils.parseToLocalDate(av.value);
                        }
                        selected = utils.areEqual(v, availableValue);
                        return !selected;
                    });
                    selectItem($(children[i]), selected);
                });
            }
            return {
                beginEdit: function(param) {
                    clear();
                    parameter = param;
                    $list.kendoListView({
                        template: '<div class="trv-listviewitem">${name}</div>',
                        dataSource: {
                            data: parameter.availableValues
                        },
                        selectable: false,
                        navigatable: navigatableEnabledForList(options.enableAccessibility)
                    });
                    listView = $list.data("kendoListView");
                    init();
                },
                enable: function(enable) {
                    enabled = enable;
                    enableItem($list, enabled);
                },
                clearPendingChange: clearPendingChange,
                addAccessibility: function(param) {
                    var info = utils.stringFormat(sr.ariaLabelParameterInfo, [ param.availableValues.length ]);
                    addAccessibilityAttributes($list, sr.ariaLabelMultiSelect, param.text, info, param.Error);
                    $list.attr("aria-multiselectable", "true");
                    var items = $list.find(".trv-listviewitem");
                    utils.each(items, function() {
                        $(this).attr("aria-label", this.innerText);
                    });
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($list, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.MultiSelectCombo,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder), enabled = true, selector = ".trv-combo", template = "trv-parameter-editor-available-values-multiselect-combo", valueChangeCallback = options.parameterChanged, $editorDom, $selectNone, $selectAll, editor, updateTimeout, parameter;
            $placeholder.html(options.templates[template]);
            $editorDom = $placeholder.find(selector);
            $selectNone = $placeholder.find(".trv-select-none");
            if ($selectNone) {
                $selectNone.text(sr[$selectNone.text()]);
                $selectNone.click(function(e) {
                    e.preventDefault();
                    editor.value([]);
                    editor.trigger("change");
                });
            }
            $selectAll = $placeholder.find(".trv-select-all");
            if ($selectAll) {
                $selectAll.text(sr[$selectAll.text()]);
                $selectAll.click(function(e) {
                    e.preventDefault();
                    if (!enabled) return;
                    var values = $.map(parameter.availableValues, function(dataItem) {
                        return dataItem.value;
                    });
                    editor.value(values);
                    editor.trigger("change");
                });
            }
            function onSelectionChanged(selection) {
                notifyParameterChanged(selection);
            }
            function notifyParameterChanged(values) {
                clearPendingChange();
                var immediateUpdate = !parameter.autoRefresh && !parameter.childParameters;
                updateTimeout = window.setTimeout(function() {
                    if (!utils.areEqualArrays(parameter.value, values)) {
                        valueChangeCallback(parameter, values);
                    }
                    updateTimeout = null;
                }, immediateUpdate ? 0 : 1e3);
            }
            function clearPendingChange() {
                if (updateTimeout) {
                    window.clearTimeout(updateTimeout);
                }
            }
            function getSelectedItems() {
                return editor.value();
            }
            function onChange() {
                onSelectionChanged(getSelectedItems());
            }
            function init() {
                setEditorTabIndex($editorDom);
                editor.bind("change", onChange);
            }
            function reset() {
                if (editor) {
                    editor.unbind("change", onChange);
                }
            }
            return {
                beginEdit: function(param) {
                    reset();
                    parameter = param;
                    $editorDom.kendoMultiSelect({
                        itemTemplate: '<div class="trv-editoritem">${name}</div>',
                        dataSource: parameter.availableValues,
                        dataTextField: "name",
                        dataValueField: "value",
                        value: parameter.value,
                        filter: "contains",
                        autoWidth: true,
                        clearButton: false
                    });
                    editor = $editorDom.data("kendoMultiSelect");
                    init($editorDom);
                },
                enable: function(enable) {
                    enabled = enable;
                    editor.enable(enable);
                },
                clearPendingChange: clearPendingChange,
                addAccessibility: function(param) {
                    var info = utils.stringFormat(sr.ariaLabelParameterInfo, [ param.availableValues.length ]);
                    addAccessibilityAttributes($editorDom, sr.ariaLabelSingleValue, param.text, info, param.Error);
                    var items = $editorDom.find(".trv-editoritem");
                    utils.each(items, function() {
                        $(this).attr("aria-label", this.innerText);
                    });
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($editorDom, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.SingleSelect,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder);
            var enabled = true;
            $placeholder.html(options.templates["trv-parameter-editor-available-values"]);
            var $list = $placeholder.find(".trv-list"), $selectNone = $placeholder.find(".trv-select-none"), listView, parameter, valueChangeCallback = options.parameterChanged;
            if ($selectNone) {
                $selectNone.text(sr[$selectNone.text()]);
                $selectNone.click(function(e) {
                    e.preventDefault();
                    listView.clearSelection();
                });
            }
            function onSelectionChanged(selection) {
                notifyParameterChanged(selection);
            }
            function notifyParameterChanged(selection) {
                var availableValues = parameter.availableValues, values = $.map(selection, function(item) {
                    return availableValues[$(item).index()].value;
                });
                if (Array.isArray(values)) {
                    values = values[0];
                }
                valueChangeCallback(parameter, values);
            }
            function getSelectedItems() {
                return listView.select();
            }
            function onChange() {
                onSelectionChanged(getSelectedItems());
            }
            function init() {
                setEditorTabIndex($list);
                setSelectedItems(parameter.value);
                listView.bind("change", onChange);
            }
            function reset() {
                if (listView) {
                    listView.unbind("change", onChange);
                }
            }
            function setSelectedItems(value) {
                var items = listView.element.children();
                utils.each(parameter.availableValues, function(i, av) {
                    var availableValue = av.value;
                    if (value instanceof Date) {
                        availableValue = utils.parseToLocalDate(av.value);
                    }
                    if (utils.areEqual(value, availableValue)) {
                        listView.select(items[i]);
                        return false;
                    }
                    return true;
                });
            }
            return {
                beginEdit: function(param) {
                    reset();
                    parameter = param;
                    $list.kendoListView({
                        template: '<div class="trv-listviewitem">${name}</div>',
                        dataSource: {
                            data: parameter.availableValues
                        },
                        selectable: true,
                        navigatable: navigatableEnabledForList(options.enableAccessibility)
                    });
                    listView = $list.data("kendoListView");
                    init($list);
                },
                enable: function(enable) {
                    enabled = enable;
                    enableItem($list, enabled);
                    if (enabled) {
                        listView.bind("change", onChange);
                        $list.addClass("k-selectable");
                    } else {
                        listView.unbind("change", onChange);
                        $list.removeClass("k-selectable");
                    }
                },
                addAccessibility: function(param) {
                    var info = utils.stringFormat(sr.ariaLabelParameterInfo, [ param.availableValues.length ]);
                    addAccessibilityAttributes($list, sr.ariaLabelSingleValue, param.text, info, param.Error);
                    var items = $list.find(".trv-listviewitem");
                    utils.each(items, function() {
                        $(this).attr("aria-label", this.innerText);
                    });
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($list, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.SingleSelectCombo,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder), enabled = true, selector = ".trv-combo", template = "trv-parameter-editor-available-values-combo", valueChangeCallback = options.parameterChanged, $editorDom, $selectNone, editor, parameter;
            $placeholder.html(options.templates[template]);
            $editorDom = $placeholder.find(selector);
            $selectNone = $placeholder.find(".trv-select-none");
            if ($selectNone) {
                $selectNone.text(sr[$selectNone.text()]);
                $selectNone.click(function(e) {
                    e.preventDefault();
                    editor.value("");
                    editor.trigger("change");
                });
            }
            function onSelectionChanged(selection) {
                notifyParameterChanged(selection);
            }
            function notifyParameterChanged(selection) {
                var values = "", availableValues;
                if (selection >= 0) {
                    availableValues = parameter.availableValues;
                    values = availableValues[selection].value;
                }
                valueChangeCallback(parameter, values);
            }
            function getSelectedItems() {
                return editor.select();
            }
            function onChange() {
                onSelectionChanged(getSelectedItems());
            }
            function init() {
                setEditorTabIndex($editorDom);
                editor.bind("change", onChange);
            }
            function reset() {
                if (editor) {
                    editor.unbind("change", onChange);
                }
            }
            return {
                beginEdit: function(param) {
                    reset();
                    parameter = param;
                    $editorDom.kendoComboBox({
                        template: '<div class="trv-editoritem">${name}</div>',
                        dataSource: parameter.availableValues,
                        dataTextField: "name",
                        dataValueField: "value",
                        value: parameter.value,
                        filter: "contains",
                        suggest: true,
                        autoWidth: true,
                        clearButton: false
                    });
                    editor = $editorDom.data("kendoComboBox");
                    init($editorDom);
                },
                enable: function(enable) {
                    enabled = enable;
                    editor.enable(enable);
                },
                addAccessibility: function(param) {
                    var info = utils.stringFormat(sr.ariaLabelParameterInfo, [ param.availableValues.length ]);
                    addAccessibilityAttributes($editorDom, sr.ariaLabelSingleValue, param.text, info, param.Error);
                    var items = $editorDom.find(".trv-editoritem");
                    utils.each(items, function() {
                        $(this).attr("aria-label", this.innerText);
                    });
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($editorDom, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.MultiValue,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder), parameter;
            $placeholder.html(options.templates["trv-parameter-editor-multivalue"]);
            var $textArea = $placeholder.find("textarea").on("change", function() {
                if (options.parameterChanged) {
                    options.parameterChanged(parameter, multivalueUtils.parseValues(this.value));
                }
            });
            function setValue(value) {
                parameter.value = value;
                $textArea.val(multivalueUtils.formatValue(value));
            }
            return {
                beginEdit: function(param) {
                    parameter = param;
                    setValue(param.value);
                    setEditorTabIndex($textArea);
                },
                enable: function(enable) {
                    enableItem($textArea, enable);
                    $textArea.prop("disabled", !enable);
                },
                addAccessibility: function(param) {
                    addAccessibilityAttributes($textArea, sr.ariaLabelMultiValue, param.text, null, param.Error);
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($textArea, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.DateTime,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder), parameter;
            $placeholder.html(options.templates["trv-parameter-editor-datetime"]);
            var $dateTimePicker = $placeholder.find("input[type=datetime]").kendoDatePicker({
                change: function() {
                    var handler = options.parameterChanged;
                    if (handler) {
                        var dtv = this.value();
                        if (null !== dtv) {
                            dtv = utils.adjustTimezone(dtv);
                        }
                        handler(parameter, dtv);
                    }
                }
            });
            var dateTimePicker = $dateTimePicker.data("kendoDatePicker");
            function setValue(value) {
                parameter.value = value;
                var dt = null;
                try {
                    if (value) {
                        dt = utils.unadjustTimezone(value);
                    }
                } catch (e) {
                    dt = null;
                }
                dateTimePicker.value(dt);
            }
            return {
                beginEdit: function(param) {
                    parameter = param;
                    setValue(param.value);
                    setEditorTabIndex($dateTimePicker);
                },
                enable: function(enable) {
                    dateTimePicker.enable(enable);
                    enableItem($dateTimePicker, enable);
                },
                addAccessibility: function(param) {
                    addAccessibilityAttributes($dateTimePicker, sr.ariaLabelParameterDateTime, param.text, null, param.Error);
                    $dateTimePicker.attr("aria-live", "assertive");
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($dateTimePicker, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.String,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder), parameter;
            $placeholder.html(options.templates["trv-parameter-editor-text"]);
            var $input = $placeholder.find('input[type="text"]').change(function() {
                if (options.parameterChanged) {
                    options.parameterChanged(parameter, $input.val());
                }
            });
            function setValue(value) {
                parameter.value = value;
                $input.val(value);
            }
            return {
                beginEdit: function(param) {
                    parameter = param;
                    setValue(param.value);
                    setEditorTabIndex($input);
                },
                enable: function(enabled) {
                    $input.prop("disabled", !enabled);
                    enableItem($input, enabled);
                },
                addAccessibility: function(param) {
                    addAccessibilityAttributes($input, sr.ariaLabelParameterString, param.text, null, param.Error);
                    $input.attr("aria-live", "assertive");
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($input, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.Number,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder), parameter, inputBehavior;
            $placeholder.html(options.templates["trv-parameter-editor-number"]);
            var $input = $placeholder.find("input[type=number]").on("change", function() {
                if (options.parameterChanged) {
                    options.parameterChanged(parameter, $input.val());
                }
            });
            function setValue(value) {
                parameter.value = value;
                $input.val(value);
            }
            return {
                beginEdit: function(param) {
                    if (inputBehavior) {
                        inputBehavior.dispose();
                    }
                    parameter = param;
                    $input.val(parameter.value);
                    if (parameter.type === trv.ParameterTypes.INTEGER) {
                        inputBehavior = integerInputBehavior($input);
                    } else {
                        inputBehavior = floatInputBehavior($input);
                    }
                    setEditorTabIndex($input);
                },
                enable: function(enable) {
                    $input.prop("disabled", !enable);
                    enableItem($input, enable);
                },
                addAccessibility: function(param) {
                    addAccessibilityAttributes($input, sr.ariaLabelParameterNumerical, param.text, null, param.Error);
                    $input.attr("aria-live", "assertive");
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($input, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.Boolean,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder), parameter;
            $placeholder.html(options.templates["trv-parameter-editor-boolean"]);
            var $input = $placeholder.find("input[type=checkbox]").on("change", function() {
                if (options.parameterChanged) {
                    options.parameterChanged(parameter, this.checked);
                }
            });
            function setValue(value) {
                parameter.value = value;
                $input[0].checked = value === true;
            }
            return {
                beginEdit: function(param) {
                    parameter = param;
                    setValue(param.value);
                    setEditorTabIndex($input);
                },
                enable: function(enable) {
                    enableItem($input, enable);
                    $input.attr("disabled", !enable);
                },
                addAccessibility: function(param) {
                    addAccessibilityAttributes($input, sr.ariaLabelParameterBoolean, param.text, null, param.Error);
                    $input.attr("aria-live", "assertive");
                },
                setAccessibilityErrorState: function(param) {
                    setAccessibilityErrorAttributes($input, param.Error);
                }
            };
        }
    }, {
        match: trv.parameterEditorsMatch.Default,
        createEditor: function(placeholder, options) {
            var $placeholder = $(placeholder);
            $placeholder.html('<div class="trv-parameter-editor-generic"></div>');
            return {
                beginEdit: function(parameter) {
                    $placeholder.find(".trv-parameter-editor-generic").html(parameter.Error ? "(error)" : parameter.value);
                },
                enable: function(enable) {}
            };
        }
    } ];
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr, utils = trv.utils;
    trv.parameterValidators = function() {
        var validators = {};
        function validateParameter(parameter, value, validatorFunc, compareFunc) {
            var values = [].concat(value).map(function(value1) {
                return checkAvailbaleValues(parameter, validatorFunc(value1), compareFunc);
            });
            if (parameter.multivalue) {
                if (value == null || value.length == 0) {
                    if (parameter.allowNull) {
                        return value;
                    } else {
                        throw sr.invalidParameter;
                    }
                }
                return values;
            }
            return values[0];
        }
        function isNull(parameter, value) {
            return parameter.allowNull && -1 != [ null, "", undefined ].indexOf(value);
        }
        function checkAvailbaleValues(parameter, value, compareFunc) {
            if (parameter.availableValues) {
                var found = false;
                utils.each(parameter.availableValues, function(i, av) {
                    found = compareFunc(value, av.value);
                    return !found;
                });
                if (!found) {
                    if (parameter.allowNull && !value) {
                        return value;
                    }
                    throw sr.invalidParameter;
                }
            }
            return value;
        }
        validators[trv.ParameterTypes.STRING] = {
            validate: function(parameter, value) {
                return validateParameter(parameter, value, function(value) {
                    if (!value) {
                        if (parameter.allowNull) {
                            return null;
                        }
                        if (parameter.allowBlank) {
                            return "";
                        }
                        throw sr.parameterIsEmpty;
                    }
                    return value;
                }, function(s1, s2) {
                    return s1 == s2;
                });
            }
        };
        validators[trv.ParameterTypes.FLOAT] = {
            validate: function(parameter, value) {
                return validateParameter(parameter, value, function(value) {
                    var num = utils.tryParseFloat(value);
                    if (isNaN(num)) {
                        if (isNull(parameter, value)) {
                            return null;
                        }
                        throw sr.parameterIsEmpty;
                    }
                    return num;
                }, function(f1, f2) {
                    return utils.tryParseFloat(f1) == utils.tryParseFloat(f2);
                });
            }
        };
        validators[trv.ParameterTypes.INTEGER] = {
            validate: function(parameter, value) {
                return validateParameter(parameter, value, function(value) {
                    var num = utils.tryParseInt(value);
                    if (isNaN(num)) {
                        if (isNull(parameter, value)) {
                            return null;
                        }
                        throw sr.parameterIsEmpty;
                    }
                    return num;
                }, function(n1, n2) {
                    return utils.tryParseInt(n1) == utils.tryParseFloat(n2);
                });
            }
        };
        validators[trv.ParameterTypes.DATETIME] = {
            validate: function(parameter, value) {
                return validateParameter(parameter, value, function(value) {
                    if (parameter.allowNull && (value === null || value === "" || value === undefined)) {
                        return null;
                    }
                    if (!isNaN(Date.parse(value))) {
                        return utils.parseToLocalDate(value);
                    }
                    throw sr.invalidDateTimeValue;
                }, function(d1, d2) {
                    d1 = utils.parseToLocalDate(d1);
                    d2 = utils.parseToLocalDate(d2);
                    return d1.getTime() == d2.getTime();
                });
            }
        };
        validators[trv.ParameterTypes.BOOLEAN] = {
            validate: function(parameter, value) {
                return validateParameter(parameter, value, function(value) {
                    if (-1 != [ "true", "false" ].indexOf(("" + value).toLowerCase())) {
                        return Boolean(value);
                    }
                    if (isNull(parameter, value)) {
                        return null;
                    }
                    throw sr.parameterIsEmpty;
                }, function(b1, b2) {
                    return Boolean(b1) == Boolean(b2);
                });
            }
        };
        return {
            validate: function(parameter, value) {
                var v = validators[parameter.type];
                if (!v) {
                    throw utils.stringFormat(sr.cannotValidateType, parameter);
                }
                return v.validate(parameter, value);
            }
        };
    }();
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr, utils = trv.utils, parameterValidators = trv.parameterValidators;
    var defaultOptions = {};
    var Events = {
        PARAMETERS_READY: "pa.parametersReady",
        ERROR: "pa.Error"
    };
    function ParametersArea(placeholder, options, otherOptions) {
        options = $.extend({}, defaultOptions, options, otherOptions);
        var parametersArea = {};
        var $parametersArea = $(parametersArea);
        var editors = {};
        var controller = options.controller;
        if (!controller) {
            throw "No controller (telerikReporting.reportViewerController) has been specified.";
        }
        var parameterEditors = [].concat(options.parameterEditors, trv.parameterEditors);
        var recentParameterValues, parameters, initialParameterValues = undefined;
        var $placeholder = $(placeholder), $content = $placeholder.find(".trv-parameters-area-content"), $errorMessage = $placeholder.find(".trv-error-message"), $previewButton = $placeholder.find(".trv-parameters-area-preview-button"), noParametersContent = $placeholder.html();
        $previewButton.text(sr[$previewButton.text()]);
        $previewButton.attr("aria-label", sr[$previewButton.attr("aria-label")]);
        $previewButton.on("click", function(e) {
            e.preventDefault();
            if (allParametersValid()) {
                applyParameters();
            }
        });
        var parameterContainerTemplate = options.templates["trv-parameter"];
        var parametersAreaVisible = options.parametersAreaVisible !== false;
        var enableAccessibility = options.enableAccessibility;
        init();
        function init() {
            replaceStringResources($placeholder);
        }
        function replaceStringResources($paramsArea) {
            var $previewButton = $paramsArea.find(".trv-parameters-area-preview-button");
            if (!$previewButton) {
                return;
            }
            $previewButton.attr("aria-label", sr[$previewButton.attr("aria-label")]);
            $previewButton.text(sr[$previewButton.text()]);
        }
        function createParameterContainer() {
            return $(parameterContainerTemplate);
        }
        function createParameterUI(parameter) {
            var $container = createParameterContainer(), $editorPlaceholder = $container.find(".trv-parameter-value"), $title = $container.find(".trv-parameter-title"), $error = $container.find(".trv-parameter-error"), $errorMessage = $container.find(".trv-parameter-error-message"), $useDefaultValueCheckbox = $container.find(".trv-parameter-use-default input"), editorsTypes = options.parameters && options.parameters.editors ? options.parameters.editors : null, editorFactory = selectParameterEditorFactory(parameter, editorsTypes);
            var parameterText = parameter.text;
            var isHiddenParameter = !parameter.isVisible;
            if (isHiddenParameter) {
                parameterText += " [<b>hidden</b>]";
            }
            $title.html(parameterText).attr("title", parameterText);
            $errorMessage.html(parameter.Error);
            (parameter.Error ? $.fn.show : $.fn.hide).call($error);
            var editor = editorFactory.createEditor($editorPlaceholder, {
                templates: options.templates,
                parameterChanged: function(parameter, newValue) {
                    try {
                        newValue = parameterValidators.validate(parameter, newValue);
                        $error.hide();
                        onParameterChanged(parameter, newValue);
                    } catch (error) {
                        parameter.Error = error;
                        parameter.value = [];
                        $errorMessage.html(error);
                        $error.show();
                        enablePreviewButton(false);
                    } finally {
                        setAccessibilityErrorState(parameter);
                    }
                },
                enableAccessibility: enableAccessibility
            });
            editors[parameter.id] = editor;
            editor.beginEdit(parameter);
            if (enableAccessibility && !isHiddenParameter) {
                editor.addAccessibility(parameter);
            }
            if ($useDefaultValueCheckbox.length > 0) {
                $useDefaultValueCheckbox.on("click", function() {
                    var useDefaultValue = $(this).is(":checked");
                    if (useDefaultValue) {
                        delete recentParameterValues[parameter.id];
                        delete initialParameterValues[parameter.id];
                        invalidateChildParameters(parameter);
                        updateParameters(onLoadParametersSuccess);
                    } else {
                        recentParameterValues[parameter.id] = parameter.value;
                        initialParameterValues[parameter.id] = parameter.value;
                    }
                    editor.enable(!useDefaultValue);
                    raiseParametersReady();
                });
                var hasInitialValues = initialParameterValues !== null;
                if (hasInitialValues) {
                    if (!(parameter.id in initialParameterValues)) {
                        $useDefaultValueCheckbox.prop("checked", true);
                        editor.enable(false);
                    }
                } else if (isHiddenParameter) {
                    $useDefaultValueCheckbox.prop("checked", true);
                    editor.enable(false);
                }
            }
            return $container;
        }
        function setAccessibilityErrorState(parameter) {
            var editor = editors[parameter.id];
            if (!editor || !enableAccessibility) {
                return;
            }
            editor.setAccessibilityErrorState(parameter);
        }
        function enablePreviewButton(enabled) {
            if (enabled) {
                $previewButton.prop("disabled", false);
                $previewButton.removeClass("k-state-disabled");
            } else {
                $previewButton.prop("disabled", true);
                $previewButton.addClass("k-state-disabled");
            }
        }
        function selectParameterEditorFactory(parameter, editorsType) {
            var factory;
            utils.each(parameterEditors, function() {
                if (this && this.match(parameter, editorsType)) {
                    factory = this;
                }
                return !factory;
            });
            return factory;
        }
        function showError(error) {
            $errorMessage.html(error);
            (error ? $.fn.addClass : $.fn.removeClass).call($placeholder, "trv-error");
        }
        function showPreviewButton() {
            (allParametersAutoRefresh(parameters) ? $.fn.removeClass : $.fn.addClass).call($placeholder, "preview");
        }
        function allParametersAutoRefresh() {
            var allAuto = true;
            utils.each(parameters, function() {
                return allAuto = !this.isVisible || this.autoRefresh;
            });
            return allAuto;
        }
        function allParametersValid() {
            var allValid = true;
            utils.each(parameters, function() {
                return allValid = !this.Error;
            });
            return allValid;
        }
        function fill(newParameters) {
            recentParameterValues = {};
            parameters = newParameters || [];
            editors = {};
            var $parameterContainer, $tempContainer = $("<div></div>");
            utils.each(parameters, function() {
                try {
                    this.value = parameterValidators.validate(this, this.value);
                } catch (e) {
                    this.Error = this.Error || e;
                }
                var hasError = Boolean(this.Error), hasValue = !hasError;
                if (hasValue) {
                    recentParameterValues[this.id] = this.value;
                } else {
                    this.Error = sr.invalidParameter;
                }
                if (this.isVisible || options.showHiddenParameters) {
                    $parameterContainer = createParameterUI(this);
                    if ($parameterContainer) {
                        $tempContainer.append($parameterContainer);
                    }
                }
            });
            if (initialParameterValues !== undefined) {
                if (null === initialParameterValues) {
                    initialParameterValues = {};
                    utils.each(parameters, function() {
                        if (this.isVisible) {
                            initialParameterValues[this.id] = this.value;
                        } else {
                            delete recentParameterValues[this.id];
                        }
                    });
                } else {
                    utils.each(parameters, function() {
                        if (!(this.id in initialParameterValues)) {
                            delete recentParameterValues[this.id];
                        }
                    });
                }
            }
            $content.empty();
            if (parameters.length > 0) {
                $content.append($tempContainer.children());
                if (enableAccessibility) {
                    $content.attr("aria-label", "Parameters area. Contains " + parameters.length + " parameters.");
                }
            } else {
                $content.append(noParametersContent);
            }
            showPreviewButton(parameters);
            var allValid = allParametersValid();
            enablePreviewButton(allValid);
        }
        function applyParameters() {
            controller.setParameters($.extend({}, recentParameterValues));
            controller.previewReport(false);
        }
        function allParametersValidForAutoRefresh() {
            var triggerAutoUpdate = true;
            for (var i = parameters.length - 1; triggerAutoUpdate && i >= 0; i--) {
                var p = parameters[i];
                triggerAutoUpdate = p.id in recentParameterValues && (Boolean(p.autoRefresh) || !p.isVisible);
            }
            return triggerAutoUpdate;
        }
        function raiseParametersReady() {
            parametersArea.parametersReady(recentParameterValues);
        }
        function tryRefreshReport() {
            raiseParametersReady();
            if (allParametersValidForAutoRefresh()) {
                applyParameters();
            }
        }
        function invalidateChildParameters(parameter) {
            if (parameter.childParameters) {
                utils.each(parameter.childParameters, function(index, parameterId) {
                    var childParameter = getParameterById(parameterId);
                    if (childParameter) {
                        invalidateChildParameters(childParameter);
                    }
                    delete recentParameterValues[parameterId];
                    resetPendingParameterChange(parameterId);
                });
            }
        }
        function resetPendingParameterChange(parameterId) {
            if (editors) {
                var editor = editors[parameterId];
                if (editor && typeof editor.clearPendingChange === "function") {
                    editor.clearPendingChange();
                }
            }
        }
        function onParameterChanged(parameter, newValue) {
            delete parameter["Error"];
            parameter.value = newValue;
            recentParameterValues[parameter.id] = newValue;
            if (initialParameterValues !== undefined) {
                if (parameter.id in initialParameterValues) {
                    recentParameterValues[parameter.id] = newValue;
                }
            } else {
                recentParameterValues[parameter.id] = newValue;
            }
            invalidateChildParameters(parameter);
            if (parameter.childParameters) {
                updateParameters(tryRefreshReport);
            } else {
                var allValid = allParametersValid();
                enablePreviewButton(allValid);
                if (allValid) {
                    tryRefreshReport();
                }
            }
        }
        function getParameterById(parameterId) {
            if (parameters) {
                for (var i = 0; i < parameters.length; i++) {
                    var p = parameters[i];
                    if (p.id === parameterId) {
                        return p;
                    }
                }
            }
            return null;
        }
        function setParametersAreaVisibility(visible) {
            controller.setParametersAreaVisible({
                visible: visible
            });
        }
        function hasVisibleParameters(params) {
            if (!params || null === params) {
                return false;
            }
            var result = false;
            utils.each(params, function() {
                result = this.isVisible;
                return !result;
            });
            return result;
        }
        var loadingCount = 0;
        function beginLoad() {
            loadingCount++;
            $placeholder.addClass("trv-loading");
        }
        function endLoad() {
            if (loadingCount > 0) {
                if (0 === --loadingCount) {
                    $placeholder.removeClass("trv-loading");
                }
            }
        }
        var parametersAreaNecessary = false;
        function onLoadParametersComplete(params, successAction) {
            parametersAreaNecessary = hasVisibleParameters(params);
            if (!parametersAreaNecessary) {
                showParametersArea(false);
            }
            fill(params);
            showError("");
            if (parametersAreaNecessary && parametersAreaVisible) {
                showParametersArea(true);
            }
            controller.updateUIInternal();
            if (typeof successAction === "function") {
                successAction();
            }
            endLoad();
        }
        function updateParameters(successAction) {
            acceptParameters(controller.loadParameters(recentParameterValues), successAction);
        }
        function acceptParameters(controllerLoadParametersPromise, successAction) {
            beginLoad();
            controllerLoadParametersPromise.then(function(parameters) {
                onLoadParametersComplete(parameters, successAction);
            }).catch(function(error) {
                endLoad();
                clear();
                if (!$placeholder.hasClass("trv-hidden")) {
                    showError(error);
                }
                parametersArea.error(error);
            });
        }
        function getEventHandlerFromArguments(args) {
            var arg0;
            if (args && args.length) {
                arg0 = args[0];
            }
            if (typeof arg0 === "function") {
                return arg0;
            }
            return null;
        }
        function eventFactory(event, args) {
            var h = getEventHandlerFromArguments(args);
            if (h) {
                $parametersArea.on(event, h);
            } else {
                $parametersArea.trigger(event, args);
            }
            return controller;
        }
        function onLoadParametersSuccess() {
            if (initialParameterValues === null) {
                initialParameterValues = $.extend({}, recentParameterValues);
            }
            raiseParametersReady();
        }
        function showParametersArea(show) {
            var splitter = trv[options.viewerSelector + "-" + "splitter"];
            if (splitter) {
                (parametersAreaNecessary ? $.fn.removeClass : $.fn.addClass).call($placeholder.prev(), "trv-hidden");
                splitter.toggle(".trv-parameters-area", show);
            }
        }
        function onReloadParameters(event, controllerLoadParametersPromise) {
            showError();
            $content.empty();
            acceptParameters(controllerLoadParametersPromise, onLoadParametersSuccess);
        }
        controller.reloadParameters(onReloadParameters).getParametersAreaState(function(event, args) {
            var parametersAreaNecessary = false;
            if (parameters) {
                parametersAreaNecessary = hasVisibleParameters(parameters);
            }
            args.enabled = parametersAreaNecessary;
            args.visible = parametersAreaVisible;
        }).setParametersAreaVisible(function(event, args) {
            parametersAreaVisible = args.visible;
            showParametersArea(args.visible && hasVisibleParameters(parameters));
        }).beforeLoadReport(function() {
            loadingCount = 0;
            beginLoad();
        }).error(endLoad).pageReady(function() {
            endLoad();
        });
        function clear() {
            fill([]);
        }
        $.extend(parametersArea, {
            allParametersValid: function() {
                return allParametersValid();
            },
            clear: function() {
                clear();
            },
            error: function() {
                return eventFactory(Events.ERROR, arguments);
            },
            parametersReady: function() {
                return eventFactory(Events.PARAMETERS_READY, arguments);
            },
            setParameters: function(parameterValues) {
                initialParameterValues = null === parameterValues ? null : $.extend({}, parameterValues);
            }
        });
        return parametersArea;
    }
    var pluginName = "telerik_ReportViewer_ParametersArea";
    $.fn[pluginName] = function(options, otherOptions) {
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new ParametersArea(this, options, otherOptions));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReporting.utils";
    }
    function uiController(options) {
        var stateFlags = {
            ExportInProgress: 1 << 0,
            PrintInProgress: 1 << 1
        };
        function getState(flags) {
            return (state & flags) != 0;
        }
        function setState(flags, value) {
            if (value) {
                state |= flags;
            } else {
                state &= ~flags;
            }
        }
        var controller = options.controller, historyManager = options.history, state = 0, refreshUI, commands = options.commands;
        if (!controller) {
            throw "No controller (telerikReporting.ReportViewerController) has been specified.";
        }
        function getDocumentMapState() {
            var args = {};
            controller.getDocumentMapState(args);
            return args;
        }
        function getParametersAreaState() {
            var args = {};
            controller.getParametersAreaState(args);
            return args;
        }
        function getSearchDialogState() {
            var args = {};
            controller.getSearchDialogState(args);
            return args;
        }
        function getSendEmailDialogState() {
            var args = {};
            controller.getSendEmailDialogState(args);
            return args;
        }
        function updateUI() {
            if (!refreshUI) {
                refreshUI = true;
                window.setTimeout(function() {
                    try {
                        updateUICore();
                    } finally {
                        refreshUI = false;
                    }
                }, 10);
            }
        }
        function updateUICore() {
            var rs = controller.reportSource();
            var pageCount = controller.pageCount();
            var currentPageNumber = controller.currentPageNumber();
            var hasReport = rs && rs.report;
            var hasPages = hasReport && pageCount > 0;
            var nextPage = hasPages && currentPageNumber < pageCount;
            var prevPage = hasPages && currentPageNumber > 1;
            var hasPage = hasPages && currentPageNumber;
            var documentMapState = getDocumentMapState();
            var parametersAreaState = getParametersAreaState();
            var searchDialogState = getSearchDialogState();
            var sendEmailDialogState = getSendEmailDialogState();
            commands.goToFirstPage.enabled(prevPage);
            commands.goToPrevPage.enabled(prevPage);
            commands.goToLastPage.enabled(nextPage);
            commands.goToNextPage.enabled(nextPage);
            commands.goToPage.enabled(hasPages);
            commands.print.enabled(hasPages && !getState(stateFlags.PrintInProgress));
            commands.export.enabled(hasPages && !getState(stateFlags.ExportInProgress));
            commands.refresh.enabled(hasReport);
            commands.historyBack.enabled(historyManager && historyManager.canMoveBack());
            commands.historyForward.enabled(historyManager && historyManager.canMoveForward());
            commands.toggleDocumentMap.enabled(hasReport && documentMapState.enabled).checked(documentMapState.enabled && documentMapState.visible);
            commands.toggleParametersArea.enabled(hasReport && parametersAreaState.enabled).checked(parametersAreaState.enabled && parametersAreaState.visible);
            commands.togglePrintPreview.enabled(hasPages).checked(controller.viewMode() == trv.ViewModes.PRINT_PREVIEW);
            commands.pageMode.enabled(hasPages).checked(controller.pageMode() == trv.PageModes.CONTINUOUS_SCROLL);
            commands.zoom.enabled(hasPage);
            commands.zoomIn.enabled(hasPage);
            commands.zoomOut.enabled(hasPage);
            commands.toggleZoomMode.enabled(hasPage);
            commands.toggleSearchDialog.enabled(hasPages).checked(searchDialogState.visible);
            commands.toggleSendEmailDialog.enabled(hasPages).checked(sendEmailDialogState.visible);
            controller.updateUI(null);
            controller.pageNumberChange(currentPageNumber);
            controller.pageCountChange(pageCount);
        }
        function getScaleMode() {
            var args = {};
            controller.getScale(args);
            return args.scaleMode;
        }
        controller.scale(function(event, args) {
            commands.toggleZoomMode.checked(args.scaleMode === trv.ScaleModes.FIT_PAGE || args.scaleMode === trv.ScaleModes.FIT_PAGE_WIDTH);
        });
        controller.currentPageChanged(updateUI);
        controller.beforeLoadReport(updateUI);
        controller.reportLoadProgress(updateUI);
        controller.reportLoadComplete(updateUI);
        controller.reportSourceChanged(updateUI);
        controller.viewModeChanged(updateUI);
        controller.pageModeChanged(function() {
            updateUI();
        });
        controller.setParametersAreaVisible(updateUI);
        controller.setDocumentMapVisible(updateUI);
        controller.setUIState(function(event, args) {
            setState(stateFlags[args.operationName], args.inProgress);
            updateUI();
        });
        controller.error(function() {
            setState(stateFlags.ExportInProgress, false);
            setState(stateFlags.PrintInProgress, false);
            updateUI();
        });
        controller.updateUIInternal(updateUI);
        controller.setSearchDialogVisible(updateUI);
        controller.setSendEmailDialogVisible(updateUI);
        updateUI();
    }
    trv.uiController = uiController;
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, window, document, undefined) {
    "use strict";
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReporting.utils";
    }
    trv.HistoryManager = function(options) {
        var controller = options.controller;
        var clientHasExpired = false;
        if (!controller) {
            throw "No controller (telerikReporting.reportViewerController) has been specified.";
        }
        var settings = options.settings, history = settings.history() || {
            records: [],
            position: -1
        };
        controller.onLoadedReportChange(function() {
            clientHasExpired = false;
            addToHistory(true);
        }).currentPageChanged(function() {
            updatePageInfo();
        }).reportLoadComplete(function(event, args) {
            addToHistory(false);
        }).clientExpired(function() {
            clientHasExpired = true;
            var records = history.records;
            for (var i = 0; i < records.length; i++) {
                records[i].reportDocumentId = null;
            }
        });
        function getCurrentRecord() {
            var records = history.records;
            if (records.length > 0) {
                return records[history.position];
            }
            return null;
        }
        function pushRecord(rec) {
            var records = history.records, position = history.position;
            records = Array.prototype.slice.call(records, 0, position + 1);
            records.push(rec);
            history.records = records;
            history.position = records.length - 1;
            saveSettings();
        }
        function saveSettings() {
            settings.history(history);
        }
        function updatePageInfo() {
            var currentRecord = getCurrentRecord();
            if (currentRecord) {
                currentRecord.pageNumber = controller.currentPageNumber();
                currentRecord.viewMode = controller.viewMode();
                currentRecord.reportDocumentId = controller.reportDocumentIdExposed();
                saveSettings();
            }
        }
        function addToHistory(temp) {
            removeTempRecordsFromHistory();
            var currentRecord = getCurrentRecord();
            var rs = controller.reportSource();
            if (!currentRecord || !utils.reportSourcesAreEqual(currentRecord.reportSource, rs)) {
                pushRecord({
                    reportSource: rs,
                    pageNumber: 1,
                    temp: temp
                });
            }
        }
        function exec(currentRecord) {
            controller.setViewMode(currentRecord.viewMode);
            controller.reportSource(currentRecord.reportSource);
            controller.refreshReport(false, currentRecord.reportDocumentId);
            controller.navigateToPage(currentRecord.pageNumber);
        }
        function canMove(step) {
            var position = history.position, length = history.records.length, newPos = position + step;
            return 0 <= newPos && newPos < length;
        }
        function move(step) {
            var position = history.position, length = history.records.length, newPos = position + step;
            if (newPos < 0) {
                newPos = 0;
            } else if (newPos >= length) {
                newPos = length - 1;
            }
            if (newPos != position) {
                history.position = newPos;
                saveSettings();
                exec(getCurrentRecord());
            }
        }
        function removeTempRecordsFromHistory() {
            var lastIndex = history.records.length - 1;
            while (lastIndex >= 0) {
                if (history.records[lastIndex].temp === true) {
                    history.records.splice(lastIndex, 1);
                    if (history.position >= lastIndex) {
                        history.position--;
                    }
                } else {
                    break;
                }
                lastIndex--;
            }
        }
        return {
            back: function() {
                move(-1);
            },
            forward: function() {
                move(+1);
            },
            canMoveBack: function() {
                return canMove(-1);
            },
            canMoveForward: function() {
                return canMove(1);
            },
            loadCurrent: function() {
                var rec = getCurrentRecord();
                if (rec) {
                    exec(rec);
                }
                return Boolean(rec);
            }
        };
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReporting.utils";
    }
    var scaleTransitionMap = {};
    scaleTransitionMap[trv.ScaleModes.FIT_PAGE] = {
        scaleMode: trv.ScaleModes.FIT_PAGE_WIDTH
    };
    scaleTransitionMap[trv.ScaleModes.FIT_PAGE_WIDTH] = {
        scaleMode: trv.ScaleModes.SPECIFIC,
        scale: 1
    };
    scaleTransitionMap[trv.ScaleModes.SPECIFIC] = {
        scaleMode: trv.ScaleModes.FIT_PAGE
    };
    var scaleValues = [ .1, .25, .5, .75, 1, 1.5, 2, 4, 8 ];
    function CommandSet(options) {
        var controller = options.controller;
        if (!controller) {
            throw "No options.controller.";
        }
        var historyManager = options.history;
        if (!historyManager) {
            throw "No options.history.";
        }
        function getDocumentMapVisible() {
            var args = {};
            controller.getDocumentMapState(args);
            return Boolean(args.visible);
        }
        function getParametersAreaVisible() {
            var args = {};
            controller.getParametersAreaState(args);
            return Boolean(args.visible);
        }
        function getSideMenuVisible() {
            var args = {};
            controller.getSideMenuVisible(args);
            return Boolean(args.visible);
        }
        function getSearchDialogVisible() {
            var args = {};
            controller.getSearchDialogState(args);
            return Boolean(args.visible);
        }
        function getSendEmailDialogVisible() {
            var args = {};
            controller.getSendEmailDialogState(args);
            return Boolean(args.visible);
        }
        return {
            historyBack: new command(function() {
                historyManager.back();
            }),
            historyForward: new command(function() {
                historyManager.forward();
            }),
            goToPrevPage: new command(function() {
                controller.navigateToPage(controller.currentPageNumber() - 1);
            }),
            goToNextPage: new command(function() {
                controller.navigateToPage(controller.currentPageNumber() + 1);
            }),
            goToFirstPage: new command(function() {
                controller.navigateToPage(1);
            }),
            goToLastPage: new command(function() {
                controller.navigateToPage(controller.pageCount());
            }),
            goToPage: new command(function(pageNumber) {
                if (!isNaN(pageNumber)) {
                    var pageCount = controller.pageCount();
                    if (pageNumber > pageCount) {
                        pageNumber = pageCount;
                    } else if (pageNumber < 1) {
                        pageNumber = 1;
                    }
                    controller.navigateToPage(pageNumber);
                    return pageNumber;
                }
            }),
            refresh: new command(function() {
                controller.refreshReport(true);
            }),
            export: new command(function(format) {
                if (format) {
                    controller.exportReport(format);
                }
            }),
            print: new command(function() {
                controller.printReport();
            }),
            pageMode: new command(function() {
                controller.pageMode(controller.pageMode() == trv.PageModes.SINGLE_PAGE ? trv.PageModes.CONTINUOUS_SCROLL : trv.PageModes.SINGLE_PAGE);
            }),
            togglePrintPreview: new command(function() {
                controller.viewMode(controller.viewMode() == trv.ViewModes.PRINT_PREVIEW ? trv.ViewModes.INTERACTIVE : trv.ViewModes.PRINT_PREVIEW);
            }),
            toggleDocumentMap: new command(function() {
                controller.setDocumentMapVisible({
                    visible: !getDocumentMapVisible()
                });
            }),
            toggleParametersArea: new command(function() {
                controller.setParametersAreaVisible({
                    visible: !getParametersAreaVisible()
                });
            }),
            zoom: new command(function(scale) {
                controller.scale({
                    scale: 1
                });
            }),
            zoomIn: new command(function() {
                zoom(1);
            }),
            zoomOut: new command(function() {
                zoom(-1);
            }),
            toggleSideMenu: new command(function() {
                controller.setSideMenuVisible({
                    visible: !getSideMenuVisible()
                });
            }),
            toggleZoomMode: new command(function(Ðµ) {
                var args = {};
                controller.getScale(args);
                controller.scale(scaleTransitionMap[args.scaleMode]);
            }),
            toggleSearchDialog: new command(function() {
                controller.setSearchDialogVisible({
                    visible: !getSearchDialogVisible()
                });
            }),
            toggleSendEmailDialog: new command(function() {
                controller.setSendEmailDialogVisible({
                    visible: !getSendEmailDialogVisible()
                });
            })
        };
        function zoom(step) {
            var args = {};
            controller.getScale(args);
            args.scale = getZoomScale(args.scale, step);
            args.scaleMode = trv.ScaleModes.SPECIFIC;
            controller.scale(args);
        }
        function getZoomScale(scale, steps) {
            var pos = -1, length = scaleValues.length;
            for (var i = 0; i < length; i++) {
                var value = scaleValues[i];
                if (scale < value) {
                    pos = i - .5;
                    break;
                }
                if (scale == value) {
                    pos = i;
                    break;
                }
            }
            pos = pos + steps;
            if (steps >= 0) {
                pos = Math.round(pos - .49);
            } else {
                pos = Math.round(pos + .49);
            }
            if (pos < 0) {
                pos = 0;
            } else if (pos > length - 1) {
                pos = length - 1;
            }
            return scaleValues[pos];
        }
    }
    trv.CommandSet = CommandSet;
    function command(execCallback) {
        var enabledState = true;
        var checkedState = false;
        var cmd = {
            enabled: function(state) {
                if (arguments.length == 0) {
                    return enabledState;
                }
                var newState = Boolean(state);
                enabledState = newState;
                $(this).trigger("enabledChanged");
                return cmd;
            },
            checked: function(state) {
                if (arguments.length == 0) {
                    return checkedState;
                }
                var newState = Boolean(state);
                checkedState = newState;
                $(this).trigger("checkedChanged");
                return cmd;
            },
            exec: execCallback
        };
        return cmd;
    }
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReporting.utils";
    }
    var lastSelectedMenuItem, lastSelectedSubmenuItem;
    function MainMenu(dom, rootOptions, otherOptions) {
        var options = $.extend({}, rootOptions, otherOptions), menu = $(dom).data("kendoMenu"), childrenL1 = dom.childNodes, controller = options.controller, enableAccessibility = options.enableAccessibility;
        if (!controller) {
            throw "No controller (telerikReporting.ReportViewerController) has been specified.";
        }
        if (!menu) {
            init();
        }
        controller.reportLoadComplete(function(e, args) {
            if (!enableAccessibility) {
                if (menu && menu._oldHoverItem) {
                    menu._oldHoverItem.toggleClass("k-state-focused");
                }
            }
        });
        function init() {
            menu = $(dom).kendoMenu().data("kendoMenu"), menu.bind("open", onSubmenuOpen);
            menu.bind("activate", onSubmenuActivate);
            menu.bind("deactivate", onSubmenuDeactivate);
            menu.element.off("keydown", onMenuKeyDown);
            menu.element.on("keydown", onMenuKeyDown);
            if (options.enableAccessibility) {
                setTabIndexes();
            }
            replaceStringResources();
        }
        function setTabIndexes() {
            var $menus = $.find('[data-role="telerik_ReportViewer_MainMenu"]');
            utils.each($menus, function() {
                var $menuArea = $(this);
                var listItems = $menuArea.find("li");
                var menuTabIndex = 0;
                var tabIndexAttr = $menuArea.attr("tabIndex");
                if (tabIndexAttr) {
                    menuTabIndex = utils.tryParseInt(tabIndexAttr);
                    if (!menuTabIndex || isNaN(menuTabIndex)) {
                        menuTabIndex = 0;
                    }
                }
                setMenuItemsTabIndexes(listItems, menuTabIndex);
                var pager = listItems.find('input[data-role="telerik_ReportViewer_PageNumberInput"]');
                if (pager.length > 0) {
                    pager.attr("tabindex", menuTabIndex);
                }
            });
        }
        function setMenuItemsTabIndexes(listItems, menuTabIndex) {
            utils.each(listItems, function() {
                var $item = $(this);
                $item.attr("tabindex", menuTabIndex);
                $item.focus(function() {
                    $item.addClass("k-state-focused");
                });
                $item.blur(function() {
                    $item.removeClass("k-state-focused");
                });
                var anchor = $item.children("a");
                if (anchor.length > 0) {
                    var $anchor = $(anchor);
                    $anchor.attr("tabindex", -1);
                    $item.attr("title", $anchor.attr("title"));
                }
                $item.off("keydown");
                $item.on("keydown", function(event) {
                    if (event.which == kendo.keys.ENTER) {
                        clickOnMenuItem($item);
                        lastSelectedMenuItem = $item;
                    }
                });
            });
        }
        function onSubmenuOpen(e) {
            var $item = $(e.item);
            if ($item.children("ul[data-command-list=export-format-list]").length > 0) {
                menu.unbind("open", onSubmenuOpen);
                menu.append({
                    text: sr.loadingFormats,
                    spriteCssClass: "k-icon k-loading"
                }, $item);
                controller.getDocumentFormats().then(fillFormats).then(function() {
                    menu.open($item);
                });
            }
        }
        function fillFormats(formats) {
            utils.each($(dom).find("ul[data-command-list=export-format-list]"), function() {
                var $list = $(this), $parent = $list.parents("li");
                menu.remove($list.children("li"));
                var tabIndex = enableAccessibility ? $parent.attr("tabindex") : -1;
                if (!tabIndex) {
                    tabIndex = 1;
                }
                utils.each(formats, function() {
                    var format = this;
                    var ariaLabel = enableAccessibility ? utils.stringFormat('aria-label="{localizedName}" ', format) : " ";
                    var li = "<li " + ariaLabel + utils.stringFormat('tabindex="' + tabIndex + '"><a tabindex="-1" href="#" data-command="telerik_ReportViewer_export" data-command-parameter="{name}"><span>{localizedName}</span></a></li>', format);
                    menu.append(li, $parent);
                });
                if (enableAccessibility) {
                    setInternalListAccessibilityKeyEvents($parent.find("li"));
                }
            });
        }
        function setInternalListAccessibilityKeyEvents(listItems) {
            utils.each(listItems, function() {
                var $item = $(this);
                $item.off("keydown");
                $item.on("keydown", function(event) {
                    switch (event.which) {
                      case kendo.keys.ENTER:
                        clickOnMenuItem($item);
                        break;

                      case kendo.keys.UP:
                        var $prev = $item.prev();
                        if ($prev.length > 0) {
                            $prev.focus();
                        } else {
                            $item.parents("li").focus();
                        }
                        break;

                      case kendo.keys.DOWN:
                        var $next = $item.next();
                        if ($next.length > 0) {
                            $next.focus();
                        } else {
                            $item.parent().children("li").first().focus();
                        }
                        break;
                    }
                });
            });
        }
        function clickOnMenuItem(item) {
            if (item && item.length > 0) {
                var anchor = item.children("a");
                if (anchor.length > 0) {
                    anchor.click();
                }
            }
        }
        function onSubmenuActivate(e) {
            var $item = $(e.item);
            focusOnFirstSubmenuItem($item);
        }
        function onSubmenuDeactivate(e) {
            lastSelectedSubmenuItem = undefined;
        }
        function focusOnFirstSubmenuItem(parentItem) {
            if (lastSelectedMenuItem && lastSelectedMenuItem.is(parentItem)) {
                window.setTimeout(function() {
                    var li = parentItem.find("li");
                    if (li.length > 0) {
                        li[0].focus();
                    }
                }, 100);
            }
        }
        function onMenuKeyDown(e) {
            switch (e.which) {
              case kendo.keys.ENTER:
                if (!enableAccessibility) {
                    var $item = getFocusedItem();
                    if ($item.length > 0) {
                        if (isItemExportContainer($item) && lastSelectedSubmenuItem) {
                            $item = lastSelectedSubmenuItem;
                        }
                        clickOnMenuItem($item);
                    }
                }
                break;

              case kendo.keys.RIGHT:
                enableAccessibility ? focusNextItemAccessibilitySelection() : focusNextItemNativeMenuSelection();
                break;

              case kendo.keys.LEFT:
                enableAccessibility ? focusPreviousItemAccessibilitySelection() : focusPreviousItemNativeMenuSelection();
                break;

              case kendo.keys.DOWN:
              case kendo.keys.UP:
                if (!enableAccessibility) {
                    lastSelectedSubmenuItem = getKendoFocusedNestedItem();
                }
            }
        }
        function getFocusedItem() {
            var $item;
            var focusedItem = document.activeElement;
            if (focusedItem && focusedItem.localName == "li") {
                var items = $(childrenL1).filter("li.k-item");
                for (var i = 0; i < items.length; i++) {
                    var listItem = items[i];
                    if (focusedItem === listItem) {
                        $item = $(listItem);
                        break;
                    }
                }
            } else if (focusedItem && focusedItem.localName == "input") {
                $item = $(focusedItem).closest("li.k-item");
            } else {
                $item = menu.element.children("li.k-item.k-state-focused");
                if ($item.length == 0) {
                    $item = menu.element.children("li.k-item").first();
                }
            }
            return $item;
        }
        function focusNextItemAccessibilitySelection() {
            var $item = getFocusedItem();
            if (!$item || !$item.length > 0) {
                return;
            }
            var $next = $item.next();
            if (!$next.length > 0) {
                $next = $(childrenL1).filter("li.k-item").first();
            }
            $next.focus();
        }
        var lastKendoFocusedItem;
        function focusNextItemNativeMenuSelection() {
            var allItems = menu.element.children("li.k-item");
            var $focused = allItems.filter(".k-state-focused");
            if (kendo.version >= "2017.3.913") {
                lastKendoFocusedItem = $focused;
                return;
            }
            if ($focused.hasClass("k-state-disabled")) {
                if (!lastKendoFocusedItem || $focused.is(lastKendoFocusedItem)) {
                    var $next = $focused.next();
                    if (!$next.length > 0) {
                        $next = allItems.first();
                    }
                    $focused.toggleClass("k-state-focused");
                    $next.toggleClass("k-state-focused");
                    lastKendoFocusedItem = $next;
                    menu._oldHoverItem = $next;
                } else {
                    lastKendoFocusedItem = $focused;
                }
            } else {
                menu._oldHoverItem = $focused;
                lastKendoFocusedItem = $focused;
            }
        }
        function focusPreviousItemAccessibilitySelection() {
            var $item = getFocusedItem();
            if (!$item || !$item.length > 0) {
                return;
            }
            var $prev = $item.prev();
            if (!$prev.length > 0) {
                $prev = $(childrenL1).filter("li.k-item").last();
            }
            $prev.focus();
        }
        function focusPreviousItemNativeMenuSelection() {
            var $focused = menu.element.children("li.k-item.k-state-focused");
            lastKendoFocusedItem = $focused;
        }
        function getKendoFocusedNestedItem() {
            var $focused = menu.element.find('li.k-item.k-state-focused [data-command="telerik_ReportViewer_export"]');
            if ($focused.length == 1) {
                return $focused.parent("li");
            }
            return undefined;
        }
        function isItemExportContainer(item) {
            if (item.length == 0) {
                return;
            }
            var id = item.attr("id");
            return id == "trv-main-menu-export-command" || id == "trv-side-menu-export-command";
        }
        function replaceStringResources() {
            var menuAreas = findMenuArea();
            if (!menuAreas) {
                return;
            }
            utils.each(menuAreas, function() {
                var $menu = $(this), menuItems = $menu.children("li.k-item");
                $menu.attr("aria-label", sr[$menu.attr("aria-label")]);
                utils.each(menuItems, function() {
                    var $menuItem = $(this);
                    $menuItem.attr("aria-label", sr[$menuItem.attr("aria-label")]);
                    if (!$menuItem.hasClass("trv-report-pager")) {
                        var $a = $menuItem.find("a");
                        if ($a) {
                            $a.attr("title", sr[$a.attr("title")]);
                        }
                    } else {
                        $menuItem.attr("title", sr[$menuItem.attr("title")]);
                    }
                });
            });
        }
        function findMenuArea() {
            return utils.findElement("ul[data-role=telerik_ReportViewer_MainMenu]");
        }
    }
    var pluginName = "telerik_ReportViewer_MainMenu";
    $.fn[pluginName] = function(options, otherOptions) {
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new MainMenu(this, options, otherOptions));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReporting.utils";
    }
    function SideMenu(dom, rootOptions, otherOptions) {
        var options = $.extend({}, rootOptions, otherOptions), menu = $(dom).data("kendoMenu"), enableAccessibility = options.enableAccessibility, lastSelectedMenuItem, DEFAULT_TABINDEX = 3, panelBar, loadingFormats, sideMenuVisible = false, controller = options.controller;
        if (!controller) {
            throw "No controller (telerikReporting.ReportViewerController) has been specified.";
        }
        if (!menu) {
            init(dom);
        }
        function init(root) {
            var $root = $(root);
            panelBar = $root.children("ul").kendoPanelBar().data("kendoPanelBar");
            panelBar.bind("expand", onSubmenuOpen);
            panelBar.element.off("keydown", onPanelKeyDown);
            panelBar.element.on("keydown", onPanelKeyDown);
            setTabIndexes($root);
            enableCloseOnClick($root);
            $root.click(function(e) {
                if (e.target == root) {
                    controller.setSideMenuVisible({
                        visible: !sideMenuVisible
                    });
                }
            });
            replaceStringResources();
        }
        controller.setSideMenuVisible(function(event, args) {
            setSideMenuVisibility();
            if (enableAccessibility) {
                panelBar.element.focus();
            }
            sideMenuVisible = args.visible;
        }).getSideMenuVisible(function(event, args) {
            args.visible = sideMenuVisible;
        });
        function setSideMenuVisibility() {
            var $root = panelBar.element.parent();
            var hidden = $root.position().left < 0 || !$root.is(":visible");
            if (hidden) {
                $root.show();
            } else {
                window.setTimeout(function() {
                    $root.hide();
                }, 500);
            }
        }
        function onSubmenuOpen(e) {
            var $item = $(e.item);
            if ($item.children("ul[data-command-list=export-format-list]").length > 0) {
                panelBar.unbind("expand", onSubmenuOpen);
                panelBar.append({
                    text: sr.loadingFormats,
                    spriteCssClass: "k-icon k-loading"
                }, $item);
                options.controller.getDocumentFormats().then(fillFormats).then(function() {
                    panelBar.expand($item);
                });
            }
        }
        function fillFormats(formats) {
            utils.each($(dom).find("ul[data-command-list=export-format-list]"), function() {
                var $list = $(this), $parent = $list.parents("li");
                panelBar.remove($list.children("li"));
                var tabIndex = $parent.attr("tabindex");
                if (!tabIndex) {
                    tabIndex = DEFAULT_TABINDEX;
                }
                utils.each(formats, function(i) {
                    var format = this;
                    var ariaLabel = enableAccessibility ? utils.stringFormat('aria-label="{localizedName}" ', format) : " ";
                    var li = "<li " + ariaLabel + utils.stringFormat('tabindex="' + tabIndex + '"><a tabindex="-1" href="#" data-command="telerik_ReportViewer_export" data-command-parameter="{name}"><span>{localizedName}</span></a></li>', format);
                    panelBar.append(li, $parent);
                });
                setListItemsTabIndex($parent.find("li"), tabIndex);
                enableCloseOnClick($parent);
            });
        }
        function focusOnFirstSubmenuItem(parentItem) {
            if (lastSelectedMenuItem && lastSelectedMenuItem.is(parentItem)) {
                window.setTimeout(function() {
                    var li = parentItem.find("li");
                    if (li.length > 0) {
                        li[0].focus();
                    }
                }, 100);
            }
        }
        function enableCloseOnClick(root) {
            utils.each(root.find("li"), function() {
                var isLeaf = $(this).children("ul").length == 0;
                if (isLeaf) {
                    $(this).children("a").click(function() {
                        controller.setSideMenuVisible({
                            visible: !sideMenuVisible
                        });
                    });
                }
            });
        }
        function setTabIndexes(root) {
            if (!root) {
                return;
            }
            var $list = root.children("ul");
            var parentTabIndex = root.attr("tabindex");
            var listIndex = parentTabIndex ? parentTabIndex : DEFAULT_TABINDEX;
            setListItemsTabIndex($list, listIndex);
        }
        function setListItemsTabIndex(list, tabIndex) {
            list.attr("tabindex", tabIndex);
            var items = list.find("li");
            utils.each(items, function() {
                var $item = $(this);
                $item.attr("tabindex", tabIndex);
                var anchor = $item.children("a");
                if (anchor.length > 0) {
                    var $anchor = $(anchor);
                    $anchor.attr("tabindex", -1);
                }
                $item.focus(function() {
                    var anchor = $item.children("a");
                    if (anchor.length > 0) {
                        anchor.addClass("k-state-focused");
                    }
                });
                $item.blur(function() {
                    var anchor = $item.children("a");
                    if (anchor.length > 0) {
                        anchor.removeClass("k-state-focused");
                    }
                });
                $item.off("keydown", onItemKeyDown);
                $item.on("keydown", onItemKeyDown);
            });
        }
        function onPanelKeyDown(e) {
            if (e.which == kendo.keys.ENTER) {
                var $item;
                var isSelectedFocusedItem = false;
                var focusedItem = document.activeElement;
                if (focusedItem && focusedItem.localName == "li") {
                    var items = panelBar.element.find("li.k-item");
                    for (var i = 0; i < items.length; i++) {
                        var listItem = items[i];
                        if (focusedItem === listItem) {
                            $item = $(listItem);
                            isSelectedFocusedItem = true;
                            break;
                        }
                    }
                } else {
                    $item = panelBar.select();
                }
                if (!$item || !$item.length > 0) {
                    return;
                }
                handleItemSelect($item, isSelectedFocusedItem);
            }
        }
        function onItemKeyDown(e) {
            if (e.which == kendo.keys.ENTER) {
                handleItemSelect($(e.target), false);
            }
        }
        function handleItemSelect(item, handleExpandCollapse) {
            if (!item.length > 0) {
                return;
            }
            lastSelectedMenuItem = item;
            var isLeaf = item.children("ul").length == 0;
            if (!isLeaf) {
                if (handleExpandCollapse) {
                    if (item.hasClass("k-state-active")) {
                        panelBar.collapse(item);
                    } else {
                        panelBar.expand(item);
                    }
                }
            } else {
                var $anchor = item.find("a");
                if ($anchor.length > 0) {
                    $anchor[0].click();
                }
            }
        }
        function replaceStringResources() {
            var menuAreas = findMenuArea();
            if (!menuAreas) {
                return;
            }
            utils.each(menuAreas, function() {
                var $menu = $(this), menuItems = $menu.children("li.k-item");
                $menu.attr("aria-label", sr[$menu.attr("aria-label")]);
                utils.each(menuItems, function() {
                    var $menuItem = $(this), $a = $menuItem.find("a");
                    $menuItem.attr("aria-label", sr[$menuItem.attr("aria-label")]);
                    if ($a) {
                        var $span = $a.find("span:not(.k-icon)");
                        $a.attr("title", sr[$a.attr("title")]);
                        if ($span) {
                            $span.text(sr[$span.text()]);
                        }
                    }
                });
            });
        }
        function findMenuArea() {
            return utils.findElement("div[data-role=telerik_ReportViewer_SideMenu] > ul");
        }
    }
    var pluginName = "telerik_ReportViewer_SideMenu";
    $.fn[pluginName] = function(options, otherOptions) {
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new SideMenu(this, options, otherOptions));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    trv.binder = {
        bind: function($element) {
            var args = Array.prototype.slice.call(arguments, 1);
            attachCommands($element, args);
            var result = utils.selector('[data-role^="telerik_ReportViewer_"]');
            utils.each(result, function() {
                var $this = $(this), f = $.fn[$this.attr("data-role")];
                if (typeof f === "function") {
                    f.apply($this, args);
                }
            });
        }
    };
    function attachCommands($element, args) {
        var commands = args[0].commands, viewerOptions = args[1], elementSelector = '[data-command^="telerik_ReportViewer_"]', customElementSelector = "[data-target-report-viewer]" + elementSelector;
        $element.on("click", elementSelector, commandHandler);
        if (!trv.GlobalSettings.CommandHandlerAttached) {
            $(document.body).on("click", customElementSelector, customCommandHandler);
            trv.GlobalSettings.CommandHandlerAttached = true;
        }
        utils.each(commands, function(key, command) {
            attachCommand(key, command, viewerOptions, $element);
        });
        function commandHandler(e) {
            var prefixedDataCommand = $(this).attr("data-command");
            if (prefixedDataCommand) {
                var dataCommand = prefixedDataCommand.substring("telerik_ReportViewer_".length), cmd = commands[dataCommand];
                if (cmd && cmd.enabled()) {
                    cmd.exec($(this).attr("data-command-parameter"));
                }
                e.preventDefault();
            }
        }
        function customCommandHandler(e) {
            var $this = $(this), prefixedDataCommand = $this.attr("data-command"), reportViewerTarget = $this.attr("data-target-report-viewer");
            if (prefixedDataCommand && reportViewerTarget) {
                var dataCommand = prefixedDataCommand.substring("telerik_ReportViewer_".length), reportViewer = $(reportViewerTarget).data("telerik_ReportViewer"), cmd = reportViewer.commands[dataCommand];
                if (cmd.enabled()) {
                    cmd.exec($(this).attr("data-command-parameter"));
                }
                e.preventDefault();
            }
        }
    }
    function attachCommand(dataCommand, cmd, viewerOptions, $element) {
        if (cmd) {
            var elementSelector = '[data-command="telerik_ReportViewer_' + dataCommand + '"]', customElementSelector = '[data-target-report-viewer="' + viewerOptions.selector + '"]' + elementSelector, $defaultElement = $element.find(elementSelector), $customElement = $(customElementSelector);
            $(cmd).on("enabledChanged", function(e) {
                (cmd.enabled() ? $.fn.removeClass : $.fn.addClass).call($defaultElement.parent("li"), "k-state-disabled");
                (cmd.enabled() ? $.fn.removeClass : $.fn.addClass).call($customElement, viewerOptions.disabledButtonClass);
            }).on("checkedChanged", function(e) {
                (cmd.checked() ? $.fn.addClass : $.fn.removeClass).call($defaultElement.parent("li"), "k-state-selected");
                (cmd.checked() ? $.fn.addClass : $.fn.removeClass).call($customElement, viewerOptions.checkedButtonClass);
            });
        }
    }
    function LinkButton(dom, options) {
        var cmd, $element = $(dom), dataCommand = $element.attr("data-command");
        if (dataCommand) {
            cmd = options.commands[dataCommand];
        }
        if (cmd) {
            $element.click(function(e) {
                if (cmd.enabled()) {
                    cmd.exec($(this).attr("data-command-parameter"));
                } else {
                    e.preventDefault();
                }
            });
            $(cmd).on("enabledChanged", function(e) {
                (cmd.enabled() ? $.fn.removeClass : $.fn.addClass).call($element, "disabled");
            }).on("checkedChanged", function(e) {
                (cmd.checked() ? $.fn.addClass : $.fn.removeClass).call($element, "checked");
            });
        }
    }
    var linkButton_pluginName = "telerik_ReportViewer_LinkButton";
    $.fn[linkButton_pluginName] = function(options) {
        return utils.each(this, function() {
            if (!$.data(this, linkButton_pluginName)) {
                $.data(this, linkButton_pluginName, new LinkButton(this, options));
            }
        });
    };
    function PageNumberInput(dom, options) {
        var $element = $(dom), oldValue = 0, cmd = options.commands["goToPage"];
        function setPageNumber(value) {
            if (oldValue !== value || !$element.is(":focus")) {
                $element.val(value);
                oldValue = value;
            }
        }
        options.controller.pageNumberChange(function(e, value) {
            setPageNumber(value);
        });
        $element.change(function() {
            var val = $(this).val();
            var num = utils.tryParseInt(val);
            if (num != NaN) {
                var result = cmd.exec(num);
                setPageNumber(result);
            }
        });
        $element.keydown(function(e) {
            if (e.which == 13) {
                $(this).change();
                return e.preventDefault();
            }
        });
        function validateValue(value) {
            return /^([0-9]+)$/.test(value);
        }
        $element.keypress(function(event) {
            if (utils.isSpecialKey(event.keyCode)) {
                return true;
            }
            var newValue = $element.val() + String.fromCharCode(event.charCode);
            return validateValue(newValue);
        }).on("paste", function(event) {});
    }
    var pageNumberInput_pluginName = "telerik_ReportViewer_PageNumberInput";
    $.fn[pageNumberInput_pluginName] = function(options) {
        return utils.each(this, function() {
            if (!$.data(this, pageNumberInput_pluginName)) {
                $.data(this, pageNumberInput_pluginName, new PageNumberInput(this, options));
            }
        });
    };
    function PageCountLabel(dom, options) {
        var $element = $(dom);
        options.controller.pageCountChange(function(e, value) {
            $element.html(value);
        });
    }
    var pageCountLabel_pluginName = "telerik_ReportViewer_PageCountLabel";
    $.fn[pageCountLabel_pluginName] = function(options) {
        return utils.each(this, function() {
            if (!$.data(this, pageCountLabel_pluginName)) {
                $.data(this, pageCountLabel_pluginName, new PageCountLabel(this, options));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, window, document, undefined) {
    "use strict";
    trv.PerspectiveManager = function(dom, controller) {
        var smallMenu = dom.querySelectorAll ? dom.querySelectorAll(".trv-menu-small")[0] : false, perspectives = {
            small: {
                documentMapVisible: false,
                parametersAreaVisible: false,
                onDocumentMapVisibleChanged: function(e, args) {
                    if (args.visible) {
                        controller.setParametersAreaVisible({
                            visible: false
                        });
                    }
                },
                onParameterAreaVisibleChanged: function(e, args) {
                    if (args.visible) {
                        controller.setDocumentMapVisible({
                            visible: false
                        });
                    }
                },
                onBeforeLoadReport: function() {
                    controller.setParametersAreaVisible({
                        visible: false
                    });
                    controller.setDocumentMapVisible({
                        visible: false
                    });
                },
                onNavigateToPage: function() {
                    controller.setParametersAreaVisible({
                        visible: false
                    });
                    controller.setDocumentMapVisible({
                        visible: false
                    });
                }
            },
            large: {
                documentMapVisible: true,
                parametersAreaVisible: true
            }
        }, currentPerspective;
        function init() {
            currentPerspective = getPerspective();
            initStateFromController(perspectives["large"]);
        }
        function setPerspective(beforeApplyState) {
            var perspective = getPerspective();
            if (perspective !== currentPerspective) {
                var oldState = perspectives[currentPerspective];
                var newState = perspectives[perspective];
                currentPerspective = perspective;
                if (beforeApplyState) {
                    beforeApplyState.call(undefined, oldState, newState);
                }
                applyState(newState);
            }
        }
        function onDocumentMapVisibleChanged(e, args) {
            dispatch("onDocumentMapVisibleChanged", arguments);
        }
        function onParameterAreaVisibleChanged(e, args) {
            dispatch("onParameterAreaVisibleChanged", arguments);
        }
        function onBeforeLoadReport() {
            dispatch("onBeforeLoadReport", arguments);
        }
        function onNavigateToPage() {
            dispatch("onNavigateToPage", arguments);
        }
        function onReportLoadComplete() {
            dispatch("onReportLoadComplete", arguments);
        }
        function onWindowResize() {
            setPerspective(function(oldState, newState) {
                initStateFromController(oldState);
            });
        }
        function onCssLoaded() {
            setPerspective(null);
        }
        function dispatch(func, args) {
            var activePerspective = perspectives[currentPerspective];
            var handler = activePerspective[func];
            if (typeof handler === "function") {
                handler.apply(activePerspective, args);
            }
        }
        function attach() {
            window.addEventListener("resize", onWindowResize);
            controller.setDocumentMapVisible(onDocumentMapVisibleChanged);
            controller.setParametersAreaVisible(onParameterAreaVisibleChanged);
            controller.beforeLoadReport(onBeforeLoadReport);
            controller.navigateToPage(onNavigateToPage);
            controller.reportLoadComplete(onReportLoadComplete);
            controller.cssLoaded(onCssLoaded);
        }
        function getPerspective() {
            var windowWidthInEm = $(window).width() / parseFloat($("body").css("font-size")), windowMinWidth = 40.5;
            return smallMenu && windowWidthInEm <= windowMinWidth ? "small" : "large";
        }
        function initStateFromController(state) {
            state.documentMapVisible = documentMapVisible();
            state.parametersAreaVisible = parametersAreaVisible();
        }
        function applyState(state) {
            documentMapVisible(state.documentMapVisible);
            parametersAreaVisible(state.parametersAreaVisible);
        }
        function documentMapVisible() {
            if (arguments.length == 0) {
                var args1 = {};
                controller.getDocumentMapState(args1);
                return args1.visible;
            }
            controller.setDocumentMapVisible({
                visible: Boolean(arguments[0])
            });
            return this;
        }
        function parametersAreaVisible() {
            if (arguments.length == 0) {
                var args1 = {};
                controller.getParametersAreaState(args1);
                return args1.visible;
            }
            controller.setParametersAreaVisible({
                visible: Boolean(arguments[0])
            });
            return this;
        }
        init();
        return {
            attach: attach
        };
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    var defaultOptions = {};
    function accessibility(options) {
        var controller, pageInitialized = false, areas, lastArea, keyMap = {
            CONFIRM_KEY: 13,
            CONTENT_AREA_KEY: 67,
            DOCUMENT_MAP_AREA_KEY: 68,
            MENU_AREA_KEY: 77,
            PARAMETERS_AREA_KEY: 80
        };
        options = $.extend({}, defaultOptions, options);
        controller = options.controller;
        if (!controller) {
            throw "No controller (telerikReporting.ReportViewerController) has been specified.";
        }
        controller.reportLoadComplete(onReportLoadComplete).pageReady(function(event, page) {
            initPage(page);
            pageInitialized = true;
        }).error(function(e, message) {
            focusOnErrorMessage();
            window.setTimeout(setAccessibilityUI, 500);
        }).updateUI(function(e) {
            if (pageInitialized) {
                setPageSelector();
                decorateMenuItems();
            }
        });
        function onReportLoadComplete(e, args) {
            setAccessibilityUI();
            var content = findContentArea();
            if (content.length > 0) {
                content.focus();
            }
        }
        function setAccessibilityUI() {
            if (!areas) {
                initAreas();
                $(document.body).off("keydown", processKeyDown);
                $(document.body).on("keydown", processKeyDown);
            }
        }
        function focusOnErrorMessage() {
            var selectorChain = [ "div.trv-pages-area", "div.trv-error-message" ];
            var $errMsg = utils.findElement(selectorChain);
            if ($errMsg.length == 0) {
                return;
            }
            $errMsg.attr("tabIndex", 0);
            $errMsg.focus();
        }
        function initPage(page) {
            if (!page) {
                return;
            }
            setAccessibilityUI();
            var area = areas[keyMap.CONTENT_AREA_KEY];
            setContentAreaKeyDown(area);
        }
        function setPageSelector() {
            var $pagers = $(".trv-report-pager");
            if ($pagers.length > 0) {
                var pageNumber = controller.currentPageNumber();
                var pageCount = controller.pageCount();
                utils.each($pagers, function() {
                    var $pager = $(this);
                    $pager.attr("aria-label", utils.stringFormat(sr.ariaLabelPageNumberSelector, [ pageNumber, pageCount ]));
                    var $pageInputs = $pager.find("input[data-role=telerik_ReportViewer_PageNumberInput]");
                    if ($pageInputs.length > 0) {
                        utils.each($pageInputs, function() {
                            var $this = $(this);
                            $this.attr("aria-label", sr.ariaLabelPageNumberEditor);
                            $this.attr("min", "1");
                            $this.attr("max", "" + pageCount);
                        });
                    }
                });
            }
        }
        function initAreas() {
            areas = {};
            areas[keyMap.DOCUMENT_MAP_AREA_KEY] = findDocumentMapArea();
            areas[keyMap.MENU_AREA_KEY] = findMenuArea();
            areas[keyMap.CONTENT_AREA_KEY] = findContentArea();
            var parametersArea = findParametersArea();
            if (parametersArea) {
                areas[keyMap.PARAMETERS_AREA_KEY] = parametersArea;
                setParameterEditorsKeyDown(parametersArea);
            }
        }
        function findContentArea() {
            return utils.findElement([ "div[data-role=telerik_ReportViewer_PagesArea]" ]);
        }
        function findDocumentMapArea() {
            return utils.findElement([ "div[data-role=telerik_ReportViewer_DocumentMapArea]", "div[data-role=treeview]" ]);
        }
        function findMenuArea() {
            return utils.findElement("ul[data-role=telerik_ReportViewer_MainMenu]");
        }
        function findParametersArea() {
            return utils.findElement([ "div[data-role=telerik_ReportViewer_ParametersArea]", "div.trv-parameters-area-content" ]);
        }
        function processKeyDown(event) {
            if (!areas) {
                return;
            }
            if (!(event.altKey && event.ctrlKey)) {
                return;
            }
            var currentArea = areas[event.which];
            if (!currentArea) {
                return;
            }
            if (!IsAreaContainerVisible(currentArea.parent())) {
                return;
            }
            var className = "k-state-focused";
            if (lastArea) {
                lastArea.removeClass(className);
            }
            currentArea.addClass(className);
            currentArea.focus();
            lastArea = currentArea;
            event.preventDefault();
        }
        function setParameterEditorsKeyDown(parametersAreaContent) {
            if (parametersAreaContent.length == 0) {
                return;
            }
            var $paramsArea = parametersAreaContent.parent("div[data-role=telerik_ReportViewer_ParametersArea]");
            if (!IsAreaContainerVisible($paramsArea)) {
                return;
            }
            utils.each(parametersAreaContent.children(), function() {
                $(this).keydown(function(event) {
                    if (event.which == keyMap.CONFIRM_KEY) {
                        var paramsButton = $paramsArea.find("button.trv-parameters-area-preview-button");
                        paramsButton.focus();
                        event.preventDefault();
                    }
                });
            });
        }
        function IsAreaContainerVisible(container) {
            return container && !container.hasClass("trv-hidden");
        }
        function setContentAreaKeyDown(contentArea) {
            if (!contentArea) {
                return;
            }
            var actions = contentArea.find("div [data-reporting-action]");
            if (!actions.length > 0) {
                return;
            }
            utils.each(actions, function() {
                var $action = $(this);
                $action.keydown(function(event) {
                    if (event.which == keyMap.CONFIRM_KEY) {
                        $action.click();
                    }
                });
            });
        }
        function decorateMenuItems() {
            var menuAreas = areas[keyMap.MENU_AREA_KEY];
            if (!menuAreas) {
                return;
            }
            utils.each(menuAreas, function() {
                var $menu = $(this);
                var menuItems = $menu.children("li.k-item");
                utils.each(menuItems, function() {
                    var $menuItem = $(this);
                    if (!$menuItem.hasClass("trv-report-pager")) {
                        var ariaLabel = $menuItem.attr("aria-label");
                        var expandableSr = utils.stringFormat(". {0}", [ sr.ariaLabelExpandable ]), expandable = $menuItem.find("ul").length > 0 && ariaLabel.indexOf(expandableSr) < 0 ? expandableSr : "";
                        var selectedSr = utils.stringFormat(". {0}", [ sr.ariaLabelSelected ]), selected = $menuItem.hasClass("k-state-selected") && ariaLabel.indexOf(selectedSr) < 0 ? selectedSr : "";
                        var label = ariaLabel + expandable + selected;
                        $menuItem.attr("aria-label", label);
                        if ($menuItem.hasClass("k-state-disabled")) {
                            $menuItem.attr("aria-disabled", "true");
                        } else {
                            $menuItem.removeAttr("aria-disabled");
                        }
                    }
                });
            });
        }
        function setKeyMap(keyMapValues) {
            keyMap = keyMapValues;
            areas = undefined;
        }
        function getKeyMap() {
            return keyMap;
        }
        return {
            getKeyMap: getKeyMap,
            setKeyMap: setKeyMap
        };
    }
    trv.accessibility = accessibility;
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    var defaultOptions = {};
    function Search(placeholder, options, otherOptions) {
        options = $.extend({}, defaultOptions, options);
        var controller = options.controller, initialized = false, viewerOptions = otherOptions, dialogVisible = false, $placeholder, $inputBox, $searchOptionsPlaceholder, searchOptionsMenu, $stopSearchPlaceholder, stopSearchMenu, $navigationPlaceholder, navigationMenu, $resultsLabel, $resultsPlaceholder, kendoComboBox, kendoSearchDialog, stopSearchCommand, optionsCommandSet, navigationCommandSet, searchResults, mruList = [], inputComboRebinding, searchMetadataRequested, searchMetadataLoaded, pendingHighlightItem, windowLocation, reportViewerWrapper = $("#" + viewerOptions.viewerSelector).find(".trv-report-viewer");
        var highlightManager = {
            shadedClassName: "trv-search-dialog-shaded-result",
            highlightedClassName: "trv-search-dialog-highlighted-result",
            current: null,
            elements: []
        };
        if (!controller) {
            throw "No controller (telerikReporting.ReportViewerController) has been specified.";
        }
        controller.getSearchDialogState(function(event, args) {
            args.visible = dialogVisible;
        }).setSearchDialogVisible(function(event, args) {
            toggleSearchDialog(args.visible);
        }).setSendEmailDialogVisible(function(event, args) {
            if (args.visible && dialogVisible) {
                toggle(!dialogVisible);
            }
        }).pageReady(onPageReady).scrollPageReady(onPageReady).beginLoadReport(closeAndClear).viewModeChanged(closeAndClear);
        function closeAndClear() {
            if (searchMetadataRequested) {
                return;
            }
            toggle(false);
            searchMetadataLoaded = false;
        }
        function toggleSearchDialog(show) {
            dialogVisible = show;
            if (show) {
                var searchMetadataOnDemand = viewerOptions.searchMetadataOnDemand;
                if (searchMetadataOnDemand && !searchMetadataLoaded) {
                    searchMetadataRequested = true;
                    controller.reportLoadComplete(function() {
                        if (searchMetadataRequested) {
                            toggle(true);
                            searchMetadataRequested = false;
                        }
                    });
                    controller.refreshReport(true);
                    return;
                }
            }
            toggle(show);
        }
        function toggle(show) {
            dialogVisible = show;
            if (show) {
                searchMetadataLoaded = true;
                ensureInitialized();
                kendoSearchDialog.open();
                kendoComboBox.value("");
                updateResultsUI(null);
                toggleErrorLabel(false, null);
            } else {
                clearColoredItems();
                if (kendoSearchDialog && kendoSearchDialog.options.visible) {
                    kendoSearchDialog.close();
                }
            }
        }
        function ensureInitialized() {
            if (!initialized) {
                $placeholder = $(placeholder);
                $inputBox = $placeholder.find(".trv-search-dialog-input-box");
                $resultsLabel = $placeholder.find(".trv-search-dialog-results-label");
                $resultsPlaceholder = $placeholder.find(".trv-search-dialog-results-area");
                initResultsArea();
                replaceStringResources($placeholder);
                $searchOptionsPlaceholder = $placeholder.find(".trv-search-dialog-search-options").kendoMenu();
                $stopSearchPlaceholder = $placeholder.find(".trv-search-dialog-stopsearch-placeholder").kendoMenu();
                $navigationPlaceholder = $placeholder.find(".trv-search-dialog-navigational-buttons").kendoMenu();
                searchOptionsMenu = $searchOptionsPlaceholder.data("kendoMenu");
                stopSearchMenu = $stopSearchPlaceholder.data("kendoMenu");
                navigationMenu = $navigationPlaceholder.data("kendoMenu");
                searchOptionsMenu.element.on("keydown", onKeyDown);
                stopSearchMenu.element.on("keydown", onKeyDown);
                navigationMenu.element.on("keydown", onKeyDown);
                kendoComboBox = $inputBox.kendoComboBox({
                    dataTextField: "value",
                    dataValueField: "value",
                    dataSource: mruList,
                    change: kendoComboBoxSelect,
                    ignoreCase: false,
                    filtering: onInputFiltering,
                    filter: "startswith",
                    delay: 1e3,
                    open: function(e) {
                        if (inputComboRebinding) {
                            e.preventDefault();
                        }
                    },
                    select: processComboBoxEvent
                }).data("kendoComboBox");
                kendoSearchDialog = reportViewerWrapper.find(".trv-search-window").kendoWindow({
                    title: sr.searchDialogTitle,
                    height: 390,
                    width: 310,
                    minWidth: 310,
                    minHeight: 390,
                    maxHeight: 700,
                    scrollable: false,
                    close: function() {
                        storeDialogPosition();
                    },
                    open: function() {
                        adjustDialogPosition();
                    },
                    deactivate: function() {
                        controller.setSearchDialogVisible({
                            visible: false
                        });
                    },
                    activate: function() {
                        kendoComboBox.input.focus();
                    }
                }).data("kendoWindow");
                kendoSearchDialog.wrapper.addClass("trv-search");
                initCommands();
                initialized = true;
            }
        }
        function onKeyDown(event) {
            var item = $(event.target).find(".k-state-focused");
            if (event.keyCode === 13 && item && item.length > 0) {
                var anchor = item.children("a");
                if (anchor.length > 0) {
                    anchor.click();
                }
            }
        }
        $(window).resize(function() {
            if (kendoSearchDialog && kendoSearchDialog.options.visible) {
                storeDialogPosition();
                adjustDialogPosition();
            }
        });
        function storeDialogPosition() {
            var kendoWindow = kendoSearchDialog.element.parent(".k-window");
            windowLocation = kendoWindow.offset();
        }
        function adjustDialogPosition() {
            var windowWidth = $(window).innerWidth(), windowHeight = $(window).innerHeight(), kendoWindow = kendoSearchDialog.wrapper, width = kendoWindow.outerWidth(true), height = kendoWindow.outerHeight(true), padding = 10;
            if (!windowLocation) {
                var reportViewerCoords = reportViewerWrapper[0].getBoundingClientRect();
                kendoWindow.css({
                    top: reportViewerCoords.top + padding,
                    left: reportViewerCoords.right - width - padding
                });
            } else {
                var left = windowLocation.left, top = windowLocation.top, right = left + width, bottom = top + height;
                if (right > windowWidth - padding) {
                    left = Math.max(padding, windowWidth - width - padding);
                    kendoWindow.css({
                        left: left
                    });
                }
                if (bottom > windowHeight - padding) {
                    top = Math.max(padding, windowHeight - height - padding);
                    kendoWindow.css({
                        top: top
                    });
                }
            }
        }
        function processComboBoxEvent(e) {
            if (!(window.event || window.event.type)) {
                return;
            }
            var evt = window.event;
            if (evt.type === "keydown") {
                e.preventDefault();
                if (evt.keyCode === 40) {
                    moveListSelection(1);
                } else if (evt.keyCode === 38) {
                    moveListSelection(-1);
                }
            }
        }
        var commandNames = {
            matchCase: "searchDialog_MatchCase",
            matchWholeWord: "searchDialog_MatchWholeWord",
            useRegex: "searchDialog_UseRegex"
        };
        function initCommands() {
            optionsCommandSet = {
                searchDialog_MatchCase: new command(function() {
                    toggleCommand(this);
                }),
                searchDialog_MatchWholeWord: new command(function() {
                    toggleCommand(this);
                }),
                searchDialog_UseRegex: new command(function() {
                    toggleCommand(this);
                })
            };
            var binder = trv.binder;
            binder.bind($searchOptionsPlaceholder, {
                controller: controller,
                commands: optionsCommandSet
            }, viewerOptions);
            stopSearchCommand = new command(function() {
                stopSearch();
            });
            binder.bind($stopSearchPlaceholder, {
                controller: controller,
                commands: {
                    searchDialog_StopSearch: stopSearchCommand
                }
            }, viewerOptions);
            navigationCommandSet = {
                searchDialog_NavigateUp: new command(function() {
                    moveListSelection(-1);
                }),
                searchDialog_NavigateDown: new command(function() {
                    moveListSelection(1);
                })
            };
            binder.bind($navigationPlaceholder, {
                controller: controller,
                commands: navigationCommandSet
            }, viewerOptions);
        }
        function initResultsArea() {
            $resultsPlaceholder.kendoListView({
                selectable: true,
                navigatable: true,
                dataSource: {},
                template: "<div class='trv-search-dialog-results-row'><span>#: description #</span> <span class='trv-search-dialog-results-pageSpan'>page #:page#</span></div>",
                change: function() {
                    var index = this.select().index(), view = this.dataSource.view(), dataItem = view[index];
                    onSelectedItem(dataItem);
                    updateUI(index, view.length);
                }
            });
        }
        function stopSearch() {
            setStopButtonEnabledState(false);
        }
        function toggleCommand(cmd) {
            cmd.checked(!cmd.checked());
            searchForCurrentToken();
        }
        function setStopButtonEnabledState(enabledState) {
            stopSearchCommand.enabled(enabledState);
        }
        function onPageReady(args, page) {
            if (dialogVisible) {
                colorPageElements(searchResults);
            }
        }
        function onInputFiltering(e) {
            e.preventDefault();
            searchForToken(e.filter.value);
        }
        function kendoComboBoxSelect(e) {
            if (e.sender.dataItem() && e.sender.dataItem().value) {
                searchForToken(e.sender.dataItem().value);
            }
        }
        function searchForCurrentToken() {
            if (kendoComboBox) {
                searchForToken(kendoComboBox.value());
            }
        }
        function searchForToken(token) {
            onSearchStarted();
            addToMRU(token);
            controller.getSearchResults({
                searchToken: token,
                matchCase: optionsCommandSet.searchDialog_MatchCase.checked(),
                matchWholeWord: optionsCommandSet.searchDialog_MatchWholeWord.checked(),
                useRegex: optionsCommandSet.searchDialog_UseRegex.checked()
            }).then(function(results) {
                updateResultsUI(results, null);
            }).catch(function(errorMessage) {
                if (errorMessage) {
                    updateResultsUI(null, errorMessage);
                }
            });
        }
        function onSearchStarted() {
            $resultsLabel.text(sr.searchDialogSearchInProgress);
            clearColoredItems();
            searchResults = null;
            setStopButtonEnabledState(true);
            toggleErrorLabel(false, null);
        }
        function updateResultsUI(results, error) {
            setStopButtonEnabledState(false);
            if (error) {
                toggleErrorLabel(true, error);
            }
            displayResultsList(results);
            searchResults = results;
            if (results && results.length > 0) {
                colorPageElements(results);
                selectFirstElement();
            } else {
                updateUI(-1, 0);
            }
        }
        function addToMRU(token) {
            if (!token || token === "") {
                return;
            }
            var exists = mruList.filter(function(mru) {
                return mru.value === token;
            });
            if (exists && exists.length > 0) {
                return;
            }
            mruList.unshift({
                value: token
            });
            if (mruList.length > 10) {
                mruList.pop();
            }
            inputComboRebinding = true;
            kendoComboBox.dataSource.data(mruList);
            kendoComboBox.select(function(item) {
                return item.value === token;
            });
            inputComboRebinding = false;
        }
        function displayResultsList(results) {
            var $listView = $resultsPlaceholder.data("kendoListView");
            if (!results) {
                results = [];
            }
            $listView.dataSource.data(results);
        }
        function colorPageElements(results) {
            if (!results || results.length === 0) {
                return;
            }
            var $parent = $placeholder.parent(), $pageContainer = $parent.find(".trv-page-container"), elements = $pageContainer.find("[data-search-id]");
            utils.each(results, function() {
                var $searchElement = elements.filter("[data-search-id=" + this.id + "]");
                if ($searchElement) {
                    $searchElement.addClass(highlightManager.shadedClassName);
                    highlightManager.elements.push($searchElement);
                }
            });
            highlightItem(pendingHighlightItem);
            pendingHighlightItem = null;
        }
        function highlightItem(item) {
            if (item) {
                var currentItemId = item.id;
                var newHighlighted = $(highlightManager.elements.filter(function(i) {
                    return i.attr("data-search-id") === currentItemId;
                })).first();
                if (newHighlighted) {
                    highlightManager.current = newHighlighted[0];
                    if (highlightManager.current) {
                        highlightManager.current.removeClass(highlightManager.shadedClassName);
                        highlightManager.current.addClass(highlightManager.highlightedClassName);
                    }
                }
            }
        }
        function selectFirstElement() {
            var $listView = $resultsPlaceholder.data("kendoListView");
            var first = $listView.element.children().first();
            $listView.select(first);
        }
        function onSelectedItem(item) {
            if (!item) {
                return;
            }
            if (highlightManager.current) {
                highlightManager.current.removeClass(highlightManager.highlightedClassName);
                highlightManager.current.addClass(highlightManager.shadedClassName);
            }
            if (item.page === controller.currentPageNumber()) {
                highlightItem(item);
            } else {
                if (controller.pageMode() !== trv.PageModes.CONTINUOUS_SCROLL) {
                    clearColoredItems();
                }
                pendingHighlightItem = item;
            }
            controller.navigateToPage(item.page, {
                type: "search",
                id: item.id
            });
        }
        function updateUI(index, count) {
            var str = count === 0 ? sr.searchDialogNoResultsLabel : utils.stringFormat(sr.searchDialogResultsFormatLabel, [ index + 1, count ]);
            $resultsLabel.text(str);
            var allowMoveUp = index > 0;
            var allowMoveDown = index < count - 1;
            navigationCommandSet.searchDialog_NavigateUp.enabled(allowMoveUp);
            navigationCommandSet.searchDialog_NavigateDown.enabled(allowMoveDown);
        }
        function clearColoredItems() {
            if (highlightManager.elements && highlightManager.elements.length > 0) {
                utils.each(highlightManager.elements, function() {
                    this.removeClass(highlightManager.shadedClassName);
                });
            }
            if (highlightManager.current) {
                highlightManager.current.removeClass(highlightManager.highlightedClassName);
            }
            highlightManager.elements = [];
            highlightManager.current = null;
        }
        function moveListSelection(offset) {
            var $listView = $resultsPlaceholder.data("kendoListView");
            var $selected = $listView.select();
            if (!$selected) {
                $selected = $listView.element.children().first();
            } else {
                var index = $listView.select().index(), view = $listView.dataSource.view();
                var newIndex = Math.min(view.length - 1, Math.max(0, index + offset));
                if (newIndex !== index) {
                    var dataItem = view[newIndex];
                    var element = $listView.element.find('[data-uid="' + dataItem.uid + '"]');
                    if (element) {
                        $listView.select(element);
                        scrollIfNeeded(element[0], $listView.element[0]);
                    }
                }
            }
        }
        function scrollIfNeeded(element, container) {
            if (element.offsetTop - element.clientHeight < container.scrollTop) {
                element.scrollIntoView();
            } else {
                var offsetBottom = element.offsetTop + element.offsetHeight;
                var scrollBottom = container.scrollTop + container.offsetHeight;
                if (offsetBottom > scrollBottom) {
                    container.scrollTop = offsetBottom - container.offsetHeight;
                }
            }
        }
        function toggleErrorLabel(show, message) {
            var $errorIcon = $searchOptionsPlaceholder.find("i[data-role='telerik_ReportViewer_SearchDialog_Error']");
            if (!$errorIcon || $errorIcon.length === 0) {
                console.log(message);
                return;
            }
            var menuItem = $searchOptionsPlaceholder.data("kendoMenu").element.find("li").last();
            if (show) {
                $errorIcon[0].title = message;
                menuItem.show();
            } else {
                menuItem.hide();
            }
        }
        function replaceStringResources($search) {
            if (!$search) {
                return;
            }
            var $searchCaption = $search.find(".trv-search-dialog-caption-label"), $searchOptions = $search.find(".trv-search-dialog-search-options"), $searchStopButton = $search.find("a[data-command='telerik_ReportViewer_searchDialog_StopSearch']"), $searchMatchCaseButton = $search.find("a[data-command='telerik_ReportViewer_searchDialog_MatchCase']"), $searchMatchWholeWordButton = $search.find("a[data-command='telerik_ReportViewer_searchDialog_MatchWholeWord']"), $searchUseRegexButton = $search.find("a[data-command='telerik_ReportViewer_searchDialog_UseRegex']"), $searchNavigateUpButton = $search.find("a[data-command='telerik_ReportViewer_searchDialog_NavigateUp']"), $searchNavigateDownButton = $search.find("a[data-command='telerik_ReportViewer_searchDialog_NavigateDown']");
            replaceAttribute($search, "aria-label");
            replaceAttribute($searchOptions, "aria-label");
            replaceText($searchCaption);
            replaceTitleAndAriaLabel($searchStopButton);
            replaceTitleAndAriaLabel($searchMatchCaseButton);
            replaceTitleAndAriaLabel($searchMatchWholeWordButton);
            replaceTitleAndAriaLabel($searchUseRegexButton);
            replaceTitleAndAriaLabel($searchNavigateUpButton);
            replaceTitleAndAriaLabel($searchNavigateDownButton);
        }
        function replaceTitleAndAriaLabel($a) {
            replaceAttribute($a, "title");
            replaceAttribute($a, "aria-label");
        }
        function replaceText($el) {
            if ($el) {
                $el.text(sr[$el.text()]);
            }
        }
        function replaceAttribute($el, attribute) {
            if ($el) {
                $el.attr(attribute, sr[$el.attr(attribute)]);
            }
        }
        function command(execCallback) {
            var enabledState = true;
            var checkedState = false;
            var cmd = {
                enabled: function(state) {
                    if (arguments.length === 0) {
                        return enabledState;
                    }
                    var newState = Boolean(state);
                    enabledState = newState;
                    $(this).trigger("enabledChanged");
                    return cmd;
                },
                checked: function(state) {
                    if (arguments.length === 0) {
                        return checkedState;
                    }
                    var newState = Boolean(state);
                    checkedState = newState;
                    $(this).trigger("checkedChanged");
                    return cmd;
                },
                exec: execCallback
            };
            return cmd;
        }
    }
    var pluginName = "telerik_ReportViewer_SearchDialog";
    $.fn[pluginName] = function(options, otherOptions) {
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new Search(this, options, otherOptions));
            }
        });
    };
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);

(function(trv, $, window, document, undefined) {
    "use strict";
    if (!$) {
        alert("jQuery is not loaded. Make sure that jQuery is included.");
    }
    if (!trv.GlobalSettings) {
        trv.GlobalSettings = {};
    }
    var utils = trv.utils;
    if (!utils) {
        throw "Missing telerikReportViewer.utils";
    }
    var sr = trv.sr;
    if (!sr) {
        throw "Missing telerikReportViewer.sr";
    }
    if (!trv.ServiceClient) {
        throw "Missing telerikReportViewer.ServiceClient";
    }
    if (!trv.ReportViewerController) {
        throw "Missing telerikReportViewer.ReportViewerController";
    }
    if (!trv.HistoryManager) {
        throw "Missing telerikReportViewer.HistoryManager";
    }
    var binder = trv.binder;
    if (!binder) {
        throw "Missing telerikReportViewer.Binder";
    }
    if (!trv.CommandSet) {
        throw "Missing telerikReportViewer.commandSet";
    }
    if (!trv.uiController) {
        throw "Missing telerikReportViewer.uiController";
    }
    trv.Events = {
        EXPORT_BEGIN: "EXPORT_BEGIN",
        EXPORT_END: "EXPORT_END",
        PRINT_BEGIN: "PRINT_BEGIN",
        PRINT_END: "PRINT_END",
        RENDERING_BEGIN: "RENDERING_BEGIN",
        RENDERING_END: "RENDERING_END",
        PAGE_READY: "PAGE_READY",
        ERROR: "ERROR",
        UPDATE_UI: "UPDATE_UI",
        INTERACTIVE_ACTION_EXECUTING: "INTERACTIVE_ACTION_EXECUTING",
        INTERACTIVE_ACTION_ENTER: "INTERACTIVE_ACTION_ENTER",
        INTERACTIVE_ACTION_LEAVE: "INTERACTIVE_ACTION_LEAVE",
        VIEWER_TOOLTIP_OPENING: "VIEWER_TOOLTIP_OPENING",
        SEND_EMAIL_BEGIN: "SEND_EMAIL_BEGIN",
        SEND_EMAIL_END: "SEND_EMAIL_END"
    };
    var templateCache = function() {
        var cache = {};
        return {
            load: function(url, serviceUrl, client) {
                var p = cache[url];
                if (!p) {
                    cache[url] = p = client.get(url).then(function(html) {
                        var templates = {};
                        var styleSheets = [];
                        var scripts = [];
                        var baseUri = utils.rtrim(serviceUrl, "\\/") + "/";
                        html = utils.replaceAll(html, "{service}/", baseUri);
                        html = utils.replaceAll(html, "{service}", baseUri);
                        var viewerTemplate = $("<div></div>").html(html);
                        utils.each(viewerTemplate.find("template"), function(index, e) {
                            var $e = $(e);
                            templates[$e.attr("id")] = utils.trim($e.html(), "\n \t");
                        });
                        utils.each(viewerTemplate.find("link"), function(index, e) {
                            styleSheets.push(utils.trim(e.outerHTML, "\n \t"));
                        });
                        styleSheets = utils.filterUniqueLastOccurance(styleSheets);
                        utils.each(viewerTemplate.find("script"), function(index, e) {
                            scripts.push(utils.trim(e.innerHTML, "\n \t"));
                        });
                        return {
                            templates: templates,
                            styleSheets: styleSheets,
                            scripts: scripts
                        };
                    });
                }
                return p;
            }
        };
    }();
    function MemStorage() {
        var data = {};
        return {
            getItem: function(key) {
                return data[key];
            },
            setItem: function(key, value) {
                data[key] = value;
            },
            removeItem: function(key) {
                delete data[key];
            }
        };
    }
    function ReportViewerSettings(id, storage, defaultSettings) {
        var _this = {};
        function getItem(key) {
            var value = storage.getItem(formatKey(key));
            return value !== null && value !== undefined ? value : defaultSettings[key];
        }
        function stateItem(prop, args) {
            var stateKey = "state";
            var stateString = getItem(stateKey);
            var state = typeof stateString === "string" ? JSON.parse(stateString) : {};
            if (args.length) {
                if (state) {
                    var newValue = args[0];
                    if (newValue === undefined) {
                        delete state[prop];
                    } else {
                        state[prop] = newValue;
                    }
                }
                setItem(stateKey, JSON.stringify(state));
                return _this;
            } else {
                return state[prop];
            }
        }
        function setItem(key, value) {
            var formattedKey = formatKey(key);
            storage.setItem(formattedKey, value);
            if (storage instanceof window.Storage) {
                var oldValue = storage.getItem(formattedKey);
                var storageEvent = document.createEvent("StorageEvent");
                storageEvent.initStorageEvent("telerikReportingStorage", false, false, formattedKey, oldValue, value, null, storage);
                window.dispatchEvent(storageEvent);
            }
        }
        function formatKey(key) {
            return id + "_" + key;
        }
        function value(key, args) {
            if (args.length) {
                setItem(key, args[0]);
                return _this;
            } else {
                return getItem(key);
            }
        }
        function valueFloat(key, args) {
            if (args.length) {
                setItem(key, args[0]);
                return _this;
            } else {
                return parseFloat(getItem(key));
            }
        }
        function valueObject(key, args) {
            if (args.length) {
                setItem(key, JSON.stringify(args[0]));
                return _this;
            } else {
                var value = getItem(key);
                return typeof value === "string" ? JSON.parse(value) : null;
            }
        }
        utils.extend(_this, {
            viewMode: function() {
                return stateItem("viewMode", arguments);
            },
            pageMode: function() {
                return stateItem("pageMode", arguments);
            },
            printMode: function() {
                return stateItem("printMode", arguments);
            },
            scale: function() {
                return stateItem("scale", arguments);
            },
            scaleMode: function() {
                return stateItem("scaleMode", arguments);
            },
            documentMapVisible: function() {
                return stateItem("documentMapVisible", arguments);
            },
            parametersAreaVisible: function() {
                return stateItem("parametersAreaVisible", arguments);
            },
            history: function() {
                return valueObject("history", arguments);
            },
            clientId: function() {
                return value("clientId", arguments);
            },
            reportSource: function() {
                return stateItem("reportSource", arguments);
            },
            pageNumber: function() {
                return stateItem("pageNumber", arguments);
            },
            enableAccessibility: function() {
                return value("enableAccessibility", arguments);
            },
            accessibilityKeyMap: function() {
                return stateItem("accessibilityKeyMap", arguments);
            },
            searchMetadataOnDemand: function() {
                return value("searchMetadataOnDemand", arguments);
            }
        });
        return _this;
    }
    function getDefaultOptions(serviceUrl) {
        return {
            id: null,
            serviceUrl: null,
            templateUrl: utils.rtrim(serviceUrl, "\\/") + "/resources/templates/telerikReportViewerTemplate-html",
            reportSource: null,
            reportServer: null,
            authenticationToken: null,
            sendEmail: null,
            scale: 1,
            scaleMode: trv.ScaleModes.FIT_PAGE,
            viewMode: trv.ViewModes.INTERACTIVE,
            pageMode: trv.PageModes.CONTINUOUS_SCROLL,
            parameters: {
                editors: {
                    multiSelect: trv.ParameterEditorTypes.LIST_VIEW,
                    singleSelect: trv.ParameterEditorTypes.LIST_VIEW
                }
            },
            persistSession: false,
            parameterEditors: [],
            disabledButtonClass: null,
            checkedButtonClass: null,
            parametersAreaVisible: true,
            documentMapVisible: true,
            enableAccessibility: false,
            searchMetadataOnDemand: false,
            initialPageAreaImageUrl: null
        };
    }
    function ReportViewer(dom, options) {
        if (!window.kendo) {
            alert("Kendo is not loaded. Make sure that Kendo is included.");
        }
        var $placeholder = $(dom), templates = {}, scripts = {}, persistanceKey = options.id || "#" + $placeholder.attr("id"), accessibility, svcApiUrl = options.serviceUrl, settings = {}, client = {}, controller = {}, history = {}, commands = {}, viewer = {}, serviceClientOptions = {}, reportServerUrl = "", reportServerUrlSVCApiUrl = "";
        if (!validateOptions(options)) {
            return;
        }
        if (options.reportServer) {
            reportServerUrlSVCApiUrl = utils.rtrim(options.reportServer.url, "\\/");
            svcApiUrl = reportServerUrlSVCApiUrl + "/api/reports";
        }
        options = utils.extend({}, getDefaultOptions(svcApiUrl), options);
        options.viewerSelector = persistanceKey.replace("#", "");
        settings = new ReportViewerSettings(persistanceKey, options.persistSession ? window.sessionStorage : new MemStorage(), {
            scale: options.scale,
            scaleMode: options.scaleMode,
            printMode: options.printMode ? options.printMode : options.directPrint,
            enableAccessibility: options.enableAccessibility,
            searchMetadataOnDemand: options.searchMetadataOnDemand,
            sendEmail: options.sendEmail
        });
        if (options.reportServer) {
            reportServerUrl = utils.rtrim(options.reportServer.url, "\\/");
            serviceClientOptions.serviceUrl = reportServerUrl + "/api/reports";
            serviceClientOptions.loginInfo = {
                url: reportServerUrl + "/Token",
                username: options.reportServer.username,
                password: options.reportServer.password
            };
        } else {
            serviceClientOptions.serviceUrl = options.serviceUrl;
        }
        client = new trv.ServiceClient(serviceClientOptions);
        controller = options.controller;
        if (!controller) {
            controller = new trv.ReportViewerController({
                serviceClient: client,
                settings: settings
            });
        } else {
            controller.updateSettings(settings);
        }
        history = new trv.HistoryManager({
            controller: controller,
            settings: settings
        });
        commands = new trv.CommandSet({
            controller: controller,
            history: history
        });
        new trv.uiController({
            controller: controller,
            history: history,
            commands: commands
        });
        viewer = {
            stringResources: sr,
            refreshReport: function(ignoreCache) {
                if (arguments.length === 0) {
                    ignoreCache = true;
                }
                controller.refreshReport(ignoreCache);
                return viewer;
            },
            reportSource: function(rs) {
                if (rs || rs === null) {
                    controller.reportSource(rs);
                    controller.refreshReport(false);
                    return viewer;
                }
                return controller.reportSource();
            },
            clearReportSource: function() {
                controller.clearReportSource();
                return viewer;
            },
            viewMode: function(vm) {
                if (vm) {
                    controller.viewMode(vm);
                    return viewer;
                }
                return controller.viewMode();
            },
            pageMode: function(psm) {
                if (psm) {
                    controller.pageMode(psm);
                    return viewer;
                }
                return controller.pageMode();
            },
            printMode: function(pm) {
                if (pm) {
                    controller.printMode(pm);
                    return viewer;
                }
                return controller.printMode();
            },
            scale: function(scale) {
                if (scale) {
                    controller.scale(scale);
                    return viewer;
                }
                scale = {};
                controller.getScale(scale);
                return scale;
            },
            currentPage: function() {
                return controller.currentPageNumber();
            },
            pageCount: function() {
                return controller.pageCount();
            },
            parametersAreaVisible: function(visible) {
                controller.setParametersAreaVisible({
                    visible: visible
                });
            },
            authenticationToken: function(token) {
                if (token) {
                    controller.setAuthenticationToken(token);
                }
                return viewer;
            },
            bind: function(eventName, eventHandler) {
                eventBinder(eventName, eventHandler, true);
            },
            unbind: function(eventName, eventHandler) {
                eventBinder(eventName, eventHandler, false);
            },
            accessibilityKeyMap: function(keyMap) {
                if (accessibility) {
                    if (keyMap) {
                        accessibility.setKeyMap(keyMap);
                        return viewer;
                    }
                    return accessibility.getKeyMap();
                }
                return undefined;
            },
            commands: commands
        };
        function validateOptions(options) {
            if (!options) {
                $placeholder.html("The report viewer configuration options are not initialized.");
                return false;
            }
            if (options.reportServer) {
                if (!options.reportServer.url) {
                    $placeholder.html("The report server URL is not specified.");
                    return false;
                }
            } else {
                if (!options.serviceUrl) {
                    $placeholder.html("The serviceUrl is not specified.");
                    return false;
                }
            }
            return true;
        }
        function eventBinder(eventName, eventHandler, bind) {
            if (typeof eventHandler === "function") {
                if (bind) {
                    $(viewer).on(eventName, {
                        sender: viewer
                    }, eventHandler);
                } else {
                    $(viewer).off(eventName, eventHandler);
                }
            } else if (!eventHandler && !bind) {
                $(viewer).off(eventName);
            }
        }
        function attachEvents() {
            var viewerEventsMapping = {
                EXPORT_BEGIN: controller.Events.EXPORT_STARTED,
                EXPORT_END: controller.Events.EXPORT_DOCUMENT_READY,
                PRINT_BEGIN: controller.Events.PRINT_STARTED,
                PRINT_END: controller.Events.PRINT_DOCUMENT_READY,
                RENDERING_BEGIN: controller.Events.BEFORE_LOAD_REPORT,
                RENDERING_END: controller.Events.REPORT_LOAD_COMPLETE,
                PAGE_READY: controller.Events.PAGE_READY,
                ERROR: controller.Events.ERROR,
                UPDATE_UI: controller.Events.UPDATE_UI,
                INTERACTIVE_ACTION_EXECUTING: controller.Events.INTERACTIVE_ACTION_EXECUTING,
                INTERACTIVE_ACTION_ENTER: controller.Events.INTERACTIVE_ACTION_ENTER,
                INTERACTIVE_ACTION_LEAVE: controller.Events.INTERACTIVE_ACTION_LEAVE,
                VIEWER_TOOLTIP_OPENING: controller.Events.TOOLTIP_OPENING,
                SEND_EMAIL_BEGIN: controller.Events.SEND_EMAIL_STARTED,
                SEND_EMAIL_END: controller.Events.SEND_EMAIL_READY
            }, $viewer = $(viewer);
            for (var eventName in viewerEventsMapping) {
                var controllerEventName = viewerEventsMapping[eventName];
                controller.on(controllerEventName, function($viewer, eventName) {
                    return function(e, args) {
                        $viewer.trigger({
                            type: eventName,
                            data: e.data
                        }, args);
                    };
                }($viewer, eventName));
            }
        }
        function attachEventHandlers() {
            eventBinder(trv.Events.EXPORT_BEGIN, options.exportBegin, true);
            eventBinder(trv.Events.EXPORT_END, options.exportEnd, true);
            eventBinder(trv.Events.PRINT_BEGIN, options.printBegin, true);
            eventBinder(trv.Events.PRINT_END, options.printEnd, true);
            eventBinder(trv.Events.RENDERING_BEGIN, options.renderingBegin, true);
            eventBinder(trv.Events.RENDERING_END, options.renderingEnd, true);
            eventBinder(trv.Events.PAGE_READY, options.pageReady, true);
            eventBinder(trv.Events.ERROR, options.error, true);
            eventBinder(trv.Events.UPDATE_UI, options.updateUi, true);
            eventBinder(trv.Events.INTERACTIVE_ACTION_EXECUTING, options.interactiveActionExecuting, true);
            eventBinder(trv.Events.INTERACTIVE_ACTION_ENTER, options.interactiveActionEnter, true);
            eventBinder(trv.Events.INTERACTIVE_ACTION_LEAVE, options.interactiveActionLeave, true);
            eventBinder(trv.Events.VIEWER_TOOLTIP_OPENING, options.viewerToolTipOpening, true);
            eventBinder(trv.Events.SEND_EMAIL_BEGIN, options.sendEmailBegin, true);
            eventBinder(trv.Events.SEND_EMAIL_END, options.sendEmailEnd, true);
        }
        function init() {
            $placeholder.html(templates["trv-report-viewer"]);
            binder.bind($placeholder, {
                controller: controller,
                commands: commands,
                templates: templates
            }, options);
            new trv.PerspectiveManager(dom, controller).attach();
            initSplitter();
            attachEvents();
            attachEventHandlers();
            initFromStorage();
            initAccessibility(options);
        }
        function initSplitter() {
            var splitter = $placeholder.find(".trv-splitter").kendoSplitter({
                panes: [ {
                    max: "500px",
                    min: "50px",
                    size: "210px",
                    collapsible: true,
                    collapsed: true
                }, {}, {
                    max: "500px",
                    min: "50px",
                    size: "210px",
                    collapsible: true
                } ],
                expand: function(e) {
                    var paneID = $(e.pane).attr("data-id");
                    setSplitterPaneVisibility(paneID, true);
                },
                collapse: function(e) {
                    var paneID = $(e.pane).attr("data-id");
                    setSplitterPaneVisibility(paneID, false);
                }
            });
            trv[options.viewerSelector + "-" + "splitter"] = splitter.data("kendoSplitter");
        }
        function setSplitterPaneVisibility(paneID, visible) {
            var panes = trv.panes;
            switch (paneID) {
              case "trv-document-map":
                controller.setDocumentMapVisible({
                    visible: visible
                });
                break;

              case "trv-parameters-area":
                controller.setParametersAreaVisible({
                    visible: visible
                });
                break;
            }
        }
        function initFromStorage() {
            var vm = settings.viewMode();
            var psm = settings.pageMode();
            var pm = settings.printMode();
            var s = settings.scale();
            var sm = settings.scaleMode();
            var dm = settings.documentMapVisible();
            var pa = settings.parametersAreaVisible();
            var am = settings.accessibilityKeyMap();
            controller.viewMode(vm ? vm : options.viewMode);
            controller.pageMode(psm ? psm : options.pageMode);
            controller.printMode(pm ? pm : options.printMode);
            controller.scale({
                scale: s ? s : options.scale,
                scaleMode: sm ? sm : options.scaleMode
            });
            controller.setDocumentMapVisible({
                visible: dm ? dm : options.documentMapVisible
            });
            controller.setParametersAreaVisible({
                visible: pa ? pa : options.parametersAreaVisible
            });
            controller.printModeChanged(function() {
                settings.printMode(controller.printMode());
            });
            controller.viewModeChanged(function() {
                settings.viewMode(controller.viewMode());
            });
            controller.pageModeChanged(function() {
                settings.pageMode(controller.pageMode());
            });
            controller.scale(function() {
                var args = {};
                controller.getScale(args);
                settings.scale(args.scale);
                settings.scaleMode(args.scaleMode);
            });
            controller.setSideMenuVisible(function(event, args) {
                window.setTimeout(function() {
                    (args.visible ? $.fn.addClass : $.fn.removeClass).call($placeholder, "trv-side-menu-visible");
                }, 1);
            });
            controller.setDocumentMapVisible(function() {
                var args = {};
                controller.getDocumentMapState(args);
                settings.documentMapVisible(args.visible);
            });
            controller.setParametersAreaVisible(function() {
                var args = {};
                controller.getParametersAreaState(args);
                settings.parametersAreaVisible(args.visible);
            });
        }
        function initAccessibility(options) {
            if (options.enableAccessibility) {
                accessibility = new trv.accessibility({
                    controller: controller,
                    templates: templates
                });
                var am = options.accessibilityKeyMap;
                if (am) {
                    accessibility.setKeyMap(am);
                }
                settings.contentTabIndex = getTemplateContentTabIndex();
            }
        }
        function getTemplateContentTabIndex() {
            var pageAreaSelector = "div.trv-pages-area";
            try {
                var pagesArea$ = $placeholder.find(pageAreaSelector);
                if (pagesArea$.length === 0) {
                    throw "Selector " + pageAreaSelector + " did not return a result.";
                }
                return parseInt(pagesArea$.attr("tabindex"));
            } catch (e) {
                if (console) console.log(e);
                return 0;
            }
        }
        function start() {
            var pendingRefresh = false;
            init();
            controller.reportLoadComplete(function() {
                if (options.documentMapVisible === false) {
                    controller.setDocumentMapVisible({
                        visible: false
                    });
                }
            });
            var rs = settings.reportSource();
            if (rs !== undefined) {
                controller.reportSource(rs);
                var pageNumber = settings.pageNumber();
                if (pageNumber !== undefined) {
                    controller.navigateToPage(pageNumber);
                }
                pendingRefresh = true;
            } else {
                if (options.viewMode) {
                    controller.viewMode(options.viewMode);
                }
                if (options.pageMode) {
                    controller.pageMode(options.pageMode);
                }
                if (options.reportSource) {
                    controller.reportSource(options.reportSource);
                    pendingRefresh = true;
                }
            }
            for (var i = 0; i < scripts.length; i++) {
                try {
                    eval(scripts[i]);
                } catch (e) {
                    if (console) console.log(e);
                }
            }
            if (typeof options.ready === "function") {
                options.ready.call(viewer);
            }
            if (pendingRefresh) {
                controller.refreshReport(false);
            }
        }
        function loadStyleSheets(styleSheets) {
            if (!styleSheets) return Promise.resolve();
            var $head = $("head");
            var currentStyleLinks = $head.find("link").map(function(i, e) {
                return e.outerHTML;
            }).toArray();
            var promises = [];
            utils.each(styleSheets, function(i, e) {
                if (-1 === currentStyleLinks.indexOf(e)) {
                    promises.push(new Promise(function(resolve, reject) {
                        var $link = $(e);
                        $link.on("load", resolve);
                        $link.on("onerror", function() {
                            utils.logError("error loading stylesheet " + e);
                            resolve();
                        });
                        $head.append($link);
                    }));
                }
            });
            return Promise.all(promises).then(controller.cssLoaded);
        }
        function browserSupportsAllFeatures() {
            return window.Promise;
        }
        function main(err) {
            if (err) {
                utils.logError(err);
            } else {
                if (options.authenticationToken) {
                    controller.setAuthenticationToken(options.authenticationToken);
                }
                controller.getDocumentFormats().catch(function() {
                    $placeholder.html(utils.stringFormat(sr.errorServiceUrl, [ utils.escapeHtml(svcApiUrl) ]));
                    return Promise.reject();
                }).then(function() {
                    templateCache.load(options.templateUrl, svcApiUrl, client).catch(function() {
                        $placeholder.html(utils.stringFormat(sr.errorLoadingTemplates, [ utils.escapeHtml(options.templateUrl) ]));
                        return Promise.reject();
                    }).then(function(result) {
                        templates = result.templates;
                        scripts = result.scripts;
                        return loadStyleSheets(result.styleSheets);
                    }).then(start);
                });
            }
        }
        if (browserSupportsAllFeatures()) {
            main();
        } else {
            utils.loadScript("https://cdn.polyfill.io/v2/polyfill.min.js?features=Promise", main);
        }
        return viewer;
    }
    var pluginName = "telerik_ReportViewer";
    jQuery.fn[pluginName] = function(options) {
        if (this.selector && !options.selector) {
            options.selector = this.selector;
        }
        return utils.each(this, function() {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new ReportViewer(this, options));
            }
        });
    };
    trv.ReportViewer = ReportViewer;
})(window.telerikReportViewer = window.telerikReportViewer || {}, jQuery, window, document);
/* DO NOT MODIFY OR DELETE THIS LINE! UPGRADE WIZARD CHECKSUM 6A7D71F99150CD60176731D96ADCD3FF */