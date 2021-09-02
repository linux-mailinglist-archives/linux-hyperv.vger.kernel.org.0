Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF93FE773
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Sep 2021 04:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhIBCPI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Sep 2021 22:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhIBCPH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Sep 2021 22:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6282C610A8;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630548850;
        bh=3Bjzm+zT8bVoE2jjUXSV7BrAUuB6TLQR4RTYv2ZEsM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C6Rz79BdkNm+tsw1/neMER0cCYykdg0KKHwpNh5C6ykT/96qxDRs5qkkbgEQipxx6
         ftFdtypBtonShg1G+ZQrWNxPAM5HlDuaPzeW7jjbFeQrIv+rkyGeHCTlpBOtk74+Cb
         8o0sT4QzpWmYfml6QDreIUd+9llFKAgggnYMzsX8n0PoA6ZBLp3tPCFi1h0spoLDT3
         SRLiozHKe+8pACi+Lp3LLpU+SgZPcYgk3S46ka1wYobJoG1h5gMIiHcWoyGyZgGDNV
         1ZJB+aHKDsXe+Ks6X8Gx9AiKmJozBSL3lWvs7u7Ok5Cc9+qMrBCCLnnK8URRy5CQuN
         Skls6K6yVO9AQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5A9056098E;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210831141808.m4i2b3dc2phjjabb@liuwe-devbox-debian-v2>
References: <20210831141808.m4i2b3dc2phjjabb@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210831141808.m4i2b3dc2phjjabb@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210831
X-PR-Tracked-Commit-Id: 9d68cd9120e4e3af38f843e165631c323b86b4e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c07f191907e7d7e04034a2b9657a6bbf1355c60a
Message-Id: <163054885036.9778.9339474978296658229.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 02:14:10 +0000
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

The pull request you sent on Tue, 31 Aug 2021 14:18:08 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210831

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c07f191907e7d7e04034a2b9657a6bbf1355c60a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
