Return-Path: <linux-hyperv+bounces-5106-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9EA9BE9A
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 08:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5223A8466
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81722CBF9;
	Fri, 25 Apr 2025 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj/rv79U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B922CBF3;
	Fri, 25 Apr 2025 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562359; cv=none; b=TobhBolMLQJuVhLLujqyJoi7wq5S62ojfiOVNj+2QrcC9+f3M2HNhD8vzfbdFUjVFVbqL9ID1Ss4CWaH7LAVGyI7xc4Mv8xEFCiYHd86u/F2CmOOi3Z6Oo6TMWJBhYcdQGxXpTMA6GM/nu9DgZ27aRPxz8poz0TaOnnQ8ImoSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562359; c=relaxed/simple;
	bh=MWq1Fozs3aOeISRj2OanVUgx7/gTvywwy2fYtgZeD58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZdCLZr/uGor1NC0RkEi7x7tY7ytSwo/H9SNzxN8yIJ+uBOGdyNS0/zNFXtV34hT9iGOb+bkOz/KzjMH5djFwq9GK38IfPbwSaC/H+wZO0Ou8YMXEsXnoRrMYoootN1ppsvDyRzdsbMENN8sTvkMAGvzDHdPyJz+Zdg9DXzDzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj/rv79U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE95C4CEE4;
	Fri, 25 Apr 2025 06:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745562359;
	bh=MWq1Fozs3aOeISRj2OanVUgx7/gTvywwy2fYtgZeD58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nj/rv79Uj7sUFpdftr3CqZD3FZJYEyJTFz1wlXihmMPmwIQm9xVj1KBOTXsrhg7X4
	 CHm2mi6OmwbavzuzY1Sf5pKu3156iCI3mEFpberGCGrj8sJCl7fTEb5YqiR/uIZPnP
	 aRAsNSJx3FOubKfWwF0F5IoFannkJYY4bC+NtvdzLQWAHxPkDfyfeyZacxAKuDMrgn
	 5bvCOpshQrQvy7EF4sGyBqxW/HGz7hzVp7siEiPkoRVm19sP5K0mc4i8VA8qwiulrg
	 2/Hid+pLg1Ci+ExSX2QMsWz8hWwBaG5G2zexIGNcyC73AQk1bzCDiSO/M5QwpL6Erw
	 rntf3uC9f5EYg==
Date: Fri, 25 Apr 2025 06:25:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, kys@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Fix bad ref to hv_synic_eventring_tail
 when CPU goes offline
Message-ID: <aAsq9RGFUbQUfQnl@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250421163134.2024-1-mhklinux@outlook.com>
 <495d5444-b82e-4ec7-9095-d34f0ac8d40c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <495d5444-b82e-4ec7-9095-d34f0ac8d40c@linux.microsoft.com>

On Wed, Apr 23, 2025 at 10:50:27AM -0700, Nuno Das Neves wrote:
> On 4/21/2025 9:31 AM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > When a CPU goes offline, hv_common_cpu_die() frees the
> > hv_synic_eventring_tail memory for the CPU. But in a normal VM (i.e., not
> > running in the root partition) the per-CPU memory has not been allocated,
> > resulting in a bad memory reference and oops when computing the argument
> > to kfree().
> > 
> > Fix this by freeing the memory only when running in the root partition.
> > 
> > Fixes: 04df7ac39943 ("Drivers: hv: Introduce per-cpu event ring tail")
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/hv/hv_common.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index b3b11be11650..8967010db86a 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -566,9 +566,11 @@ int hv_common_cpu_die(unsigned int cpu)
> >  	 * originally allocated memory is reused in hv_common_cpu_init().
> >  	 */
> >  
> > -	synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
> > -	kfree(*synic_eventring_tail);
> > -	*synic_eventring_tail = NULL;
> > +	if (hv_root_partition()) {
> > +		synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
> > +		kfree(*synic_eventring_tail);
> > +		*synic_eventring_tail = NULL;
> > +	}
> >  
> >  	return 0;
> >  }
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-fixes.

