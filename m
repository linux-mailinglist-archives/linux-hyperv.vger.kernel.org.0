Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6730048FDD1
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Jan 2022 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiAPQWX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 16 Jan 2022 11:22:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49132 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiAPQWW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 16 Jan 2022 11:22:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C98C60F5D;
        Sun, 16 Jan 2022 16:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AFC6C36AE7;
        Sun, 16 Jan 2022 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642350141;
        bh=2jdyKrWpKup8kv17H0oHHbBaH+dLiIj2E9IXQlp3gIM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=puS/oAWOoQmSqj1P3anb/GfP5jxcwqfBJf+Z08EBMa2JEJm00gLTzOWzTjbWPFooE
         qyhJnApN9CD4BGkzEGTb8Jdzy7mRRJxIp7aEYrpeZo21XQjMYSdsajyniqeiz3U4oK
         7pqXNtZjjxP1++tOqawscsFS1jw7PkH+GwtUoaQLohopQx9bIVZhJBIl7InlGZnUhQ
         Xk45gUqhmpkHOvgKSo/HspTsZoBLYGwtXYpw6i+1btwAvaoXnPY6OQlwOBnNDeGnVG
         c8GULIICNOq5R0TQsxlqtrzqpIZyos6o/YVOEOXGRGNMQ5co6Hn1R9nXweEs6ieeZU
         vDIlOQ5yvgnDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 861A3F60796;
        Sun, 16 Jan 2022 16:22:21 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220114190246.4uvu7oehhugxcwki@liuwe-devbox-debian-v2>
References: <20220114190246.4uvu7oehhugxcwki@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220114190246.4uvu7oehhugxcwki@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220114
X-PR-Tracked-Commit-Id: 4eea5332d67d8ae6ba5717ec0f4e671fdbd222e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb3f09f9afe5286c0aed7a1c5cc71495de166efb
Message-Id: <164235014154.4755.17282227684468805915.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jan 2022 16:22:21 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 19:02:46 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220114

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb3f09f9afe5286c0aed7a1c5cc71495de166efb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
