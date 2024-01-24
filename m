Return-Path: <linux-hyperv+bounces-1465-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83068839E44
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 02:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B391C283DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339FC15C3;
	Wed, 24 Jan 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbbP3Mqd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C915A5;
	Wed, 24 Jan 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059831; cv=none; b=iacp3vGOolruDwZ4Nx+7AvutIcsWa2NTaMfRpMP+BqKiqm9PGIroEmjrTjL0IDpno7ysgXu8hApwmNFQRwh3QekmFa+A1VZhyCeVcy1v2fxfYTuxeJI2AhNJQKHkSsXvmYlSYFXz7kRyjLZ8bePXATyq7zGoRgCqO8GTXSsWgy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059831; c=relaxed/simple;
	bh=JTWzB95tQksa5MDrICl6BaP8CqbXJ+U4hsSFxWdgIA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ir1mpOFXVszOR5Om2FhEMVjPwSB2KSnEo6T533gEGr6yHqtXAMTffeejpj4wVaw/wnHxWXbAlhKCe8yDfrVt1vm5r4zsCAniOEwc9HHjkkqP1IUh1RClNGF6TZ6TVIYELAV67ZJscUTnHB75+7JXqUAuS7MVckq/AT7rVpFMZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbbP3Mqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C690C43390;
	Wed, 24 Jan 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706059830;
	bh=JTWzB95tQksa5MDrICl6BaP8CqbXJ+U4hsSFxWdgIA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DbbP3MqdEZJFOzOklIithRbKpINxz+tksq4FB6ZpcGAjrkfEUEMduTLc/zy/YHo4P
	 FBDDv/gMTZfas+dX+PIWiYWMUzsd2UjvRGw8F4WjqsO4ZEOSpUX2MRk36R91Vec5Jy
	 uOqEEpQBBEN4ROSIlb8IcMsCglS3nfy2gwWydJH3BP3u/5l7P/tNsouJRvPez0oWu4
	 ztyzBwDEZ7rv0caQ9/UyQHCW8g804b0MtHjxed2XwPfgQxAEzKzr2F/23rP8LFPnEM
	 ba89sJdQCzufcWk/wssLYvjohfvXr5PPh25/5joIvIqb7kwMU8meB/w0LVAjORp7y/
	 lewwCp7QkbNAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53536DFF767;
	Wed, 24 Jan 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] hv_netvsc: Calculate correct ring size when PAGE_SIZE
 is not 4 Kbytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605983033.14933.2315449295954740333.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 01:30:30 +0000
References: <20240122162028.348885-1-mhklinux@outlook.com>
In-Reply-To: <20240122162028.348885-1-mhklinux@outlook.com>
To: Michael Kelley <mhkelley58@gmail.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 08:20:28 -0800 you wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Current code in netvsc_drv_init() incorrectly assumes that PAGE_SIZE
> is 4 Kbytes, which is wrong on ARM64 with 16K or 64K page size. As a
> result, the default VMBus ring buffer size on ARM64 with 64K page size
> is 8 Mbytes instead of the expected 512 Kbytes. While this doesn't break
> anything, a typical VM with 8 vCPUs and 8 netvsc channels wastes 120
> Mbytes (8 channels * 2 ring buffers/channel * 7.5 Mbytes/ring buffer).
> 
> [...]

Here is the summary with links:
  - [net,1/1] hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes
    https://git.kernel.org/netdev/net/c/6941f67ad37d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



