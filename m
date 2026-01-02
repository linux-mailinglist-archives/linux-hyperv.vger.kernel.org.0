Return-Path: <linux-hyperv+bounces-8111-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96612CEE1CC
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 10:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A8FC3002A6C
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89AB2D877A;
	Fri,  2 Jan 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMloNzx3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lLEsGTuY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08CC2749DC
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Jan 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347948; cv=none; b=tz2ZQ/+X8NvzSCG+tkHNW82vxV5KUgYI2MwYhgkRvdKaKzDZx2c4h/qpcjPWB7NHXfUicHc9B3nxLP8YOepilg/+hKuk7CbT7XejCAH2ch596rXCJrGkzPhjGvZafDFC3+Hm3zmGyv1zmvubEjPYLhD0JDVfFcOkzxsD29dF9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347948; c=relaxed/simple;
	bh=xwN5SJgpKv5d/dw9zKfPpCMUcx2M/mX4rbiBa7U8+Ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IoUjNqTUTrhDkcQ1ZSNmeNDoXG1j07xEsHEgqYXq7zNPZG2cEKxhyvzWdIO3wo6bHni1FSfWiUAKq8a0Cvt1Ofv55ab7bOWJ0uWo5gWySCqjMRedACIhTQEbLfZybzhqybLtejnnkrh6BT+0T5pioWOKYBDt2zrtx+QiRopRQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMloNzx3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lLEsGTuY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767347944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUxS4f8mPvClX+DwiPHnFyp+SWqUM3DkFf5Rfhn2JeY=;
	b=GMloNzx32+ACrjXAQVORfp1FqDyJ5mMWA47oRD0PI60h44XBYZA1JEE12hDY9UsdBKm5lA
	mAydsRgtLOjWem6VBMU1fxugdLUEu5IWh8/J4WmYtnaTkXyG/NzLqImLO4Ti/9oNW87Ymg
	JuXSkzvS5doZI1YNs/CJRFz9i20bTnk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-IiNGdz3gNoCVhMWbeg8gxQ-1; Fri, 02 Jan 2026 04:59:03 -0500
X-MC-Unique: IiNGdz3gNoCVhMWbeg8gxQ-1
X-Mimecast-MFC-AGG-ID: IiNGdz3gNoCVhMWbeg8gxQ_1767347942
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432586f2c82so6396437f8f.0
        for <linux-hyperv@vger.kernel.org>; Fri, 02 Jan 2026 01:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767347942; x=1767952742; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUxS4f8mPvClX+DwiPHnFyp+SWqUM3DkFf5Rfhn2JeY=;
        b=lLEsGTuY8U/CWI/26HlcDFTaNpeLJUNCGkYyXSlhQ8hbSDR3vKmqoQCIu3wIF0/cDq
         2xZfnRLBFQsrAdcm8Z8SpWCuIGUwB2qIfmZ5FG+/xQVVtQT0YTKbj2wjrkhYC6H0TFIv
         s0yV+cmoB3IzlobwMb3hX5QiTzD3rVqTMaGDo/77LWodWmieepLR5pE7pQ95EeX9EVCZ
         e1AXxGhayydsfZDfFRPGwvKj8OwaI0KxULEMh0nfPJtxA4paQusEOkiSqOy46QGoNkDY
         2UH3U5ACx80VsEx4OBAIgS+60ILP7RUO0vF6cS2QD3Z6w3CBJ3B42canI77tC1aKK7A7
         CNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347942; x=1767952742;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUxS4f8mPvClX+DwiPHnFyp+SWqUM3DkFf5Rfhn2JeY=;
        b=bblCajC5vpc78/B2CenoDtbTCo5Pi+bj674qeylYCT+xg9fs//bUOzE/tdUMhNgfI6
         OdpMsbORzc+72Pu6bOV3CAOMLaNSjI8NlgAEpPwVKzGD4oFDhWpJlLUjJILP5uJxBhWo
         TnCAgO1Kk/DKC9GoB4focv0n6THWbYC5c+bgJnSti6UW8pEcn87hcM6qGi1u+QH1WSA1
         ScAUo0v63QKJw+E6NABQjsagfXvEvCsrtvi5gS7sWW4nQzj0sE+AAVEWufbDhBpFzhqP
         Si/axGAsjW+oBM7T373+uJGmz35m6Ko8mlR2erPpTYiGBMwFfCeHgPnPkd31AnY8S2b3
         fd0w==
