Return-Path: <linux-hyperv+bounces-4425-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382FAA5DFCE
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 16:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321E218885DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACE24EF7C;
	Wed, 12 Mar 2025 15:08:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8824E00B;
	Wed, 12 Mar 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792128; cv=none; b=DqLUSuRILBUDBvaXzcEEPsdyInC0pxxVeSkUmemG2AXQNlKyow2ci2GyBbwUNMmzrOylYS6KsTElp9gtwCTut9et/2Qm0aXGGXvXo6Fsr+cuO8BAgOUVNGRCJHu6VEbvrOrBvcCRUNe1Qeb3Xz+5r+diTEtSJV/NffKrWs0KpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792128; c=relaxed/simple;
	bh=vQklG8ec9db7Dlo5fbtAFgXm38kjh3vp2rOmrAKlZ7k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ls9K8ZQsw+NUBm+u9FswZX+n8jcdmRHFg/lbPGi0qyL+VAJlgZaq2O5z8upwmIcmsc0xz/sT70xffJUbRY21q2Rua+yVtibjWo2XIVrlBtn/OijtKvjeXTxndRRUwakEFx+giIaQucSJgohpxat0fusBo5y3MHXt8/R6Owk6yC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCYqG2KH8z6K9HL;
	Wed, 12 Mar 2025 23:06:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D495F1404FC;
	Wed, 12 Mar 2025 23:08:37 +0800 (CST)
Received: from localhost (10.202.227.76) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 16:08:36 +0100
Date: Wed, 12 Mar 2025 15:08:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
	<dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	<ntb@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [patch 02/10] genirq/msi: Use lock guards for MSI descriptor
 locking
Message-ID: <20250312150835.00001851@huawei.com>
In-Reply-To: <87senjz2ar.ffs@tglx>
References: <20250309083453.900516105@linutronix.de>
	<20250309084110.267883135@linutronix.de>
	<20250311180017.00003fcc@huawei.com>
	<87senjz2ar.ffs@tglx>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Mar 2025 22:26:52 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Mar 11 2025 at 18:00, Jonathan Cameron wrote:
> > On Sun,  9 Mar 2025 09:41:44 +0100 (CET)
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> 
> >>  
> >> @@ -1037,25 +1032,23 @@ bool msi_create_device_irq_domain(struct
> >>  	if (msi_setup_device_data(dev))  
> >
> > Hmm. We might want to make the docs in cleanup.h more nuanced.
> > They specifically say to not mix goto and auto cleanup, but 
> > in the case of scoped_guard() unlikely almost any other case
> > it should be fine.
> >  
> >>  		goto free_fwnode;  
> 
> I got rid of the gotos. It requires __free() for the two allocations.
That works.

> 
> Thanks,
> 
>         tglx
> ---
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -216,6 +216,8 @@ const volatile void * __must_check_fn(co
>  
>  #define return_ptr(p)	return no_free_ptr(p)
>  
> +#define retain_ptr(p)				\
> +	__get_and_null(p, NULL)
Single line?

This sort of thing got discussed in the past though I doubt I can find
the thread. There was some push back but maybe now is it's time!

Probably worth shouting about it a bit to attract attention. Maybe
a separate patch.

Jonathan

