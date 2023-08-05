Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE374770CA1
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Aug 2023 02:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjHEAUA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Aug 2023 20:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjHEAUA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Aug 2023 20:20:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A974EF3
        for <linux-hyperv@vger.kernel.org>; Fri,  4 Aug 2023 17:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8C360AEE
        for <linux-hyperv@vger.kernel.org>; Sat,  5 Aug 2023 00:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FAD3C433C7;
        Sat,  5 Aug 2023 00:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691194794;
        bh=yRJltqmaPMjcn8rvi5Yfex9NYHjm/Nae3r6/DzTReKw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q2zruPuVSRtFjp3yKfoSKtBRGoj0/xGeXqO2M27qbnC+QL9ihO/pkmMTwgvzOI9Ob
         /IURtTcwBzoSh/b6TavlZqxLl0hk12Vu8BW/hTzOw4Q6yMcmB6FlFp3sk1NPRGweX/
         jdsF6Y6RxI2HT9FXKTD26fQlp0yUDFMXZb084406eSVpYSRR0V4MzCbb9116Ep1dVA
         711H0hV53imprWChzb61DMSYK2hPAWuk5J6CizQnNx4oEHzOmiOgY848IwMuXxWRw6
         hJKNzPboCXx5y+AXBxOLEyfdxspbLpANxCZhWtqP++IMRFeSprKFARr3KVDtTWD+9W
         kwiMOv9blHi/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48A99C595C3;
        Sat,  5 Aug 2023 00:19:54 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZM2J0hRj7HXbFF+b@liuwe-devbox-debian-v2>
References: <ZM2J0hRj7HXbFF+b@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZM2J0hRj7HXbFF+b@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230804
X-PR-Tracked-Commit-Id: 6ad0f2f91ad14ba0a3c2990c054fd6fbe8100429
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 024ff300db33968c133435a146d51ac22db27374
Message-Id: <169119479428.18284.6529094730669099263.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Aug 2023 00:19:54 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Fri, 4 Aug 2023 23:29:22 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230804

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/024ff300db33968c133435a146d51ac22db27374

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
