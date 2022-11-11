Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5656260C8
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiKKSDI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 13:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiKKSDF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3856A771;
        Fri, 11 Nov 2022 10:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86547B82692;
        Fri, 11 Nov 2022 18:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C55CC43143;
        Fri, 11 Nov 2022 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189781;
        bh=m8LM5Q+N5tzr+8vS/qv92DCq7+I+tHPeB+kcBN87vCA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZdZ4sLDpKOJfSixd2oKjmr7bEQt56plCl83g23nfeyHClZso0mfhQlgy7K5O98wY1
         fFVOHdBAuiPQp+GuOjrcV6AmLBiWMH0KJYlYBZZYWYxMR8OnOwVYGV0znhf6wu18bu
         vkE3y2QG6mar/vmBoRm+5A9SuOK96BIEOnvTQWIkDozg21EBiYyvRou8nH1tWfIyFF
         MACFUtZ8oSlQpk0kEp2Z4ouzuBzh5Z1EWzh9XCandRoTptvmCGI7O/EI5T1r1AYvuZ
         x6v861hvgQWF+SITuTDhOI1zbgzhd8DsPapruo7SVn8tbqlykte+UdmRlF0eVk137F
         /7dvddunm4X1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CCB1C395FE;
        Fri, 11 Nov 2022 18:03:01 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y21q/c7CywEAdiDo@liuwe-devbox-debian-v2>
References: <Y21q/c7CywEAdiDo@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y21q/c7CywEAdiDo@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20221110
X-PR-Tracked-Commit-Id: e70af8d040d2b7904dca93d942ba23fb722e21b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5be07b3fb53d14581f470745d129141b97d15614
Message-Id: <166818978117.15878.1972755711911505408.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:03:01 +0000
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

The pull request you sent on Thu, 10 Nov 2022 21:19:57 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20221110

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5be07b3fb53d14581f470745d129141b97d15614

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
