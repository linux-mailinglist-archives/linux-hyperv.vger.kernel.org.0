Return-Path: <linux-hyperv+bounces-9020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHf1GMpQoWkfsAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9020-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:07:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68131B4417
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 709F73050D6B
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202433563E1;
	Fri, 27 Feb 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f8CefGH6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208A33A709;
	Fri, 27 Feb 2026 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179622; cv=none; b=Rmq4y6NbfCRhTvhB/IqKAvAe3CmoY8Ym2Stb88O4XARivTwt3jKb5jkbzqv8fwDseJGXJttQmuEMXPYYvwFDyK8tCq3YBw2Xd1Dp+kz+43MxqTKDbrh3UMXrGpQnart84Q4GV1wIOAlbdGdSqWEBD7NFUq1hUt6AWKZxUxr1rZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179622; c=relaxed/simple;
	bh=MYeiqeUz0+cYZL1vIL2doQLbHsHiezb/fmgpGe1KrMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR5ypKxTO2GIjn5y8s9yFNjq3mFdClUeCd0Dhzxw7O51mKLyOBoJxN9uc2M4OtMFQ4OQexZ9zoENUesHYO96Nxlx+i2XVJd1DFaM5AbdEZMcx/lqjf12Xj1BUoYfHOjD/cUDn1APP4b6xJyRiVzOtj4C0WL804NgIex58R2rtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f8CefGH6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 6D5EB20B6F02; Fri, 27 Feb 2026 00:07:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D5EB20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772179620;
	bh=cmvpUzkiSyC2ORyghMCYrVOpIg4j/U0+skDpYexndIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8CefGH6pUzoj6NkCRIDfvYGJCac/23ZuIIBWoq7LGug9Q7tVCehLQLMgz9hZ8OMZ
	 TEI9MZrK2GABBRYQpi7N9SF4vV+vVRztIF8HdS84Memxp0caDH0aeDmGQRb6RS/4ve
	 VL4VrJD20bg0OeO7hXemXV9Ui2aNHOvEKV6rVicQ=
Date: Fri, 27 Feb 2026 00:07:00 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, decui@microsoft.com, pabeni@redhat.com,
	dipayanroy@microsoft.com, kotaranov@microsoft.com,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	davem@davemloft.net, linux-rdma@vger.kernel.org,
	shradhagupta@linux.microsoft.com, kys@microsoft.com,
	ssengar@linux.microsoft.com, haiyangz@microsoft.com,
	linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
	netdev@vger.kernel.org, longli@microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	andrew+netdev@lunn.ch
Subject: Re: [net-next] net: mana: Trigger VF reset/recovery on health check
 failure due to HWC timeout
