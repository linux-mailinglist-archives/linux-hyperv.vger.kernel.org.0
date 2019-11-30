Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4291910DFC7
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Dec 2019 00:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfK3XFT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 30 Nov 2019 18:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfK3XFT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:19 -0500
Subject: Re: [GIT PULL] Hyper-V commits for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155118;
        bh=FEM+nBC20ertfEWafe8bXdM/X0IGxRCT+ScQjJOJPM4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q8Ma4bTBVb/yB+QaHv34vYDcMqDfLSI3DM/og7ZDMNUgMozrpmwi1gGoqkvb6QEDD
         Y3Sc7WWoxe1QLmIEuM1ZZJgPxgbczH/p5qFZHmmW/ZS35ZWsDrxew4COlsMKorXFvA
         qbawbTe3iiPDpheQBeSt7gzhiUCCwwmf3+GAKOg4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128152532.DAF4D2168B@mail.kernel.org>
References: <20191128152532.DAF4D2168B@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128152532.DAF4D2168B@mail.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-next-signed
X-PR-Tracked-Commit-Id: 7a1323b5dfe44a9013a2cc56ef2973034a00bf88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dd0c8f7db036b9aa61b70fa9fac423493cd5d17
Message-Id: <157515511874.27985.12481547107914799492.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 23:05:18 +0000
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 10:25:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dd0c8f7db036b9aa61b70fa9fac423493cd5d17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
