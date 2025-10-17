# StudyCAT Prisma Schema

This repository contains the Prisma schema and migrations for the StudyCAT platform.

The reason for a separate schema repository is to allow for this to be used as a submodule by the other StudyCAT repositories that depend on the same database schema. This allows for a single source of truth for the schema and migrations.

## Usage

This repository is intended to be used as a submodule by the other StudyCAT repositories. To do this, add this repository as a submodule to the other repositories and then run the following command to update the submodule:

```bash
git submodule update --init --recursive
```

## Implementing Changes Requiring Schema Changes

When working on changes that require schema changes in a repository that depends on this schema repository, follow these steps (this example is for the `studycat-service` repository):

1. Ensure you are on a feature branch of the repository

```bash
git checkout -b my-feature
```

2. Create a schema feature branch (inside the submodule)

```bash
cd external/studycat-schema # path to the submodule
git fetch
git checkout -b my-feature-schema
```

3. Edit the schema and create a migration

```bash
# after editing the schema:
prisma migrate dev # this will create a new migration file in the migrations directory
```

4. Push the schema changes and migration file to the remote repository

```bash
git add .
git commit -m "feat: add my feature schema changes"
git push origin my-feature-schema
```

5. Create a PR for the schema feature branch and merge it into the `main` branch of `studycat-schema`

6. Manually tag the release of the schema changes according to semantic versioning (e.g. `v1.0.0`). On a fresh clone of the `studycat-schema` repository, run the following command to create the tag:

```bash
# in a clean clone/working copy of the schema repo (not submodule)
git checkout main
git pull origin main

# create an annotated tag
git tag -a v1.13.0 -m "Release schema v1.13.0: add my feature schema changes"
git push origin v1.13.0
```

<!-- add callout for semantic versioning -->

> [!TIP]
> Destructive/removals → major (v2.0.0)
>
> Backward-compatible adds → minor (v1.13.0)
>
> Hotfix migration tweaks → patch (v1.13.1)

7. Update the submodule in your feature branch in the `studycat-service` repository to the new tag. In your feature branch:

```bash
# in your feature branch, update the submodule to the new tag
cd external/studycat-schema
git fetch --tags
git checkout --detach tags/v1.13.0

# commit the new submodule
cd ../../
git add external/studycat-schema
git commit -m "chore: bump schema submodule to v1.13.0"
git push
```

8. The feature branch is now ready to be merged into the `main` branch of the `studycat-service` repository.
