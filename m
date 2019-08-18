Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD38D91431
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Aug 2019 04:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfHRCuH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 17 Aug 2019 22:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfHRCuG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 17 Aug 2019 22:50:06 -0400
Subject: Re: [GIT PULL] Hyper-V fixes for v5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566096606;
        bh=i4LUhpGZg/nhL+4fU6f9c8ytUZEy89m/wzUvRwQu/f4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TN9qTND5piDGpriH1slcaTV4DnkxFiqIJ36TGdijQS0C42ZWlQE1gu0f2hcK7maZn
         GESg1Vbt+QEgXKMX8VSCX8ykOR8rSh+d5caVaWNvmcFrG3/xH2i35n7FsOKefo3Dgj
         /AnUP1DTrmegF68YXUGULvQTqRkt/NVCr0eHQYxE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190817195936.999002075E@mail.kernel.org>
References: <20190817195936.999002075E@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190817195936.999002075E@mail.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: bafe1e79e05de725e26b3f60c90b49e635b686b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85d8d3b172eb37b23dcdbe9fa7a85e343642bfea
Message-Id: <156609660610.32044.8400289595566004669.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 02:50:06 +0000
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@microsoft.com
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Sat, 17 Aug 2019 15:59:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85d8d3b172eb37b23dcdbe9fa7a85e343642bfea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
