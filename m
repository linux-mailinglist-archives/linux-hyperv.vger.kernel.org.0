Return-Path: <linux-hyperv+bounces-1030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0AB7F5073
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 20:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52804281260
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 19:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A45C902;
	Wed, 22 Nov 2023 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnwAdXVi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73345C8EF
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Nov 2023 19:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29D53C433CD;
	Wed, 22 Nov 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700680624;
	bh=eu1niTZ9Us0JvNhA7epPBjffJ3MpouSoCCq6jD5odqM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cnwAdXViIEG6jkrRoeLzgTHZBmEJWabwoSsB6Kw5UKsd5Qb8d4AdvTZ/EuI3rCEhX
	 LK4R1KJW8OldD9a79HItnzDSVeY/DSaA+4w2NzV5NGwYjBhrECfmMLZjuaDgKgawhA
	 RB7w+8a01v/Hr39XRD7xYIK9ZyqDdOZG7GJJ2XyB3XEI8Eqvn3aQkFAIpPXx+qEyE6
	 PS1PEmBkYBLYAODcqMzW1LB0ccmqTWxtmb783EeW0l8FAM9Yu3DeZlNypLQZ7wba6o
	 iDsAq2w2Ean8xwz+DI5z0BsO06HTQ7ApqsNMzfSROzfV/6VUAqcFASKSxlnBbkzKa4
	 LOmaIE2yE6s9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1571BEAA958;
	Wed, 22 Nov 2023 19:17:04 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.7-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZV2NvuIAgdrc1d1P@liuwe-devbox-debian-v2>
References: <ZV2NvuIAgdrc1d1P@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZV2NvuIAgdrc1d1P@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231121
X-PR-Tracked-Commit-Id: 18286883e779fb79b413a7462968ee3f6768f19c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05c8c94ed407499279b2a552e7ee9bb03e859b7b
Message-Id: <170068062408.6718.13004684063632403217.pr-tracker-bot@kernel.org>
Date: Wed, 22 Nov 2023 19:17:04 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, Linux Kernel List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Nov 2023 05:12:30 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05c8c94ed407499279b2a552e7ee9bb03e859b7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

