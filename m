Return-Path: <linux-hyperv+bounces-2279-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BB8D7D98
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8FB209D8
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE246A032;
	Mon,  3 Jun 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5eK3gvV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9823383BE;
	Mon,  3 Jun 2024 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404088; cv=none; b=X0TA16Mb3pbaePZcLULsFrglXndAX31Hc4HK3rNG/W9Wdcu7i5GQrYvAAXLyV/UxWCBjM2IgsjTfSHOv7TCX+TQZRuyh31jVmWOk9rvGLQBGV8gOM4UM4/3WPUv4QBa5WG/36ucXl+S+52okOk85qdm+aHrRSLVh6tRn0cWz5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404088; c=relaxed/simple;
	bh=fKoLx7kOYeVfEWenmuVw+KXEUzR3ArFKL0In9YO3j6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNC++AG2gPm8Xh1uXmJ9h1yYSTpb3jNi98c6aVMFZqRfc2hL+ZCO2g28rxEMfWbccffli+yzH7Mm4utaHzPLSu2GNSPlutJA4RFakuvZy/GDWtIfUbk4f4q8RRjuZ8RXumrQs1N4Dw1IfRMJnZh3xf4990Tw61MnA/9jlr+GBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5eK3gvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A961C2BD10;
	Mon,  3 Jun 2024 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717404087;
	bh=fKoLx7kOYeVfEWenmuVw+KXEUzR3ArFKL0In9YO3j6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5eK3gvVgBdd3RmU/4lx4tWmr33Pn0YJBBdp3sp6wDd90SlKHniAGHiuGx9v3A+ZV
	 x7qP3KRBcOrG1FQLT68MMCjufbbCoJz6q0UxQ7MjVexqjCwcg0nqKuw3+fcMaNe4NE
	 Etv3Oo/ONlm/huQEH9PW3pVAomVMG5ww1RFneGBG+rw9ZIY4h4Xx7y+MW60niNjfTD
	 xp7h8KDwe+RVkRc94XRBUOYt3ufp6buIPgk3qPaTgMwuFXEPTEfNMg2XnsN8cwlyAO
	 A0xKNgYWAuxVaBlrBc5afKzeMR+5vCJ0jnLH2lJtv4ChMKyjwRULBg6E06orXjmJil
	 0XLHupbgFxm2Q==
Date: Mon, 3 Jun 2024 11:41:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: mana: Allow variable size indirection
 table
Message-ID: <20240603084122.GK3884@unreal>
References: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, May 31, 2024 at 08:37:41AM -0700, Shradha Gupta wrote:
> Allow variable size indirection table allocation in MANA instead
> of using a constant value MANA_INDIRECT_TABLE_SIZE.
> The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> indirection table is allocated dynamically.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v3:
>  * Fixed the memory leak(save_table) in mana_set_rxfh()
> 
>  Changes in v2:
>  * Rebased to latest net-next tree
>  * Rearranged cleanup code in mana_probe_port to avoid extra operations
> ---
>  drivers/infiniband/hw/mana/qp.c               | 10 +--
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 68 ++++++++++++++++---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 27 +++++---
>  include/net/mana/gdma.h                       |  4 +-
>  include/net/mana/mana.h                       |  9 +--
>  5 files changed, 89 insertions(+), 29 deletions(-)

<...>

> +free_indir:
> +	apc->indir_table_sz = 0;
> +	kfree(apc->indir_table);
> +	apc->indir_table = NULL;
> +	kfree(apc->rxobj_table);
> +	apc->rxobj_table = NULL;
>  reset_apc:
>  	kfree(apc->rxqs);
>  	apc->rxqs = NULL;
> @@ -2897,6 +2936,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  {

<...>

> @@ -2931,6 +2972,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  		}
>  
>  		unregister_netdevice(ndev);
> +		apc->indir_table_sz = 0;
> +		kfree(apc->indir_table);
> +		apc->indir_table = NULL;
> +		kfree(apc->rxobj_table);
> +		apc->rxobj_table = NULL;

Why do you need to NULLify here? Will apc is going to be accessible
after call to mana_remove? or port probe failure?

Thanks

