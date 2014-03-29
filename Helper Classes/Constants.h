
typedef enum {
    ButtonClickedBack=0,
    ButtonClickedDasbord,
    ButtonClickedMsg,
    ButtonClickedSetting
} ButtonClicked;

//Api Url
#define APIURL      @"http://hometeachingreporter.com/controller/controller.php"//Live
//#define APIURL      @"http://hometeachingreporter.com/test/controller/controller.php"//Test

//AppDelegate
#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])
//UserDefault
#define USERDEFAULT [NSUserDefaults standardUserDefaults]

//Colors
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define COLORBlue(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ColorSliderRow [UIColor colorWithRed:(29.0/255) green:(110.0/255) blue:(185.0/255) alpha:1.0]
#define ColorSliderSection [UIColor colorWithRed:(20.0/255) green:(72.0/255) blue:(124.0/255) alpha:1.0]


#define ColorTaught [UIColor colorWithRed:(0.0/255) green:(255.0/255) blue:(0.0/255) alpha:1.0]
#define ColorNotTaught [UIColor colorWithRed:(255.0/255) green:(0.0/255) blue:(0.0/255) alpha:1.0]
#define ColorUnrepoted [UIColor colorWithRed:(170.0/255) green:(170.0/255) blue:(170.0/255) alpha:1.0]

#define Index @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"

#define HEADERINDEX [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil]

#define CHARTCOLOR [[NSArray alloc] initWithObjects:ColorTaught,ColorNotTaught,ColorUnrepoted, nil]

//iPhone5 helper
#define isiPhone5 ([UIScreen mainScreen].bounds.size.height == 568.0)
#define ASSET_BY_SCREEN_HEIGHT(regular) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : [regular stringByAppendingString:@"-568h"])

//#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

//iPhone Or iPad
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define SET_XIB(regular) (IS_IPHONE ? regular : [regular stringByAppendingString:@"_iPad"])

//iOS7 Or less
#define ISIOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

//Api Methods
#define POST_METHOD             @"POST"
#define GET_METHOD              @"GET"
#define PUT_METHOD              @"PUT"

//DateFormate
#define DateFormat  @"yyyy-mm-dd HH:MM:SS"//"2013-09-13 14:02:49"

#define DATE_MONTH @"y-MM-dd"

//Log helper
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif


//Font Helper
#define FONT_CELL_BOLD [UIFont boldSystemFontOfSize:(IS_IPHONE)?12.0:20.0]
#define FONT_CELL_REGULAR [UIFont systemFontOfSize:(IS_IPHONE)?12.0:20.0]

//User Default Helper
extern NSString *const UD_USERID;
extern NSString *const UD_PASSWORD;
extern NSString *const UD_GROUPID;
extern NSString *const UD_FIRSTNAME;
extern NSString *const UD_LASTNAME;
extern NSString *const UD_OWNER;
extern NSString *const UD_ADMIN;
extern NSString *const UD_REPORTTOOLS;
extern NSString *const UD_EMAIL;
extern NSString *const UD_PHONE;

//Web Service Helper
//params
extern NSString *const PARAM_COMMAND;//command

extern NSString *const PARAM_GNAME;//gname
extern NSString *const PARAM_FNAME;//fname
extern NSString *const PARAM_FAMNAME;//famname
extern NSString *const PARAM_FIRSTNAMES;//firstnames
extern NSString *const PARAM_LNAME;//lname
extern NSString *const PARAM_OWNER;//owner
extern NSString *const PARAM_ADMIN;//admin
extern NSString *const PARAM_PHONE;//phone
extern NSString *const PARAM_EMAIL;//email
extern NSString *const PARAM_GID;//gid
extern NSString *const PARAM_UID;//uid
extern NSString *const PARAM_PASSWORD;//password
extern NSString *const PARAM_REPORTTOOLS;//reportTools
extern NSString *const PARAM_CID;//cid
extern NSString *const PARAM_FID;//fid
extern NSString *const PARAM_DATE;//date
extern NSString *const PARAM_VID;//vid
extern NSString *const PARAM_VISITED;//visited
extern NSString *const PARAM_COMMENTS;//comments
extern NSString *const PARAM_LID;//lid
extern NSString *const PARAM_DNAME;//dname
extern NSString *const PARAM_DID;//did
extern NSString *const PARAM_COMP1;//comp1
extern NSString *const PARAM_COMP2;//comp2
extern NSString *const PARAM_COMP3;//comp3
extern NSString *const PARAM_NOTES;//notes
extern NSString *const PARAM_MONTHS;//months
extern NSString *const PARAM_FAMILYID;//FamilyID

extern NSString *const PARAM_QUARTER;//quarter
extern NSString *const PARAM_YEAR;//year

extern NSString *const PARAM_ATTENDED;//attended


//uid = 1 attended = 0 or 1 date = "2014-03-09"
//attendanceScreen($_POST['gid'], $_POST['quarter'], $_POST['year'])

//param values
extern NSString *const COMMAND_CREATEGROUP;//createGroup
extern NSString *const COMMAND_JOINGROUP;//joinGroup
extern NSString *const COMMAND_CREATEUSER;//createUser
extern NSString *const COMMAND_USERNAME;//username
extern NSString *const COMMAND_USERINFO;//userInfo
extern NSString *const COMMAND_EDITUSER;//editUser
extern NSString *const COMMAND_ASSIGNOWNERID;//assignOwnerID
extern NSString *const COMMAND_ASSIGNEDCOMP;//assignedComp
extern NSString *const COMMAND_ASSIGNEDFAMILIES;//assignedFamilies
extern NSString *const COMMAND_FAMILYVISIT;//familyVisit
extern NSString *const COMMAND_UPDATEREPORTING;//updateReporting
extern NSString *const COMMAND_ADDDISTRICT;//addDistrict
extern NSString *const COMMAND_EDITDISTRICT;//editDistrict
extern NSString *const COMMAND_GETDISTRICT;//getDistricts
extern NSString *const COMMAND_DISTRICTINFO;//districtInfo
extern NSString *const COMMAND_GETTEACHERS;//getTeachers
extern NSString *const COMMAND_ASSIGNEDTEACHERS;//assignedTeachers
extern NSString *const COMMAND_UNASSIGNEDTEACHERS;//unassignedTeachers
extern NSString *const COMMAND_UNASSIGNEDFROMCOMPANIONSHIP;//unassignFromCompanionship
extern NSString *const COMMAND_UNASSIGNEDFAMFROMCOMPANIONSHIP;//unassignFamFromCompanionship
extern NSString *const COMMAND_ADDCOMPANIONSHIP;//addCompanionship
extern NSString *const COMMAND_EDITCOMPANIONSHIP;//editCompanionship
extern NSString *const COMMAND_GETALLCOMPS;//getAllComps
extern NSString *const COMMAND_GETDISTRICTCOMPS;//getDistrictComps
extern NSString *const COMMAND_ADDFAMILY;//addFamily
extern NSString *const COMMAND_FAMILYINFO;//familyInfo
extern NSString *const COMMAND_EDITFAMILY;//editFamily
extern NSString *const COMMAND_ASSIGNFAMILY;//assignFamily
extern NSString *const COMMAND_ALREADYASSIGNEDFAMILIES;//alreadyAssignedFamilies
extern NSString *const COMMAND_UNASSIGNEDFAMILIES;//unassignedFamilies
extern NSString *const COMMAND_TOTALFAMS;//totalFams
extern NSString *const COMMAND_TOTALREPORTED;//totalReported
extern NSString *const COMMAND_TOTALTAUGHT;//totalTaught
extern NSString *const COMMAND_TOTALDISTRICTFAMS;//totalDistrictFams
extern NSString *const COMMAND_TOTALDISTRICTTAUGHT;//totalDistrictTaught
extern NSString *const COMMAND_TOTALUNASSIGNEDFAMS;//totalUnassignedFams
extern NSString *const COMMAND_UNASSIGNEDTAUGHT;//totalUnassignedTaught
extern NSString *const COMMAND_COMPNAMES;

extern NSString *const COMMAND_ASSIGNEDCOMPANDNAMES;//assignedCompAndNames
extern NSString *const COMMAND_ASSIGNEDFAMILIESANDVISIT;//assignedFamiliesAndVisit
extern NSString *const COMMAND_DISTRICTSANDCOMPS;

extern NSString *const COMMAND_ALLFAMILIES;//allFamilies
extern NSString *const COMMAND_ALLTEACHERS;//allTeachers

extern NSString *const COMMAND_DELETECOMPANIONSHIP;//deleteCompanionship

extern NSString *const COMMAND_GROUPREPORTINGSCREEN;//groupReportingScreen

extern NSString *const COMMAND_ISDL;//isDL

extern NSString *const COMMAND_DELETEUSER;//deleteUser
extern NSString *const COMMAND_DELETEFAMILY;//deleteFamily
extern NSString *const COMMAND_DELETEDISTRICT;//deleteDistrict

extern NSString *const COMMAND_COMPINFOANDFAMILIES;//compInfoAndFamilies
extern NSString *const COMMAND_USERPROFILE;//userProfile
extern NSString *const COMMAND_FAMILYPROFILE;

extern NSString *const COMMAND_GETCHANGES;//getChanges
extern NSString *const COMMAND_CLEARCHANGES;//clearChange
extern NSString *const COMMAND_CLEARALLCHANGES;//clearAllChanges

extern NSString *const COMMAND_UNVISITEDPAGE;//unvisitedPage
extern NSString *const COMMAND_ATTENDANCESCREEN;//attendanceScreen
extern NSString *const COMMAND_UPDATEATTENDANCE;//updateAttendance


