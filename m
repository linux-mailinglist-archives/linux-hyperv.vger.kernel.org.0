Return-Path: <linux-hyperv+bounces-5833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855BAAD44E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2D617CA17
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533F286413;
	Tue, 10 Jun 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrwyZMfD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5D2857DE;
	Tue, 10 Jun 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591606; cv=none; b=IfEJcE7KthMccbkOijmfDOq1muZ5/8nPxalsQ8imZMTVEVMhLPDMM4BbnSmV3jzZVt7RJFJs9UwewrcAVFdCMV0lNbvBusqeI+b1ohToNrVZiEqstsaDIYG57SW1eBgBY/eUx/YY4alBnkqRmMqm1YQHVblkQ+osRTTav4OeXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591606; c=relaxed/simple;
	bh=OQ5TxnygLvYZ+w90EqVsIGmUrF7BUzDsm+GgA7XgVQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U+Wso/uH8OwmXvpeByzXT6s8EFyIWT9Rn7PaSXaqkJ3X9DK6btywIComlJbgs3Yt0wiFtvprzOx0zH2TG9K3uIJK5WaUNSQFDpLfvjKVOfGe6HZMSqRnXIGt1KJF+T5DCZ72qhyoRVx6mvUYaamfv1Cq+1iDHGILd9qZY5YjA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrwyZMfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFAAC4CEED;
	Tue, 10 Jun 2025 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749591605;
	bh=OQ5TxnygLvYZ+w90EqVsIGmUrF7BUzDsm+GgA7XgVQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CrwyZMfDv5WiI/r/RyCtx7u+z7wUxJ+GgfZFhh+qm+IjMD76jfDksXA41aItKfUeC
	 u7ge6jJcHpkhYVjwUdY3CkzdKU9h1N6Jdf8nMDR2VZpO3Nd7e2civNYLytbTXlm2OB
	 jVBDXNfAtYoAFudpTUPY/n5GF/fU37IkkINQjx+iPJ1czMmY00er9mbnsA8NGeTq/T
	 gxBMvGBDK+qBBddGkTZVpsl5hasVqUR8BktvvxVtTnwRWB6yyifQTq7GatSYXwBULv
	 VdI9hupDPAPkds/vgTAD05CuNQ869r4AJaagCoBwMWLZLdYCAL/ghVdbCaRycJlsqy
	 8DW9mCa7dRs9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAC38111E3;
	Tue, 10 Jun 2025 21:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mana: Expose additional hardware counters for drop
 and
 TC via ethtool.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959163599.2619474.1037436501592107542.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 21:40:35 +0000
References: 
 <20250609100103.GA7102@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <20250609100103.GA7102@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: andrew+net@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 mhklinux@outlook.com, ernis@linux.microsoft.com, dipayanroy@microsoft.com,
 schakrabarti@linux.microsoft.com, rosenp@gmail.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Jun 2025 03:01:03 -0700 you wrote:
> Add support for reporting additional hardware counters for drop and
> TC using the ethtool -S interface.
> 
> These counters include:
> 
> - Aggregate Rx/Tx drop counters
> - Per-TC Rx/Tx packet counters
> - Per-TC Rx/Tx byte counters
> - Per-TC Rx/Tx pause frame counters
> 
> [...]

Here is the summary with links:
  - net: mana: Expose additional hardware counters for drop and TC via ethtool.
    https://git.kernel.org/netdev/net-next/c/c09ef59e17c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



