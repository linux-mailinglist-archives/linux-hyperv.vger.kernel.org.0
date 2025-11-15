Return-Path: <linux-hyperv+bounces-7607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33AC6012F
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 766B44E14C9
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF315ADB4;
	Sat, 15 Nov 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="dmKBQl8j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13D2B9A4;
	Sat, 15 Nov 2025 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763192370; cv=pass; b=q4GiWK/GpEgYxmCYnBcoyuclWHL4SZXZpO5n5F+7o8w6yZn+8BA1S9GyP14Odt1iP4925mharL2d7pR1aeOBu39ulhSPRTC7nizJ0/n/4bHtw4nDPQrEAY3BLOqcfKu5vJDN3oIWT+6OnmWvY4WdQDQyjtZvTcWgQwtHP02tuK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763192370; c=relaxed/simple;
	bh=zhoK87McsMhLdUYjLb9xKWON9L5IPxh5v2emuHG0Tds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIJ63mKjCk21RHLlBGgcHnCkS5EAvOFhqa82ADY2QJKQOAM3WEzGlauuR7TN4OXC+Fe64FE/pquVviAVbTyxNdp/PZwfbyjIrCoc7Yd9BhIe0JiCMTk65QSlOClwfYFJkOUGxPiCj5V/cahP1Y7jKYdkf9XpRjE2ODRFmSUtijI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=dmKBQl8j; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763192360; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MtYioCe88U750wO9L4QpMNEBQ2y8XQIkjXjUmtMmr8G00bUoVOoZwjwHHpiKw9VAkMItngqYlHhErcM5EWmkik5NVNaAQuObaX1KW5bhPHGB8sSiPUX9E7ztJE9U/xKwjA+sFx5IO2pZwx3GBGIpQKCH6q3UM7y/Barw5P5ba9g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763192360; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VIMakywiLdd9Po/mLiQdiUL62Jf/1xLS8ZQb7Ivv+5o=; 
	b=CoH2R90JtGL3ZEVFgauXEiN/cSBNjxfab6wiaiU5HwCJu659dmSjO7tw4P6t2nFA6lk4Vd1z9vejkhokuJ2q7YVS8oqYjdkMhoRfShAZn9eWXqNIjNB7+MBaBvigvM0fJA+iCO7E2OV7VgJZ1l4LtnHMKowpiuS77TlGWaRoBSo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763192360;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=VIMakywiLdd9Po/mLiQdiUL62Jf/1xLS8ZQb7Ivv+5o=;
	b=dmKBQl8jhg18Q0Jl9eilqxH1pf3hsfYxAPmZARCkIMNVr0d6dUXmghe2ljRoknaK
	qJcWdS+pO4svdVugzDRc4euc+z8xKbOLmCnrWWOreFtpEwD9PIl92gsNdKdpkb7x2bY
	w1urw6ZXRsXkKaP/Q24WE25Q6Rf/ft+4pqLOMmi0=
Received: by mx.zohomail.com with SMTPS id 1763192358465720.5474117458283;
	Fri, 14 Nov 2025 23:39:18 -0800 (PST)
Date: Sat, 15 Nov 2025 13:09:12 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
Message-ID: <vywh5euispm7c4emz2bma3upnldj2x7rthhsedwhjguv54pakz@5dy326il2de2>
References: <20251114095853.3482596-1-anirudh@anirudhrb.com>
 <20251115062240.GA1794663@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115062240.GA1794663@liuwe-devbox-debian-v2.local>
X-ZohoMailClient: External

On Sat, Nov 15, 2025 at 06:22:40AM +0000, Wei Liu wrote:
> On Fri, Nov 14, 2025 at 09:58:52AM +0000, Anirudh Rayabharam wrote:
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> > execute a passthrough hypercall targeting the root/parent partition
> > i.e. HV_PARTITION_ID_SELF.
> > 
> > This will be useful for the VMM to query things like supported
> > synthetic processor features, supported VMM capabiliites etc.
> > 
> > While at it, add HVCALL_GET_PARTITION_PROPERTY_EX to the allowed list of
> > passthrough hypercalls.
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> This doesn't apply to hyperv-next. What's its base?

Hmmm... I remember doing this on hyperv-next. This the parent I see:

commit f2329fd987a0da4759c307c46fd27c4d05bb7433
Author: Naman Jain <namjain@linux.microsoft.com>
Date:   Thu Nov 13 04:41:49 2025 +0000

    Drivers: hv: Introduce mshv_vtl driver

No worries, I can rebase it on hyperv-next and send it again.

Thanks,
Anirudh.

> 
> Wei
> 
> > ---
> >  drivers/hv/mshv_root_main.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 20eda00a1b5a..98f56322cd19 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -122,6 +122,7 @@ static struct miscdevice mshv_dev = {
> >   */
> >  static u16 mshv_passthru_hvcalls[] = {
> >  	HVCALL_GET_PARTITION_PROPERTY,
> > +	HVCALL_GET_PARTITION_PROPERTY_EX,
> >  	HVCALL_SET_PARTITION_PROPERTY,
> >  	HVCALL_INSTALL_INTERCEPT,
> >  	HVCALL_GET_VP_REGISTERS,
> > @@ -159,6 +160,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
> >  	unsigned int pages_order;
> >  	void *input_pg = NULL;
> >  	void *output_pg = NULL;
> > +	u64 pt_id = partition ? partition->pt_id : HV_PARTITION_ID_SELF;
> >  
> >  	if (copy_from_user(&args, user_args, sizeof(args)))
> >  		return -EFAULT;
> > @@ -180,7 +182,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
> >  	is_async = mshv_hvcall_is_async(args.code);
> >  	if (is_async) {
> >  		/* async hypercalls can only be called from partition fd */
> > -		if (!partition_locked)
> > +		if (!partition || !partition_locked)
> >  			return -EINVAL;
> >  		ret = mshv_init_async_handler(partition);
> >  		if (ret)
> > @@ -208,7 +210,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
> >  	 * NOTE: This only works because all the allowed hypercalls' input
> >  	 * structs begin with a u64 partition_id field.
> >  	 */
> > -	*(u64 *)input_pg = partition->pt_id;
> > +	*(u64 *)input_pg = pt_id;
> >  
> >  	if (args.reps)
> >  		status = hv_do_rep_hypercall(args.code, args.reps, 0,
> > @@ -226,7 +228,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
> >  	}
> >  
> >  	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
> > -		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
> > +		ret = hv_call_deposit_pages(NUMA_NO_NODE, pt_id, 1);
> >  		if (!ret)
> >  			ret = -EAGAIN;
> >  	} else if (!hv_result_success(status)) {
> > @@ -2048,6 +2050,9 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
> >  	case MSHV_CREATE_PARTITION:
> >  		return mshv_ioctl_create_partition((void __user *)arg,
> >  						misc->this_device);
> > +	case MSHV_ROOT_HVCALL:
> > +		return mshv_ioctl_passthru_hvcall(NULL, false,
> > +					(void __user *)arg);
> >  	}
> >  
> >  	return -ENOTTY;
> > -- 
> > 2.34.1
> > 

