Return-Path: <linux-hyperv+bounces-2850-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B695DBDA
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 07:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D801B23B01
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 05:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96D154C05;
	Sat, 24 Aug 2024 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="emMUxo2a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D5154C00;
	Sat, 24 Aug 2024 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476696; cv=none; b=ui6b1UbLC9WhBJsDXssR6RYLNP57LXWcvu1ai3hnTbwaHmrorlAOmyDh3ma7VM1BMsE2zMrpE7szRdYlynuelW794oN35FLYTiS46EGp1x84rX+a1Nwlhfu4zqz5/0BPIQqLLuCyCEixf/Jl272bjLwD8gpat3NlcYeiaakeyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476696; c=relaxed/simple;
	bh=ZdYoc4ipxEVvYqYdFzrfotSN1ZfZFBlIBachiqmnKK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nlr9gNJ8Dd1K6ucrZmL9vBGW35B4bR6EdkpC184oeZPr+B+JjVSqAUfVYhkW8NPp3sII6t3ndCnuH9G0pzIp/468M1bLrysAYIkB6HlKrJ/5BW8LkDQR4eXQw2WtTVdmxV/t9NQ5maHC0CabvsODYaj8pFq3Io8KnEKzLeIYAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=emMUxo2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90172C4AF09;
	Sat, 24 Aug 2024 05:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476696;
	bh=ZdYoc4ipxEVvYqYdFzrfotSN1ZfZFBlIBachiqmnKK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emMUxo2a+QfrpKBKncBeQHugPqwqToxr0JaQM6b5KiQERsm53UGKVBwV03doYCXt0
	 av326kZoY9F52gsJMD5WXSoU4oM4T4+kAOvHbe9dGxNNslURPiFBxv5RZ2c2lw6foj
	 BSoxzkx0T2bD5SBDUPV00m2OVgf+fgeJh5xiBhfs=
Date: Sat, 24 Aug 2024 11:09:13 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 1/2] uio_hv_generic: Fix kernel NULL pointer dereference
 in hv_uio_rescind
Message-ID: <2024082403-aloof-yo-yo-4cf1@gregkh>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-2-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822110912.13735-2-namjain@linux.microsoft.com>

On Thu, Aug 22, 2024 at 04:39:11PM +0530, Naman Jain wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> For primary VMBus channels primary_channel pointer is always NULL. This
> pointer is valid only for the secondry channels.
> 
> Fix NULL pointer dereference by retrieving the device_obj from the parent
> in the absence of a valid primary_channel pointer.
> 
> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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

