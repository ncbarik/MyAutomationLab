Execution Details using RobotFramework

1. Install Python and make sure python is added in path upto \Scripts\ 
e.g C:\Users\ncbar\AppData\Local\Programs\Python\Python38\Scripts\
2. Install PyCharm editor
3. Now Go to command line and execute command -> pip install selenium
3. -> pip install robotframework
4. ->pip install robotframework-seleniumlibrary
5.Open Py Charm create a project
6. Go to Project setting from File->>Setting>>Project>> Project Interpretor click + to add 
now add 
1.  selenium
2. robotframework
3. robotframework-seleniumlibrary

7. now add plug in IntelliBot@SeleniumLibrary Patched from Proect setting. File>> Settings>>Plugins>>  then + to add
8. download chrome driver(or take it from Drivers directory and put it in python's script folder
9. on command line go till Python folder e.g \Python\Python38\ and execute following command
pip install webdrivermanager
webdrivermanager firefox chrome --linkpath \usr\local\bin
make sure \user\local\bin is added to Path
10. Open Pycharm import project to pycharm 
11. Now open terminal to execute test case
 use command 

e.g robot C:\Users\ncbar\PycharmProjects\Automation\TestCases\tc1.robot

12. Following additional Library required for api Testing,
These need to be installed from command line
 as well as need to be configured from PyCharm

1-robot framework 
(already done in previous step else -->> pip install robotframework
2-requests 
	-->> pip install requests
3-robortframework-requests 
 -->> pip install robotframework-requests
4-robotframework-jsonlibrary
 -->> pip install robotframework-jsonlibrary
13. Now on PyCharm 
select Project-->>File-->>Settings-->>Projects-->>Project Interpreter to add these click on '+'
make sure  by adding robotframework-jsonlibrary, below libraries also added.

jasonpath_rw
jsonpath_rw_ext


