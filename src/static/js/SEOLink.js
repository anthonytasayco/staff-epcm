(function(a){a(document).ready(function(){a('.url_seo .grp-readonly').each(function(){a(this).html(),console.log(a(this).html()),a(this).parent().append('<a class="wSEOLink" href="'+a(this).html()+'" target="_blank" style="margin-left: 5px;">Abrir Enlace </a>')})})})(grp.jQuery),function(a){a(document).ready(function(){a('.cv .grp-readonly').each(function(){a(this).html(),console.log(a(this).html()),a(this).parent().append('<a class="wSEOLink" href="'+MEDIA_URL+a(this).html()+'" target="_blank" style="margin-left: 5px;">Abrir Archivo</a>')})})}(grp.jQuery);