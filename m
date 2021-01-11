Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9B2F207A
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jan 2021 21:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391516AbhAKUPD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jan 2021 15:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390529AbhAKUPC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jan 2021 15:15:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 24E002054F;
        Mon, 11 Jan 2021 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610396062;
        bh=1HebwtGXgAD4RYtBbwn+WVxKt1E+4mY10utMigoBQRY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DlS8AAxhViLMjRKoYv2+fl/kJ7VeB26BWHindwltJu7NrHfU9p0W4yWp4aVqkcnzE
         uON8MGN3GEgbhyCEEj6MjHo/UdXkAtofNAfTqjteQva0wxtnGqKvrj5qNoDcvA1zcX
         7zh1tYPLa7B7NxWlZC0yILk6xBegj8f60xQ2fgT/LtLxuR01V+l4Ub4l5QD6kwalU3
         aVcyac+M8IE/zRqH9FdjWtINF/IoGWdzA6/E87EkABIygFcBMX6LJmrv9yTiHPtXqM
         +Vwzpa/o+JqO2NADd73W9pNC3SPmRzdf0bIPGcwCJ5L1K0Fj51iyMWsEkcVzHTtZ3j
         khoDwqYniUcMw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 0ED21600E0;
        Mon, 11 Jan 2021 20:14:22 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210111114210.zpuskk7pct6ibf6d@liuwe-devbox-debian-v2>
References: <20210111114210.zpuskk7pct6ibf6d@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210111114210.zpuskk7pct6ibf6d@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210111
X-PR-Tracked-Commit-Id: ad0a6bad44758afa3b440c254a24999a0c7e35d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1ee3e150bd9da2dd60a210926c86cffd4a336ea
Message-Id: <161039606198.25323.4412347117487107929.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Jan 2021 20:14:21 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Mon, 11 Jan 2021 11:42:10 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210111

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1ee3e150bd9da2dd60a210926c86cffd4a336ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