X-Forwarded-Encrypted: i=1; AJvYcCXvecgoYojOFKMa4zWdIWGdb7TFPCmatcDhHKjCMyAW40+mLiSJGQxJtTe6OoFycvl5Ejc8Gmbt3StJodw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyopPBbGKT9hxAe5Vh5ATMLhcaYbAkP3bb0RlL/kc3PUYUaqfiN
	iio8ezyiqRU/xDPD9jRy6Qo2HnZ0v2L4Fmy1dKOfpZKJcXOKrikWBdZVUbT0Fr0IDbX2gRe00EF
	TVGQSJVx5HAjRvww6fiXeiPCpQiO0iXYNJbf/S20li8gCcZBoJOJryF2pdtbT4EY/9g==
X-Gm-Gg: AY/fxX46d9tJcnf0/YJn3LEBiRYwOopzFrkz6qwCgtX1x+XetM6PImYmh1N0VfkFXji
	YSf/81LUb+VCKxGvz046G1ERKzGsRdh9H2CXiF082EG+yjuCWWCPw0Z8ywy9AGb6z42+gfUwJ4f
	wkDw0SVUrd40u/ilf3qOL1RavAQZKAbZFR0sHbJ9GXFvSgg6Nkhzirx0FOAlFsd9PHVFdc85RcI
	b03bXIc3qyww7tAmlM4GPtZHfvlvFI1twa606fPXyW+Of1beweFCNalXfSUcC0UcrGPklkIUvjT
	SXGOu8vtwMi6Qw2yuqZw/p7AsFJQOy5obioP7cEP/AoECw6NnbkvmO0sSl1E357oEZLAHxvtNLo
	/oSZYvQ==
X-Received: by 2002:a05:6000:1052:b0:432:84f0:9683 with SMTP id ffacd0b85a97d-43284f0971dmr22484620f8f.24.1767347942191;
        Fri, 02 Jan 2026 01:59:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXb22RGg1w4fy3z8I/bvF7q1MbAh1dJe/WDLMVTEQmMTtkYSsT5t/aZbCWXfL696OPjB6p8w==
X-Received: by 2002:a05:6000:1052:b0:432:84f0:9683 with SMTP id ffacd0b85a97d-43284f0971dmr22484602f8f.24.1767347941743;
        Fri, 02 Jan 2026 01:59:01 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm83175299f8f.3.2026.01.02.01.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:59:01 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, Yosry
 Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v2 8/8] KVM: SVM: Assert that Hyper-V's
 HV_SVM_EXITCODE_ENL == SVM_EXIT_SW
In-Reply-To: <20251230211347.4099600-9-seanjc@google.com>
References: <20251230211347.4099600-1-seanjc@google.com>
 <20251230211347.4099600-9-seanjc@google.com>
Date: Fri, 02 Jan 2026 10:58:59 +0100
Message-ID: <87eco8bajg.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Add a build-time assertiont that Hyper-V's "enlightened" exit code is that,
> same as the AMD-defined "Reserved for Host" exit code, mostly to help
> readers connect the dots and understand why synthesizing a software-defined
> exit code is safe/ok.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/hyperv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/hyperv.c b/arch/x86/kvm/svm/hyperv.c
> index 3ec580d687f5..4f24dcb45116 100644
> --- a/arch/x86/kvm/svm/hyperv.c
> +++ b/arch/x86/kvm/svm/hyperv.c
> @@ -10,6 +10,12 @@ void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
> +	/*
> +	 * The exit code used by Hyper-V for software-defined exits is reserved
> +	 * by AMD specifically for such use cases.
> +	 */
> +	BUILD_BUG_ON(HV_SVM_EXITCODE_ENL != SVM_EXIT_SW);
> +
>  	svm->vmcb->control.exit_code = HV_SVM_EXITCODE_ENL;
>  	svm->vmcb->control.exit_info_1 = HV_SVM_ENL_EXITCODE_TRAP_AFTER_FLUSH;
>  	svm->vmcb->control.exit_info_2 = 0;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Alternatively (or additionally?) to BUG_ON, I guess we could've

#define HV_SVM_EXITCODE_ENL SVM_EXIT_SW 

unless including SVM's headers into include/hyperv/hvgdk.h is too big of
a mess.

-- 
Vitaly


