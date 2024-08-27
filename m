Return-Path: <linux-hyperv+bounces-2879-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE55960470
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6121F2366D
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591119644B;
	Tue, 27 Aug 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmRMpfiG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8C131182
	for <linux-hyperv@vger.kernel.org>; Tue, 27 Aug 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747568; cv=none; b=h7bKVWhP2CrcIaDHRFxkf44tdBB1Z39pFVuhjPthddfaBBHxTGVddP5b+PKAe/Za71SAZ0vnBltlSmotbAxm1rSa7lEQsekAvdILp2kZs/JxpJUdwbY9diV1AGe5Bi1yDrQw2inMjE/uU83s8beYLpnpimAvJ9z8W7PUnOjGPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747568; c=relaxed/simple;
	bh=w3e2l/LkFkI1FKRdLYSz+PC3KjWBIaRK2n5Zp2WvPWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3mJsge1MeA82MylNkIPcMnjEfAyiYsmKUWxFvgwPqEtIjqYwsNs8e9rNChHEPNAxTHrVgt26028m4CBgJbVT33YimJ6HNVt1AKaAB12PPHZunoq6jpNTnT29nzlci1HJ0ntRyQI1ON86Mz1ipWosNXHfIBc516WxXAS1t7p37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmRMpfiG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724747566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6KVgv1IL2HPmMPmJO9/W7wft0+lwNpol6UUqmyiHZI=;
	b=JmRMpfiG2gBJV3efvFMb5EGB6MyDY53dgbK0lQBS8EJegnKskMKipKyXjiFpRhZ1eHvj7m
	+IeQpVWm5KDPRVHRsgmk8GhT+csdRJWtWAlVyO2bq22iWHw58HtAOGh9liqJ3ulX2lfOmA
	fYvEYly6cbBNFTdFp0V/fPxlWsrdWMM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-TrwdCbGiOi-PdWh-M9k3lA-1; Tue, 27 Aug 2024 04:32:44 -0400
X-MC-Unique: TrwdCbGiOi-PdWh-M9k3lA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5334573b3e6so4603165e87.2
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Aug 2024 01:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747563; x=1725352363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6KVgv1IL2HPmMPmJO9/W7wft0+lwNpol6UUqmyiHZI=;
        b=PUppezComXhEqW7gaSK/V2N/ZMFInJ7NYO/b06Rg0z8MFaUhLF+zc8MB+rMX7VZQg2
         hd5JDF48buB8cuwdpJgb/W6l7S0LnzQfcmmT+VhOFZtNvMZis7aZqN0m5Gc82ltw4wce
         kbGjLwUhUkFflSEVNk3mN9kJylrbuwcFNSCa7Z8rdpiv7TvNcqdTvqSOkxUCwccsm1Pq
         ma+irfCBJwKDrJzFvsqi/VHNYNMmUQPd1+ArhZ0QdbUuif9iqa09XQXD2k/4BSelCViN
         eZ4xeNMnyNFb7M9/ls5tc5H4zW4Knj8Hj4uqPa23ErU0pq0G6iQmjTXqu+e9LEmSZbVD
         FG3w==
X-Forwarded-Encrypted: i=1; AJvYcCUiImaK3anRXT2Sr7u1dsHhWY70boicEnmquhIi+27gC/hVJ9TIZf3p25i3jjUK7LUck9kMUMLv5jkSduM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzNTCBnwabi3Z/qxwb5IGqajymyZmhs+oQk0mpUf8w21fhnbE
	mAwXku+8aJTGCgjjjc7f8i5ZktFlpw3xfGIaZWDnVNYL++LzVfsMFOtbtUeYaYKOTt51eWh12qx
	h4K5uHzTpMZeBY7BkgXPHLGg4y+odstCRtyUIYl53s3OjXn+uUASgsb7h1QE2Gg==
X-Received: by 2002:a05:6512:1395:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-5343870c302mr8057090e87.0.1724747562925;
        Tue, 27 Aug 2024 01:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKg67blLe1ufYFNA3yQVBWOA7L339P3C4Z2XLP23b4E0lZT1vUhPQUB9g2nPFuV3RXc6LU8Q==
