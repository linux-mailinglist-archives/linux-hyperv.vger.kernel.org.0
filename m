Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B252A3D8
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 May 2022 15:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiEQNvZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 May 2022 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348265AbiEQNvW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 May 2022 09:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C05C526100
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652795479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DI+2TLyotaAB4m8Wk/Jy92LMvHUEqA+a9jwjfCWo8vE=;
        b=Lemx0RyDzmFfXbMk/JGU6L5UDgmCjXE1RmwbyHwHV5HKLjq2U6JH+8J0W1tfvU8QT47NjC
        T5Rj3aFSLE1t6y0zyaI5nrIFFKdiOetiL53PUsetVA5vRi+B1gt2RS3y6zcfYKi/KGtpoH
        AnZDlm8vQZxFZ9/mgiNdsXUB1dQJfTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-7tmdrCc7OOWauOPz9d56Dg-1; Tue, 17 May 2022 09:51:18 -0400
X-MC-Unique: 7tmdrCc7OOWauOPz9d56Dg-1
Received: by mail-wm1-f72.google.com with SMTP id p24-20020a1c5458000000b003945d2ffc6eso8209827wmi.5
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 06:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DI+2TLyotaAB4m8Wk/Jy92LMvHUEqA+a9jwjfCWo8vE=;
        b=GXrRLhndTsMSAOManu0nOv3dS6JPZhGnEsq5yoPqKTsGTTRc/yns0w+wQng/jTgV+m
         1oHbmIUb9wcCiRtYqil9Qyx+pahSnmyurKE3yWO/eDb1Y+79i5ibYP427gNxUXWVz+YQ
         3FKXDJL8ZgoUGd56uEt3we7+GtVs7+bf9ilgHmb3JLOAVixFyIHOtYKOi5jakP71QYDf
         st7l+ZIrFVpMRDCXwj2Vv2kN/3R7oOAek/qpWpcVtsXSiXQ23SZz50QPpvuNjn36VmTT
         VHhsFBbznprW1UbezfemKj+GgW4InaNYvmHttWFiYN0HdwSLx46y0jx80N3R38h4TG7X
         0mhA==
X-Gm-Message-State: AOAM532L5Y0Z2U1TOFoEzSQJRSNzWkG7kTm90QBhSPl1cHbp8gItmxio
        hSPufu9PUuFdfSgj88G2QsAqnNsIB7zZ1IdLpHlIQHWsvv424wh98jCuu51RjpfP31tJ2FxoWwu
        PkK4Xo0/RPTFdMWwjnJHo3TCC
X-Received: by 2002:a5d:595f:0:b0:20d:97d:4d14 with SMTP id e31-20020a5d595f000000b0020d097d4d14mr8262070wri.549.1652795477334;
        Tue, 17 May 2022 06:51:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGzb/41GwD8L8W8DX4aDq6yMVVszSErv2Y5yTV9eLtgY7MvadoakIwpfSvObshosUucUtTEA==
X-Received: by 2002:a5d:595f:0:b0:20d:97d:4d14 with SMTP id e31-20020a5d595f000000b0020d097d4d14mr8262048wri.549.1652795477119;
        Tue, 17 May 2022 06:51:17 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o16-20020adf8b90000000b0020c5253d8e0sm12819325wra.44.2022.05.17.06.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:51:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/34] KVM: x86: hyper-v: Use preallocated buffer in
 'struct kvm_vcpu_hv' instead of on-stack 'sparse_banks'
In-Reply-To: <YoKunaNKDjYx7C21@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-12-vkuznets@redhat.com>
 <YoKunaNKDjYx7C21@google.com>
Date:   Tue, 17 May 2022 15:51:15 +0200
Message-ID: <87k0akuv1o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Apr 14, 2022, Vitaly Kuznetsov wrote:
>> To make kvm_hv_flush_tlb() ready to handle L2 TLB flush requests, KVM needs
>> to allow for all 64 sparse vCPU banks regardless of KVM_MAX_VCPUs as L1
>> may use vCPU overcommit for L2. To avoid growing on-stack allocation, make
>> 'sparse_banks' part of per-vCPU 'struct kvm_vcpu_hv' which is allocated
>> dynamically.
>> 
>> Note: sparse_set_to_vcpu_mask() keeps using on-stack allocation as it
>> won't be used to handle L2 TLB flush requests.
>
> I think it's worth using stronger language; handling TLB flushes for L2 _can't_
> use sparse_set_to_vcpu_mask() because KVM has no idea how to translate an L2
> vCPU index to an L1 vCPU.  I found the above mildly confusing because it didn't
> call out "vp_bitmap" and so I assumed the note referred to yet another sparse_banks
> "allocation".  And while vp_bitmap is related to sparse_banks, it tracks something
> entirely different.
>
> Something like?
>
> Note: sparse_set_to_vcpu_mask() can never be used to handle L2 requests as
> KVM can't translate L2 vCPU indices to L1 vCPUs, i.e. its vp_bitmap array
> is still bounded by the number of L1 vCPUs and so can remain an on-stack
> allocation.

My brain is probably tainted by looking at all this for some time so I
really appreciate such improvements, thanks :)

I wouldn't, however, say "never" ('never say never' :-)): KVM could've
kept 2-level reverse mapping up-to-date:

KVM -> L2 VM list -> L2 vCPU ids -> L1 vCPUs which run them

making it possible for KVM to quickly translate between L2 VP IDs and L1
vCPUs. I don't do this in the series and just record L2 VM_ID/VP_ID for
each L1 vCPU so I have to go over them all for each request. The
optimization is, however, possible and we may get to it if really big
Windows VMs become a reality.

>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 3 +++
>>  arch/x86/kvm/hyperv.c           | 6 ++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 058061621872..837c07e213de 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -619,6 +619,9 @@ struct kvm_vcpu_hv {
>>  	} cpuid_cache;
>>  
>>  	struct kvm_vcpu_hv_tlb_flush_ring tlb_flush_ring[HV_NR_TLB_FLUSH_RINGS];
>> +
>> +	/* Preallocated buffer for handling hypercalls passing sparse vCPU set */
>> +	u64 sparse_banks[64];
>
> Shouldn't this be HV_MAX_SPARSE_VCPU_BANKS?
>

It certainly should, thanks!

-- 
Vitaly

