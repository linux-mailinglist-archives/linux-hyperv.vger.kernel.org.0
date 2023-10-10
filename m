Return-Path: <linux-hyperv+bounces-501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7C7C03CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 20:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421AA1C20993
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCD27707;
	Tue, 10 Oct 2023 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0AysTWD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A89EB8
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Oct 2023 18:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3113DC433C7;
	Tue, 10 Oct 2023 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696964073;
	bh=5M8uHajsXetU2LCmi4J1QL/R3D0JAdVcfHelqD5j7yY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R0AysTWDZTRdTpMy28oqE1vqClsxRcjMngy9BB/5RL0729u5LSFKimU92eL1caOvY
	 syJVepPaCmMllOohbUETf96g/qJgjOqdP+wYITTfwHZO0s4ax7tPJVPXAKtW3s0eNC
	 RE3S9oZn4xeaz5qaO/LHQfSXprTsRTH/n/bsfAS5xj+iKwExCCWKOqXZHimN7/xvCk
	 6yVO19d6fNV4cxoKxvOoBV4o+VNqMD64bDGuRVx7h+n+S+UxCV0k0cxcLdqtdPmfNL
	 V+SDGR8SdulSszcMy5Satz0NT0OauPPqXlvS3coE6FqpSX6pH+0Gx/VDnmFM98MIUH
	 WlauBACnOi2Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14027C41671;
	Tue, 10 Oct 2023 18:54:33 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 6.6-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZSTjl1BsWyyh9COJ@liuwe-devbox-debian-v2>
References: <ZSTjl1BsWyyh9COJ@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSTjl1BsWyyh9COJ@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231009
X-PR-Tracked-Commit-Id: 42999c90461293233de9bb6e6c7d8a2db7281c1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b711538a40b794ccc83838fb66990a091c56c101
Message-Id: <169696407307.29903.11304557279294545474.pr-tracker-bot@kernel.org>
Date: Tue, 10 Oct 2023 18:54:33 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 10 Oct 2023 05:39:35 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231009

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b711538a40b794ccc83838fb66990a091c56c101

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

