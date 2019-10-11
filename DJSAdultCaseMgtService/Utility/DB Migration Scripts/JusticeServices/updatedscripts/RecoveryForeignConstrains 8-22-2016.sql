Use Justiceservices
--1
ALTER TABLE [dbo].[AspNetUserClaims]
 DROP CONSTRAINT  [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
 GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO

--2

ALTER TABLE [dbo].[AspNetUserLogins]
DROP CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO

--3
ALTER TABLE [dbo].[AspNetUserRoles]
DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO

--4
ALTER TABLE [dbo].[AspNetUserRoles] 
DROP CONSTRAINT  [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO

--5
ALTER TABLE [dbo].[FamilyProfile] 
DROP CONSTRAINT [FK_dbo.FamilyProfile_dbo.Relationship_RelationshipID]
GO
ALTER TABLE [dbo].[FamilyProfile]  WITH CHECK ADD  CONSTRAINT [FK_dbo.FamilyProfile_dbo.Relationship_RelationshipID] FOREIGN KEY([RelationshipID])
REFERENCES [dbo].[Relationship] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FamilyProfile] CHECK CONSTRAINT [FK_dbo.FamilyProfile_dbo.Relationship_RelationshipID]
GO

--6

ALTER TABLE [dbo].[PersonAddress] 
DROP CONSTRAINT [FK_dbo.PersonAddress_dbo.AddressType_AddressTypeID]
GO
ALTER TABLE [dbo].[PersonAddress]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PersonAddress_dbo.AddressType_AddressTypeID] FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[AddressType] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonAddress] CHECK CONSTRAINT [FK_dbo.PersonAddress_dbo.AddressType_AddressTypeID]
GO

--7

ALTER TABLE [dbo].[ServiceProgramCategory]
DROP CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceProgram_ServiceProgramID]
GO
ALTER TABLE [dbo].[ServiceProgramCategory]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceProgram_ServiceProgramID] FOREIGN KEY([ServiceProgramID])
REFERENCES [dbo].[ServiceProgram] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceProgramCategory] CHECK CONSTRAINT [FK_dbo.ServiceProgramCategory_dbo.ServiceProgram_ServiceProgramID]
GO

--8
ALTER TABLE [dbo].[PlacementOffense]
DROP CONSTRAINT [FK_dbo.PlacementOffense_dbo.Offense_OffenseID]
GO

ALTER TABLE [dbo].[PlacementOffense]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PlacementOffense_dbo.Offense_OffenseID] FOREIGN KEY([OffenseID])
REFERENCES [dbo].[Offense] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlacementOffense] CHECK CONSTRAINT [FK_dbo.PlacementOffense_dbo.Offense_OffenseID]
GO

--9

ALTER TABLE [dbo].[PlacementOffense]
DROP CONSTRAINT [FK_dbo.PlacementOffense_dbo.Placement_PlacementID]

ALTER TABLE [dbo].[PlacementOffense]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PlacementOffense_dbo.Placement_PlacementID] FOREIGN KEY([PlacementID])
REFERENCES [dbo].[Placement] ([ID])

GO
ALTER TABLE [dbo].[PlacementOffense] CHECK CONSTRAINT [FK_dbo.PlacementOffense_dbo.Placement_PlacementID]
GO

--creating the foreign key for clientprofile
ALTER TABLE [dbo].[Placement]
DROP CONSTRAINT [FK_dbo.Placement_dbo.Clientprofile_ClientprofileID]

--GO
--10

--11
--MODIFYING ASSESSMENT DELETE ON CASCADE
ALTER TABLE [dbo].[Assessment]
DROP CONSTRAINT [FK_dbo.Assessment_dbo.ClientProfile_ClientProfileID]
GO

ALTER TABLE [dbo].[Assessment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Assessment_dbo.ClientProfile_ClientProfileID] FOREIGN KEY([ClientProfileID])
REFERENCES [dbo].[ClientProfile] ([ID])

GO
ALTER TABLE [dbo].[Assessment] CHECK CONSTRAINT [FK_dbo.Assessment_dbo.ClientProfile_ClientProfileID]
GO
--12
--reactivate the client profile

update clientprofile set active=0 where personid=42115