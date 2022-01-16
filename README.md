# Czech Republic COVID-19 data 
This project downloads the complete COVID-19 tracking data from the [Czech Ministry of Health site](https://onemocneni-aktualne.mzcr.cz/api/v2/covid-19) and transform it to a simple analytical data model.  

![COVID CZ data model](https://raw.githubusercontent.com/zsvoboda/dbd/master/img/covid.cz.datamodel.png)

The data are loaded to Postgres database that is part of GoodData.CN Docker image. This project contains declarative definitions of GoodData metrics, insights, and dashboards that you can import to your local GoodData.CN Docker container. 

You'll get this initial COVID-19 dasboard out of the box. 

![COVID CZ Dashboard](https://raw.githubusercontent.com/zsvoboda/covid_cz/main/img/covid.cz.dashboard.png)

Then you can visually create your own data visualizations and interactive dasboards. You should be able to complete this in less than 15 minutes. 

# Steps

1. Install GoodData.CN Community Edition to your computer:

`docker pull gooddata/gooddata-cn-ce`

2. Install [dbd](https://github.com/zsvoboda/dbd) to your computer (make sure that you have Python 3.8+ installed)

`pip3 install dbd`

3. Install [Visual Studio Code](https://code.visualstudio.com) on your computer

Install [REsr Client extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client). You'll use it for convenient GoodData.CM API invocation. 

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

Find the `# @name storePhysicalModel` on line 45 and click on the small link `Send Request` between line 45 and 46

Again, you may need to `Send Request` link twice.

11. Create workspace

Find the `# @name createWorkspace` on line 25 and click on the small link `Send Request` between line 25 and 26

12. Publish semantic (logical) model 

Find the `@name publishSemanticModel` on line 59 and click on the small link `Send Request` between line 59 and 60

13. Create analytics model (metrics, insights, dashboards) 

Find the `# @name createAnalyticsModelObjects` on line 73 and click on the small link `Send Request` between line 73 and 74

14. ENJOY it at [localhost:3000](http://localhost:3000/)

Username is `demo@example.com`, password `demo123`.
