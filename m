Return-Path: <linux-hyperv+bounces-4697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC5A708A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 18:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4D51750CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A3325EF9B;
	Tue, 25 Mar 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlGWaZRa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BC253B62;
	Tue, 25 Mar 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925580; cv=none; b=jVjzs/8Csvmit8TJr6Ar2CSzZYzw5YXbqAZG/7Xt564PW8uTrLIoFX5pIuRgAruUHS2aIDCg3/OHa142Rssv1VBxcHv+p4ePs90c0lH1lPXm6A0Kxq9esgAqtR13hwlMoujQvV8p5k0OHHvcbkVVaSKHdIpJ+8nCZXMvNdfOsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925580; c=relaxed/simple;
	bh=fnXCqNzUlOESX5x7kQrBRYFvf9zA3HR7m4/Rf2wjJOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5sIy7WbSDfzM8J6y86/gPxBPhSXRmK8s7N6Q6utIkGlnzSrhsQsulkgOTNmYwUUTf5Fe/2kQ/n+i5Gynqcj09PpYIyYIaAt/5z1wMw8C96vuYSTUNAord/BrXVh7XI6Lvc7qyR2zSHduUvUb7mRaDB7zsQwHOfCJUtwt69+lLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlGWaZRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C28C4CEE4;
	Tue, 25 Mar 2025 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742925580;
	bh=fnXCqNzUlOESX5x7kQrBRYFvf9zA3HR7m4/Rf2wjJOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlGWaZRau2G/X+0jsXDxqjA0BgC/4au+VUZka3eCeIb8BKdjrJLgzjjWQpqW0498R
	 kxA3ekgFZaOD1PEK6JR4rp5KCIwitOPWMn1U61bu9dhSVC5i2ee5G0pEsKPphQK/IK
	 8fTvdD1B1Bzp+B1oXEXFiqil/AsRD7dDvCfVx0Th8yGYt0NgWodVQ+EJLqAPAQz/vM
	 mz8KkacZueA0909kyEK2tRcyChb8QSlBAZ4Yvh7W0yrmaDfJ5dMBDgHnHZPq8WYed7
	 Oulu2LdGExa4r3dR2TE4bdI5sESnzo6cyPJysJq8q7Z7ipNJmcML4icSONiKNdU8FF
	 /lZ+AY2lloIpw==
Date: Tue, 25 Mar 2025 17:59:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <wei.liu@kernel.org>, longli@linuxonhyperv.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v3] uio_hv_generic: Set event for all channels on the
 device
Message-ID: <Z-LvCnIZxZeINR6R@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1741644721-20389-1-git-send-email-longli@linuxonhyperv.com>
 <Z-LVk8jWkalG5KdD@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <2025032533-sassy-blinker-85de@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025032533-sassy-blinker-85de@gregkh>

On Tue, Mar 25, 2025 at 12:39:54PM -0400, Greg Kroah-Hartman wrote:
> On Tue, Mar 25, 2025 at 04:10:59PM +0000, Wei Liu wrote:
> > On Mon, Mar 10, 2025 at 03:12:01PM -0700, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > > 
> > > Hyper-V may offer a non latency sensitive device with subchannels without
> > > monitor bit enabled. The decision is entirely on the Hyper-V host not
> > > configurable within guest.
> > > 
> > > When a device has subchannels, also signal events for the subchannel
> > > if its monitor bit is disabled.
> > > 
> > > This patch also removes the memory barrier when monitor bit is enabled
> > > as it is not necessary. The memory barrier is only needed between
> > > setting up interrupt mask and calling vmbus_set_event() when monitor
> > > bit is disabled.
> > > 
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > 
> > Greg, are you going to take this patch?
> > 
> > I can take it if you want.
> 
> It's the merge window right now, neither of us should be taking it.  Let
> me look into it after -rc1 is out.

Understood. Thank you for your response.

> 
> thanks,
> 
> greg k-h

