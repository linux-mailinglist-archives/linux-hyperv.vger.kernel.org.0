Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA04C21146D
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2020 22:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgGAUaK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Jul 2020 16:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgGAUaJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Jul 2020 16:30:09 -0400
Subject: Re: [GIT PULL] Hyper-V fixes for 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593635409;
        bh=u3FKsCqugYWXHKHrtra0Rp85HDVEGDHNUweEPevDvaw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u7Y/+01XvDa9rJ5atsT+OwYbjOPoqEBUz1olStUpcbacpGvBuWpJdUwPq6CobfvVU
         7emAWcDMZ5iW9e8/9Ty7pvy7RTnboskQW9yDqAqJQ5b06AF+yWfjLw8Vg18pQ3CkmP
         DSt/Qv+eFkCnbLqR3nt6nBZAngCeyW4c3uFdOdHQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200701182855.l5xdgglmctv3otvb@liuwe-devbox-debian-v2>
References: <20200701182855.l5xdgglmctv3otvb@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200701182855.l5xdgglmctv3otvb@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: 77b48bea2fee47c15a835f6725dd8df0bc38375a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd77006e01b3198c75fb7819b3d0ff89709539bb
Message-Id: <159363540943.27033.4409656844682147101.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jul 2020 20:30:09 +0000
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

The pull request you sent on Wed, 1 Jul 2020 18:28:55 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd77006e01b3198c75fb7819b3d0ff89709539bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
