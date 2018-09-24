#!/usr/bin/env node
'use strict';

let path = require('path'),
    child_process = require('child_process'),
    mkdirp = require('mkdirp'),
    cmake = require('cmake-cli');

main();


function main() {
    var os = (process.platform === 'win32') ? 'windows' : 'linux',
        buildType = 'release';

    [32, 64].forEach((bits) => {
        cmakeGenerate(os, bits, buildType);

        [1, 2, 3].forEach((i) => {
            cmakeBuild(`exec${i}`, os, bits, buildType);
        });
    });

}

function cmakeGenerate(os, bits, buildType) {
    let pkg = require(`${__dirname}/package.json`),
        generator = pkg.generators[os] || '',
        options = {
            stdio: 'inherit',
            cwd: path.join(__dirname, 'target', 'build', `${buildType}-${bits}`)
        };

    if (generator.indexOf('Visual Studio') > -1) {
        if (bits === 64)
            generator += ' Win64';
    }

    mkdirp.sync(options.cwd);

    let args = [
        '-G',
        generator,
        '-DCMAKE_BUILD_TYPE:STRING=' + buildType,
        '-DTARGET_ARCH:STRING=' + bits,
        __dirname
    ];

    child_process.spawnSync(cmake.path(), args, options);
}

/*
function mkdirp(target) {
    let dirs = [];

    while (!fs.existsSync(target)) {
        let temp = target.split(path.sep);

        dirs.push(temp.pop());

        target = temp.join(path.sep);
    }

    while (dirs.length > 0) {
        target = path.join(target, dirs.pop());

        fs.mkdirSync(target);
    }
}
*/

function cmakeBuild(project, os, bits, buildType) {
    let identifier = `${buildType}-${bits}`,
        projectDir = path.join(__dirname, 'target', 'build', identifier),
        options = {
            stdio: 'inherit',
            cwd: projectDir
        };

    let args = [
        '--build',
        projectDir,
        '--target',
        project,
        '--config',
        buildType
    ];

    child_process.spawnSync(cmake.path(), args, options);
}
