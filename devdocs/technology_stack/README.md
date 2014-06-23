# Technology Stack Overview


### Languages Used
* Javascript
* Coffeescript 1.6.3
* Jade 1.0.0 (HTML preprocessor and server-side templating)
* Stylus 0.41.3 (CSS preprocessor)


### Front-end Technologies
* **AngularJS** 1.2.6
* **Refer to bower.json** for Angular plugins used
* **Coffeescript** 1.6.3 (compiled to JS in build process)
* **Stylus** 0.41.3 (compiled to CSS in build process)
* **Jade** 1.3.1 (rendered to HTML by back-end)

### Back-end Technologies
* **NodeJS** 0.10.23
* **Express Framework** 3.4.3
* **Jade** 1.3.1 for Express render engine
* NodeJS modules:
    * **Node-uuid** 1.4.1 for UUID generation
    * **Tedious** 0.2.5 for SQL Server 2012 driver
    * **MSSQL** 0.5.3 for SQL Server 2012 interface

### Build and Workflow Tools
* **Grunt** 0.4.1 for managing and automating build/development processes
* **Refer to Gruntfile.js** for build/dev process details. Briefly:
    * Use "grunt serve" command for development
    * Use "grunt build" command to build for deployment
* **Yeoman** for project scaffolding
    * **angular-fullstack** generator for generating project scaffold and Gruntfile
    * **bower** for managing front-end packages
