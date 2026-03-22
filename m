Return-Path: <linux-hyperv+bounces-9686-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHYeDJo5wGkvFAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9686-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Mar 2026 19:48:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BB2EA5EE
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Mar 2026 19:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2572E3002B00
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Mar 2026 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571C37648D;
	Sun, 22 Mar 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6BjiTr8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6F36E465;
	Sun, 22 Mar 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205336; cv=none; b=DLSMnQ15ZJo5SPzIwhb0/Yphr0kfmSdDu/YZ/pWrYfWPkmZElJVa41ZxnUZ7A+LwDUGaU692z6x7IOZflY8ZNNGkmVq0Ztvc7MJBCZ97RwMFk72IAH4Jy1RwT/DLahRaMu9vpWpR538Is4HII1vx4lmU0K7tWf2Zcfw3ScFI+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205336; c=relaxed/simple;
	bh=3wRlSaja4dFFdIlJqdkm0iC9QbRkFhHiOXjrVmCrmVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At0/oCAsKrbhYyDNHKdnJe49IFDPLct+lcg9Qim+mhSQqZ3lNyrA0NXOfncbu9tKHVp3CmF65R0rvg9ONKDjmcAn6bzKcodqcaVw0qI7C13PgWAogMD2qH0DyEcUlbBRH2XLDFKneOpej0YiJrV4ATml0YZLtsSmFbJ1fmMVi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6BjiTr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21850C19424;
	Sun, 22 Mar 2026 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774205335;
	bh=3wRlSaja4dFFdIlJqdkm0iC9QbRkFhHiOXjrVmCrmVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6BjiTr8psw7SP7NU1Ga1kTmbUM3oFks3OrLuUZFQB/E9SAIAVEJ91gQZ296ozwBY
	 BeTKd6aFNyzCA+MawWHnAS2U4kNDFcTlW5tjblzNFBb783Bw/zOqDnHnjDuSSxxWG9
	 Qpgyigc0yg+qnSp0I83xoNovR0EpJR8aBsecF4kWi2LlCTshcxeqgGPomhBteByG2Z
	 X2kBzvohLu53VE1SNV6yTMr599KUcNSWJNQhlYexD0wffUXOhOqNLVLnpZqgKEVl8N
	 +C1vUJxSfsO0zPSsu9KEjaOsn+6AQYGCsNS5TNXy8HJno1N5Wq40eCDW03XAHcn0Xx
	 9PLjFbNmKBHCw==
Date: Sun, 22 Mar 2026 20:48:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH rdma] RDMA/mana_ib: Disable RX steering on RSS QP destroy
Message-ID: <20260322184848.GC814676@unreal>
References: <20260321002842.1607179-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321002842.1607179-1-longli@microsoft.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9686-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B00BB2EA5EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 05:28:42PM -0700, Long Li wrote:
> When an RSS QP is destroyed (e.g. DPDK exit), mana_ib_destroy_qp_rss()
> destroys the RX WQ objects but does not disable vPort RX steering in
> firmware. This leaves stale steering configuration that still points to
> the destroyed RX objects.
> 
> If traffic continues to arrive (e.g. peer VM is still transmitting) and
> the VF interface is subsequently brought up (mana_open), the firmware
> may deliver completions using stale CQ IDs from the old RX objects.
> These CQ IDs can be reused by the ethernet driver for new TX CQs,
> causing RX completions to land on TX CQs:
> 
>   WARNING: mana_poll_tx_cq+0x1b8/0x220 [mana]  (is_sq == false)
>   WARNING: mana_gd_process_eq_events+0x209/0x290 (cq_table lookup fails)
> 
> Fix this by disabling vPort RX steering before destroying RX WQ objects.
> Note that mana_fence_rqs() cannot be used here because the fence
> completion is delivered on the CQ, which is polled by user-mode (e.g.
> DPDK) and not visible to the kernel driver.
> 
> Refactor the disable logic into a shared mana_disable_vport_rx() in
> mana_en, exported for use by mana_ib, replacing the duplicate code.
> The ethernet driver's mana_dealloc_queues() is also updated to call
> this common function.
> 
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/qp.c               | 17 ++++++++++++++++-
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 11 ++++++++++-
>  include/net/mana/mana.h                       |  1 +
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 80cf4ade4b75..b27084c53a14 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -829,11 +829,26 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
>  	struct net_device *ndev;
>  	struct mana_ib_wq *wq;
>  	struct ib_wq *ibwq;
> -	int i;
> +	int i, err;
>  
>  	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
>  	mpc = netdev_priv(ndev);
>  
> +	/* Disable vPort RX steering before destroying RX WQ objects.
> +	 * Otherwise firmware still routes traffic to the destroyed queues,
> +	 * which can cause bogus completions on reused CQ IDs when the
> +	 * ethernet driver later creates new queues on mana_open().
> +	 *
> +	 * Unlike the ethernet teardown path, mana_fence_rqs() cannot be
> +	 * used here because the fence completion CQE is delivered on the
> +	 * CQ which is polled by userspace (e.g. DPDK), so there is no way
> +	 * for the kernel to wait for fence completion.
> +	 */
> +	err = mana_disable_vport_rx(mpc);
> +	if (err)
> +		ibdev_err(&mdev->ib_dev,
> +			  "Failed to disable vPort RX: %d\n", err);

mana_cfg_vport_steering() is already prints in all failure scenarios.

Thanks

> +
>  	for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
>  		ibwq = ind_tbl->ind_tbl[i];
>  		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 22444c7530a5..51719ef1c09b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2934,6 +2934,13 @@ static void mana_rss_table_init(struct mana_port_context *apc)
>  			ethtool_rxfh_indir_default(i, apc->num_queues);
>  }
>  
> +int mana_disable_vport_rx(struct mana_port_context *apc)
> +{
> +	return mana_cfg_vport_steering(apc, TRI_STATE_FALSE, false, false,
> +				       false);
> +}
> +EXPORT_SYMBOL_NS(mana_disable_vport_rx, "NET_MANA");
> +
>  int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
>  		    bool update_hash, bool update_tab)
>  {
> @@ -3339,10 +3346,12 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	 */
>  
>  	apc->rss_state = TRI_STATE_FALSE;
> -	err = mana_config_rss(apc, TRI_STATE_FALSE, false, false);
> +	err = mana_disable_vport_rx(apc);
>  	if (err && mana_en_need_log(apc, err))
>  		netdev_err(ndev, "Failed to disable vPort: %d\n", err);
>  
> +	mana_fence_rqs(apc);
> +
>  	/* Even in err case, still need to cleanup the vPort */
>  	mana_destroy_rxqs(apc);
>  	mana_destroy_txq(apc);
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 204c2b612a62..2634e9135eed 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -574,6 +574,7 @@ struct mana_port_context {
>  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
>  int mana_config_rss(struct mana_port_context *ac, enum TRI_STATE rx,
>  		    bool update_hash, bool update_tab);
> +int mana_disable_vport_rx(struct mana_port_context *apc);
>  
>  int mana_alloc_queues(struct net_device *ndev);
>  int mana_attach(struct net_device *ndev);
> -- 
> 2.43.0
> 

