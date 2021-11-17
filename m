Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A1454B55
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Nov 2021 17:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbhKQQwJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Nov 2021 11:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhKQQwF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Nov 2021 11:52:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 43A246137E;
        Wed, 17 Nov 2021 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637167746;
        bh=AAfzw2zGlr3QImhF5utGKNVpW4kvwxxjFSW7Q1F0A8I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GLpJ7d1DuoFAFbnb9SoA0ixrTfzgIPRObijX8P8GO/PIiJTpzMlIts8zjSamXKXjZ
         VKcQ2a4QJG+EZ5phe/tKrydUTzse3G8RihioXl1AwFN2sUeJmjYLNgP6RZWEU+JHvR
         kslKfzBaqFDbdshl3ZolsqXmrgixVq9dO7mLZOat60qY+CTzzqUAIjfMuhEWk8Jp9n
         lp/JuVm4nmV0fjFcdwZCYtk78EsF5L4A7egSdaTtATFMFDxIN8MiAPy7PLWQrUNyla
         p7gMyu+FTvtQmDG8qXh9XnTfD/DokEaNjaDoZXuSlq/YijJEStUBlifwIScwRu5WqQ
         tkTnMHSB64Ilw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 375E860A94;
        Wed, 17 Nov 2021 16:49:06 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211117114810.favtd35s5gra7lli@liuwe-devbox-debian-v2>
References: <20211117114810.favtd35s5gra7lli@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211117114810.favtd35s5gra7lli@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211117
X-PR-Tracked-Commit-Id: f3e613e72f66226b3bea1046c1b864f67a3000a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee1703cda8dc777e937dec172da55beaf1a74919
Message-Id: <163716774616.2428.17924057447912417998.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Nov 2021 16:49:06 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Wed, 17 Nov 2021 11:48:10 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211117

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee1703cda8dc777e937dec172da55beaf1a74919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
