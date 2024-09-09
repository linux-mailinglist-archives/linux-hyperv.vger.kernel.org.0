Return-Path: <linux-hyperv+bounces-2993-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A143972051
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2EF5B22AD3
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA6716D4EF;
	Mon,  9 Sep 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP9QkRLT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7B282E2
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Sep 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902451; cv=none; b=MRb+6vp+WavFW9f5prWV3HTjwKtNNGli8bOpLnX/kYpuxLaPIo6zSHMqEKxVdh8qFU5MyXJ4c3NJxOnmQZfEOZRKaW+Gz8qAZONNbJkWt8cKXDapbYV2p/jSoo16B4li1+O9MO3WTGQH0u16uducOb/tu5f8xEj1b/Jl3RUH5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902451; c=relaxed/simple;
	bh=yflZn/RDJFjzoHFEHs27FmikSaoPIG1gPFY7EOQRzZE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KVVs22oLQOvQ2X6UGaVM8Q97Zk9wxNJ5a7NIMeZjDMUuV6udv8CEjHCTMwq+5YQVLspecFp8EJ+IogmYddwwQlW2vBenJaJ5gpTwGrabV7vS1reJXr9DFR+981M8Jy/CY0FUzauxVNjhURUEB0gFDiRu328sbZA7+NdlA6Al/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP9QkRLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED210C4CEC5;
	Mon,  9 Sep 2024 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902451;
	bh=yflZn/RDJFjzoHFEHs27FmikSaoPIG1gPFY7EOQRzZE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QP9QkRLT++uw2uPDIeA7hoaotGriSPf9YGDUmgaxh2Spb+GhfuSIdI6p9i+5eHLc6
	 g4xm3WXleql+RX2qUBYRc+8i+kcvMkJR9mzJrTIF7VMAszeZ8EB+W5Y9UkpDlLHAF+
	 l5c+XyHt1ezziSA/oIAU0DHIrKX3zGq1YskmUfgWqW4bHKniqvlMQfCE/w/2C5mtpO
	 NErn/Z8dE0qi4zNGZaFrfxBMpey+26q2sw7wsPeH1pCmkzwzZHBTN8YuYNp0qS99in
	 hXY8HxzE+jXyebuk4QdVaOzqs+vvNumxF6LOmzy9ERiPVOvvJH5lAYBBFJc6l4kMYp
	 q2Y24MAsn5jDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EC13806654;
	Mon,  9 Sep 2024 17:20:53 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v6.11-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zt5JlnHqc6ubskR3@liuwe-devbox-debian-v2>
References: <Zt5JlnHqc6ubskR3@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zt5JlnHqc6ubskR3@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240908
X-PR-Tracked-Commit-Id: 895384881ec960aa4c602397a69f0a44a8169405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb92a1ffc121e65ffed13c6bfe01c190487d791e
Message-Id: <172590245181.3867163.12007178031276039327.pr-tracker-bot@kernel.org>
Date: Mon, 09 Sep 2024 17:20:51 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 01:04:22 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240908

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb92a1ffc121e65ffed13c6bfe01c190487d791e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

