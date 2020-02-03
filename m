Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB615098F
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgBCPPP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 10:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgBCPPP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 10:15:15 -0500
Subject: Re: [GIT PULL] Hyper-V commits for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580742915;
        bh=akO6zxzTYa31r9tgyQw1xYMcFayqbVeA9ogxk9shhl8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PJnUijxlEHn/POU8nGNEp25CmOIqQreU44NT2grDDoIjT3rCrzCy2PYGoKF2v9kod
         6yDrWBhmbAtFQ9AoEd+KDZFplfKZMsmSh4K7e2AukigFiIaBIWEEFegXgFj0Dja7G7
         eOnNaDLYwznsn9GoB/8AZg7zz7GihC5CjvjR6nqA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203022747.7473A205F4@mail.kernel.org>
References: <20200203022747.7473A205F4@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203022747.7473A205F4@mail.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-next-signed
X-PR-Tracked-Commit-Id: 54e19d34011fea26d39aa74781131de0ce642a01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0fa9250317ff6e92a1397ebf7cf4d83014f38a6
Message-Id: <158074291518.25778.8185482567151622892.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 15:15:15 +0000
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Sun, 02 Feb 2020 21:27:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0fa9250317ff6e92a1397ebf7cf4d83014f38a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
