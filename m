Return-Path: <linux-hyperv+bounces-1102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1ED7FBC85
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41F11C20C57
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447415ABAD;
	Tue, 28 Nov 2023 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UKCi5/sf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5293AC1;
	Tue, 28 Nov 2023 06:16:42 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 992F520B74C0; Tue, 28 Nov 2023 06:16:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 992F520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701181000;
	bh=JTSxRPuPoUMjGKOv3Wz11crg13aNlR7BOqiwlqR1PEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKCi5/sfTOxnwV6M5bYGvN5xrkLW8IQAo8zEC7Dfk1v6x8yFX3yagSJQO5KGTD2jj
	 R9uRLfJdqAFPYYWdDtDqO7BCcRJhoqcqnMMnTubLI51O+uyHrdZaM5ruYXwfcqFUuQ
	 +iqQq8vkJ3zEHg64X47Mv2VTo5Q1h+7AJfEAu0BY=
Date: Tue, 28 Nov 2023 06:16:40 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: mana: Fix spelling mistake "enforecement" ->
 "enforcement"
Message-ID: <20231128141640.GA29976@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20231128095304.515492-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128095304.515492-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 28, 2023 at 09:53:04AM +0000, Colin Ian King wrote:
> There is a spelling mistake in struct field hc_tx_err_sqpdid_enforecement.
> Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c      | 2 +-
>  drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 4 ++--
>  include/net/mana/mana.h                            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 6b857188b9da..bc65cc83b662 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2445,7 +2445,7 @@ void mana_query_gf_stats(struct mana_port_context *apc)
>  	apc->eth_stats.hc_tx_err_eth_type_enforcement =
>  					     resp.tx_err_ethtype_enforcement;
>  	apc->eth_stats.hc_tx_err_sa_enforcement = resp.tx_err_SA_enforcement;
> -	apc->eth_stats.hc_tx_err_sqpdid_enforecement =
> +	apc->eth_stats.hc_tx_err_sqpdid_enforcement =
>  					     resp.tx_err_SQPDID_enforcement;
>  	apc->eth_stats.hc_tx_err_cqpdid_enforcement =
>  					     resp.tx_err_CQPDID_enforcement;
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 7077d647d99a..777e65b8223d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -43,8 +43,8 @@ static const struct {
>  	 offsetof(struct mana_ethtool_stats, hc_tx_err_eth_type_enforcement)},
>  	{"hc_tx_err_sa_enforcement", offsetof(struct mana_ethtool_stats,
>  					      hc_tx_err_sa_enforcement)},
> -	{"hc_tx_err_sqpdid_enforecement",
> -	 offsetof(struct mana_ethtool_stats, hc_tx_err_sqpdid_enforecement)},
> +	{"hc_tx_err_sqpdid_enforcement",
> +	 offsetof(struct mana_ethtool_stats, hc_tx_err_sqpdid_enforcement)},
>  	{"hc_tx_err_cqpdid_enforcement",
>  	 offsetof(struct mana_ethtool_stats, hc_tx_err_cqpdid_enforcement)},
>  	{"hc_tx_err_mtu_violation", offsetof(struct mana_ethtool_stats,
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 5567f5bc8eb6..76147feb0d10 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -368,7 +368,7 @@ struct mana_ethtool_stats {
>  	u64 hc_tx_err_vlan_enforcement;
>  	u64 hc_tx_err_eth_type_enforcement;
>  	u64 hc_tx_err_sa_enforcement;
> -	u64 hc_tx_err_sqpdid_enforecement;
> +	u64 hc_tx_err_sqpdid_enforcement;
>  	u64 hc_tx_err_cqpdid_enforcement;
>  	u64 hc_tx_err_mtu_violation;
>  	u64 hc_tx_err_inval_oob;
> -- 
> 2.39.2
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