Message-ID: <aaFQpJG0GP6898e/@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aZwUDlTkb5xunIkH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260224082641.130868-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224082641.130868-1-horms@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9020-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B68131B4417
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:26:41AM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout
> 
> The GF stats periodic query is used as mechanism to monitor HWC health
> check. If this HWC command times out, it is a strong indication that
> the device/SoC is in a faulty state and requires recovery.
> 
> Today, when a timeout is detected, the driver marks
> hwc_timeout_occurred, clears cached stats, and stops rescheduling the
> periodic work. However, the device itself is left in the same failing
> state.
> 
> Extend the timeout handling path to trigger the existing MANA VF
> recovery service by queueing a GDMA_EQE_HWC_RESET_REQUEST work item.
> This is expected to initiate the appropriate recovery flow by suspende
> resume first and if it fails then trigger a bus rescan.
> 
> This change is intentionally limited to HWC command timeouts and does
> not trigger recovery for errors reported by the SoC as a normal command
> response.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 0055c231acf6..16c438d2aaa3 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 9b5a72ada5c4..e6a4034b40f9 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> 
> [ ... ]
> 
> > @@ -3530,6 +3530,8 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
> >  {
> >  	struct mana_context *ac =
> >  		container_of(to_delayed_work(work), struct mana_context, gf_stats_work);
> > +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> > +	struct mana_serv_work *mns_wk;
> >  	int err;
> >
> >  	err = mana_query_gf_stats(ac);
> > @@ -3537,6 +3539,30 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
> >  		/* HWC timeout detected - reset stats and stop rescheduling */
> >  		ac->hwc_timeout_occurred = true;
> >  		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
> > +		dev_warn(gc->dev,
> > +			 "Gf stats wk handler: gf stats query timed out.\n");
> > +
> > +		/* As HWC timed out, indicating a faulty HW state and needs a
> > +		 * reset.
> > +		 */
> > +		if (!test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
> > +			if (!try_module_get(THIS_MODULE)) {
> > +				dev_info(gc->dev, "Module is unloading\n");
> > +				return;
> > +			}
> > +
> > +			mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> > +			if (!mns_wk) {
> > +				module_put(THIS_MODULE);
> > +				return;
> > +			}
> 
> Does this leave the GC_IN_SERVICE flag permanently set? When
> test_and_set_bit() atomically sets the bit and then try_module_get()
> fails or kzalloc() fails, the function returns without clearing
> GC_IN_SERVICE.
> 
> This would permanently block all future recovery attempts. Looking at
> mana_gd_process_eqe() in gdma_main.c:
>
ACK. 
> 	if (test_bit(GC_IN_SERVICE, &gc->flags)) {
> 		dev_info(gc->dev, "Already in service\n");
> 		break;
> 	}
> 
> It would detect the set bit and skip the reset. Similarly, mana_tx_timeout()
> in mana_en.c would also short-circuit:
> 
> 	if (test_bit(GC_IN_SERVICE, &gc->flags))
> 		return;
> 
> The device cannot recover without manual intervention since the flag is only
> cleared by mana_serv_reset() at the end of the service work:
> 
> drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_serv_reset()
> {
> 	...
> out:
> 	clear_bit(GC_IN_SERVICE, &gc->flags);
> }
> 
> But since the work is never scheduled in these error paths, clear_bit() is
> never called.
> 
> Note that the existing mana_gd_process_eqe() path avoids this problem by
> calling set_bit(GC_IN_SERVICE) only AFTER all allocations succeed:
> 
> drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_process_eqe()
> {
> 	...
> 	if (test_bit(GC_IN_SERVICE, &gc->flags)) {
> 		dev_info(gc->dev, "Already in service\n");
> 		break;
> 	}
> 
> 	if (!try_module_get(THIS_MODULE)) {
> 		...
> 		break;
> 	}
> 
> 	mns_wk = kzalloc(sizeof(*mns_wk), GFP_KERNEL);
> 	if (!mns_wk) {
> 		module_put(THIS_MODULE);
> 		break;
> 	}
> 
> 	dev_info(gc->dev, "Start MANA service type:%d\n", type);
> 	set_bit(GC_IN_SERVICE, &gc->flags);  // Set only after success
> 	...
> }
> 
> Should clear_bit(GC_IN_SERVICE, &gc->flags) be added before each error
> return?
> 
ACK.
> > +
> > +			mns_wk->pdev = to_pci_dev(gc->dev);
> > +			mns_wk->type = GDMA_EQE_HWC_RESET_REQUEST;
> > +			pci_dev_get(mns_wk->pdev);
> > +			INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> > +			schedule_work(&mns_wk->serv_work);
> > +		}
> 
> This isn't a bug, but the recovery initiation sequence here is a
> near-duplicate of the pattern in mana_gd_process_eqe() (gdma_main.c).
> Both perform the identical 7-step sequence: try_module_get, kzalloc
> mana_serv_work, set pdev, set type, pci_dev_get, INIT_WORK, schedule_work.
> 
> The duplication already contributed to the GC_IN_SERVICE error path issue
> above, where this new copy diverged from the original in its error handling.
> 
> Consider extracting a common helper to avoid divergence.
> 
ACK.
> >  		return;
> >  	}
> >  	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
> 
> [ ... ]

Thanks Simon, I am addressing these in v2.

Regards

