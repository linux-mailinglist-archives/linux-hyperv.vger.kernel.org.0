Return-Path: <linux-hyperv+bounces-7198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D67BD35C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4733C3F2C
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DCD24A044;
	Mon, 13 Oct 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJB7oFgP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639122A7F9
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Oct 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364766; cv=none; b=A34QtG/pBXkbVS3qH0aOxABMe06BA4Me4JKaRIs1yhby2ZkII8QqbWXnbZxli2ybgV6BeTDupRBiLW7n04d/iXulnpgrS5vZJBrISdQihdotH/d7vMr3JcE4ghMvWmk7zRGRNr5TYxImFpbL2EfQBzMUx87FoHRfyG7lAaY/t5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364766; c=relaxed/simple;
	bh=ZTDyULMOfbZgmpW/yDsvyDFXqzmJd2DHr2PiLwFI1k0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pOxg+X87xEiCvJ3wHnETvDvfSL1VDbFgn2Dt0kDArvvS+gicvojjSrpfOXFGwHtCofxkM3X1xl/4elhakF31OWx1y0cYYaIu+DrJtAa33DT6K5+OK2j6C7qR3Ssd3jNfUfZZv3M2ZCkgAZYYSIWnvhLOyTL4+TS7kT2/av0g1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJB7oFgP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befb83so11306769a91.1
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Oct 2025 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760364764; x=1760969564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pW0LKbcmBjofa4oQYzdc8+pyp6zpYElMR+X+ZJF6fvU=;
        b=kJB7oFgPchTE8Tqk5bw51k08SHeF4GD41gC0pKDOqwD4ETfkAgr1zh0JRLBSjpbab2
         NZFluz2aHW7JUvcvOb4TZOJNEoSzxI3Y24ZeoSzdlCQ2zLONYKa5UjAibjIIMHfmfJq0
         W+svM3r7b9kjVcajmgX8YeZI7pK75T6wZVZW52uDP9CqXrkHjTQy/cxWAnqJ9GP6VHT3
         U0BCkZnbRsD4pCmwVqBw2RfEMANEEzA3R+aY3RDjSF46utSDjQt2dDxu124FNaNtIGiS
         Tu49ZkTreYmFu3arLOyxRVzi12CfuV2LwvyHHzBBX+lqW6a4iP1fiAkOSu2+t1GGTTri
         jV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364764; x=1760969564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW0LKbcmBjofa4oQYzdc8+pyp6zpYElMR+X+ZJF6fvU=;
        b=tSTQ7/J0jW/Ksa69R/PPcExvDZ+v0Qzzsjtz8NnpcBwwGm39Ma03IFd+4HC49bUuIg
         F/307F0qtU0s5pEifrIocgLJ1UxeHMm5MdTsLpE4lbV2ZSZfrdqvMCsYfAf3EWuYYQ+n
         PJWM82r0t7nVHdr40eS3+poJCCSSzHZZOSBeVRd7pPByA/h4UkTzY3ofqH+fD119wf4K
         UBERMqPgTOat2KY1Iqm7fUD6fBRZ0cGVt8DqK364Ct/2iz0zYVpW4nnHwwupTKqqR0qZ
         9GleG8/mUEoPH9aiRGBsn3YuBCGQJQTPhYCyPYtLryBWzaDCuReuOhHcOHaTW1LeHIAW
         k8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVo8iOJGesWAZylHFDpqhWOrkhmntChSK0ITrLqzQ1YUqi5EsqYUEihVJhslcfO/spV+Wq34+6Qjopnlks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDGUo1YwUZqzwx+JuEVhWj/PkOdA7K3Ap638kHPQl+wA9Qjmz
	yZwYLTI0QuV0cJP3A70tX7CCEegYncBWIfu/37QK+w+OLs2/lei10uWaJ/2CVsr5kkYJig+qF0U
	ek2GmLg==
X-Google-Smtp-Source: AGHT+IHYTAMsBdkqa6mQs+AQZHLUnwfl0jXB2dPP7CH/+/02DZm3RrW4t1q3AR17vjq1r+RaXhc3IjYohgw=
X-Received: from pjur7.prod.google.com ([2002:a17:90a:d407:b0:32e:d03b:ade9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b92:b0:32e:18fb:f05f
 with SMTP id 98e67ed59e1d1-33b5138e2c8mr29389536a91.20.1760364764414; Mon, 13
 Oct 2025 07:12:44 -0700 (PDT)
Date: Mon, 13 Oct 2025 07:12:42 -0700
In-Reply-To: <20251013060353.67326-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013060353.67326-1-namjain@linux.microsoft.com> <20251013060353.67326-3-namjain@linux.microsoft.com>
Message-ID: <aO0I2va2HQ6mA-u0@google.com>
Subject: Re: [PATCH v8 2/2] Drivers: hv: Introduce mshv_vtl driver
From: Sean Christopherson <seanjc@google.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Michael Kelley <mhklinux@outlook.com>, 
	Christoph Hellwig <hch@infradead.org>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Naman Jain wrote:
> +static int mshv_vtl_ioctl_return_to_lower_vtl(void)
> +{
> +	preempt_disable();
> +	for (;;) {
> +		u32 cancel;
> +		unsigned long irq_flags;
> +		struct hv_vp_assist_page *hvp;
> +		int ret;
> +
> +		local_irq_save(irq_flags);
> +		cancel = READ_ONCE(mshv_vtl_this_run()->cancel);
> +		if (cancel)
> +			current_thread_info()->flags |= _TIF_SIGPENDING;

There's no need to force SIGPENDING, this code can return directly if cancel is
set[1].  And then you can wait to disable IRQs until after handling pending work,
and thus avoid having to immediately re-enable IRQs[2].

[1] https://lore.kernel.org/all/20250828000156.23389-3-seanjc@google.com
[2] https://lore.kernel.org/all/20250828000156.23389-4-seanjc@google.com

> +
> +		if (unlikely(cancel) || __xfer_to_guest_mode_work_pending()) {
> +			local_irq_restore(irq_flags);
> +			preempt_enable();
> +			ret = xfer_to_guest_mode_handle_work();
> +			if (ret)
> +				return ret;
> +			preempt_disable();
> +			continue;
> +		}
> +
> +		mshv_vtl_return(&mshv_vtl_this_run()->cpu_context);
> +		local_irq_restore(irq_flags);
> +
> +		hvp = hv_vp_assist_page[smp_processor_id()];
> +		this_cpu_inc(num_vtl0_transitions);
> +		switch (hvp->vtl_entry_reason) {
> +		case MSHV_ENTRY_REASON_INTERRUPT:
> +			if (!mshv_vsm_capabilities.intercept_page_available &&
> +			    likely(!mshv_vtl_process_intercept()))
> +				goto done;
> +			break;
> +
> +		case MSHV_ENTRY_REASON_INTERCEPT:
> +			WARN_ON(!mshv_vsm_capabilities.intercept_page_available);
> +			memcpy(mshv_vtl_this_run()->exit_message, hvp->intercept_message,
> +			       sizeof(hvp->intercept_message));
> +			goto done;
> +
> +		default:
> +			panic("unknown entry reason: %d", hvp->vtl_entry_reason);
> +		}
> +	}
> +
> +done:
> +	preempt_enable();
> +
> +	return 0;
> +}

