(function(a){var b=["es","en","pt"];a(document).ready(function(){function c(c){if("all"!=c)for(i=0;i<b.length;i++)b[i]==c?(a("div[class*=_"+b[i]+"]").removeClass("wLangRowItem"),a("div[class*=-"+b[i]+"]").removeClass("wLangRowItem")):(a("div[class*=_"+b[i]+"]").addClass("wLangRowItem"),a("div[class*=-"+b[i]+"]").addClass("wLangRowItem"));else for(i=0;i<b.length;i++)a("div[class*=_"+b[i]+"]").removeClass("wLangRowItem"),a("div[class*=-"+b[i]+"]").removeClass("wLangRowItem")}a("#id_color_filter").attr("type","color"),a(".url_seo .grp-readonly").each(function(){a(this).html(),console.log(a(this).html()),a(this).parent().append("<a class=\"wSEOLink\" href=\""+a(this).html()+"\" target=\"_blank\" style=\"margin-left: 5px;\">Abrir Enlace </a>")}),a("#grp-content-title").append("<ul class=\"grp-object-tools wLangList\"><li>\t\t\t\t\t\t\t\t\t\t\t<a class=\"wChangeLang wEs\" data-wlang=\"es\">ES</a>\t\t\t\t\t\t\t\t\t\t\t<a class=\"wChangeLang wEn\" data-wlang=\"en\">EN</a>\t\t\t\t\t\t\t\t\t\t\t<a class=\"wChangeLang wPt\" data-wlang=\"pt\">PT</a>\t\t\t\t\t\t\t\t\t\t\t<a class=\"wChangeLang wAll wLangActive\" data-wlang=\"all\">ALL</a>\t\t\t\t\t\t\t\t\t\t\t</li></ul>"),a(".wChangeLang").click(function(){a(".wChangeLang").removeClass("wLangActive"),a(this).addClass("wLangActive"),c(a(this).attr("data-wlang"))}),a("#grp-content-title .wEs").trigger("click")})})(grp.jQuery);