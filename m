Return-Path: <linux-hyperv+bounces-2851-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7681395DBDC
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 07:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55491C21DEF
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 05:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E41155326;
	Sat, 24 Aug 2024 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ru4kt/bS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9614AD0A;
	Sat, 24 Aug 2024 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476699; cv=none; b=D6rlMtGw+BJGkGXKXancuip1SUWshGah2E7j5K5mG3hZnxHdC7cQgHU1lnmYySSoThlGzgTEqklhWdaCyBhlmU6XeEev1g24D/F/ZVIEgooYiZtm+QXi/lba0OJEnbz15DMzvBxikKI0YuKTtvWS6Q4NwUoaL0uyq/dHIT86zG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476699; c=relaxed/simple;
	bh=9OCVmgYNEcupERuc6F6nxMp3Y6gHEg5hYO5+I8EfrUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu/BGkOL/2H1ZTtOn+SNIJEkcitmsYFLtDxQj8AxobLDr0b7m9QcyVDuqlx7o9ksBreKY8gKGsj4VUeX6r532FUzGSsVLz75tZMDgB/kRO174gTUdJJ/xIfqJUcDpOaw6wSRpyxGqqzgGS776dDl5ZFRPodYb1fvjkWeDHADT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ru4kt/bS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D657EC4AF0B;
	Sat, 24 Aug 2024 05:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476699;
	bh=9OCVmgYNEcupERuc6F6nxMp3Y6gHEg5hYO5+I8EfrUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ru4kt/bS2l7PbO7qUl2mZ6+CAaoJSkjUkLUPbbgU+djM9NkI2u8zIT65hibcvcZA3
	 9hQH7nHzfu/v+IiaT/itjoNCGO7O3pW+8zVMI2nhJEQC7AAhzidjlT/RK1qFxxbyI9
	 m/GSUv3scT1+yBiptIwrbNx+xThMSxHbQzd/JrIY=
Date: Sat, 24 Aug 2024 11:09:30 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Message-ID: <2024082418-hexagon-preset-8e7d@gregkh>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822110912.13735-3-namjain@linux.microsoft.com>

On Thu, Aug 22, 2024 at 04:39:12PM +0530, Naman Jain wrote:
> Rescind offer handling relies on rescind callbacks for some of the
> resources cleanup, if they are registered. It does not unregister
> vmbus device for the primary channel closure, when callback is
> registered.
> Add logic to unregister vmbus for the primary channel in rescind callback
> to ensure channel removal and relid release, and to ensure rescind flag
> is false when driver probe happens again.
> 
> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c       | 1 +
>  drivers/uio/uio_hv_generic.c | 7 +++++++
>  2 files changed, 8 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

