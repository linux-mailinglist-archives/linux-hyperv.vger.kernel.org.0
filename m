Return-Path: <linux-hyperv+bounces-3769-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E9A1C4E8
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2025 19:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9943A74D5
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2025 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7084D29;
	Sat, 25 Jan 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6EjCy53"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD36800;
	Sat, 25 Jan 2025 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737829788; cv=none; b=ievNOYmddlNGKy0Pwq0ULqMDUr+yPq6ta6UvZauMq/Qylrb5EN4H5VPdn2A3iPKHdoidJfBqCBtYAy1sYcPQxm5wSicbwFPfwr9wCxkabPhcugVluOx22kPMQmJ6F2KM6J0KsQt5uY/aXAU1qIagFIlVtGKK9cMBWkMI/oQf1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737829788; c=relaxed/simple;
	bh=fgvxziG3CuUFsmcV8Qo81Zw99MqrZKUioEphyfRZPUE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UeLm2RMKc1cltagaWuE8Chk+FUJ6Uuc5uYSNBV+hI6OdoN6CmfiIARI2rk576bNQny6IgDXEQxTDoH/jwGg5dw9UKHDjKCk/0tVaIqajLuAAD3XViN/rcW2qI+BCfs7GrsHy+3UaLwukG7fMlWngmfRM58zKBfY4vY7XNsz4LeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6EjCy53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9D1C4CEDD;
	Sat, 25 Jan 2025 18:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737829787;
	bh=fgvxziG3CuUFsmcV8Qo81Zw99MqrZKUioEphyfRZPUE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N6EjCy536V9jteu3BFbLxQ2a9GZQbDTBF2t1Lx2NQN0V5gEVSdYDA89+s4WfhqVbT
	 sWcyOm40THMyO7pBU4Ai6Tv3oXk7QdTixQ5hLrEP597BrWwxLzzACBqK6PjrmkN4Pa
	 VfFVY8BBzgLvvEZpFPeNRY61I2aLUJm1H1ZMpS09k03GLWVEaD2xkZIC1OW5QNf5i2
	 R5gfsALO7ul82qSHkCcPkaB0OH/WJKNEzB0KJ1kMcSnJbQMkMoMuIur4vOUkqnUseC
	 EnfGSdDa9H/fdVc6VWAcechCv9OQzp6oEXBLfiGDcA87qSBlZo5sJJv0u4GDm1+CF6
	 pZ/VKdeGA2eCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34258380AA79;
	Sat, 25 Jan 2025 18:30:14 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z5MY8wmtnKFeCcAa@liuwe-devbox-debian-v2>
References: <Z5MY8wmtnKFeCcAa@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z5MY8wmtnKFeCcAa@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250123
X-PR-Tracked-Commit-Id: 2e03358be78b65d28b66e17aca9e0c8700b0df78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 382e391365ca12d1e5a15f109ba8b4609d58db6b
Message-Id: <173782981303.2581083.2956924996099769946.pr-tracker-bot@kernel.org>
Date: Sat, 25 Jan 2025 18:30:13 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Jan 2025 04:37:07 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250123

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/382e391365ca12d1e5a15f109ba8b4609d58db6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

