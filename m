Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76154F851A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbiDGQpR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiDGQpQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 12:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3751AE1AE;
        Thu,  7 Apr 2022 09:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A6CA60C76;
        Thu,  7 Apr 2022 16:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7581BC385A0;
        Thu,  7 Apr 2022 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649349792;
        bh=a266PekklTC2Eu8Vl/iZdDHr+C+o/zghnzCuVrxEuI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L0hI+mMotdmuXweWRkJbgxRmU8icvo1IYRXQvmXENHeUMsuHeysryAjLOjQLbfZsh
         qNufiirbl4W+Vi5OzPPeidPDY9430rxqXTJSJqI0+17OB1LTlJNSdxjbgjuSthVH3B
         CXfzhEgTfjNEKVfAPF+x9vIfr8WYENeGKs1L9bzbWRKuuuh32lPlE+jrEnNCA9517y
         d0KkYTXZQhNug0RYFTmDYR/Z6hFY7yPNarKxcoN+5ladf9xXZL5t2chsjZphULBUCP
         MwtAKFbRHsGU8xrXb1WN8pA7R1dBeBoJzH58oRMqSmgZ9NLscl6YPFg7b/nsTzjWj1
         qHf8Oz17fdOFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AF16E8DD18;
        Thu,  7 Apr 2022 16:43:12 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220407145351.n5nnpcp4rqusrqnh@liuwe-devbox-debian-v2>
References: <20220407145351.n5nnpcp4rqusrqnh@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220407145351.n5nnpcp4rqusrqnh@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220407
X-PR-Tracked-Commit-Id: eaa03d34535872d29004cb5cf77dc9dec1ba9a25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42e7a03d3badebd4e70aea5362d6914dfc7c220b
Message-Id: <164934979217.4180.6246520562938858652.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Apr 2022 16:43:12 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Thu, 7 Apr 2022 14:53:51 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220407

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42e7a03d3badebd4e70aea5362d6914dfc7c220b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
