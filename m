Return-Path: <linux-hyperv+bounces-4051-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC22A462F8
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2025 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672B2166A21
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD16F21D3DA;
	Wed, 26 Feb 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFtU+mCb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC321C9E7;
	Wed, 26 Feb 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580451; cv=none; b=DcA+f/dhofgBXt15o2TEcL+cFL9j7DR7Pydl37lsL6haDlFU7zS/xMB24Y31MY0/I4WTIxIuLG3LURluIniymJpz6+sw8Vf/kKlCO8sLOeCPMOWbowf9Zt9f1Z/VADsFYxPle/TDt8cyVQITykQO0YyvonPDwIq17JzAeo1ln/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580451; c=relaxed/simple;
	bh=w+jA4BG9fehLoPXddRUPe3xu1fzIVndYV/6iAT1JVXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOXB1B8ukxmJ7aL7+dEj35KpIbPB6mSF/bhTg+QrMsUYwj6UgISI0gJ0Gg+JdTOzlOn/dvhi9Az60BsddkFeoOoRf3tfV1YkiDOO6YFn8AJo589CWYxtYY1xVQX7fvC4DUsLvF/Cht6sJr53A797wykQout9WrjOFGL6Bntdh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFtU+mCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36BBC4CED6;
	Wed, 26 Feb 2025 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740580451;
	bh=w+jA4BG9fehLoPXddRUPe3xu1fzIVndYV/6iAT1JVXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFtU+mCb4jPbqTa/tIi5mhrF20f/j+7G9ydD/BSwzwg1X70ppLBnNlkjzj4OnBJo2
	 ewLwB1P0odzlLzmzVp8VuKA/JtUUIl+uy5lpiv6ZVyvIoDNQA480rQ57u2Uu+s82As
	 TlncZHzLkZ+yi8jCxS0dTo6msDLddVRGVS/9rLCY=
