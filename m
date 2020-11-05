Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA12A87E4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 21:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgKEUV2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 15:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbgKEUVY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:24 -0500
Subject: Re: [GIT PULL] Hyper-V fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607683;
        bh=dulk5KmFWuVno2rX+gwzsAOGoSfqXhjmupjdEDp2MBM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pDnxOOZLXptmU4c4RinAV3f5HO4SvosCyzAsOEqHQWYbBvzUWCWo8TSZIfSpFGrIu
         bGWDWTZvghZZ2DZ0i1kJHrcZn992R5zlorE4WAwo6lrM/aaw24b4cKLq2Ey1ku42J+
         3L8Txgf44BQ9MT3tPhveo6vpWwtMuTauB03qZYQk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201105163622.dgcchoa47cetr5e6@liuwe-devbox-debian-v2>
References: <20201105163622.dgcchoa47cetr5e6@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201105163622.dgcchoa47cetr5e6@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: dbf563eee0b8cc056744514d91c5ffc2fa6c0982
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6732b3548573780cd8e0ca17d90f3f1add6c0af7
Message-Id: <160460768370.18865.4418631381724204586.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:23 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Thu, 5 Nov 2020 16:36:22 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6732b3548573780cd8e0ca17d90f3f1add6c0af7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
