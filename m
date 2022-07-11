Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1F55C29B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiF0Ruf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jun 2022 13:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiF0Rue (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jun 2022 13:50:34 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E64767A
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Jun 2022 10:50:34 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101ab23ff3fso13914421fac.1
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Jun 2022 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvLc0KAoeCG/x6cMf474PJVr5c3IRBsOYfpRWzYOz64=;
        b=b13f20McHwfbhFM7Uv3QqZ+tK3PojQDPvs6uKN1cxttfYLzxMVnB/WnBHOprwgqQlr
         bX5UDBaIRyM6Pfqq1fUb4ehpuiHnwdiuB5ZuEfdtK5FQfRUrnXpSqIZaxGN6Wa3458H3
         oYa7qNKfJLj9mBObyCW0Fm1L8ESGgjWD8t7abMrFLqGCsJhW0S/M37WiHVRZ5Asqmqzk
         T0G9hekokpmUXqnaevM0IGbHvC5N7kgcvl76wTbygNP+3JS1X+mD6Nb15KJNKT2fVsri
         hZHlUd0jDQBT0aJ4yE8Xkk776Gt8YCORIXRlJsQMcJUfF+13gdNdxvoNKxtpplNDFMyH
         GBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvLc0KAoeCG/x6cMf474PJVr5c3IRBsOYfpRWzYOz64=;
        b=A4+Sq4xfllf57yqfm66U2b9r5F4OdCEpBLdKGYC1+uyinBtFlDI+6dDk8be2uQChs6
         xmETklpiaBbaRsanRDof591qz/itJYXwD3BjxmlwSHMd5k6szUWhDAHp8oTbEP2nYSdh
         DO+y3E3Urt3buKUHEKwT+Hp/4SwvLQ98c/Z92gQBxVYWGvE/tD9nAIBAJDUqawl01aXf
         AveQqiNPIfozbSCFqt2vcCwUjio10JUL3ei3btBppKmZ3H3lgOKM+PlOQ5OWRHauEhvg
         xUVAMiwK5zItc0KoliJ9l33KNMrtNdQjLBX6OdWlg/pVL+5Gdp/yofsG6rYUux1Q2qif
         2K+A==
X-Gm-Message-State: AJIora9PSsISoWMzP6zuVrR5mG9dFXQlReiU38+SIGPJ57DwErT5OtOL
        XnbhUVChs6DpM/LrZMdBbr3eOevZsVu+PaJq2VSdVQ==
X-Google-Smtp-Source: AGRyM1vGo0mK62j7gn7FGNVciNy5Vm+ednBSsRuJC5Vz4W9QRbFg8IOFjq77y9jLpFVvqi0CbrYtxJR3JSgRSty//L0=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr11029906oab.112.1656352233275; Mon, 27
 Jun 2022 10:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220627160440.31857-1-vkuznets@redhat.com>
In-Reply-To: <20220627160440.31857-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 27 Jun 2022 10:50:22 -0700
Message-ID: <CALMp9eQL2a+mStk-cLwVX6NVqwAso2UYxAO7UD=Xi2TSGwUM2A@mail.gmail.com>
Subject: Re: [PATCH 00/14] KVM: nVMX: Use vmcs_config for setting up nested
 VMX MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 27, 2022 at 9:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Changes since RFC:
> - "KVM: VMX: Extend VMX controls macro shenanigans" PATCH added and the
>   infrastructure is later used in other patches [Sean] PATCHes 1-3 added
>   to support the change.
> - "KVM: VMX: Clear controls obsoleted by EPT at runtime, not setup" PATCH
>   added [Sean].
> - Commit messages added.
>
> vmcs_config is a sanitized version of host VMX MSRs where some controls are
> filtered out (e.g. when Enlightened VMCS is enabled, some know bugs are
> discovered, some inconsistencies in controls are detected,...) but
> nested_vmx_setup_ctls_msrs() uses raw host MSRs instead. This may end up
> in exposing undesired controls to L1. Switch to using vmcs_config instead.
>
> Sean Christopherson (1):
>   KVM: VMX: Clear controls obsoleted by EPT at runtime, not setup
>
> Vitaly Kuznetsov (13):
>   KVM: VMX: Check VM_ENTRY_IA32E_MODE in setup_vmcs_config()
>   KVM: VMX: Check CPU_BASED_{INTR,NMI}_WINDOW_EXITING in
>     setup_vmcs_config()
>   KVM: VMX: Tweak the special handling of SECONDARY_EXEC_ENCLS_EXITING
>     in setup_vmcs_config()
>   KVM: VMX: Extend VMX controls macro shenanigans
>   KVM: VMX: Move CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering out of
>     setup_vmcs_config()
>   KVM: VMX: Add missing VMEXIT controls to vmcs_config
>   KVM: VMX: Add missing VMENTRY controls to vmcs_config
>   KVM: VMX: Add missing CPU based VM execution controls to vmcs_config
>   KVM: nVMX: Use sanitized allowed-1 bits for VMX control MSRs
>   KVM: VMX: Store required-1 VMX controls in vmcs_config
>   KVM: nVMX: Use sanitized required-1 bits for VMX control MSRs
>   KVM: VMX: Cache MSR_IA32_VMX_MISC in vmcs_config
>   KVM: nVMX: Use cached host MSR_IA32_VMX_MISC value for setting up
>     nested MSR
>
>  arch/x86/kvm/vmx/capabilities.h |  16 +--
>  arch/x86/kvm/vmx/nested.c       |  37 +++---
>  arch/x86/kvm/vmx/nested.h       |   2 +-
>  arch/x86/kvm/vmx/vmx.c          | 198 ++++++++++++++------------------
>  arch/x86/kvm/vmx/vmx.h          | 118 +++++++++++++++++++
>  5 files changed, 229 insertions(+), 142 deletions(-)
>
> --
> 2.35.3
>

Just checking that this doesn't introduce any backwards-compatibility
issues. That is, all features that were reported as being available in
the past should still be available moving forward.

Thanks,

--jim
