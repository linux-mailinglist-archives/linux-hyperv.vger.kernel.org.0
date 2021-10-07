Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE0425916
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Oct 2021 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbhJGRRN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Oct 2021 13:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242925AbhJGRRM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Oct 2021 13:17:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2EA7A61108;
        Thu,  7 Oct 2021 17:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633626918;
        bh=uXH+uAQEOXHEYUnLM0TElNKwbL5xRwTmSF4ML58CtkU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H7zE9y97BeoM4qZ8eHI57wKZazjXM1ulS4XWuYGKU88p56xa0dQ2JOxC+dYEYefP8
         dWmhuX21QaOAeGhg1gjPsRsDaNymaMWGsjmeaHpMqm1zDUljFsoPtrTTfl1v8mVTnv
         JEeQx8emvdPho43su4EwVmEqLJ2anmc7IK076i3QLGZJ4Kb8qIMuRNNAX1mld/+sgA
         n2M45yP2nXAIiM6UsqTggrKhZ3umAwQiiTcK0GzXUL+8fyGiZMEDA16Ek2LsMzsufZ
         f2MQFcmueKPus4vfJRDWZd/+VFvXoBHJN5pxT1MVmYy0B6swJKsSSFeA9MyaRzq++V
         sd8JRY8eERP5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1DD8E60A23;
        Thu,  7 Oct 2021 17:15:18 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 5.15-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211007103253.t5w5pgpmzvkffvwp@liuwe-devbox-debian-v2>
References: <20211007103253.t5w5pgpmzvkffvwp@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211007103253.t5w5pgpmzvkffvwp@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211007
X-PR-Tracked-Commit-Id: f5c20e4a5f18677e22d8dd2846066251b006a62d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52bf8031c06464268b1a7810946a54de5b088e81
Message-Id: <163362691806.23492.11402827145100786735.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Oct 2021 17:15:18 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, sthemmin@microsoft.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Thu, 7 Oct 2021 10:32:53 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211007

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52bf8031c06464268b1a7810946a54de5b088e81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
