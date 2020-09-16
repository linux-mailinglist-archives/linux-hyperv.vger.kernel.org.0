Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C970B26C8F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgIPTBC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 15:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbgIPTA0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 15:00:26 -0400
Subject: Re: [GIT PULL] Hyper-V fixes for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600282825;
        bh=diYUg/Atzoj3Sg/gpFWsuRSLsNWf09rssXPFQw0N3s0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kRxPPWgkTqI1BMlumNbzFvOaGiIwwxkNNplWKSFN6XgpLWXDP6waTkGKrI+M82VYQ
         CTIVeHxG7XXbvGmzfxnR+YlTQVE6jDJrcubTZBtOh6QNwEANjtqzTpKIU9vxIVVQyw
         fub/v454lq4HJmaK+6CkSAzz904hCzNrg0n3Ch4E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200915114457.tozhtbxojblcnyow@liuwe-devbox-debian-v2>
References: <20200915114457.tozhtbxojblcnyow@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200915114457.tozhtbxojblcnyow@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: 911e1987efc8f3e6445955fbae7f54b428b92bd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00acc50506329bef3c28d11481730e6cda01a6a0
Message-Id: <160028282559.10613.17712799534565360889.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Sep 2020 19:00:25 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 15 Sep 2020 11:44:57 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00acc50506329bef3c28d11481730e6cda01a6a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
