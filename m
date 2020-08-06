Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBFD23DDF1
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Aug 2020 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgHFRUL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Aug 2020 13:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbgHFRT7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Aug 2020 13:19:59 -0400
Subject: Re: [GIT PULL] Hyper-V commits for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596734399;
        bh=llGio8NISU1dDiX/k1/v42pGDK10egkgeYA1hXPqBrE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oW/8qgwVMVBvwGY9hoa9QyRwWEaUL2eAe+VSdkN6vgmI8KmKJx71JYNB/pXXApYqa
         doLPQtVzWZr+bLkoVDwTsml8tmIh9WTQpf762nkBv0cEysWb3mZDeQEPxlvYAwgKpz
         G724+vEhJ0oVEdgPTeg4PAZmMqGqgwx79R+bv5fE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804101516.xtytsljxre3wheae@liuwe-devbox-debian-v2>
References: <20200804101516.xtytsljxre3wheae@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804101516.xtytsljxre3wheae@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed
X-PR-Tracked-Commit-Id: 7deff7b5b4395784b194bae3631b8333d3423938
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ab9bc5115c9a1a57ed83a143c601c31488eadd9
Message-Id: <159673439877.17279.18064274073791934714.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 17:19:58 +0000
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

The pull request you sent on Tue, 4 Aug 2020 10:15:16 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ab9bc5115c9a1a57ed83a143c601c31488eadd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
