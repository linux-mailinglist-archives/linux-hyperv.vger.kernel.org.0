Return-Path: <linux-hyperv+bounces-5721-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B8CACCAF7
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB68A16F2F6
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA8E23F271;
	Tue,  3 Jun 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ16LM1J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAF23F26A;
	Tue,  3 Jun 2025 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966929; cv=none; b=hdWQ6X6SMn4vibTznzHGDRJwgK0g9nU/95YL7UMm1uAK5Je+cZfW2SwKLYVAGI5EPeBvDJdbCb5q4m0ul4NswLTomzYtca7hvITcv46IGJwWhWKK3IzNLX9j959ipsgDadc9SjCK1EsdJS/h3AoQOeZtWiuq5yTTfWXQfedGCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966929; c=relaxed/simple;
	bh=ag6yM55zS2LLWLzt/J2bH3xIErdualVaQuSPyas6euM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KEHqB7TRGR1+bqGvki2KqYD6X0z14V3ZPL3I+Ae3ZcV2WBKUXo82Fn9dzn7rFO8c1judwA1oNI9r0R19n1w1cz1Yexl4bDnapu4o8RPniAu+6yJLNFWr863fRaJ10r/vgD2CaQ6/a+3mT52fkFrVV5ZK4UTC/tfeZ1HIMbaBtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ16LM1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB50C4CEED;
	Tue,  3 Jun 2025 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748966929;
	bh=ag6yM55zS2LLWLzt/J2bH3xIErdualVaQuSPyas6euM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AJ16LM1JSh84mp02u7Ck2DZ3ASf0hCl74y4TIT0Yv4YJvfsfZR+aBSgggvUrdZ67r
	 mX84cU7ExugqMh7UrbtCPAyNi74BzPtwtLPMcdAAtSLcWKMJoNPZaRlqroiy/G7jjt
	 s+yg5lF7YlaPBW84lTKinB/WqgpkHn8wnLq4qc2W6G+XnUuht3ic+80HqbLzoM1T1P
	 beU5G4QqVUUIAackp/PklJWzzb6V/EHNjF2p9yvCLff0unw5O/K4s6i+Qxn0WiKxJ7
	 VjmzU+2mF9lVHKy+z7rQQtuD9gYyn1dHPWjO85rte/xXGVY8eQkqB8iZ8nWqMD+aR5
	 mE1CzYdheAU3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE44380DBEC;
	Tue,  3 Jun 2025 16:09:22 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aD6Rq7Hm499y5ybR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <aD6Rq7Hm499y5ybR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aD6Rq7Hm499y5ybR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250602
X-PR-Tracked-Commit-Id: 96959283a58d91ae20d025546f00e16f0a555208
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c00b28502470b7677c2f4ee2e9c899205fa78e27
Message-Id: <174896696159.1571592.11934860779251289748.pr-tracker-bot@kernel.org>
Date: Tue, 03 Jun 2025 16:09:21 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 3 Jun 2025 06:09:47 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250602

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c00b28502470b7677c2f4ee2e9c899205fa78e27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

