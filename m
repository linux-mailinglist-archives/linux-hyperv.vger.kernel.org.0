Return-Path: <linux-hyperv+bounces-8965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JFxKt1gnWkDPAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8965-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 09:27:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC76183A39
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 09:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B2130244F3
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253636681D;
	Tue, 24 Feb 2026 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQwH/GL+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D306366552;
	Tue, 24 Feb 2026 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921625; cv=none; b=qalVr+vKfpTPKx2qfRTpe/nA7O0GneXKUgVI119kS7tf+UTdik2/id4UdapQFaYcl1tWMKrNvmwvf01vIeLs1E0YJdNKJ5twTVvY+x1YxO13WFwtg094YhX1nlSzquY6yBlIIcc1pMAJIICcDyvo9rvVW61zLrdrurcpfVOihPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921625; c=relaxed/simple;
	bh=5BIsjw2n9+mZDFSucxJ7xTsOVD5l8tfQvmSHZ4IJIrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4kE8XJKNWKydbaIkSYxYWMLwZZXYA0HJZWUIsimDX1Btc6fln7t7q3fnrleXb8LLEwVBcKj2Nfm5DO4ypG+yaxZNzTpj32qXog5GSSB60HYg5z0VDubh5s9UAvb3XnyTg1dS0pmp7b+KfNhrREnXW6auoHFcRSvyROhiRW4OHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQwH/GL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D52C19423;
	Tue, 24 Feb 2026 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921625;
	bh=5BIsjw2n9+mZDFSucxJ7xTsOVD5l8tfQvmSHZ4IJIrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQwH/GL+OG1XXnKIflNZBESOQ40d+rNrLwLg9GmFTrVaA6zUaaiKqglNVYubO01C2
	 f3/8kFrHjxwCykMW7sgSsXCcfMLfJhzZsNPvwv10EFv/2/kb48oGSxKoBabN59gNXA
	 ptKn5zYcHYDsd9erpoqg9qtIDoJt1MiyzX3HhuxArEU42W0LBurEIfRWMA7j9P6I/9
	 sKz6HtySf5UdHtDWcCXA7FdKM5e3K7gi46aAQUx0bCmh5+H3uhiSrT7hh/uZo+YHw8
	 NEW+VV9ulpTbWW6jeUUobAip/JIEUO91a3m1/y4gUWnwYQ4cL0eRXowgRnmTFgjvQX
	 YWYExbxu1jXDw==
From: Simon Horman <horms@kernel.org>
To: dipayanroy@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	decui@microsoft.com,
	pabeni@redhat.com,
	dipayanroy@microsoft.com,
	kotaranov@microsoft.com,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	linux-rdma@vger.kernel.org,
	shradhagupta@linux.microsoft.com,
	kys@microsoft.com,
	ssengar@linux.microsoft.com,
	haiyangz@microsoft.com,
	linux-hyperv@vger.kernel.org,
	wei.liu@kernel.org,
	netdev@vger.kernel.org,
	longli@microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	andrew+netdev@lunn.ch
Subject: Re: [net-next] net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout
Date: Tue, 24 Feb 2026 08:26:41 +0000
Message-ID: <20260224082641.130868-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aZwUDlTkb5xunIkH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aZwUDlTkb5xunIkH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-8965-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 3CC76183A39
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout

The GF stats periodic query is used as mechanism to monitor HWC health
check. If this HWC command times out, it is a strong indication that
the device/SoC is in a faulty state and requires recovery.

Today, when a timeout is detected, the driver marks
hwc_timeout_occurred, clears cached stats, and stops rescheduling the
periodic work. However, the device itself is left in the same failing
state.

Extend the timeout handling path to trigger the existing MANA VF
recovery service by queueing a GDMA_EQE_HWC_RESET_REQUEST work item.
This is expected to initiate the appropriate recovery flow by suspende
resume first and if it fails then trigger a bus rescan.

