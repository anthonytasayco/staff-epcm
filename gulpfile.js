/* Config Gulp Task */
var gulp = require('gulp'),
	plumber = require('gulp-plumber'),
	nib = require('nib'),
	concat = require('gulp-concat'),
	findPort = require('find-port'),
	stylus = require('gulp-stylus'),
	connect = require('gulp-connect'),
	shell = require('gulp-shell');

// Funciones Globales
function makeid(){
	var text = "";
	var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	for( var i=0; i < 8; i++ )
		text += possible.charAt(Math.floor(Math.random() * possible.length));

	return text;
}

function StartsWith(s1, s2) {
	return (s1.length >= s2.length && s1.substr(0, s2.length) == s2);
}

var server_port = 8080;
findPort(server_port, server_port+10, function(ports) {
		server_port = ports[0];
	});


//Directorios de sistema
var path = {
	master_styl: 'src/static/stylus/styles.styl',
	production_styl: 'src/static/stylus/production.styl',
	stylus_dirs: 'src/static/stylus/**/*.styl',
	stylus_blocks_dir: 'src/static/stylus/blocks/*.styl',
	css_builds: 'src/static/css/builds/*.css',
	css_builds_dir: 'src/static/css/builds/',
	css: 'src/static/css/',
	all_apps: 'src/apps/**/*.py',
	all_templates: 'src/templates/**/*.html'
}

CONST = {
	ROOT : 'src/'
};

//Livereload - Watch Taks HTML - CSS
gulp.task('connect', function(){
	connect.server({
		root: CONST.ROOT,
		port: server_port,
		livereload: true
	});
});

// Runserver
gulp.task('run', function () {
	findPort(9090, 9100, function(ports) {
			var server_port = ports[0];
			console.log('[00:00:00] Corriendo en http://server.loc:'+server_port)
			return gulp.src('*.js', {read: false})
				.pipe(shell([
					'fab run:'+server_port
				], {
					templateData: {
						f: function (s) {
							return s.replace(/$/, '.bak')
						}
					}
				}));
		});

});


// Concat Css
gulp.task('concat_css', function () {
	setTimeout(function () {
		return gulp.src(path.css_builds)
		.pipe(plumber())
		.pipe(concat('blocks_styl.css'))
		.pipe(plumber.stop())
		.pipe(gulp.dest(path.css)).on('end', function(){
				console.log('>>>>>>>>>> Css Concatenados perfectamente...');
			})
	}, 256);
});

// Stylus Compiler
gulp.task('stylus', function () {
	return gulp.src(path.master_styl)
	.pipe(plumber())
	.pipe(stylus({ use: nib(),  import: ['nib']}))
	.pipe(plumber.stop())
	.pipe(gulp.dest(path.css))});



// Stylus Compiler
gulp.task('stylus_prod', function () {
	return gulp.src(path.production_styl)
	//.pipe(plumber())
	.pipe(stylus({ use: nib(),  import: ['nib']}))
	//.pipe(plumber.stop())
	.pipe(gulp.dest(path.css))});


// Stylus Compiler
gulp.task('stylus_blocks', function () {
	return gulp.src(path.stylus_blocks_dir)
	.pipe(plumber())
	.pipe(stylus({ use: nib(),  import: ['nib','../config/identity']}))
	.pipe(plumber.stop())
	.pipe(gulp.dest(path.css_builds_dir)).on('end', function(){
		setTimeout(function () {
			return gulp.src(path.css_builds)
			.pipe(plumber())
			.pipe(concat('blocks_styl.css'))
			.pipe(plumber.stop())
			.pipe(gulp.dest(path.css)).on('end', function(){
				console.log('>>>>>>>>>> Css Concatenados perfectamente...');
			})
		}, 1);
	})});

gulp.task('reload_server', function () {
	// Se retrasa a 0.2 segundos el LiveReload
	setTimeout(function () {
		return gulp.src(path.all_templates).pipe(connect.reload()).on('end', function(){
				console.log('>>>>>>>>>> Navegador refrescado...');
			});
	}, 768);
});

function styl_com_con(file){
	if (StartsWith(file.path,"/")){
		file_name = file.path.split('/')[file.path.split('/').length - 1];
	}else{
		file_name = file.path.split('\\')[file.path.split('\\').length - 1];
	}
	console.log('>>>>>>>>>> Compiling '+file_name+' : running tasks...');
	gulp.src(file.path)
	.pipe(plumber())
	.pipe(stylus({ use: nib(),  import: ['nib','../config/identity']}))
	.pipe(plumber.stop())
	.pipe(gulp.dest(path.css_builds_dir))
	console.log('>>>>>>>>>> Compiled! '+file_name);
}

// watchers filePaths #withReload
gulp.task('watch', function () {
	gulp.watch(path.stylus_blocks_dir, ['concat_css']).on('change', function(file) {return styl_com_con(file);});
	gulp.watch(path.stylus_dirs, ['stylus']);
	gulp.watch(path.all_apps, ['reload_server']);
	gulp.watch(path.all_templates, ['reload_server']);
});

gulp.task('default', ['stylus_blocks','stylus','watch','connect']);
gulp.task('server', ['stylus_blocks','stylus','watch','run']);
