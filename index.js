var parser = require('./parsers/selector');

module.exports = function (selector) {
  return parser.parse(selector);
};