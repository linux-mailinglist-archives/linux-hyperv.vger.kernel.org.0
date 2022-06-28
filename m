Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78855EAA8
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiF1RLT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jun 2022 13:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiF1RLS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jun 2022 13:11:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE212C12C
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 10:11:17 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-101bb9275bcso17875607fac.8
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Jun 2022 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9iQSlpW/Sg98O8w3kQrkvkAcMFnb09BQssJyDNeW5o=;
        b=RgTwDThn6/Nl98GpEo6dfFMm4xqIZT7SgaRaNSYHH2qpRxST1hbQCcxFtBIrgmgsdB
         KeWqHT6gpzsh04hezaHxC3GesbwdfbNWcAhlTKVekIOdZdMzT44oooHw1y6wDJvkrpnk
         fNgxFWeHxYUIWW4gUhFc1VTbb+JXvoyDk4bhaxjCJ+r9q0yZVOOezChnp9zTdALdJVqx
         bW7su34tRzk2WsIyzgmi9eqt+91g92tQmzDBI7H7qB70kKMymmSQzeWPd1526SFUvKWN
         OsTTcAuiJDqVbEErmzlRq7E1m08COd0HYD5FhZDs5z5AmO1mZRChmoy+ACqtR9GyJphu
         DtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9iQSlpW/Sg98O8w3kQrkvkAcMFnb09BQssJyDNeW5o=;
        b=hrmDFiFNhmLMk5gsWL4DxGjZAyU7duzmRTYZCD6LydsXXEhdFQYywNat3S12Yrl8O8
         1b4KEn5wLBQJB8fd7Eo4uXdowcbygAtfzoOeZZsfPumqhVbe9Apgs6u3H1yZHKPdTLdY
         1ppmp8LQeUmkKwnjUWLvTRD24iCDPcuagVyMxgRUojEqeDDVMOY8eKdMS/8h1YK5PLIC
         KQBnAUzHmd5z03sCfo3sKtOqJIeT1AXm5Li1NczZ03eMG/Apvv4QjuXmcc7bi5m5PFyQ
         vUT3AfecihqhjL9fHr6rpZXLFCOUlsyOKumueG3WMwx3IMKcfuPNQaF1xFwHUnCSWvnV
         Fxsg==
X-Gm-Message-State: AJIora/CtohE+6GhMvLWKvopoBKIh/sv+dvnFnmaFaiCV3BJuYQWWgXY
        hSe845PYVtKDVT9fx9C0DzKlJGXryKDafXu12CNwnw==
X-Google-Smtp-Source: AGRyM1sR4z6Ah0rmM+btTilt1SEBv5YU5YK20x1hgCzFACKUxuftJ/EZ2eE9WBOB9VocegfWn+DlqKjSGy/lk5o+liI=
X-Received: by 2002:a05:6870:d3c7:b0:104:9120:8555 with SMTP id
 l7-20020a056870d3c700b0010491208555mr360162oag.181.1656436275331; Tue, 28 Jun
 2022 10:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220627160440.31857-1-vkuznets@redhat.com> <CALMp9eQL2a+mStk-cLwVX6NVqwAso2UYxAO7UD=Xi2TSGwUM2A@mail.gmail.com>
 <87y1xgubot.fsf@redhat.com> <CALMp9eSBLcvuNDquvSfUnaF3S3f4ZkzqDRSsz-v93ZeX=xnssg@mail.gmail.com>
 <87letgu68x.fsf@redhat.com>
In-Reply-To: <87letgu68x.fsf@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jun 2022 10:11:04 -0700
Message-ID: <CALMp9eQ35g8GpwObYBJRxjuxZAC8P_HNMMaC0v0uZeC+pMeW_Q@mail.gmail.com>
Subject: Re: [PATCH 00/14] KVM: nVMX: Use vmcs_config for setting up nested
 VMX MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
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

On Tue, Jun 28, 2022 at 9:01 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Jim Mattson <jmattson@google.com> writes:
>
> > On Tue, Jun 28, 2022 at 7:04 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
>
> ...
>
> >> Jim Mattson <jmattson@google.com> writes:
> >>
> >> > Just checking that this doesn't introduce any backwards-compatibility
> >> > issues. That is, all features that were reported as being available in
> >> > the past should still be available moving forward.
> >> >
> >>
> >> All the controls nested_vmx_setup_ctls_msrs() set are in the newly
> >> introduced KVM_REQ_VMX_*/KVM_OPT_VMX_* sets so we should be good here
> >> (unless I screwed up, of course).
> >>
> >> There's going to be some changes though. E.g this series was started by
> >> Anirudh's report when KVM was exposing SECONDARY_EXEC_TSC_SCALING while
> >> running on KVM and using eVMCS which doesn't support the control. This
> >> is a bug and I don't think we need and 'bug compatibility' here.
> >
> > You cannot force VM termination on a kernel upgrade. On live migration
> > from an older kernel, the new kernel must be willing to accept the
> > suspended state of a VM that was running under the older kernel. In
> > particular, the new KVM_SET_MSRS must accept the values of the VMX
> > capability MSRS that userspace obtains from the older KVM_GET_MSRS. I
> > don't know if this is what you are referring to as "bug
> > compatibility," but if it is, then we absolutely do need it.
> >
>
> Oh, right you are, we do seem to have a problem. Even for eVMCS case,
> the fact that we expose a feature which can't be used in VMX control
> MSRs doesn't mean that the VM is broken. In particular, the VM may not
> be using VMX features at all. Same goes to PERF_GLOBAL_CTRL errata.
>
> vmx_restore_control_msr() currenly does strict checking of the supplied
> data against what was initially set by nested_vmx_setup_ctls_msrs(),
> this basically means we cannot drop feature bits, just add them. Out of
> top of my head I don't see a solution other than relaxing the check by
> introducing a "revoke list"... Another questions is whether we want
> guest visible MSR value to remain like it was before migration or we can
> be brave and clear 'broken' feature bits there (the features are
> 'broken' so they couldn't be in use, right?). I'm not sure.

Read-only MSRs cannot be changed after their values may have been
observed by the guest.

> Anirudh, the same concern applies to your 'intermediate' patch too.
>
> Smart ideas on what can be done are more than welcome)

You could define a bunch of "quirks," and userspace could use
KVM_CAP_DISABLE_QUIRKS2 to ask that the broken bits be cleared.
