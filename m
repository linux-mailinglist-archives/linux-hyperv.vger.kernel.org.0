Return-Path: <linux-hyperv+bounces-2746-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8B94AE8C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 19:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5782284BA1
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E913BAE3;
	Wed,  7 Aug 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odad3vo+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lRkUIkz4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFA13B7A3;
	Wed,  7 Aug 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049974; cv=none; b=MuWRhcePi/ZirprAB67HqvKPZIt7ZwzPWmjoGuoKgbllSIbeOZHY2/G+v8jZ/Ic3+ofv9cqe+5VZ5MaUfRPnRlh78HrFvivX25MO8IeUkQiTCKsCsHIZvQMbmRm/YPrTfBh8VvpQKT2GAaj+NH5igkHQNI7tfxS01QM+CevCT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049974; c=relaxed/simple;
	bh=byyLyYIES1ujG0m93DaLgMws/0hwctl4+3xQEzXVUr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=icQk4t8D4S2EWFgpKBeEg2WWIVJmdSdjb9jInCnK45L8BjQIHR+pOSxwgjNWGBnXaKUcE+YpHBw9nInZqNAJDr9/Ig+HJKzS/XBaB5CiSQwZ9V59ygTPd3/juDkihXjMLExRu+J1/7a9/FjhDS/gPFhD3NAMeFuoldIPisUmAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odad3vo+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lRkUIkz4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723049969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otPONBhSjDgKNxkH5EJTvsINrlb7+i62Ck70fxMf50E=;
	b=odad3vo+qUtZ9DlO1uiwY0uN7nkJOcCa0MdCPoKRZzxQeQ4a1iHLV5n+8crXQpXbQLKDjZ
	8wiqZLRyJ8U4stKdY5gqUejQc4YdRItobgRlMcK7F4F1AgZDNOufBlIo+e+KjVv3oJAqaq
	KNhj1npGtgwDFaw48kW7265b70J83JfSzoYzLIzlt03MmHPgzve5Fb998in/RU/UbEMwE0
	cwwikcPMJvGY0JFYg/ZbsVXd/l92ShIaG7SaLzvXojecG2gLYsP6/58EQ9/OnYNtm+TZ0z
	y02Sk+Gl+mC+XvUP8RDgVPdmM2baRDyJGglxhN1oP6wMP4SQLIxildrIw3agGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723049969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otPONBhSjDgKNxkH5EJTvsINrlb7+i62Ck70fxMf50E=;
	b=lRkUIkz4Q837ijx3A+o6+lW3kLfalmRxfy2GgdVe9Mrvk0Z5uCAjd/mAyqHLWRbNJydqgk
	0Dt+bTYYxsuMh4Dw==
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
 kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 yunhong.jiang@linux.intel.com
Subject: Re: [PATCH 5/7] x86/hyperv: Mark ACPI wakeup mailbox page as private
In-Reply-To: <20240806221237.1634126-6-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-6-yunhong.jiang@linux.intel.com>
Date: Wed, 07 Aug 2024 18:59:28 +0200
Message-ID: <87cymk2rrj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 15:12, Yunhong Jiang wrote:
> The ACPI wakeup mailbox is accessed by the OS and the firmware, both are
> in the guest's context, instead of the hypervisor/VMM context. Mark the
> address private explicitly.

This lacks information why the realmode area must be reserved and
initialized, which is what the change is doing implicitely.

> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>  
> +/*
> + * The ACPI wakeup mailbox are accessed by the OS and the BIOS, both are in the
> + * guest's context, instead of the hypervisor/VMM context.
> + */
> +static bool hv_is_private_mmio_tdx(u64 addr)
> +{
> +	if (wakeup_mailbox_addr && (addr >= wakeup_mailbox_addr &&
> +	    addr < (wakeup_mailbox_addr + PAGE_SIZE)))
> +		return true;
> +	return false;
> +}

static inline bool within_page(u64 addr, u64 start)
{
	return addr >= start && addr < (start + PAGE_SIZE);
}

static bool hv_is_private_mmio_tdx(u64 addr)
{
        return wakeup_mailbox_addr && within_page(addr, wakeup_mailbox_addr)
}

Hmm?

> +
>  void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>  
> -	x86_platform.realmode_reserve = x86_init_noop;
> -	x86_platform.realmode_init = x86_init_noop;
> +	if (wakeup_mailbox_addr) {

Wants a comment vs. realmode here.

> +		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
> +	} else {
> +		x86_platform.realmode_reserve = x86_init_noop;
> +		x86_platform.realmode_init = x86_init_noop;
> +	}
>  	x86_init.irqs.pre_vector_init = x86_init_noop;
>  	x86_init.timers.timer_init = x86_init_noop;

Thanks,

        tglx

