Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D34B7743
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Feb 2022 21:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiBORSn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Feb 2022 12:18:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbiBORSm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Feb 2022 12:18:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE732140B4;
        Tue, 15 Feb 2022 09:18:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A3D7B8124E;
        Tue, 15 Feb 2022 17:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32A54C340EB;
        Tue, 15 Feb 2022 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644945510;
        bh=lVGrmNhBk5rjjDXvPYoQi8Mcajocy+3I5SzCCdBVJeg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hje5XWV0tlgUvuNMH/a3Pfr372uvVZRhTEjdxkPaSw+Lb4ow6FHiEjfH1+59IUbE6
         CMd2OZaJuMyOH/5D0GXx+2InayxbKiDNl9MesseDmGo/QAPK1XExu5fGGKgZL3DQzl
         b81238uiVEx3NvQ0saHOilyNzipj9HZFCkLEz5HAtXq+00RsOaPEwmpAhkOyNXD0F8
         hWWcdSGD7DzfqZFJnilmWAeIIJatjzheudWp06/zUn6o5UWYhC9qDJcK1dtH5uynls
         iAcDfHoxV6OC/tE1fYI6Bk4q5+Rvgh9iy2IPUqXbP6+iu/1+Eri4AHtxodAm1WKieD
         unD4kuR2k47Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E198E6BBD2;
        Tue, 15 Feb 2022 17:18:30 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220215113738.mewd4wwbw6defcuj@liuwe-devbox-debian-v2>
References: <20220215113738.mewd4wwbw6defcuj@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220215113738.mewd4wwbw6defcuj@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220215
X-PR-Tracked-Commit-Id: ffc58bc4af9365d4eea72526bb3cf6a83615c673
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c24449b321095d8c80cdda3d68107269c1d5569f
Message-Id: <164494551011.28256.4563406145359283570.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Feb 2022 17:18:30 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 15 Feb 2022 11:37:38 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220215

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c24449b321095d8c80cdda3d68107269c1d5569f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
