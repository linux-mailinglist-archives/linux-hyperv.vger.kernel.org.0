Return-Path: <linux-hyperv+bounces-9324-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DXpBlqtsWmzEQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9324-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 18:58:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 130042685B1
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 18:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 157C73018E37
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962B63E63BC;
	Wed, 11 Mar 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kscVPh9b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D43E63B6;
	Wed, 11 Mar 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251923; cv=none; b=m6P7Sa382kH0MNTNXtPUIl+G3qvL5mEPbjFY9E6PNfXReIykv3cEOtkhXWjHqTzFYDvtVJ0gPd/YNw5OPwqQmH8teMgYS9B+LZGH3GgdRKdc942L8FUHICA0/KNzMyHxs6sI5+oB/NezUm+FeiiONuYeaeKAYE4t3FUP2nxXWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251923; c=relaxed/simple;
	bh=lPNDgdfcB4TUNnHS7VI9JE0TmqQLeybQYRP4UcSSaNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFLmsMfaGUGU2m3fNHvzYPr892B1Et05RfALaibsl8wvRmPd1n5zr0BmVuotgxR8GE8ZSh2Egab8ROic2EChGvlcUAJcOthC6qVcxQoycVxJRVqAzU+CgL16H4/wykcq8xD4XXltkL6DCh1ta1VT5HxDJ6D5oWUceui0d8pxTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kscVPh9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795DFC4CEF7;
	Wed, 11 Mar 2026 17:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773251923;
	bh=lPNDgdfcB4TUNnHS7VI9JE0TmqQLeybQYRP4UcSSaNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kscVPh9buXHldR5cSapRZK5225/CEjCNzGPhQydrc59SS4rH33BGJcmYOT45JjO+I
	 YwiDKdHat0/pTBdjqiTWakdtqK/PN4e7qPd6WxNNEMu1y+A0xGQ9ujvIF1Evro1LOE
	 nQnaKKz5x08nkFAcka2TpT7vNlr/sd3vTfF3IL1NEvV5/B6VX0l9EA/JJ8LVqm3YkW
	 Sm66rsrcwMAonFEzSAhdmSb/5evAL3M3991WOUo2YMGKvOK9V1aFM/WharohMrz43o
	 LkbR75XtL9uBhZ2B515XLsILb/co+P0d2Zagu+PVDXwAZp+1dD3OP3GQlP/cqcnn/I
	 +jyCpXwHim+8w==
Date: Wed, 11 Mar 2026 17:58:35 +0000
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH net-next,V4, 3/3] net: mana: Add ethtool counters for RX
 CQEs in coalesced type
Message-ID: <20260311175835.GV461701@kernel.org>
References: <20260309212106.764156-1-haiyangz@linux.microsoft.com>
 <20260309212106.764156-4-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309212106.764156-4-haiyangz@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9324-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 130042685B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 02:20:45PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> For RX CQEs with type CQE_RX_COALESCED_4, to measure the coalescing
> efficiency, add counters to count how many contains 2, 3, 4 packets
> respectively.
> Also, add a counter for the error case of first packet with length == 0.
> 
> Reviewed-by: Long Li <longli@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 21 ++++++++++++++++++-
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 15 +++++++++++--
>  include/net/mana/mana.h                       |  9 +++++---
>  3 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index fa30046dcd3d..85f7a56d0d90 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2148,11 +2148,23 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
>  		old_buf = NULL;
>  		pktlen = oob->ppi[i].pkt_len;
>  		if (pktlen == 0) {
> -			if (i == 0)
> +			/* Collect coalesced CQE count based on packets processed.
> +			 * Coalesced CQEs have at least 2 packets, so index is i - 2.
> +			 */
> +			if (i > 1) {
> +				u64_stats_update_begin(&rxq->stats.syncp);
> +				rxq->stats.coalesced_cqe[i - 2]++;
> +				u64_stats_update_end(&rxq->stats.syncp);
> +			} else if (i == 0) {
> +				/* Error case stat */
> +				u64_stats_update_begin(&rxq->stats.syncp);
> +				rxq->stats.pkt_len0_err++;
> +				u64_stats_update_end(&rxq->stats.syncp);
>  				netdev_err_once(
>  					ndev,
>  					"RX pkt len=0, rq=%u, cq=%u, rxobj=0x%llx\n",
>  					rxq->gdma_id, cq->gdma_id, rxq->rxobj);
> +			}
>  			break;

Hi Haiyang Zhang,

As there is a break here, can the accounting logic above be move out of the
loop, and merged with the "Coalesced CQE with all 4 packets" accounting
logic that is already there?

As is, accounting seems split between and slightly duplicated in two locations.


>  		}
>  
> @@ -2175,6 +2187,13 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
>  		if (!coalesced)
>  			break;
>  	}
> +
> +	/* Coalesced CQE with all 4 packets */
> +	if (coalesced && i == MANA_RXCOMP_OOB_NUM_PPI) {
> +		u64_stats_update_begin(&rxq->stats.syncp);
> +		rxq->stats.coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 2]++;
> +		u64_stats_update_end(&rxq->stats.syncp);
> +	}
>  }
>  
>  static void mana_poll_rx_cq(struct mana_cq *cq)

...

