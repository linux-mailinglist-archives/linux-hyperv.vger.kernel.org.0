Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86DE73608B
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 02:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjFTAOp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 20:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFTAOp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 20:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9469DC0;
        Mon, 19 Jun 2023 17:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E2B60C96;
        Tue, 20 Jun 2023 00:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88756C433C8;
        Tue, 20 Jun 2023 00:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687220083;
        bh=VKGVZJgA7H3tlazewHNWf8ivXmAhAf6xrH2yjMpSZ+A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mqMP4CDZegZPZAF2M+595/r3PMOK6xtjLAVz7NT+uUh7XOiUAnWhvEFQ7T82F8Rpc
         I7ZPQcK3Neaxdspp+WBT/z1pWzqBdZifnDbUQxuNjVynpEVrGIUPuJ8mohmPe0dM7s
         K4ltCzk13GdUUXx7N4i7/VmVfdFi/14vw0ZIshLJopoIW0GqujQ0w1qCTS9acuHbLz
         HNPgqNjPiZRLwV8I0blsiyoHZDsYzlCqnY/jgmZHYUWAFTBbEm7c/tzmXj+6QbfnTn
         hwK46VT1oTD2iHEiZbLzmki9C8GHcDp0EwVPKwXOZpEsa2AJjJdnm1IGEKlUliiioN
         c+9EKOgAZPVPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70A72C43168;
        Tue, 20 Jun 2023 00:14:43 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.4-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJDihKX5BT38Rkab@liuwe-devbox-debian-v2>
References: <ZJDihKX5BT38Rkab@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJDihKX5BT38Rkab@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230619
X-PR-Tracked-Commit-Id: 067d6ec7ed5b49380688e06c1e5f883a71bef4fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 692b7dc87ca6d55ab254f8259e6f970171dc9d01
Message-Id: <168722008344.2104.2174728263963004951.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Jun 2023 00:14:43 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Mon, 19 Jun 2023 23:19:32 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230619

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/692b7dc87ca6d55ab254f8259e6f970171dc9d01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
