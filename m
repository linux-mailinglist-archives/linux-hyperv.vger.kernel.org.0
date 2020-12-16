Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA02DC7A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Dec 2020 21:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgLPURL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Dec 2020 15:17:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgLPURL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Dec 2020 15:17:11 -0500
Subject: Re: [GIT PULL] Hyper-V commits for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608149790;
        bh=jgfQaAoV4ebctupq/4HVG22n4AjqmhxSDgj6TUeBExU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FNQCO/qqDDRjrIfp/ewDHW1ehzQfiRNUsMOU8bIPnwSmZyTY89N2n+bfwYk5KJRyL
         5qPAEiHvlIZysUC+vlia267yv1Wu04yA10PmdNr/Vyqg6zNtG5TW2PcGpj2cyH1AbG
         bfTelrIhTWPvuuzR3MAMfyVqcYZrl0pIr85nonsflKt5ybDqGNFhfINFGCx7nDqAy/
         PLCqbGRAiRCMJEmVMqjT7EPmUqem2FTGlNFv8f02TPtUcsQrQE5JZvAgD+bycCvftj
         B3BdJ/emKHv+iJosFUvkuYuWEatMWf0uJOYLvmpAsiCq751xfjYWjStbVv42T4KFCQ
         LD1/VwboYTbyQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214132833.vtqxw46vemhez5mb@liuwe-devbox-debian-v2>
References: <20201214132833.vtqxw46vemhez5mb@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214132833.vtqxw46vemhez5mb@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20201214
X-PR-Tracked-Commit-Id: d1df458cbfdb0c3384c03c7fbcb1689bc02a746c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 571b12dd1ad41f371448b693c0bd2e64968c7af4
Message-Id: <160814979077.31129.4542093654981235311.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 20:16:30 +0000
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

The pull request you sent on Mon, 14 Dec 2020 13:28:33 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20201214

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/571b12dd1ad41f371448b693c0bd2e64968c7af4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
