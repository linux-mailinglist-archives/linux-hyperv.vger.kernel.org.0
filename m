Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928D96F0F9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Apr 2023 02:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344675AbjD1Abg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Apr 2023 20:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344653AbjD1Abc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA23A82;
        Thu, 27 Apr 2023 17:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517C8640A1;
        Fri, 28 Apr 2023 00:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F52C433A0;
        Fri, 28 Apr 2023 00:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682641890;
        bh=HQHFeIJ0xoU1gjH7X5J0QT50oI2QKyqb2PIz284TPvE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hPJEsxD3w4HdDi903pKDmLZwFWfIFoAneoMY5SWvf7sef3aXcnVM+4ooz8ymehpnG
         /Wk3Ah6NQCqbouR+/BPAiZmmeEpA+Eyoxtsjo8dBNQmhCcUQWGiRw6n0Iilb4ekWmH
         ZBNF4yFIQTUcQK6PiTK0JAI7G0hfTU5lxi267MGrG1O27/FAtTmTVVkTwLlU/1WJSr
         qATgGWTwppshAUMlcbywTCHTRb6qWyX7zgHrmqzAtdw6UKDt20WwJyDvN09PimGuaA
         7a2nfKmQ/sOKGei79EaFJYPHpbGfDpj2tlX0CocRTm3R20YYiUxK9/tAqulUkU/1rN
         923ir93dGdB2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5036E5FFC8;
        Fri, 28 Apr 2023 00:31:30 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEcpgwRj8kDvjfSK@liuwe-devbox-debian-v2>
References: <ZEcpgwRj8kDvjfSK@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEcpgwRj8kDvjfSK@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230424
X-PR-Tracked-Commit-Id: a494aef23dfc732945cb42e22246a5c31174e4a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da46b58ff884146f6153064f18d276806f3c114c
Message-Id: <168264189067.7031.4346397360291482410.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:31:30 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 01:14:43 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230424

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da46b58ff884146f6153064f18d276806f3c114c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
