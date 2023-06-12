const semver = require('semver');

exports.ltr = function(args, cb) {
  const version = args[0];
  const range = args[1];
  const result = semver.ltr(version, range);
  cb(null, result);
};

exports.diff = function(args, cb) {
  const version = args[0];
  const range = args[1];
  const result = semver.diff(version, range);
  cb(null, result);
};

exports.gte = function(args, cb) {
  const version = args[0];
  const range = args[1];
  const result = semver.gte(version, range);
  cb(null, result);
};

exports.valid = function(args, cb) {
  const version = args[0];
  const result = semver.valid(version);
  cb(null, result);
};

exports.clean = function(args, cb) {
  const version = args[0];
  const result = semver.clean(version);
  cb(null, result);
};

exports.satisfies = function(args, cb) {
  const version = args[0];
  const rule = args[1];
  const result = semver.satisfies(version,rule);
  cb(null, result);
};