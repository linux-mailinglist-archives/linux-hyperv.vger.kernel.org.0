Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0156A02B
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiGGKld (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiGGKlc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 06:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DD604F183
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657190490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pwcg7T0JuistTDUMjOvWrknPf1gKH9MIp+DFOaxmRLk=;
        b=fuEJw9ZUNg++bNFtkFC9byvxVKJ6yTXhgMsCSuFedlwBv1V6aeUQR/QnZ5PuvCdl5abyeH
        7iQ0iSIojp6Rxc0amaXsctVpDqGpiUFHxTvrJf0yzWyht9hCI+o9kOfbc5d16KpCFDOYzh
        gHQRL7w73huf8Fw7s36uOTJNTBFjMCM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-gDYiuB-sO1KoZqV_MOk-KQ-1; Thu, 07 Jul 2022 06:41:29 -0400
X-MC-Unique: gDYiuB-sO1KoZqV_MOk-KQ-1
Received: by mail-wr1-f69.google.com with SMTP id j23-20020adfb317000000b0021d7986c07eso1172869wrd.2
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Pwcg7T0JuistTDUMjOvWrknPf1gKH9MIp+DFOaxmRLk=;
        b=1/B4PwW0Vep8PFWLZhtOGPn8CMQ7dBiIUs0gdLs2X9xl4Ke/Lf8whcqngv5t24Oc2T
         /oJjebxDAhHYMt8VrQ7TvcaH83/yU5llp2Mbf8T/andGCLuBCG5KVZ2N0nJHQvrO/c9R
         LWewxEagbnU6pbL9d8fBAhKj7Bg8O/4XEpiNLCiI9vVGQ+MLgyamTqO1dHR2kBPlWH2v
         MchpmdVT57DkpugTL70RT9Eg8Fvg2ZLVULbVV8PRSo/F9Gtfe1VS2yspRMVeacPRnYFR
         7838Ml2VNKawCdhYzx1TnN1/cLjnrCsOPkO6g67hruhvb3+v4vOvCsRPkxxZS3pNf4K7
         /6DA==
X-Gm-Message-State: AJIora+bN8CsySE1pdNzOXGbC8svwSJjkppCw8VCklve8KSJawL/+FAi
        4ePrNhm0x0XA5jOBg91YWSpAOW4+ARZYDNrpye33cHgxtU4tIBNDKZDRDk6k2/xQX8kLomm62Hi
        6d7Fe5BGtl44weC6SoryhqJnu
X-Received: by 2002:a05:6000:1449:b0:21b:b171:5eb8 with SMTP id v9-20020a056000144900b0021bb1715eb8mr42593894wrx.634.1657190488445;
        Thu, 07 Jul 2022 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umfdWDsVBEWSxSBLaDDZ9YXVnNYpWt9Xos/OmPvPmnoyKP3JJo7OU6aWB2hLTWYc0keDEnWg==
X-Received: by 2002:a05:6000:1449:b0:21b:b171:5eb8 with SMTP id v9-20020a056000144900b0021bb1715eb8mr42593876wrx.634.1657190488245;
        Thu, 07 Jul 2022 03:41:28 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm28432130wms.18.2022.07.07.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:41:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/28] KVM: VMX: Add missing VMENTRY controls to
 vmcs_config
In-Reply-To: <CALMp9eTVAOCvWQ-3A6VmwhJk6skES9phMPC3O-za7Rk05SfVTg@mail.gmail.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-21-vkuznets@redhat.com>
 <CALMp9eTVAOCvWQ-3A6VmwhJk6skES9phMPC3O-za7Rk05SfVTg@mail.gmail.com>
Date:   Thu, 07 Jul 2022 12:41:26 +0200
Message-ID: <87fsjdqk6h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> As a preparation to reusing the result of setup_vmcs_config() in
>> nested VMX MSR setup, add the VMENTRY controls which KVM doesn't
>> use but supports for nVMX to KVM_OPT_VMX_VM_ENTRY_CONTROLS and
>> filter them out in vmx_vmentry_ctrl().
>>
>> No functional change intended.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 3 +++
>>  arch/x86/kvm/vmx/vmx.h | 4 +++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index e5ab77ed37e4..b774b6391e0e 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4179,6 +4179,9 @@ static u32 vmx_vmentry_ctrl(void)
>>  {
>>         u32 vmentry_ctrl = vmcs_config.vmentry_ctrl;
>>
>> +       /* Not used by KVM but supported for nesting. */
>> +       vmentry_ctrl &= ~(VM_ENTRY_SMM | VM_ENTRY_DEACT_DUAL_MONITOR);
>> +
>
> LOL! KVM does not emulate the dual-monitor treatment of SMIs and SMM.
> Do we actually claim to support these VM-entry controls today?!?
>

No, just a brainfart on my side, nested_vmx_setup_ctls_msrs() filters
them out too. I'll drop the patch.

>>         if (vmx_pt_mode_is_system())
>>                 vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
>>                                   VM_ENTRY_LOAD_IA32_RTIT_CTL);
>> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>> index d4503a38735b..7ada8410a037 100644
>> --- a/arch/x86/kvm/vmx/vmx.h
>> +++ b/arch/x86/kvm/vmx/vmx.h
>> @@ -479,7 +479,9 @@ static inline u8 vmx_get_rvi(void)
>>                 __KVM_REQ_VMX_VM_ENTRY_CONTROLS
>>  #endif
>>  #define KVM_OPT_VMX_VM_ENTRY_CONTROLS                          \
>> -       (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |                  \
>> +       (VM_ENTRY_SMM |                                         \
>> +       VM_ENTRY_DEACT_DUAL_MONITOR |                           \
>> +       VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |                   \
>>         VM_ENTRY_LOAD_IA32_PAT |                                \
>>         VM_ENTRY_LOAD_IA32_EFER |                               \
>>         VM_ENTRY_LOAD_BNDCFGS |                                 \
>> --
>> 2.35.3
>>
>

-- 
Vitaly

