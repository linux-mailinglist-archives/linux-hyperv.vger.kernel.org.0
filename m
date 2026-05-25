Return-Path: <linux-hyperv+bounces-11181-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LUxGOEBFGquIQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11181-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 10:01:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C295C7628
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 323CF3003D09
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516B43CD8BB;
	Mon, 25 May 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oi8TQ0x3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA415ECCC;
	Mon, 25 May 2026 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696095; cv=none; b=nP9xyzll4yLfSdzdWnJgpYepwsK/7s8i/rF7H/GeZr07+69Sg8nzpXeYmQw2yy45K8q996XalkYwkfJkTpnn11pyp9eK+yUa05TnzibJ/9A5mqkWH2i/Wya9rsfqhox0EAzEdB0Q65F6PqXX4jnga8IEuiAmUxXqmkTnpXQugSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696095; c=relaxed/simple;
	bh=DqNzwrd0I5meiHoTPh1oTbGQ2oglAwf0hjhojpIZtjw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRTxVkzys5VDHMeacJcEmS/D+RAu48CVdEOqLmLLV3CHgEKTCWhkUd3pNEAuMOGIJo0fXkL6D5zQlKexGmPPDFcnMhWgc17M7sft+y12ZZh2dyI9VvX9/foA5Hp2Pm1iphJcaCvMNQ3UVt+s1YBFTmzWy1/Vh88Z9FZc+rs6TYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oi8TQ0x3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id C3A6920B7166; Mon, 25 May 2026 01:01:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3A6920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779696077;
	bh=a/3OpYSo7pi6L2H8KYxVX0pCbOmL1iviVE9A8mWM6fU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=oi8TQ0x3y+QA64J+IjyUy33bkzwlppB+pb0CmgiDCkAEmWEdVn6MsiP4GZ6fi9jhc
	 YYEdCNV/yqS++KqDW3oT7gp2SKN/rWcSKesJFv5ZzGJ02WvvN3+hTpi+g60xK7k1Jh
	 F5ZDkRKeCKORE8Whs+sPJDZDUghCAmwd3mAwpMRc=
Date: Mon, 25 May 2026 01:01:17 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net v2 1/2] net: mana: Add NULL guards in teardown path
 to prevent panic on attach failure
Message-ID: <ahQBzTUrhzvsy22C@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260522233555.1099342-1-dipayanroy@linux.microsoft.com>
 <20260522233555.1099342-2-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522233555.1099342-2-dipayanroy@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11181-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 00C295C7628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 04:33:12PM -0700, Dipayaan Roy wrote:
> When queue allocation fails partway through, the error cleanup frees
> and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
> mana_remove(), mana_change_mtu() recovery, and internal error handling
> in mana_alloc_queues() can subsequently call into functions that
> dereference these pointers without NULL checks:
> 
> - mana_chn_setxdp() dereferences apc->rxqs[0], causing a NULL pointer
>   dereference panic (CR2: 0000000000000000 at mana_chn_setxdp+0x26).
> - mana_destroy_vport() iterates apc->rxqs without a NULL check.
> - mana_fence_rqs() iterates apc->rxqs without a NULL check.
> - mana_dealloc_queues() iterates apc->tx_qp without a NULL check.
> 
> Add NULL guards for apc->rxqs in mana_fence_rqs(),
> mana_destroy_vport(), and before the mana_chn_setxdp() call. Add a
> NULL guard for apc->tx_qp in mana_dealloc_queues() to skip TX queue
> draining when TX queues were never allocated or already freed.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Hi, 

I will send a v3 to fix the fixes tag issue highlighted in:
https://netdev-ctrl.bots.linux.dev/logs/build/1099669/14590738/verify_fixes/summary

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 70 +++++++++++--------
>  1 file changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9afc786b297a..0582803907a8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1727,6 +1727,9 @@ static void mana_fence_rqs(struct mana_port_context *apc)
>  	struct mana_rxq *rxq;
>  	int err;
>  
> +	if (!apc->rxqs)
> +		return;
> +
>  	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
>  		rxq = apc->rxqs[rxq_idx];
>  		err = mana_fence_rq(apc, rxq);
> @@ -2858,13 +2861,16 @@ static void mana_destroy_vport(struct mana_port_context *apc)
>  	struct mana_rxq *rxq;
>  	u32 rxq_idx;
>  
> -	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
> -		rxq = apc->rxqs[rxq_idx];
> -		if (!rxq)
> -			continue;
> +	if (apc->rxqs) {
>  
> -		mana_destroy_rxq(apc, rxq, true);
> -		apc->rxqs[rxq_idx] = NULL;
> +		for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
> +			rxq = apc->rxqs[rxq_idx];
> +			if (!rxq)
> +				continue;
> +
> +			mana_destroy_rxq(apc, rxq, true);
> +			apc->rxqs[rxq_idx] = NULL;
> +		}
>  	}
>  
>  	mana_destroy_txq(apc);
> @@ -3269,7 +3275,8 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	if (apc->port_is_up)
>  		return -EINVAL;
>  
> -	mana_chn_setxdp(apc, NULL);
> +	if (apc->rxqs)
> +		mana_chn_setxdp(apc, NULL);
>  
>  	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
>  		mana_pf_deregister_filter(apc);
> @@ -3287,33 +3294,38 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	 * number of queues.
>  	 */
>  
> -	for (i = 0; i < apc->num_queues; i++) {
> -		txq = &apc->tx_qp[i].txq;
> -		tsleep = 1000;
> -		while (atomic_read(&txq->pending_sends) > 0 &&
> -		       time_before(jiffies, timeout)) {
> -			usleep_range(tsleep, tsleep + 1000);
> -			tsleep <<= 1;
> -		}
> -		if (atomic_read(&txq->pending_sends)) {
> -			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
> -			if (err) {
> -				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> -					   err, atomic_read(&txq->pending_sends),
> -					   txq->gdma_txq_id);
> +	if (apc->tx_qp) {
> +		for (i = 0; i < apc->num_queues; i++) {
> +			txq = &apc->tx_qp[i].txq;
> +			tsleep = 1000;
> +			while (atomic_read(&txq->pending_sends) > 0 &&
> +			       time_before(jiffies, timeout)) {
> +				usleep_range(tsleep, tsleep + 1000);
> +				tsleep <<= 1;
> +			}
> +			if (atomic_read(&txq->pending_sends)) {
> +				err =
> +				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
> +				if (err) {
> +					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> +						   err,
> +					    atomic_read(&txq->pending_sends),
> +					    txq->gdma_txq_id);
> +				}
> +				break;
>  			}
> -			break;
>  		}
> -	}
>  
> -	for (i = 0; i < apc->num_queues; i++) {
> -		txq = &apc->tx_qp[i].txq;
> -		while ((skb = skb_dequeue(&txq->pending_skbs))) {
> -			mana_unmap_skb(skb, apc);
> -			dev_kfree_skb_any(skb);
> +		for (i = 0; i < apc->num_queues; i++) {
> +			txq = &apc->tx_qp[i].txq;
> +			while ((skb = skb_dequeue(&txq->pending_skbs))) {
> +				mana_unmap_skb(skb, apc);
> +				dev_kfree_skb_any(skb);
> +			}
> +			atomic_set(&txq->pending_sends, 0);
>  		}
> -		atomic_set(&txq->pending_sends, 0);
>  	}
> +
>  	/* We're 100% sure the queues can no longer be woken up, because
>  	 * we're sure now mana_poll_tx_cq() can't be running.
>  	 */
> -- 
> 2.43.0
> 

