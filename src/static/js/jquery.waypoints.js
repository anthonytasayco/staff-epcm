(function(){'use strict';function a(d){if(!d)throw new Error('No options passed to Waypoint constructor');if(!d.element)throw new Error('No element option passed to Waypoint constructor');if(!d.handler)throw new Error('No handler option passed to Waypoint constructor');this.key='waypoint-'+b,this.options=a.Adapter.extend({},a.defaults,d),this.element=this.options.element,this.adapter=new a.Adapter(this.element),this.callback=d.handler,this.axis=this.options.horizontal?'horizontal':'vertical',this.enabled=this.options.enabled,this.triggerPoint=null,this.group=a.Group.findOrCreate({name:this.options.group,axis:this.axis}),this.context=a.Context.findOrCreateByElement(this.options.context),a.offsetAliases[this.options.offset]&&(this.options.offset=a.offsetAliases[this.options.offset]),this.group.add(this),this.context.add(this),c[this.key]=this,b+=1}var b=0,c={};a.prototype.queueTrigger=function(a){this.group.queueTrigger(this,a)},a.prototype.trigger=function(a){!this.enabled||this.callback&&this.callback.apply(this,a)},a.prototype.destroy=function(){this.context.remove(this),this.group.remove(this),delete c[this.key]},a.prototype.disable=function(){return this.enabled=!1,this},a.prototype.enable=function(){return this.context.refresh(),this.enabled=!0,this},a.prototype.next=function(){return this.group.next(this)},a.prototype.previous=function(){return this.group.previous(this)},a.invokeAll=function(a){var b=[];for(var d in c)b.push(c[d]);for(var e=0,f=b.length;e<f;e++)b[e][a]()},a.destroyAll=function(){a.invokeAll('destroy')},a.disableAll=function(){a.invokeAll('disable')},a.enableAll=function(){a.invokeAll('enable')},a.refreshAll=function(){a.Context.refreshAll()},a.viewportHeight=function(){return window.innerHeight||document.documentElement.clientHeight},a.viewportWidth=function(){return document.documentElement.clientWidth},a.adapters=[],a.defaults={context:window,continuous:!0,enabled:!0,group:'default',horizontal:!1,offset:0},a.offsetAliases={"bottom-in-view":function(){return this.context.innerHeight()-this.adapter.outerHeight()},"right-in-view":function(){return this.context.innerWidth()-this.adapter.outerWidth()}},window.Waypoint=a})(),function(){'use strict';function a(a){window.setTimeout(a,1e3/60)}function b(a){this.element=a,this.Adapter=e.Adapter,this.adapter=new this.Adapter(a),this.key='waypoint-context-'+c,this.didScroll=!1,this.didResize=!1,this.oldScroll={x:this.adapter.scrollLeft(),y:this.adapter.scrollTop()},this.waypoints={vertical:{},horizontal:{}},a.waypointContextKey=this.key,d[a.waypointContextKey]=this,c+=1,this.createThrottledScrollHandler(),this.createThrottledResizeHandler()}var c=0,d={},e=window.Waypoint,f=window.onload;b.prototype.add=function(a){var b=a.options.horizontal?'horizontal':'vertical';this.waypoints[b][a.key]=a,this.refresh()},b.prototype.checkEmpty=function(){var a=this.Adapter.isEmptyObject(this.waypoints.horizontal),b=this.Adapter.isEmptyObject(this.waypoints.vertical);a&&b&&(this.adapter.off('.waypoints'),delete d[this.key])},b.prototype.createThrottledResizeHandler=function(){function a(){b.handleResize(),b.didResize=!1}var b=this;this.adapter.on('resize.waypoints',function(){b.didResize||(b.didResize=!0,e.requestAnimationFrame(a))})},b.prototype.createThrottledScrollHandler=function(){function a(){b.handleScroll(),b.didScroll=!1}var b=this;this.adapter.on('scroll.waypoints',function(){(!b.didScroll||e.isTouch)&&(b.didScroll=!0,e.requestAnimationFrame(a))})},b.prototype.handleResize=function(){e.Context.refreshAll()},b.prototype.handleScroll=function(){var a={},b={horizontal:{newScroll:this.adapter.scrollLeft(),oldScroll:this.oldScroll.x,forward:'right',backward:'left'},vertical:{newScroll:this.adapter.scrollTop(),oldScroll:this.oldScroll.y,forward:'down',backward:'up'}};for(var c in b){var d=b[c],e=d.newScroll>d.oldScroll,f=e?d.forward:d.backward;for(var g in this.waypoints[c]){var h=this.waypoints[c][g],i=d.oldScroll<h.triggerPoint,j=d.newScroll>=h.triggerPoint;(i&&j||!i&&!j)&&(h.queueTrigger(f),a[h.group.id]=h.group)}}for(var k in a)a[k].flushTriggers();this.oldScroll={x:b.horizontal.newScroll,y:b.vertical.newScroll}},b.prototype.innerHeight=function(){return this.element==this.element.window?e.viewportHeight():this.adapter.innerHeight()},b.prototype.remove=function(a){delete this.waypoints[a.axis][a.key],this.checkEmpty()},b.prototype.innerWidth=function(){return this.element==this.element.window?e.viewportWidth():this.adapter.innerWidth()},b.prototype.destroy=function(){var a=[];for(var b in this.waypoints)for(var c in this.waypoints[b])a.push(this.waypoints[b][c]);for(var d=0,e=a.length;d<e;d++)a[d].destroy()},b.prototype.refresh=function(){var a,b=this.element==this.element.window,c=b?void 0:this.adapter.offset(),d={};for(var f in this.handleScroll(),a={horizontal:{contextOffset:b?0:c.left,contextScroll:b?0:this.oldScroll.x,contextDimension:this.innerWidth(),oldScroll:this.oldScroll.x,forward:'right',backward:'left',offsetProp:'left'},vertical:{contextOffset:b?0:c.top,contextScroll:b?0:this.oldScroll.y,contextDimension:this.innerHeight(),oldScroll:this.oldScroll.y,forward:'down',backward:'up',offsetProp:'top'}},a){var g=a[f];for(var h in this.waypoints[f]){var i,j,k,l,m,n=this.waypoints[f][h],o=n.options.offset,p=n.triggerPoint,q=0,r=null==p;n.element!==n.element.window&&(q=n.adapter.offset()[g.offsetProp]),'function'==typeof o?o=o.apply(n):'string'==typeof o&&(o=parseFloat(o),-1<n.options.offset.indexOf('%')&&(o=Math.ceil(g.contextDimension*o/100))),i=g.contextScroll-g.contextOffset,n.triggerPoint=q+i-o,j=p<g.oldScroll,k=n.triggerPoint>=g.oldScroll,l=j&&k,m=!j&&!k,!r&&l?(n.queueTrigger(g.backward),d[n.group.id]=n.group):!r&&m?(n.queueTrigger(g.forward),d[n.group.id]=n.group):r&&g.oldScroll>=n.triggerPoint&&(n.queueTrigger(g.forward),d[n.group.id]=n.group)}}return e.requestAnimationFrame(function(){for(var a in d)d[a].flushTriggers()}),this},b.findOrCreateByElement=function(a){return b.findByElement(a)||new b(a)},b.refreshAll=function(){for(var a in d)d[a].refresh()},b.findByElement=function(a){return d[a.waypointContextKey]},window.onload=function(){f&&f(),b.refreshAll()},e.requestAnimationFrame=function(b){var c=window.requestAnimationFrame||window.mozRequestAnimationFrame||window.webkitRequestAnimationFrame||a;c.call(window,b)},e.Context=b}(),function(){'use strict';function a(c,a){return c.triggerPoint-a.triggerPoint}function b(c,a){return a.triggerPoint-c.triggerPoint}function c(a){this.name=a.name,this.axis=a.axis,this.id=this.name+'-'+this.axis,this.waypoints=[],this.clearTriggerQueues(),d[this.axis][this.name]=this}var d={vertical:{},horizontal:{}},e=window.Waypoint;c.prototype.add=function(a){this.waypoints.push(a)},c.prototype.clearTriggerQueues=function(){this.triggerQueues={up:[],down:[],left:[],right:[]}},c.prototype.flushTriggers=function(){for(var c in this.triggerQueues){var d=this.triggerQueues[c];d.sort('up'==c||'left'==c?b:a);for(var e,f=0,g=d.length;f<g;f+=1)e=d[f],(e.options.continuous||f==d.length-1)&&e.trigger([c])}this.clearTriggerQueues()},c.prototype.next=function(b){this.waypoints.sort(a);var c=e.Adapter.inArray(b,this.waypoints),d=c===this.waypoints.length-1;return d?null:this.waypoints[c+1]},c.prototype.previous=function(b){this.waypoints.sort(a);var c=e.Adapter.inArray(b,this.waypoints);return c?this.waypoints[c-1]:null},c.prototype.queueTrigger=function(a,b){this.triggerQueues[b].push(a)},c.prototype.remove=function(a){var b=e.Adapter.inArray(a,this.waypoints);-1<b&&this.waypoints.splice(b,1)},c.prototype.first=function(){return this.waypoints[0]},c.prototype.last=function(){return this.waypoints[this.waypoints.length-1]},c.findOrCreate=function(a){return d[a.axis][a.name]||new c(a)},e.Group=c}(),function(){'use strict';function a(a){this.$element=b(a)}var b=window.jQuery,c=window.Waypoint;b.each(['innerHeight','innerWidth','off','offset','on','outerHeight','outerWidth','scrollLeft','scrollTop'],function(b,c){a.prototype[c]=function(){var a=Array.prototype.slice.call(arguments);return this.$element[c].apply(this.$element,a)}}),b.each(['extend','inArray','isEmptyObject'],function(c,d){a[d]=b[d]}),c.adapters.push({name:'jquery',Adapter:a}),c.Adapter=a}(),function(){'use strict';function a(a){return function(){var c=[],d=arguments[0];return a.isFunction(arguments[0])&&(d=a.extend({},arguments[1]),d.handler=arguments[0]),this.each(function(){var e=a.extend({},d,{element:this});'string'==typeof e.context&&(e.context=a(this).closest(e.context)[0]),c.push(new b(e))}),c}}var b=window.Waypoint;window.jQuery&&(window.jQuery.fn.waypoint=a(window.jQuery)),window.Zepto&&(window.Zepto.fn.waypoint=a(window.Zepto))}();