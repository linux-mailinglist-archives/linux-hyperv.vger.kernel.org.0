Return-Path: <linux-hyperv+bounces-3427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7239E8711
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Dec 2024 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6FA2813F9
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Dec 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CEB1531E3;
	Sun,  8 Dec 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sGjMJPx1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1706C22EE4;
	Sun,  8 Dec 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733679051; cv=none; b=TVeN258VhB4XFnJzt7cloN4jVMyJdzfdTPBpUYuaU3vPoWDSD8F+7z9BgmjBELyyktCdCBu3wKJM8iqnomMlHluJVtL2skCUt8K1bopCPq4u94rmN/itq6PLkzxaF3VwcBGsYhAPHoUn3qDaMhoKAwQUk3Z1OFKIonX4+DkTF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733679051; c=relaxed/simple;
	bh=un4hFlr8tN+gBb47IVP6egqtpZ7CA7ikz4rJmTaMn90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIQ8IwvECNfi47Xiv5BD+7Uf0OaNb/coRwuJqwXn5QfnWdTOau4O+p3ES0w+TtlLUBZcIHmxJwp7J3M6cWHdgk8dBSIBjzS3kL5dItJHmhJPNJPxvX3UmDOJolFjrjgs5K+5ERTKTcBXhLLClqLcXnRPdYtmwmMsJ45vJlttXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sGjMJPx1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 952CA205368C; Sun,  8 Dec 2024 09:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 952CA205368C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733679049;
	bh=zU3TuQuM4YwMbRMr4MJxP6mVAgRFK93zVHws/i7P1/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGjMJPx1Rwm8xd0tcaDRbdnRbAKeo4HoB00yxlZl/djzDBHF/wHxo6d64HlwYxASF
	 GwKkrMDyfGoYxTZaN3ls6RNfUcteX5R87SrxBXKzbtL0mofO6M1bliJMPqRunp69hz
	 +CR5GDtvxilzmRbNsSsnY03YHVqCpyvy4pF8hjOY=
Date: Sun, 8 Dec 2024 09:30:49 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, gregkh@linuxfoundation.org,
	vkuznets@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Drivers: hv: util: Don't force error code to
 ENODEV in util_probe()
Message-ID: <20241208173049.GA14100@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241106154247.2271-1-mhklinux@outlook.com>
 <20241106154247.2271-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106154247.2271-2-mhklinux@outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Nov 06, 2024 at 07:42:46AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> If the util_init function call in util_probe() returns an error code,
> util_probe() always return ENODEV, and the error code from the util_init
> function is lost. The error message output in the caller, vmbus_probe(),
> doesn't show the real error code.
> 
> Fix this by just returning the error code from the util_init function.
> There doesn't seem to be a reason to force ENODEV, as other errors
> such as ENOMEM can already be returned from util_probe(). And the
> code in call_driver_probe() implies that ENODEV should mean that a
> matching driver wasn't found, which is not the case here.
> 
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2: None. This is the first version of Patch 1 of this series.
> The "v2" is due to changes to Patch 2 of the series.
> 
>  drivers/hv/hv_util.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index c4f525325790..370722220134 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -590,10 +590,8 @@ static int util_probe(struct hv_device *dev,
>  	srv->channel = dev->channel;
>  	if (srv->util_init) {
>  		ret = srv->util_init(srv);
> -		if (ret) {
> -			ret = -ENODEV;
> +		if (ret)
>  			goto error1;
> -		}

After reviewing V2 of this series, I couldn’t find any scenario where
'util_init' in any driver returns a value other than 0. In such cases,
could we consider making all these functions 'void' ?

After this ee can remove the check for util_int return type.

- Saurabh

