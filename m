Return-Path: <linux-hyperv+bounces-2868-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6195F16A
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 14:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25C81F228E5
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BDE1714BC;
	Mon, 26 Aug 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkk4KyOJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1721514F6
	for <linux-hyperv@vger.kernel.org>; Mon, 26 Aug 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675813; cv=none; b=jnatFkXVrrYtL7rnb2cPmQLo2H8cWeM61n1GH6VdcCti7xWNQxUHlxvjFMbOmbBE5ZJoY8hgg91i1xRA1IKE9BGgQQMtAB4KX8GM2CuT2km9xAME20F70QXjdOgZsVfJpG6apbPq2quqYXeqxIz/N395PuKdgIMgE6a0NfZtmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675813; c=relaxed/simple;
	bh=iWRFUZw7EAU7SCpienX05S6uQTjYRWJKezLcC9Sf7YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hec2SuCJx7NO4A6zqHwo3J20LQmgEYg72utTL1NwSAq3EkhgaFXxDS33RxNHtFNClVTZAzwZcXEE1E7Esbmvn9MO77zFRjS5Ix9kwAoYsLWLt+Eizf2hPyiVs4YNb1g3EzGyMZtAS/37C2VdsSaqYjpluOtEE3IO/BLiOX7nC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jkk4KyOJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724675809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mpNv0/zUncpktHjWKY5hkNa40BgmEN2ZaZZ+DFcs/s=;
	b=Jkk4KyOJ5B9LyWira2Fz/mqmN/j+XSoP5jZwO0sY0R/MITMhXQk7F5YCs0OV9cflEWC7p4
	x0HxAtNiCRsjluOntZgm2LSVoGsrH/+HE608OLNoZFJrUXUTbW9ZojL0jo8fD2JEiXJVPu
	SGmycm5NGme6Yo62qAHv9PTmq6I5Sdc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-3VfEzMhlMsmOA38DE9qdxg-1; Mon, 26 Aug 2024 08:36:48 -0400
X-MC-Unique: 3VfEzMhlMsmOA38DE9qdxg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a86884df270so321431566b.3
        for <linux-hyperv@vger.kernel.org>; Mon, 26 Aug 2024 05:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675807; x=1725280607;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mpNv0/zUncpktHjWKY5hkNa40BgmEN2ZaZZ+DFcs/s=;
        b=o8gfZxBfLUhq/5AMsGC0v9IqmcqflMsVH1n6MmGNEECfxvSIKV398h55WmSne1hsFm
         iDsoKYanmYgqiTGck0+uLqT0TOZRvX8J217lY0hZ+vFGeu/89O7bnLShn9wWvxRL5yVo
         GvQf9MBhstKXwtUt0/3vHhOH0yhK35101LaYD0WURPfd21HdAsNBjFhqs/k1nlFFNEK7
         ir9blr2lQv/n2KIf2sUfoRdyB2Ff3XQO7Wb/ejU4Td32UVZnQzjFmuOIo+/l99TjjyKT
         1iEEeEjbCXDGN01oY1fdhDcybjI/ePikD1VyxkHzP+uRsxV57i9CcKmdBQYOD+ffp7M/
         czwA==
X-Forwarded-Encrypted: i=1; AJvYcCV+LQK2fpmU6lxKZlj55RTGOFeCtGAprUC89cwAWCS8T1o9PHV7n1HNvq32vjyq8JtcVQgpz/f4w36dRRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQ8HKqKSgfkJoZLETqrVhUF0KaA7Kh+IBlyTm+dSH5C2cs0hN
	AP8ubdxFvAdbNAxT73M4Qb9VaJ2f/5Mp9WlO2L8UtWIOaNMg6yOMpvVYOA03TGGov9L830CpBXf
	a5aQIH0WIS133A1zprwvut3gnk8SVkM5H4VebBYZCCfiKF3D9GE5rarltc+TGxw==
X-Received: by 2002:a17:907:3fa6:b0:a7a:c106:364f with SMTP id a640c23a62f3a-a86a54d198dmr710878766b.43.1724675807318;
        Mon, 26 Aug 2024 05:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1RlIEl6d5JcDZs9kvOBnlK+XjHpgx2Ot6NWif/JsEW1r5gRLLOQ2rzpgkzMVRaB/uhIDA9g==
X-Received: by 2002:a17:907:3fa6:b0:a7a:c106:364f with SMTP id a640c23a62f3a-a86a54d198dmr710876466b.43.1724675806721;
        Mon, 26 Aug 2024 05:36:46 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436607sm658029666b.105.2024.08.26.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:36:46 -0700 (PDT)
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
In-Reply-To: <20240826105029.3173782-1-anirudh@anirudhrb.com>
References: <20240826105029.3173782-1-anirudh@anirudhrb.com>
Date: Mon, 26 Aug 2024 14:36:44 +0200
Message-ID: <87zfozxxyb.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anirudh Rayabharam <anirudh@anirudhrb.com> writes:

> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>
> 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
> online/offline") introduces a new cpuhp state for hyperv initialization.
>
> cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
> or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
> since a new cpuhp state was introduced it would return 0. However,
> in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
> "hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
> called on all CPUs. This means the VP assist page won't be reset. When the
> kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
> the memory region of the old VP assist page causing a panic in case the kexec
> kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
> ("x86/hyperv: Fix kexec panic/hang issues").
>
> Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
> the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
> takes place.
>
> Cc: stable@vger.kernel.org
> Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  arch/x86/hyperv/hv_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 17a71e92a343..81d1981a75d1 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -607,7 +607,7 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> -	hyperv_init_cpuhp = cpuhp;
> +	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;

Do we really need 'hyperv_init_cpuhp' at all? I.e. post-change (which
LGTM btw), I can only see one usage in hv_machine_shutdown():

   if (kexec_in_progress && hyperv_init_cpuhp > 0)
           cpuhp_remove_state(hyperv_init_cpuhp);

and I'm wondering if the 'hyperv_init_cpuhp' check is really
needed. This only case where this check would fail is if we're crashing
in between ms_hyperv_init_platform() and hyperv_init() afaiu. Does it
hurt if we try cpuhp_remove_state() anyway?

>  
>  	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
>  		hv_get_partition_id();
> @@ -637,7 +637,7 @@ void __init hyperv_init(void)
>  clean_guest_os_id:
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> -	cpuhp_remove_state(cpuhp);
> +	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
>  free_ghcb_page:
>  	free_percpu(hv_ghcb_pg);
>  free_vp_assist_page:

-- 
Vitaly


