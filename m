Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D33728E573
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Oct 2020 19:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbgJNRhO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Oct 2020 13:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389383AbgJNRhM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:12 -0400
Subject: Re: [GIT PULL] Hyper-V commits for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697032;
        bh=xJtjbH6oINNo0b2u6RmHIaV3sup612mAzHad1Y/RHhA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0bKTNlcaC2j7AQZ0ovw0CFeqaBqls+78Col5slvXK+swHNgvfqpcnclJuOMRIHkRV
         L2qWw2auq+/tKVaEvOExxthyTs3ojiZUMqAzqPdDoB2zGX02QQL3gSSfPoMiaf8/+c
         F72LXYLyUIez9c+5yceTRFjATRK0D+rzf7o8uCkY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013131214.ej4ek5expi5dywer@liuwe-devbox-debian-v2>
References: <20201013131214.ej4ek5expi5dywer@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013131214.ej4ek5expi5dywer@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed
X-PR-Tracked-Commit-Id: 1f3aed01473c41c9f896fbf4c30d330655e8aa7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4907a43da83184d4e88009654c9b31f5e091f709
Message-Id: <160269703226.25844.1399151386874205907.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 17:37:12 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 13:12:14 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4907a43da83184d4e88009654c9b31f5e091f709

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
