⚠️ DEPRECATED, NO LONGER MAINTAINED

# Unlocator-Updater

<img src= "https://github.com/MDalprato/Unlocator-Updater/blob/master/uu_preview1.png?raw=true">
<img src= "https://github.com/MDalprato/Unlocator-Updater/blob/master/uu_preview2.png?raw=true">

Unlocator updater was my very first super cool application for macOX and Netflix

### Unlocator Updater Manual

```
Revision 1.0, Application Version 8.
```

## Menu

1. Configuration
    1. Login with Unlocator account
    2. Login using the Private Key
    3. Logout
    4. Launch the application on startup
2. Updates
    1. Force and update
    2. Configure a scheduled update
3. International & Languages
    1. Change and set the region for a service
4. Notifications
    1. General information about notifications
5. Updates
    1. Check for new updates
6. Copyright and legal information


# Configuration

## Login with Unlocator account

You can use your Unlocator account to access and configure the application. You don’t need to
write or find any particular code or settings, the application will fetch all the information for you.
To do that, open the “Preferences Panel” by clicking on the icon of the application the you can find
in the top-right bar of you Mac then choose the menu “Application” and the “Preferences...” button.

Now you should see a new window that is the main part of the application. In this window you
should be able to login with your Unlocator account. Just type the username and the password and
click on “Login”

After a few seconds the application will fetch your private key and your are ready to configure the
application for manual or scheduled updates.


# Configuration

## Login using the Private Key

You can also use your private key if you prefer to bypass the login process. In order to do that you
need to get your private key from the Unlocator website (this is the link).

Copy the Private Key that you should find in the “Update your IP Automatically” and open the
Preferences panel of the application. You can find in the top-right bar of you Mac then choose the
menu “Application” and the “Preferences...” button.
Now click on the button called “Use Private Key” and paste the private key that you salved before.

Click on “Save” and you should be able to configure the application without need to login using
your credentials.


# Configuration

## Logout

To Logout and forget your credentials or your private key you can click on the “Logout” button that
you can find into the “Preference” window of the application.
This Logout function is valid also if you logged in using your private key.
**Note that if you logout from the application, scheduled, manual update and international
settings will no longer works.**


# Configuration

## Launch the application on startup

To launch the application on startup you need to follow this steps:

Open the “System Preferences” panel on your Mac and click on “Users and Groups”.
Now


# Updates

## Force an update

There are two different ways to update your IP: manually or automatically.
To manually update your IP you can click on the “Update now !” button that you can find in the
menubar of the application or you can open the Unlocator Updater interface and click on the button
called “Update Now”.

Both way are absolutely identical and they both update your current IP.


# Updates

## Configure a scheduled update

You can configure a scheduled update to keep your Unlocator account always matched
with your IP.
In order to do that you need to check the “Enable scheduled updates” in the Preferences
window of the application.

After that you can also choose a right interval for the update. You can set the interval
directly by changing the value of the “Update Interval” options.
You can also change it by selecting the interval in the menu of the application.


You can also customize the interval list with your personal settings.
In order to do that you need to locate the Unlocator Updater app, right click on it and
choose “Show Package contents”.
A new finder window will show up and you should be select a “Contents” folder, then
locate the “Resources” and open (with “Textedit” or an external editor”) the “settings.plist”
file.
Locate the part of the text where there is a “key” called “timer_interval_list”. After that key
you’ll se a list of Key/string. Here you can add, delete or edit your custom interval made
by a user friendly name (string) and the interval time in seconds (key).
For example, if you want to create an interval that update the IP every 2 hours, you’ll need
to add a combination of key-string this one.

<string>3600</string>
<key>2 hours</key>

Note that string and be different but values must me unique.If you’ll add two string with
the same name but different value, the application will get the latest one in order or
reading.
**You cannot add an interval that is minor than 700 seconds.**

_You can also update the IP every time that you (or the computer) will launch the
application by checking the option “Update on load”._

# International & Languages

## Change and set the region for a service

Unlocator offers the possibility to set a particular region for a service.
For example, if you are in Italy but you want to access to the Netflix US account you need
to set “Netflix” as a service and “US” as region.
In order to do that you have to possibilities: use the menu of the application or open the
Preferences panel.
If you want to change the region settings from the menu of the application, just select the
“International” option and choose the right service. Then click on your region settings.
If you want to do it from the Preferences panel, just choose your service and your region
in the “International & Languages” box.

If the update went well, a response should appear in the “International & Languages”
box.


# Notifications

## General information about notifications

Unlocator updater can show up a notification if:

- a new update is completed
- there was an internet connection during the latest update
- there was an issue during the latest update^

You can activate three different notifications:

- To be notified on every update: If you want to receive a notification message every time
    that the update concludes an IP update


- To be notified if something goes wrong: If you want to receive a notification message if
    the application cannot update your IP.
- To be notified on connections problems: If you want to receive a notification message if
    your mac cannot reach to the web due to a connection issue.

In order to receive notification is mandatory to enable it in the Preference panel of your
“System Preferences” menu of your Mac (check the image below for more information).

# Updates

## Check for new updates

Unlocator Updater can also check for new updates that could includes new features and
bug fixes.
In order to check updates, you can click on the “Check for updates” button in the menu
bar of the application.

You can check automatically for new updates by enabling the “Automatically check for
new updates” options that you can find in the Preferences window.


# Copyright and Legal Information

**Unlocator Updater is a software that need a valid Unlocator.com account to work.
Unlocator Updater is not affiliated in any way with Unlocator.com and with its services.
When you purchase the application, you'll receive a link with the download of the respective
application (OSX or Windows).**

The information specified on this manual is only intended for general information purposes.
Due to the changing nature of laws and regulations and the intrinsic risks of electronic
communication, there may be delays, defects or other inconsistencies in the information provided
on this manual.
Although Marco Dalprato aspires to the greatest precision possible in the compilation and
maintenance of the information provided on this manual, Marco Dalprato cannot guarantee that
this information is exact, complete and correct.
Marco Dalprato further assumes no liability or responsibility for any errors or omissions in the
content of the manual.
The use of the manual is at your own risk. Neither Marco Dalprato nor any other party involved in
creating, producing or delivering the manual is liable for any direct, incidental, consequential,


indirect or punitive damages arising out of your access to, or use of, or reading this manual. This
includes damages to, or arising out of viruses that may infect, your computer equipment or other
property.
Marco Dalprato makes no representations or warranties regarding the condition or functionality of
this manual, its suitability for use, or that this manual will be uninterrupted or error-free.
Without limiting the foregoing, everything on the manual is provided to you "AS IS" without
warranty of any kind, either expressed or implied.
Unlocator Updater Logo, Marco Dalprato Logo and all associated logos and designs are property
of Marco Dalprato.
All product and company names are trademarks™ or registered® trademarks of their respective
holders. Use of them does not imply any affiliation with or endorsement by them.

marcodalprato.com
unlocatorupdater.com


