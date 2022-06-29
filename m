Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E51560931
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jun 2022 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiF2Sd4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jun 2022 14:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiF2Sdz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jun 2022 14:33:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9D52CC9E
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Jun 2022 11:33:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id be10so22799699oib.7
        for <linux-hyperv@vger.kernel.org>; Wed, 29 Jun 2022 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBpBPb1JfgBVQOcK+q3lL0dbcx1PPlhvFD2bZ/S2vPM=;
        b=cu3axz7wBc7nVAreYd1L+Pb1byOJ4uMLiVp94gUpynZw+v9m5YCZkr5s69wFhzhl+a
         jhOmBimVo5SaABiaB9knVqdVsIsCE7z0OYVKR6GgEJXsbdjaOpjn3Odi2cabtINH4DSY
         b82g2o2mPlWGhpxi66h3OcqMGqsHaaF+6spqX647DqGr57AX1tsJ9xfD71x7HlaVwQHS
         oFzHGb+IA3WGZbtNz9ibL9f2jUGoqCfjzac2DyZAKKIYVKMk9nP4pn7vhwYsYrgmU8Sm
         Iq5+TzpmdT0z5Lm/7MQMkqME74GTXatyxIGj9FM2GYMJKDVEV3fLGXL92OvpyxsEFcgr
         G5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBpBPb1JfgBVQOcK+q3lL0dbcx1PPlhvFD2bZ/S2vPM=;
        b=RYH2yTB0E/PdWZmB77vfRhFnPp/CCSGxKWEx9vXbk9at6+vYNokMGlDY2McpLDRWf/
         UBNP2gKsAbbEt4frzFqIYhRNAUjHjeUiuwMpkq8dz+nPPj5BqEiBogouj6ignjU2jbBY
         Qey/ilvCJ+L5RLYUlZ/D3AojS7lALcLbyN0VUR0xkSD5tPuRDZ2VGYlHnZaqaqTWadqs
         NGptDIBvTL6fu5eol3UGiy+fW5dXYJP2YR47hWRv1x+JDtBkO6WlzkvlqNN9YJHnyPNv
         D4TL9kUf9v1Grfu2MdgWpDdfPE2AyhQhdg3GRb3v0w7PmQeD3lnufTiXgNTBJrDBq9Xx
         l8Ng==
X-Gm-Message-State: AJIora9WbKjBglnRbW7fczvydHt8+FwNgzb6DVthyvdgq0km3pXvlRzC
        HHNaa1+lFcEzmT1mMVvpmCT0JRHUQ7Xg1zatK8er0Q==
X-Google-Smtp-Source: AGRyM1seb9ITh5NsU0tHCNYxwXwACqSmvjKgR2tK0f4RLChSSyXyYg7yXv5s1kKqgxyLniM5ahYMgcRakmBf29KW7j4=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr4011416oiw.112.1656527634087; Wed, 29
 Jun 2022 11:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-28-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-28-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jun 2022 11:33:43 -0700
Message-ID: <CALMp9eRvaiz32TiOwEN0HXn3n8r3fkeJCKVmiBVuXrcUagRzXQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] KVM: VMX: Cache MSR_IA32_VMX_MISC in vmcs_config
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

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Like other host VMX control MSRs, MSR_IA32_VMX_MISC can be cached in
> vmcs_config to avoid the need to re-read it later, e.g. from
> cpu_has_vmx_intel_pt() or cpu_has_vmx_shadow_vmcs().
>
> No (real) functional change intended.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
