-- AlterTable
ALTER TABLE [dbo].[Enrollment] ADD [hidden] BIT NOT NULL CONSTRAINT [Enrollment_hidden_df] DEFAULT 0;
