Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535B85B63CC
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Sep 2022 00:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiILWmL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Sep 2022 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiILWmK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Sep 2022 18:42:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE79402D1;
        Mon, 12 Sep 2022 15:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 760ADB80E00;
        Mon, 12 Sep 2022 22:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28567C433D6;
        Mon, 12 Sep 2022 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663022527;
        bh=SqNE7ZCLF7o+gpUAaG6L1c6OlJKhN/9eqQwPlUMIWgk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NxAfJCe7jZ2CDkTBzDeUc937ahUv96+iHYECrwYBBv9ykIsQdh1U3WbULMpn7E0tA
         LpJeBWc8LKvEmkIGhWX3DQFdR3bo6K+KGVAEO4eSeYc2FH9sW4Wov/tne5l0sjlCuB
         aYvficsyMk6RmqsCPxwPIy1Pd+bOoVKrdCaS/skQoRhSQkRlgH4ep5VQI2LHOU/YdP
         6wsn8hwFRJnhw8tvcH4nHBBCpQJLfBrr5vjApiNQUCcBfR8FxqxBNIt/24lWWkZkWz
         8nBLfdKJdrqg9leqHhFQ6ebM5zUE24Ekv5nsNVmtZGGr2Wb2M6ZjioDZeQdPiDXJNO
         3xn0kW0ds78Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CA93C73FE5;
        Mon, 12 Sep 2022 22:42:07 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yx+vEggYHHyBdb5r@liuwe-devbox-debian-v2>
References: <Yx+vEggYHHyBdb5r@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yx+vEggYHHyBdb5r@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220912
X-PR-Tracked-Commit-Id: f0880e2cb7e1f8039a048fdd01ce45ab77247221
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e839a756012b6cad7a4eeb67b0598ac3f349f863
Message-Id: <166302252702.25412.14039653395008305231.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Sep 2022 22:42:07 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, sthemmin@microsoft.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Mon, 12 Sep 2022 22:13:38 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220912

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e839a756012b6cad7a4eeb67b0598ac3f349f863

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
