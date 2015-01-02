css-selector-parser
===================

This is the CSS selector parser that [CSS Selector Level 4](http://dev.w3.org/csswg/selectors-4/) compliant (WIP!).
It is created by [PEG.js](http://pegjs.org/).

Install
-------

```
$ npm install
```

Usage
-----

```js
var parse = require('css-selector-parser');
var ast = parse('a.btn.btn-primary#js-popup');
```

### output

See [parser.test.coffee](test/parser.test.coffee).

Development
-----------

### PEG.js (*.pegjs) compile & Test

```
$ npm install # (compile)
$ npm test
```
