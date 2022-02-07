# Czech Republic COVID-19 data 
This project downloads the complete COVID-19 tracking data from the [Czech Ministry of Health site](https://onemocneni-aktualne.mzcr.cz/api/v2/covid-19) and transform it to a simple analytical data model.  

![COVID CZ data model](https://raw.githubusercontent.com/zsvoboda/covid_cz/main/img/pdm.png)

Data are loaded to Postgres database that is part of GoodData.CN Docker image. This project contains declarative definitions of GoodData metrics, insights, and dashboards that you can import to your local GoodData.CN Docker container. 

You'll get this initial COVID-19 dashboard out of the box. 

![COVID CZ Dashboard](https://raw.githubusercontent.com/zsvoboda/covid_cz/main/img/covid_cz.dashboard.png)

Then you can visually create your own data visualizations and interactive dasboards. You should be able to complete this in less than 15 minutes. 

# Multitenancy
This project sets up 15 workspaces. One of them named `Česká republika (All data)` contains complete Czech Republic data. There are additional 14 workspaces (e.g. `Praha` or `Jihomoravský kraj`), one per each Czech county, that contain data for a specific county.  

![Workspaces per CZ county](https://raw.githubusercontent.com/zsvoboda/covid_cz/main/img/covid_cz.lcm.png)

# Installation steps

1. Install GoodData.CN Community Edition to your computer:

`docker pull gooddata/gooddata-cn-ce`

2. Install [dbd](https://github.com/zsvoboda/dbd) to your computer (make sure that you have Python 3.8+ installed)

```shell
python3 -m venv dbd-env
source dbd-env/bin/activate
pip3 install dbd
```

3. Install [Visual Studio Code](https://code.visualstudio.com) on your computer

Install [REST Client extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client). You'll use it for convenient GoodData.CM API invocation. 

4. Start GoodData.CN Community Edition

`docker run -t -i -p 3000:3000 -p 5432:5432 --name gd gooddata/gooddata-cn-ce`

Answer 'yes' when prompted. 

5. Download the COVID data to Postgres that runs in the GoodData.CM container

```shell
cd etl 
dbd run .
```

6. Open the project in the Visual Studio Code editor

`code .`

7. Load `workspace.code-workspace` file in VSCode (press blue botton in the bottom right area of the file editor)

VSCode shouls reload.

8. Open the `api/rest.http`

Make sure that your environment is set to `GoodData.CN CE` in the bottom right status bar listbox of the VSCode editor. 

9. Create database connection

Find the `# @name createDataSource` on line 11 and click on the small link `Send Request` between line 11 and 12

Sometimes I must click the `Send Request` link twice. Not sure why. I hope that you don't have the same issue. 

10. Create physical data model

Find the `# @name storePhysicalModel` on line 31 and click on the small link `Send Request` between line 31 and 32

Again, you may need to `Send Request` link twice.

11. Create workspaces

Find the `# @name storeAllWorkspaces` on line 45 and click on the small link `Send Request` between line 45 and 46

12. ENJOY the COVID analytics at [localhost:3000](http://localhost:3000/)

Username is `demo@example.com`, password `demo123`.

There are quite a few courses on GoodData University. You can talk to us on our Slack community if you have a question or run into issues. Visit University and community on [GoodData website](https://www.gooddata.com/learn/) if you need a jumpstart. 
