function validar(a,b,c,d){var e=!0,f=$(a).val();if(''==f||f==$(a).attr('placeholder')||null==f)e=!1,$(a).addClass(d),$(a+'_error').css('display','block');else{if($(a+'_error').css('display','none'),$(a).removeClass(d),'mail'==c){var g=/^([\w-\.]+@([\w-]+\.)+[\w-]{2,8})?$/;g.test(f)?($(a).removeClass(d),$(a+'_error').css('display','none')):(e=!1,$(a).addClass(d),$(a+'_error').css('display','block'))}if('file'==c){myfile=$(a).val(),$('#conten_file_name').html(myfile.split('\\').pop());var h=myfile.split('.').pop();'pdf'==h||'docx'==h||'doc'==h?(e=!0,$(a).removeClass(d),$(a+'_error').css('display','none')):(e=!1,$(a).addClass(d),$(a+'_error').css('display','block'),alert('Solo se acepta .pdf .doc .docx'))}}return $(a).attr('onkeyup','wcc_verify(this.id);'),e}function validarSelectLi(a,b,c,d){console.log(a);var e=!0,f=$(a).val();return''==f||f==$(a).attr('placeholder')||null==f?(e=!1,$(a).parent('li').addClass(d),$(a+'_error').css('display','block')):($(a+'_error').css('display','none'),$(a).parent('li').removeClass(d)),$(a).attr('onchange','validarSelectLi("'+a+'","","text","error");'),e}function wcc_verify(a){a='#'+a,error='error',tipo=$(a).attr('type');var b=$(a).val();if(''==b||b==$(a).attr('placeholder')||null==b)valido=!1,$(a).addClass(error),$(a+'_error').css('display','block');else{if($(a+'_error').css('display','none'),$(a).removeClass(error),'email'==tipo){var c=/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;c.test(b)?($(a).removeClass(error),$(a+'_error').css('display','none')):(valido=!1,$(a).addClass(error),$(a+'_error').css('display','block'))}if('file'==tipo){myfile=$(a).val(),$('#conten_file_name').html(myfile.split('\\').pop());var d=myfile.split('.').pop();'pdf'==d||'docx'==d||'doc'==d?(valido=!0,$(a).removeClass(error),$(a+'_error').css('display','none')):(valido=!1,$(a).addClass(error),$(a+'_error').css('display','block'),alert('Solo se acepta .pdf .doc .docx'))}}$(a).attr('onkeyup','wcc_verify(this.id);')}$('#wSuscriptForm').submit(function(){var a=!0;return valido4=validar('#wcc_email_suscript','Email*','mail','error'),valido4?(a=!0,$('.w-boton').css('display','none'),$('#mensaje-form').css('display','block'),$('#mensaje-form').html('Su mensaje esta siendo enviado ...')):a=!1,a}),$('#idcontactotra').submit(function(){var a=!0;return valido1=validar('#wNombreJob','','text','error'),valido4=validar('#archivo','','file','error'),valido1&&valido4?(a=!0,$('.w-boton').css('display','none'),$('#mensaje-form').css('display','block'),$('#mensaje-form').html('Su mensaje esta siendo enviado ...')):a=!1,a}),$('#wBusquedaHomeForm').submit(function(){var a=!0;return valido1=validarSelectLi('#wmarca_hf','Email*','text','error'),valido2=validarSelectLi('#wmodelo_hf','Email*','text','error'),valido3=validarSelectLi('#wuso_hf','Email*','text','error'),valido1&&valido2&&valido3?(a=!0,$('.w-boton').css('display','none'),$('#mensaje-form').css('display','block'),$('#mensaje-form').html('Su mensaje esta siendo enviado ...')):a=!1,a}),$('#wTopFormBattery').submit(function(){var a=!0;return valido1=validarSelectLi('#wMarcaSelectTopForm','Email*','text','error'),valido2=validarSelectLi('#wModelSelectTopForm','Email*','text','error'),valido3=validarSelectLi('#wUsoSelectTopForm','Email*','text','error'),valido1&&valido2&&valido3?(a=!0,$('.w-boton').css('display','none'),$('#mensaje-form').css('display','block'),$('#mensaje-form').html('Su mensaje esta siendo enviado ...')):a=!1,a}),$('#wTopFormBattery2').submit(function(){var a=!0;return valido1=validarSelectLi('#wMarcaSelectTopForm','Email*','text','error'),valido2=validarSelectLi('#wModelSelectTopForm','Email*','text','error'),valido1&&valido2?(a=!0,$('.w-boton').css('display','none'),$('#mensaje-form').css('display','block'),$('#mensaje-form').html('Su mensaje esta siendo enviado ...')):a=!1,a}),$('.wMarcaSelect').change(function(){var a={};''==$(this).val()?($('.wModelSelect').empty(),$('.wModelSelect').html('<option value="">-------------</option>'),$('.wModelSelect').change()):(a.marca=$(this).val(),$.ajax({url:'/es/mpm/',data:a,type:'POST',dataType:'json'}).done(function(a){$('.wModelSelect').empty(),$.each(a,function(a,b){$('<option data-have="'+b.have+'" value="'+b.nombre+'">'+b.nombre+'</option>').appendTo('.wModelSelect')}),$('.wModelSelect').change()}))}),$('.wMarcaSelectLM').change(function(){var a={};''==$(this).val()?($('.wModelSelectLM').empty(),$('.wModelSelectLM').html('<option value="">-------------</option>'),$('.wModelSelectLM').change()):(a.marca=$(this).val(),$.ajax({url:'/es/mpm_lm/',data:a,type:'POST',dataType:'json'}).done(function(a){$('.wModelSelectLM').empty(),$.each(a,function(a,b){$('<option value="'+b+'">'+b+'</option>').appendTo('.wModelSelectLM')}),$('.wModelSelectLM').change()}))}),$('.wMarcaSelectBM').change(function(){var a={};''==$(this).val()?($('.wModelSelectBM').empty(),$('.wModelSelectBM').html('<option value="">-------------</option>'),$('.wModelSelectBM').change()):(a.marca=$(this).val(),$.ajax({url:'/es/mpm_bm/',data:a,type:'POST',dataType:'json'}).done(function(a){$('.wModelSelectBM').empty(),$.each(a,function(a,b){$('<option value="'+b+'">'+b+'</option>').appendTo('.wModelSelectBM')}),$('.wModelSelectBM').change()}))});