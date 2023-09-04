Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA4791D64
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 20:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjIDSsj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 14:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjIDSsi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 14:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D318B;
        Mon,  4 Sep 2023 11:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A80619B3;
        Mon,  4 Sep 2023 18:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8448C433C8;
        Mon,  4 Sep 2023 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693853314;
        bh=2MeB46xR/6lOxGvnUHQEGmJ0bMawlKXRhmOsQjp9Zw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G+aMb5s2XKEjRtElFHYUQtrORtqcZN4xJ56gz8BPsXEwp+NKNssnbrR4ZHSS61N9I
         WP2FieBNTHGjvD+oyOTCbikizvDsoHRVTRBtzmZT313m2NXMbwGIj8VOufXKeqv67J
         JHx2VjKIN9IR4scsOZO151qfOImc/1P4HtWa8WcazTZ8FBLBCGthl2kAsVYtZ31NKn
         NXl4x/c/NUg1QI2jmi4iUSofIgozcuqePKv7ad6puMuIQJtNm/7cDAuFgiCbNjMNIv
         qu0drG8P/LzCFU0u9Q6RoRI9FG6ITksa9542aP4G8RlxnrmbL1FWZN5IFozSCpy64s
         07SFr81Ed1Xnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBEBBC04DD9;
        Mon,  4 Sep 2023 18:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPQTFyfzgvlp3QkW@liuwe-devbox-debian-v2>
References: <ZPQTFyfzgvlp3QkW@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPQTFyfzgvlp3QkW@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230902
X-PR-Tracked-Commit-Id: 284930a0146ade1ce0250a1d3bae7a675af4bb3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b90c5637dfea8a08f87db5dd16000eb679013a3
Message-Id: <169385331474.21931.113767991083910756.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 18:48:34 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Sun, 3 Sep 2023 05:01:11 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230902

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b90c5637dfea8a08f87db5dd16000eb679013a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
