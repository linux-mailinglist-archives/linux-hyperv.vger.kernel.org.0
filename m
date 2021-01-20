Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753702FCA1D
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 05:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhATEvX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Jan 2021 23:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbhATEvD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Jan 2021 23:51:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 20C6B23137;
        Wed, 20 Jan 2021 04:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611118222;
        bh=rd3vLXIH9asFrOl/woIo1LuABsCpeFAqzuVO0FSk7I8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tz9IpALO2cTocnGYPbvgZIv6Gc0SN1P3chDIovOz2yNsW/QpuKmzFnGuxZwqDinh2
         KgOuZTIYsVZ5HU5mtXHdkdYcUvyYKOkyqEimW4NS6dmYftDs8LM0rlVmS5CMF3xuP0
         IzcQujLMbHeU2RrcAwf9t1DEx4fUDgsWduONDH6/c5RmQI6NxDrIrsq3NcbrQHJLGc
         Vs+D6E6d+3ex9613zwLUW/lF1G4N57+2CywUU0TxDu0E3LWeSQG169DDkS3msHpxIu
         kDhfCOyveoBewHlfdgQfJs0Wf6Pg9lka/hOY0Q98ZjCFRjigm84vxtr9GRByxupvCH
         LXMd0DmUM4Onw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 0609F6036C;
        Wed, 20 Jan 2021 04:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210119113040.cy7x6hilvts56xan@liuwe-devbox-debian-v2>
References: <20210119113040.cy7x6hilvts56xan@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210119113040.cy7x6hilvts56xan@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210119
X-PR-Tracked-Commit-Id: fff7b5e6ee63c5d20406a131b260c619cdd24fd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28df858033484b830c2ea146c03da67d2d659405
Message-Id: <161111822195.31434.2452040472483337572.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Jan 2021 04:50:21 +0000
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

The pull request you sent on Tue, 19 Jan 2021 11:30:40 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210119

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28df858033484b830c2ea146c03da67d2d659405

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
