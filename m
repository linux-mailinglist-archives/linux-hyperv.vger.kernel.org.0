Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C956AEDD
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 01:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiGGXNB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 19:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiGGXM5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 19:12:57 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D99675A6
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 16:12:56 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10c0052da61so16447963fac.12
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTPiCq6o5QBRMPOp6LpD2/BgeXHlU+wjUZU6A5lOqmI=;
        b=Kv4sBtlHcxjTqD2hQ8a0f+HjkdKVfueMchWfmNrAPSBbJ4NdfSZiCWV3gY6kjp/W2p
         lGt5A6E5qBpHPQ/bNOE5IXjUnuQQZFczt9RxXeUV7D5onvSNY1UWjlBDFtbHM0/Rf8V+
         abZtNfXtI2WXMx50jbKQjhbM628BYGInasWQITioCytDhEDC2RTKWWrfL198mOvkFSnO
         ZCcoMh3ZNyQoE49UC+mW+5w5v/swVZY9HCQbFuerUhaV1BhJr5kvWiiJv9ZTrO4RIXSO
         yyYhyUIOFULCq7hELMcAxda2Xr2UIieVxY8DExB4EK3VZdlaN5GI4b4Ks6XeYimwYO0V
         RTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTPiCq6o5QBRMPOp6LpD2/BgeXHlU+wjUZU6A5lOqmI=;
        b=8NgK0WTQu4C++WPSKxha0z8gtw9/B1mr9bg6Bjk8n7ba1EBefLas3U09B3sdsn7y5R
         DjK/IkG8dYZkt04+dGV6h6g0F44iHnGb5et9+/QH3cmLN4yijVi3zOhaKmavP4W18qkk
         JgzeDuaMGEZA0a3hFJWyavPrkvl/qmQaGKX1UMXSWoNsOIInhxTaXX3uMnwtCfBcOhyK
         X+Gf0JvEoXpA6b+gYU3kcyV93JeHyL3bCiIzsAiJBPZCu1xIeB/p91OZ/BkdoEWdrvXf
         6vvq6lRhz9xGxGjnUeopQkrtS2dZaSb4n02BCff2jI2Z20qCzHzgpCm5noSokrWW2Hnz
         PwYw==
X-Gm-Message-State: AJIora+V/O3GlCMOTnQsTnCHuFwiHWsVGqsDfBdOA4oHVqXKBQRjurvZ
        H89cWEU1T2hKrf4YtQcGxLypHpuKA1VAv8I08jTz6w==
X-Google-Smtp-Source: AGRyM1vXg3o7dInLHiP/tPHXi9ddVDLyNUgXK++7oeJvRgJ6rSyuJ9DQ3K4nevvDXVKMVECR6Yp0LWT9N80ZGyx2Ndc=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr4456421oab.112.1657235575730; Thu, 07
 Jul 2022 16:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-23-vkuznets@redhat.com>
 <CALMp9eRA0v6BK6KG81ZE_iLKF6VNXxemN=E4gAE4AM-V4gkdHQ@mail.gmail.com>
 <87wncpotqv.fsf@redhat.com> <Ysc0TZaKxweEaelb@google.com> <CALMp9eTrtFd-pcEeWvyAs7eYe1R1FPvGr0pjQNP8o8F0YHhg8A@mail.gmail.com>
 <YsdSfP7xmMcLv8i9@google.com>
In-Reply-To: <YsdSfP7xmMcLv8i9@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 7 Jul 2022 16:12:44 -0700
Message-ID: <CALMp9eTjVksjTkOQ-=HNKB2oyuCcDw3mC=E+P8XAXafy2MmrPA@mail.gmail.com>
Subject: Re: [PATCH v2 22/28] KVM: VMX: Clear controls obsoleted by EPT at
 runtime, not setup
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 7, 2022 at 2:39 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Jul 07, 2022, Jim Mattson wrote:
> > On Thu, Jul 7, 2022 at 12:30 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Thu, Jul 07, 2022, Vitaly Kuznetsov wrote:
> > > > Jim Mattson <jmattson@google.com> writes:
> > > >
> > > > > On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > > > >>
> > > > >> From: Sean Christopherson <seanjc@google.com>
> > > > >>
> > > > >> Clear the CR3 and INVLPG interception controls at runtime based on
> > > > >> whether or not EPT is being _used_, as opposed to clearing the bits at
> > > > >> setup if EPT is _supported_ in hardware, and then restoring them when EPT
> > > > >> is not used.  Not mucking with the base config will allow using the base
> > > > >> config as the starting point for emulating the VMX capability MSRs.
> > > > >>
> > > > >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > > > Nit: These controls aren't "obsoleted" by EPT; they're just no longer
> > > > > required.
>
> Actually, they're still required if unrestricted guest isn't supported.
>
> > > Isn't that the definition of "obsolete"?  They're "no longer in use" when KVM
> > > enables EPT.
> >
> > There are still reasons to use them aside from shadow page table
> > maintenance. For example, malware analysis may be interested in
> > intercepting CR3 changes to track process context (and to
> > enable/disable costly monitoring). EPT doesn't render these events
> > "obsolete," because you can't intercept these events using EPT.
>
> Fair enough, I was using "EPT" in the "KVM is using EPT" sense.  But even that's
> wrong as KVM intercepts CR3 accesses when EPT is enabled, but unrestricted guest
> is disabled and the guest disables paging.

MOV-to-CR3 is also a required intercept for allow_smaller_maxphyaddr,
when the guest is in PAE mode. So, that one, at least, isn't anywhere
near obsolete. :-)

> Vitaly, since the CR3 fields are still technically "needed", maybe just be
> explicit?
>
>   KVM: VMX: Adjust CR3/INVPLG interception for EPT=y at runtime, not setup
