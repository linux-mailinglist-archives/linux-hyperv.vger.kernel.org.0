Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6504C2B54BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Nov 2020 00:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKPXK2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Nov 2020 18:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPXK2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Nov 2020 18:10:28 -0500
Subject: Re: [GIT PULL] Hyper-V fixes for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605568228;
        bh=GNE8ClcNESQuIAyoGl3ADYNWh2wjA97OrnMRMBN61Ts=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zJpC1ptB01pNUtWtztkJCTd4+Smgls6HupjTU8/UF403lp6Grw7UuCeZ01FSrK6kY
         ak5TabnuQB6jHHAV+4/vcQI1NP3epusSBeIQyXKREEQO/gIYNjtARS2K1Bmxox28Iy
         VkJm1XlheqqRG//sfJ9Rei2qzyw/xHrRQP0v8/T0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201116171353.ebq6iwpe4cdp5j2a@liuwe-devbox-debian-v2>
References: <20201116171353.ebq6iwpe4cdp5j2a@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201116171353.ebq6iwpe4cdp5j2a@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: 92e4dc8b05663d6539b1b8375f3b1cf7b204cfe9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5698b3835f5990deef30fa5397cae563af3c68a
Message-Id: <160556822805.30215.1382306859167136782.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Nov 2020 23:10:28 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Mon, 16 Nov 2020 17:13:53 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5698b3835f5990deef30fa5397cae563af3c68a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
