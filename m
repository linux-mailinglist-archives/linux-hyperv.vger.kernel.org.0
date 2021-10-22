Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3178437F72
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Oct 2021 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhJVUsn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Oct 2021 16:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234319AbhJVUsm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Oct 2021 16:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D142760F6F;
        Fri, 22 Oct 2021 20:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634935584;
        bh=bVhrdaBlaimshD3NhLP3nYWTKZPKZiGLsgsDY3YMQjo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FDFwjM1HYsSYJzqI+seA+AnB7SzM3O900IHpY7aOEBWNDywP+dJ+Xxsnv95MI0umP
         6UuiBxvcS/BvO3RKaMMq+EprWbbBZGo9lrn8uT7qV4ocEnB4goggnWtA/WdzUsHo9s
         vM6CZblXZ8goGCelSRYO14WLhvVzSYxsHIszKYFYlfbbj+hfwT7zVdAZAeCetJG4qX
         5zh1f52VVYhygstV4Gi5E0kVi7hh5gkm3vgRdcmkF2EtGz9pqKqVYjfVsvaTDWrCgL
         WA45VyxjautDCloVuq1BBfrRZGTfxf4BqjWARGkuYwIjh4dYeq9nMU+Ug61RfmvqaM
         6WzesJ9J6+Sxw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C78D860A2A;
        Fri, 22 Oct 2021 20:46:24 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211022193115.l5doheww7ljub6dj@liuwe-devbox-debian-v2>
References: <20211022193115.l5doheww7ljub6dj@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211022193115.l5doheww7ljub6dj@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211022
X-PR-Tracked-Commit-Id: 8017c99680fa65e1e8d999df1583de476a187830
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 477b4e80c57f787cf8f494ccb9be23a23642b2f2
Message-Id: <163493558481.22044.17386270021879893363.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Oct 2021 20:46:24 +0000
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

The pull request you sent on Fri, 22 Oct 2021 19:31:15 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211022

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/477b4e80c57f787cf8f494ccb9be23a23642b2f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
