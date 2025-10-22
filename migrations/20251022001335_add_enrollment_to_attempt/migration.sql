/*
  Warnings:

  - You are about to drop the column `userId` on the `Attempt` table. All the data in the column will be lost.
  - Added the required column `enrollmentId` to the `Attempt` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Attempt" DROP CONSTRAINT "Attempt_userId_fkey";

-- DropIndex
DROP INDEX "Attempt_userId_idx";

-- AlterTable
ALTER TABLE "Attempt" DROP COLUMN "userId",
ADD COLUMN     "enrollmentId" TEXT NOT NULL;

-- CreateIndex
CREATE INDEX "Attempt_enrollmentId_idx" ON "Attempt"("enrollmentId");

-- AddForeignKey
ALTER TABLE "Attempt" ADD CONSTRAINT "Attempt_enrollmentId_fkey" FOREIGN KEY ("enrollmentId") REFERENCES "Enrollment"("id") ON DELETE CASCADE ON UPDATE CASCADE;
