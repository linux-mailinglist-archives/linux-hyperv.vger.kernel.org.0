Return-Path: <linux-hyperv+bounces-11875-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YsxyHv1zTmo9NAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11875-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 17:59:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3927285DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 17:59:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F5Wu84Vj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11875-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11875-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14B11302FD55
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45741CB3B;
	Wed,  8 Jul 2026 15:59:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41E377003;
	Wed,  8 Jul 2026 15:59:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526378; cv=none; b=MqT7u/hjuwpBEAk1JkTgaqUYSC2ESb9clo3FexhLHd2LGUW81ref4mfi2A72nekL9SshnxYuUvCJSpVEKYAqG1WE2WQlvEFCGSPqC6G8XKeY8N1SNV/wsMPtN9FssQQ6sVMkIRGGviA9+NtT+nJmD146rmlvWqhX7bIhDzNyrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526378; c=relaxed/simple;
	bh=egFSGt8kcBq7+3KTBcUr6rEZnhx2TON5wudYFkUgVRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaC5HssKQa3kBn1DNC9GlFYMJk4oW3Tsrda363/OkpvngeGapVzmdOyMc4N6pBtWNZnG81ZpS1UVFCIYr+4hWJRMazlIFkVVoiodZYdnxRp+Jjl4A9P9My2kYiGQFkksM4hqw2zRRmehfIPwwAhvvpAEzU6Vc1WHJ0lS3Z3XvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5Wu84Vj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236761F00A3D;
	Wed,  8 Jul 2026 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783526376;
	bh=bgHMjrz0F2NAw+WlnQWaUmYDJnFaPfiIHTo3qBDjSJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5Wu84Vj55NlW+FO4CJe3VrjQ/dlbsOXnA6UuuZEYS/0GobWaudc4wJv7O0ESBN+p
	 oXAl89FDn+G1JdiKRN8YMsY1+PvNd/vEKtclVXXzsOXbTsUbkrL+yg9E35muXyJ8m9
	 3f57sVzFqlbr6y8M4GfR13FuhXFvwCev0bcRVZAulCZNl/S3siAbWlH5AvDPld9xl1
	 bZRdR5acXvg8lRNMe0yqaoCbu19CQJ7gKAcSzIyKAg6esgbP6YQ+c1swqZqQFy2k4o
	 5m5O445imASy8joEwTnsqqKMsS5x9115GCVYiIkabHX7I2wXJQcm6Z5uJ+Pvclmlcw
	 YppmNw5DaJuuA==
From: Simon Horman <horms@kernel.org>
To: dipayanroy@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com,
	pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v11 2/2] net: mana: force full-page RX buffers via ethtool private flag
Date: Wed,  8 Jul 2026 16:57:42 +0100
Message-ID: <20260708155741.1509815-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701141808.461554-3-dipayanroy@linux.microsoft.com>
References: <20260701141808.461554-3-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11875-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dipayanroy@linux.microsoft.com,m:horms@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B3927285DE

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: mana: force full-page RX buffers via ethtool private flag

This adds an ethtool private flag "full-page-rx" that forces one RX buffer
per page to avoid a page_pool fragment path throughput regression on some
4K PAGE_SIZE ARM64 platforms. Toggling the flag while the port is up
triggers a mana_detach() + mana_attach() reconfiguration to apply the new
buffer layout.

A few questions inline.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 7438ea6b3f26..38f50b4eef87 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... mana_use_single_rxbuf_per_page() and mana_get_rxbuf_cfg() hunks
      unrelated to the comments below ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 3531abfdaf43..24f6ce63b031 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c

[ ... ]

> @@ -611,6 +630,88 @@ static int mana_get_link_ksettings(struct net_device *ndev,
>  	return 0;
>  }
>  
> +static u32 mana_get_priv_flags(struct net_device *ndev)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +
> +	return apc->priv_flags;
> +}
> +
> +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +	u32 changed = apc->priv_flags ^ priv_flags;
> +	u32 old_priv_flags = apc->priv_flags;
> +	bool schedule_port_reset = false;
> +	int err = 0;
> +
> +	if (!changed)
> +		return 0;
> +
> +	/* Reject unknown bits */
> +	if (priv_flags & ~GENMASK(MANA_PRIV_FLAG_MAX - 1, 0))
> +		return -EINVAL;
> +
> +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> +		apc->priv_flags = priv_flags;

[Low]
Is the storage of priv_flags intentionally nested inside the per-flag
branch?  With only one flag today this is fine, but when a second bit is
added to enum mana_priv_flag_bits, a user toggling only the new bit
passes the !changed and unknown-bits checks, the outer if is skipped,
apc->priv_flags is never updated, and mana_set_priv_flags() returns 0
while mana_get_priv_flags() keeps reporting the old state.

Would it be cleaner to store priv_flags unconditionally after validation
and use per-flag if (changed & BIT(...)) blocks only for the
flag-specific reconfiguration?

> +
> +		if (!apc->port_is_up) {
> +			/* Port is down, flag updated to apply on next up
> +			 * so just return.
> +			 */
> +			return 0;
> +		}
> +
> +		/* Pre-allocate buffers to prevent failure in mana_attach
> +		 * later
> +		 */
> +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);

