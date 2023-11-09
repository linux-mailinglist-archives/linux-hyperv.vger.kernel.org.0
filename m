Return-Path: <linux-hyperv+bounces-815-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C083E7E620E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 03:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5FA281151
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 02:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5915A1;
	Thu,  9 Nov 2023 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb4b226A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502F4C8F;
	Thu,  9 Nov 2023 02:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C46C433C7;
	Thu,  9 Nov 2023 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699496000;
	bh=CIfWFmoLFCkhaqyQ5UtCPzZFqwtq4QVkAFXMOQeAhyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tb4b226AHLMk/bHc4vzM6Gv0V5XrNewAX5nu+rrNis/m+mV+43a3g7SyHvOrfJ0tF
	 +zmRR8OTFtUnKt0C4G44zVNEynBy2qNh+Tr5AhO1gi4qlNt2DR1MUC/P+8kyVI/tvO
	 JGLm2GpNxozNWFCaf5xaYPNi8Mtzea/XoLFTlsV7RjLvGXgINJmCz61csbuFYae6Io
	 HwRQTfLlXN0JaXzUTfZfuMo20KkJS8D/0gSRa172S2oFSswuvRJNEcnDy4pOPnJubD
	 XckToT4r04J3+BqRyhtKBTRfKdZ4FDUJIbp8oD+qCF/vwojzndVZPBNsPa/DVQHHAF
	 OOSu1FWJVUAOA==
Date: Wed, 8 Nov 2023 18:13:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231108181318.5360af18@kernel.org>
In-Reply-To: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Nov 2023 14:56:52 -0800 longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When a VF is being exposed form the kernel, it should be marked as "slave"
> before exposing to the user-mode. The VF is not usable without netvsc running
> as master. The user-mode should never see a VF without the "slave" flag.
> 
> An example of a user-mode program depending on this flag is cloud-init
> (https://github.com/canonical/cloud-init/blob/19.3/cloudinit/net/__init__.py)

Quick grep for "flags", "priv" and "slave" doesn't show anything.
Can you point me to the line of code?

> When scanning interfaces, it checks on if this interface has a master to
> decide if it should be configured. There are other user-mode programs perform
> similar checks.
> 
> This commit moves the code of setting the slave flag to the time before VF is
> exposed to user-mode.

> Change since v3:
> Change target to net-next.

You don't consider this a fix? It seems like a race condition.

> -		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
> -			netdev_notice(vf_netdev,
> -				      "falling back to mac addr based matching\n");
> +		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
> +		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))

This change doesn't seem to be described in the commit message.

Please note that we have a rule against reposting patches within 24h:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

