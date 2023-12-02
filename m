Return-Path: <linux-hyperv+bounces-1178-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D4801A94
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 Dec 2023 05:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A751C209EE
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 Dec 2023 04:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF228F59;
	Sat,  2 Dec 2023 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE9/YrLf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF688BFB;
	Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55B81C433C9;
	Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701490824;
	bh=wY26yQIEBbe4Nr9NvsYTLwnEbE6uZhSZJ1xkeUJI2dM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OE9/YrLfJEZhgX63nlNw2azgOcPe/dNf2/yBrovdJdVvFBKdkXS2qTw9Nja5kK/wz
	 LxzeLR02oAuI1PDjhz3qEVYpVTKPvtVySOKGvU1viYdrxmWzR3dCNr4sGJ8Jbz0KgN
	 Ch7FFM6mC5OnqaAXxAWsr+FS4ylJXKBczJYE3I9XN5JvSAeglmV64A6IGn0aySxwQ9
	 bMqQuutpptLKgbKSquJbeahve7MAE+krVxlXfR4jkurvBsqpKodTRDYHUQPcgUACKI
	 vJbbHj8+K8BNgtcX84iv/mtR5L41IIbn12rLINgLI5CdznK+xSeEBxA7+A3ircVWUR
	 IHraTD/zgEKEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F68AC64459;
	Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] hv_netvsc: rndis_filter needs to select NLS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170149082425.6898.11188583894805240877.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 04:20:24 +0000
References: <20231130055853.19069-1-rdunlap@infradead.org>
In-Reply-To: <20231130055853.19069-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, haiyangz@microsoft.com, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, mikelley@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 21:58:53 -0800 you wrote:
> rndis_filter uses utf8s_to_utf16s() which is provided by setting
> NLS, so select NLS to fix the build error:
> 
> ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undefined!
> 
> Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within guests")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org> # build-tested
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [v2] hv_netvsc: rndis_filter needs to select NLS
    https://git.kernel.org/netdev/net/c/6c89f4996437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



