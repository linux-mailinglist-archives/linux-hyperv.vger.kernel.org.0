Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3A540D0F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Sep 2021 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhIPAdx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Sep 2021 20:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhIPAdx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BA58C60F6D;
        Thu, 16 Sep 2021 00:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752353;
        bh=a/XA1zZYARdyrZOimECF0MuxSN3+rgrHB9VZsxkkrlc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ry7vJl60/w6ciji50W8a8aWBbNPFSqrfShDLMw3byNRqf2Hf12wVt4Qq2MiQ4ovHj
         4O8Ka6IFmklYrUuDtBYzU6xu0015nENtHK5JdMmwmdoBmQdazEQpyzarbkCaUqTl3i
         25TRAvWTJzTJA/IQr8H/CQao4LHvY/CuNzqwVJBd2rEXzSWxPCzENo/XAO70FGJy+t
         OaO+d4f8xgE0hU7W5Y89axhVCpxsNOmbJ5Rqc5j4cLxziz+48R7YPwhNyHKXBwihm2
         oQmIPnJmRCnAAMwDgZ27atU/N2kjQnbeSGN73Nz6ZyTnvQAVjREX80tqZ/p7heC78+
         l37hagVq2IZwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2B9E60A22;
        Thu, 16 Sep 2021 00:32:33 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210915125506.4zra6p2b7qu7fz4d@liuwe-devbox-debian-v2>
References: <20210915125506.4zra6p2b7qu7fz4d@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210915125506.4zra6p2b7qu7fz4d@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210915
X-PR-Tracked-Commit-Id: dfb5c1e12c28e35e4d4e5bc8022b0e9d585b89a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff1ffd71d5f0612cf194f5705c671d6b64bf5f91
Message-Id: <163175235372.18536.9635229087559879261.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Sep 2021 00:32:33 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Wed, 15 Sep 2021 12:55:06 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210915

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff1ffd71d5f0612cf194f5705c671d6b64bf5f91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
