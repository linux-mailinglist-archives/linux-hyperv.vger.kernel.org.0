Return-Path: <linux-hyperv+bounces-5261-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FACBAA54B6
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 21:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475309E5727
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 19:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C61E5B60;
	Wed, 30 Apr 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nmrpDyUH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HutCrlPC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9951B87E8;
	Wed, 30 Apr 2025 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746041588; cv=none; b=BnDujpeDKleFs5NkLYuXa7o0E70A8lrcifBwSMGTqqGxu+WAVSCMP07KkRgEiTuhXatEVA5xAhy6/O08UBVevn8ARRQlQ0jalhQur3b2AVIMnkiR7OXMY8qKQf4V+Hd6W3e9mJmgAHeEfcMVNf5tEc7L99oU8h1v3B9bZGIrLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746041588; c=relaxed/simple;
	bh=NgCpYyhisR+eT14JahIMfINyl+OmdqYb/Aau9YB7T6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=APKKksCnk6Z1HRMCGeGi2TiIJEvwXZ7sCD6HKzfrWZ4ADTh85PaE08IgfyX14cM1e7Kk1pWI9HxdUWAMFp/gBYcCsUoUZso6icUsrDkiNeH3pVAaq0mDRpm5QcoiGjm65jZwJzISI6LDxhfHC1gCOEO60XZNjKwBaTbviC+7RtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nmrpDyUH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HutCrlPC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746041584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/YyscSAqwZBgtqXLx1SsF2waKn2TwCC0qIe2pJzuSGk=;
	b=nmrpDyUH7fggWHS/REurepWbQ/wOb99mLz8imaLQvfUrUHHzVw7Innd1Y+sWzkpr61UDDF
	/DwYtzY9Q5Gdubyebu9/W3OaffBmNhjFcPX1vNC+tC7HWeR9CKPAzbmXPDGkbbE6zRkKxP
	IsYwpuDYEgQ1tVrvOvNO/PCuDvnpKaiFh4wNuCX9tNiC50ixwHHBNPr4v4TzsY8RdZipxq
	Tvm9ootQvEXE/G3985aKmxdAWpLN+GsjAZA3MZvFreMOVFQpHuDnN1FLBxRW5X5ksmRf0d
	jGvl8jvnQ3uXWksTTnIAs00duU6TozHVBVKjpyw589ZsrPC7My7KJIfyPt2tMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746041584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/YyscSAqwZBgtqXLx1SsF2waKn2TwCC0qIe2pJzuSGk=;
	b=HutCrlPCqLxZRtWb2P+1P1aZ2O+umglvdkq8Xl/a7pJgk4Gkq+H+K8t6X0yDSmcKf1EW/r
	eoBRAUWv11/cWADA==
To: Roman Kisel <romank@linux.microsoft.com>, ardb@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 dimitri.sivanich@hpe.com, haiyangz@microsoft.com, hpa@zytor.com,
 imran.f.khan@oracle.com, jacob.jun.pan@linux.intel.com, jgross@suse.com,
 justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
 kys@microsoft.com, lenb@kernel.org, mingo@redhat.com, nikunj@amd.com,
 papaluri@amd.com, perry.yuan@amd.com, peterz@infradead.org,
 rafael@kernel.org, romank@linux.microsoft.com, russ.anderson@hpe.com,
 steve.wahl@hpe.com, thomas.lendacky@amd.com, tim.c.chen@linux.intel.com,
 tony.luck@intel.com, wei.liu@kernel.org, xin@zytor.com,
 yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v2] arch/x86: Provide the CPU number in the
 wakeup AP callback
In-Reply-To: <20250430161413.276759-1-romank@linux.microsoft.com>
References: <20250430161413.276759-1-romank@linux.microsoft.com>
Date: Wed, 30 Apr 2025 21:33:03 +0200
Message-ID: <87cyctphqo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 30 2025 at 09:14, Roman Kisel wrote:
> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
> +static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, int cpu)

unsigned int cpu please. There are no negative CPU numbers yet :)

>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>  	struct ghcb_state state;
> @@ -1187,7 +1187,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  	unsigned long flags;
>  	struct ghcb *ghcb;
>  	u8 sipi_vector;
> -	int cpu, ret;
> +	int ret;
>  	u64 cr4;
>  
>  	/*
> @@ -1208,15 +1208,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  
>  	/* Override start_ip with known protected guest start IP */
>  	start_ip = real_mode_header->sev_es_trampoline_start;
> -
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apic_id))
> -			break;
> -	}
> -	if (cpu >= nr_cpu_ids)
> -		return -EINVAL;
> -

I just looked what arch_match_cpu_phys_id() actually does and I couldn't
help myself to get a fit of laughter. x86 uses the weak default function
in drivers/of/cpu.c:

bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
{
	return (u32)phys_id == cpu;
}

So this loop is the most convoluted way to write:

       cpu = apic_id;

which is valid because the to be started CPU must be present, no?

I'm not opposed against the CPU number argument per se, but the
justification for it is dubious at best.

Thanks,

        tglx

