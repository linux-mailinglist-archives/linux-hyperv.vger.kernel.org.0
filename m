Return-Path: <linux-hyperv+bounces-1571-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E1859FFC
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501CE2814B4
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7272376D;
	Mon, 19 Feb 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lq9ubTHt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9425569;
	Mon, 19 Feb 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335625; cv=none; b=Ili8wbZTG+2DHajfS0xVDMl0fOej3wLhqMR4lwCzMFxL/xFQVcHhmrRu5j2tKdi5YLSlqTzWAYpcQPSiJtcztC5p0vvkHeBUgruJhZbZNfjFd8AyK06z4ixNz+SpkpEZeTtPcRsIGEiLWHRv6wZDn1wpmmdiqaxlEawNtev2zXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335625; c=relaxed/simple;
	bh=+0z+WLSqM9PLe9yU45IvLUSUrPaur/xg7coLCs8rcdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGCmJbwi4RqCz6X88uf7QjjenddDgYO093SA3mnI+jkgaswokpampC/CnkSFTRWCN+Hr8hEQ2Jf6ukiEcDAq/iPPOJMsWtGMQX2SdJxx3UXyCy4AwLlmtftjUaAQSgUQGhIuqxqFNIp9n5HRz6+f7Tvxosq1ay7bWtpq1Pl1e34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lq9ubTHt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0200320835FB; Mon, 19 Feb 2024 01:40:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0200320835FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708335624;
	bh=ELvZ5Y3ANrK+RgjK2Cz1IwCcePKRlLVuyLn+tsrpu80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lq9ubTHtST3vhh96PIlNVg6zcGkA5oGUWBSYPuT2M3oTjiND+HFtSpsRTWV+R0gSU
	 2GNU5xMZKGxNhYF6tW7LQtI/thJo2OPoScD2fEaUccSqmqlkmEs2mAfUBo+rvaQe9+
	 k5vMVrAT193H6tabZQDfsUBWpf8oLZ4Ge6N6ea74=
Date: Mon, 19 Feb 2024 01:40:23 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 2/6] uio_hv_generic: Query the ringbuffer size for device
Message-ID: <20240219094023.GB32526@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-3-git-send-email-ssengar@linux.microsoft.com>
 <2024021920-wincing-dyslexic-aae1@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021920-wincing-dyslexic-aae1@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 19, 2024 at 09:50:54AM +0100, Greg KH wrote:
> On Sat, Feb 17, 2024 at 10:03:36AM -0800, Saurabh Sengar wrote:
> > Query the ring buffer size from pre defined table per device.
> > Keep the size as is if the device doesn't have any preferred
> > ring size.
> 
> What is the "as is" size?

I will elaborate more here.

> 
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/uio/uio_hv_generic.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> > index 20d9762331bd..4bda6b52e49e 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -238,6 +238,7 @@ hv_uio_probe(struct hv_device *dev,
> >  	struct hv_uio_private_data *pdata;
> >  	void *ring_buffer;
> >  	int ret;
> > +	size_t ring_size = hv_dev_ring_size(channel);
> >  
> >  	/* Communicating with host has to be via shared memory not hypercall */
> >  	if (!channel->offermsg.monitor_allocated) {
> > @@ -245,12 +246,14 @@ hv_uio_probe(struct hv_device *dev,
> >  		return -ENOTSUPP;
> >  	}
> >  
> > +	if (!ring_size)
> > +		ring_size = HV_RING_SIZE * PAGE_SIZE;
> 
> Why the magic * PAGE_SIZE here?
> 
> Where is it documented that ring_size is in pages?
> 
> And what happens when PAGE_SIZE is changed?  Why are you relying on that
> arbritrary value to dictate your buffer sizes to a device that has
> no relationship with PAGE_SIZE?
> 
> Yes, I know you are copying what was there today, but you have the
> chance to rethink and most importantly, DOCUMENT this decision properly
> now.

I agree PAGE_SIZE is not accurate here and we should use HV_HYP_PAGE_SIZE.
This can be further improved by using VMBUS_RING_SIZE macro.

However, I propose addressing this improvement in a separate patch, given
the are significant changes already present in this series.

- Saurabh


> 
> thanks,
> 
> greg k-h

