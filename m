Return-Path: <linux-hyperv+bounces-8308-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B744DD22C2F
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9419E3043F78
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E425A2DD;
	Thu, 15 Jan 2026 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPha8Ft0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AF1E5207;
	Thu, 15 Jan 2026 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461140; cv=none; b=VdWgeWsJqlMLlXkqgQe/9laXf8GYI/dweeqlxXCs8v3KUJaX0IzWlkMkhriP2WFIjR0cHBW22vJhVIrp7Jp9DAtNH0ggYmf7NUCwfDfwXUiLjcMMBeg/pS2fm25R+JzoS9GbdtBN4PwnJLYVrcabDeabPFRU9ROMYZdM2qtCW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461140; c=relaxed/simple;
	bh=YVH8+HWWZdqOr9mtcglBqrqqKNv7IT0J/lqwRXjOBm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQFv3RZF3rENX9/BuoM/kJwsSYBrBhE7+cGglKgigm/QTe69+Q57FDm9r3Do9/jpZH6G3CZH+M+nEs60JUQvG4/csl8MN+lgNXNkoKHGAoW0nXLINu4nzgeznA0TYAbaZHErrdQ4ktzbut49zvtVZd32xZoSPab5OzDADaPjXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPha8Ft0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C734EC116D0;
	Thu, 15 Jan 2026 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768461139;
	bh=YVH8+HWWZdqOr9mtcglBqrqqKNv7IT0J/lqwRXjOBm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPha8Ft0ut5o0XQvLvfyX0dfwXaUmYNMDKkkJxI+JJT031jCgKYPRiVBpt4F+biuK
	 jcE/NEHqNsNsiGNPBVzUWROhm9sTEMYPRUC8SvZCTj2VKSg/78NyItf79uoPlMtC6J
	 fAu26r4ELLGoeDxnnwLNF/bAqJQRwEMMRBoyKQMrRo+VEXrqKaeqzLSEObv4A5S7u0
	 t9GY1ubaEgPbzbEUbBidC1dUdoEGrqNi74VztyMhtBiWJPDqMusmc9ufeyzu2JbX+7
	 89/56sXb2t60R5UDzCU1pmkaE2TJb+Y96nRafhuLEAKb4Q62g6IJqAghsswTgxPnty
	 o8KbpUogE3FUQ==
Date: Thu, 15 Jan 2026 07:12:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mshv: Add __user attribute to argument passed to
 access_ok()
Message-ID: <20260115071218.GE3557088@liuwe-devbox-debian-v2.local>
References: <20260114181508.143564-1-mhklinux@outlook.com>
 <eb163338-cd03-49c6-8c44-f6fac39ba7f6@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb163338-cd03-49c6-8c44-f6fac39ba7f6@linux.microsoft.com>

On Wed, Jan 14, 2026 at 10:39:14AM -0800, Nuno Das Neves wrote:
> On 1/14/2026 10:15 AM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > access_ok() expects its first argument to have the __user attribute
> > since it is checking access to user space. Current code passes an
> > argument that lacks that attribute, resulting in 'sparse' flagging
> > the incorrect usage. However, the compiler doesn't generate code
> > based on the attribute, so there's no actual bug.
> > 
> > In the interest of general correctness and to avoid noise from sparse,
> > add the __user attribute. No functional change.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202512141339.791TCKnB-lkp@intel.com/
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/hv/mshv_root_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index eff1b21461dc..5673af9fe101 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1280,7 +1280,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  	long ret;
> >  
> >  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> > -	    !access_ok((const void *)mem.userspace_addr, mem.size))
> > +	    !access_ok((const void __user *)mem.userspace_addr, mem.size))
> >  		return -EINVAL;
> >  
> >  	mmap_read_lock(current->mm);
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied.

