Return-Path: <linux-hyperv+bounces-9021-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFXTHHFRoWkfsAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9021-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:10:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C934F1B4454
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70ECD303BB2A
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 08:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C84364931;
	Fri, 27 Feb 2026 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="loERtx6k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F8224AF1;
	Fri, 27 Feb 2026 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179823; cv=none; b=Zw3IqccIYY+qekPIOKXZvUPudbj1k8apOI66JF3ZHlD/XCl3moBhiA+UWwQxfOMHr4HpT1o2D8YlxbZmozMrEIzHcGFg7U+f7C98pXQP0e/1CeQMe9aPQ10PUPN2uFEUDMJzIEhEOsM1zdZbPtSDTYKjlHuHADbah+zEg2ZkxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179823; c=relaxed/simple;
	bh=9uv1uxGBd/zggn1wM9QVCkGvWxWGsRNWA3DinkJadQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPYz/KABOFOsOq7XshjaMVQ0Z9bAfQfxAJ3GVb6AizPLBafp0wBzbX1oABoR+1IGQ/CVRWOt30XkWadqGqf/02wAsou34xRrmGv9QOq+7C/mxr4JV9zs1j+O6z5Ir/GPx7S1kL92wzHZI6YDF036RFc+5D1iXpBsPND0MZp76mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=loERtx6k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 760B720B6F02; Fri, 27 Feb 2026 00:10:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 760B720B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772179821;
	bh=HQREjXSsQWgfv1fDFcG0NHt2zls4/Z9mCGEeEHKrm0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loERtx6kkMc2IJIialfP2+P4FPsJ78GaY1rdl4MOdo2vu9+fqlzkpJXdBH0hN1Zbb
	 blz9KvyMCPqbOM922SIrMTSkXFrL+5AohNgWr0PFGl5vLZGoNQC2NTLb0gzVG2JlzD
	 DqbN9egCtygoJMH/zZHPjPSpFLMLQxwj/DxuYcd8=
Date: Fri, 27 Feb 2026 00:10:21 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Dipayaan Roy <dipayanroy@microsoft.com>
Subject: Re: [PATCH, net-next] net: mana: Trigger VF reset/recovery on health
 check failure due to HWC timeout
Message-ID: <aaFRbSrKFkZXAfIT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aZwUDlTkb5xunIkH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DS3PR21MB5735F00E300CB4B7E54DA710CE72A@DS3PR21MB5735.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS3PR21MB5735F00E300CB4B7E54DA710CE72A@DS3PR21MB5735.namprd21.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9021-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C934F1B4454
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:48:31PM +0000, Long Li wrote:
> > The GF stats periodic query is used as mechanism to monitor HWC health check.
> > If this HWC command times out, it is a strong indication that the device/SoC is in a
> > faulty state and requires recovery.
> > 
> > Today, when a timeout is detected, the driver marks hwc_timeout_occurred,
> > clears cached stats, and stops rescheduling the periodic work. However, the
> > device itself is left in the same failing state.
> > 
> > Extend the timeout handling path to trigger the existing MANA VF recovery
> > service by queueing a GDMA_EQE_HWC_RESET_REQUEST work item.
> > This is expected to initiate the appropriate recovery flow by suspende resume
> > first and if it fails then trigger a bus rescan.
> > 
> > This change is intentionally limited to HWC command timeouts and does not
> > trigger recovery for errors reported by the SoC as a normal command response.
> > 
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 14 +++-------
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 28 ++++++++++++++++++-
> >  include/net/mana/gdma.h                       | 16 +++++++++--
> >  3 files changed, 45 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 0055c231acf6..16c438d2aaa3 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -490,15 +490,9 @@ static void mana_serv_reset(struct pci_dev *pdev)
> >  		dev_info(&pdev->dev, "MANA reset cycle completed\n");
> > 
> >  out:
> > -	gc->in_service = false;
> > +	clear_bit(GC_IN_SERVICE, &gc->flags);
> >  }
> > 
> > -struct mana_serv_work {
> > -	struct work_struct serv_work;
> > -	struct pci_dev *pdev;
> > -	enum gdma_eqe_type type;
> > -};
> > -
> >  static void mana_do_service(enum gdma_eqe_type type, struct pci_dev *pdev)
> > {
> >  	switch (type) {
> > @@ -542,7 +536,7 @@ static void mana_recovery_delayed_func(struct
> > work_struct *w)
> >  	spin_unlock_irqrestore(&work->lock, flags);  }
> > 
> > -static void mana_serv_func(struct work_struct *w)
> > +void mana_serv_func(struct work_struct *w)
> >  {
> >  	struct mana_serv_work *mns_wk;
> >  	struct pci_dev *pdev;
> > @@ -624,7 +618,7 @@ static void mana_gd_process_eqe(struct gdma_queue
> > *eq)
> >  			break;
> >  		}
> > 
> > -		if (gc->in_service) {
> > +		if (test_bit(GC_IN_SERVICE, &gc->flags)) {
> >  			dev_info(gc->dev, "Already in service\n");
> >  			break;
> >  		}
> > @@ -641,7 +635,7 @@ static void mana_gd_process_eqe(struct gdma_queue
> > *eq)
> >  		}
> > 
> >  		dev_info(gc->dev, "Start MANA service type:%d\n", type);
> > -		gc->in_service = true;
> > +		set_bit(GC_IN_SERVICE, &gc->flags);
> >  		mns_wk->pdev = to_pci_dev(gc->dev);
> >  		mns_wk->type = type;
> >  		pci_dev_get(mns_wk->pdev);
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 91c418097284..8da574cf06f2 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -879,7 +879,7 @@ static void mana_tx_timeout(struct net_device *netdev,
> > unsigned int txqueue)
> >  	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> > 
> >  	/* Already in service, hence tx queue reset is not required.*/
> > -	if (gc->in_service)
> > +	if (test_bit(GC_IN_SERVICE, &gc->flags))
> >  		return;
> > 
> >  	/* Note: If there are pending queue reset work for this port(apc), @@ -
> > 3533,6 +3533,8 @@ static void mana_gf_stats_work_handler(struct work_struct
> > *work)  {
> >  	struct mana_context *ac =
> >  		container_of(to_delayed_work(work), struct mana_context,
> > gf_stats_work);
> > +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> > +	struct mana_serv_work *mns_wk;
> >  	int err;
> > 
> >  	err = mana_query_gf_stats(ac);
> > @@ -3540,6 +3542,30 @@ static void mana_gf_stats_work_handler(struct
> > work_struct *work)
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
> 
> Maybe it's not necessary: check if you want to call  clear_bit(GC_IN_SERVICE, &gc->flags) here?
>
yes it makes sense to clear it here. 
> > +				return;
> > +			}
> > +
> > +			mns_wk->pdev = to_pci_dev(gc->dev);
> > +			mns_wk->type = GDMA_EQE_HWC_RESET_REQUEST;
> > +			pci_dev_get(mns_wk->pdev);
> > +			INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> > +			schedule_work(&mns_wk->serv_work);
> > +		}
> >  		return;
> >  	}
> >  	schedule_delayed_work(&ac->gf_stats_work,
> > MANA_GF_STATS_PERIOD); diff --git a/include/net/mana/gdma.h
> 

Regards


