{ lib, config, ... }:
{

  xdg.configFile."pcmanfm-qt/default/settings.conf".text = lib.generators.toINI { } {
    Behavior = {
      AutoSelectionDelay = 600;
      BookmarkOpenMethod = "current_tab";
      ConfirmDelete = true;
      ConfirmTrash = false;
      CtrlRightClick = false;
      NoUsbTrash = false;
      QuickExec = false;
      RecentFilesNumber = 0;
      SelectNewFiles = false;
      SingleClick = false;
      SingleWindowMode = false;
      UseTrash = true;
    };

    Desktop = {
      AllSticky = false;
      BgColor = "#000000";
      DesktopCellMargins = "@Size(3 1)";
      DesktopIconSize = 48;
      DesktopShortcuts = "@Invalid()";
      FgColor = "#ffffff";
      Font =
        with config.gtk;
        "${font.name},${builtins.toString font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular";
      HideItems = false;
      LastSlide = "";
      OpenWithDefaultFileManager = false;
      PerScreenWallpaper = false;
      ShadowColor = "#000000";
      ShowHidden = false;
      SlideShowInterval = 0;
      SortColumn = "name";
      SortFolderFirst = true;
      SortHiddenLast = false;
      SortOrder = "ascending";
      TransformWallpaper = false;
      Wallpaper = "";
      WallpaperDialogSize = "@Size(700 500)";
      WallpaperDialogSplitterPos = 200;
      WallpaperDirectory = "";
      WallpaperMode = "none";
      WallpaperRandomize = false;
      WorkAreaMargins = "12, 12, 12, 12";
    };

    FolderView = {
      BackupAsHidden = false;
      BigIconSize = 48;
      CustomColumnWidths = "@Invalid()";
      FolderViewCellMargins = "@Size(3 3)";
      HiddenColumns = "@Invalid()";
      Mode = "icon";
      NoItemTooltip = false;
      ScrollPerPixel = true;
      ShadowHidden = true;
      ShowFilter = false;
      ShowFullNames = true;
      ShowHidden = false;
      SidePaneIconSize = 24;
      SmallIconSize = 24;
      SortCaseSensitive = false;
      SortColumn = "name";
      SortFolderFirst = true;
      SortHiddenLast = false;
      SortOrder = "ascending";
      ThumbnailIconSize = 128;
    };

    Places = {
      HiddenPlaces = "@Invalid()";
    };

    Search = {
      ContentPatterns = "@Invalid()";
      MaxSearchHistory = 0;
      NamePatterns = "@Invalid()";
      searchContentCaseInsensitive = false;
      searchContentRegexp = true;
      searchNameCaseInsensitive = false;
      searchNameRegexp = true;
      searchRecursive = false;
      searchhHidden = false;
    };

    System = {
      Archiver = "lxqt-archiver";
      FallbackIconThemeName = "oxygen";
      OnlyUserTemplates = false;
      SIUnit = false;
      SuCommand = "lxqt-sudo %s";
      TemplateRunApp = false;
      TemplateTypeOnce = false;
      Terminal = "xfce4-terminal";
    };

    Thumbnail = {
      MaxExternalThumbnailFileSize = -1;
      MaxThumbnailFileSize = 4096;
      ShowThumbnails = true;
      ThumbnailLocalFilesOnly = true;
    };

    Volume = {
      AutoRun = true;
      CloseOnUnmount = true;
      MountOnStartup = true;
      MountRemovable = true;
    };

    Window = {
      AlwaysShowTabs = true;
      FixedHeight = 480;
      FixedWidth = 640;
      LastWindowHeight = 1025;
      LastWindowMaximized = false;
      LastWindowWidth = 617;
      PathBarButtons = true;
      RememberWindowSize = true;
      ReopenLastTabs = false;
      ShowMenuBar = true;
      ShowTabClose = true;
      SidePaneMode = "places";
      SidePaneVisible = true;
      SplitView = false;
      SplitViewTabsNum = 0;
      SplitterPos = 150;
      SwitchToNewTab = false;
      TabPaths = "@Invalid()";
    };
  };
}
