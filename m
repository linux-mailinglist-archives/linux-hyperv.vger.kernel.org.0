Return-Path: <linux-hyperv+bounces-7984-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD53CA9953
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Dec 2025 00:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139543021E5A
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656E16DC28;
	Fri,  5 Dec 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQR4Ex6M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE823B8D70;
	Fri,  5 Dec 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976090; cv=none; b=LtVBZLRbRvIUXWN5GUbmjN9qZti/HbImvsDNgvg1gdX2ZzWnMqKEYV+l9samLT/TQiYQ+kFniPhKa28fhcBhF1WEFQAaz4v8dn7NPPU6XB4SC/TW/Iz7e+3/YbqkEGgAvwAuf4onWfGy9z9sDy+UQyb9EDCiQcKpBXnQneWDPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976090; c=relaxed/simple;
	bh=KCBoE6lp7ZJrgzCbHQwRwwncKo+/2YtdbXMSHn0y1kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnMVFqmROeWjXp6lV+AYPtQz+pt3JMqKfqUv6wYd/WT6nPwhxTK0BSY+uBvSKFrZMjzWWUBwxUkxcAc12NPRo8VEq6o7vq7B133hj0ydZoTAHUm2qvXkR9ViyfmJc8Pc2pz1wI6LadQ/bfH7aiE72TcwUsCrIHhMOeyiCFz2UnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQR4Ex6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34A0C4CEF1;
	Fri,  5 Dec 2025 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764976087;
	bh=KCBoE6lp7ZJrgzCbHQwRwwncKo+/2YtdbXMSHn0y1kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQR4Ex6M+G8EzxsEdw0yDPgRwO365d1mTo0b/qSqGTJDa0G+VVon8Te/OM8SzRNZY
	 BOKw5m/wffxdHBbvvpp91KomF1I8ARMDmpPPirTlzxDGPLD3VAkBl3XKcZXyxx2RXi
	 5jaclxDoL0BoTLopPCdpmbo9G19U6LIphJ5pJVQWL/NDoaiU7rYVLSx9H8R6zW3sFg
	 WuzfX4i8OFugbhFvfqrnvHyFXxEjUpRO8+mLHmMCVNLqGMiUcpJGLBQal3FHvOwD9q
	 cYSPo13qkuoa8Eq/OV22Pn5sMJ8pYMhr73Wggs9qy/KNa8Iv4ln05lUJu3O7l323wQ
	 tRff9l5rCEdmg==
Date: Fri, 5 Dec 2025 23:08:06 +0000
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
Message-ID: <20251205230806.GB1942423@liuwe-devbox-debian-v2.local>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
 <20251205201721.7253-2-prapal@linux.microsoft.com>
 <20251205230624.GA1942423@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205230624.GA1942423@liuwe-devbox-debian-v2.local>

On Fri, Dec 05, 2025 at 11:06:24PM +0000, Wei Liu wrote:
> Please provide a proper commit subject.
> 
> On Fri, Dec 05, 2025 at 02:17:05PM -0600, Praveen K Paladugu wrote:
> > Drop the spurios "space" character in Makefile condition check
> > that causes mshv_common.o to be built regardless of the CONFIG settings.
> > 
> > Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> 
> This should come with a Fixes: tag.

Since the bug is not in any released kernel, so it is not needed.

I don't want to squash this though. So the request to have a proper
subject line still stands.

Wei

> 
> > ---
> >  drivers/hv/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> > index 58b8d07639f3..6d929fb0e13d 100644
> > --- a/drivers/hv/Makefile
> > +++ b/drivers/hv/Makefile
> > @@ -20,6 +20,6 @@ mshv_vtl-y := mshv_vtl_main.o
> >  # Code that must be built-in
> >  obj-$(CONFIG_HYPERV) += hv_common.o
> >  obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
> > -ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
> > +ifneq ($(CONFIG_MSHV_ROOT)$(CONFIG_MSHV_VTL),)
> >  	obj-y += mshv_common.o
> >  endif
> > -- 
> > 2.51.0
> > 

