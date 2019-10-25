This repository represents my submission for the Applicaster assessment. The original assessment requested that the app get the user's location, then reveal 10 images from Instagram that were taken within 500 meters of the user. Instagram recently deprecated the ability to access photo location, so I was told to mock the data.

From Xcode, you can launch the app in the normal fashion (Cmd + R) selecting the simulator of choice. The app will launch and immediately load one of two json files to mock data. The ten photos are accompanied by mocked comments, usernames, user avatars, etc. Both the user avatars and the faked IG media are pulled from royalty-free sources on a background thread, then set in the main thread. These images are cached so that scrolling doesn't cause repeat calls.

The user can tick the compass button in the upper right to see a settings menu that allows them to expand the search radius for the app. Because the data is mocked this does not have an effect.Tapping the compass button again dismisses the modal settings view.

Unit tests for the app can be run by changing the scheme in Xcode to Applicaster_AssessmentTest. Runing the suite will confirm logic expectations. 
