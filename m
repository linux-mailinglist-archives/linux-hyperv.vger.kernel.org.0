Return-Path: <linux-hyperv+bounces-1578-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F044A85B2EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 07:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C5B2849D0
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B95917B;
	Tue, 20 Feb 2024 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m+/qvWFK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D717740;
	Tue, 20 Feb 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410609; cv=none; b=dB4jjarg4nmOF/DT9gI25sMt3EnmW696vCof7tF0dv18ZPelNJtP/BxZZk9nYtVlwVZy1zTZT8F+qbagOTJayqt3OxhlavMUxUh0uWyirtnZzXz4LEBXeauoeP8zO4upG3QdpqpeeUUuhVaAj8vfOLYfjKbRI6w4PzLFMNo9p58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410609; c=relaxed/simple;
	bh=X5Ky79iDgxmJYSC+Z/i/7mg96HvOwr9JZSwlio3XVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Imrgck5nGK443lwMGlpKwO1aig4tDeU1YLsVnY/W5pX4h/yUdKk8trHuEffxYHDrBt1L9MShXNqwVYP3NIQfDrlJxUtJfU3qw3zFn7n+m3ZGuPs5wImT7kYGtElD6/ZwOPrJ1JzYVw3WX24kTnlILSqU7kfFbOX99KSI2mKNKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m+/qvWFK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 2AB272083609; Mon, 19 Feb 2024 22:30:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2AB272083609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708410607;
	bh=s1rjPiaurgRUARd2EXAbH2FrRbDVT1VK83N6oook3eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+/qvWFKzJOa/daTEZQPx7WwkTyzEkawcfFWj8VebLxyKmypE23UPVEndTtZ5iwDD
	 XcTsx6XZfzbi+1XLlRwx6j0zxNSHRprQ39UuxPRDWkDjJyTRF4nP6Cy7MlKR0GxHOp
	 /t8rJbilqhcniSC6WdZmGjDSvuciWZW191DopTqQ=
Date: Mon, 19 Feb 2024 22:30:07 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for
 more efficient use of memory
Message-ID: <20240220063007.GA17584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240213061959.782110-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213061959.782110-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 12, 2024 at 10:19:59PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The VMBUS_RING_SIZE macro adds space for a ring buffer header to the
> requested ring buffer size.  The header size is always 1 page, and so
> its size varies based on the PAGE_SIZE for which the kernel is built.
> If the requested ring buffer size is a large power-of-2 size and the header
> size is small, the resulting size is inefficient in its use of memory.
> For example, a 512 Kbyte ring buffer with a 4 Kbyte page size results in
> a 516 Kbyte allocation, which is rounded to up 1 Mbyte by the memory
> allocator, and wastes 508 Kbytes of memory.
> 
> In such situations, the exact size of the ring buffer isn't that important,
> and it's OK to allocate the 4 Kbyte header at the beginning of the 512
> Kbytes, leaving the ring buffer itself with just 508 Kbytes. The memory
> allocation can be 512 Kbytes instead of 1 Mbyte and nothing is wasted.
> 
> Update VMBUS_RING_SIZE to implement this approach for "large" ring buffer
> sizes.  "Large" is somewhat arbitrarily defined as 8 times the size of
> the ring buffer header (which is of size PAGE_SIZE).  For example, for
> 4 Kbyte PAGE_SIZE, ring buffers of 32 Kbytes and larger use the first
> 4 Kbytes as the ring buffer header.  For 64 Kbyte PAGE_SIZE, ring buffers
> of 512 Kbytes and larger use the first 64 Kbytes as the ring buffer
> header.  In both cases, smaller sizes add space for the header so
> the ring size isn't reduced too much by using part of the space for
> the header.  For example, with a 64 Kbyte page size, we don't want
> a 128 Kbyte ring buffer to be reduced to 64 Kbytes by allocating half
> of the space for the header.  In such a case, the memory allocation
> is less efficient, but it's the best that can be done.
> 
> Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  include/linux/hyperv.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2b00faf98017..6ef0557b4bff 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -164,8 +164,28 @@ struct hv_ring_buffer {
>  	u8 buffer[];
>  } __packed;
>  
> +
> +/*
> + * If the requested ring buffer size is at least 8 times the size of the
> + * header, steal space from the ring buffer for the header. Otherwise, add
> + * space for the header so that is doesn't take too much of the ring buffer
> + * space.
> + *
> + * The factor of 8 is somewhat arbitrary. The goal is to prevent adding a
> + * relatively small header (4 Kbytes on x86) to a large-ish power-of-2 ring
> + * buffer size (such as 128 Kbytes) and so end up making a nearly twice as
> + * large allocation that will be almost half wasted. As a contrasting example,
> + * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes for the
> + * header from a 128 Kbyte allocation, leaving only 64 Kbytes for the ring.
> + * In this latter case, we must add 64 Kbytes for the header and not worry
> + * about what's wasted.
> + */
> +#define VMBUS_HEADER_ADJ(payload_sz) \
> +	((payload_sz) >=  8 * sizeof(struct hv_ring_buffer) ? \
> +	0 : sizeof(struct hv_ring_buffer))
> +
>  /* Calculate the proper size of a ringbuffer, it must be page-aligned */
> -#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring_buffer) + \
> +#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payload_sz) + \
>  					       (payload_sz))
>  
>  struct hv_ring_buffer_info {

Thanks for the patch.
It's worth noting that this will affect the size of ringbuffer calculation for
some of the drivers: netvsc, storvsc_drv, hid-hyperv, and hyperv-keyboard.c.
It will be nice to have this comment added in commit for future reference.

Looks a good improvement to me,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

> -- 
> 2.25.1
> 