[Low]
When the MTU is already jumbo (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2) or
XDP is attached, mana_use_single_rxbuf_per_page() already returns true
regardless of the new priv flag:

	if (apc->priv_flags & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF))
		return true;

	/* For xdp and jumbo frames make sure only one packet fits per page. */
	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
		return true;

In that case mana_get_rxbuf_cfg() produces identical output whether the
new flag is on or off, yet toggling the flag here always performs a full
mana_pre_alloc_rxbufs() + mana_detach() + mana_attach() cycle and flaps
the link.

Would a pre/post comparison of mana_get_rxbuf_cfg() output be worth
adding to skip the reconfiguration when nothing actually changes?

[High]
mana_set_priv_flags() drives the same detach/attach sequence used by
mana_set_channels() and mana_per_port_queue_reset_work_handler(), but
does not take apc->vport_mutex and set apc->channel_changing = true
across the window.

The struct comment on channel_changing spells out the invariant:

	/* Set by mana_set_channels() under vport_mutex to block RDMA
	 * from grabbing the vport during the detach/attach window.
	 * Checked by mana_cfg_vport() when called from the RDMA path.
	 */
	bool channel_changing;

Without it, after mana_detach() uncfg's the vport an RDMA client can
call mana_cfg_vport() and bump vport_use_count, and then mana_attach()
will fail with -EBUSY when it re-cfg's the vport.

There is also no equivalent of the '!port_is_up && vport_use_count'
early -EBUSY check that mana_set_channels() performs, so is the flag
allowed to be changed silently while an RDMA client is using the vport?

> +		if (err) {
> +			netdev_err(ndev,
> +				   "Insufficient memory for new allocations\n");
> +			apc->priv_flags = old_priv_flags;
> +			return err;
> +		}
> +
> +		err = mana_detach(ndev, false);

[High]
mana_detach() begins with ASSERT_RTNL(), and so does mana_attach()
called below.  Is RTNL guaranteed to be held on the SET priv-flags path?

mana registers net_shaper_ops in mana_devops, which makes it an
ops-locked driver, so netdev_need_ops_lock() is true and the ethtool
core acquires rtnl only when the driver opts in via
ETHTOOL_OP_NEEDS_RTNL_* for that specific command.

Looking at mana_ethtool_ops.op_needs_rtnl:

	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
				  ETHTOOL_OP_NEEDS_RTNL_GLINK,

ETHTOOL_OP_NEEDS_RTNL_SPFLAGS is not listed, so ASSERT_RTNL() in the
detach/attach helpers below will WARN, and the code races with
RTNL-serialized mutators (mana_open, mana_close, mana_change_mtu,
mana_tx_timeout) that read and write apc->port_is_up, apc->rxqs,
apc->tx_qp and apc->port_st_save.

Should ETHTOOL_OP_NEEDS_RTNL_SPFLAGS be added to op_needs_rtnl, matching
what is already done for SET channels?

> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			apc->priv_flags = old_priv_flags;
> +
> +			/* Port is in an inconsistent state. Restore
> +			 * 'port_is_up' so that queue reset work handler
> +			 * can properly detach and re-attach.
> +			 */
> +			apc->port_is_up = true;
> +			schedule_port_reset = true;
> +			goto out;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			apc->priv_flags = old_priv_flags;
> +
> +			/* Restore 'port_is_up' so the reset work handler
> +			 * can properly detach/attach. Without this,
> +			 * the handler sees port_is_up=false and skips
> +			 * queue allocation, leaving the port dead.
> +			 */
> +			apc->port_is_up = true;
> +			schedule_port_reset = true;

[High]
On this branch, mana_detach() has already succeeded and run
mana_cleanup_port_context(), so apc->rxqs is NULL and queues are torn
down.  Setting apc->port_is_up = true here between now and when
queue_reset_work runs opens a window where callers gate on port_is_up
as their "safe to access rxqs/tx_qp" predicate.

For example, mana_get_ethtool_stats() does:

	if (!apc->port_is_up)
		return;
	...
	rxq = apc->rxqs[q];
	...

A concurrent ethtool -S invocation during that window will pass the
port_is_up gate and dereference apc->rxqs[q]->stats on a NULL rxqs.

Is the port_is_up restore actually needed for the reset work handler's
mana_detach() call?  On the reset path, mana_detach() takes its early
return when !netif_device_present(ndev):

	if (!from_close && !netif_device_present(ndev))
		return 0;

That early return does not touch apc->port_st_save, so the saved state
from the earlier successful mana_detach() should already be intact for
the follow-up mana_attach().

There is also no smp_wmb() paired with this write, unlike the pattern
used inside mana_detach()/mana_attach() proper.

> +		}
> +	}
> +
> +out:
> +	mana_pre_dealloc_rxbufs(apc);
> +
> +	if (schedule_port_reset)
> +		queue_work(apc->ac->per_port_queue_reset_wq,
> +			   &apc->queue_reset_work);
> +
> +	return err;
> +}
> +

[ ... remaining hunks unrelated to the comments above ... ]

