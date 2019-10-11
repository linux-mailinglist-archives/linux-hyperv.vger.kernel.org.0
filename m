Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D42D46EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Oct 2019 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfJKRuH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Oct 2019 13:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbfJKRuG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Oct 2019 13:50:06 -0400
Subject: Re: [GIT PULL] Hyper-V commits for v5.4-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570816206;
        bh=TScF5Enw8y29nxbqKbzVNfhmhUbqAYlxbTflATRRKdE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c1fGTldIJje0g6x+w3GxZnvBB5AHlqpVpIptg5IZ9dHbPfZVyfDUlhP+2TbPXO0Ae
         OW9PwAFLm5bseNXjFxW/ieKmn+gcqhJCgdyJypL1HeK6skzh/HSQgcbN0uEwf6T4Cz
         cWXwlV1pfATR3TgkWEdeH0k6AREZ+eIA2jJp76YY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191011150106.44699206CD@mail.kernel.org>
References: <20191011150106.44699206CD@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191011150106.44699206CD@mail.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: 83b50f83a96899f30c6369ef5988412fa2354ab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56c642e2aa1c3be3e51e136eace6502aca8116ab
Message-Id: <157081620625.1160.10292156664410555727.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Oct 2019 17:50:06 +0000
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Fri, 11 Oct 2019 11:01:05 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56c642e2aa1c3be3e51e136eace6502aca8116ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
