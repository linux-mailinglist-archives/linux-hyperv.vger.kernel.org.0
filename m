Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E962232EE85
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Mar 2021 16:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCEPVi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Mar 2021 10:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCEPVL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBEC061756;
        Fri,  5 Mar 2021 07:21:11 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id x29so1590907pgk.6;
        Fri, 05 Mar 2021 07:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bGAHDIVFaRp/bdPI6zF1ZJd9aUgFlGEMGn0CcVtEKYk=;
        b=MUx/LASvSQLR4RYoO8m/RQi8+glkk5s7yXGhXqKSZZRX51R6eyHtxNzwSgsxZoG3gK
         2peagQb/CeCoh+rF5ceMp4OsaChVpJYhBDkBSXPX8+ikjCWQKFO+dx4PFhXUb9Tqf3IM
         BRTD/4owgFp3aj5BWq/aI1l95kqbCBgcGhxeD4ExINxaLEB0NFbiYtVEW/UwSkbymeyB
         vk3aHhrkPwQF9Ig1sBPLIPVgdZIxiKFqFC1lxLyEGhD1nV+tEezsEItIwsTG0SSZGiLd
         6SVqeIY2FZMrX4bjMJ68QJjswcXvF1AyIxP0AAb6JMJe4j3BIco5cOTsZPUkmmLWw3U7
         OltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bGAHDIVFaRp/bdPI6zF1ZJd9aUgFlGEMGn0CcVtEKYk=;
        b=sd6rXzaLO8WYZHVUr38XXAn7Y1XBjNnHMEovm7XVjVPF0aHXlTKhk9hwlQk9x/Zaej
         xMoXEyZC7CaBhBV33sxljyvaV+9smrnl9g1tcqYTB9MnP9t3NEcZh01RwFtX51pVVXzJ
         nL/tM20WCl93G7d5OAeh/ChuwccthAqfCEl2TtnJpKJbqtgGce7nfPdaqpYK3h1zGjRG
         nFCP7xf2ktJHS0ThRfZuE/2lshxyhf0PbTu3bXHwyQvLOT/ZW7yGLH3sIcaH9J6+WxqM
         mJbbncPycyXrXJzb3/3Zsh9LJSpBC8QE40DZtNb4/RX/byNu3iZ1wsQ/L46+xA6Jdzn8
         Sopw==
X-Gm-Message-State: AOAM531Re1DNbh2pUnMVIxYCp/FEq53cLsU5DlZVvehlhp9Rv+3ctxlU
        ngBGW/1XndKMcAO8azZ82sU=
X-Google-Smtp-Source: ABdhPJxTtcUrlOU0ojVBk/nRhKT2L7aTRDTI+pNV10V56uOHFfUJLesskrGlnHOgB81bLCMmsYrnQg==
X-Received: by 2002:a63:4e44:: with SMTP id o4mr9228695pgl.46.1614957670534;
        Fri, 05 Mar 2021 07:21:10 -0800 (PST)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
        by smtp.gmail.com with ESMTPSA id k63sm3081844pfd.48.2021.03.05.07.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 07:21:10 -0800 (PST)
Subject: Re: [RFC PATCH 5/12] HV: Add ghcb hvcall support for SNP VM
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
References: <20210228150315.2552437-1-ltykernel@gmail.com>
 <20210228150315.2552437-6-ltykernel@gmail.com>
 <87mtvkcfw8.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <d1a9dd9c-8e1d-85a8-2270-9663cec3249e@gmail.com>