Date: Wed, 26 Feb 2025 15:33:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>
Subject: Re: [PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer
Message-ID: <2025022643-predict-hedge-8c77@gregkh>
References: <20250225052001.2225-1-namjain@linux.microsoft.com>
 <2025022504-diagnosis-outsell-684c@gregkh>
 <9ee65987-4353-42c6-b517-d6f52428f718@linux.microsoft.com>
 <2025022515-lasso-carrot-4e1d@gregkh>
 <541c63d6-8ae6-4a32-8a02-d86eea64827e@linux.microsoft.com>
 <2025022627-deflate-pliable-6da0@gregkh>
 <0a694947-809d-48b2-9138-d3f6175fe09d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a694947-809d-48b2-9138-d3f6175fe09d@linux.microsoft.com>

On Wed, Feb 26, 2025 at 05:51:46PM +0530, Naman Jain wrote:
> 
> 
> On 2/26/2025 3:33 PM, Greg Kroah-Hartman wrote:
> > On Wed, Feb 26, 2025 at 10:43:41AM +0530, Naman Jain wrote:
> > > 
> > > 
> > > On 2/25/2025 2:09 PM, Greg Kroah-Hartman wrote:
> > > > On Tue, Feb 25, 2025 at 02:04:43PM +0530, Naman Jain wrote:
> > > > > 
> > > > > 
> > > > > On 2/25/2025 11:42 AM, Greg Kroah-Hartman wrote:
> > > > > > On Tue, Feb 25, 2025 at 10:50:01AM +0530, Naman Jain wrote:
> > > > > > > On regular bootup, devices get registered to vmbus first, so when
> > > > > > > uio_hv_generic driver for a particular device type is probed,
> > > > > > > the device is already initialized and added, so sysfs creation in
> > > > > > > uio_hv_generic probe works fine. However, when device is removed
> > > > > > > and brought back, the channel rescinds and device again gets
> > > > > > > registered to vmbus. However this time, the uio_hv_generic driver is
> > > > > > > already registered to probe for that device and in this case sysfs
> > > > > > > creation is tried before the device gets initialized completely.
> > > > > > > 
> > > > > > > Fix this by moving the core logic of sysfs creation for ring buffer,
> > > > > > > from uio_hv_generic to HyperV's vmbus driver, where rest of the sysfs
> > > > > > > attributes for the channels are defined. While doing that, make use
> > > > > > > of attribute groups and macros, instead of creating sysfs directly,
> > > > > > > to ensure better error handling and code flow.
> 
> <snip>
> 
> > > > > > > +static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
> > > > > > > +				       const struct bin_attribute *attr,
> > > > > > > +				       struct vm_area_struct *vma)
> > > > > > > +{
> > > > > > > +	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
> > > > > > > +
> > > > > > > +	if (!channel->mmap_ring_buffer)
> > > > > > > +		return -ENODEV;
> > > > > > > +	return channel->mmap_ring_buffer(channel, vma);
> > > > > > 
> > > > > > What is preventing mmap_ring_buffer from being set to NULL right after
> > > > > > checking it and then calling it here?  I see no locks here or where you
> > > > > > are assigning this variable at all, so what is preventing these types of
> > > > > > races?
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > 
> > > > > Thank you so much for reviewing.
> > > > > I spent some time to understand if this race condition can happen and it
> > > > > seems execution flow is pretty sequential, for a particular channel of a
> > > > > device.
> > > > > 
> > > > > Unless hv_uio_remove (which makes channel->mmap_ring_buffer NULL) can be
> > > > > called in parallel to hv_uio_probe (which had set
> > > > > channel->mmap_ring_buffer to non NULL), I doubt race can happen here.
> > > > > 
> > > > > Code Flow: (R, W-> Read, Write to channel->mmap_ring_buffer)
> > > > > 
> > > > > vmbus_device_register
> > > > >     device_register
> > > > >       hv_uio_probe
> > > > > 	  hv_create_ring_sysfs (W to non NULL)
> > > > >           sysfs_update_group
> > > > >             vmbus_chan_attr_is_visible (R)
> > > > >     vmbus_add_channel_kobj
> > > > >       sysfs_create_group
> > > > >         vmbus_chan_attr_is_visible  (R)
> > > > >         hv_mmap_ring_buffer_wrapper (critical section)
> > > > > 
> > > > > hv_uio_remove
> > > > >     hv_remove_ring_sysfs (W to NULL)
> > > > 
> > > > Yes, and right in here someone mmaps the file.
> > > > 
> > > > I think you can race here, no locks at all feels wrong.
> > > > 
> > > > Messing with sysfs groups and files like this is rough, and almost never
> > > > a good idea, why can't you just do this all at once with the default
> > > > groups, why is this being added/removed out-of-band?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > The decision to avoid creating a "ring" sysfs attribute by default
> > > likely stems from a specific use case where it wasn't needed for every
> > > device. By creating it automatically, it keeps the uio_hv_generic
> > > driver simpler and helps prevent potential race conditions. However, it
> > > has an added cost of having ring buffer for all the channels, where it
> > > is not required. I am trying to find if there are any more implications
> > > of it.
> > 
> > You do know about the "is_visable" attribute callback, right?  Why not
> > just use that instead of manually mucking around with the
> > adding/removing of sysfs attributes at all?  That is what it was
> > designed for.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> Yes, I am utilizing that in my patch. For differentiating channels of a
> uio_hv_generic device, and for *selectively* creating sysfs, we
> introduced this field in channel struct "channel->mmap_ring_buffer",
> which we were setting only in uio_hv_generic. But, by the time we set
> this in uio_hv_generic driver, the sysfs creation has already gone
> through and sysfs doesn't get updated dynamically. That's where there
> was a need to call sysfs_update_group. I thought the better place to
> keep sysfs_update_group would be in vmbus driver, where we are creating
> the original sysfs entries, hence I had to add the wrapper functions.
> This led us to the race condition we are trying to address now.
> 
> 
> @@ -1838,6 +1872,10 @@ static umode_t vmbus_chan_attr_is_visible(struct
> kobject *kobj,
>  	     attr == &chan_attr_monitor_id.attr))
>  		return 0;
> 
> +	/* Hide ring attribute if channel's mmap_ring_buffer function is not yet
> initialised */
> +	if (attr ==  &chan_attr_ring_buffer.attr && !channel->mmap_ring_buffer)
> +		return 0;
> +
>  	return attr->mode;

Ok, that's good.  BUT you need to change the detection of this to be
before the device is set up in the driver.  Why can't you do it in the
device creation logic itself instead of after-the-fact when you will
ALWAYS race with userspace?

thanks,

greg k-h

