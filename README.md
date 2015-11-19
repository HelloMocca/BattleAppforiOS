# BattleApp for iOS
BattleApp serves information of Starcraft2 Worldwide Championship Series. See more information and fork at https://github.com/HelloMocca/BattleAppforiOS.git
  Wiki: https://github.com/HelloMocca/BattleAppforiOS/wiki/
  
# Screen Shot

# Version History
__[Latest Version]0.11.3__
* Player search result interval change to 20.
* Set Tab Bar Style -> UIBarStyleBlack.  
* Revise player profile view layout.  
* Published 19 November, 2015.

__0.11.2__
* Skip notification when LiveViewController loaded already.  
* Publishde 18 November, 2015.  

__0.11.1__
* Show alert message when notification has arrived.
* LiveViewController which subclass of BAWebViewController is added.
* App block the landscape mode.
* BATabViewController added to prevent rotate function.  
* Published 18 November, 2015.  

__0.10.3__
* Match Simulator menu redesign.
* Check duplicate player before simulating.  
* View Report Button invalid when selected players are not acceptable.
* Player list order by player's play ID.
* Published 17 November, 2015.  
 
__0.10.2__
* BADoubleLabelView class added.
* LeagueInfomationView redesign.
* Game class has 'provider' property.
* Game class has 'date' property.
* Published 16 November, 2015.

__0.10.1__
* 20news shows when each request in HomeViewController.
* more article button shows spinner when request is working.  
* more article button is inactivated when there is no more articles data.  
* Published 16 November, 2015.  

__0.9.6__
* Player Profile View redesign.  
* PlayerInfoViewController separated class of view works to PlayerTotalRecordView and RaceRecordView.
* PlayerTotalRecordView creates subviews of player's total records.  
* RaceRecordView creates subviews of player's opposite race record views.
* setupDoughnutChartsWithFrame:donutRatio:title method change to setupDoughnutChartWithFrame:score:title method.  
* navigation bar back button tint color changed.
* Published 16 November, 2015.

__0.9.5__
* GameTableView Height revised.  
* Player Profile View redesigned.
* Published 13 November, 2015.

__0.9.4__  
* Player Information -> Player Profile.
* PlayerTableViewController -> PlayerViewController.  
* Cell color define move to UIColorExtension class.  
* Player Not Found View Shows when player search result is emtpy.  
* Published 13 November, 2015.   


__0.9.3__
* Player class requestRecordData deprecated.  
* GameTableViewCell -> GameCell.  
* PlayerTableViewCell -> PlayerCell. 
* PlayerSearchDisplayController deleted.   
* Published 12 November, 2015.  
 
__0.9.2__
* HomeViewController and BAArticleView and BAArticleView's Subclass refactored.  
* Create [BattleApp Wiki](https://github.com/HelloMocca/BattleAppforiOS/wiki/)
* Published 12 November, 2015.  

__0.9.1__
* BattleApp provides league schedule and alram function.  
* ScheduleTableViewContainer and SceduleCell View added.  
* NotificationManager Class for managing notifications added.  
* Schedule Class added.  
* Published 10 November, 2015.  

__0.8.7__
* ScrollView insert into PlayerInformationView.  
  * to Supports iPhone4 and iPhone5.  
* Published 9 November, 2015.

__0.8.6__
* Custom Cell GameTableViewCell for GameTableView added.
* Published 9 November, 2015.

__0.8.5__
* BAArticle, MainArticle and SubArticle refactored.  
  * Move alloc and Init subviews task into BAArticle Class.  
* Published 9 November, 2015.  

__0.8.4__  
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
  
__0.7.2__
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
