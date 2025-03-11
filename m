Return-Path: <linux-hyperv+bounces-4412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D62A5D2BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 23:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B33B1ED6
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 22:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22D1EE7CB;
	Tue, 11 Mar 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY4Gt4fM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D871E832A;
	Tue, 11 Mar 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733654; cv=none; b=aQbkacWtM040SBsPUJULJkzOCbqSYShR1OIPLWqVUu9VMW/Em6t/aVakspe0lsofnIBnmSSliTtmAaVZCeHdBNXjvKeWxDG6ZsFTljoXKIFN+TM1WkgTnVuLnAuTA32m6shi4Q4SMucP7STsDftsT1HVaCOxPIgmwlp8x2kl7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733654; c=relaxed/simple;
	bh=K2Ws8G2BwfOhbzPCCjGplxBpqc2i8mGF0Qamx1ZX4OU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g7DgVOtf68/hfy4nNKsBk2+QIF9N8JJCj298rpiCfIBzUs+VburgLLgDY+jhCqEItv3muC4Chv8BYK8au3Kf/X+zFUdin5BzmpV+/yxa1WWVF4NKUSbaxua85x2fP6kKCCGEtZi/iL/J2t9H72J8uMA/HFkPB5looXMhDtqaQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY4Gt4fM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0259CC4CEE9;
	Tue, 11 Mar 2025 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741733654;
	bh=K2Ws8G2BwfOhbzPCCjGplxBpqc2i8mGF0Qamx1ZX4OU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BY4Gt4fMVvQsjk7zP7kv8wx5imn97akJh0EM1ViE9qtehX1wDv1or5D0BsGc+H+SR
	 130pivb+r+8myv7ieplJeAsRTvRJcx2kilZVZElEwftmmEQHyLkFWXNy2Kk/cC3xzg
	 nEh26fhMvTQ9zHfGEcueNAQh/Rwb9OFJJk3rn82uE6TWpYFA+l6UwdxAwFwVlOSdIs
	 pjk5fG+70UCrnepgnHPJ1L6OSySqVSXzGO1esbhyzGRzl8TqjeA57hItyjeosUdPtw
	 5DZhBe8/WRTReo8QBFvEHkpQc5cwjZawflE5CViCHdJPK1bjU/prz9ppd+YKRJZwR0
	 Jl5lDMNl/fPmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71221380DBD2;
	Tue, 11 Mar 2025 22:54:49 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9CwWweWftt02ZWZ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <Z9CwWweWftt02ZWZ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9CwWweWftt02ZWZ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250311
X-PR-Tracked-Commit-Id: 73fe9073c0cc28056cb9de0c8a516dac070f1d1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fed89a961ea851945d23cc35beb59d6e56c0964
Message-Id: <174173368803.261972.6643664486774360071.pr-tracker-bot@kernel.org>
Date: Tue, 11 Mar 2025 22:54:48 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 11 Mar 2025 21:51:23 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250311

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fed89a961ea851945d23cc35beb59d6e56c0964

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

