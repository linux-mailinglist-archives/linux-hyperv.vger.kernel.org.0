Return-Path: <linux-hyperv+bounces-3595-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D973CA04837
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 18:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801331889428
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DB1F3D4F;
	Tue,  7 Jan 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bAxTksmm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF70155CB3;
	Tue,  7 Jan 2025 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270881; cv=none; b=LaZ+b/o8V6XoOYDybD7R5pcsEwLCHrQ6Ne/H5jY3K2QiTWoB1sWTcRGliuxBagf3TGHJiaSARIK+KEmw/HDaXtl8CkkYeyVJbN3Y535XYFIcxeyCH3gzpptOXy6LXbQwwrBbaWqZ6F4FweD8KtkTTO/D2BJa0oEOMIyMEeIebaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270881; c=relaxed/simple;
	bh=Tczwen4MS/hBXH2pRi8eio5oBcRmVFsndg9xuTo0M2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlulS5B96LjHNdVXRsiIs+DEShprNzCynPQPD++a0OR2nRVCwVra53TWpZHk2GwcqFjLFPqs8+oYJfbfDxG5EfCDIGTfyJa0rOh/FN8pyOTv2+L88PB48fOksd36cX3/mwei/06zr6bjxv45av6jncR77zV1/MATwOn3wAcw4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bAxTksmm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBBB1206AB9F;
	Tue,  7 Jan 2025 09:27:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBBB1206AB9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736270872;
	bh=ItJf9Tyt4B5A0+O4eNcPVsd7dIPfzCGXkmtnO0omaxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=bAxTksmmKLnnPeAMUjDpRBkRjaRnTC+IRkHwPjdm8N+X5uvqPSHZvQP8np7/IJcDP
	 SmJ+PXQdvLCZL9EqSeEtNIAvc81OMoNJeDkG/GSNr8hMwVRwBFDEa9bu4f4FsahER0
	 UGLEatintFOItJHiQdbHMu7QTcvVWhFzU4t3bSTA=
Date: Tue, 7 Jan 2025 09:27:50 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Allen Pais
 <apais@linux.microsoft.com>, Vikram Sethi <vsethi@nvidia.com>, Michael
 Frohlich <mfrohlich@microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH] hv_balloon: Fallback to generic_online_page() for
 non-HV hot added mem
Message-ID: <20250107092750.255db61d@DESKTOP-0403QTC.>
In-Reply-To: <SN6PR02MB4157AE0C00C9EE805A78D8D7D4112@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250102213940.413753-1-jacob.pan@linux.microsoft.com>
	<SN6PR02MB4157AE0C00C9EE805A78D8D7D4112@SN6PR02MB4157.namprd02.prod.outlook.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Michael,

On Tue, 7 Jan 2025 00:39:07 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Jacob Pan <jacob.pan@linux.microsoft.com> Sent: Thursday,
> January 2, 2025 1:40 PM
> > 
> > When device memory blocks are hot-added via
> > add_memory_driver_managed(), the HV balloon driver intercepts them
> > but fails to online these memory blocks. This could result in
> > device driver initialization failures.
> > 
> > To address this, fall back to the generic online callback for memory
> > blocks not added by the HV balloon driver. Similar cases are
> > handled the same way in virtio-mem driver.  
> 
> I had a little bit of trouble figuring out what problem this patch is
> solving. Is this a correct description?
> 
>    The Hyper-V balloon driver installs a custom callback for handling
> page onlining operations performed by the memory hotplug subsystem.
> This custom callback is global, and overrides the default callback
>    (generic_online_page) that Linux otherwise uses. The custom
> callback properly handles memory that is hot-added by the balloon
> driver as part of a Hyper-V hot-add region.
> 
>    But memory can also be hot-added directly by a device driver for a
> vPCI device, particularly GPUs. In such a case, the custom callback
> installed by the balloon driver runs, but won't find the page in its
> hot-add region list and doesn't online it, which could cause driver
> initialization failures.
> 
>    Fix this by having the balloon custom callback run
> generic_online_page() when the page isn't part of a Hyper-V hot-add
> region, thereby doing the default Linux behavior. This allows device
> driver hot-adds to work properly. Similar cases are handled the same
> way in the virtio-mem driver.
> 
Yes, your description has the complete story. I was also thinking the
generic code could handle this if the custom callback is not a void
return type. Then we don't have to duplicate the code in here and
virtio-mem, perhaps a separate cleanup effort.

> > 
> > Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> > Tested-by: Michael Frohlich <mfrohlich@microsoft.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_balloon.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index a99112e6f0b8..c999daf34108 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -766,16 +766,18 @@ static void hv_online_page(struct page *pg,
> > unsigned int order)
> >  	struct hv_hotadd_state *has;
> >  	unsigned long pfn = page_to_pfn(pg);
> > 
> > -	guard(spinlock_irqsave)(&dm_device.ha_lock);
> > -	list_for_each_entry(has, &dm_device.ha_region_list, list) {
> > -		/* The page belongs to a different HAS. */
> > -		if (pfn < has->start_pfn ||
> > -		    (pfn + (1UL << order) > has->end_pfn))
> > -			continue;
> > +	scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> > +		list_for_each_entry(has,
> > &dm_device.ha_region_list, list) {
> > +			/* The page belongs to a different HAS. */
> > +			if (pfn < has->start_pfn ||
> > +				(pfn + (1UL << order) >
> > has->end_pfn))
> > +				continue;
> > 
> > -		hv_bring_pgs_online(has, pfn, 1UL << order);
> > -		break;
> > +			hv_bring_pgs_online(has, pfn, 1UL <<
> > order);
> > +			return;
> > +		}
> >  	}
> > +	generic_online_page(pg, order);
> >  }
> > 
> >  static int pfn_covered(unsigned long start_pfn, unsigned long
> > pfn_cnt) --
> > 2.34.1
> >   
> 
> The code LGTM. I'd suggest updating the commit message along the
> lines of what I wrote. My descriptions can be a bit wordy, but
> hopefully they add clarity on the overall picture.
> 
> In any case,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
Will update the commit message in the next version, thanks a lot.

Thanks,

Jacob

