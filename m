Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859E132C6CC
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 02:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442187AbhCDAaG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 19:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1574294AbhCCRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Mar 2021 12:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614792085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CAwyU1BHNDoyV8EO5GioXHZdHdDn0xPfe1nQ/O6geG4=;
        b=HVXR3K4JJS1sQgRk1XfmALVGaClIPicCf1B7iUma8gYuCqna9ca+/VXGWyUFo3G9gGfAr+
        0CWMef/EHszm26Du5m/S5BoKAzEDtMkq2AdvLCoVoWC0bIAn+MXujQ7YUZJ6lgb+ltFThq
        ZnJseAW0jt2/ifPKhtNuwfb3i7VIEn0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-fu-3oGKIO0-xKjDg1z9lvQ-1; Wed, 03 Mar 2021 12:21:14 -0500
X-MC-Unique: fu-3oGKIO0-xKjDg1z9lvQ-1
Received: by mail-ed1-f70.google.com with SMTP id u1so10604255edt.4
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Mar 2021 09:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CAwyU1BHNDoyV8EO5GioXHZdHdDn0xPfe1nQ/O6geG4=;
        b=YOffRLA42gnh/iIDau/gNNlWUI9wX8ZIdI/qO5ikX3Y9bApWuPRA3NsQPDgJI1BPce
         g8/5imWYwJTYGerrNY2MJaH3zRhDLe1jPRWvGk+X5TQIDnZv3b1vuNv3VHTTm/PzcdAc
         44J5DWLn41DZDQ9o3ta7XH5TW8Q8oKuYCt7jdCoBdWEqvrSJxZJ6kAVStLycMuZF71gC
         iuuDSpGnUagoFaQpoO+MDlZipIub+HMcOm/NxBu28KPz7b649aZJYIrLSClyrSkKQvRR
         Mpzi1v1RIql1TFm894+EYg1zyNbVTCvnC49/JMdhn5LscP+Jrhf/LzdCm8kKQNW8Yylc
         J+/A==
X-Gm-Message-State: AOAM531J8o0B2QKvev/74e2Us0l9xVD8wwo9mVpWff8QtdQxY86VXxIv
        mgpUfK/g/r9NgAReYG2bXSEK/FiQTzLgFqBZx0WqhNlEp59u9wBUH301suWxn+URNTfkZPUqWwQ
        nvmR6/oaqnJz1PCgJT8tKl6+0
X-Received: by 2002:aa7:cd94:: with SMTP id x20mr332362edv.53.1614792073127;
        Wed, 03 Mar 2021 09:21:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwty1xIzXyywNnOr8oKLUrlKOHFnVxaaKcLshQU3Al/qp0TSfgK2IbqBaBG6Pranmy85FHGOw==
X-Received: by 2002:aa7:cd94:: with SMTP id x20mr332331edv.53.1614792072969;
        Wed, 03 Mar 2021 09:21:12 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o8sm22625148edj.79.2021.03.03.09.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:21:12 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: Re: [RFC PATCH 5/12] HV: Add ghcb hvcall support for SNP VM
In-Reply-To: <20210228150315.2552437-6-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
 <20210228150315.2552437-6-ltykernel@gmail.com>
