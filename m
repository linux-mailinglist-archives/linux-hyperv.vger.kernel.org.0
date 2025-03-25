Return-Path: <linux-hyperv+bounces-4706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82930A70C71
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 22:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F0188F483
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA5266B77;
	Tue, 25 Mar 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/B7QNYB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51E2580E1;
	Tue, 25 Mar 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939721; cv=none; b=d9pTcj1x9WSkRUuRGgFoRCvK4xTK7s+f5jFHcotc8/1dgYhzaeDYToxzhcKH4ljBUdemoMxIAGgP4WiGXZAWFyb1+7RerCaTdIF6bNCbP9/iAmGn7IbjDbowZg0bIpubMR9u/9zr+ntH8Mdd0Dyk+jamPd6NR4B9Qtxocuxnkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939721; c=relaxed/simple;
	bh=tqtJHNLpvHMD6YGFy4nYk1vJ8wxLrbQUDCQiL3ki65A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ot0RNwzaNCsLPb82IqIXO4FpWfnwMP/t9xttHMnWoVXQlhIxWXM2CQZ3vpVaA4IUNIjTrBotNYBCXG/XOMPCTQGGGoEAcZyS2SJ1mUfwuCIovZwc1s2+R9RYNwvbWNtNoHFfEgpVJWWT4SVj/fqkBPkTw21E4/DfIdku39bEreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/B7QNYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE28C4CEE4;
	Tue, 25 Mar 2025 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939721;
	bh=tqtJHNLpvHMD6YGFy4nYk1vJ8wxLrbQUDCQiL3ki65A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U/B7QNYB2Xl8mRRJXcNVkTn+TjI0AkGvdMck2O/TJaYB/Rxmonja5mSvTAAKmccem
	 /rVTIlOhWNebt6xXG9I9y0KVyxRadtnlC2PMXbfA1c9oZrGNWNGvgmuMCi955r/B1q
	 YezNrp0U6EOJb4BgHK5E0qhlTMLNQNfju5J34jBm62WrMlwDdBDNA50rIWhARfVYl5
	 AnWrmIo1yM5IWCd17CAjuWV6LyO2iYA9d3wdkPTVYdT+d0OxtivwNPtuLvTIAopZ1w
	 92cG4FA5AhsXUl60uLlfKewxjhXgnaPN24HVmakLzYayceEjyaa99jzy6zBneH4i22
	 HMcqHnjfotgEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE02380DBFC;
	Tue, 25 Mar 2025 21:55:58 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-GYKSuytHh-Weas@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <Z-GYKSuytHh-Weas@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z-GYKSuytHh-Weas@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250324
X-PR-Tracked-Commit-Id: 628cc040b3a2980df6032766e8ef0688e981ab95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b3d8660b049779880c790549ff3fef02f6922c
Message-Id: <174293975731.745772.18014066976136500331.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 21:55:57 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 17:36:41 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250324

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b3d8660b049779880c790549ff3fef02f6922c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

