Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78F4435AD
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Nov 2021 19:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKBSjo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Nov 2021 14:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhKBSjn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Nov 2021 14:39:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A895C6103C;
        Tue,  2 Nov 2021 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635878228;
        bh=HrZO8Q1VfeeHo0hxkPKKSp783NHfKYax5CtVojWKoIg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JqKaedmYVch5Lbr6yBVNkTotSvc460JZFGZChN6BrEMVpeeilDoqBevav8bf+3nZb
         LiAhei/jth6iMmTKV0OHuFQumrnj6pzNjYW0/7Pk0ZukY654rB/9J7omfssMURncky
         hKpABEhSU0yp6s+Gsu019PPAZtMVf/3pB1yH6EurQTU05ofDh8aGZ9ooZ0GJ3U/abb
         nQMs0LwtRnu3hjzFY+o40tAJTI8z/jAbA6+Fsf5qF5YGgK7IlmJZrh+MTQPfIiAIXv
         lOApb+aMdmnaq3RM02Y61/aL0cXXGh6Pckywk1TvTHiR81C/VMdy84lODY+B3FXjA/
         bFgli4qRzbAKw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 96FA160A90;
        Tue,  2 Nov 2021 18:37:08 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
References: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20211102
X-PR-Tracked-Commit-Id: 285f68afa8b20f752b0b7194d54980b5e0e27b75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44261f8e287d1b02a2e4bfbd7399fb8d37d1ee24
Message-Id: <163587822855.14475.17596091804975220404.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 18:37:08 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 13:13:09 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20211102

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44261f8e287d1b02a2e4bfbd7399fb8d37d1ee24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
