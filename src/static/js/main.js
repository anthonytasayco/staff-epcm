$(function(){function a(){$('.menu-sidebar').removeClass('active'),$('.menu-overlay').removeClass('active'),$('.menu-mobile-close').removeClass('active'),$('.menu-mobile-open').removeClass('active'),$('.cnt-wrapper').removeClass('active'),$('.footer').removeClass('active'),$('body').removeClass('active')}var b=new Date,c=b.getFullYear();if($('#id_year').text(c),$('.h1-logo-2').clone().appendTo('.menu-sidebar-cnt').addClass('resp-logo').removeClass('h1-logo-2').removeClass('h1-logo'),$('.menu-list').clone().appendTo('.menu-sidebar-cnt').addClass('menu-responsive').removeClass('menu-list-1'),$('.footer-menu ul li').clone().appendTo('.menu-responsive'),$('.clone-contacto ul li:last-child').clone().appendTo('.menu-responsive'),$('.clone-menu').clone().appendTo('.menu-sidebar-cnt').addClass('menu-toggle-resp').removeClass('footer-item').removeClass('clone-contacto').removeClass('clone-menu'),$('.h2-btn').clone().appendTo('.menu-sidebar-cnt'),$('.h1-languaje').clone().appendTo('.menu-sidebar-cnt'),$('.h2-iconos').clone().appendTo('.menu-sidebar-cnt'),$('.menu-mobile-open').click(function(){$(this).addClass('active'),$('.menu-mobile-close').addClass('active'),$('.menu-sidebar').addClass('active'),$('.menu-overlay').addClass('active'),$('.cnt-wrapper').addClass('active'),$('.footer').addClass('active'),$('body').addClass('active')}),($('.menu-mobile-close').click(function(){a()}),$('.menu-overlay').click(function(){a()}),dispositivo_movil=$.browser.device=/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase()),dispositivo_movil)){window.onorientationchange=function(){90===Math.abs(window.orientation)?a():a()}}else $(window).resize(function(){var b=$('.menu-responsive').width();0!=b&&a()});$.browser.chrome=/chrome/.test(navigator.userAgent.toLowerCase()),$.browser.chrome&&($.browser.safari=!1),$.browser.safari,$('.miclase[href*=#]').click(function(){if(location.pathname.replace(/^\//,'')==this.pathname.replace(/^\//,'')&&location.hostname==this.hostname){var a=$(this.hash);if(a=a.length&&a||$('[name='+this.hash.slice(1)+']'),a.length){var b=a.offset().top;return $('html,body').animate({scrollTop:b},1e3),!1}}}),$('.no-style *').removeAttr('style');var d=0;$(window).scroll(function(){d=$(window).scrollTop(),0<d?$('.header-home .header').addClass('active'):$('.header-home .header').removeClass('active')}),$('input, textarea').placeholder()});function languaje_hover(){$('.h1-languaje li:nth-child(1)').hover(function(){$('.h1-languaje').addClass('borde-1')},function(){$('.h1-languaje').removeClass('borde-1')}),$('.h1-languaje li:nth-child(2)').hover(function(){$('.h1-languaje').addClass('bordes')},function(){$('.h1-languaje').removeClass('bordes')}),$('.h1-languaje li:nth-child(3)').hover(function(){$('.h1-languaje').addClass('borde-2')},function(){$('.h1-languaje').removeClass('borde-2')})}function languaje_active(){var a=$('.h1-languaje li:nth-child(1).active');a.hasClass('active')&&$('.h1-languaje li:nth-child(1)').addClass('delet-borde1');var b=$('.h1-languaje li:nth-child(2).active');b.hasClass('active')&&($('.h1-languaje li:nth-child(1)').addClass('delet-borde1'),$('.h1-languaje li:nth-child(2)').addClass('delet-borde1'));var c=$('.h1-languaje li:nth-child(3).active');c.hasClass('active')&&$('.h1-languaje li:nth-child(2)').addClass('delet-borde1')}function h_open_menu(){$('.header').addClass('header-color'),$('.header-home .header').removeClass('header-color').addClass('home-color-desplegable'),$('.header-desplegable').addClass('active'),$('.header-overlay').addClass('active'),$('.h1-openDesplegable').addClass('active'),$('.h1-closeDesplegable').addClass('active')}function h_close_menu(){$('.header').removeClass('header-color'),$('.header-home .header').removeClass('home-color-desplegable'),$('.header-desplegable').removeClass('active'),$('.header-overlay').removeClass('active'),$('.h1-closeDesplegable').removeClass('active'),$('.h1-openDesplegable').removeClass('active')}var menu_resp_toggle=$('.openToggleResp.active');menu_resp_toggle.hasClass('active')&&($('.desplegableResp').hide(),menu_resp_toggle.closest('.openToggleResp').find('.desplegableResp').show());$(function(){$('.openToggleResp').click(function(){$(this).hasClass('active')?$(this).removeClass('active').parent().find('.desplegableResp').stop().slideUp():($('.openToggleResp').removeClass('active'),$('.desplegableResp').stop().slideUp(),$(this).addClass('active').parent().find('.desplegableResp').stop().slideToggle())});var a=$(window).width();1007<a&&languaje_hover(),languaje_active(),$('.h1-openDesplegable').click(function(){h_open_menu()}),$('.h1-closeDesplegable, .header-overlay').click(function(){h_close_menu()}),$(window).resize(function(){languaje_hover()})});