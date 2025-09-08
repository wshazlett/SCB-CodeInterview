<p align="center">
  <a href="https://stylecraft.com" target="_blank" alt="Stylecraft Builders Home"><img src="./img/scb_white-background.png" width="450" /></a>
</p>

# Stylecraft Builders: IT Administrator Scripting Challenges

## Introduction

Thank you for your interest in becoming an IT Administrator here at Stylecraft! As a part of this role, you will be responsible for maintaining, extending, and creating scripts to automate various tasks. For standardization, submissions should be done in **Powershell**, and ideally should be able to work in Windows Powershell 5.1+ and Powershell Core 7.4+, though you do not have to test in both necessarily.

These challenges don't have right or wrong answers, and aren't meant to disqualify any candidate, but are designed to highlight your problem solving process. Each of these challenges are parts of actual problems that we have solved here at Stylecraft, or rely on skills necessary to solve problems we have faced. Our staff will review work for technical skill, problem solving techniques, and effective documentation.

With that being said, you may not be able to fully complete each challenge in the timeframe given, and that's okay! You should attempt to complete as much of each challenge as possible. Each challenge has been given a time estimate based on how long it took to solve these problems originally. You may take more or less time to complete each challenge, and that's fine.

You are encouraged to use resources such as Microsoft's official Powershell documentation, forums (e.g. Reddit, Stack Exchange, Microsoft Learn), and learning platforms (e.g. LinkedIn Learning, Coursera, Udemy). **Please do not use generative AI to complete these challenges.** If you use an outside resource, you are encouraged to make a note in your code about what the resource was, and how to access it. We do not need formal citations.

**If you have any technical questions, please visit our [SCB Code Interview: IT Administrators Q&A discussion board](https://github.com/Stylecraft-Builders/SCB-CodeInterview/discussions/1) for assistance.**

**If you have questions about the hiring process, please reach out to your HR point of contact.**


## Getting Started

To be successful with these code challenges, we are requiring code submissions to be done via a public GitHub repository. This is to allow external users to submit their code to us without going through the hassle of bundling as a .zip and trying to share it out over OneDrive or by email.

If you are not familiar with using Git/GitHub, I highly recommend the following resources:

- [W3Schools: Git Tutorial](https://www.w3schools.com/git/default.asp)
- [GeeksForGeeks: Ultimate Guide to Git and GitHub](https://www.geeksforgeeks.org/blogs/ultimate-guide-git-github/)
- [FreeCodeCamp: Git and GitHub for Beginners](https://www.freecodecamp.org/news/git-and-github-for-beginners/)
- [LinkedIn Learning: Programming Foundations, Version Control with Git](https://www.linkedin.com/learning/programming-foundations-version-control-with-git-21044342/don-t-lose-your-work?u=2045532)
- [LinkedIn Learning: Learning Git and GitHub](https://www.linkedin.com/learning/learning-git-and-github-23011330/welcome?u=2045532)

### NOTE: When you are invited to look at this repository, you will receive a GUID that you will use to name your Git branch. Please only use this GUID when naming your branch so that we can track submissions without you needing to write your name in the branch name.

For example, let's say I received the GUID `efa44b29-89bd-11f0-bfc6-4c496cf734f5` in my email. I will use this to identify my Git branch in these examples. Please don't use this example GUID or your submission can't be considered.

### Cloning This Repository

Here is a quick way to clone this repository using Git BASH (Git for Windows). If you are using Mac or Linux then these will be the same commands if you are using BASH.

1. Clone the Repository

```BASH
$ git clone https://github.com/Stylecraft-Builders/SCB-CodeInterview.git
```

2. Create your OWN BRANCH (you can't commit to the main branch). Please use the form `submission/{GUID}` for the GitHub Actions to run successfully.

```BASH
$ git checkout -b submission/efa44b29-89bd-11f0-bfc6-4c496cf734f5
```

3. Make sure you `git add . && git commit` relatively frequently. I recommend using `git tag` to tag each Challenge as you complete it. For example, `git tag challenge1-complete a5278c1`. You can optionally tag the start of work on a challenge if you would like as well. You don't need to perform these challenges in order.

```BASH
$ git add . && git commit -m "Adds profile.xml to Challenge1 folder to finish Challenge1"
[submission/efa44b29-89bd-11f0-bfc6-4c496cf734f5 a5278c1] Adds profile.xml to Challenge1 folder to finish Challenge1
    ...

$ git tag challenge1-complete a5278c1
```

## Submitting Your Code

When you are ready to submit your code, you will want to perform a `git push` with all of your commits up to your personal branch, and then perform a pull request to the branch named `submit-here`.

1. Push your code changes and tags to `origin/<your-GUID>`

```BASH
$ git push -u origin submission/efa44b29-89bd-11f0-bfc6-4c496cf734f5
$ git push --tags
```

2. On GitHub, open a [pull request](https://docs.github.com/en/pull-requests) to merge against the branch name `submit-here`. Please do not open a pull request against the `main` branch or it will be rejected.

## Table of Contents

| Doc Link | Description |
| :------- | :---------- |
| [Challenge1](./Challenge1) | WLAN Network Deployment (est. 2 hours) |
| [Challenge2](./Challenge2) | Domain Blocklist Parsing (est. 5 hours) |
| [Challenge3](./Challenge3) | API Calls (est. 1 hour) |
| [img](./img) | Contains supplementary images for the Markdown files. |
| [challenge_setup](./challenge_setup/) | Python scripts for setting up the challenge environments and generating data, as needed. |

## Copyright

**Classification: Public**

This repository contains material that has been approved for release to public audiences. This material is not sensitive or proprietary, however this repository is intended only to supplement the interview process for IT Administrators.