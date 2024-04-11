Return-Path: <linux-hyperv+bounces-1956-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3E8A17D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2001C2048B
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64322DDD2;
	Thu, 11 Apr 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd5AQd9c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA68D534;
	Thu, 11 Apr 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847028; cv=none; b=r5/4x9E0dBNrteonZqQuuDLp+wB2wuyXFYxsx95dqCuAucfEatRSaBv8atQWmeFMl0QTAXMLm1yP8ou8tWhqJXl93pWaaKh3aZDV269H/aJ3zKY/NByf5F7f79H5La5UaiEZlmptzXtPi7HSE4Ww4/BUXcK3yxBS4JmpuOLbT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847028; c=relaxed/simple;
	bh=RK8HPzL73Quew+tMOrVpkfmMzV4s5rg6BXSQRmSLg8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y7rQJEkNKqSqQSAvRxrF3OAGKcJ6Y0lvnWjpyca7CS8VpIbYMZHGcPq03PYzGMgIIS0+w/LS+opr8IbIp5R7srIobXGX3Nd15efnvswQLdlbGG8HwMVtczSxgK3U5fwFKVtqulleMSaPPGaCyT1NC8g3Yw1IcphwAg7EnXHrcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd5AQd9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9A01C113CE;
	Thu, 11 Apr 2024 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712847027;
	bh=RK8HPzL73Quew+tMOrVpkfmMzV4s5rg6BXSQRmSLg8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jd5AQd9c+Y+DVjeZhRA51xRwPAFPk6ny9Nly0y/GGIhczEKr22hWMYCjS18dsAbcm
	 SBvNIG6yngZiZjIFrzq3yM41dxSy5YvzBJXVyvpgBMrdFVf4EVKS2K5cLuPVkNWung
	 3eC9SvbTIAM9/ksLbXoQE93t6AUsWvQTZWbiF1VYooRD0dy7gqU101QW9cCW9oEOnT
	 +MK0xXDmbSEY0Co6guBWZukqGhMkwOSoBhUulamUCMO/9z7fm0RfxIlgXKSB2znv97
	 TSy7J79SVgJFcl5MaxOCfihWDsIeZky6uT++YnsTeenQO7oUvKaNdBFXYujUjq7RDJ
	 Kz6gFOWlrbORg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A465FC4339F;
	Thu, 11 Apr 2024 14:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171284702766.5792.6538200625585720132.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 14:50:27 +0000
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: longli@microsoft.com, sharmaajay@microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 keescook@chromium.org, gustavoars@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 jgg@ziepe.ca, leon@kernel.org, shradhagupta@linux.microsoft.com,
 kotaranov@microsoft.com, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Leon Romanovsky <leon@kernel.org>:

On Sat,  6 Apr 2024 16:23:34 +0200 you wrote:
> The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
> trailing elements. Specifically, it uses a "mana_handle_t" array. So,
> use the preferred way in the kernel declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> [...]

Here is the summary with links:
  - [v3,1/3] net: mana: Add flex array to struct mana_cfg_rx_steer_req_v2
    https://git.kernel.org/netdev/net-next/c/bfec4e18f943
  - [v3,2/3] RDMA/mana_ib: Prefer struct_size over open coded arithmetic
    https://git.kernel.org/netdev/net-next/c/29b8e13a8b4c
  - [v3,3/3] net: mana: Avoid open coded arithmetic
    https://git.kernel.org/netdev/net-next/c/a68292eb4316

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



