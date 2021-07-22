Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7A3D2B9A
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhGVRT7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 13:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhGVRT6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 13:19:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0AF296135F;
        Thu, 22 Jul 2021 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626976833;
        bh=fSwWzJJQs8mKjbj+ouc0JQN5s0eyyINvt+YEmk48jJc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KO+Y6CJrI08+qp6efFo50Xn0CT5LrsT8/pq+ebIYCEl7Kbh0aMDywVLW0tg7fS26o
         dXZIoBRiEZzd3R2fckymS3xbOCRaspXKSgmqi0j8J9hY0QZLEPtHiBdICCs4YqJhb0
         SFqTyh2lYTfzL35w2Fi/xXJKhbz9ByZp4NDERwdUoO4znSuE0KNv8zyR4mOoUTdRBh
         ze677MvFkovuGb7IoUj2QTAxbpfl1xdgRthjRcP2TUn/nL8urvIZAZEtUWggNdCF9z
         udu4YOZl9vzU8slzVWt4NQf86ripl2+KVWzLxeiKjjOXQDhDAqPzS0i4+2PMCnD5+1
         lHSSSBln0d1tQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 05480600AB;
        Thu, 22 Jul 2021 18:00:33 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
References: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210722
X-PR-Tracked-Commit-Id: f5a11c69b69923a4367d24365ad4dff6d4f3fc42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c14e4d6fbdd68bf8026868e8de263017c81b83d
Message-Id: <162697683301.6012.10755117407654361177.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Jul 2021 18:00:33 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Thu, 22 Jul 2021 14:09:49 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210722

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c14e4d6fbdd68bf8026868e8de263017c81b83d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
