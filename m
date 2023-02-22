Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8469EC6A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Feb 2023 02:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBVBnH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Feb 2023 20:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjBVBnH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Feb 2023 20:43:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600A9ED5;
        Tue, 21 Feb 2023 17:43:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD313B811A6;
        Wed, 22 Feb 2023 01:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90834C433EF;
        Wed, 22 Feb 2023 01:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677030183;
        bh=emHb+LpcjGiTOP4Gx/w+ZwOGTnqIbGoQsywiq1pZwWc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LSu/iTWOIAMpgQMrkiMojaZuglTbH7A2zChl3jhg7Tn5JTxhay9sSrvZbnuUsJ02w
         GZgcapD9cDKx8l+qgDq0G68dn2Uf9Wdx3LgqVBbnP/hB8QedebgPhEgC7p7J0SX9nm
         GTYKgyJuWzDX9rziDcqQ6RtPAbrFvwGPalTSiZ3Cfj8R9wWJOCS4i+OwmDJ6aVMFgm
         gD80Y/yjSP2PbsnT9BMZ6DFNio4OZyAXrlphvquscfLOO4E+uGOeH+Eur9m3EcGnn9
         C+IX3BtEghO+HszQcusGmdjizLCysbKGWPWE7z7UZJ1wDHu1dSFCVm6rneXAMaDMmp
         wTqwj7cQCvipg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D311C43158;
        Wed, 22 Feb 2023 01:43:03 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/OCT7A/7GHNxgX4@liuwe-devbox-debian-v2>
References: <Y/OCT7A/7GHNxgX4@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/OCT7A/7GHNxgX4@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230220
X-PR-Tracked-Commit-Id: b14033a3e6ba73a5c68974a80b05cba55553ed5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8878e5a5c62a16ad491ba664a9c1efff62e9a99
Message-Id: <167703018342.10177.1248592221266500878.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 01:43:03 +0000
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

The pull request you sent on Mon, 20 Feb 2023 14:23:11 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230220

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8878e5a5c62a16ad491ba664a9c1efff62e9a99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
