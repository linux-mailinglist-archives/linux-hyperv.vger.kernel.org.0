Return-Path: <linux-hyperv+bounces-9162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI58HP5Uqml4PgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9162-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 05:15:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8921B6A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 05:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D1730247C4
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 04:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E319E7F7;
	Fri,  6 Mar 2026 04:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="MD6j8Fw0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFC33689D;
	Fri,  6 Mar 2026 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770555; cv=pass; b=L980LY4YB/t5zqGxU863WR4y5YR2eTs6hc9TxJZHKY4z8yC+PBYMhhUqulKCZGYkOvB1kYpmPkFkXuy3Uu4mw2skVn09eGodkgrmWzKproEMd9U83voYz3+277wNZoq3Y7oOuh15jwno5bYe6pEGzBk8Yxhp4DaG6bMMkpJtx+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770555; c=relaxed/simple;
	bh=jHC65XaYoMCSHA23ebQiu+UADl6aqRyAI5p9pv6yHlA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ffBgNQ1po/JRx/CnJ7L6YWqyz++l97E+ftpgKHRNBak+4h2N2UgLRiHtR+wn1yOg6BGfPdFaEVZSSNJS828hR3uUjEfpuyCHI09hiD0JYiic3tFXJdhx81zoUXim+oWvHXbW7zVcAJ0Cvvq0ius7MkpfJXCHGURZeniWYqDG9QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=MD6j8Fw0; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1772770543; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nsbo1JvzxIIPekkx7t/JFdO67xxMgeKp/VSLUzWCIvi7z6ccYFlT6el4duZvusHvahIUGQM+lvUcfKur+ym1DrC5A4xMe/vrp75jdLlaUwGSSyzvRvBomWz0IZT/Df84S5KfF5X0+wL6FxLe8O7Q/BLNaZQmuQ4uJjpNLx9YT0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772770543; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Okb+pKFoGKXNccmHfQDwZBc1RVYi05QbQMe3OEjvVi0=; 
	b=HAF8gGptiJXtn9vnPiwrXTv7Ttfbxz4bY2ecynBGaQ5uTLkVRJrP8ANQo3BvK13hZTi+s1zoOGfovCoe/aU8LvjknizwqNdWtbq8nQk1jKPr8Rj2PyW/oWROeYyM69kYogwYLYT1TQNVXx2tunAPoH1BenwDyKScKbdgmwZRMAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772770543;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:References:In-Reply-To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Okb+pKFoGKXNccmHfQDwZBc1RVYi05QbQMe3OEjvVi0=;
	b=MD6j8Fw0UD6V28sxug8f2JBvcj99m5s939Ip6rgcj0YrD2U6qo9Jph1mAPBfwvYb
	iFBtaek6Qv44Y+qmsH6q2YPhR1PgyV0M8Gu/mHuyYNJw8uIMaQ4krI7TNZWU4BLQ3Mk
	IGMMSv6qSAu7Mz9t2Iav0G6pOfGdS9Fqw1FTZONY=
Received: by mx.zohomail.com with SMTPS id 1772770541660636.72017219885;
	Thu, 5 Mar 2026 20:15:41 -0800 (PST)
From: <mhklkml@zohomail.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>,
	"'Stanislav Kinsburskii'" <skinsburskii@linux.microsoft.com>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>
