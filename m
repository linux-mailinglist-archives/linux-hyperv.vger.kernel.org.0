Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3343764A67B
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Dec 2022 19:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiLLSIc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Dec 2022 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiLLSIF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA5E1649A;
        Mon, 12 Dec 2022 10:07:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7E960FD8;
        Mon, 12 Dec 2022 18:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3963C433D2;
        Mon, 12 Dec 2022 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670868445;
        bh=ggUI4Lpwf9G45ek6KFw16Grsbpw7Nnbz/co2f1zrHnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HRGVauge9EDaUivo2wJMjC2OeeTVtlav6ai1KILuHUpfdqD/dmpFEN7qfX29pmvLm
         6cbv8tla/tEeZlfsdMjQqQmBkwzxkNU4iZvz8JST9iAgl45OCSno/7HiNHuswwCNZe
         NpMTjjNN4iSM048Ff1nhlUGvQLb3qYwwDcTIfTHpasIULsYdKizFoHDGDqJ6HXsyEE
         S4Z+JSDmhMLWR5NBQ2OTXkXHCkpErk11psoi/dLG5ri1BmAQfAcoIkUf3L7vVokyOZ
         OkbPXVOCHJpp4oiPrbj6XFcBwiUjPjbZ7Z7MtKk3mswOW+/DKCgVU+IT5uGyqsUMIL
         0+D/rnt2IAwzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAF31C00448;
        Mon, 12 Dec 2022 18:07:25 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5HQvdUqsJeC69X8@liuwe-devbox-debian-v2>
References: <Y5HQvdUqsJeC69X8@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5HQvdUqsJeC69X8@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20221208
X-PR-Tracked-Commit-Id: 32c97d980e2eef25465d453f2956a9ca68926a3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d62159919c90fbcd9ee808e9f1b776eae990d53
Message-Id: <167086844569.13437.11758777662185316340.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 18:07:25 +0000
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

The pull request you sent on Thu, 8 Dec 2022 11:55:41 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20221208

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d62159919c90fbcd9ee808e9f1b776eae990d53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
