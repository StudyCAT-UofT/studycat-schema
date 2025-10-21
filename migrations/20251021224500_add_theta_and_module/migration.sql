/*
  Warnings:

  - You are about to drop the column `module` on the `Item` table. All the data in the column will be lost.
  - You are about to drop the column `includedModules` on the `Quiz` table. All the data in the column will be lost.
  - Added the required column `moduleId` to the `Item` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Item_module_idx";

-- AlterTable
ALTER TABLE "Item" DROP COLUMN "module",
ADD COLUMN     "moduleId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Quiz" DROP COLUMN "includedModules",
ADD COLUMN     "includedModuleIds" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- CreateTable
CREATE TABLE "Module" (
    "id" TEXT NOT NULL,
    "offeringId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Module_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Theta" (
    "id" TEXT NOT NULL,
    "enrollmentId" TEXT NOT NULL,
    "moduleId" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Theta_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Module_offeringId_idx" ON "Module"("offeringId");

-- CreateIndex
CREATE UNIQUE INDEX "Module_offeringId_name_key" ON "Module"("offeringId", "name");

-- CreateIndex
CREATE INDEX "Theta_enrollmentId_idx" ON "Theta"("enrollmentId");

-- CreateIndex
CREATE INDEX "Theta_moduleId_idx" ON "Theta"("moduleId");

-- CreateIndex
CREATE UNIQUE INDEX "Theta_enrollmentId_moduleId_key" ON "Theta"("enrollmentId", "moduleId");

-- CreateIndex
CREATE INDEX "Item_moduleId_idx" ON "Item"("moduleId");

-- AddForeignKey
ALTER TABLE "Module" ADD CONSTRAINT "Module_offeringId_fkey" FOREIGN KEY ("offeringId") REFERENCES "CourseOffering"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Theta" ADD CONSTRAINT "Theta_enrollmentId_fkey" FOREIGN KEY ("enrollmentId") REFERENCES "Enrollment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Theta" ADD CONSTRAINT "Theta_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Item" ADD CONSTRAINT "Item_moduleId_fkey" FOREIGN KEY ("moduleId") REFERENCES "Module"("id") ON DELETE CASCADE ON UPDATE CASCADE;
