Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5333D476161
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Dec 2021 20:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbhLOTPQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Dec 2021 14:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbhLOTPP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Dec 2021 14:15:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4226AC061574;
        Wed, 15 Dec 2021 11:15:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D46BB61A5E;
        Wed, 15 Dec 2021 19:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40244C36AE4;
        Wed, 15 Dec 2021 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639595714;
        bh=jnNKzN3/LyivQSwG6a/PILUFPs0weRTJqZ0kYiAOAiM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pBRjSQT0odW5Fpp09mev62ZQ8g1E1wdaPJM0UcTMV4opNisNFap3lDFvbIjgpHFz2
         QQThb0wLoqzlfDCkLubuJQdrl5HHcrJ3GeBheYIr5HRiSNWcrWfyxsLgHGGA0NlomS
         61avZDHf1Ids5CqTefiUqvblc6uaRveIst4l06bWtkiIxEmtEhT6/V2jvAIT4KiE24
         ML0RfhEZGPygPdjWiEc1fXCZspB3I3DXflkJrDwFrxubTs5COk84gtZo+UQXrrVCH7
         sPXfFnR0FgD9O/6tznKWa6yStIhp+VmPoRxv5RXHpvIH0kxQFMOwbGfmIyJ9VfWgvW
         gdAaJRSmiGucA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2B78660984;
        Wed, 15 Dec 2021 19:15:14 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211214190833.a4cnzbygiph3ydl2@liuwe-devbox-debian-v2>
References: <20211214190833.a4cnzbygiph3ydl2@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211214190833.a4cnzbygiph3ydl2@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211214
X-PR-Tracked-Commit-Id: 1dc2f2b81a6a9895da59f3915760f6c0c3074492
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 213d9d4c25c380d4ce86d6ca3682e185f7924d05
Message-Id: <163959571417.3685.4533140541250038128.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Dec 2021 19:15:14 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 14 Dec 2021 19:08:33 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211214

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/213d9d4c25c380d4ce86d6ca3682e185f7924d05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
