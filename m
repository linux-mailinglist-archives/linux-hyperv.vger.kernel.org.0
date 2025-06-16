Return-Path: <linux-hyperv+bounces-5921-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D36ADB595
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1553B7AD850
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FF2652B6;
	Mon, 16 Jun 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L5r5Sqk7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB282676F3;
	Mon, 16 Jun 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087969; cv=none; b=eT+2a4hhtwlL+vf4MqoxDVQV2LQNLzyOfA1qRvnYXjBN4ZGj4zwFg0KmRPLpP+L4PScmPneF7AP7Nd/xZUOf8bUTbI7Mlzdga4fTxWAd0ovTFe+xbhywrZH2/75CWeNMv3RG1lQHZXjTc9J29tRJYl4A2PDkmElTwKlN3hEQono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087969; c=relaxed/simple;
	bh=5bDrO8l5JTUQ/0A+AsMqyeLX6KEFEC59MT2EY3ySsGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwxO1SBgwIAIJK50f16UIIMcVIe5JgojK1ClPkp7hBu0I2W0NX2RcZMWQ8BPQVo6VpavPkAm0m2jeWEQtlum6lqwsY4KxUex6eIgSWMBICVvvyqQEFLkbaTGUdyNUNrlDSflNdGNjCniL2vlfJdKvU01bbfjvoVpXo6jQTmMh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L5r5Sqk7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 61F8C21176C4; Mon, 16 Jun 2025 08:32:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61F8C21176C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750087962;
	bh=rhCl/uIDccRxuHm7p7vGNDxXrJwG78AgR0V8kl4GkVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5r5Sqk7EL10qA9Shyceo+mnNV2S/l1gibd6X17xn67cbHy4J2zZbtBY5q+FyBKz4
	 W1Y9q5En/imJ+0FYpDr1xW4O/OC2iA0BlMJrDXpGJUkAcDlVSt/+Zi3jgWNE8DIpVW
	 KD+jj+sqm8h0GnzgY0UY5jVfFcpQ5hLfrDjjt5Qk=
Date: Mon, 16 Jun 2025 08:32:42 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: longli@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [Patch net-next v2] net: mana: Record doorbell physical address
 in PF mode
Message-ID: <20250616153242.GB23702@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749836765-28886-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749836765-28886-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jun 13, 2025 at 10:46:05AM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> MANA supports RDMA in PF mode. The driver should record the doorbell
> physical address when in PF mode.
> 
> The doorbell physical address is used by the RDMA driver to map
> doorbell pages of the device to user-mode applications through RDMA
> verbs interface. In the past, they have been mapped to user-mode while
> the device is in VF mode. With the support for PF mode implemented,
> also expose those pages in PF mode.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Changes
> v2: add more details in commit message on how the doorbell physical address is used
> 
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 3504507477c6..52cf7112762c 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -31,6 +31,9 @@ static void mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->db_page_base = gc->bar0_va +
>  				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
>  
> +	gc->phys_db_page_base = gc->bar0_pa +
> +				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
> +
>  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
>  
>  	sriov_base_va = gc->bar0_va + sriov_base_off;
> -- 
> 2.25.1

Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>


