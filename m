Return-Path: <linux-hyperv+bounces-2446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB790C118
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2024 03:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2891F224C8
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2024 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEAB1D531;
	Tue, 18 Jun 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl9W8qs8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7F1CD39;
	Tue, 18 Jun 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673031; cv=none; b=TSEpsZlVzRUJMduH09ue0Ve8REFmBFZt+HKpK/384e9Mq9CWgO5tpoEmUuecINVezwKjMnRjBs6GEW1Ia0tgb1vy0Qt7EJrbtkgZxG892lgEsLfJ3G/CXMmgTGtbcJ8GsK1w8Tx6dYI6o2WqZPY2wWzCJRpuB24x37c+8odi5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673031; c=relaxed/simple;
	bh=TsMx1cRC6kI5WzXKv9nNIBTGc4Np8d2AEZmiWV7MBTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vxm+Nmmsa1vLS0BnisThcja2zidwR/hUZ6cgBfaxzsgTOnnJ7XJjQR9G4j141SkkTjyAfC1Mip3xxQZQcgBFf5T9yZNWC+oVV3AiQq5+RDdNNUqZxKdVZo4My+1hOplwSCMQYkpCmv5FVsa27aPWqbdmDHSlTORJtA2gT7h/83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl9W8qs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AE8EC4DDF1;
	Tue, 18 Jun 2024 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673030;
	bh=TsMx1cRC6kI5WzXKv9nNIBTGc4Np8d2AEZmiWV7MBTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dl9W8qs8489ULVgeqVbNx+TJHCRFoKyGqK4f4nSgBQoIo5wrOlYJ3thGCqlAoAyod
	 nFHEjZT9rtILpPwODdliN/qoGC3vQYvFuyiypZIQXnBJyGxM6pHXL1m1klY18UhHEO
	 Zzs9kySZVM35HU0rNgmB1bTNtx1va6L1YGeZ1XxqFT9u2lEMGVUWpBXsuYOcns1QDE
	 qw/G4JVtoBkrc8oghs5rQcXfgsjBX6ANCzZj73RXfVBsV8DGi8OShZBHW+mRROdiM4
	 eBTTk9I7vKjNlIgIIvlfwAtqNE3EgaStr+SujkUDUE1wBbPXjnedNFjrTjMQzIA9L8
	 ziPyRxln3yX3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2C59D2D0FA;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: Use mana_cleanup_port_context() for rxq
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302999.10892.13105498225110195396.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:29 +0000
References: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, schakrabarti@linux.microsoft.com,
 erick.archer@outlook.com, kotaranov@microsoft.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, shradhagupta@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 00:19:08 -0700 you wrote:
> To cleanup rxqs in port context structures, instead of duplicating the
> code, use existing function mana_cleanup_port_context() which does
> the exact cleanup that's needed.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: mana: Use mana_cleanup_port_context() for rxq cleanup
    https://git.kernel.org/netdev/net-next/c/e275e19c918b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



