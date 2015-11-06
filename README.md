# BattleApp for iOS
BattleApp serves information of Starcraft2 Worldwide Championship Series. See more information and fork at https://github.com/HelloMocca/BattleAppforiOS.git

# Screen Shot

# Version History
__[Latest Version]0.8.4__  
* PlayerInfoViewController refactored.  
* Published 6 November, 2015.

__0.8.3__  
* BARecord struct deprecated(use Record and Score class instead).    
* Record Class and Score Class added. 
* Revise Player class.
  * Player has record object.  
  * getOppositeRaceRecordByRaceName -> oppositeRaceScoreByRaceName.  
* Revise MatchCalculator class.  
  * BARecord competitionRecord -> Score *competitionScore.  
* Published 6 November, 2015.  

__0.8.2__
* BAOperationQueue created.
* Application has one BAOperationQueue (Single instance).  
* BAHttpTask is not manages OperationQueue instance no more.  
* Published 5 November, 2015.

__0.8.1__
* BAGameTableViewController's tableview event added.  
* VOD WebView showup when select sell of BAGameTableViewController's tableview.  
* BAArticleDetailViewController Deprecated.(use BAWebViewController instead.)  
* BAWebViewController created.  
* Published 5 November, 2015.  

__0.7.3__
* BAHttpTask provides Asynchronous request also Synchronous request.  
   * HomeController's news request -> Sync.  
   * PlayerTableController's playerlist request -> Async.  
   * Player's record request -> Sync.  
   * LeagueController's leaguelist request -> Async.
* Published 4 November, 2015.
  
__[Latest Version]0.7.2__
* BAHttpTask added.
  * BAHttpTask provides http request method with url.  
* Published 4 November, 2015.

__0.7.1__
* Game Class Added.  
* Each Game object represents one of the match of leagues.  
* BAGameTableViewController added.
  * BAGameTableViewController shows list of games.  
  * BAGameTableViewController used in Player Information Service and League information Service.  
* Player Object has Game list type of NSArray.(before NSDictionary)  
* Published 3 November, 2015.

__0.6.2__
* Revise Player Information View.  
* Player Object has Game List type of NSDictionary.  
* Published 3 November, 2015.

__0.6.1__
* More Article Button provides more news articles maximun 20.  
* Published 3 November, 2015.

__0.5.2__
* BAColor deprecated.
* UIColorExtension category contains color samples as extension of UIColor.
* Published 2 November, 2015.

__0.5.1__
* Match Predict View applies score data from server.  
* MatchCalculator request score data from server and calculate win rates of match.  
* Player object can use requestRecordData method to request own some detail game records(but Synchronous Task).
* Published 2 November, 2015.

__0.4.1__  
* Player analysis diplay implement.  
* Show graph using Racoon Graph Library.  
* More news button added but not activate yet.  
* Match Predict View shows some graphs to result of predict match of two players.  
* Published 28 October, 2015.  
  
__0.3.1__  
* 2 Player select function implement in Match Simulator Menu.  
* BAPlayerSearchViewController added for reuse player search function.  
* Now PlayerTableViewController just inherits BAPlayerSearchViewController because of BAPlayerSearchViewController provides all function to Search Player.  
* MatchPlayerStandView is subview of MatchViewController.  
* MatchPlayerStandView has two PlayerDescView.  
* PlayerDescView provides interface *requestPlayer* for gesture of tapping thumbnail-view area.  
    *The Controller that supervise MatchPlayerStandView use protocol *PlayerDescViewDelegate* to response PlayerDescView's request.  
* BAColor contains macro of UIColor sets.  
* Published 22 October, 2015.  
  
__0.2.1__  
* HomeViewController provides news contents.  
* MainArticleView contains most recently news.  
* SubArticleView shows other 4 news.  
* View of ArticleDetailViewController shows contents of news when tapped one of article view.  
* PlayerTableView shows player profile thumbnail.  
* News data API URL : http://125.209.198.90/battleapp/wcsnews.php  
* News data API provides 'page' parameter.  
* Published 19 October, 2015.  
   
__0.1.1__  
* SearchViewController deleted and replaced by PlayerTableViewController
* Implement service of player search menu.  
  *API URL: http://125.209.198.90/battleapp/players.php  
  *Parameter :   
    - q : letter of playId  
  *dataType: JSON  
* Implement service of league information menu.  
  *API URL: http://125.209.198.90/battleapp/leagues.php  
  *dataType: JSON  
* SearchBar added using UISearchDisplayController.  
  *UISearchDisplayController will deprecate @ iOS8.  
  *TODO : change to UISearchController.  
  *CAUTION: NavigationBar disapear bug when using UISearchController.  
* Player has thumbnail typeof UIImage.  
  *Player download thumbnail when return thumbnail variable and reuse it.  
* Published 15 October, 2015.

__0.0.1__  
* Initialize the Battle App Project.
* Add BANavigationController Class
  * Common Type NavigationController in BattleApp
* Add BAViewController Class
  * Common Type ViewController in BattleApp
  * -(void)applyTransparentBackgroundToTheNavigationBar:(CGFloat)opacity
* Add SearchViewController
  * root view controller of player search and information service.
* Add HomeViewController  
  * root view controller of home service.  
* Add LeagueViewController  
  * root view controller of league information service.  
* Add MatchViewController  
  * root view controller of match simulation service.  
* Published 12 October, 2015.  
