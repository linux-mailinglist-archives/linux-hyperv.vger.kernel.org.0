Return-Path: <linux-hyperv+bounces-1565-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7B8595E8
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 10:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7792E1C211AA
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B5107AA;
	Sun, 18 Feb 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndBAOdHj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B58149E15;
	Sun, 18 Feb 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247399; cv=none; b=CTdix29fs5xvX3X0pcoF6pu0wFij6WQKBWDR//+FuLUAKzc/DgriIlAGCx47U3biamaqwE1ui/aN7wp2xeaX/dnJZOPi18eZENwUiudyQaz2oTt9Ju1F1oPsbw9+2OMC5jp7Zd9VilF0MZgOpz97hEl43Sd1ql56JmO6cltJros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247399; c=relaxed/simple;
	bh=1OsNLwgxVXebNMC45+ZmTuw0oeQg7Ljz3M+cLuiyciQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbDTdLuVxcRKyf+BtOdlguWSQ5ezm78TXxPh2WiWJugMr7FfaPr0apSS5f6gYfY9lGRgeck8JxgWsbGWzMVwHqH6ydcxY1rSr4uHQXqTk+0tTWSO04uFkPsSoDMoZxBQDgxMsWYUvFusthk7nhMmTHX6CG0SdL9s2R9Rb7abbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndBAOdHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FA1C433F1;
	Sun, 18 Feb 2024 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708247398;
	bh=1OsNLwgxVXebNMC45+ZmTuw0oeQg7Ljz3M+cLuiyciQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndBAOdHjF7oKpEWNr3YoKh0ZhailtEvW3iyv9izRkl9TxgsU0cbb58btDpiV4cnkp
	 M6VQr+Km/+WdgoBs+7EUokObFU4PDDnfh4sN1oRqS3khR2iOLe3npjAzw8Ym1zTmzF
	 7DJjJmJEKbjhGQq5eLJ2EUVWTvEPx/kcikXNthSQ=
Date: Sun, 18 Feb 2024 10:09:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 0/6] Low speed Hyper-V devices support
Message-ID: <2024021835-selector-rasping-4228@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <2024021812-shrouded-fanciness-06ec@gregkh>
 <20240218075114.GA24453@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218075114.GA24453@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Sat, Feb 17, 2024 at 11:51:14PM -0800, Saurabh Singh Sengar wrote:
> On Sun, Feb 18, 2024 at 08:10:36AM +0100, Greg KH wrote:
> > On Sat, Feb 17, 2024 at 10:03:34AM -0800, Saurabh Sengar wrote:
> > > Hyper-V is adding multiple low speed "speciality" synthetic devices.
> > > Instead of writing a new kernel-level VMBus driver for each device,
> > > make the devices accessible to user space through UIO-based
> > > uio_hv_generic driver. Each device can then be supported by a user
> > > space driver. This approach optimizes the development process and
> > > provides flexibility to user space applications to control the key
> > > interactions with the VMBus ring buffer.
> > > 
> > > The new synthetic devices are low speed devices that don't support
> > > VMBus monitor bits, and so they must use vmbus_setevent() to notify
> > > the host of ring buffer updates. These new devices also have smaller
> > > ring buffer sizes which requires to add support for variable ring buffer
> > > sizes.
> > > 
> > > Moreover, this patch series adds a new implementation of the fcopy
> > > application that uses the new UIO driver. The older fcopy driver and
> > > application will be phased out gradually. Development of other similar
> > > userspace drivers is still underway.
> > > 
> > > 
> > > Efforts have been made previously to implement this solution earlier.
> > > Here are the discussions related to those attempts:
> > > https://lore.kernel.org/lkml/1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com/
> > > https://lore.kernel.org/lkml/1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com/
> > > https://lore.kernel.org/lkml/1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com/
> > 
> > So is this a v4 of the patch series?  What has changed from those
> > previous submissions?
> 
> In the most recent attempt we introduced a new driver uio_hv_vmbus_client
> for slow devices, where as in this new approach we are making use of
> existing uio_hv_generic driver.
> 
> We also introduced the function to query ring buffer sizes, this is an
> attempt to address your comment on earlier series to avoid kernel params.
> Comment ref: https://lore.kernel.org/lkml/Y0bipdisMbTNMYOq@kroah.com/
> 
> We later tried to have ring buffer sizes via sysfs for which we wrote a
> new driver uio_hv_vmbus_client as explained above.
> 
> This is the next approach in an attempt to address all of the concerns
> with all the previous series.

Then you need to say that somewhere, what differs from the previous
submissions and why this is better.  Remember, some of us get 1000+
emails a day to do something with, and trying to remember a review
comment from last week, let alone months ago, is impossible.

Make this easy for us please...

And as this is a "next approach", it should be versioned properly.  What
would you want to see if you had to review this?

thanks,

greg k-h

