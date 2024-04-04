Return-Path: <linux-hyperv+bounces-1916-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D039E897DC4
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Apr 2024 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700EC1F27C1E
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Apr 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6A1CABB;
	Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXVwxse+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E8EEB2;
	Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198427; cv=none; b=CSDRzRPRKgOQTS7eLJw+0snzj+ytt6IQhDKX0jWCFbSqvKSlSKQQPTgp4r0p+Nasc4dIYBlXW8uGz/XQDr4g0ZqevzljSXqhb2erA4m0+0uBFJnDNX0KtsAP9R9HibaGJf9aWa0yKf8omr/0R6tr3ACQvMdop37OS4zIVVtEVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198427; c=relaxed/simple;
	bh=z1iXLvkFfv7cvcYmpQ/4o3DzldKRSGogDcrjWfkz/no=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hAgq1+PHMe/XQmz54vkJM+94bagcQMIic9rdEqKL2pJVUOFuUOhvdgSekXYIpu4x+u9OphCvrBqHWTsU4NdiP95NYKt/otBZhA/Ev1kzefzCMTJ2vGSR3UeXQhLa0Aap6JJ/eZMIjh7p9ZOtL0+dtLNI6e7zojOWLDrBjqmSADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXVwxse+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F9DC433F1;
	Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712198427;
	bh=z1iXLvkFfv7cvcYmpQ/4o3DzldKRSGogDcrjWfkz/no=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pXVwxse+4leHQBCAqngVCssZ1Db/s7EX/otUfWPT8kcdnZlyzTP7XAki1eODxVXlv
	 sRUnbNgRIKG+k4AI1koZH1px3gFXjfiMditk/+ecmOikQq68Z77/yf6EKmdnoZe08u
	 fafw/k4+9FxQwdM1Vzu/TyMtWC1VS9Bxy1V0qyzx+9MbYr5T6Ui5fjy6CUkTqggFCV
	 qRLXXKYmVd7xrvpw+ZcIRBdlawvjotu7VcwLsV5zRfE5Z0cwqD6aUp31mDic+QpHKz
	 BlCO4q0ESelNHxfmzCRtp+zgs1i+0HlAGdAZ000PPj1OxmF0OK7v1CEoRCH3gnwFhV
	 Eltyt/Bk0Jfmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31064C43168;
	Thu,  4 Apr 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] net: mana: Fix Rx DMA datasize and skb_over_panic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219842719.31127.17495935498454370650.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:40:27 +0000
References: <1712087316-20886-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1712087316-20886-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
 hawk@kernel.org, tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 12:48:36 -0700 you wrote:
> mana_get_rxbuf_cfg() aligns the RX buffer's DMA datasize to be
> multiple of 64. So a packet slightly bigger than mtu+14, say 1536,
> can be received and cause skb_over_panic.
> 
> Sample dmesg:
> [ 5325.237162] skbuff: skb_over_panic: text:ffffffffc043277a len:1536 put:1536 head:ff1100018b517000 data:ff1100018b517100 tail:0x700 end:0x6ea dev:<NULL>
> [ 5325.243689] ------------[ cut here ]------------
> [ 5325.245748] kernel BUG at net/core/skbuff.c:192!
> [ 5325.247838] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 5325.258374] RIP: 0010:skb_panic+0x4f/0x60
> [ 5325.302941] Call Trace:
> [ 5325.304389]  <IRQ>
> [ 5325.315794]  ? skb_panic+0x4f/0x60
> [ 5325.317457]  ? asm_exc_invalid_op+0x1f/0x30
> [ 5325.319490]  ? skb_panic+0x4f/0x60
> [ 5325.321161]  skb_put+0x4e/0x50
> [ 5325.322670]  mana_poll+0x6fa/0xb50 [mana]
> [ 5325.324578]  __napi_poll+0x33/0x1e0
> [ 5325.326328]  net_rx_action+0x12e/0x280
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: Fix Rx DMA datasize and skb_over_panic
    https://git.kernel.org/netdev/net/c/c0de6ab920aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



