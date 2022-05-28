Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7629C536E1B
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 May 2022 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiE1S4H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 May 2022 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiE1S4G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 May 2022 14:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1E50B32;
        Sat, 28 May 2022 11:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9957160DF6;
        Sat, 28 May 2022 18:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02810C34118;
        Sat, 28 May 2022 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653763411;
        bh=TBFfBotOezaoBQQcGf+0AQ0cSsdjrTCn0ywW+8wNTHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bgCPg6dsoVMJnEjU1AZF8jnJoqWQk+YmTUW+zXZfJDQxakyV/wHok2fqrVnJo7b6D
         PlDTJs8xWO4z/isjtlpEEewdOut6F+9SqQ35kEf64gHHNh7LkKtPTqQzjfNTBQmf4y
         d3NPZOAtJ5z2GMIkIJ7QhApZJ6q5WrtwB9LPMG3JrqNBzjFAvRluq//dO8X8L2nwsQ
         pReVfxiRyDtyaeFC/PuabblGL/O7p/Q6IkQcHiG6qhvB2OYUrwDA1PM5C21CwfAtqY
         yoTrlm+BYfDijkNrTVYI1RL6b68E4SCNd71xvUCySxJ/OAIrGwKl2ATYL8ht5LRwhs
         45Q7GKsouW0mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9E11F03944;
        Sat, 28 May 2022 18:43:30 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220528163001.43ripr5agsesyq7o@liuwe-devbox-debian-v2>
References: <20220528163001.43ripr5agsesyq7o@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220528163001.43ripr5agsesyq7o@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220528
X-PR-Tracked-Commit-Id: d27423bf048dcb5e15f04286d001c66685e30c29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f56dbdda4322d33d485f3d30f3aabba71de9098c
Message-Id: <165376341075.28289.7698327766130070455.pr-tracker-bot@kernel.org>
Date:   Sat, 28 May 2022 18:43:30 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Sat, 28 May 2022 16:30:01 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220528

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f56dbdda4322d33d485f3d30f3aabba71de9098c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
