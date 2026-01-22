BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[User] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [User_id_df] DEFAULT NEWID(),
    [username] NVARCHAR(1000) NOT NULL,
    [givenName] NVARCHAR(1000) NOT NULL CONSTRAINT [User_givenName_df] DEFAULT '',
    [familyName] NVARCHAR(1000) NOT NULL CONSTRAINT [User_familyName_df] DEFAULT '',
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [User_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [User_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [User_username_key] UNIQUE NONCLUSTERED ([username])
);

-- CreateTable
CREATE TABLE [dbo].[Course] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Course_id_df] DEFAULT NEWID(),
    [code] NVARCHAR(1000) NOT NULL,
    [title] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Course_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Course_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Course_code_title_key] UNIQUE NONCLUSTERED ([code],[title])
);

-- CreateTable
CREATE TABLE [dbo].[Term] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Term_id_df] DEFAULT NEWID(),
    [name] NVARCHAR(1000) NOT NULL,
    [startDate] DATETIME2,
    [endDate] DATETIME2,
    CONSTRAINT [Term_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Term_name_key] UNIQUE NONCLUSTERED ([name])
);

-- CreateTable
CREATE TABLE [dbo].[CourseOffering] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [CourseOffering_id_df] DEFAULT NEWID(),
    [courseId] UNIQUEIDENTIFIER NOT NULL,
    [termId] UNIQUEIDENTIFIER NOT NULL,
    [display] NVARCHAR(1000),
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [CourseOffering_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [CourseOffering_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [CourseOffering_courseId_termId_key] UNIQUE NONCLUSTERED ([courseId],[termId])
);

-- CreateTable
CREATE TABLE [dbo].[Enrollment] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Enrollment_id_df] DEFAULT NEWID(),
    [userId] UNIQUEIDENTIFIER NOT NULL,
    [offeringId] UNIQUEIDENTIFIER NOT NULL,
    [offeringRole] NVARCHAR(1000) NOT NULL CONSTRAINT [Enrollment_offeringRole_df] DEFAULT 'STUDENT',
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Enrollment_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Enrollment_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Enrollment_userId_offeringId_key] UNIQUE NONCLUSTERED ([userId],[offeringId])
);

-- CreateTable
CREATE TABLE [dbo].[Module] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Module_id_df] DEFAULT NEWID(),
    [offeringId] UNIQUEIDENTIFIER NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Module_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Module_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Module_offeringId_name_key] UNIQUE NONCLUSTERED ([offeringId],[name])
);

-- CreateTable
CREATE TABLE [dbo].[Theta] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Theta_id_df] DEFAULT NEWID(),
    [enrollmentId] UNIQUEIDENTIFIER NOT NULL,
    [moduleId] UNIQUEIDENTIFIER NOT NULL,
    [value] FLOAT(53) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Theta_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [Theta_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Theta_enrollmentId_moduleId_key] UNIQUE NONCLUSTERED ([enrollmentId],[moduleId])
);

-- CreateTable
CREATE TABLE [dbo].[Item] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Item_id_df] DEFAULT NEWID(),
    [courseId] UNIQUEIDENTIFIER NOT NULL,
    [moduleId] UNIQUEIDENTIFIER NOT NULL,
    [externalQuestionId] NVARCHAR(1000) NOT NULL,
    [bloom] NVARCHAR(1000) NOT NULL,
    [stem] NVARCHAR(1000) NOT NULL,
    [reference] NVARCHAR(1000),
    [figureUrl] NVARCHAR(1000),
    [ptBi] FLOAT(53),
    [average] FLOAT(53),
    [attemptsCount] INT,
    [irtA] FLOAT(53) NOT NULL,
    [irtB] FLOAT(53) NOT NULL,
    [irtC] FLOAT(53) NOT NULL,
    [active] BIT NOT NULL CONSTRAINT [Item_active_df] DEFAULT 1,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Item_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Item_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Item_courseId_externalQuestionId_key] UNIQUE NONCLUSTERED ([courseId],[externalQuestionId])
);

