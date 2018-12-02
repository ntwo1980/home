var exec = require("child_process").exec,
    path = require('path'),
    fs = require('fs'),
    Q = require("q"),
    qlimit = require("qlimit"),
    limit = qlimit(5),
    _ = require("underscore"),
    _s = require("underscore.string"),
    nconf = require('nconf'),
    moment = require('moment'),
    now = moment(),
    home = process.env.HOME || process.env.USERPROFILE,
    bundlePath = home.replace(/\\/g, "/") + "/" + ".vim/bundle/",
    isWindows = /^win/.test(process.platform),
    configPath = path.resolve(__dirname, 'vim.js.json');

nconf.file({file: configPath});

var updateData = nconf.get('update'),
    repositories = [
    {
        name: "airline",
        url: "git@github.com:bling/vim-airline.git"
    },
    {
        name: "ale",
        url: "git@github.com:w0rp/ale.git"
    },
    {
        name: "asyncrun",
        url: "git@github.com:skywind3000/asyncrun.vim.git"
    },
    {
        name: "autoclose",
        url: "git@github.com:townk/vim-autoclose.git",
        updateInterval: 30
    },
    {
        name: "betterwhitespace",
        url: "git@github.com:ntpeters/vim-better-whitespace.git",
        updateInterval: 123
    },
    {
        name: "commenter",
        url: "git@github.com:scrooloose/nerdcommenter.git",
        updateInterval: 35
    },
    {
        name: "cheat40",
        url: "git@github.com:lifepillar/vim-cheat40.git",
        updateInterval: 30
    },
    {
        name: "csharp",
        url: "git@github.com:OrangeT/vim-csharp.git",
        updateInterval: 37
    },
    {
        name: "easymotion",
        url: "git@github.com:lokaltog/vim-easymotion.git"
    },
    {
        name: "filer",
        url: "git@github.com:Shougo/vimfiler.vim.git"
    },
    {
        name: "filetype",
        url: "git@github.com:Shougo/context_filetype.vim.git",
        updateInterval: 60
    },
    {
        name: "flake8",
        url: "git@github.com:nvie/vim-flake8.git",
        updateInterval: 100
    },
    {
        name: "gas",
        url: "git@github.com:Shirk/vim-gas.git",
        updateInterval: 100
    },
    {
        name: "visual-increment",
        url: "git@github.com:triglav/vim-visual-increment.git",
        updateInterval: 107
    },
    {
        name: "indentpython",
        url: "git@github.com:vim-scripts/indentpython.vim.git",
        updateInterval: 100
    },
    {
        name: "javascript-syntax",
        url: "git@github.com:jelera/vim-javascript-syntax.git",
        updateInterval: 40
    },
    {
        name: "jedi-vim",
        url: "git@github.com:davidhalter/jedi-vim.git",
        updateInterval: 20
    },
    {
        name: "listmaps",
        url: "git@github.com:vim-scripts/listmaps.vim.git",
        updateInterval: 100
    },
    {
        name: "markdown",
        url: "git@github.com:plasticboy/vim-markdown.git"
    },
    {
        name: "matchit",
        url: "git@github.com:vim-scripts/matchit.zip.git",
        updateInterval: 100
    },
    {
        name: "misc",
        url: "git@github.com:xolox/vim-misc.git"
    },
    {
        name: "mru",
        url: "git@github.com:Shougo/neomru.vim.git",
        updateInterval: 70
    },
    {
        name: "neocomplete",
        url: "git@github.com:Shougo/neocomplete.vim.git"
    },
    {
        name: "indentpython",
        url: "git@github.com:vim-scripts/indentpython.vim.git",
        updateInterval: 100
    },
    //{
        //name: "yarp",
        //url: "git@github.com:roxma/nvim-yarp.git"
    //},
    //{
        //name: "rpc",
        //url: "git@github.com:roxma/vim-hug-neovim-rpc.git"
    //},
    //{
        //name: "deoplete",
        //url: "git@github.com:Shougo/deoplete.nvim.git"
    //},
    {
        name: "neosnippet",
        url: "git@github.com:shougo/neosnippet.vim.git"
    },
    {
        name: "neosnippet-snippets",
        url: "git@github.com:Shougo/neosnippet-snippets.git"
    },
    {
        name: "powershell",
        url: "git@github.com:PProvost/vim-ps1.git"
    },
    {
        name: "renumber",
        url: "git@github.com:vim-scripts/renumber.vim.git",
        updateInterval: 365
    },
    {
        name: "repeat",
        url: "git@github.com:tpope/vim-repeat.git"
    },
    {
        name: "signature",
        url: "git@github.com:kshenoy/vim-signature.git"
    },
    {
        name: "smartpairs",
        url: "git@github.com:gorkunov/smartpairs.vim.git",
        updateInterval: 108
    },
    {
        name: "solarized",
        url: "git@github.com:altercation/vim-colors-solarized.git",
        updateInterval: 102
    },
    {
        name: "startify",
        url: "git@github.com:mhinz/vim-startify.git"
    },
    {
        name: "surround",
        url: "git@github.com:tpope/vim-surround.git"
    },
    {
        name: "tabular",
        url: "git@github.com:godlygeek/tabular.git",
        updateInterval: 33
    },
    {
        name: "targets",
        url: "git@github.com:wellle/targets.vim.git"
    },
    {
        name: "unimpaired",
        url: "git@github.com:tpope/vim-unimpaired.git",
        updateInterval: 35
    },
    {
        name: "unite",
        url: "git@github.com:Shougo/unite.vim.git"
    },
    {
        name: "unitecolorschema",
        url: "git@github.com:ujihisa/unite-colorscheme.git",
        updateInterval: 107
    },
    {
        name: "unitehelp",
        url: "git@github.com:Shougo/unite-help.git",
        updateInterval: 108
    },
    {
        name: "unitemark",
        url: "git@github.com:tacroe/unite-mark.git",
        updateInterval: 45
    },
    {
        name: "uniteoutline",
        url: "git@github.com:Shougo/unite-outline.git",
        updateInterval: 20
    },
    {
        name: "unitesession",
        url: "git@github.com:Shougo/unite-session.git",
        updateInterval: 108
    },
    {
        name: "unitespell",
        url: "git@github.com:kopischke/unite-spell-suggest.git",
        updateInterval: 109
    },
    {
        name: "vimproc",
        url: "git@github.com:shougo/vimproc.vim.git",
        updateInterval: 28,
        success: function (){
            if(!isWindows)
            {
                var makefile = bundlePath + this.name + "/Makefile";
                exec("make " + makefile , reportError);
            }
        }
    },
    {
        name: "snippets",
        url: "git@github.com:honza/vim-snippets.git"
    }
];

