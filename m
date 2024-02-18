Return-Path: <linux-hyperv+bounces-1564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96E859578
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545121F20F75
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093012E4D;
	Sun, 18 Feb 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="quZwxXZK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8512E4B;
	Sun, 18 Feb 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243388; cv=none; b=BcOBqnQYWFFIUKCgh572lwwSp3V1aG6LlzIFSazOwu0MoTQ0KIyXvrdWj4FaqZ+nu2QabSKCww/0afmbk3SlhQUgGPYDOKLWzAZ6MyxPCbgIReTOYzPa2rggV4h2Yq44sqY4a9f33qL1Hk7RYTVjCIWXsgo0twnAzSJR3wk6AXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243388; c=relaxed/simple;
	bh=7rfhh/G/gNd2Y2Ocj7vJDV+XSDPEZiZJ2iUMHIvvKkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co5BVusFgzwKIJ42ZifLoZLSYzIULrfAIUUt3Y5/Psa5Xu3lAlf9NrAmzQ+ZU1IUSRxDF9JgiOVKAzRI7SfR/42ZJwIBTC6RlnTxOM+qXeuq1/4bCEhXaKewtQtD2hu9SjwlMOsQiWnf91l78N5Iyq/7q5+84AVT9WQNzY16tiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=quZwxXZK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id A33E320B2000; Sun, 18 Feb 2024 00:03:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A33E320B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708243386;
	bh=PlBbQIfgXaGIaQ4BZWIMpX7PSPkzfONi407mxwRRYsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quZwxXZKLsOSQbMlKLvqthC2+ZTqAemUKIeQhzJYaP1tapfBlUmnieSCHgT+iq1G2
	 kiRICTkijkuExz9kq/W3qGSB95rXOdFHEYcuBN3Axk5zRWQsw6qX3VRKxF4bhLb+yM
	 v/xTyz0yUdcg0+T08wMc5JeOTReLTeGkDeYEuV6s=
Date: Sun, 18 Feb 2024 00:03:06 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 1/6] Drivers: hv: vmbus: Add utility function for
 querying ring size
Message-ID: <20240218080306.GA26112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-2-git-send-email-ssengar@linux.microsoft.com>
 <2024021858-cubicle-irregular-d402@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021858-cubicle-irregular-d402@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Feb 18, 2024 at 08:11:58AM +0100, Greg KH wrote:
> On Sat, Feb 17, 2024 at 10:03:35AM -0800, Saurabh Sengar wrote:
> > Add a function to query for the preferred ring buffer size of VMBus
> > device.
> 
> That says what you did, but not why you did it.

I thought subsequent patch will make it clear, but I can add more
info in cover letter. I will enhance this commit as well.

> 
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 7 +++++--
> >  drivers/hv/hyperv_vmbus.h | 5 +++++
> >  include/linux/hyperv.h    | 1 +
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 2f4d09ce027a..7ea444d72f9f 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -120,7 +120,8 @@ const struct vmbus_device vmbus_devs[] = {
> >  	},
> >  
> >  	/* File copy */
> > -	{ .dev_type = HV_FCOPY,
> > +	{ .pref_ring_size = 0x4000,
> > +	  .dev_type = HV_FCOPY,
> >  	  HV_FCOPY_GUID,
> >  	  .perf_device = false,
> >  	  .allowed_in_isolated = false,
> > @@ -141,11 +142,13 @@ const struct vmbus_device vmbus_devs[] = {
> >  	},
> >  
> >  	/* Unknown GUID */
> > -	{ .dev_type = HV_UNKNOWN,
> > +	{ .pref_ring_size = 0x11000,
> > +	  .dev_type = HV_UNKNOWN,
> 
> Where do these magic numbers for the size come from?


This value is (16 + 1) page_size, which is found sufficient for most
of the slow devices. 16 page_size is for the ringbuffer and 1 page_size
for the headre. This is the approximation for default case, to avoid
using fall back case of 512 page_size as used by uio_hv_generic.

> 
> >  	  .perf_device = false,
> >  	  .allowed_in_isolated = false,> >  	},
> >  };
> > +EXPORT_SYMBOL_GPL(vmbus_devs);
> >  
> >  static const struct {
> >  	guid_t guid;
> > diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> > index f6b1e710f805..76ac5185a01a 100644
> > --- a/drivers/hv/hyperv_vmbus.h
> > +++ b/drivers/hv/hyperv_vmbus.h
> > @@ -417,6 +417,11 @@ static inline bool hv_is_perf_channel(struct vmbus_channel *channel)
> >  	return vmbus_devs[channel->device_id].perf_device;
> >  }
> >  
> > +static inline size_t hv_dev_ring_size(struct vmbus_channel *channel)
> > +{
> > +	return vmbus_devs[channel->device_id].pref_ring_size;
> > +}
> > +
> >  static inline bool hv_is_allocated_cpu(unsigned int cpu)
> >  {
> >  	struct vmbus_channel *channel, *sc;
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 2b00faf98017..5951c7bb5712 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -800,6 +800,7 @@ struct vmbus_requestor {
> >  #define VMBUS_RQST_RESET (U64_MAX - 3)
> >  
> >  struct vmbus_device {
> > +	size_t pref_ring_size;
> 
> No documentation for this?  What is the size in units of?

I can add a comment here like below:

/* 
 * Total memory in bytes allocated for the one complete ring buffer,
 * which includes the ring buffer header, of size PAGE_SIZE. This value
 * should be aligned to page_size.
 */

- Saurabh

> 
> thanks,
> 
> greg k-h

