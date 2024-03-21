Return-Path: <linux-hyperv+bounces-1812-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23506885FD2
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 18:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D389E283900
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD898613B;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieX9247Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877C85937;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042480; cv=none; b=NmkPyVzNpk8S8/OXdNo6tbM9x1qECHAjrk19lmL1wNPQCaZricoR3c1G7sXUet/wxxYxgxF3ftxCTO1qvtKYr8DtgdUin5cP3YGpYD3asYiBisocXAAT4Vq+fOKsPlPNzTNUMASUGk45bZjLuRZ4OwSQp/VysSyGDZY2j8NrN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042480; c=relaxed/simple;
	bh=K7WpSl6AiRYcxcqj81IGT7P52vOFRswU8sUuEgJhgy0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U/aF9MdUlF76BD4IGkwrtxowrNrfqDr8BqnOaZuKOClIYps5gExHi0Q4f+xwRsbP7udminFEN63XCKmd6K5gGiaPSGKQT3W/7p8T4/8or/YfXCNW9GuIDmCXbF64RT5bXuPvs1tgEgMnzGspOleUbKs8M6HcA4rkdY6Y9ZgDiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieX9247Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38FBCC43390;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711042480;
	bh=K7WpSl6AiRYcxcqj81IGT7P52vOFRswU8sUuEgJhgy0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ieX9247YeMZrAawIZSNOTTqiK7dpVhB9plRMRWOrQGH9XcQvNHHYtG89whs79ohSo
	 Yjc+XnfOOVIv9HF8+/Ccmtz6+Apu8Wk4nuiQ31xZACK99+3+mSJwiaqh3ibrgie4xZ
	 37hwxwPcpiSjonKee6Y+mCswCnKRZO0n6FX7KMWn3d+tLLX4Li+RhFmuAX4Ab5Mx/A
	 NyLTqnAPDv8o3MWiSxLzNb1I5e3lfwYy/C7lyzZOfMs1+1oofhpbjBh/UFvT6+5n1I
	 MeSEEtp7y0TMzIJqqYcCpaCxUs5tvr3t1qvZXZnWPtCdf8CmH4SsWSV0n6X4J0u67b
	 9LhQxe96R48Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 291EDD95060;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V commits for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
References: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240320
X-PR-Tracked-Commit-Id: f2580a907e5c0e8fc9354fd095b011301c64f949
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfce216e1439d67a52a4b4c709299f6555946c33
Message-Id: <171104248016.9254.6771809565359866205.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 17:34:40 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 04:09:09 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240320

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfce216e1439d67a52a4b4c709299f6555946c33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

