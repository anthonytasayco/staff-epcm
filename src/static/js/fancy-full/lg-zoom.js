(function(a,b){'use strict';var c=Math.abs,d={scale:1,zoom:!0,enableZoomAfter:300},e=function(c){return this.core=a(c).data('lightGallery'),this.core.s=a.extend({},d,this.core.s),this.core.s.zoom&&this.core.doCss()&&(this.init(),this.zoomabletimeout=!1,this.pageX=a(b).width()/2,this.pageY=a(b).height()/2+a(b).scrollTop()),this};e.prototype.init=function(){var c=this;this.core.$outer.find('.lg-toolbar').append('<span id="lg-zoom-in" class="lg-icon"></span><span id="lg-zoom-out" class="lg-icon"></span>'),c.core.$el.on('onSlideItemLoad.lg.tm.zoom',function(b,d,e){var f=c.core.s.enableZoomAfter+e;a('body').hasClass('lg-from-hash')&&e?f=0:a('body').removeClass('lg-from-hash'),c.zoomabletimeout=setTimeout(function(){c.core.$slide.eq(d).addClass('lg-zoomable')},f+30)});var d=1,e=function(d){var e,f,g=c.core.$outer.find('.lg-current .lg-image'),h=(a(b).width()-g.width())/2,i=(a(b).height()-g.height())/2+a(b).scrollTop();e=c.pageX-h,f=c.pageY-i;var j=(d-1)*e,k=(d-1)*f;g.css('transform','scale3d('+d+', '+d+', 1)').attr('data-scale',d),g.parent().css('transform','translate3d(-'+j+'px, -'+k+'px, 0)').attr('data-x',j).attr('data-y',k)},f=function(){1<d?c.core.$outer.addClass('lg-zoomed'):c.resetZoom(),1>d&&(d=1),e(d)},g=function(a,b,e){var g,h=b.width();g=c.core.s.dynamic?c.core.s.dynamicEl[e].width||b[0].naturalWidth||h:c.core.$items.eq(e).attr('data-width')||b[0].naturalWidth||h;var i;c.core.$outer.hasClass('lg-zoomed')?d=1:g>h&&(i=g/h,d=i||2),c.pageX=a.pageX||a.originalEvent.targetTouches[0].pageX,c.pageY=a.pageY||a.originalEvent.targetTouches[0].pageY,f(),setTimeout(function(){c.core.$outer.removeClass('lg-grabbing').addClass('lg-grab')},10)},h=!1;c.core.$el.on('onAferAppendSlide.lg.tm.zoom',function(a,b){var d=c.core.$slide.eq(b).find('.lg-image');d.on('dblclick',function(a){g(a,d,b)}),d.on('touchstart',function(a){h?(clearTimeout(h),h=null,g(a,d,b)):h=setTimeout(function(){h=null},300),a.preventDefault()})}),a(b).on('resize.lg.zoom scroll.lg.zoom orientationchange.lg.zoom',function(){c.pageX=a(b).width()/2,c.pageY=a(b).height()/2+a(b).scrollTop(),e(d)}),a('#lg-zoom-out').on('click.lg',function(){c.core.$outer.find('.lg-current .lg-image').length&&(d-=c.core.s.scale,f())}),a('#lg-zoom-in').on('click.lg',function(){c.core.$outer.find('.lg-current .lg-image').length&&(d+=c.core.s.scale,f())}),c.core.$el.on('onBeforeSlide.lg.tm',function(){d=1,c.resetZoom()}),c.core.isTouch||c.zoomDrag(),c.core.isTouch&&c.zoomSwipe()},e.prototype.resetZoom=function(){this.core.$outer.removeClass('lg-zoomed'),this.core.$slide.find('.lg-img-wrap').removeAttr('style data-x data-y'),this.core.$slide.find('.lg-image').removeAttr('style data-scale'),this.pageX=a(b).width()/2,this.pageY=a(b).height()/2+a(b).scrollTop()},e.prototype.zoomSwipe=function(){var a=this,b={},d={},f=!1,g=!1,h=!1;a.core.$slide.on('touchstart.lg',function(c){if(a.core.$outer.hasClass('lg-zoomed')){var d=a.core.$slide.eq(a.core.index).find('.lg-object');h=d.outerHeight()*d.attr('data-scale')>a.core.$outer.find('.lg').height(),g=d.outerWidth()*d.attr('data-scale')>a.core.$outer.find('.lg').width(),(g||h)&&(c.preventDefault(),b={x:c.originalEvent.targetTouches[0].pageX,y:c.originalEvent.targetTouches[0].pageY})}}),a.core.$slide.on('touchmove.lg',function(i){if(a.core.$outer.hasClass('lg-zoomed')){var e,j,k=a.core.$slide.eq(a.core.index).find('.lg-img-wrap');i.preventDefault(),f=!0,d={x:i.originalEvent.targetTouches[0].pageX,y:i.originalEvent.targetTouches[0].pageY},a.core.$outer.addClass('lg-zoom-dragging'),j=h?-c(k.attr('data-y'))+(d.y-b.y):-c(k.attr('data-y')),e=g?-c(k.attr('data-x'))+(d.x-b.x):-c(k.attr('data-x')),(15<c(d.x-b.x)||15<c(d.y-b.y))&&k.css('transform','translate3d('+e+'px, '+j+'px, 0)')}}),a.core.$slide.on('touchend.lg',function(){a.core.$outer.hasClass('lg-zoomed')&&f&&(f=!1,a.core.$outer.removeClass('lg-zoom-dragging'),a.touchendZoom(b,d,g,h))})},e.prototype.zoomDrag=function(){var d=this,f={},g={},h=!1,i=!1,j=!1,k=!1;d.core.$slide.on('mousedown.lg.zoom',function(b){var c=d.core.$slide.eq(d.core.index).find('.lg-object');k=c.outerHeight()*c.attr('data-scale')>d.core.$outer.find('.lg').height(),j=c.outerWidth()*c.attr('data-scale')>d.core.$outer.find('.lg').width(),d.core.$outer.hasClass('lg-zoomed')&&a(b.target).hasClass('lg-object')&&(j||k)&&(b.preventDefault(),f={x:b.pageX,y:b.pageY},h=!0,d.core.$outer.scrollLeft+=1,d.core.$outer.scrollLeft-=1,d.core.$outer.removeClass('lg-grab').addClass('lg-grabbing'))}),a(b).on('mousemove.lg.zoom',function(a){if(h){var b,e,l=d.core.$slide.eq(d.core.index).find('.lg-img-wrap');i=!0,g={x:a.pageX,y:a.pageY},d.core.$outer.addClass('lg-zoom-dragging'),e=k?-c(l.attr('data-y'))+(g.y-f.y):-c(l.attr('data-y')),b=j?-c(l.attr('data-x'))+(g.x-f.x):-c(l.attr('data-x')),l.css('transform','translate3d('+b+'px, '+e+'px, 0)')}}),a(b).on('mouseup.lg.zoom',function(a){h&&(h=!1,d.core.$outer.removeClass('lg-zoom-dragging'),i&&(f.x!==g.x||f.y!==g.y)&&(g={x:a.pageX,y:a.pageY},d.touchendZoom(f,g,j,k)),i=!1),d.core.$outer.removeClass('lg-grabbing').addClass('lg-grab')})},e.prototype.touchendZoom=function(a,b,d,e){var f=this,g=f.core.$slide.eq(f.core.index).find('.lg-img-wrap'),h=f.core.$slide.eq(f.core.index).find('.lg-object'),i=-c(g.attr('data-x'))+(b.x-a.x),j=-c(g.attr('data-y'))+(b.y-a.y),k=(f.core.$outer.find('.lg').height()-h.outerHeight())/2,l=c(h.outerHeight()*c(h.attr('data-scale'))-f.core.$outer.find('.lg').height()+k),m=(f.core.$outer.find('.lg').width()-h.outerWidth())/2,n=c(h.outerWidth()*c(h.attr('data-scale'))-f.core.$outer.find('.lg').width()+m);(15<c(b.x-a.x)||15<c(b.y-a.y))&&(e&&(j<=-l?j=-l:j>=-k&&(j=-k)),d&&(i<=-n?i=-n:i>=-m&&(i=-m)),e?g.attr('data-y',c(j)):j=-c(g.attr('data-y')),d?g.attr('data-x',c(i)):i=-c(g.attr('data-x')),g.css('transform','translate3d('+i+'px, '+j+'px, 0)'))},e.prototype.destroy=function(){var c=this;c.core.$el.off('.lg.zoom'),a(b).off('.lg.zoom'),c.core.$slide.off('.lg.zoom'),c.core.$el.off('.lg.tm.zoom'),c.resetZoom(),clearTimeout(c.zoomabletimeout),c.zoomabletimeout=!1},a.fn.lightGallery.modules.zoom=e})(jQuery,window,document);