X-Received: by 2002:a05:6512:1395:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-5343870c302mr8057068e87.0.1724747562285;
        Tue, 27 Aug 2024 01:32:42 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582de25sm79641566b.122.2024.08.27.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:32:41 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: stable@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: fix kexec crash due to VP assist page
 corruption
In-Reply-To: <11001.124082704082000271@us-mta-164.us.mimecast.lan>
References: <20240826105029.3173782-1-anirudh@anirudhrb.com>
 <87zfozxxyb.fsf@redhat.com>
 <11001.124082704082000271@us-mta-164.us.mimecast.lan>
Date: Tue, 27 Aug 2024 10:32:41 +0200
Message-ID: <87wmk2xt5i.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anirudh Rayabharam <anirudh@anirudhrb.com> writes:

> On Mon, Aug 26, 2024 at 02:36:44PM +0200, Vitaly Kuznetsov wrote:
>> Anirudh Rayabharam <anirudh@anirudhrb.com> writes:
>> 
>> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>> >
>> > 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
>> > online/offline") introduces a new cpuhp state for hyperv initialization.
>> >
>> > cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
>> > or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
>> > since a new cpuhp state was introduced it would return 0. However,
>> > in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
>> > "hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
>> > called on all CPUs. This means the VP assist page won't be reset. When the
>> > kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
>> > the memory region of the old VP assist page causing a panic in case the kexec
>> > kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
>> > ("x86/hyperv: Fix kexec panic/hang issues").
>> >
>> > Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
>> > the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
>> > takes place.
>> >
>> > Cc: stable@vger.kernel.org
>> > Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
>> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>> > ---
>> >  arch/x86/hyperv/hv_init.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > index 17a71e92a343..81d1981a75d1 100644
>> > --- a/arch/x86/hyperv/hv_init.c
>> > +++ b/arch/x86/hyperv/hv_init.c
>> > @@ -607,7 +607,7 @@ void __init hyperv_init(void)
>> >  
>> >  	register_syscore_ops(&hv_syscore_ops);
>> >  
>> > -	hyperv_init_cpuhp = cpuhp;
>> > +	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;
>> 
>> Do we really need 'hyperv_init_cpuhp' at all? I.e. post-change (which
>> LGTM btw), I can only see one usage in hv_machine_shutdown():
>> 
>>    if (kexec_in_progress && hyperv_init_cpuhp > 0)
>>            cpuhp_remove_state(hyperv_init_cpuhp);
>> 
>> and I'm wondering if the 'hyperv_init_cpuhp' check is really
>> needed. This only case where this check would fail is if we're crashing
>> in between ms_hyperv_init_platform() and hyperv_init() afaiu. Does it
>
> Or if we fail to setup the cpuhp state for some reason but don't
> actually crash and then later do a kexec?

I see this can happen for CPUHP_AP_ONLINE_DYN/CPUHP_BP_PREPARE_DYN
because we run out of free slots (40/20), but here we have our own
dedicated CPUHP_AP_HYPERV_ONLINE and other failure paths seem to be
exotic...

>
> I guess I was just trying to be extra safe and make sure we have
> actually setup the cpuhp state before calling cpuhp_remove_state()
> for it. However, looking elsewhere in the kernel code I don't
> see anybody doing this for custom states...
>
>> hurt if we try cpuhp_remove_state() anyway?
>
> cpuhp_invoke_callback() would trigger a WARNING if we try to remove a
> cpuhp state that was never setup.
>
> 184         if (cpuhp_step_empty(bringup, step)) {
> 185                 WARN_ON_ONCE(1);
> 186                 return 0;
> 187         }
>

Personally, I'd say that getting an extra WARN for such a corner case
(failing to setup cpuhp state or crashing in between
ms_hyperv_init_platform() and hyperv_init()) is OK. 

Alternatively, we can convert hyperv_init_cpuhp to a boolean to make it
a bit more staitforward but as it's uncomon to do it for other states,
it's likely an overkill.

-- 
Vitaly


