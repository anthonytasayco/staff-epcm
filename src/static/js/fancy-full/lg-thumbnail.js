(function(a,b){'use strict';var c=Math.abs,d={thumbnail:!0,animateThumb:!0,currentPagerPosition:'middle',thumbWidth:100,thumbContHeight:100,thumbMargin:5,exThumbImage:!1,showThumbByDefault:!0,toogleThumb:!0,pullCaptionUp:!0,enableThumbDrag:!0,enableThumbSwipe:!0,swipeThreshold:50,loadYoutubeThumbnail:!0,youtubeThumbSize:1,loadVimeoThumbnail:!0,vimeoThumbSize:'thumbnail_small',loadDailymotionThumbnail:!0},e=function(b){return this.core=a(b).data('lightGallery'),this.core.s=a.extend({},d,this.core.s),this.$el=a(b),this.$thumbOuter=null,this.thumbOuterWidth=0,this.thumbTotalWidth=this.core.$items.length*(this.core.s.thumbWidth+this.core.s.thumbMargin),this.thumbIndex=this.core.index,this.left=0,this.init(),this};e.prototype.init=function(){var a=this;this.core.s.thumbnail&&1<this.core.$items.length&&(this.core.s.showThumbByDefault&&setTimeout(function(){a.core.$outer.addClass('lg-thumb-open')},700),this.core.s.pullCaptionUp&&this.core.$outer.addClass('lg-pull-caption-up'),this.build(),this.core.s.animateThumb?(this.core.s.enableThumbDrag&&!this.core.isTouch&&this.core.doCss()&&this.enableThumbDrag(),this.core.s.enableThumbSwipe&&this.core.isTouch&&this.core.doCss()&&this.enableThumbSwipe(),this.thumbClickable=!1):this.thumbClickable=!0,this.toogle(),this.thumbkeyPress())},e.prototype.build=function(){function c(a,b,c){var d,h=e.core.isVideo(a,c)||{},i='';h.youtube||h.vimeo||h.dailymotion?h.youtube?e.core.s.loadYoutubeThumbnail?d='//img.youtube.com/vi/'+h.youtube[1]+'/'+e.core.s.youtubeThumbSize+'.jpg':d=b:h.vimeo?e.core.s.loadVimeoThumbnail?(d='//i.vimeocdn.com/video/error_'+g+'.jpg',i=h.vimeo[1]):d=b:h.dailymotion&&(e.core.s.loadDailymotionThumbnail?d='//www.dailymotion.com/thumbnail/video/'+h.dailymotion[1]:d=b):d=b,f+='<div data-vimeo-id="'+i+'" class="lg-thumb-item" style="width:'+e.core.s.thumbWidth+'px; margin-right: '+e.core.s.thumbMargin+'px"><img src="'+d+'" /></div>',i=''}var d,e=this,f='',g='';switch(this.core.s.vimeoThumbSize){case'thumbnail_large':g='640';break;case'thumbnail_medium':g='200x150';break;case'thumbnail_small':g='100x75';}if(e.core.$outer.addClass('lg-has-thumb'),e.core.$outer.find('.lg').append('<div class="lg-thumb-outer"><div class="lg-thumb group"></div></div>'),e.$thumbOuter=e.core.$outer.find('.lg-thumb-outer'),e.thumbOuterWidth=e.$thumbOuter.width(),e.core.s.animateThumb&&e.core.$outer.find('.lg-thumb').css({width:e.thumbTotalWidth+'px',position:'relative'}),this.core.s.animateThumb&&e.$thumbOuter.css('height',e.core.s.thumbContHeight+'px'),e.core.s.dynamic)for(var h=0;h<e.core.s.dynamicEl.length;h++)c(e.core.s.dynamicEl[h].src,e.core.s.dynamicEl[h].thumb,h);else e.core.$items.each(function(b){e.core.s.exThumbImage?c(a(this).attr('href')||a(this).attr('data-src'),a(this).attr(e.core.s.exThumbImage),b):c(a(this).attr('href')||a(this).attr('data-src'),a(this).find('img').attr('src'),b)});e.core.$outer.find('.lg-thumb').html(f),d=e.core.$outer.find('.lg-thumb-item'),d.each(function(){var b=a(this),c=b.attr('data-vimeo-id');c&&a.getJSON('//www.vimeo.com/api/v2/video/'+c+'.json?callback=?',{format:'json'},function(a){b.find('img').attr('src',a[0][e.core.s.vimeoThumbSize])})}),d.eq(e.core.index).addClass('active'),e.core.$el.on('onBeforeSlide.lg.tm',function(){d.removeClass('active'),d.eq(e.core.index).addClass('active')}),d.on('click.lg touchend.lg',function(){var b=a(this);setTimeout(function(){(!e.thumbClickable||e.core.lgBusy)&&e.core.doCss()||(e.core.index=b.index(),e.core.slide(e.core.index,!1,!0))},50)}),e.core.$el.on('onBeforeSlide.lg.tm',function(){e.animateThumb(e.core.index)}),a(b).on('resize.lg.thumb orientationchange.lg.thumb',function(){setTimeout(function(){e.animateThumb(e.core.index),e.thumbOuterWidth=e.$thumbOuter.width()},200)})},e.prototype.setTranslate=function(a){this.core.$outer.find('.lg-thumb').css({transform:'translate3d(-'+a+'px, 0px, 0px)'})},e.prototype.animateThumb=function(a){var b=this.core.$outer.find('.lg-thumb');if(this.core.s.animateThumb){var c;switch(this.core.s.currentPagerPosition){case'left':c=0;break;case'middle':c=this.thumbOuterWidth/2-this.core.s.thumbWidth/2;break;case'right':c=this.thumbOuterWidth-this.core.s.thumbWidth;}this.left=(this.core.s.thumbWidth+this.core.s.thumbMargin)*a-1-c,this.left>this.thumbTotalWidth-this.thumbOuterWidth&&(this.left=this.thumbTotalWidth-this.thumbOuterWidth),0>this.left&&(this.left=0),this.core.lGalleryOn?(!b.hasClass('on')&&this.core.$outer.find('.lg-thumb').css('transition-duration',this.core.s.speed+'ms'),!this.core.doCss()&&b.animate({left:-this.left+'px'},this.core.s.speed)):!this.core.doCss()&&b.css('left',-this.left+'px'),this.setTranslate(this.left)}},e.prototype.enableThumbDrag=function(){var d=this,f=0,g=0,h=!1,i=!1,j=0;d.$thumbOuter.addClass('lg-grab'),d.core.$outer.find('.lg-thumb').on('mousedown.lg.thumb',function(a){d.thumbTotalWidth>d.thumbOuterWidth&&(a.preventDefault(),f=a.pageX,h=!0,d.core.$outer.scrollLeft+=1,d.core.$outer.scrollLeft-=1,d.thumbClickable=!1,d.$thumbOuter.removeClass('lg-grab').addClass('lg-grabbing'))}),a(b).on('mousemove.lg.thumb',function(a){h&&(j=d.left,i=!0,g=a.pageX,d.$thumbOuter.addClass('lg-dragging'),j-=g-f,j>d.thumbTotalWidth-d.thumbOuterWidth&&(j=d.thumbTotalWidth-d.thumbOuterWidth),0>j&&(j=0),d.setTranslate(j))}),a(b).on('mouseup.lg.thumb',function(){i?(i=!1,d.$thumbOuter.removeClass('lg-dragging'),d.left=j,c(g-f)<d.core.s.swipeThreshold&&(d.thumbClickable=!0)):d.thumbClickable=!0,h&&(h=!1,d.$thumbOuter.removeClass('lg-grabbing').addClass('lg-grab'))})},e.prototype.enableThumbSwipe=function(){var a=this,b=0,d=0,f=!1,g=0;a.core.$outer.find('.lg-thumb').on('touchstart.lg',function(c){a.thumbTotalWidth>a.thumbOuterWidth&&(c.preventDefault(),b=c.originalEvent.targetTouches[0].pageX,a.thumbClickable=!1)}),a.core.$outer.find('.lg-thumb').on('touchmove.lg',function(c){a.thumbTotalWidth>a.thumbOuterWidth&&(c.preventDefault(),d=c.originalEvent.targetTouches[0].pageX,f=!0,a.$thumbOuter.addClass('lg-dragging'),g=a.left,g-=d-b,g>a.thumbTotalWidth-a.thumbOuterWidth&&(g=a.thumbTotalWidth-a.thumbOuterWidth),0>g&&(g=0),a.setTranslate(g))}),a.core.$outer.find('.lg-thumb').on('touchend.lg',function(){a.thumbTotalWidth>a.thumbOuterWidth?f?(f=!1,a.$thumbOuter.removeClass('lg-dragging'),c(d-b)<a.core.s.swipeThreshold&&(a.thumbClickable=!0),a.left=g):a.thumbClickable=!0:a.thumbClickable=!0})},e.prototype.toogle=function(){var a=this;a.core.s.toogleThumb&&(a.core.$outer.addClass('lg-can-toggle'),a.$thumbOuter.append('<span class="lg-toogle-thumb lg-icon"></span>'),a.core.$outer.find('.lg-toogle-thumb').on('click.lg',function(){a.core.$outer.toggleClass('lg-thumb-open')}))},e.prototype.thumbkeyPress=function(){var c=this;a(b).on('keydown.lg.thumb',function(a){38===a.keyCode?(a.preventDefault(),c.core.$outer.addClass('lg-thumb-open')):40===a.keyCode&&(a.preventDefault(),c.core.$outer.removeClass('lg-thumb-open'))})},e.prototype.destroy=function(){this.core.s.thumbnail&&1<this.core.$items.length&&(a(b).off('resize.lg.thumb orientationchange.lg.thumb keydown.lg.thumb'),this.$thumbOuter.remove(),this.core.$outer.removeClass('lg-has-thumb'))},a.fn.lightGallery.modules.Thumbnail=e})(jQuery,window,document);