This change is intentionally limited to HWC command timeouts and does
not trigger recovery for errors reported by the SoC as a normal command
response.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 0055c231acf6..16c438d2aaa3 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9b5a72ada5c4..e6a4034b40f9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -3530,6 +3530,8 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
>  {
>  	struct mana_context *ac =
>  		container_of(to_delayed_work(work), struct mana_context, gf_stats_work);
> +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> +	struct mana_serv_work *mns_wk;
>  	int err;
>
>  	err = mana_query_gf_stats(ac);
> @@ -3537,6 +3539,30 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
>  		/* HWC timeout detected - reset stats and stop rescheduling */
>  		ac->hwc_timeout_occurred = true;
>  		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
> +		dev_warn(gc->dev,
> +			 "Gf stats wk handler: gf stats query timed out.\n");
> +
> +		/* As HWC timed out, indicating a faulty HW state and needs a
> +		 * reset.
> +		 */
> +		if (!test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
> +			if (!try_module_get(THIS_MODULE)) {
> +				dev_info(gc->dev, "Module is unloading\n");
> +				return;
> +			}
> +
> +			mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> +			if (!mns_wk) {
> +				module_put(THIS_MODULE);
> +				return;
> +			}

Does this leave the GC_IN_SERVICE flag permanently set? When
test_and_set_bit() atomically sets the bit and then try_module_get()
fails or kzalloc() fails, the function returns without clearing
GC_IN_SERVICE.

This would permanently block all future recovery attempts. Looking at
mana_gd_process_eqe() in gdma_main.c:

	if (test_bit(GC_IN_SERVICE, &gc->flags)) {
		dev_info(gc->dev, "Already in service\n");
		break;
	}

It would detect the set bit and skip the reset. Similarly, mana_tx_timeout()
in mana_en.c would also short-circuit:

	if (test_bit(GC_IN_SERVICE, &gc->flags))
		return;

The device cannot recover without manual intervention since the flag is only
cleared by mana_serv_reset() at the end of the service work:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_serv_reset()
{
	...
out:
	clear_bit(GC_IN_SERVICE, &gc->flags);
}

But since the work is never scheduled in these error paths, clear_bit() is
never called.

Note that the existing mana_gd_process_eqe() path avoids this problem by
calling set_bit(GC_IN_SERVICE) only AFTER all allocations succeed:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_process_eqe()
{
	...
	if (test_bit(GC_IN_SERVICE, &gc->flags)) {
		dev_info(gc->dev, "Already in service\n");
		break;
	}

	if (!try_module_get(THIS_MODULE)) {
		...
		break;
	}

	mns_wk = kzalloc(sizeof(*mns_wk), GFP_KERNEL);
	if (!mns_wk) {
		module_put(THIS_MODULE);
		break;
	}

	dev_info(gc->dev, "Start MANA service type:%d\n", type);
	set_bit(GC_IN_SERVICE, &gc->flags);  // Set only after success
	...
}

Should clear_bit(GC_IN_SERVICE, &gc->flags) be added before each error
return?

> +
> +			mns_wk->pdev = to_pci_dev(gc->dev);
> +			mns_wk->type = GDMA_EQE_HWC_RESET_REQUEST;
> +			pci_dev_get(mns_wk->pdev);
> +			INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> +			schedule_work(&mns_wk->serv_work);
> +		}

This isn't a bug, but the recovery initiation sequence here is a
near-duplicate of the pattern in mana_gd_process_eqe() (gdma_main.c).
Both perform the identical 7-step sequence: try_module_get, kzalloc
mana_serv_work, set pdev, set type, pci_dev_get, INIT_WORK, schedule_work.

The duplication already contributed to the GC_IN_SERVICE error path issue
above, where this new copy diverged from the original in its error handling.

Consider extracting a common helper to avoid divergence.

>  		return;
>  	}
>  	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);

[ ... ]

