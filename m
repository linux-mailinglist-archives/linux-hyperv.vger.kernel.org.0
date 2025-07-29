Return-Path: <linux-hyperv+bounces-6438-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64BEB15318
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45A23A5D4C
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDE824EABC;
	Tue, 29 Jul 2025 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="H3Gzxvlo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A3237A4F;
	Tue, 29 Jul 2025 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814830; cv=none; b=RuO8zCIV92xrgVVxrTjdYG+OO15B8sHJPzt84xR2gvpPoZoxZHLGTuZRgAvHW2dJ6f2pjtT/5f0wXrfKq0FUZKj+yp8+ZGA7SE8jtJZyI3Hec8DVXdqeFG8v3DV40wpia+UNFXLbCEHgPUfB7UA2Ry7twiAksaHRrmaoTlsU1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814830; c=relaxed/simple;
	bh=7O/H029Cl3RLOyEaOQNONmS4jswG7FQ5V5E+u/QrPFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca4snswpfZmusofpDWZYOJUNW2T8D9idx93dlUCcZW42cvHVEtI6U7EM4vKeWrrwb0N6vWhwpFPLipspPV6y0K4ugsA6h1bzJivSnZWl5TI/uTUWKUnVZM0oAldIz89yZApeCZE+7vfvj9DxdMG1wgV8mjoAX1R8bWOBuAcDMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=H3Gzxvlo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1753814820;
	bh=7O/H029Cl3RLOyEaOQNONmS4jswG7FQ5V5E+u/QrPFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3Gzxvloz9iWnzt7k6F2L9gyWvW2094ohEsgrv5fYkUqyg/857a3QxwMV1AaYFC5k
	 TsCyLLgrvdKCG21XgHM04sY2IqnpeEU0wRVRVrdJeypCacIKmPBHuymy2ag+anzl8m
	 sBFYb+x27Xe6mCqSyO2jO/WR/mYE47PXR02WQpe0=
Date: Tue, 29 Jul 2025 20:46:59 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Naman Jain <namjain@linux.microsoft.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Long Li <longli@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
Message-ID: <e1d394bd-93a6-4d8f-b7f9-fc01449df98a@t-8ch.de>
References: <20250723070200.2775-1-namjain@linux.microsoft.com>
 <SN6PR02MB41579080792040E166B5EB69D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41579080792040E166B5EB69D425A@SN6PR02MB4157.namprd02.prod.outlook.com>

On 2025-07-29 18:39:45+0000, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, July 23, 2025 12:02 AM
> > 
> > The ring buffer size varies across VMBus channels. The size of sysfs
> > node for the ring buffer is currently hardcoded to 4 MB. Userspace
> > clients either use fstat() or hardcode this size for doing mmap().
> > To address this, make the sysfs node size dynamic to reflect the
> > actual ring buffer size for each channel. This will ensure that
> > fstat() on ring sysfs node always returns the correct size of
> > ring buffer.
> > 
> > This is a backport of the upstream commit
> > 65995e97a1ca ("Drivers: hv: Make the sysfs node size for the ring buffer dynamic")
> > with modifications, as the original patch has missing dependencies on
> > kernel v6.12.x. The structure "struct attribute_group" does not have
> > bin_size field in v6.12.x kernel so the logic of configuring size of
> > sysfs node for ring buffer has been moved to
> > vmbus_chan_bin_attr_is_visible().
> > 
> > Original change was not a fix, but it needs to be backported to fix size
> > related discrepancy caused by the commit mentioned in Fixes tag.
> > 
> > Fixes: bf1299797c3c ("uio_hv_generic: Align ring size to system page")
> > Cc: <stable@vger.kernel.org> # 6.12.x
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
> > 
> > This change won't apply on older kernels currently due to missing
> > dependencies. I will take care of them after this goes in.
> > 
> > I did not retain any Reviewed-by or Tested-by tags, since the code has
> > changed completely, while the functionality remains same.
> > Requesting Michael, Dexuan, Wei to please review again.
> > 
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 1f519e925f06..616e63fb2f15 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1810,7 +1810,6 @@ static struct bin_attribute chan_attr_ring_buffer = {
> >  		.name = "ring",
> >  		.mode = 0600,
> >  	},
> > -	.size = 2 * SZ_2M,
> >  	.mmap = hv_mmap_ring_buffer_wrapper,
> >  };
> >  static struct attribute *vmbus_chan_attrs[] = {
> > @@ -1866,6 +1865,7 @@ static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
> >  	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
> >  	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
> >  		return 0;
> > +	attr->size = channel->ringbuffer_pagecount << PAGE_SHIFT;
> 
> Suppose a VM has two devices using UIO, such as DPDK network device with
> a 2MiB ring buffer, and an fcopy device with a 16KiB ring buffer. Both devices
> will be referencing the same static instance of chan_attr_ring_buffer, and the
> .size field it contains. The above statement will change that .size field
> between 2MiB and 16KiB as the /sys entries are initially populated, and as
> the visibility is changed if the devices are removed and re-instantiated (which
> is much more likely for fcopy than for netvsc). That changing of the .size
> value will probably work most of the time, but it's racy if two devices with
> different ring buffer sizes get instantiated or re-instantiated at the same time.

IIRC it works out in practice. While the global attribute instance is indeed
modified back-and-forth the size from it will be *copied* into kernfs
after each recalculation. So each attribute should get its own correct size.

> Unfortunately, I don't see a fix, short of backporting support for the
> .bin_size function, as this is exactly the problem that function solves.

It should work out in practice. (I introduced the .bin_size function)

Thomas

