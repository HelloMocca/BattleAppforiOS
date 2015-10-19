# BattleApp for iOS
BattleApp serves information of Starcraft2 Worldwide Championship Series. See more information and fork at https://github.com/HelloMocca/BattleAppforiOS.git

# Screen Shot

# Version History 
__[Latest Version]0.2.1__  
* HomeViewController provides news contents.  
* MainArticleView contains most recently news.  
* SubArticleView shows other 4 news.  
* View of ArticleDetailViewController shows contents of news when tapped one of article view.  
* PlayerTableView shows player profile thumbnail.  
* News data API URL : http://125.209.198.90/battleapp.wcsnews.php  
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
