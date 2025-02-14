Return-Path: <linux-hyperv+bounces-3951-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C00A35815
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 08:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5425C3AD3E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9720F087;
	Fri, 14 Feb 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xWPgsr/3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E620C034;
	Fri, 14 Feb 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518922; cv=none; b=h/v3COqi7puoOgiu05GiE5tnIenaU34ZIDRJWES10oQOc2NNdd0m9gbVORgGrQHNBXyFZR4IRfYZIdL0W45suRGwjeZdR18aVu+W+EX5ZPg277OBHlkyZQqdTtWGz2DQKE8aRaKaaYt1LS6o2cCHHq8s2j7VKxUKZWpyIkHVbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518922; c=relaxed/simple;
	bh=EDD9q/k0LYjcR7mWTHUsBXJQI1egklmZfCrvsVVR6wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffLff/+K0O6Z0wR12Ogc6/gW2EBmDpJekgHkDKXluI3jBVQAb9Nz1zX9KpIfP8noamLZyRykjjQQWfxKgFhfq0kFs7I6ELL067wZ3Q3gvBve6JSpJ1XgAt+0JSmKaxo8dG9aui/sLDU2zr5ZCUqh8W2c3z8s1LjafOmd6zlkBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xWPgsr/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBCEC4CED1;
	Fri, 14 Feb 2025 07:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739518921;
	bh=EDD9q/k0LYjcR7mWTHUsBXJQI1egklmZfCrvsVVR6wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xWPgsr/3DGM34UvBmBtrGM/iTJ9rTlJxO/3yjH5IOnLTBJKIStDpcHvsoNMfHCjZn
	 G5xzvDVYwN7RQezCc+HU/6A1qyYZThbJiVQUqa9HY/x7zBY67QjFYjRzprZ2c8X3pp
	 rC8kXKRDwQRFFONN45gGLQ8BvPWfZig48aMJEQPc=
Date: Fri, 14 Feb 2025 08:41:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [RFC PATCH] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <2025021418-cork-rinse-698a@gregkh>
References: <20250214064351.8994-1-namjain@linux.microsoft.com>
 <2025021455-tricky-rebalance-4acc@gregkh>
 <bb1c122e-e1bb-43fb-a71d-dde8f7aa352b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1c122e-e1bb-43fb-a71d-dde8f7aa352b@linux.microsoft.com>

On Fri, Feb 14, 2025 at 12:35:44PM +0530, Naman Jain wrote:
> 
> 
> On 2/14/2025 12:21 PM, Greg Kroah-Hartman wrote:
> > On Fri, Feb 14, 2025 at 12:13:51PM +0530, Naman Jain wrote:
> > > On regular bootup, devices get registered to vmbus first, so when
> > > uio_hv_generic driver for a particular device type is probed,
> > > the device is already initialized and added, so sysfs creation in
> > > uio_hv_generic probe works fine. However, when device is removed
> > > and brought back, the channel rescinds and again gets registered
> > > to vmbus. However this time, the uio_hv_generic driver is already
> > > registered to probe for that device and in this case sysfs creation
> > > is tried before the device gets initialized completely. Fix this by
> > > deferring sysfs creation till device gets initialized completely.
> > > 
> > > Problem path:
> > > vmbus_device_register
> > >      device_register
> > >          uio_hv_generic probe
> > > 		    sysfs_create_bin_file (fails here)
> > 
> > Ick, that's the issue, you shouldn't be manually creating sysfs files.
> > Have the driver core do it for you at the proper time, which should make
> > your logic much simpler, right?
> > 
> > Set the default attribute groups instead of manually creating this and
> > see if that works out better.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Thanks for reviewing Greg. I tried this approach and here are my
> observations:
> 
> What I could create with ATTRIBUTE_GROUPS:
> /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/ring
> 
> The one we have right now:
> /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels/6/ring

What is "channels" and "6" here?  Are they real devices or just a
directory name or something else?

> I could not find a way to tweak attributes to create the "ring" under above
> path. I could see the variations of sys_create_* which provides a
> way to pass kobj and do that, but that is something we are already
> using.

No driver should EVER be pointing to a raw kobject, that's a huge hint
that something is really wrong.  Also, if a raw kobject is in a device
path in the middle like this, it will not be seen properly from
userspace library tools :(

So again, what is creating the "channels" and "6" subdirectories?  All
of that shoudl be under full control by the uio device, right?

thanks,

greg k-h

