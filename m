Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54558CCCF
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbiHHRkI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbiHHRkG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 13:40:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A45D175A3;
        Mon,  8 Aug 2022 10:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33823B81034;
        Mon,  8 Aug 2022 17:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0F82C433C1;
        Mon,  8 Aug 2022 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659980403;
        bh=ZiyMce+HmPzQbMEKleA07B/gt6XYTFjrIkvunG1psfE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gavaLQgV4qiuTctu2Cg3kIPbljsIXw5ak4cSF3Ve55gcPLNqq4FtxjgEhW7L+Sv6G
         zppj+4CPRnjQCF5jkD3MhFwdqR84rgUPDQsgYVc5XfJ3akX25pViUW69sYtd4y5MOW
         4oSpIi8CbEKq2yewLsOsezxfIQke+4zkrQiA28LNFrKVPfWssSExDHa8jfvpa7majq
         rRMzdXgrNIUnar/huCtih5373wr+5qgzjXQJi9WgqQqLI8OOBmkeR3Ks9hZrcOGOS8
         b75duMLMMkldhlWfFKt8AGvWfMGqp3lR+BWPduY/IOvxpVyJNQjJ+sYeNNBIxJVSo9
         mFxBetKYAtBkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3F00C43140;
        Mon,  8 Aug 2022 17:40:02 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next patches
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220807204433.k4lcpmfbradclnnq@liuwe-devbox-debian-v2>
References: <20220807204433.k4lcpmfbradclnnq@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220807204433.k4lcpmfbradclnnq@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220807
X-PR-Tracked-Commit-Id: d180e0a1be6cea2b7436fadbd1c96aecdf3c46c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df7a456e7d1d7511b2c373dc1099cecfea093858
Message-Id: <165998040283.21911.6675000001362296677.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 17:40:02 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Sun, 7 Aug 2022 20:44:33 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220807

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df7a456e7d1d7511b2c373dc1099cecfea093858

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
