Return-Path: <linux-hyperv+bounces-1573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4038185A072
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 11:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1800281515
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0C8250F2;
	Mon, 19 Feb 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJm7WNO7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAD24203;
	Mon, 19 Feb 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336977; cv=none; b=QFg1Rh6OshwQLz+LNd1E+IBqGlZF4IE9G05AtNvruPIWMKUn3tGwCmBZcpHfIi+fCojfCLb0DmJqgzXLpRtyQx5FugOq9Zaw13z6OAN3tOTQwZq69/Z5SuGo+m+I84JkenxrJ0eDaJPIaw4cgHOB7FJJYi4MX2+V2Kqk0vrfBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336977; c=relaxed/simple;
	bh=oWKqdvPMZz6M+UOT5vAd2xJ9jW6p5zdyxLuJpfrA+Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gusI1b6MtWSAdgrHPypjMhovCBQMVpSKSdAIxOHKWPWMOcqUHH70md5sp1JZBJtAKJIrbr956okD5XC5P30auop4llUN8DsDp3K9Xyp6SNGT0fChlf6rYWkRCOSFgZKVCnL+Z9CbfDum/ngqtqFvJ5yH3qudlngHjYtX0NCvndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJm7WNO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74146C433F1;
	Mon, 19 Feb 2024 10:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708336976;
	bh=oWKqdvPMZz6M+UOT5vAd2xJ9jW6p5zdyxLuJpfrA+Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJm7WNO72wGd3dVNd2lI2cQErXOg8b1YOMtR8d/UmzcfSrLnMbqgvF9XNfntViE5W
	 sUTB+DSK74uBCmRuKUL5SBjLmAL+X4DidUcJ9TBMrQbbYFt4IL5eQ0USgRb0dbe+Em
	 aT96rV87THDHtxtpyNl1/xJp7HC27nhcaCs91Muw=
Date: Mon, 19 Feb 2024 11:02:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 2/6] uio_hv_generic: Query the ringbuffer size for device
Message-ID: <2024021931-heroics-ducktail-e7aa@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-3-git-send-email-ssengar@linux.microsoft.com>
 <2024021920-wincing-dyslexic-aae1@gregkh>
 <20240219094023.GB32526@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219094023.GB32526@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Feb 19, 2024 at 01:40:23AM -0800, Saurabh Singh Sengar wrote:
> On Mon, Feb 19, 2024 at 09:50:54AM +0100, Greg KH wrote:
> > On Sat, Feb 17, 2024 at 10:03:36AM -0800, Saurabh Sengar wrote:
> > > Query the ring buffer size from pre defined table per device.
> > > Keep the size as is if the device doesn't have any preferred
> > > ring size.
> > 
> > What is the "as is" size?
> 
> I will elaborate more here.
> 
> > 
> > > 
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/uio/uio_hv_generic.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> > > index 20d9762331bd..4bda6b52e49e 100644
> > > --- a/drivers/uio/uio_hv_generic.c
> > > +++ b/drivers/uio/uio_hv_generic.c
> > > @@ -238,6 +238,7 @@ hv_uio_probe(struct hv_device *dev,
> > >  	struct hv_uio_private_data *pdata;
> > >  	void *ring_buffer;
> > >  	int ret;
> > > +	size_t ring_size = hv_dev_ring_size(channel);
> > >  
> > >  	/* Communicating with host has to be via shared memory not hypercall */
> > >  	if (!channel->offermsg.monitor_allocated) {
> > > @@ -245,12 +246,14 @@ hv_uio_probe(struct hv_device *dev,
> > >  		return -ENOTSUPP;
> > >  	}
> > >  
> > > +	if (!ring_size)
> > > +		ring_size = HV_RING_SIZE * PAGE_SIZE;
> > 
> > Why the magic * PAGE_SIZE here?
> > 
> > Where is it documented that ring_size is in pages?
> > 
> > And what happens when PAGE_SIZE is changed?  Why are you relying on that
> > arbritrary value to dictate your buffer sizes to a device that has
> > no relationship with PAGE_SIZE?
> > 
> > Yes, I know you are copying what was there today, but you have the
> > chance to rethink and most importantly, DOCUMENT this decision properly
> > now.
> 
> I agree PAGE_SIZE is not accurate here and we should use HV_HYP_PAGE_SIZE.
> This can be further improved by using VMBUS_RING_SIZE macro.
> 
> However, I propose addressing this improvement in a separate patch, given
> the are significant changes already present in this series.

Add it as a new patch to the series makes sense, thanks!

greg k-h