Cc: <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net> <177258383107.229866.16867493994305727391.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net> <SN6PR02MB4157C408547E59A469C5CE08D47DA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157C408547E59A469C5CE08D47DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH 4/4] mshv: Pre-deposit pages for SLAT creation
Date: Thu, 5 Mar 2026 20:15:40 -0800
Message-ID: <000901dcad1f$e53772c0$afa65840$@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGf/CXhq+vihj2DXZ0/OE6Cmc0kFAJtpOXpAlJETLa19Ed7oA==
Feedback-ID: rr080112274a9d8f6f82b56b3ad15f471400001b9f91f2f60bf88c84ff54b72b6d237cb3464b9a8d64d772b7:zu080112270253bd582d2ae8e3b2e2f6d90000edd6d65966646bbff30bd1f085dd05796ad579f6ed23bbcdef:rf0801122c4fe6348f407b1754ff4f171f0000e729ffb8e1b954e9707b12cfa85c5fb9f5debe16117856dc9f88f8807fb2:ZohoMail
X-ZohoMailClient: External
X-Rspamd-Queue-Id: C7C8921B6A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9162-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com,microsoft.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, March 5, 2026 11:45 AM
> 
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, March
3, 2026 4:24 PM
> >
> > Deposit enough pages up front to avoid guest address space region creation
> > failures due to low memory. This also speeds up guest creation.
> >
> > Calculate the required number of pages based on the guest's physical
> > address space size, rounded up to 1 GB chunks. Even the smallest guests are
> > assumed to need at least 1 GB worth of deposits. This is because every
> > guest requires tens of megabytes of deposited pages for hypervisor
> > overhead, making smaller deposits impractical.
> >
> > Estimating in 1 GB chunks prevents over-depositing for larger guests while
> > accepting some over-deposit for smaller ones. This trade-off keeps the
> > estimate close to actual needs for larger guests.
> >
> > Also withdraw the deposited pages if address space region creation fails.
> >
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |   25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 48c842b6938d..cb5b4505f8eb 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -39,6 +39,7 @@
> >  #define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
> >  #define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)
> >  #define MSHV_VP_DEPOSIT_PAGES			(1 * SZ_1M >> PAGE_SHIFT)
> > +#define MSHV_1G_DEPOSIT_PAGES			(6 * SZ_1M >> PAGE_SHIFT)
> >
> >  MODULE_AUTHOR("Microsoft");
> >  MODULE_LICENSE("GPL");
> > @@ -1324,6 +1325,18 @@ static int mshv_prepare_pinned_region(struct
mshv_mem_region *region)
> >  	return ret;
> >  }
> >
> > +static u64
> > +mshv_region_deposit_slat_pages(struct mshv_mem_region *region)
> 
> Same nit about the function name. This one seems like it will "deposit slat pages".
> 
> > +{
> > +	u64 region_in_gbs, slat_pages;
> > +
> > +	/* SLAT needs 6 MB per 1 GB of address space. */
> > +	region_in_gbs = DIV_ROUND_UP(region->nr_pages << HV_HYP_PAGE_SHIFT, SZ_1G);
> 
> This local variable "region_in_gbs" is computed in units of bytes.

Ignore this comment and the following one in this function. I saw the
ROUND_UP(), but somehow failed to see that it was DIV_ROUND_UP().  :-(

Michael

> 
> > +	slat_pages = region_in_gbs * MSHV_1G_DEPOSIT_PAGES;
> 
> But here region_in_gbs is used as if it were in units of Gbytes.  So the
> slat_pages return value is much larger than intended.
> 
> > +
> > +	return slat_pages;
> > +}
> > +
> >  /*
> >   * This maps two things: guest RAM and for pci passthru mmio space.
> >   *
> > @@ -1364,6 +1377,11 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  	if (ret)
> >  		return ret;
> >
> > +	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
> > +				    mshv_region_deposit_slat_pages(region));
> > +	if (ret)
> > +		goto free_region;
> > +
> >  	switch (region->mreg_type) {
> >  	case MSHV_REGION_TYPE_MEM_PINNED:
> >  		ret = mshv_prepare_pinned_region(region);
> > @@ -1392,7 +1410,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  				   region->hv_map_flags, ret);
> >
> >  	if (ret)
> > -		goto errout;
> > +		goto withdraw_memory;
> >
> >  	spin_lock(&partition->pt_mem_regions_lock);
> >  	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
> > @@ -1400,7 +1418,10 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >
> >  	return 0;
> >
> > -errout:
> > +withdraw_memory:
> > +	hv_call_withdraw_memory(mshv_region_deposit_slat_pages(region),
> > +				NUMA_NO_NODE, partition->pt_id);
> 
> Again, for an L1VH partition, the actual number of pages deposited would
> be 2x what mshv_region_deposit_slat_pages() returns.
> 
> > +free_region:
> >  	vfree(region);
> >  	return ret;
> >  }
> >
> >
> 