Date:   Fri, 5 Mar 2021 23:21:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87mtvkcfw8.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 3/4/2021 1:21 AM, Vitaly Kuznetsov wrote:
> Tianyu Lan <ltykernel@gmail.com> writes:
> 
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Hyper-V provides ghcb hvcall to handle VMBus
>> HVCALL_SIGNAL_EVENT and HVCALL_POST_MESSAGE
>> msg in SNP Isolation VM. Add such support.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   arch/x86/hyperv/ivm.c           | 69 +++++++++++++++++++++++++++++++++
>>   arch/x86/include/asm/mshyperv.h |  1 +
>>   drivers/hv/connection.c         |  6 ++-
>>   drivers/hv/hv.c                 |  8 +++-
>>   4 files changed, 82 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index 4332bf7aaf9b..feaabcd151f5 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -14,8 +14,77 @@
>>   
>>   union hv_ghcb {
>>   	struct ghcb ghcb;
>> +	struct {
>> +		u64 hypercalldata[509];
>> +		u64 outputgpa;
>> +		union {
>> +			union {
>> +				struct {
>> +					u32 callcode        : 16;
>> +					u32 isfast          : 1;
>> +					u32 reserved1       : 14;
>> +					u32 isnested        : 1;
>> +					u32 countofelements : 12;
>> +					u32 reserved2       : 4;
>> +					u32 repstartindex   : 12;
>> +					u32 reserved3       : 4;
>> +				};
>> +				u64 asuint64;
>> +			} hypercallinput;
>> +			union {
>> +				struct {
>> +					u16 callstatus;
>> +					u16 reserved1;
>> +					u32 elementsprocessed : 12;
>> +					u32 reserved2         : 20;
>> +				};
>> +				u64 asunit64;
>> +			} hypercalloutput;
>> +		};
>> +		u64 reserved2;
>> +	} hypercall;
>>   } __packed __aligned(PAGE_SIZE);
>>   
>> +u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
>> +{
>> +	union hv_ghcb *hv_ghcb;
>> +	void **ghcb_base;
>> +	unsigned long flags;
>> +
>> +	if (!ms_hyperv.ghcb_base)
>> +		return -EFAULT;
>> +
>> +	local_irq_save(flags);
>> +	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
>> +	hv_ghcb = (union hv_ghcb *)*ghcb_base;
>> +	if (!hv_ghcb) {
>> +		local_irq_restore(flags);
>> +		return -EFAULT;
>> +	}
>> +
>> +	memset(hv_ghcb, 0x00, HV_HYP_PAGE_SIZE);
>> +	hv_ghcb->ghcb.protocol_version = 1;
>> +	hv_ghcb->ghcb.ghcb_usage = 1;
>> +
>> +	hv_ghcb->hypercall.outputgpa = (u64)output;
>> +	hv_ghcb->hypercall.hypercallinput.asuint64 = 0;
>> +	hv_ghcb->hypercall.hypercallinput.callcode = control;
>> +
>> +	if (input_size)
>> +		memcpy(hv_ghcb->hypercall.hypercalldata, input, input_size);
>> +
>> +	VMGEXIT();
>> +
>> +	hv_ghcb->ghcb.ghcb_usage = 0xffffffff;
>> +	memset(hv_ghcb->ghcb.save.valid_bitmap, 0,
>> +	       sizeof(hv_ghcb->ghcb.save.valid_bitmap));
>> +
>> +	local_irq_restore(flags);
>> +
>> +	return hv_ghcb->hypercall.hypercalloutput.callstatus;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_ghcb_hypercall);
>> +
>>   void hv_ghcb_msr_write(u64 msr, u64 value)
>>   {
>>   	union hv_ghcb *hv_ghcb;
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index f624d72b99d3..c8f66d269e5b 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -274,6 +274,7 @@ void hv_sint_rdmsrl_ghcb(u64 msr, u64 *value);
>>   void hv_signal_eom_ghcb(void);
>>   void hv_ghcb_msr_write(u64 msr, u64 value);
>>   void hv_ghcb_msr_read(u64 msr, u64 *value);
>> +u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
>>   
>>   #define hv_get_synint_state_ghcb(int_num, val)			\
>>   	hv_sint_rdmsrl_ghcb(HV_X64_MSR_SINT0 + int_num, val)
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index c83612cddb99..79bca653dce9 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -442,6 +442,10 @@ void vmbus_set_event(struct vmbus_channel *channel)
>>   
>>   	++channel->sig_events;
>>   
>> -	hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
>> +	if (hv_isolation_type_snp())
>> +		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
>> +				NULL, sizeof(u64));
>> +	else
>> +		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
> 
> vmbus_set_event() is a hotpath so I'd suggest we introduce a static
> branch instead of checking hv_isolation_type_snp() every time.
> 

Good suggestion. Will add it in the next version. Thanks.

