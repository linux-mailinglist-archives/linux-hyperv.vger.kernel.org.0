Return-Path: <linux-hyperv+bounces-7982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70BCA994D
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Dec 2025 00:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96163005EBC
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 23:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7121FF3B;
	Fri,  5 Dec 2025 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDjmjnpP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E60433BC;
	Fri,  5 Dec 2025 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975986; cv=none; b=q6Dm+NwBkyxSmB2gwZCjJmjEJW2IB13z01xa4kzbAXq+aC0a6ToloKkEFUQfT24RikUIY7c+IXloa4/25AlGD02vAGhYVcz2dFqWW42dumub1onbV+afizX2HLIvuiKVqYkh+Khyt8twDOwkVgKWwXK85+M0hZtT9q8zDHZZBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975986; c=relaxed/simple;
	bh=S8Guuc8LW33dqLYXWNrPbbx1uN50/rSVNlYomRWfJ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+YmgHb5klub9y/732s142osyecT+eDV4gz5LAGRH7w/iaS7aGUgV1dyirUejKPtH8VrWZ8tfgu7Ii36lSeBaU6Os0BcKDo5Wvv4MNEfkyd0CEIOcH9dUWNnUVYTi7OgNP97xr+c9Df/tTEjmjz8EeWS8I9KFG4k6+0Z0HEYZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDjmjnpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165DFC4CEF1;
	Fri,  5 Dec 2025 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764975986;
	bh=S8Guuc8LW33dqLYXWNrPbbx1uN50/rSVNlYomRWfJ5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDjmjnpP3oyvWE4fe0ARSjrDRMEkBg/Km90n4Q9CVyE563C3V3RgU02I3P9hFoKXa
	 RbH/vYFiJnbF53yXW/f+NDMqShN4EolE72XuWFtL2BH73wRrKDU8KhSwUqvMK9P1zb
	 a+Jieoimt+wKOiSGeODBn9ywx6W3XxaLnzQF0WQKAwE5sRopHXhyaZeohfob5wgEHx
	 kVfAhFNGN13CHpOy9RLUYKBVZGFdyyDF1eUr/168rTDavGB7/gmMz3zGmPdKa1NDRd
	 j63DvMc4rBLXBShmMYITPqwUHIXbbIlG0foDiUjLCPU8vF8d8FKEhy1sW2IAPZLI1Z
	 5Kr/s0hNksFkA==
Date: Fri, 5 Dec 2025 23:06:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v7 1/4] fixup! Drivers: hv: Introduce mshv_vtl driver
Message-ID: <20251205230624.GA1942423@liuwe-devbox-debian-v2.local>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
 <20251205201721.7253-2-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205201721.7253-2-prapal@linux.microsoft.com>

Please provide a proper commit subject.

On Fri, Dec 05, 2025 at 02:17:05PM -0600, Praveen K Paladugu wrote:
> Drop the spurios "space" character in Makefile condition check
> that causes mshv_common.o to be built regardless of the CONFIG settings.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>

This should come with a Fixes: tag.

> ---
>  drivers/hv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 58b8d07639f3..6d929fb0e13d 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -20,6 +20,6 @@ mshv_vtl-y := mshv_vtl_main.o
>  # Code that must be built-in
>  obj-$(CONFIG_HYPERV) += hv_common.o
>  obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
> -ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
> +ifneq ($(CONFIG_MSHV_ROOT)$(CONFIG_MSHV_VTL),)
>  	obj-y += mshv_common.o
>  endif
> -- 
> 2.51.0
> 