Date:   Wed, 03 Mar 2021 18:21:11 +0100
Message-ID: <87mtvkcfw8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Hyper-V provides ghcb hvcall to handle VMBus
> HVCALL_SIGNAL_EVENT and HVCALL_POST_MESSAGE
> msg in SNP Isolation VM. Add such support.
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 69 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h |  1 +
>  drivers/hv/connection.c         |  6 ++-
>  drivers/hv/hv.c                 |  8 +++-
>  4 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 4332bf7aaf9b..feaabcd151f5 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -14,8 +14,77 @@
>  
>  union hv_ghcb {
>  	struct ghcb ghcb;
> +	struct {
> +		u64 hypercalldata[509];
> +		u64 outputgpa;
> +		union {
> +			union {
> +				struct {
> +					u32 callcode        : 16;
> +					u32 isfast          : 1;
> +					u32 reserved1       : 14;
> +					u32 isnested        : 1;
> +					u32 countofelements : 12;
> +					u32 reserved2       : 4;
> +					u32 repstartindex   : 12;
> +					u32 reserved3       : 4;
> +				};
> +				u64 asuint64;
> +			} hypercallinput;
> +			union {
> +				struct {
> +					u16 callstatus;
> +					u16 reserved1;
> +					u32 elementsprocessed : 12;
> +					u32 reserved2         : 20;
> +				};
> +				u64 asunit64;
> +			} hypercalloutput;
> +		};
> +		u64 reserved2;
> +	} hypercall;
>  } __packed __aligned(PAGE_SIZE);
>  
> +u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
> +{
> +	union hv_ghcb *hv_ghcb;
> +	void **ghcb_base;
> +	unsigned long flags;
> +
> +	if (!ms_hyperv.ghcb_base)
> +		return -EFAULT;
> +
> +	local_irq_save(flags);
> +	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
> +	hv_ghcb = (union hv_ghcb *)*ghcb_base;
> +	if (!hv_ghcb) {
> +		local_irq_restore(flags);
> +		return -EFAULT;
> +	}
> +
> +	memset(hv_ghcb, 0x00, HV_HYP_PAGE_SIZE);
> +	hv_ghcb->ghcb.protocol_version = 1;
> +	hv_ghcb->ghcb.ghcb_usage = 1;
> +
> +	hv_ghcb->hypercall.outputgpa = (u64)output;
> +	hv_ghcb->hypercall.hypercallinput.asuint64 = 0;
> +	hv_ghcb->hypercall.hypercallinput.callcode = control;
> +
> +	if (input_size)
> +		memcpy(hv_ghcb->hypercall.hypercalldata, input, input_size);
> +
> +	VMGEXIT();
> +
> +	hv_ghcb->ghcb.ghcb_usage = 0xffffffff;
> +	memset(hv_ghcb->ghcb.save.valid_bitmap, 0,
> +	       sizeof(hv_ghcb->ghcb.save.valid_bitmap));
> +
> +	local_irq_restore(flags);
> +
> +	return hv_ghcb->hypercall.hypercalloutput.callstatus;
> +}
> +EXPORT_SYMBOL_GPL(hv_ghcb_hypercall);
> +
>  void hv_ghcb_msr_write(u64 msr, u64 value)
>  {
>  	union hv_ghcb *hv_ghcb;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index f624d72b99d3..c8f66d269e5b 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -274,6 +274,7 @@ void hv_sint_rdmsrl_ghcb(u64 msr, u64 *value);
>  void hv_signal_eom_ghcb(void);
>  void hv_ghcb_msr_write(u64 msr, u64 value);
>  void hv_ghcb_msr_read(u64 msr, u64 *value);
> +u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
>  
>  #define hv_get_synint_state_ghcb(int_num, val)			\
>  	hv_sint_rdmsrl_ghcb(HV_X64_MSR_SINT0 + int_num, val)
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index c83612cddb99..79bca653dce9 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -442,6 +442,10 @@ void vmbus_set_event(struct vmbus_channel *channel)
>  
>  	++channel->sig_events;
>  
> -	hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
> +	if (hv_isolation_type_snp())
> +		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
> +				NULL, sizeof(u64));
> +	else
> +		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);

vmbus_set_event() is a hotpath so I'd suggest we introduce a static
branch instead of checking hv_isolation_type_snp() every time.

>  }
>  EXPORT_SYMBOL_GPL(vmbus_set_event);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 28e28ccc2081..6c64a7fd1ebd 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -60,7 +60,13 @@ int hv_post_message(union hv_connection_id connection_id,
>  	aligned_msg->payload_size = payload_size;
>  	memcpy((void *)aligned_msg->payload, payload, payload_size);
>  
> -	status = hv_do_hypercall(HVCALL_POST_MESSAGE, aligned_msg, NULL);
> +	if (hv_isolation_type_snp())
> +		status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
> +				(void *)aligned_msg, NULL,
> +				sizeof(struct hv_input_post_message));
> +	else
> +		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
> +				aligned_msg, NULL);

and, if we are to introduce a static branch, we could use it here
(though it doesn't matter much for messages).

>  
>  	/* Preemption must remain disabled until after the hypercall
>  	 * so some other thread can't get scheduled onto this cpu and

-- 
Vitaly

