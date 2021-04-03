Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6272B35352C
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Apr 2021 20:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhDCSSo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 3 Apr 2021 14:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236397AbhDCSSn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 743906124C;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617473920;
        bh=nWwSp0+o/gzk9BtBj+7lGolbkLFnsr+EfXfNj3lDqVU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FQ26KWO3DGVK0FTlUjhEmK37CcnluimIzUAYAXdHb1BpnACSufc+oIHrEa4wtYSpG
         S9CpwF7RncBkLajwiX4xqKDS7ERphiOoxiMUQiq+vXCoTwHB4R9LIrEl2wY9dhYE3J
         JU6uoawyZt4LzCjHJlLVMjh1el4E8oY+Ro3vkYR4kppAJIX+wjaW/OO8VHgdVp91IW
         7LVMZEbGaCoszOoDT5Pvm4Rz8GLkPpI3G+8/iIQxnnDEA/tHzd5DAQFav5ToEl1PnI
         M3y1WbrusJPljaQtXr3cmUbQJHd2Cw3IgYNh3YlNUR/HiQQye5hBplD0ZTM8etWxSm
         y9PsAzLCZrm5g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6BAF860075;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210402215533.56z6kk56s6wxannw@liuwe-devbox-debian-v2>
References: <20210402215533.56z6kk56s6wxannw@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210402215533.56z6kk56s6wxannw@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210402
X-PR-Tracked-Commit-Id: 37df9f3fedb6aeaff5564145e8162aab912c9284
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa16199500c8863da145870f01d61617d967b6c3
Message-Id: <161747392043.13474.15297761635305854325.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 18:18:40 +0000
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

The pull request you sent on Fri, 2 Apr 2021 21:55:33 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210402

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa16199500c8863da145870f01d61617d967b6c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
