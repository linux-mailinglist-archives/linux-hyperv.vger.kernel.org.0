Return-Path: <linux-hyperv+bounces-8285-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D379D1C4A2
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 04:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E82D300251B
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 03:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7702D8764;
	Wed, 14 Jan 2026 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfjnGxO9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FD13DDAE;
	Wed, 14 Jan 2026 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362225; cv=none; b=fYdg6OmlW5W25SLBRFqPyCclINj+/pl5LleIkc/405B7aMcnGr5llPxO4Z7kcXUJERVy2fcw9TuH/WnSiGkX1UOADM0xzJuy/oM6cZgFii8VUbWBhJzVKNzIRfNIj1tea7G8dBXirYqn6nSIWd0qqfFXGFHQqeEH/e11UUso1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362225; c=relaxed/simple;
	bh=fsm+RbfBmzE3HHaX362NezsDg0pqF6wDy7Rk3jWR5B8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nFRj1yG+gPc1J+8po/fSwB8uA6oTZ/Y28a0xzWornEqf0S7a17Z3+0ZCwLpNbjiNXEy0p6/m4w7JvZCnRWO++jtJo5qn2abASEL2JrKYoF0bspSbFgBpzR4hjHNopxylWSdcCRj3Odt3Dx7sSXLZIWVwPDTwv8sLLvpqmVsbklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfjnGxO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC44C4CEF7;
	Wed, 14 Jan 2026 03:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768362225;
	bh=fsm+RbfBmzE3HHaX362NezsDg0pqF6wDy7Rk3jWR5B8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NfjnGxO9p8v8tgyYZ1YLhipRYtvtuDQMcttpYqDdA5nkVicBUVIP6ZiIrwUg+QFOq
	 PNAsvPKQh8TcV7D4n8HAFdrlmLiyf1v4xT5OZ6iaBokBAG0vYlP5iVRLT4u1eJiFDz
	 GGxeem/NiqhIlbI9MYXUk7sV74em/ptwbYPmeEbIuxgOFgb7nnxDBFOXpmMaUh5w7B
	 Jp23alHSDsViJVw+clYHoAPnTX3fMSIM5M80FnEtVSfjUM6P1NjFz5SVuAy4zNJU+Y
	 pWH++LTXpCfPaIyJ7CEyk99A8fZ65D7zE+x39SXgSLRoz7xUZANcLPsHuPi/XYihOX
	 v8ezxOgq1fyrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58EE3808200;
	Wed, 14 Jan 2026 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next, v8] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836201827.2575016.15589980289559695566.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:40:18 +0000
References: 
 <20260112130552.GA11785@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <20260112130552.GA11785@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 05:05:52 -0800 you wrote:
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> and a device-controlled port reset for all queues can be scheduled to a
> ordered workqueue. The reset for all queues on stall detection is
> recomended by hardware team.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net: mana: Implement ndo_tx_timeout and serialize queue resets per port.
    https://git.kernel.org/netdev/net-next/c/3b194343c250

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



