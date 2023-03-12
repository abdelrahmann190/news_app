const List<String> firstPageBoldText = [
  'Customize your news',
  'Pick your location',
  'Get started',
];

const List<String> firstPageSecondText = [
  'This is the news app you always looked for, you could pick and customize the news you are interested in.',
  'Where ever you are you will get news that are happening around you, or where ever you pick.',
  'Go ahead and sign up to start recieveing your news.',
];

const String splashPageRoute = '/';
const String mainEntryPage = '/main-entry-page';
const String signUpPage = '/sign-up-page';
const String loginPage = '/log-in-page';
const String userDataEntryPage = '/user-data-entry-page';

const String newsAPIBaseUrl = 'https://newsdata.io/api/1/news?';
const String apiKey = 'apikey=pub_18520412f6670f87c235d36d802db961ce765';
String countryCode = 'us';
String topHeadLines = '$apiKey&category=top&country=';

const List<String> newsCatogeries = [
  'Business',
  'Entertainment',
  'environment',
  'food',
  'health',
  'politics',
  'science',
  'sports',
  'technology',
  'top',
  'world',
];

Map countryCodesAndNames = {
  'US': 'United States of Amertica',
  'GB': 'Great Britan',
};
