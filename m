Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248FB55E808
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 18:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347388AbiF1OEM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jun 2022 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347379AbiF1OEJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jun 2022 10:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E1412F383
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656425047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCQ95kskG0LV6RyOc6915lftS4TkDvmZ/mGLATm2CXA=;
        b=gFuVt3aK7zPoTw/HvBSpvFvIMcyAO7rqmLZIrMKbJandbOPZEoN+WYGKVlPP2Axvj8lhnc
        O6FcjbfPVQyBWqe5BsSFeWCsptZ4JkbcU3xhSBw1qyZrpCAGfl9RdTW0qCVMoF1oHZAkwZ
        XEOGvgKiut8kNwBLLYInFnHyfmRbPXg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-5g3eAofJNzC1miPA0yIlpg-1; Tue, 28 Jun 2022 10:04:05 -0400
X-MC-Unique: 5g3eAofJNzC1miPA0yIlpg-1
Received: by mail-wr1-f71.google.com with SMTP id n7-20020adfc607000000b0021a37d8f93aso1847038wrg.21
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 07:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tCQ95kskG0LV6RyOc6915lftS4TkDvmZ/mGLATm2CXA=;
        b=IvcpoJyxcL/YxhUb6C31HYMw1L/SV9zfsnEMdJilJpVmIGArMBx+NuiBzAMykmZ75y
         daRqtF7V4PZog3c2v9qzODu19UTuKqM2IKyC9qmJpt2EaJ5eQmiu+xwySU5uGxDXuLdG
         LEZ2PqDCSx14KqTgFe2raafizZsgB1l8eCyoc4G3PZb7rg0RUTDeB9Xse+HtUs0V8pxO
         mRj7ahohAeXAzURytB2BNRTzpC8p7VmfFgqmCUdhjSFHRGW4Z2zSugKHlkXA80xNIyLM
         H7cwtVSXWjSYM6fHfYTgkp1SUuk8POgT4P1ADfJ3BoFbWne+qWbwhtAHjvVIgTRHZVy4
         IImA==
X-Gm-Message-State: AJIora+M1/N0A7HehGclIKipmZ3ghE3voZ7klZDki6k2UohpTGLkhTvi
        NJ15WXQgt50Py3Vh8HlMaC/qkPj9Be0H7DW/0mbqcHoyuSd2DwrJWAjAdD9M+cTjN/gDeuxo8qc
        x+WYItE2X8uz+UxVzIbpEtzEB
X-Received: by 2002:a5d:5a02:0:b0:21b:939d:65c5 with SMTP id bq2-20020a5d5a02000000b0021b939d65c5mr17751623wrb.417.1656425044295;
        Tue, 28 Jun 2022 07:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0s2s3XeZUMv6q6rtAsAs/6OXYU+g4+8x0iWclWQs/xTu8cQCgmivP1LZWP4lQ+ukTOP2iCw==
X-Received: by 2002:a5d:5a02:0:b0:21b:939d:65c5 with SMTP id bq2-20020a5d5a02000000b0021b939d65c5mr17751596wrb.417.1656425044079;
        Tue, 28 Jun 2022 07:04:04 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b0020e5b4ebaecsm13855180wrt.4.2022.06.28.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:04:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] KVM: nVMX: Use vmcs_config for setting up nested
 VMX MSRs
In-Reply-To: <CALMp9eQL2a+mStk-cLwVX6NVqwAso2UYxAO7UD=Xi2TSGwUM2A@mail.gmail.com>
References: <20220627160440.31857-1-vkuznets@redhat.com>
 <CALMp9eQL2a+mStk-cLwVX6NVqwAso2UYxAO7UD=Xi2TSGwUM2A@mail.gmail.com>
Date:   Tue, 28 Jun 2022 16:04:02 +0200
Message-ID: <87y1xgubot.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Mon, Jun 27, 2022 at 9:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Changes since RFC:
>> - "KVM: VMX: Extend VMX controls macro shenanigans" PATCH added and the
>>   infrastructure is later used in other patches [Sean] PATCHes 1-3 added
>>   to support the change.
>> - "KVM: VMX: Clear controls obsoleted by EPT at runtime, not setup" PATCH
>>   added [Sean].
>> - Commit messages added.
>>
>> vmcs_config is a sanitized version of host VMX MSRs where some controls are
>> filtered out (e.g. when Enlightened VMCS is enabled, some know bugs are
>> discovered, some inconsistencies in controls are detected,...) but
>> nested_vmx_setup_ctls_msrs() uses raw host MSRs instead. This may end up
>> in exposing undesired controls to L1. Switch to using vmcs_config instead.
>>
>> Sean Christopherson (1):
>>   KVM: VMX: Clear controls obsoleted by EPT at runtime, not setup
>>
>> Vitaly Kuznetsov (13):
>>   KVM: VMX: Check VM_ENTRY_IA32E_MODE in setup_vmcs_config()
>>   KVM: VMX: Check CPU_BASED_{INTR,NMI}_WINDOW_EXITING in
>>     setup_vmcs_config()
>>   KVM: VMX: Tweak the special handling of SECONDARY_EXEC_ENCLS_EXITING
>>     in setup_vmcs_config()
>>   KVM: VMX: Extend VMX controls macro shenanigans
>>   KVM: VMX: Move CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering out of
>>     setup_vmcs_config()
>>   KVM: VMX: Add missing VMEXIT controls to vmcs_config
>>   KVM: VMX: Add missing VMENTRY controls to vmcs_config
>>   KVM: VMX: Add missing CPU based VM execution controls to vmcs_config
>>   KVM: nVMX: Use sanitized allowed-1 bits for VMX control MSRs
>>   KVM: VMX: Store required-1 VMX controls in vmcs_config
>>   KVM: nVMX: Use sanitized required-1 bits for VMX control MSRs
>>   KVM: VMX: Cache MSR_IA32_VMX_MISC in vmcs_config
>>   KVM: nVMX: Use cached host MSR_IA32_VMX_MISC value for setting up
>>     nested MSR
>>
>>  arch/x86/kvm/vmx/capabilities.h |  16 +--
>>  arch/x86/kvm/vmx/nested.c       |  37 +++---
>>  arch/x86/kvm/vmx/nested.h       |   2 +-
>>  arch/x86/kvm/vmx/vmx.c          | 198 ++++++++++++++------------------
>>  arch/x86/kvm/vmx/vmx.h          | 118 +++++++++++++++++++
>>  5 files changed, 229 insertions(+), 142 deletions(-)
>>
>> --
>> 2.35.3
>>
>
> Just checking that this doesn't introduce any backwards-compatibility
> issues. That is, all features that were reported as being available in
> the past should still be available moving forward.
>

All the controls nested_vmx_setup_ctls_msrs() set are in the newly
introduced KVM_REQ_VMX_*/KVM_OPT_VMX_* sets so we should be good here
(unless I screwed up, of course).

There's going to be some changes though. E.g this series was started by
Anirudh's report when KVM was exposing SECONDARY_EXEC_TSC_SCALING while
running on KVM and using eVMCS which doesn't support the control. This
is a bug and I don't think we need and 'bug compatibility' here.

Another change is that VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL/
VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL will now be filtered out on the
"broken" CPUs (the list is in setup_vmcs_config()). I *think* this is
also OK but if not, we can move the filtering to vmx_vmentry_ctrl()/
vmx_vmexit_ctrl().

-- 
Vitaly

