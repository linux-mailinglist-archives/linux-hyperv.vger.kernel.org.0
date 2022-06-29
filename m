Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F055FB68
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jun 2022 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiF2JGx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jun 2022 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiF2JGw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jun 2022 05:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D8E227CE1
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Jun 2022 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656493610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvWzvzdAUmdish1ZjSGH2vHCDmFvOStbYvaW/KwyrXg=;
        b=i9xJvqZ0dB8X4DW+xmyB6djIMiyLqJdQ8egMleHFIOMVYL41kvP517I+PaXJ9pohIhac7/
        t5TA8uNgxwqqn89EB2+psmEy4yFTKAVrkGGs15rhUFbH90iivjoOHBQpOEOOofF5MQ+I0R
        ZLkhY41FkiKIb8PbPfhaTzU+XcgNMOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-gOhpfIgAP8SV65kvuaop6w-1; Wed, 29 Jun 2022 05:06:48 -0400
X-MC-Unique: gOhpfIgAP8SV65kvuaop6w-1
Received: by mail-wr1-f69.google.com with SMTP id l9-20020adfa389000000b0021b8b489336so2215371wrb.13
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Jun 2022 02:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HvWzvzdAUmdish1ZjSGH2vHCDmFvOStbYvaW/KwyrXg=;
        b=glRJf7ExbFV3fRiTsO7iVvSSR5Vf+r4AfD9oZe/Ji5X3KoFMA2v+pVZT7T6/Kacl/E
         vvKxfpYoHTfVkJspLYWuPHqgiqORVjPpnvWL3AaTyoYXfGwPWerbYMFK30OOsBClfZz7
         qRRvNDKy5ZgPzU0PTO8DRwBzJAreI4dw8uCgkrkDF7MrWoe5d3RbPhFsUh0HGGoORqbM
         RNj/WriGIXnR4xjLNktEnyIhD4fJ7XACEI1TPzEtHiBm+AcVKiutpCvykw7EHfob72/d
         ux3ZUb/sXEmiij93zhmxre5ltHTkkwFizsMhM2NoVcWZIfQLahf4MbKZ9I0is0TwATTN
         9Z2Q==
X-Gm-Message-State: AJIora/jqKVY/96g3gRqx1/P+LG1/4tvNhBAnyBGCdtoTk6hU2Yo2pl5
        RvILdFDyc0yTM8GN3gpZcQPMKoySVYKQS1Ej3gVQOHTW/excvODbHmcd/7TPy4EcZT46X1q9k/i
        y5oVi9vihAgw9MBpaKXhTQDnH
X-Received: by 2002:a5d:53ca:0:b0:21b:940f:8e29 with SMTP id a10-20020a5d53ca000000b0021b940f8e29mr2024196wrw.490.1656493607749;
        Wed, 29 Jun 2022 02:06:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slfgJ4CmLtTDf48t9U1mX1pHXjxoYEcJdwqwzZ9MajWVRs6KVcjT0ny0vB8KhBz1k0tami8A==
X-Received: by 2002:a5d:53ca:0:b0:21b:940f:8e29 with SMTP id a10-20020a5d53ca000000b0021b940f8e29mr2024164wrw.490.1656493607451;
        Wed, 29 Jun 2022 02:06:47 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b003a03ae64f57sm2609957wma.8.2022.06.29.02.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:06:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] KVM: nVMX: Use vmcs_config for setting up nested
 VMX MSRs
In-Reply-To: <CALMp9eQ35g8GpwObYBJRxjuxZAC8P_HNMMaC0v0uZeC+pMeW_Q@mail.gmail.com>
References: <20220627160440.31857-1-vkuznets@redhat.com>
 <CALMp9eQL2a+mStk-cLwVX6NVqwAso2UYxAO7UD=Xi2TSGwUM2A@mail.gmail.com>
 <87y1xgubot.fsf@redhat.com>
 <CALMp9eSBLcvuNDquvSfUnaF3S3f4ZkzqDRSsz-v93ZeX=xnssg@mail.gmail.com>
 <87letgu68x.fsf@redhat.com>
 <CALMp9eQ35g8GpwObYBJRxjuxZAC8P_HNMMaC0v0uZeC+pMeW_Q@mail.gmail.com>
Date:   Wed, 29 Jun 2022 11:06:46 +0200
Message-ID: <87czeru9cp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Tue, Jun 28, 2022 at 9:01 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>

...

>
> Read-only MSRs cannot be changed after their values may have been
> observed by the guest.
>
>> Anirudh, the same concern applies to your 'intermediate' patch too.
>>
>> Smart ideas on what can be done are more than welcome)
>
> You could define a bunch of "quirks," and userspace could use
> KVM_CAP_DISABLE_QUIRKS2 to ask that the broken bits be cleared.

This sounds correct, but awful :-) I, however, think we can avoid this.

For the KVM-on-eVMCS case:
- When combined with "[PATCH 00/11] KVM: VMX: Support TscScaling and
EnclsExitingBitmap whith eVMCS" series
(https://lore.kernel.org/kvm/20220621155830.60115-1-vkuznets@redhat.com/),
the filtering we do in setup_vmcs_config() is no longer needed. I need
to check various available Hyper-V versions but my initial investigation
shows that we were only filtering out TSC Scaling and 'Load
IA32_PERF_GLOBAL_CTRL' vmexit/vmentry, the rest were never present in
VMX control MSRs (as presented by Hyper-V) in the first place.

For PERF_GLOBAL_CTRL errata:
- We can move the filtering to vmx_vmexit_ctrl()/vmx_vmentry_ctrl()
preserving the status quo: KVM doesn't use the feature but it is exposed
to L1 hypervisor (and L1 hypervisor presumably has the same check and
doesn't use the feature. FWIW, the workaround was added in 2011 and the
erratas it references appeared in 2010, this means that the affected
CPUs are quite old, modern proprietary hypervisors won't likely boot
there).

If we do the above, there's going to be no changes to VMX control MSRs
generated by nested_vmx_setup_ctls_msrs(). I, however, need to work on
a combined series.

-- 
Vitaly

