Return-Path: <linux-hyperv+bounces-2443-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA990BA67
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6ED1F22C05
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC5198838;
	Mon, 17 Jun 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3/sANzz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6C1741CD;
	Mon, 17 Jun 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650841; cv=none; b=A5MRcB8oB5CrdmL2jqokn+P5fLqfKkWeXnv1Z4PqXLY4upjogwWgzaA9FtEfS6UO86ZAszqTn/pQ6sDfykBbUonfJfADBkxKwr4+rartxrN3BFHShXOBdJ7uC5uJVE2b/XIIeugZpzD9Xtupwc1gq/YRjs+DFBVLxXMCafmNjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650841; c=relaxed/simple;
	bh=zAsGAyMXxFvkRg/djLZNz8tnkKkMGOudgMy5giKZRZU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AvpoqRd9eD/bhAhHO4/GQMv+Xi+zVmtw9jiuYL6PqRBbspkuBJlvfrpUh7FXa+jdMosryHBrnOLT1N3u62qcs3bfGi5qHKVdBCR8MdBpyBe3y5OovX02bvh3MwLivMekR2Lwu1+1+cY08P7txuvxz/i9uPOZEFhp7AV1lheNJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3/sANzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A360C2BD10;
	Mon, 17 Jun 2024 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650840;
	bh=zAsGAyMXxFvkRg/djLZNz8tnkKkMGOudgMy5giKZRZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W3/sANzzdH+GCg32P0uTEqwiSvt6pqst0ko0+bfuMiOIrJsBkZwcjgEBVj5Zk95A4
	 aPKTfOPd/makh3sqgsrYErkZdxwd+OlT3Y5cY4fXBvpUD0l2NqW0x7IH+NOPnGbjfC
	 u8pueE8ckXvlRulIDMpkG1PWm63bEkfieF98jqN7QT3x4HUL5gsbGKHX/pFRFPe3gf
	 wbAI2UPeA0li1JhrLc1BLgDgUpoim4lyOWNlNvJe0hK99CinZpy11+kqQrg0hVLFef
	 x1XddueU7k+9k81OCqjgBC+oBCStukCqQ70i3mMfJ/y/d9UZ5LLzbBo6XZmv1r/rF/
	 BkMEWoyus6dYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A68AC4361A;
	Mon, 17 Jun 2024 19:00:40 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm_hlTTK0pZFMujj@liuwe-devbox-debian-v2>
References: <Zm_hlTTK0pZFMujj@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm_hlTTK0pZFMujj@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240616
X-PR-Tracked-Commit-Id: 831bcbcead6668ebf20b64fdb27518f1362ace3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6226e74900d7c106c7c86b878dc6779cfdb20c2b
Message-Id: <171865084041.27486.2889459138073270147.pr-tracker-bot@kernel.org>
Date: Mon, 17 Jun 2024 19:00:40 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Jun 2024 07:11:17 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240616

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6226e74900d7c106c7c86b878dc6779cfdb20c2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

