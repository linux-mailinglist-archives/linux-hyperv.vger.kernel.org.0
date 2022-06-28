Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60B55CD40
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbiF1KFv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jun 2022 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiF1KFu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jun 2022 06:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 013352CE23
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656410749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZkdqF7PxaI/l/1ULWxtUV2SzIUGChDa2pCYGEjPuo0=;
        b=gEzHUnX8DZl+v2jC0yN8iF1YC7rICj2LopFHmNddf0WCtp3HRIJzNODHqb2wvi7AtTro33
        ccxye4Fnk4vJI1YaqzC2LGsGy/dpVaWIl6dqKCF8a1k+0W5jrlCgymQ52nmBoHbt2Yfkrg
        1G8uB5VwTl5dj/r2v0QYrl5SnlBMKFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-wpM-fcKjNmyV89v-N24zCw-1; Tue, 28 Jun 2022 06:04:05 -0400
X-MC-Unique: wpM-fcKjNmyV89v-N24zCw-1
Received: by mail-wr1-f69.google.com with SMTP id z11-20020a056000110b00b0021b9c009d09so1693147wrw.17
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 03:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CZkdqF7PxaI/l/1ULWxtUV2SzIUGChDa2pCYGEjPuo0=;
        b=wdKKtJ16UkN1zLVlepBj0slWPZyysnO0T9RfGdRql7PL+7da7/bV6nMeLyE07nK4EE
         G4gL8UH7MpHFiwUHbl+TCB2LmLFDui2eMXOYEtz9+BMXrVe1p2AnayN406hbgRNM7aLa
         OAChiHeAtZ4ELg5rv1Y4Pk1yks9kocwIbjG8tzMUnavugyJrnH/USbh8E3SfXE4kh3Kt
         KIMYVZPh3ezuNGmuHuncYw6/sTOpI5ydnW3VTAE/Zo0AJqyqzi3Vq+GG104An1hlKywW
         ywdRY6xEcm0RxwYwhee0Hn/0+hP88brWBjeTge94D4GH7pAw05xhn5sWpvjmwiifC0L6
         Rxhw==
X-Gm-Message-State: AJIora8Rz4cvWcKP2rnTLnMZ6ZNTGWrlJwRl+inD7maNB0oSneywcq6n
        hqVmp2JMIey0TNPfI5lvO3CoLWu740f6gs/OTaSZgNrlCC4mEdBoQc0NipMtEgM9olfFxjirMcU
        XQ8mYs50bkpSVFZjH4yRdCr3+
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr16503389wrd.552.1656410644087;
        Tue, 28 Jun 2022 03:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1thV9O1McPGTCkEwn4a3gYeWtN14xejhgmJ7xh5kWvZYNd+w+jW03B1+RRiGJ7d+7UuV6PQTw==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr16503367wrd.552.1656410643877;
        Tue, 28 Jun 2022 03:04:03 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b0021b95bcaf7fsm13089118wrr.59.2022.06.28.03.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:04:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 00/14] KVM: nVMX: Use vmcs_config for setting up nested
 VMX MSRs
In-Reply-To: <0739589fe08c75c563e10cb41388640c7e050a52.camel@redhat.com>
References: <20220627160440.31857-1-vkuznets@redhat.com>
 <0739589fe08c75c563e10cb41388640c7e050a52.camel@redhat.com>
Date:   Tue, 28 Jun 2022 12:04:02 +0200
Message-ID: <87h745umst.fsf@redhat.com>
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

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Mon, 2022-06-27 at 18:04 +0200, Vitaly Kuznetsov wrote:
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
> Sorry that I was a bit out of loop on this, so before I review it,
> does this patch series solve the eVMCS issue we had alone,
> or we still need the eVMCS version patch series as well?

"[PATCH 00/11] KVM: VMX: Support TscScaling and EnclsExitingBitmap whith
eVMCS" adds new features, namely TSC scaling for both KVM-on-Hyper-V and
Hyper-V-on-KVM. This series doesn't add any features but avoids the
problem reported by Anirudh by properly filtering values in L1 VMX MSRs.

TL;DR: Both series are needed.

-- 
Vitaly

