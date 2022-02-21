#! /usr/bin/env node

import { execSync } from 'child_process';
import { program } from 'commander';
import { readFile } from 'fs';
import { resolve } from 'path';
import chalkTemplate from 'chalk-template';

program
    .command('deps <program>')
    .description('Install Dependencies for a Given Program')
    .action(deps);

program
    .command('install <program>')
    .description('Install Configuration + Dependencies for a Given Program')
    .action(install);

function install(program) {
    const configPath = resolve('.', program, 'cfg.json');
    readFile(configPath, 'utf8', (err, data) => {
        
        if(err) {
            console.log(`Error reading config file for ${program} config: ${configPath}`);
            return 1;
        }

        const config = JSON.parse(data);

        console.log(chalkTemplate`{green Installing {white ${program}} config...}`)
        execSync(config.install);
        console.log('done.');
        return 0;
    });
} 

function deps(program) {
    const configPath = resolve('.', program, 'cfg.json');
    readFile(configPath, 'utf8', (err, data) => {
        
        if(err) {
            console.log(`Error reading config file for ${program} config: ${configPath}`);
            return 1;
        }

        const config = JSON.parse(data);

        if(config.dependencies.yay) {
            console.log(chalkTemplate`{green Installing {blue yay} deps... }`)
            execSync(`yay -S --needed --noconfirm ${config.dependencies.yay}`);
            console.log('done.');
        }

        if(config.dependencies.npm) {
            console.log(chalkTemplate`{green Installing {white npm} deps... }`);
            execSync(`npm i -g ${config.dependencies.npm}`);
            console.log('done.');
        }

        if(config.dependencies.pip) {
            console.log(chalkTemplate`{green Installing {yellow pip} deps... }`);
            execSync(`pip install ${config.dependencies.pip}`);
            console.log('done.');
        }

        if(config.dependencies.other) {
            console.log(chalkTemplate`{green Installing {magenta other} deps... }`);
            config.dependencies.other.forEach((dep) => {
                execSync(dep);
            });
            console.log('done.');
        }

        return 0;
    });
}

program.parse();
