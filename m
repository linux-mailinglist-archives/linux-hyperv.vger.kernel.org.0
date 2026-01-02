Return-Path: <linux-hyperv+bounces-8113-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC08CEEEDE
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1DF3013EAB
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6B9299A81;
	Fri,  2 Jan 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVBEKpbt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nv+8lsyj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93292240611
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Jan 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369319; cv=none; b=i5oSjih/cIKs3OqFvZpQJyMxXYZpGePqgwZZrRo4Nys/VsWmN18z3nEzUvIRpxmTUn3IbBeLsbr0V+KdIFIOPQiHLH06ACtVkELCf0AegpEUFFKGjOqtXjjFRz/dwzdSH6DCRBiBZND1ruYHywFufnT6zWBO7i9Veq5m2cF51+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369319; c=relaxed/simple;
	bh=Y0Hwi5z3RMPP/UnQPMuL5YEkscPe0NW5f+9+86I8E/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VxXhsq//5GSpbejksMDiJFYXjEHv1kkNutaMRiJe/ysT9DTPinNTAS/BwN9gec1wALNqB1NJZVkAmjNfDAymuRbETJBGE4P/N52FEv/j13MRyL+us/7uYhf6jEVmxFWHdQcBz1yy4vNJ36k3FiYm4dqnq9tmFTTO3ZTuY8V0fOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVBEKpbt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nv+8lsyj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767369316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcWgSJxKhh7rH3PGgygg+GR3a8mlwHXbCD1n/CcOlc8=;
	b=SVBEKpbtfEx0fyW3SM3UrULaeDHwVTBqUSfahLN6oNAOcXH0TXMwZ4d3NciPy91q6IrggK
	WEdWx/ZEhoZPJMsibAfeMgClJOzNvsVKoyrKd0uX1+BjMwWDvRUdkNvhiEH3do+uxRqnlE
	yxnKUTGe61UnlzgjMEUvFpTIFPBJZS4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-Ix06mTLFPaC6m2m2PiWS7A-1; Fri, 02 Jan 2026 10:55:13 -0500
X-MC-Unique: Ix06mTLFPaC6m2m2PiWS7A-1
X-Mimecast-MFC-AGG-ID: Ix06mTLFPaC6m2m2PiWS7A_1767369312
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso70713915e9.0
        for <linux-hyperv@vger.kernel.org>; Fri, 02 Jan 2026 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767369312; x=1767974112; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcWgSJxKhh7rH3PGgygg+GR3a8mlwHXbCD1n/CcOlc8=;
        b=Nv+8lsyjxTPgzjZGx4lcUx/lmqHRI1mXMr8Io2ADlhT6SbV9SGm39Ibwlm4Cs3pYJ+
         ZWyn3Qo0Hi+dUPx6aqxYchh8hb7C01OlVMuhlCsaSKTFeqbIX9pyDCoewYHCFuVsq6mq
         +95wWOO3VNRXzwl6nUuG6W2dBR1fniDg7wL9J4DnpyTYaNiN2rPRF1VEDu7i+wu11IhW
         Y21yhxptkkJMape44/v9NXn8YNqhEMjLh5sN0KsP9Lv4rMXVpa5Fxl1dvuqdZodmRMMw
         C5aFh+O9jQdXYihYunI/n9n4iGPzev3NeSWjV3TwSb+Y1fwgBfzvQSewf64GE3n3KisX
         OSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767369312; x=1767974112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcWgSJxKhh7rH3PGgygg+GR3a8mlwHXbCD1n/CcOlc8=;
        b=KlzdlIdyC6dNZsOHM6G7Yd2+VTIitdlIcxpene1TppLVjY2RXGXZ8ogEdw+m3BVUnj
         9L1WOGfpLBN03hxJVUshmmE5K52dsTUEjBmjnHgwPcE6Dz26XHNWehRXJT0hDMyr0Uzm
         Pq5KQzNmXDWFCRUokho/Uh/Pn1kQBP32aYQpHVaYUI7t5s7mM1kbjEbB7UjNzY7aU9Wp
         JBHE3GpfPNe3h8ZVsiOTB6jNkLMXPlPq6Vgk2jQkVbwQ1OKyNN0FTKgzO9xg7EA3epZ8
         +lM6997UzbdofppPqacsJBXhJOgcAFOatiNZC/KPCDen4lqgyiKs6vBYePH3BNXqLs3S
         NhWA==
