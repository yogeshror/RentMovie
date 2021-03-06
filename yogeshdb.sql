USE [master]
GO
/****** Object:  Database [yogeshdb]    Script Date: 3/08/2021 12:57:47 pm ******/
CREATE DATABASE [yogeshdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'yogeshdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\yogeshdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'yogeshdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\yogeshdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [yogeshdb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [yogeshdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [yogeshdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [yogeshdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [yogeshdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [yogeshdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [yogeshdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [yogeshdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [yogeshdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [yogeshdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [yogeshdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [yogeshdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [yogeshdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [yogeshdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [yogeshdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [yogeshdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [yogeshdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [yogeshdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [yogeshdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [yogeshdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [yogeshdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [yogeshdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [yogeshdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [yogeshdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [yogeshdb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [yogeshdb] SET  MULTI_USER 
GO
ALTER DATABASE [yogeshdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [yogeshdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [yogeshdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [yogeshdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [yogeshdb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [yogeshdb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [yogeshdb] SET QUERY_STORE = OFF
GO
USE [yogeshdb]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[Rating] [nvarchar](50) NULL,
	[Title] [nvarchar](255) NULL,
	[Year] [nvarchar](255) NULL,
	[Rental_Cost] [money] NULL,
	[Copies] [nvarchar](50) NULL,
	[Plot] [ntext] NULL,
	[Genre] [nvarchar](50) NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentedMovies]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentedMovies](
	[RMID] [int] IDENTITY(1,1) NOT NULL,
	[MovieIDFK] [int] NULL,
	[CustIDFK] [int] NULL,
	[DateRented] [datetime] NULL,
	[DateReturned] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MovieConnection]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MovieConnection]
AS
SELECT        dbo.RentedMovies.CustIDFK
FROM            dbo.RentedMovies INNER JOIN
                         dbo.Movies ON dbo.RentedMovies.MovieIDFK = dbo.Movies.MovieID INNER JOIN
                         dbo.Customer ON dbo.RentedMovies.CustIDFK = dbo.Customer.CustID
GO
/****** Object:  View [dbo].[CustomerMoviesRentals]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerMoviesRentals]
AS
SELECT        dbo.RentedMovies.RMID, dbo.Customer.FirstName, dbo.Customer.LastName, dbo.Movies.Title, dbo.RentedMovies.DateRented, dbo.RentedMovies.DateReturned
FROM            dbo.RentedMovies INNER JOIN
                         dbo.Movies ON dbo.RentedMovies.MovieIDFK = dbo.Movies.MovieID INNER JOIN
                         dbo.Customer ON dbo.RentedMovies.CustIDFK = dbo.Customer.CustID
GO
/****** Object:  View [dbo].[MovieView]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MovieView]
AS
SELECT        MovieID, Rating, Title, Year, Plot, Genre
FROM            dbo.Movies
GO
/****** Object:  View [dbo].[MoviesOut]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MoviesOut]
AS
SELECT        dbo.Movies.MovieID, dbo.Movies.Rating, dbo.Movies.Title, dbo.Movies.Year, dbo.Movies.Plot, dbo.Movies.Genre, dbo.RentedMovies.DateRented, dbo.RentedMovies.DateReturned
FROM            dbo.Movies INNER JOIN
                         dbo.RentedMovies ON dbo.Movies.MovieID = dbo.RentedMovies.MovieIDFK
GO
/****** Object:  View [dbo].[TopCustomers]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TopCustomers]
AS
SELECT        TOP (100) PERCENT dbo.Customer.FirstName, dbo.Customer.LastName, COUNT(dbo.Customer.CustID) AS MoviesRented
FROM            dbo.Customer INNER JOIN
                         dbo.RentedMovies ON dbo.Customer.CustID = dbo.RentedMovies.CustIDFK INNER JOIN
                         dbo.Movies ON dbo.RentedMovies.MovieIDFK = dbo.Movies.MovieID
GROUP BY dbo.Customer.FirstName, dbo.Customer.LastName
GO
/****** Object:  View [dbo].[TopMovies]    Script Date: 3/08/2021 12:57:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TopMovies]
AS
SELECT        dbo.Movies.Title, COUNT(dbo.Movies.MovieID) AS RentalAmount
FROM            dbo.Customer INNER JOIN
                         dbo.RentedMovies ON dbo.Customer.CustID = dbo.RentedMovies.CustIDFK INNER JOIN
                         dbo.Movies ON dbo.RentedMovies.MovieIDFK = dbo.Movies.MovieID
GROUP BY dbo.Movies.Title
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1500, N'Lourdes ', N'Shaffer', N'159 Lakeview Drive', N'7441988')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1501, N'James', N'Hoker', N'123 smes steet', N'8987656')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1502, N'Camille', N'isbel', N'67 oxford road', N'4567654')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1503, N'Ngawhiria', N'monds', N'3/45 unit 1 xox steet', N'67654567')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1504, N'Sam', N'donnelly', N'Hmailton river road', N'7657654')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1505, N'Willow', N'karl', N'7 frost road', N'7654567')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1506, N'Claudia', N'Farhat', N'320 te rapa hamilton', N'8765445')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1507, N'Ospiria', N'Loches', N'1307  Hortiu Road', N'8765678')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1508, N'Brieana', N'Cattely', N'Lake View Point ', N'345678')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1509, N'lanas', N'olive', N'234 sahesper road', N'9876543')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1510, N'reeces', N'tom', N'45 tommy street', N'56789876')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1511, N'harry', N'styalh', N'1 alzebra cross road', N'54345678')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1512, N'Ashton', N'aroha''', N'45 frankton street', N'7654678')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1513, N'Smiley', N'queen''', N'67 nomand road', N'545678')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1515, NULL, NULL, NULL, N'')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (1, N'3', N'sjab', N'2002', 2.0000, N'34', N'Action', N'Action')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (2, N'3', N'Jungle Cruies', N'2012', 2.0000, N'45', N'Fight', N'Action')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (3, N'4', N'Jolt', N'2014', 2.0000, N'5', N'Action', N'Action')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (4, N'5', N'The Tomorrow War', N'2015', 5.0000, N'66', N'Romentic', N'Romentic')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (5, N'4', N'Spirsl', N'2016', 5.0000, N'77', N'Romentic', N'Romentic')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (6, N'5', N'365 days', N'2020', 2.0000, N'8', N'Action', N'Action')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (7, N'3', N'Greenland', N'2020', 5.0000, N'34', N'Romentic', N'Romentic')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (8, N'3', N'Nobody', N'2013', 5.0000, N'56', N'Action', N'Action')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (9, N'4', N'Official Secrets', N'2006', 5.0000, N'2', N'Romentic', N'Romentic')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (10, N'4', N'In the Height', N'2004', 5.0000, N'23', N'Action', N'Action')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (11, N'5', N'Rise of the war', N'2021', 52.0000, N'45', N'Romentic', N'Romentic')
INSERT [dbo].[Movies] ([MovieID], [Rating], [Title], [Year], [Rental_Cost], [Copies], [Plot], [Genre]) VALUES (12, N'3', N'No war', N'2012', 2.0000, N'33', N'Action', N'Action')
SET IDENTITY_INSERT [dbo].[Movies] OFF
GO
SET IDENTITY_INSERT [dbo].[RentedMovies] ON 

INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (1, 1, 1500, CAST(N'2021-06-16T16:00:51.000' AS DateTime), CAST(N'2021-06-16T16:00:51.000' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (2, 4, 1502, CAST(N'2021-08-03T12:54:22.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[RentedMovies] OFF
GO
ALTER TABLE [dbo].[RentedMovies]  WITH CHECK ADD  CONSTRAINT [FK_RentedMovies_Customer] FOREIGN KEY([CustIDFK])
REFERENCES [dbo].[Customer] ([CustID])
GO
ALTER TABLE [dbo].[RentedMovies] CHECK CONSTRAINT [FK_RentedMovies_Customer]
GO
ALTER TABLE [dbo].[RentedMovies]  WITH CHECK ADD  CONSTRAINT [FK_RentedMovies_Movies] FOREIGN KEY([MovieIDFK])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[RentedMovies] CHECK CONSTRAINT [FK_RentedMovies_Movies]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 17
               Left = 331
               Bottom = 147
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 27
               Bottom = 136
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Customer"
            Begin Extent = 
               Top = 1
               Left = 653
               Bottom = 131
               Right = 823
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomerMoviesRentals'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomerMoviesRentals'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customer"
            Begin Extent = 
               Top = 17
               Left = 656
               Bottom = 147
               Right = 826
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MovieConnection'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MovieConnection'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MoviesOut'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MoviesOut'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MovieView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MovieView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TopCustomers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TopCustomers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TopMovies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TopMovies'
GO
USE [master]
GO
ALTER DATABASE [yogeshdb] SET  READ_WRITE 
GO
