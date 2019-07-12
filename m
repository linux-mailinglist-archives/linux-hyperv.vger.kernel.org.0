Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604BE676CA
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jul 2019 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfGLXUR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Jul 2019 19:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbfGLXUR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Jul 2019 19:20:17 -0400
Subject: Re: [GIT PULL] hyper-v patches for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562973616;
        bh=5e/tLG1BsjKhvoxbS6jno/Sy7QVMNa9ymXCpGF8CbnI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IWho/AyuDSd5VQvXsWOeOpk0MGi1Ei02m0TJoFJ/D1TMgYvgzrOlWak6RjBUqrwRH
         EY3vxSUX+SgQ/kPxy/zY4T+2HJ5t5aYpcPYh1lGmtROaoVhaIJxdHAgZeC1NzVcv4q
         xfnUnmJhNfDjG026uvuJCkIBT86KW3ISzPTJD4vc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190711183218.GA10104@sasha-vm>
References: <20190711183218.GA10104@sasha-vm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711183218.GA10104@sasha-vm>
X-PR-Tracked-Remote: https://lore.kernel.org/lkml/20190709195358.25af244b@canb.auug.org.au/ .
X-PR-Tracked-Commit-Id: 765e33f5211ab620c117ff1ee0c4f38c10f7a973
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16c97650a56abdd067f7da079007b7e00b307083
Message-Id: <156297361662.22922.2125754581036814142.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 23:20:16 +0000
To:     Sasha Levin <sashal@kernel.org>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-kernel@microsoft.com
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 14:32:18 -0400:

> https://lore.kernel.org/lkml/20190709195358.25af244b@canb.auug.org.au/ .

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16c97650a56abdd067f7da079007b7e00b307083

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
