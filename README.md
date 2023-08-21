# GitHubRxApp
GitHub app for portfolio (practice) purpose used MVVM + Coordinator architectural pattern with Cocoa-Pods (RxSwift, RxCocoa, RxDataSources, SnapKit and Kingfisher). Unit tests are also implemented.

**Intro**

The goal of this assignment is to develop a simple app that allows you to s​earch the repositories and view the users that created them 
on the GitHub service. The assignment should be solved in Swift and it should have a decent UI, although the focus should be on code 
quality and reusability, which can be achieved by using one of the popular iOS architectures. Using third-party libraries and frameworks 
is allowed (and recommended). Basically the idea of this assignment is to show us all your skills as an iOS developer in a real-world app. 
It can be delivered as a zip of the project folder or on Google Drive but it is recommended to deliver it as a git repository.

**Resources**

The data to show in the app should be fetched from GitHub public APIs. More info can be found on these links:

    ● https://developer.github.com/v3/
    ● https://api.github.com/
    ● https://developer.github.com/v3/search/#search-repositories

**Requirements**

**Main screen (search)**

The main screen should contain:

    ● Search field
    ● Possibility to enter a search query
    ● List of repositories
    ● Possibility to sort the search results by:
          ○ Stars
          ○ Forks
          ○ Updated
          ○ Number of issues
          
Optionally you can add any other data you want from the GitHub API.

From this screen navigation should be made possible to:

    ● Repository detail screen (e.g. by clicking on the list item)
    ● User detail screen (e.g. by clicking the thumbnail avatar of the user)


**Repository detail screen**

The repository detail screen should contain:

    ● An extended set of information about the repository. This can be anything else you want from the Github API like:
        ○ Programming language
        ○ Date of creation
        ○ Date of last modification
    ● The ability to open (navigate) the repository details in an external browser (e.g. Chrome, Firefox, Safari)
    ● Information about the owner of the repository

**User detail screen**

The user detail screen should contain:

    ● User’s thumbnail picture (bigger than in the repository list screen)
    ● Any other user information you want
    ● Ability to open the user details in an external browser

**Navigation overview**

![Screenshot 2023-08-09 at 12 34 10](https://github.com/gabbartose/GitHubRxApp/assets/57413150/5a911c2e-b908-4a16-abdb-cd308e7f49f1)


**Bonus**

If you have some extra time and go above and beyond, try solving these tasks too:

    ● Implement user authorization and show information about the currently logged in user. You can add additional functionality that
      requires authorization if needed. Documentation for OAuth is available at the following link: ​https://developer.github.com/v3/oauth/
    ● Implement some unit tests.
    ● Configure different environments for the app (test, staging, production) and make it
      possible to have 3 different apps on a device for each environment. To distinguish them, configure it in such a way that the test 
      environment only shows the repository list and cannot do anything else, make staging able to show only the repository list and details, 
      and finally production should be able to show everything.
    ● Implement a nice transition animation for the user avatar when going from list to details.

