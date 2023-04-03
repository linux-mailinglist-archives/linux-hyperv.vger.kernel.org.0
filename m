Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8276D4E63
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Apr 2023 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjDCQvZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Apr 2023 12:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjDCQvY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Apr 2023 12:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71FF1FEE
        for <linux-hyperv@vger.kernel.org>; Mon,  3 Apr 2023 09:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5235561E92
        for <linux-hyperv@vger.kernel.org>; Mon,  3 Apr 2023 16:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB103C433D2;
        Mon,  3 Apr 2023 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680540682;
        bh=X466J82bosm0PTvTRy54TG10laJkUJzHUhFyQJOb+G4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Np82OrdpTH2TWO6pbevXeWEnvNetAlk2YgdX1OezeWTROpZOBMSDl7V+Qzt89tgvC
         7HnNMFgqx3gObxcbWI5+IwPlrCEGj0mul8WMxmzJ8m5LLcS/BQH1OrqA7EvphVZRjP
         fNxvPQ5onfryZDn+7C5ahJjqUfMx+2W23C+ESOzWqz04gl2hif4NxCKUwYp3ViRzcP
         yAABO/mYGIgYZFM2lqx5OS4Oxo2TCWEp6RBcCQAXYliIJdiNV/aehYUyWXRY7RRrIW
         IHcbRMoNETtWfzrkRaNHjsUiMwUVWuSHhLBrdCaDTCZ3L3TSZGl1mtYh57GUXtKSvV
         Q1SORMv052+gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3720C41670;
        Mon,  3 Apr 2023 16:51:22 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCoyGafhIVqHpekW@liuwe-devbox-debian-v2>
References: <ZCoyGafhIVqHpekW@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZCoyGafhIVqHpekW@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230402
X-PR-Tracked-Commit-Id: f8acb24aaf89fc46cd953229462ea8abe31b395f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d72ab2449fa9fce8f6898fd5adda10497f7c111
Message-Id: <168054068266.29791.14665758865591628259.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Apr 2023 16:51:22 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Mon, 3 Apr 2023 01:55:37 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230402

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d72ab2449fa9fce8f6898fd5adda10497f7c111

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
