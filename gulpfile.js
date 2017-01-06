var gulp       = require('gulp'),
		sass = require('gulp-sass'),
		nodeResolve = require('rollup-plugin-node-resolve'),
		babel = require('rollup-plugin-babel'),
		uglify = require('gulp-uglify'),
    rollup     = require('gulp-rollup');

var ASSETS_PATH = './assets';
var PUBLIC_PATH = './public';

var env = process.env.NODE_ENV || 'development';
console.log(`NODE_ENV=${env}`)

var SASS_SRC = `${ASSETS_PATH}/scss/**/*.scss`;
var JS_SRC = `${ASSETS_PATH}/js/app.js`;
var ROLLUP_OPTS = {
	allowRealFiles: true,
	context: 'window',
	// any option supported by Rollup can be set here.
	entry: './assets/js/app.js',
	plugins: [
		nodeResolve({
			// use "module" field for ES6 module if possible
			module: true, // Default: true

			// use "jsnext:main" if possible
			// – see https://github.com/rollup/rollup/wiki/jsnext:main
			jsnext: true,  // Default: false

			// use "main" field or index.js, even if it's not an ES6 module
			// (needs to be converted from CommonJS to ES6
			// – see https://github.com/rollup/rollup-plugin-commonjs
			main: true,  // Default: true

			// if there's something your bundle requires that you DON'T
			// want to include, add it to 'skip'. Local and relative imports
			// can be skipped by giving the full filepath. E.g.,
			// `path.resolve('src/relative-dependency.js')`
			// skip: [ 'some-big-dependency' ],  // Default: []

			// some package.json files have a `browser` field which
			// specifies alternative files to load for people bundling
			// for the browser. If that's you, use this option, otherwise
			// pkg.browser will be ignored
			browser: true,  // Default: false

			// not all files you want to resolve are .js files
			extensions: [ '.js', '.json' ],  // Default: ['.js']

			// whether to prefer built-in modules (e.g. `fs`, `path`) or
			// local ones with the same names
			preferBuiltins: false  // Default: true

		}),
		babel({
			exclude: 'node_modules/**'
		}),
	]
}
var SASS_OPTS = {}

if (env == 'production'){
	SASS_OPTS['outputStyle'] = 'compressed'
}

gulp.task('sass', function () {
	return gulp.src(SASS_SRC)
		.pipe(sass(SASS_OPTS).on('error', sass.logError))
		.pipe(gulp.dest(`${PUBLIC_PATH}/css`));
});

gulp.task('js', function() {
	if (env=='development'){
		return gulp.src(JS_SRC)
			// transform the files here.
			.pipe(rollup(ROLLUP_OPTS))
			.pipe(gulp.dest('./public/js'))
	}else {
		return gulp.src(JS_SRC)
			// transform the files here.
			.pipe(rollup(ROLLUP_OPTS))
			.pipe(uglify())
			.pipe(gulp.dest('./public/js'))
	}
});


gulp.task('fonts', function(){
	return gulp.src([
		'./node_modules/bootstrap-sass/assets/fonts/**/*',
		'./node_modules/font-awesome/fonts/**/*',
	]).pipe(gulp.dest(`${PUBLIC_PATH}/fonts`))
})


gulp.task('watch', ['js', 'sass', 'fonts'], function(){
	gulp.watch(JS_SRC, ['js']);
	gulp.watch(SASS_SRC, ['sass']);
})


gulp.task('build', ['js', 'sass', 'fonts'])
