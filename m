Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C756ADA9
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 23:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiGGVcj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 17:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiGGVci (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 17:32:38 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646432EF4
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 14:32:36 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id t128-20020a4a5486000000b004287b14f5c6so2520872ooa.1
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2SOYnoMdx8IBvrKnymTBSvcOZ/zbN6d4SkV8cqAn1A=;
        b=AgJgdrchkINgAqJ5cUSpp2w3dE9d5buWYCk1EA95XAOB4LlsuZCYvaEYLdSxf0BwZz
         /fVuGNye+0hpTvhVidCOmJYs/EUeeE7s0DUvPcgzyPisUNnMG3IVIPAFW24LiAvk5iIC
         x82LbBwvo6xxdcDldjKYPFemNgn8bZbG0ZarJrXucisGdTpD50A+HdKsiFfDGAP4gVwW
         wTp/wYGVy1tFgcxgitSin9UUl1Uh1Wz4lxSQfMFEAaQQb0NnV0FpDcItk+bbuh1Qzuey
         5+mWwh384fZobG8PsIjShS24XRO+s/331QvWBLQLln1CzuIKDFGWp4MRo5JjLH8+bZ1J
         sgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2SOYnoMdx8IBvrKnymTBSvcOZ/zbN6d4SkV8cqAn1A=;
        b=p0Zg02/NGs7Kg9HEXJXEDOLEaa4/N6yA7CNB00iPvci5+kn6EfDp5xKdD68YVl7wcK
         E4Qy45NJjv7YyZBNUWFONwYv7e2QSFbsHyufr0P3pOG1DgfT4APlA00fHUIdaD1lOXrt
         WrLrYo7JlKvAgGOpQ2jcYKgDD2TmO4UEhpATOXMXkhJ6SyTzzvisXHWplJU+clqOLg59
         xvZFmWjmX6ut/KVEjVcCJIj0MyN0qBqpJ35qpAKvIOz0Od+uIlNJglV64hN3xjs4dBYH
         usi5grkikPOZp+Bz6vHHaz+R59DXXtAOvMYLdCR5hU8XRRWRKsLpviiJt7GlWbZxqJl9
         1Zhw==
X-Gm-Message-State: AJIora/LzeE4mPmqtnFfL3txNYKBc+GCbHdWPBZOdgxo1RBkkWU8++w0
        sKOHt7FJa0PyvkKyLkta0YYomsFQ31rJi1qH3V+6tQ==
X-Google-Smtp-Source: AGRyM1uVHy+Y+mLBNj09lNqkFCm0pKmCiqbLXqn3UmHXZ3+2xDxcMe6fLlu8ugezy+h8U5wPcp4JxEOMxcDAhPjYp1E=
X-Received: by 2002:a4a:b306:0:b0:425:8afc:a3d8 with SMTP id
 m6-20020a4ab306000000b004258afca3d8mr75934ooo.47.1657229555846; Thu, 07 Jul
 2022 14:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-23-vkuznets@redhat.com>
 <CALMp9eRA0v6BK6KG81ZE_iLKF6VNXxemN=E4gAE4AM-V4gkdHQ@mail.gmail.com>
 <87wncpotqv.fsf@redhat.com> <Ysc0TZaKxweEaelb@google.com>
In-Reply-To: <Ysc0TZaKxweEaelb@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 7 Jul 2022 14:32:25 -0700
Message-ID: <CALMp9eTrtFd-pcEeWvyAs7eYe1R1FPvGr0pjQNP8o8F0YHhg8A@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 7, 2022 at 12:30 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Jul 07, 2022, Vitaly Kuznetsov wrote:
> > Jim Mattson <jmattson@google.com> writes:
> >
> > > On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > >>
> > >> From: Sean Christopherson <seanjc@google.com>
> > >>
> > >> Clear the CR3 and INVLPG interception controls at runtime based on
> > >> whether or not EPT is being _used_, as opposed to clearing the bits at
> > >> setup if EPT is _supported_ in hardware, and then restoring them when EPT
> > >> is not used.  Not mucking with the base config will allow using the base
> > >> config as the starting point for emulating the VMX capability MSRs.
> > >>
> > >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> > >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Nit: These controls aren't "obsoleted" by EPT; they're just no longer
> > > required.
>
> Isn't that the definition of "obsolete"?  They're "no longer in use" when KVM
> enables EPT.

There are still reasons to use them aside from shadow page table
maintenance. For example, malware analysis may be interested in
intercepting CR3 changes to track process context (and to
enable/disable costly monitoring). EPT doesn't render these events
"obsolete," because you can't intercept these events using EPT.

> > I'm going to update the subject line to "KVM: VMX: Clear controls
> > unneded with EPT at runtime, not setup" retaining your authorship in v3
>
> That's fine, though s/unneded/unneeded.
