Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDBB1ED8A4
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2020 00:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFCWaI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jun 2020 18:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgFCWaI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jun 2020 18:30:08 -0400
Subject: Re: [GIT PULL] Hyper-V commits for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591223407;
        bh=mBMUz/upXT1Rm2DIZiASRqtA4m6wu5qmMfoDC6Hz4Lk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kqOIIETPImHZ3Nov76Qetdsj+G5yaK/vjVqQ8pGQ76SbGjAZRab28bBB+BkxORFbT
         zCHQwBOOvUOWL9a7iz7fcJhY3A4Ow7D++hiDeUPj7rnXg+r8j+38BhEvxIDOBavksx
         fZWxoXMIQnjsVuj9mifkS24p1iLXM5hDLZKwLh4Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602174752.u67tmpxojt5dv655@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200602174752.u67tmpxojt5dv655@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602174752.u67tmpxojt5dv655@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-next-signed
X-PR-Tracked-Commit-Id: afaa33da08abd10be8978781d7c99a9e67d2bbff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b2591c21273ebf65c13dae5d260ce88f0f197dd
Message-Id: <159122340776.21404.18224584718474512131.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 22:30:07 +0000
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

The pull request you sent on Tue, 2 Jun 2020 17:47:52 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b2591c21273ebf65c13dae5d260ce88f0f197dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
