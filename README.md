
# Note Maker
This is a Simple Notes app with plenty of unwanted colors.
This Application Can be used to store, view, add and update
 short notes, like to-do's or a your next plan. 
This App store all data in firebase('not authenticated, i.e., anyone can view and edit data with the app,because test mode of firebase is used in this project').

 ## Installation Guidelines
 
Use the flutter run command to run your Flutter app on a connected device or simulator.

To run your app from the command-line:

Open a terminal and change directories to the root of your app (the same directory that contains the pubspec.yaml file for your project).

Run the following command. Once the flutter tool is running, if you change the app’s source code, you can hit r to hot-reload your application (updating the source on the fly without actually restarting the entire app).

`$ cd notes_maker`  `$ flutter run`

## How to use
 
 ### Home Screen
 - Home Screen shows the list of activities you have added.
 - On Clicking any activity(on the text) you can open detailed view of that activity.
  
  **_Note_**: Detailed view is non-editable(for editing you can use Edit option).

 - By Clicking on add button('+') you will redirected to another page where you can add new activities to the list.
 - By sliding any tile to the left you will get two options--
    * Edit: By clicking on Edit, you can Edit the current activites' title or its details.
    * Delete: By clicking on Delete, you can delete the current activity.
    
### Adding New Note Page
- Here you can add new activity in the list. 
**_Note_**: both title and details field is compulsory.


### Edit Notes Page
- Here you will initially provided with current activity's title and details to which you can edit
  

## ScreenShots

<p float="left">
  <img src="https://github.com/abhay1704/notes_keeper/blob/master/android/app/src/main/res/drawable/Screenshot_20220331-023528.png" width="100" />
  <img src="https://github.com/abhay1704/notes_keeper/blob/master/android/app/src/main/res/drawable/Screenshot_20220331-024409.png" width="100" /> 
</p
<p float="left"> 
 <img src="https://github.com/abhay1704/notes_keeper/blob/master/android/app/src/main/res/drawable/Screenshot_20220331-023628.png" width="100" />
 <img src="https://github.com/abhay1704/notes_keeper/blob/master/android/app/src/main/res/drawable/Screenshot_20220331-023628.png" width="100" />
</p

 
## Warning
 There is no authentication or seprate database access for different users so, all the users will provided same database, hence anyone can read and write anone's other activity. "# notes_app" 
