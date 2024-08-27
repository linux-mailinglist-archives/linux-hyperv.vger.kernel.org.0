Return-Path: <linux-hyperv+bounces-2884-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD79616E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 20:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52485289419
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994DA1C7B63;
	Tue, 27 Aug 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CcOERhB5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206AB1C3F2C;
	Tue, 27 Aug 2024 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783048; cv=none; b=GICkdaPpjROgRGT1AShd3KDWad/OFNit/4QUohF7sIrPSQ2MwEjm191TSHopl3zfFh/3ovvaxIeKTfYX8MeNlPjqNBB9fak/4Dmuk2qBHHuHG2gDUFu0kKOl7AASXX9MoYzHte0QOLcGz4S8ooqfU3bAX/QUPD9lsAk+vbGogMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783048; c=relaxed/simple;
	bh=0l6b8HehaW+vqzQG/TIzcn0RanmUBfGthJgWFVQEBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imuCyjFZe3UVU4fSKeW/L9NwTrPKPi+Y4gVaLGWR/UKk2pb8dZfka9NeHfByG6RhmTYrPKLOYb3bk6f2enrsGf/LJFDYDMEHTjGgAKn7hO2MbPl7D15TmYcJ9neG9PJ9xVwF4wM88qvkyEc1/nfiGOJpl4NMTqhQY2kaU6z2G8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CcOERhB5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id C3C9820B7165; Tue, 27 Aug 2024 11:24:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3C9820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724783046;
	bh=E05mT8nEHfpKguDowD3PHBTuCYfL83BfAUlsYjxtd4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcOERhB5LBW/e0d2D/FKl+gvH7TuWeiAG20HfzfSGigEcF6mqQWsVuxWJo8OwuJvM
	 iLNFZbmUgAFfyCpPWRlmzjnPjALBanXL+C6h8hKxi8ovXxai+mPtvLnMxGQT9qXFzs
	 FEbP7Mo+cvSOTUZc5nZ8lJ3KBJbgFenjWV7geX/w=
Date: Tue, 27 Aug 2024 11:24:06 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Message-ID: <20240827182406.GA32019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157FB898345A1A8B88D1F4DD48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a447911b-ef12-46de-ba01-13105e34b8fe@linux.microsoft.com>
 <SN6PR02MB415711F672364610BBE6861DD48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415711F672364610BBE6861DD48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 26, 2024 at 05:40:37AM +0000, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 25, 2024 10:32 PM
> > 
> > On 8/25/2024 8:27 AM, Michael Kelley wrote:
> > > From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, August 22, 2024 4:09 AM
> > >>
> > >> Rescind offer handling relies on rescind callbacks for some of the
> > >> resources cleanup, if they are registered. It does not unregister
> > >> vmbus device for the primary channel closure, when callback is
> > >> registered.
> > >> Add logic to unregister vmbus for the primary channel in rescind callback
> > >> to ensure channel removal and relid release, and to ensure rescind flag
> > >> is false when driver probe happens again.
> > >>
> > >> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> > >> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > >> ---
> > >>   drivers/hv/vmbus_drv.c       | 1 +
> > >>   drivers/uio/uio_hv_generic.c | 7 +++++++
> > >>   2 files changed, 8 insertions(+)
> > >>
> > >> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > >> index c857dc3975be..4bae382a3eb4 100644
> > >> --- a/drivers/hv/vmbus_drv.c
> > >> +++ b/drivers/hv/vmbus_drv.c
> > >> @@ -1952,6 +1952,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> > >>   	 */
> > >>   	device_unregister(&device_obj->device);
> > >>   }
> > >> +EXPORT_SYMBOL_GPL(vmbus_device_unregister);
> > >>
> > >>   #ifdef CONFIG_ACPI
> > >>   /*
> > >> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> > >> index c99890c16d29..ea26c0b460d6 100644
> > >> --- a/drivers/uio/uio_hv_generic.c
> > >> +++ b/drivers/uio/uio_hv_generic.c
> > >> @@ -121,6 +121,13 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
> > >>
> > >>   	/* Wake up reader */
> > >>   	uio_event_notify(&pdata->info);
> > >> +
> > >> +	/*
> > >> +	 * With rescind callback registered, rescind path will not unregister the device
> > >> +	 * when the primary channel is rescinded. Without it, next onoffer msg does not come.
> > >> +	 */
> > >> +	if (!channel->primary_channel)
> > >> +		vmbus_device_unregister(channel->device_obj);
> > >
> > > When the rescind callback is *not* set, vmbus_onoffer_rescind() makes the
> > > call to vmbus_device_unregister(). But it does so bracketed with get_device()/
> > > put_device(). Your code here does not do the bracketing. Is there a reason for
> > > the difference? Frankly, I'm not sure why vmbus_onoffer_rescind() does the
> > > bracketing, and I can't definitively say if it is really needed. So I guess I'm
> > > just asking if you know. :-)
> > >
> > > Michael
> > 
> > IMHO, we have already NULL checked channel->device_obj and other couple
> > of things to make sure we are safe to clean this up. At other places as
> > well, I don't see the use of put and get device. So I think its not
> > required. I am open to suggestions.
> > 
> > Regards,
> > Naman
> 
> OK. I'm good with what you've said, and don't have any further suggestions.
> Go with what your patch already has. :-)
> 
> Michael


Michael,

If we look at vmbus_onoffer_rescind function, hv_uio_rescind can only be called
if channel->device_obj is not NULL. By this if we conclude that hv_uio_rescind can
never be called for secondary channel I think we can simplify hv_uio_rescind
only for primary channel.

In the first patch of this series, instead of this:
+	struct hv_device *hv_dev = channel->primary_channel ?
+				   channel->primary_channel->device_obj : channel->device_obj;

We can only have

+	struct hv_device *hv_dev = channel->device_obj;


In second patch, instead of this:
+        if (!channel->primary_channel)
+                vmbus_device_unregister(channel->device_obj);

We can only have:
+                vmbus_device_unregister(channel->device_obj);
	

Possibly WARN for secondary channel is also not required as that will never happen ?


- Saurabh

