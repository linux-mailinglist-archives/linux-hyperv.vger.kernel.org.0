Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1EE36B845
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Apr 2021 19:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhDZRr5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Apr 2021 13:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235584AbhDZRr4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Apr 2021 13:47:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EA342613B2;
        Mon, 26 Apr 2021 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459235;
        bh=t6L+sC5Vr3ZziZ+vqTWovfRpM028shEMLNqe0TWZoDU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HA/I1cCSUqzyGbbIB29DPGqoikyIHuyYR/UdxSzoT05CEa7lyzGRANJnMUuoJcMjv
         vUasn1miR1D+t3fLAw5CQt9B3Qys5JL2sT8yRY9G9lhCToL29+sgX5JHLNp2mlxCgT
         etSXHZ056P0GynQnD1yG5T1RvXetLZW0TuPx+QLX1/kDSJMdy/cod8l9kdTDImQq0z
         i4tnmbc5U6mdX4k7l/6CLSHWcgOcsEcfz3QB+gTO0eVn0UKQ/hcRVU8gdiu45f2T0I
         xT+RKJXh4hcsJIVzMu8mgYe1S476umQXDla45nnXyPrlRgajVqcSJAI2oR0Du2UMV6
         E3PMyiJGg31QQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E197D609AE;
        Mon, 26 Apr 2021 17:47:14 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426172042.tzl7i3mdr6dc4iyp@liuwe-devbox-debian-v2>
References: <20210426172042.tzl7i3mdr6dc4iyp@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426172042.tzl7i3mdr6dc4iyp@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210426
X-PR-Tracked-Commit-Id: 753ed9c95c37d058e50e7d42bbe296ee0bf6670d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d480dbf21f3385e9957b1ee8dadee35548f4516
Message-Id: <161945923491.30101.1618177739366309098.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:47:14 +0000
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

The pull request you sent on Mon, 26 Apr 2021 17:20:42 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210426

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d480dbf21f3385e9957b1ee8dadee35548f4516

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