repositories = _.reject(repositories, function(repository){
    return repository.disabled;
});

var commands = _.map(repositories, limit(function(repository){
    return getRepository(repository);
}));

Q.all(commands).done(function(results){
    _.each(results, function(result){
        if(result){
            if(result.message
                    && result.message.indexOf("up-to-date") == -1
                    && result.message.indexOf("up to date") == -1){
                console.log(result.message);

                nconf.set('update:' + result.name, moment().add(1, 'days').format('YYYY-MM-DD'));
            }
            else
            {
                var updateInterval = result.updateInterval,
                    lastUpdate = result.lastUpdate ? result.lastUpdate : 1,
                    nextUpdate = 1;

                if(updateInterval == 1) {
                    if(lastUpdate < 7) {
                        nextUpdate = lastUpdate + 1;
                    }
                    else
                    {
                        nextUpdate = 7;
                    }
                }
                else
                {
                    nextUpdate = updateInterval;
                }

                nconf.set('update:' + result.name, moment().add(nextUpdate, 'days').format('YYYY-MM-DD'));
            }
        }
    });

    nconf.save();
    console.log('All done');
});

function getRepository(repository)
{
    var mkdir = Q.nfbind(fs.mkdir),
        name = repository.name,
        updateInterval = repository.updateInterval ? repository.updateInterval : 1,
        updateDateStr = updateData && updateData[name];

    if(updateDateStr)
    {
        var updateDate = new moment(updateDateStr),
            dateDiff = now.diff(updateDate, 'days');

        if(dateDiff <= 0)
            return;
    }

    var path = bundlePath + name,
        deferred = Q.defer(),
        isRepositoryCloned = fs.existsSync(path);

        console.log("Getting " + name + "...");
        var url = repository.url;
        if(isWindows)
        {
            url = convertGitUrlFromSshToHttps(url);
        }

        var gitCommand;
        if(!isRepositoryCloned)
        {
            gitCommand = "cd " + bundlePath + " & git clone " + url + " " +  name;
        }
        else
        {
            gitCommand = "cd " + path + " & git reset --hard HEAD & git pull"
        }

        exec(gitCommand, function(error, stdout, stderr){
            var message = name + ": ";

            if(error)
            {
                message += error;
            }
            else if(stdout)
            {
                message += stdout;

                var success = repository.success;

                if(success)
                {
                    success.apply(repository);
                }
            }
            else if(stderr)
            {
                message += stderr;
            }

            deferred.resolve({
                name: name,
                updateInterval: updateInterval,
                lastUpdate: dateDiff,
                message: _s(message).trim().value()
            });
        });

    return deferred.promise;
}

function reportError(error, stdout, stderr)
{
    if(error)
    {
        console.log(error);
    }
    else if(stderr)
    {
        console.log(stderr);
    }
}

function convertGitUrlFromSshToHttps(sshUrl)
{
    var sshRegExp = /^git@(.+)?:(.+)?\/(.+$)?/,
    match = sshUrl.match(sshRegExp),
    hostname = match[1],
        author = match[2],
        project = match[3];

    return "https://" + hostname + "/" + author + "/" + project;
}

