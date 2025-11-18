Return-Path: <linux-hyperv+bounces-7674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF3BC67342
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 05:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13D554ED7E1
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 04:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05EA242D9D;
	Tue, 18 Nov 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NInvcvL/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1235CBA5;
	Tue, 18 Nov 2025 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438460; cv=none; b=H7HALtduN9Vpq3tbjNw7h6vesreTZ3KjNjv7ZUJrNsoRsd24zaN/tCIQhnkcGY5JFMigYvdvTBDWm0AjQ4LEHaMlujRbKqlyXJvyGjanh1mH8SXgiGDhry8IrF1dDl0AgcT0sLmVo/KMaDE83OsHMuBxfulWXzT8ebg4gUHEdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438460; c=relaxed/simple;
	bh=QJnMpqaql+M1a9+Ul2s/BidVW4uDvaX/cSm5Cf4o+ho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gv/9KY5l8mtDfYzs5D1HINpjtd59eqy9gYVQzqPcVjEc834gOJ7BaUdTZLrBZSdbLEAbvSmXiWKtltrKyOLMBzwoOL/6MZZAZcALLOGe2jYuWTHqQLggGx7p8zRr122bn/YUaiQaFgZLecawkJNhdrYCbqZ7lIpLFxmYkphLE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NInvcvL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8BAC116D0;
	Tue, 18 Nov 2025 04:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438459;
	bh=QJnMpqaql+M1a9+Ul2s/BidVW4uDvaX/cSm5Cf4o+ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NInvcvL/JbNusz02kXMbUJwXLZ5zLZ8xd5VKDcJlcLdnMsLGz3SLIPxsEIfC4QjgY
	 0bt8I/SYdy2uLWvF42UtCRCt5IT690Jh48dXorSXcHYt/CKVnrI6Nh64ux3RTkhQ8M
	 me4X2ODEm1pNiN6ltimJGw1tN65kD/Wv2hq77gFsRLAU9rT8t6U3aASD31L2OohNNo
	 3dGr6R8NxTPSW1+APLYzs0Ny7ej2nINaS4BYqglMKbzCsnA6OY2tmRIMOuNi3MPixc
	 oxgPbR2faeYmaSZsp8RnVlMs/qm01gAwRazObLXkLHJWcIoWQuNPxNGmXY47hzL97S
	 Pih7I47LkOalQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF243809A1C;
	Tue, 18 Nov 2025 04:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: mana: Refactor GF stats handling and
 add
 rx_missed_errors counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176343842550.3578356.18200043929984849136.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 04:00:25 +0000
References: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 sbhatta@marvell.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Nov 2025 03:43:17 -0800 you wrote:
> Restructure mana_query_gf_stats() to operate on the per-VF mana_context,
> instead of per-port statistics. Introduce mana_ethtool_hc_stats to
> isolate hardware counter statistics and update the
> "ethtool -S <interface>" output to expose all relevant counters while
> preserving backward compatibility.
> 
> Add support for the standard rx_missed_errors counter by mapping it to
> the hardware's hc_rx_discards_no_wqe metric. Introduce a
> global workqueue that refreshes statistics every 2 seconds, ensuring
> timely and consistent updates of hardware counters.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: mana: Move hardware counter stats from per-port to per-VF context
    https://git.kernel.org/netdev/net-next/c/e275d9091c01
  - [net-next,v3,2/2] net: mana: Add standard counter rx_missed_errors
    https://git.kernel.org/netdev/net-next/c/be4f1d67ec56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



