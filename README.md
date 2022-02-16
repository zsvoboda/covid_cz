# Czech Republic COVID-19 data 
This project downloads the complete COVID-19 tracking data from the [Czech Ministry of Health site](https://onemocneni-aktualne.mzcr.cz/api/v2/covid-19) and transform it to a [GoodData.CN](https://www.gooddata.com/developers/cloud-native?utm_source=mediumcom&utm_medium=referral&utm_campaign=gdcn&utm_content=zd-dbd) semantic data model.

![COVID CZ data model](https://raw.githubusercontent.com/zsvoboda/covid_cz/main/img/pdm.png)

Data are loaded to Postgres database that is part of the GoodData.CN Docker image. This project contains declarative definitions of GoodData metrics, insights, and dashboards that you can import to your local GoodData.CN instance running in a local Docker container. 

You'll get this initial COVID-19 dashboard out of the box: 

![COVID CZ Dashboard](https://raw.githubusercontent.com/zsvoboda/covid_cz/main/img/covid_cz.dashboard.png)

Then you can create your own data visualizations and interactive dashboards using the visual GoodData.CN analytics tools or APIs. You should be able to have everything up and running in less than 15 minutes. 

# Multitenancy
This project sets up 15 workspaces. One of them named `Česká republika (All data)` contains complete Czech Republic data. There are additional 14 workspaces (e.g. `Praha` or `Jihomoravský kraj`), one per each Czech county, that contain data for the county.  

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

Install [REST Client extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client). You'll use it for the GoodData.CN API invocation.  

4. Start GoodData.CN Community Edition

`docker run -t -i -p 3000:3000 -p 5432:5432 --name gd gooddata/gooddata-cn-ce`

Answer 'yes' when prompted. 

5. Load the COVID data to the Postgres database that runs in the GoodData.CN container

```shell
cd etl 
dbd run .
```

6. Open this project's files in the Visual Studio Code editor. Invoke the `code` command from the project root directory.

`code .`

7. Load `workspace.code-workspace` file in VSCode (press the blue button in the bottom right area of the file editor)

VSCode should reload.

8. Open the `api/rest.http`

Make sure that your environment is set to `GoodData.CN CE` in the bottom right status bar listbox of the VSCode editor. 

9. Create database connection

Find the `# @name createDataSource` on line 11 and click on the small link `Send Request` between line 11 and 12

Sometimes I must click the `Send Request` link twice. A new VSCode editor tab with a good HTTP result code (2xx) should open as result of the invocation.

10. Create physical data model

Find the `# @name storePhysicalModel` on line 31 and click on the small link `Send Request` between line 31 and 32

Again, you may need to `Send Request` link twice.

11. Create workspaces

Find the `# @name storeAllWorkspaces` on line 45 and click on the small link `Send Request` between line 45 and 46

12. ENJOY the COVID analytics at [localhost:3000](http://localhost:3000/)

Username is `demo@example.com`, password `demo123`.

You can reach GoodData support on their [Slack community channel](https://www.gooddata.com/slack/?utm_source=mediumcom&utm_medium=referral&utm_campaign=gdcn&utm_content=zd-dbd) if you have a question or run into issues. 
There are also useful GoodData University courses available on the [GoodData website](https://www.gooddata.com/learn/?utm_source=mediumcom&utm_medium=referral&utm_campaign=gdcn&utm_content=zd-dbd).