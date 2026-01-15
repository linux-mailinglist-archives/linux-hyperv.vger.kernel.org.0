Return-Path: <linux-hyperv+bounces-8307-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E183D22BC9
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8098E3009FE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A68314D2C;
	Thu, 15 Jan 2026 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGixqhF9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429C25A2DD;
	Thu, 15 Jan 2026 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461108; cv=none; b=WzXAWHeubYYDevEEqHne3E2RUGVZwCeZdyeyEs3CUTJm4mnRcDU3YlT85qd91P3HihjWiGbMt8WN6Y8spDQgjnpAbdpjj/latiWWlBZzlo8nBWytsQnZr9HUwaLSkRsnWEtZ/GRwmA1J9+k7EokRYnnVNjqmJIIkPhnJUs67RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461108; c=relaxed/simple;
	bh=MkFD9KJikE6P9YEGWCAqOlXhGrIIdKoOevrdTBS9Qag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alnxILDJpl6RUjAYKX0hNHNhnlAN4Bp6yyu2ac7LxnKQbSa3WAHamtI2CXJdQyeT2dM1Jxk4dksIKWg+5h3hf5V33qUi0Zy8FGGftmY1xLcXPies3KC0hGb4mwCK9EIDHFkR+tBkBECeT91GXUM+5zZFCyn4R4CXZeK+G7KCqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGixqhF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E2AC116D0;
	Thu, 15 Jan 2026 07:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768461108;
	bh=MkFD9KJikE6P9YEGWCAqOlXhGrIIdKoOevrdTBS9Qag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGixqhF9ljmY5DfZ3DsC+ojmlsedNJ12zDDPUNKsqr/QWBrRoZ2VhQKbdNY902XaV
	 H8GNQbPpOm8ZWqPv6E+OHEmOY8ihbYEOSreDY/Y1WRL+0uMCpseEPl9pVxLRkVl/LR
	 Px1TDkx0SxLDqfk8WRYbhX43BWvCBHQ8IKSxvK+jdQu2MjVwE/8gZv0i4SjN9Vgd5V
	 Kx99DnCNXbeLwimAt2KFj0yoMjBrVw0NXnPn3DSCZVofZjE5spc0IK5xiMgK5iaCQY
	 sUX8WNaIgD5HY88ukkDtCMmgSWXZfHuj9+qlBv3INx97V6iE0vPJ3tZM/rXm0g+jVJ
	 Hsc7b6aVFzl8A==
Date: Thu, 15 Jan 2026 07:11:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mshv: Store the result of vfs_poll in a variable of
 type __poll_t
Message-ID: <20260115071146.GD3557088@liuwe-devbox-debian-v2.local>
References: <20260114170112.102673-1-mhklinux@outlook.com>
 <49fd5523-f558-4ac0-b1a5-d0ead75bd9f3@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49fd5523-f558-4ac0-b1a5-d0ead75bd9f3@linux.microsoft.com>

On Wed, Jan 14, 2026 at 10:40:04AM -0800, Nuno Das Neves wrote:
> On 1/14/2026 9:01 AM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > vfs_poll() returns a result of type __poll_t, but current code is using
> > an "unsigned int" local variable. The difference is that __poll_t carries
> > the "bitwise" attribute. This attribute is not interpreted by the C
> > compiler; it is only used by 'sparse' to flag incorrect usage of the
> > return value. The return value is used correctly here, so there's no
> > bug, but sparse complains about the type mismatch.
> > 
> > In the interest of general correctness and to avoid noise from sparse,
> > change the local variable to type __poll_t. No functional change.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202512141339.791TCKnB-lkp@intel.com/
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > This change is not marked with a Fixes: tag as there's no value in
> > backporting to older stable releases.
> > 
> >  drivers/hv/mshv_eventfd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> > index d93a18f09c76..0b75ff1edb73 100644
> > --- a/drivers/hv/mshv_eventfd.c
> > +++ b/drivers/hv/mshv_eventfd.c
> > @@ -388,7 +388,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
> >  {
> >  	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
> >  	struct mshv_irqfd *irqfd, *tmp;
> > -	unsigned int events;
> > +	__poll_t events;
> >  	int ret;
> >  	int idx;
> >  
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied.

