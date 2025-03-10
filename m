Return-Path: <linux-hyperv+bounces-4349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C557A59EA9
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 18:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FBF3ABD76
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC83233153;
	Mon, 10 Mar 2025 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IOCDbGNT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8A232786;
	Mon, 10 Mar 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627885; cv=none; b=bmnd6Gsh9POlUfLITiUQbjYstC4EoFNlejGKL9adHA0ra0kT8+40o7LVHmyANp9wkYN7c6Q/ealXV+FioDUBt7nTUsu+oT4piYDOQf4d+zdJdD0OWPT6Aldkrvpnks8qPv3ZxcVWr+8Lb5KmjMF+oOD3BtI84FAJRYqGNrVR5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627885; c=relaxed/simple;
	bh=q/1r3wPdDdRlhHfssspaROOV06X15f1PmEiLTnCtoz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtZSRYidyNu4a9BQP55UORZoz7GyHBxeLhrCpyp/cElaMdAWsuDq+3Y7ZMKLVQKbB7suIWoqde7uyUHXUiQciG5FTz5O6XEnKOEZJ3HPzxQ48C7SiXsRi12sK6oLbxnwJu7KXklREH+V4OQW9NrJR+vaSYfWi6ZSL0jkhf0JVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IOCDbGNT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id AED642113D77; Mon, 10 Mar 2025 10:31:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AED642113D77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741627883;
	bh=0H6S+D21gWkP7aNk7LVObPkuCTFhQICMQZTmBEwShk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOCDbGNTfEUGmn2q76GMhXNctpiGxHG/o/wogNJWxT1hwANwGt56pJFkxHPr4xLGe
	 W3g2euv3yKbKnpEkH5j+r4G8QmnLxX3oM3gliD52xYrt3E+hPZdFVsR7nP0UcQzRaB
	 dINdOFb8gHM9wWWZVHca1uwYzyTm3jJeeDXrlxAw=
Date: Mon, 10 Mar 2025 10:31:23 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Message-ID: <20250310173123.GA12960@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
 <20250309054727.GA24737@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA6PR21MB4231D4A8F6D942B405777BECCED62@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB4231D4A8F6D942B405777BECCED62@SA6PR21MB4231.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 10, 2025 at 05:16:15PM +0000, Long Li wrote:
> > Subject: Re: [Patch v2] uio_hv_generic: Set event for all channels on the device
> > 
> > On Fri, Feb 28, 2025 at 02:14:14PM -0800, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > Hyper-V may offer a non latency sensitive device with subchannels
> > > without monitor bit enabled. The decision is entirely on the Hyper-V
> > > host not configurable within guest.
> > >
> > > When a device has subchannels, also signal events for the subchannel
> > > if its monitor bit is disabled.
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > > Change log
> > > v2: Use vmbus_set_event() to avoid additional check on monitored bit
> > >     Lock vmbus_connection.channel_mutex when going through subchannels
> > >
> > >  drivers/uio/uio_hv_generic.c | 32 ++++++++++++++++++++++++++------
> > >  1 file changed, 26 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/uio/uio_hv_generic.c
> > > b/drivers/uio/uio_hv_generic.c index 3976360d0096..45be2f8baade 100644
> > > --- a/drivers/uio/uio_hv_generic.c
> > > +++ b/drivers/uio/uio_hv_generic.c
> > > @@ -65,6 +65,16 @@ struct hv_uio_private_data {
> > >  	char	send_name[32];
> > >  };
> > >
> > > +static void set_event(struct vmbus_channel *channel, s32 irq_state) {
> > > +	channel->inbound.ring_buffer->interrupt_mask = !irq_state;
> > > +	if (!channel->offermsg.monitor_allocated && irq_state) {
> > > +		/* MB is needed for host to see the interrupt mask first */
> > > +		virt_mb();
> > 
> > Why is memory barrier not getting called for 'faster' channels ?
> > 
> > - Saurabh
> 
> No, the memory barrier is not needed. Even with a barrier, There is no guarantee that all pending IRQs are flushed when hv_uio_irqcontrol() returns. If user-mode depends on this guarantee, that user-mode has a bug. This barrier adds unnecessary costs when walking through subchannels.
> 

Thanks for the details. However I didn't understand if memory barrier is not
required why have it only for 'slow' devices (ie !monitor_allocated) ?

This change also removes the MB for primary channel (if it supports moitor bits),
if this is intentional, we should call out this in commit message.

Regards,
Saurabh

