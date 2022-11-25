Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D016390D3
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Nov 2022 21:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKYUsk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Nov 2022 15:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKYUsj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Nov 2022 15:48:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3B27147;
        Fri, 25 Nov 2022 12:48:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CE609CE2F83;
        Fri, 25 Nov 2022 20:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18F39C433B5;
        Fri, 25 Nov 2022 20:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669409315;
        bh=VrGRJPa77jCgGAXGBK0bZGE+gDnSMTZIkkngFTx23IY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H3NG2e/xc4cng23AhtUL5MnYMa0A94hU6pszdefe7z9W6IuaA126WSyuL8pprUDkT
         WvPDFsfaQ2WB6gWZ4ygAK3nZ1wgzF3SY458T+D2V8yXWv9VGhMD85Q/FUZ/IBFy5kd
         f+Gqw0lIpzU8XQKz66WR9S4NrQ7NxAijdGJE0CSMxmznuxAZ451XqdQJ3bh+mruTpJ
         1GqKPg6ZZY9z/alOgUPCDifYKHZcUPtv3r5QeYtV5rXEvSgx9zy4WlueMpXvFMpipG
         elH4yS1FY0uHB6dX+eqk52IZ8EWgWs0pD++05BetPtl2rnXGtegSaib8f/T/NEPUAk
         Gg0/iwdGentuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00071E270C7;
        Fri, 25 Nov 2022 20:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4DaBH/mNVLQ2XhF@liuwe-devbox-debian-v2>
References: <Y4DaBH/mNVLQ2XhF@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4DaBH/mNVLQ2XhF@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20221125
X-PR-Tracked-Commit-Id: 25c94b051592c010abe92c85b0485f1faedc83f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 081f359ef5334b0e034979e4e930c2ce80f3001b
Message-Id: <166940931499.23524.6574324097048357294.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 20:48:34 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Fri, 25 Nov 2022 15:06:44 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20221125

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/081f359ef5334b0e034979e4e930c2ce80f3001b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
