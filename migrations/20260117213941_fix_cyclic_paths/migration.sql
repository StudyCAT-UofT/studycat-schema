BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[Attempt] DROP CONSTRAINT [Attempt_enrollmentId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[Enrollment] DROP CONSTRAINT [Enrollment_offeringId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[Module] DROP CONSTRAINT [Module_offeringId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[Quiz] DROP CONSTRAINT [Quiz_createdById_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[QuizItem] DROP CONSTRAINT [QuizItem_quizId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[QuizModule] DROP CONSTRAINT [QuizModule_moduleId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[QuizModule] DROP CONSTRAINT [QuizModule_quizId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[Response] DROP CONSTRAINT [Response_itemId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[Theta] DROP CONSTRAINT [Theta_enrollmentId_fkey];

-- AddForeignKey
ALTER TABLE [dbo].[Enrollment] ADD CONSTRAINT [Enrollment_offeringId_fkey] FOREIGN KEY ([offeringId]) REFERENCES [dbo].[CourseOffering]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Module] ADD CONSTRAINT [Module_offeringId_fkey] FOREIGN KEY ([offeringId]) REFERENCES [dbo].[CourseOffering]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Theta] ADD CONSTRAINT [Theta_enrollmentId_fkey] FOREIGN KEY ([enrollmentId]) REFERENCES [dbo].[Enrollment]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Quiz] ADD CONSTRAINT [Quiz_createdById_fkey] FOREIGN KEY ([createdById]) REFERENCES [dbo].[User]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[QuizItem] ADD CONSTRAINT [QuizItem_quizId_fkey] FOREIGN KEY ([quizId]) REFERENCES [dbo].[Quiz]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[QuizModule] ADD CONSTRAINT [QuizModule_quizId_fkey] FOREIGN KEY ([quizId]) REFERENCES [dbo].[Quiz]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[QuizModule] ADD CONSTRAINT [QuizModule_moduleId_fkey] FOREIGN KEY ([moduleId]) REFERENCES [dbo].[Module]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Attempt] ADD CONSTRAINT [Attempt_enrollmentId_fkey] FOREIGN KEY ([enrollmentId]) REFERENCES [dbo].[Enrollment]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Response] ADD CONSTRAINT [Response_itemId_fkey] FOREIGN KEY ([itemId]) REFERENCES [dbo].[Item]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
