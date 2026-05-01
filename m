Return-Path: <linux-hyperv+bounces-10546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGCaModu9GlrBQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10546-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 11:12:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D04AB2EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 11:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 312403022955
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531737D136;
	Fri,  1 May 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYOZysQz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B23366DB5;
	Fri,  1 May 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626729; cv=none; b=Rqr/O0O0mK7GHT/7n7uDQyUb/VENvGjYvOeNZR01Cot3UN7Vh/6sQ8zXGGzTgmcsWd9W1YxJTl75XgwfCJSaNyQ6s7yUgw/j50LAQ2vPz0FFO08u+uuaLUlmol39FhtwiN2NGrZv3+K/ZFfrZpwBVGwFsMMD72ao13BHVDbj0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626729; c=relaxed/simple;
	bh=NOrf6mzvHrRgZjfbm7D186ZX9Ny1YSByLo/xre4YKqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG9nb/tWpOiCCmIfgHHY8EmMDAF/JLxndmDD3UqkhHJ4XjB3/sZV361izxp3TeRzvCKa4Tb7FvExQmHwL79Mhxgb7fSWTvbkU0S3d5IfyvdXmakUfV4bztGSk/sJFCF7fY9q/gfzNt2IeLwwWg7w4+mugBc699Tz3l5pRdCRes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYOZysQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B2AC2BCC4;
	Fri,  1 May 2026 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626729;
	bh=NOrf6mzvHrRgZjfbm7D186ZX9Ny1YSByLo/xre4YKqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYOZysQz+19iJ00qjZ0CCHDAAI1rZoXgodL2k49ovZfoyVMzq6TYwUo9AMhhou8f/
	 KzaTjjZoDWtufssBEWinn0hZAnByGj14f9KwOH2DlrHrllAc2Uoyn2Is6scBa+4cm8
	 xuaArVJY9DhMzi61QJmlNb/7cgxXSFrGwBzcqMYF8dBerkrjUdOyOkxP9U0NGY6n4t
	 0yCAY6oz4b98qRTJ8qM+W+IXG1zXZqKU60mt9gaLhwW3229jXOHTBMbT/NmAgJIFeA
	 28Vi705FQAWlhfXF46InVyr/eJwaostreDjw72tN6CPca+PlUyBqf27BbhJag2l38T
	 NCWO+4HjyXb9Q==
Date: Fri, 1 May 2026 10:12:02 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <20260501091202.GA15617@horms.kernel.org>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
X-Rspamd-Queue-Id: 794D04AB2EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10546-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]

On Wed, Apr 29, 2026 at 02:06:37AM -0700, Shradha Gupta wrote:
> In mana driver, the number of IRQs allocated is capped by the
> min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> than the vcpu count, we want to utilize all the vCPUs, irrespective of
> their NUMA/core bindings.
> 
> This is important, especially in the envs where number of vCPUs are so
> few that the softIRQ handling overhead on two IRQs on the same vCPU is
> much more than their overheads if they were spread across sibling vCPUs.
> 
> This behaviour is more evident with dynamic IRQ allocation. Since MANA
> IRQs are assigned at a later stage compared to static allocation, other
> device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> weights become imbalanced, causing multiple MANA IRQs to land on the
> same vCPU, while some vCPUs have none.
> 
> In such cases when many parallel TCP connections are tested, the
> throughput drops significantly.

...

> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org
> Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> Changes in v2
>  * Removed the unused skip_first_cpu variable
>  * fixed exit condition in irq_setup_linear() with len == 0
>  * changed return type of irq_setup_linear() as it will always be 0
>  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
>  * added appropriate comments to indicate expected behaviour when
>    IRQs are more than or equal to num_online_cpus()

Reviewed-by: Simon Horman <horms@kernel.org>