X-Forwarded-Encrypted: i=1; AJvYcCW0fVU4kut4zP+ZXCHIJdl+EpqlL750kWB3rClV3STJwIjgQYAXAjCglMIMIjWqFGOQ7kjchv+PQtGe2tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdnNaM1o2oG3cTIrUuyw3eJV13donEvPHjo8VnXyIeDcBn9VX
	By8qhONudvPS79t+0ieB6zFl34Pz8etcFzZQUZbq9JcBRsegDkJh5NjRUzcFl2PUH/X7oM0igSV
	ADbLIJPkVSshZnmhzKw8LSJHpXnqUZN/V7XOgU7biGRnmrAOm6sVlha9+6UqbbNVBFw==
X-Gm-Gg: AY/fxX4Wl+pw0qf6Vn5tqGhawdu4lU5ZYINqFWoEZWkCuwvim4pnJm1rPVVZtNZZbzh
	rTBz9fMntBMI93cs3b9WfCWud3giezK+e1WKf2blH6DJtfAC8Xz9d7p+LOd/QRYTiDOUtf5qgHW
	LtKnO0mnXCsIq1Snayg+sf7/3L2pxyUFn9bRmmkP63xofPoT02beHBJvyRfclfdwn4+9kQvvZ+k
	MNZlIa7e3xcnApggGgV7n02kHRfIhHb1JP7LFEzM3ZZQ6Dp/biPzzra/OmYr1/i9osgxayD+j3o
	Nz6xNQd8oGWGQuOOT+tC7tNlMqkFceGzbblj3u8ShfOBKomQxAvN2aHgeLWkvMXY4iv0eNSGkmu
	rt/FbLQ==
X-Received: by 2002:a05:600c:3b2a:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d1953bd8bmr538060695e9.1.1767369312241;
        Fri, 02 Jan 2026 07:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKHKcquZ8Xxglk27XCbx2myAA+yEVZMb7oWD8RqkHQr0NzOPzJxHJWP4SDsCwraSgSeWL5Cw==
X-Received: by 2002:a05:600c:3b2a:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d1953bd8bmr538060375e9.1.1767369311851;
        Fri, 02 Jan 2026 07:55:11 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2724fe8sm948276005e9.1.2026.01.02.07.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:55:11 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com
Subject: Re: [RFC][PATCH v0] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
In-Reply-To: <20251231012100.681060-1-mrathor@linux.microsoft.com>
References: <20251231012100.681060-1-mrathor@linux.microsoft.com>
Date: Fri, 02 Jan 2026 16:55:10 +0100
Message-ID: <877bu0au1t.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mukesh Rathor <mrathor@linux.microsoft.com> writes:

> MSVC compiler used to compile the Microsoft Hyper-V hypervisor currently,
> has an assert intrinsic that uses interrupt vector 0x29 to create an
> exception. This will cause hypervisor to then crash and collect core. As
> such, if this interrupt number is assigned to a device by linux and the
> device generates it, hypervisor will crash. There are two other such
> vectors hard coded in the hypervisor, 0x2C and 0x2D. 
>
> Fortunately, the three vectors are part of the kernel driver space, and
> that makes it feasible to reserve them early so they are not assigned
> later.
>
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 579fb2c64cfd..19d41f7434df 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -478,6 +478,25 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  }
>  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>  
> +/*
> + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
> + * will crash or hang or break into debugger.
> + */
> +static void hv_reserve_irq_vectors(void)
> +{
> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
> +
> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +		BUG();

Would it be less hackish to use sysvec_install() with a dummy handler
for all three vectors instead? 

> +
> +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
> +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
> +}
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax, eax;
> @@ -510,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
>  
>  	hv_identify_partition_type();
>  
> +	if (hv_root_partition())
> +		hv_reserve_irq_vectors();
> +
>  	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
>  		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;

-- 
Vitaly


