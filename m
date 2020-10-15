Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B989D28FB6E
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Oct 2020 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbgJOXIc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Oct 2020 19:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbgJOXIb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Oct 2020 19:08:31 -0400
Subject: Re: [GIT PULL] Hyper-V commits for 5.10, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602803311;
        bh=G/mg8bgpahf73EujAqlkITdjl49u9HIQ854QnUXdmAU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ouEExP6Lo6BqGyQIm3vmF6bvvyhnKvPRqkNnfTrnL6BrgBM9BZiVST/7WCaArbfJ4
         nlx7lYfSlF3EHOhYoOK0ThQ65GPHJ97lUNCs1O9Z4K3kHA5Ff1hakIekSTQmOXloPP
         wumo7UdNnnQT/XAYTV6NeK9fWGl4AvyB7Klz9mCo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015163248.yo3ior67vxtvojra@liuwe-devbox-debian-v2>
References: <20201015163248.yo3ior67vxtvojra@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015163248.yo3ior67vxtvojra@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed
X-PR-Tracked-Commit-Id: 626b901f60446355e35e8c76c6b391a7d7491203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d0f6b0aab9afbd6fdf3514cb4acc249d7aebf9c
Message-Id: <160280331136.7173.12667080445747465305.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 23:08:31 +0000
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

The pull request you sent on Thu, 15 Oct 2020 16:32:48 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d0f6b0aab9afbd6fdf3514cb4acc249d7aebf9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
