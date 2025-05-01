Return-Path: <linux-hyperv+bounces-5288-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FECAA612B
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 18:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BBC3BDFB2
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04971F76CA;
	Thu,  1 May 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mo1kf4i1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140918DB16;
	Thu,  1 May 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115505; cv=none; b=iyf4/V7MJBR51biOmxOFhJdMT34JhdYYZlF6lJTejbP1vUzVgDfggktQ8zOhmlWof1sjLgg7dUbfG18Lkb6GqDoPymnN30aE8jere8UCLrJbGCYu8G0ZESc4ChgKgjSPAsSaGtOIZNr+Ih4/ceYXFBp9arP/0B5HSmzOcEn+JDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115505; c=relaxed/simple;
	bh=8BDYSJgOsetPEaZe8GSxclMAWayBzqeDqICNc6GpC/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn1uhA2VfDdysxOT2jZ2wIme8vByXD9qMRxf8C3t6zm7jVcbpt4Rq9KzqDlsS9pjsnUm0bP2V2qQlHMjL5EAUjP4VjTvsZQZxyVJ8ct95H2KYtSsXv+EjpvtGhfgABbLSZElZYcB8IuGQ7rApFDPQr0OBR96HPLxlyWXP1VJql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mo1kf4i1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987F7C4CEED;
	Thu,  1 May 2025 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746115505;
	bh=8BDYSJgOsetPEaZe8GSxclMAWayBzqeDqICNc6GpC/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mo1kf4i17jsK39aokxedABFnzeKNY7lnqvVtmszGjmVFr/G/srsNESQ1s3vbEcftu
	 n3m+vbxDQjJ/j4Osb+3/j015YdY9CINPMEu/oSWzJ9oss0y2sDsHb0f9mLHtyIM3m1
	 K2Qxph663bCO2oXba5Uveoh64zJILioaZ0trCZUE=
Date: Thu, 1 May 2025 18:05:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
Message-ID: <2025050154-skyward-snagged-973d@gregkh>
References: <20250424053524.1631-1-namjain@linux.microsoft.com>
 <2025042501-accuracy-uncombed-cb99@gregkh>
 <752c5b1c-ef67-4644-95d4-712cdba6ad2b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752c5b1c-ef67-4644-95d4-712cdba6ad2b@linux.microsoft.com>

On Mon, Apr 28, 2025 at 02:37:22PM +0530, Naman Jain wrote:
> 
> 
> On 4/25/2025 7:30 PM, Greg Kroah-Hartman wrote:
> > On Thu, Apr 24, 2025 at 11:05:22AM +0530, Naman Jain wrote:
> > > Hi,
> > > This patch series aims to address the sysfs creation issue for the ring
> > > buffer by reorganizing the code. Additionally, it updates the ring sysfs
> > > size to accurately reflect the actual ring buffer size, rather than a
> > > fixed static value.
> > > 
> > > PFB change logs:
> > > 
> > > Changes since v5:
> > > https://lore.kernel.org/all/20250415164452.170239-1-namjain@linux.microsoft.com/
> > > * Added Reviewed-By tags from Dexuan. Also, addressed minor comments in
> > >    commit msg of both patches.
> > > * Missed to remove check for "primary_channel->device_obj->channels_kset" in
> > >    hv_create_ring_sysfs in earlier patch, as suggested by Michael. Did it
> > >    now.
> > > * Changed type for declaring bin_attrs due to changes introduced by
> > >    commit 9bec944506fa ("sysfs: constify attribute_group::bin_attrs") which
> > >    merged recently. Did not use bin_attrs_new since another change is in
> > >    the queue to change usage of bin_attrs_new to bin_attrs
> > >    (sysfs: finalize the constification of 'struct bin_attribute').
> > 
> > Please fix up to apply cleanly without build warnings:
> > 
> > drivers/hv/vmbus_drv.c:1893:15: error: initializing 'struct bin_attribute **' with an expression of type 'const struct bin_attribute *const[2]' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> >   1893 |         .bin_attrs = vmbus_chan_bin_attrs,
> >        |                      ^~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> 
> Hi Greg,
> I tried reproducing this error but could not see it. Should I rebase the
> change to some other tree or use some specific config option, gcc version,
> compilation flag etc.?
> 
> I tried the following:
> * Rebased to latest linux-next tip with below base commit:
> 393d0c54cae31317deaa9043320c5fd9454deabc
> * Regular compilation with gcc: make -j8
> * extra flags:
>   make -j8  EXTRA_CFLAGS="-Wall -O2"
>   make -j8 EXTRA_CFLAGS="-Wincompatible-pointer-types-discards-qualifiers
> -Werror"
> * Tried gcc 11.4, 13.3
> * Tried clang/LLVM with version 18.1.3 : make LLVM=1

I tried this against my char-misc-linus branch (which is pretty much
just 6.15.0-rc4 plus some iio patches), and it fails with that error
above.

> BTW I had to edit the type for bin_attrs as this change got merged recently:
> 9bec944506fa ("sysfs: constify attribute_group::bin_attrs")
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 576b8b3c60af..f418aae4f113 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -107,7 +107,7 @@ struct attribute_group {
>                                             int);
>         struct attribute        **attrs;
>         union {
> -               struct bin_attribute            **bin_attrs;
> +               const struct bin_attribute      *const *bin_attrs;
>                 const struct bin_attribute      *const *bin_attrs_new;
>         };
>  };

That commit is not in my char-misc branches, that's coming from
somewhere else.

thanks,

greg k-h

