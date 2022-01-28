Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB549FFA2
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 18:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350463AbiA1RgG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 12:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350424AbiA1RgE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 12:36:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF2C061714;
        Fri, 28 Jan 2022 09:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F01FB82693;
        Fri, 28 Jan 2022 17:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7B4AC340E0;
        Fri, 28 Jan 2022 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643391358;
        bh=DIOeOC3m4WJ7hAsqVUfReYe+UFR/zfAGlTQCKjLIhPM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ccR6VKoAFzN65e0FJA/0AYqe9jYE9fczloLZMXAVWiiwG11JlggOqdoX+Oe9oe7Ez
         AaI+39mv/yZu6LF0wPXvi0RqDerTg8EbW8GEX1z8e5q2t2HjMa2SeaunZRWCElF4W4
         E6SlJOKe0GMDuYxg73/k9fQ5k8TZpF7+sd4WMznXP7iHzeH4EihAj/LPWgsoiZZ0qu
         RcoKfF5vGMBqRD6KDESb5KvdIextdiv/KlGa8btvTkxYwe/Qu50hbZeIJEXKAkDdmn
         9Lz2YtMl2Qdlt9zmDnp0k/CrtjTQ3QhCt7u2cOtMdMyo5ehS5v2W2eyqWHLdmSpqNP
         Vmg9Vhf7Y0upA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5DB0F6079F;
        Fri, 28 Jan 2022 17:35:58 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128160344.ihcyofyvxvgwq2r4@liuwe-devbox-debian-v2>
References: <20220128160344.ihcyofyvxvgwq2r4@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128160344.ihcyofyvxvgwq2r4@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220128
X-PR-Tracked-Commit-Id: 9ff5549b1d1d3c3a9d71220d44bd246586160f1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56a14c69ae5e0a1661e4b54ebf2fbf6e7410a9ec
Message-Id: <164339135880.16649.4971394175432730234.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 17:35:58 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 16:03:44 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220128

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56a14c69ae5e0a1661e4b54ebf2fbf6e7410a9ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
