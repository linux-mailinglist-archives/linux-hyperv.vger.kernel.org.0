Return-Path: <linux-hyperv+bounces-7603-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C49BC5F976
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 00:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C689835FBAF
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5A1A08AF;
	Fri, 14 Nov 2025 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVAJNmYF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHIavjnW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6630DD3F
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163139; cv=none; b=t291G47e4txjNc1gDX7H0v/osiC0GDM6iZIXtv9tELZbDnxWTh6td1m/mxbS2cCZICXfBw7IqB6hCB4TIusoc/ck4oxRyoxerzFd667hNjtaFv0lBcLsvz7MsOcaF92bqfCpAerF/qWZ9I/Q1IfQ1xkffx3I2gEslKTVJp0Xggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163139; c=relaxed/simple;
	bh=AbnGhiOXx7dGsbwYslsKjnRY8FJ95Mbk/ikoKAQApZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BA5aOC7X42G7Oz2EzWI8ywjn0KewcM93cTPHPBeyyTnDjVQmxvh/k3IDHu/Pg6RcdnjT3jL435cCiX6N7EgKPWY7Q/aaDzCXnLb+APxQXCN7JFJjm/8HgeLxVwIPHNvtAOXRU1dirR/eZgqA9ZiznKhdUrZV2/vu3tPcWwaG8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVAJNmYF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHIavjnW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763163133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/QYo7Ljqd9DNAGh5/P3lAIO/wCt6rj9fGqv6o3T6eUs=;
	b=PVAJNmYFzAz3tTB417trYQ3VUDYOMzMMHviHb65bIuLcCG21636NmKfaN2viXa9LfL2cH6
	s1oy2zaEE7ktePg4DMo3ive/2s1zhG0yHu7KJyCktArdPrJ6BuIMz7C7cQRdFuGNeMGnyq
	EMjrZL8vCMQ7HdTfiLY0pOtqgqixlmA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-9rGJfN5rO5arczU3tNQPDg-1; Fri, 14 Nov 2025 18:32:11 -0500
X-MC-Unique: 9rGJfN5rO5arczU3tNQPDg-1
X-Mimecast-MFC-AGG-ID: 9rGJfN5rO5arczU3tNQPDg_1763163130
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cd1d0d98so1649353f8f.3
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 15:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763163130; x=1763767930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/QYo7Ljqd9DNAGh5/P3lAIO/wCt6rj9fGqv6o3T6eUs=;
        b=gHIavjnWVJ62f4o/K2QzUptlA9Hh0wIUjAn1jYVVhEBd6TQ1AIaraco76J4nDr1vQT
         C5k1VcKKyJQLPeNEMsFYLGgQAbIMqpuiA1kAkuSQcHPxSC/ia+p5xBtUEuivZa8tmSvK
         jAIx4B5EpQVmsPh2irzvW0UxZGakwh52E9LFf8yoJVOnyPP/gayK98MtFoUBgztk3ap5
         a1Iw1wpib06GmNB+n7gYnEFmMzVQGNdeYzKBdrty+3CnPphGM3glFEQe6nHTossiW81h
         loYwV2iIKteEdyCCgjgOZJBJJy7vypE5JRTdFXiktnt+lda7ALqyk1Ufe6WF3U7o2y+e
         I8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763163130; x=1763767930;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QYo7Ljqd9DNAGh5/P3lAIO/wCt6rj9fGqv6o3T6eUs=;
        b=avvYfCW1FjeWvMG3Sn40I+2dRgBDXsTJ4g5pCpE00WE+tAUi3f8TX4MFO+t6dHi6ZX
         0Rdp7rsbR2lEOS9/3HmSvZSDsTzT2azHng2hhRiXm4rLvJW2p8sPXOTiBrHwgnMcDH70
         nWQkSr/8P20XfLrXBK007Cw9AXLE5JghMFdRRYhp/7S2GplscdjKQs6WUjIGbcwI+NWR
         mgt0nUN62bM/YHJM9EU5cpECSkSM0gRnsDF+c2QXfQeeW9jy6kSLjxVqTcdmxWYjNhli
         a/yo6FV7Q+BINWvc87rO4ggFHcWK6we9MuyTWi0NjblhuP4gBXqKe92OKzSpbB4BXfe6
         OrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYKxzg0DYVR40T5I54AWkMpkpbw4CfYzuNcVB0SKcuVdT+oKx3wLsEsa2sKAraMvdrnQnnRxvnsLc36yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Rhizved9Y9011j7T8W7hMlOO7+NUi8gex05L2pr7zykE5QF2
	hnWYulK9EO2UkVxQARectIwYZxKDWaoKBKXCh/wGi0b1NQsVmNbWz6hGKJE+B514sLlE6PjJWDw
	s3TaA0UPkpp8VGv88g16VDCQQr4kD1k/xqfjKLsgzLcT6M5Njqxcxf2gMV7AcMOA/UA==
