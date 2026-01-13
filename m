Return-Path: <linux-hyperv+bounces-8276-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F9D1ACEE
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820C33032965
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25798306490;
	Tue, 13 Jan 2026 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MboLO2bD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371361FFE;
	Tue, 13 Jan 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328121; cv=none; b=ZojeB0vQ/mPZfctnaabtDpuSSAXeRqYsLzrl4DmyS3B1rrKoUJYiHDJK9+dMZkaM74KH/acDVU4YSWjk0Fp2Fgqm1vHEe9tdOZ60xDdVWMroTu13fWT+DtpNSAqutj9QLbu7NJfyMds4kTvtR6jTAQzBeOwKLmXIuftehgKQvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328121; c=relaxed/simple;
	bh=PHdcHEb0yfs0bWiRcvT5UdXECVv/XRr375avuR2e1GU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UBuM4+Fw0Q/CG/uSZd6/20o3pjXxgacbZ/fmMoSvq8Nf44L0iQYGyvni30WrrITjFjhNATM14OaMwcA0lb+bCxq3BvQV9XdtQwOCqssfc4LQ9Dx1+BghUxikPZG7zc80Kylkdm4uuE8u4EylIsR0Cbgh2D0pZ0WiNG0hVHOZOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MboLO2bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E2C116C6;
	Tue, 13 Jan 2026 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328120;
	bh=PHdcHEb0yfs0bWiRcvT5UdXECVv/XRr375avuR2e1GU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MboLO2bDuw+VT9GRWb4WgwQVHAAeZAXWbIYIxin+6Oz24fkU7pd/fczvNYKhtgDAP
	 dPDenRqQKC6qkgXMXSiTAiWC4o/Ph0p3D292mhtroGkZ2m/NBd+iVZx0LACuy7RZu9
	 7UhJiTkCSNQ5ERHVRh7w81BjfxVSQYfXrAiSMiy8tEXTN6aVqwb5HNcuc53DA1k81W
	 oRKnt3lOY+92clCeCThBpjhUYSWfDS78Mprvz3yUqMrxqz9poQpSX1mxWgBKhO5YKt
	 8CD//w9fZ3HMloFrVHGpdmPqvP4gCZJJTfm8I+AO8Htf6EULHfSbDC7hJVxSwc/QFg
	 lI3f7wV8mzimA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BC5F3808200;
	Tue, 13 Jan 2026 18:11:55 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260113064709.GA3099059@liuwe-devbox-debian-v2.local>
References: <20260113064709.GA3099059@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260113064709.GA3099059@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260112
X-PR-Tracked-Commit-Id: 173d6f64f9558ff022a777a72eb8669b6cdd2649
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afd12f914c8f733a9660c97bdbe539aee88e742b
Message-Id: <176832791372.2405565.16367155426627830359.pr-tracker-bot@kernel.org>
Date: Tue, 13 Jan 2026 18:11:53 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 13 Jan 2026 06:47:09 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afd12f914c8f733a9660c97bdbe539aee88e742b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

