# sbg-rails

A rails app for managing Standards-Based Grading. For now, it's for developers only. 
Here are screenshots of commit
[1ced62](https://github.com/StevenClontz/sbg-rails/commit/1ced6271008aa5757adbb2420193334f38e189dc).

## Progress reports

![progress][progress-screen]

## Assessments built from progress

![assessment][assessment-screen]

[assessment-screen]: https://raw.githubusercontent.com/StevenClontz/sbg-rails/master/screenshots/assessment.png

[progress-screen]: https://raw.githubusercontent.com/StevenClontz/sbg-rails/master/screenshots/progress.png

# Installation

To use the app on your computer:

1. Clone the repo
2. Check you're running the version of Ruby defined in `.ruby-version`.
3. `bundle install` gems
4. Create a file `local/password.txt` with two lines: 
   the first line is a username and the second line is a password. 
   These are required to access the app. 
5. `bin/rails s` to run the server
6. Go to `http://localhost:3000` in your browser to access the app. 