X-Gm-Gg: ASbGncujUmbVwCcdtIHYuJ7Hv9N9oVsiGwe8a094RkqK2Km4BSTFMIZxfMheKE/5tkE
	T7uCS9l/QdDeCdycXQJynZ+pdOfVrb2CTFwRaVZTwDrg2SANHOf9gvvqr07Uj13iyk2aI8MpJYW
	wsriW/c6b8xiiRTu6NosbC9jNvocqgX4cbUbAbQTOD2J/V4OQDMJl6W7NHwvT/gygwhOgDcL9Jg
	t6kc4bfuXzLnJD7MZwzA2iQj9ogmn0tb50salFOMEDsa2JKALwNL0GJh5f2sVoMDK8e8eGkLkJO
	2SIY02WiyUVQ7Z44kW03mEVwQPGwpZMnWl65vxlYY1lvls89e+tmXg7uaZ3ShDxfbALSHqW5M/7
	snmXHZIrIKGn92fLN48Onaj5lluny66ZYf4Uzt+3IDlmFryVMtVRninuKuqojzOEFjlPWz9GZfp
	fJzmeN
X-Received: by 2002:a05:6000:40de:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-42b593497d8mr4293947f8f.21.1763163129942;
        Fri, 14 Nov 2025 15:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLD8BHdcVzHtD6TF4dLvyu5AHqRO8aq+/3QgGswkcNLf/IeBbf1T8H4P8a8bY7RmWd0txzCA==
X-Received: by 2002:a05:6000:40de:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-42b593497d8mr4293924f8f.21.1763163129430;
        Fri, 14 Nov 2025 15:32:09 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42b53f17291sm12635481f8f.32.2025.11.14.15.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 15:32:08 -0800 (PST)
Message-ID: <60f7c9b3-312f-41e2-ab47-c4361df1d825@redhat.com>
Date: Sat, 15 Nov 2025 00:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] KVM: SVM: Filter out 64-bit exit codes when invoking
 exit handlers on bare metal
To: Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20251113225621.1688428-1-seanjc@google.com>
 <20251113225621.1688428-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251113225621.1688428-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 23:56, Sean Christopherson wrote:
> Explicitly filter out 64-bit exit codes when invoking exit handlers, as
> svm_exit_handlers[] will never be sized with entries that use bits 63:32.
> 
> Processing the non-failing exit code as a 32-bit value will allow tracking
> exit_code as a single 64-bit value (which it is, architecturally).  This
> will also allow hardening KVM against Spectre-like attacks without needing
> to do silly things to avoid build failures on 32-bit kernels
> (array_index_nospec() rightly asserts that the index fits in an "unsigned
> long").
> 
> Omit the check when running as a VM, as KVM has historically failed to set
> bits 63:32 appropriately when synthesizing VM-Exits, i.e. KVM could get
> false positives when running as a VM on an older, broken KVM/kernel.  From
> a functional perspective, omitting the check is "fine", as any unwanted
> collision between e.g. VMEXIT_INVALID and a 32-bit exit code will be
> fatal to KVM-on-KVM regardless of what KVM-as-L1 does.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/svm.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 202a4d8088a2..3b05476296d0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3433,8 +3433,22 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
>   		sev_free_decrypted_vmsa(vcpu, save);
>   }
>   
> -int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
> +int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
>   {
> +	u32 exit_code = __exit_code;
> +
> +	/*
> +	 * SVM uses negative values, i.e. 64-bit values, to indicate that VMRUN
> +	 * failed.  Report all such errors to userspace (note, VMEXIT_INVALID,
> +	 * a.k.a. SVM_EXIT_ERR, is special cased by svm_handle_exit()).  Skip
> +	 * the check when running as a VM, as KVM has historically left garbage
> +	 * in bits 63:32, i.e. running KVM-on-KVM would hit false positives if
> +	 * the underlying kernel is buggy.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
> +	    (u64)exit_code != __exit_code)
> +		goto unexpected_vmexit;

I reviewed the series and it looks good, but with respect to this patch 
and patch 8, is it really worth it?  While there is a possibility that 
code 0x00000000ffffffff is used, or that any high 32-bit values other 
than all-zeros or all-ones are used, they'd be presumably enabled by 
some control bits in the VMCB or some paravirt thing in the hypervisor.

What really matters is that SEV-ES's kvm_get_cached_sw_exit_code() is 
reading the full 64 bits and discarding invalid codes before reaching 
svm_invoke_exit_handler().

I totally agree, of course, with passing __exit_code as u64 and adding a 
comment explaining what's going on with "u32 exit_code == (u32)__exit_code".

Paolo

>   #ifdef CONFIG_MITIGATION_RETPOLINE
>   	if (exit_code == SVM_EXIT_MSR)
>   		return msr_interception(vcpu);
> @@ -3461,7 +3475,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
>   
>   unexpected_vmexit:
>   	dump_vmcb(vcpu);
> -	kvm_prepare_unexpected_reason_exit(vcpu, exit_code);
> +	kvm_prepare_unexpected_reason_exit(vcpu, __exit_code);
>   	return 0;
>   }
>   


