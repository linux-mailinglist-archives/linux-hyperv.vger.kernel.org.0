Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF89BF59
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2019 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfHXSpK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Aug 2019 14:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbfHXSpJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Aug 2019 14:45:09 -0400
Subject: Re: [GIT PULL] Hyper-V commits for v5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566672308;
        bh=UOSlRmEptJkj0Waa6NENDDkwnv9qgN1PFyh68/zOBZg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wBFVViDGmwBP5EOMjrNyJ7vqlJdQQDbqPfstUqmkxYQI7xvH0ZDDLjgesRW0PCyDU
         JqfuQQpHaLGnhrqzdHIGkpKrNRa2uMRf/ZW/c4LZDRan+XJN4R6lKsebIXY3OCWeKz
         I4kNDh7NuM7qdVW3WcWZPDjpyOIGisbKnM/xkbQ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190824173935.63A412146E@mail.kernel.org>
References: <20190824173935.63A412146E@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190824173935.63A412146E@mail.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: a9fc4340aee041dd186d1fb8f1b5d1e9caf28212
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 361469211f876e67d7ca3d3d29e6d1c3e313d0f1
Message-Id: <156667230845.2337.4059356004364464694.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Aug 2019 18:45:08 +0000
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@microsoft.com
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Sat, 24 Aug 2019 10:59:21 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/361469211f876e67d7ca3d3d29e6d1c3e313d0f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
