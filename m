Return-Path: <linux-hyperv+bounces-4621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B397A68F0F
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 15:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620A6172CF3
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371041D5145;
	Wed, 19 Mar 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u5Enb5L5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E01CCB4B;
	Wed, 19 Mar 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394335; cv=none; b=b20lTOMAeEeeaap/f4pnpg+mmGzAXehDGiS5QcZS0+4bHseahrHCwno6uIp9cclwGgb3gRnrEJe192pobLM12elTDyGEcFnjfubSkh71Dxn9eH0VSIgrZ3XJWI11SDWqCNP8fDNceelydPRjFXx8vTUkf0rpRaTg8uVAl9JNTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394335; c=relaxed/simple;
	bh=TD42Tf0S1nxyCZtd8qEvFl6ihUI1l3yCTT58YFfzrlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuFmAyUeBJpWkQFUhu1gyZhEjanRs3zBthZg75qkUkSiiPiuEsQKwz+EpE2+msU0rDpJ4d4vSoGaFZdppND1TxJQDpSmdhiMDFI6AY6z27riuMM6TR7rMwxWWPU32Oy2a363FAaJcePtgiCnzkNEgCbb17GU/d5czEkATu5pfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u5Enb5L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A942C4CEEE;
	Wed, 19 Mar 2025 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394334;
	bh=TD42Tf0S1nxyCZtd8qEvFl6ihUI1l3yCTT58YFfzrlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5Enb5L58D6VCz3n6wr4WI9SyChZGUB7bz0sKIu241VAf+x57lDhKx/xOB8o0WlOs
	 3v8ZYbiZQOl65wHMimsW+E3eWsO3FwsA0XVR5Z8k5jQF8JXGrjJKVuujTgIAsc45+V
	 j99HjkBDxUxz24S6kW+lIYQuc2uFPSlI/QwaykWw=
Date: Wed, 19 Mar 2025 07:24:15 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <2025031932-timid-xerox-7f0d@gregkh>
References: <20250318061558.3294-1-namjain@linux.microsoft.com>
 <2025031859-overwrite-tidy-f8ef@gregkh>
 <2b09fa80-7b2f-4eb2-b059-d16d69ee8f0c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b09fa80-7b2f-4eb2-b059-d16d69ee8f0c@linux.microsoft.com>

On Wed, Mar 19, 2025 at 07:05:56PM +0530, Naman Jain wrote:
> On 3/18/2025 6:58 PM, Greg Kroah-Hartman wrote:
> > > +/*
> > > + * hv_create_ring_sysfs - create ring sysfs entry corresponding to ring buffers for a channel
> > > + */
> > 
> > Kerneldoc?
> 
> Documentation of the ring sysfs is present here -
> Documentation/ABI/stable/sysfs-bus-vmbus
> 
> What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
> Date:           January. 2018
> KernelVersion:  4.16
> Contact:        Stephen Hemminger <sthemmin@microsoft.com>
> Description:    Binary file created by uio_hv_generic for ring buffer
> Users:          Userspace drivers
> 
> I should probably change the description, to reflect that it's visibility is
> controlled by uio_hv_generic, but it's created by hyperV drivers.
> 
> Please correct me if I misunderstood your comment.

I mean you are adding a comment here that is NOT in the correct
kerneldoc fomat.

> > > +int hv_create_ring_sysfs(struct vmbus_channel *channel,
> > > +			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
> > > +						    struct vm_area_struct *vma))
> > > +{
> > > +	struct kobject *kobj = &channel->kobj;
> > > +
> > > +	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
> > > +	channel->ring_sysfs_visible = true;
> > > +	return sysfs_update_group(kobj, &vmbus_chan_group);
> > > +}
> > > +EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
> > 
> > You just raced userspace and created a file without telling it that it
> > showed up, right?  Something still feels really wrong here.
> > 
> > greg k-h
> 
> From use-case POV, we needed to have uio_hv_generic control the visibility
> of this ring sysfs node, because the same device (HV_NIC) is used by either
> hv_netvsc or uio_hv_generic at any given point of time. We didn't want to
> expose ring buffer through sysfs when hv_netvsc is using it. That's the
> reason why uio_hv_generic was creating sysfs in the first place.
> 
> DPDK, which uses this ring sysfs, checks for its presence for primary
> channel but for secondary channels, it additionally does mmap() of this
> ring. That's where it becomes more important, not to expose ring buffer when
> uio_hv_generic is not bind to the device.
> 
> DPDK runs after uio_hv_generic probe is complete, so I am not sure if this
> race can happen, in practice. I'll try to gather more information around it.

Please do, and document the heck out of why you are doing it this way
and why there is no such race or issue, and why no one else should ever
copy this pattern as an example of what to do for other drivers.

thanks,

greg k-h

