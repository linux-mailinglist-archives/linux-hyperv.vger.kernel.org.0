Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69954FD74
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jun 2022 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiFQTW2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jun 2022 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbiFQTWZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jun 2022 15:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D85496BE;
        Fri, 17 Jun 2022 12:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A564661FB9;
        Fri, 17 Jun 2022 19:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14C3AC3411B;
        Fri, 17 Jun 2022 19:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655493744;
        bh=iVotz9vyiBHH6A25eUIT9pn8WnYyoI1mOWJ9aVDfw5E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tlM46kwWScFXymM85qg5mUiCMvb+DE9OxPV9RXYxdRNBiJqihT2KMPfqp7wwkn2za
         kysEDK0yplyx5auQFWkuiaJH2AZxIzQfsg4A0jeIp1juKlODxnz/7qCvfbzWpLsA8l
         OzqKnTjRo4QBhzIuPHtG6IdEgpymdudBvDgfigHwRUQisseAu3ghpNyPlIg8FtyUEb
         m/0EJ1Wv+n2+M230xoOMykQCQ79vAchDzd6a9isqKCWT83WK8ySaeBA7qmgNbdJc8W
         E6rBo30wNNboPfzAMfYrsU0GI27vJEljoTQmJD5C56U5Tdx7MoobXbkjp7BCOEwaje
         UTCjHpRQuxM5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F00A9E6D466;
        Fri, 17 Jun 2022 19:22:23 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220617142232.urp25kc2oi3yorqw@liuwe-devbox-debian-v2>
References: <20220617142232.urp25kc2oi3yorqw@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220617142232.urp25kc2oi3yorqw@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220617
X-PR-Tracked-Commit-Id: 49d6a3c062a1026a5ba957c46f3603c372288ab6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d806a688f98a36792e108ca8583712ee235f815
Message-Id: <165549374397.16480.17217502075807953903.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 19:22:23 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
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

The pull request you sent on Fri, 17 Jun 2022 14:22:32 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220617

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d806a688f98a36792e108ca8583712ee235f815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
