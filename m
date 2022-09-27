Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E15EBF7B
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Sep 2022 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiI0KMp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Sep 2022 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiI0KMe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Sep 2022 06:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00181CC8EB
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Sep 2022 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664273521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQd8FYCDQy3HQURocCej6OC1RjFJIa51YDrjxzf/0AM=;
        b=foBVWIyDcQ0vWJf1MEAZYcn8tUyRAacfeFLN9DjV/BxJzZaNS1yk7cLpwxTZK4mGpc5Z23
        BQAEk7bBR/YN0MgJnrKZPYc7GtZFmEqdVritDs38D8K+X7Nh+jtYRZoqtNN6Nn22nWgAR9
        /Fc9xncG2iMRskqT6/5sWDqZYH3cMU0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-iAFVYXh9MgC_KCRB8xzgiQ-1; Tue, 27 Sep 2022 06:11:59 -0400
X-MC-Unique: iAFVYXh9MgC_KCRB8xzgiQ-1
Received: by mail-ed1-f69.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so7393824edz.0
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Sep 2022 03:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=OQd8FYCDQy3HQURocCej6OC1RjFJIa51YDrjxzf/0AM=;
        b=tmjQMWsiWUn86k4GPXgstMF3Dh0hQdgARV1RoTXYTIrR5NMC3YFGPfqSyoyThVDT1r
         9hBLuPthVAwrz58ScSN55EiJqDUkKHUz7QuysxkTlWmkdAyONZL1Yrw7ehSt6b0GQVFD
         S9jWfHndfpHVvIrE5J6YvzG9uVsHPNicY6kdX/RlshKrg6BPB+SM/EiUtkFTqyp6n/7m
         wWkmaZ1N8LJzNmwLLz3XUvOHZdPzHHM/w4QtoulO0EXHr7i/eQrYbDIEIA7LHJL8GFGY
         fQlXO0Yk5nPKDVAydyHygYl2as97f3vnbHNyukWkc2OJbNq03M6MGdgq2IR3ejnfbsd+
         Q/2w==
X-Gm-Message-State: ACrzQf0tc+9omRUSZF2cXJSdjol0QWquEVsnFPzFx5BcZYE8aW5ZuRXn
        4C1g7hYgwEJ42YfT5JR9tJPgaT4jKjnfEgiT4QlRpHqjv4wbORm2PqHVOI7i+2eV+dzUYCVgs3w
        om9OfS/uzkdY7iVDXwh2IFN2v
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr4056432ejc.628.1664273518593;
        Tue, 27 Sep 2022 03:11:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5a/uFARed6CYSDEjLBgEocSIoC2LGZ4xrTfoHJ7Pq7WGxYRuIWKX+ve0FETVLwQS3Do7XTlg==
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr4056405ejc.628.1664273518308;
        Tue, 27 Sep 2022 03:11:58 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d41-20020a056402402900b0045703d699b9sm931101eda.78.2022.09.27.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:11:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86/hyperv: Move VMCB enlightenment definitions to
 hyperv-tlfs.h
In-Reply-To: <YyzgD0xp/Ki9a3jK@google.com>
References: <20220921201607.3156750-1-seanjc@google.com>
 <20220921201607.3156750-2-seanjc@google.com>
 <BYAPR21MB1688D04068DBA520366DA205D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <YyzgD0xp/Ki9a3jK@google.com>
Date:   Tue, 27 Sep 2022 12:11:56 +0200
Message-ID: <87tu4tktxv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Sep 22, 2022, Michael Kelley (LINUX) wrote:
>> From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, September 21, 2022 1:16 PM
>> > 
>> > Move Hyper-V's VMCB enlightenment definitions to the TLFS header; the
>> > definitions come directly from the TLFS[*], not from KVM.
>> > 
>> > No functional change intended.
>> > 
>> > [*] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_svm_enlightened_vmcb_fields> 
>> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>> > ---
>> >  arch/x86/include/asm/hyperv-tlfs.h | 22 +++++++++++++++++++
>> >  arch/x86/kvm/svm/hyperv.h          | 35 ------------------------------
>> >  arch/x86/kvm/svm/svm_onhyperv.h    |  3 ++-
>> >  3 files changed, 24 insertions(+), 36 deletions(-)
>> >  delete mode 100644 arch/x86/kvm/svm/hyperv.h
>> > 
>> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> > index 0a9407dc0859..4c4f81daf5a2 100644
>> > --- a/arch/x86/include/asm/hyperv-tlfs.h
>> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> > @@ -584,6 +584,28 @@ struct hv_enlightened_vmcs {
>> > 
>> >  #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL			0xFFFF
>> > 
>> > +/*
>> > + * Hyper-V uses the software reserved 32 bytes in VMCB control area to expose
>> > + * SVM enlightenments to guests.
>> > + */
>> > +struct hv_enlightenments {
>> > +	struct __packed hv_enlightenments_control {
>> > +		u32 nested_flush_hypercall:1;
>> > +		u32 msr_bitmap:1;
>> > +		u32 enlightened_npt_tlb: 1;
>> > +		u32 reserved:29;
>> > +	} __packed hv_enlightenments_control;
>> > +	u32 hv_vp_id;
>> > +	u64 hv_vm_id;
>> > +	u64 partition_assist_page;
>> > +	u64 reserved;
>> > +} __packed;
>> > +
>> > +/*
>> > + * Hyper-V uses the software reserved clean bit in VMCB.
>> > + */
>> > +#define VMCB_HV_NESTED_ENLIGHTENMENTS		31
>> 
>> Is it feasible to change this identifier so it starts with HV_ like
>> everything else in this source code file, such as
>> HV_VMCB_NESTED_ENLIGHTENMENTS?  It doesn't look like it is
>> used in very many places.  
>
> Most definitely, IIRC it's used in only one spot.
>

I'll take these 4 patches to the next iteration of my "KVM: x86:
hyper-v: Fine-grained TLB flush + L2 TLB flush features" series and I'll
change VMCB_HV_NESTED_ENLIGHTENMENTS to HV_VMCB_NESTED_ENLIGHTENMENTS.

-- 
Vitaly

