Return-Path: <linux-hyperv+bounces-7133-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EA6BC2134
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 18:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5273A3E34AE
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661E2E718E;
	Tue,  7 Oct 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNrp2alW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF292DE6F7;
	Tue,  7 Oct 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853664; cv=none; b=G4vcCUs87CJAbV2viXlPXcQLuABUS/hPJVdQyH+3ipuPh28NWlq8RIdLsWlWHecHN7bWNIyFn8Gzl6udIX3puPDyw4Cg/7HqSeUOYv7t8H2AT7S5psyL4YmsFz01rYjAYjeydkW2GPkpNM1FCxJrDb5qqmcVg4ZGiU66H3dNxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853664; c=relaxed/simple;
	bh=T/VjQgJ3pJtErZWaNfx9l24QStUaeCW92SmBEERxbrk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jackrHEXDguA4TfBHsZJLNaSf9QJiiGATQgK4SP3b/02O1M4urfdCuAZ9adnglyVcXmHmG1B633bRaX9McagWb9Apy3YUSmn/z/0EhQCjUhIpclhARKVz0FeYkcszHQiFhR88Jfs3k/3qNLEjgDQv6K+dE9DYj3C9tXKhk/uR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNrp2alW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E95DC4CEF1;
	Tue,  7 Oct 2025 16:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853664;
	bh=T/VjQgJ3pJtErZWaNfx9l24QStUaeCW92SmBEERxbrk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mNrp2alWqhMorayE5LFoGDbq1azkwKssVwF5AhW1kLEOPiaLbgH+Z5MJBKtAHVFkV
	 YIcfTZSNZ8LBQ8TPi6L8lwyKOR4Y/HflgG3JSfPU/TZdaX3fElf6IIu9AyVpIs8W80
	 AWuwgDc4/KqpzlsPvOPMAjWAeh15G18H7WazGZeUq/o/huRGD2SN3sMOvXATf45HxC
	 5HS95N/REwgkOay3MzTAvZ27DVovlVTiw2Fmk0p3jPY5vHUgWd+ApV0y6qz/2wT8Yy
	 sqE4ZRfPFtIgu/QDBanC6m5d9Mb7BF3I4xRlBjpKOXW25BUq1nuQoY9DAxEY0uBvnZ
	 UtGx9KjEqSxzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712D739EFA6D;
	Tue,  7 Oct 2025 16:14:14 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251007055546.GF2051323@liuwe-devbox-debian-v2.local>
References: <20251007055546.GF2051323@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251007055546.GF2051323@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20251006
X-PR-Tracked-Commit-Id: b595edcb24727e7f93e7962c3f6f971cc16dd29e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 221533629550e920580ab428f13ffebf54063b95
Message-Id: <175985365302.2684232.9980517307975036416.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 16:14:13 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 05:55:46 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20251006

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/221533629550e920580ab428f13ffebf54063b95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

