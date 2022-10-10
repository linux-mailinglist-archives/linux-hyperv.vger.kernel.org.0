Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0975FA6EA
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Oct 2022 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJJVXv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Oct 2022 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJJVXu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Oct 2022 17:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3476BD7E;
        Mon, 10 Oct 2022 14:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740B26101F;
        Mon, 10 Oct 2022 21:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8C35C433C1;
        Mon, 10 Oct 2022 21:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665437025;
        bh=Qds/az0JsA4Cni+rqkjFnWh2cVo6hS9iubDz96Ut6QE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kfDr2knCi1hRXY0VisZHsA7JAozGkiV83uYVYQwA6TTPBTXIij7Kjt6Yv412Kv+zj
         G3BvxpLayuW12iBjpCHuhf56ozF7LJ+oOWsYlrL3PDgshSRuytXFBjirDloD36ytjh
         9+YMI5hhqeIY0XmVuksIt9xA1zE5zPE7WG4bHIGqRPPTFr1tDpWwxsM/s+3d0ahDjZ
         5qNu8z3pGCKe96LFc7cB+w8tGPOigrkw2u25Sr/nXQ+LpHnCsgp6hnjUbBrqDu32sS
         /kfF2Ajwfaolnw1xLrLjh11hNPTPaPsHUEZVkLwUSjzyfuItEegUMH1oMRm992uI63
         j5lxs3IzClFuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1E67E2A05F;
        Mon, 10 Oct 2022 21:23:45 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0MygRaW4C+Sy2XS@liuwe-devbox-debian-v2>
References: <Y0MygRaW4C+Sy2XS@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0MygRaW4C+Sy2XS@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20221009
X-PR-Tracked-Commit-Id: 154fb14df7a3c81dea82eca7c0c46590f5ffc3d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e0073eb1b60f4ec6faecea034a6772fe1409a88
Message-Id: <166543702578.28157.6574303033160109411.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 21:23:45 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Sun, 9 Oct 2022 20:43:45 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20221009

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e0073eb1b60f4ec6faecea034a6772fe1409a88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
