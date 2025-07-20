Return-Path: <linux-hyperv+bounces-6309-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1EB0B6F1
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Jul 2025 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7C1169722
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Jul 2025 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AED1B423D;
	Sun, 20 Jul 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3g9dq+S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388272616;
	Sun, 20 Jul 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029297; cv=none; b=szB2py9EB464/Oyts2GSCTn2X8/IdQpzubItG24HE1iQ8oZC+cgyujXciBYRUadKnWsoXVQqD+0BBNRePwhxCV/iKA8lcvZyadbertkB1uDUI5CwU+f402t0aYakMsqN0j77ebDTsTvlY0jvdy8+kCVC42YPSfcCNK3+/7F8OpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029297; c=relaxed/simple;
	bh=TVL17lsHg63KaLy3I/rYCmcg9qawjt9HbG4Zj4OZ8pk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NxA1zM1KME96WnNy8aCAMxoWZNEMTyZutv6i0tsOqcdey/P5vEwYj7YKJEoFQ1znij9f/Aid4UjBoVJ6ws36O9KO938pUi+28EXf/HYHSkK3HOtzgwK3CIAWpmD9ug4KW7tNc7JYmNM+hBJLoxMnkRmbPi3cuJN3VoNrEqB3YyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3g9dq+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F4C4CEE7;
	Sun, 20 Jul 2025 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753029295;
	bh=TVL17lsHg63KaLy3I/rYCmcg9qawjt9HbG4Zj4OZ8pk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g3g9dq+SH+EIV9nLJSajMenx9buvTjGP/JdmmThHieTT5wAjclA6JU2H8BnE86EXM
	 2H+FhhtPcJowWpA3SSTFBAUVJ3WVOeeFps/yoBPvtPpqIZ+nCwsynWZXK4wnwR4r27
	 okpRMzCTytJBWf7BQ1zClNUQJ3dkLd6M4FPiW9SX27tb0vTCOHRaUmfR1IkateHdOg
	 NHuGAKH4BtC1NuS+mjp/VPLleLYUiSEDfxAznJDy3cTQ1rrh9twMpjiKqRlJiRumma
	 nLVVHdnZ++WNLD7UYhf5qqFozPiuekAYdKBJUVHLF3qtY+xaWm+Et4CCBFWfU/cpmZ
	 QfEiolxO13zRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C9121383BF51;
	Sun, 20 Jul 2025 16:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHyJD7tQPytwl0nS@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <aHyJD7tQPytwl0nS@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHyJD7tQPytwl0nS@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250718
X-PR-Tracked-Commit-Id: a4131a50d072b369bfed0b41e741c41fd8048641
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f054ef2e0f1ca7d32ac48e275d08e2ac29d84f3
Message-Id: <175302931461.3242983.6866622472818331901.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 16:35:14 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 06:13:35 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250718

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f054ef2e0f1ca7d32ac48e275d08e2ac29d84f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