-- CreateTable
CREATE TABLE [dbo].[ItemOption] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [ItemOption_id_df] DEFAULT NEWID(),
    [itemId] UNIQUEIDENTIFIER NOT NULL,
    [label] NVARCHAR(1000) NOT NULL,
    [text] NVARCHAR(1000) NOT NULL,
    [justification] NVARCHAR(1000),
    [isCorrect] BIT NOT NULL,
    CONSTRAINT [ItemOption_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [ItemOption_itemId_label_key] UNIQUE NONCLUSTERED ([itemId],[label])
);

-- CreateTable
CREATE TABLE [dbo].[Quiz] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Quiz_id_df] DEFAULT NEWID(),
    [offeringId] UNIQUEIDENTIFIER NOT NULL,
    [title] NVARCHAR(1000) NOT NULL,
    [fixedLength] INT NOT NULL,
    [active] BIT NOT NULL CONSTRAINT [Quiz_active_df] DEFAULT 1,
    [includedBlooms] NVARCHAR(1000) NOT NULL CONSTRAINT [Quiz_includedBlooms_df] DEFAULT '',
    [createdById] UNIQUEIDENTIFIER,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Quiz_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [Quiz_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[QuizItem] (
    [quizId] UNIQUEIDENTIFIER NOT NULL,
    [itemId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [QuizItem_pkey] PRIMARY KEY CLUSTERED ([quizId],[itemId])
);

-- CreateTable
CREATE TABLE [dbo].[QuizModule] (
    [quizId] UNIQUEIDENTIFIER NOT NULL,
    [moduleId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [QuizModule_pkey] PRIMARY KEY CLUSTERED ([quizId],[moduleId])
);

-- CreateTable
CREATE TABLE [dbo].[Attempt] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Attempt_id_df] DEFAULT NEWID(),
    [quizId] UNIQUEIDENTIFIER NOT NULL,
    [enrollmentId] UNIQUEIDENTIFIER NOT NULL,
    [startedAt] DATETIME2 NOT NULL CONSTRAINT [Attempt_startedAt_df] DEFAULT CURRENT_TIMESTAMP,
    [finishedAt] DATETIME2,
    [status] NVARCHAR(1000) NOT NULL CONSTRAINT [Attempt_status_df] DEFAULT 'IN_PROGRESS',
    [fixedLengthN] INT NOT NULL,
    [engineVersion] NVARCHAR(1000),
    [scopeSnapshot] NVARCHAR(1000),
    [engineMasteryAtFinish] NVARCHAR(1000),
    CONSTRAINT [Attempt_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Response] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Response_id_df] DEFAULT NEWID(),
    [attemptId] UNIQUEIDENTIFIER NOT NULL,
    [itemId] UNIQUEIDENTIFIER NOT NULL,
    [selectedLabel] NVARCHAR(1000) NOT NULL,
    [itemOptionId] UNIQUEIDENTIFIER,
    [isCorrect] BIT NOT NULL,
    [askedAt] DATETIME2 NOT NULL,
    [answeredAt] DATETIME2 NOT NULL,
    [responseTimeMs] INT NOT NULL,
    [engineMasterySnapshot] NVARCHAR(1000),
    CONSTRAINT [Response_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [CourseOffering_termId_idx] ON [dbo].[CourseOffering]([termId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [CourseOffering_courseId_idx] ON [dbo].[CourseOffering]([courseId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Enrollment_offeringId_idx] ON [dbo].[Enrollment]([offeringId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Enrollment_offeringRole_idx] ON [dbo].[Enrollment]([offeringRole]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Module_offeringId_idx] ON [dbo].[Module]([offeringId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Theta_enrollmentId_idx] ON [dbo].[Theta]([enrollmentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Theta_moduleId_idx] ON [dbo].[Theta]([moduleId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Item_courseId_idx] ON [dbo].[Item]([courseId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Item_moduleId_idx] ON [dbo].[Item]([moduleId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Item_bloom_idx] ON [dbo].[Item]([bloom]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Item_active_idx] ON [dbo].[Item]([active]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [ItemOption_isCorrect_idx] ON [dbo].[ItemOption]([isCorrect]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Quiz_offeringId_idx] ON [dbo].[Quiz]([offeringId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Quiz_active_idx] ON [dbo].[Quiz]([active]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [QuizItem_itemId_idx] ON [dbo].[QuizItem]([itemId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Attempt_quizId_idx] ON [dbo].[Attempt]([quizId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Attempt_enrollmentId_idx] ON [dbo].[Attempt]([enrollmentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Attempt_status_idx] ON [dbo].[Attempt]([status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Attempt_startedAt_idx] ON [dbo].[Attempt]([startedAt]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Response_attemptId_idx] ON [dbo].[Response]([attemptId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Response_itemId_idx] ON [dbo].[Response]([itemId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Response_isCorrect_idx] ON [dbo].[Response]([isCorrect]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Response_answeredAt_idx] ON [dbo].[Response]([answeredAt]);

-- AddForeignKey
ALTER TABLE [dbo].[CourseOffering] ADD CONSTRAINT [CourseOffering_courseId_fkey] FOREIGN KEY ([courseId]) REFERENCES [dbo].[Course]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[CourseOffering] ADD CONSTRAINT [CourseOffering_termId_fkey] FOREIGN KEY ([termId]) REFERENCES [dbo].[Term]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Enrollment] ADD CONSTRAINT [Enrollment_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[User]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Enrollment] ADD CONSTRAINT [Enrollment_offeringId_fkey] FOREIGN KEY ([offeringId]) REFERENCES [dbo].[CourseOffering]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Module] ADD CONSTRAINT [Module_offeringId_fkey] FOREIGN KEY ([offeringId]) REFERENCES [dbo].[CourseOffering]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Theta] ADD CONSTRAINT [Theta_enrollmentId_fkey] FOREIGN KEY ([enrollmentId]) REFERENCES [dbo].[Enrollment]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Theta] ADD CONSTRAINT [Theta_moduleId_fkey] FOREIGN KEY ([moduleId]) REFERENCES [dbo].[Module]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Item] ADD CONSTRAINT [Item_courseId_fkey] FOREIGN KEY ([courseId]) REFERENCES [dbo].[Course]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Item] ADD CONSTRAINT [Item_moduleId_fkey] FOREIGN KEY ([moduleId]) REFERENCES [dbo].[Module]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[ItemOption] ADD CONSTRAINT [ItemOption_itemId_fkey] FOREIGN KEY ([itemId]) REFERENCES [dbo].[Item]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Quiz] ADD CONSTRAINT [Quiz_offeringId_fkey] FOREIGN KEY ([offeringId]) REFERENCES [dbo].[CourseOffering]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Quiz] ADD CONSTRAINT [Quiz_createdById_fkey] FOREIGN KEY ([createdById]) REFERENCES [dbo].[User]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[QuizItem] ADD CONSTRAINT [QuizItem_quizId_fkey] FOREIGN KEY ([quizId]) REFERENCES [dbo].[Quiz]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[QuizItem] ADD CONSTRAINT [QuizItem_itemId_fkey] FOREIGN KEY ([itemId]) REFERENCES [dbo].[Item]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[QuizModule] ADD CONSTRAINT [QuizModule_quizId_fkey] FOREIGN KEY ([quizId]) REFERENCES [dbo].[Quiz]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[QuizModule] ADD CONSTRAINT [QuizModule_moduleId_fkey] FOREIGN KEY ([moduleId]) REFERENCES [dbo].[Module]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Attempt] ADD CONSTRAINT [Attempt_quizId_fkey] FOREIGN KEY ([quizId]) REFERENCES [dbo].[Quiz]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Attempt] ADD CONSTRAINT [Attempt_enrollmentId_fkey] FOREIGN KEY ([enrollmentId]) REFERENCES [dbo].[Enrollment]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Response] ADD CONSTRAINT [Response_attemptId_fkey] FOREIGN KEY ([attemptId]) REFERENCES [dbo].[Attempt]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Response] ADD CONSTRAINT [Response_itemId_fkey] FOREIGN KEY ([itemId]) REFERENCES [dbo].[Item]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Response] ADD CONSTRAINT [Response_itemOptionId_fkey] FOREIGN KEY ([itemOptionId]) REFERENCES [dbo].[ItemOption]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
