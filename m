Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F32BD327
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2019 21:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfIXTzZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Sep 2019 15:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfIXTzY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Sep 2019 15:55:24 -0400
Subject: Re: [GIT PULL] Hyper-V commits for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569354924;
        bh=+Z/x/3W0z7XYglP8yRga3IjIoBy5/zKhrTcfFLenmFg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q8w3MgqPfW5Ybzks+aSAIrmltpwJHucdXyk3+R4mfYDwZKlOJQ0R04l65bmcS/f1W
         v3IYKoyrCGVQzAQCZW/VzwnOdk1AkZ1tQujHKomZdCcwmQ+ZKuugVY0oORFge2kFsT
         4vKJbKMKNchJOerXAyxzXOypzG6u/50WAwZt0Gqs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190924010311.C941520820@mail.kernel.org>
References: <20190924010311.C941520820@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190924010311.C941520820@mail.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-next-signed
X-PR-Tracked-Commit-Id: d8bd2d442bb2688b428ac7164e5dc6d95d4fa65b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af5a7e99cce2a24e98487e70f99c8716643cc445
Message-Id: <156935492426.15821.8493325600368694254.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 19:55:24 +0000
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@microsoft.com
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Mon, 23 Sep 2019 21:03:10 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af5a7e99cce2a24e98487e70f99c8716643cc445

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
