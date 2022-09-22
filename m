Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EF05E6A02
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 19:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIVR4C (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIVR4B (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 13:56:01 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F539EBBFA
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 10:56:00 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11eab59db71so14926773fac.11
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t9sywruqcuKyY9MOVDQxFF5A99e42M9asDqWWcnjP1g=;
        b=f8iOwOZDaGvsk1kJiLcpnxW5pf3fBnQTVD4woOnEBJl8xrz9zaeBzsYIIXyAyd16SS
         Gpr1A/Ix7iTMV3G0SuFqbxyIN6X3AbRMV8WZ8TPSNcEvHOx6vqLgITW6IRFsaglvo4LR
         y6XNHmxAqOnQZWFs/nr0MC3Xo8xfGqRQQIdG1GwKZPLX7HqHuarB21OBhZQL+5v4/9Z8
         hRXy4HFv6pSrQWpcrBHlx5yFCmEW3n75JLHwCkW1twjNgvmutCpYituv1dpM9FFQlsMZ
         wbDvvT6OcIxkZBd3EkwdDiMmolcKMmtSGp83g0J/nNba7d8eGkFXOooP5OZC5KdwOywo
         cRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t9sywruqcuKyY9MOVDQxFF5A99e42M9asDqWWcnjP1g=;
        b=Nhqmbvw0JsuIZMi+Qd//hCoJ1d34NoCIiuo9dpKoBkOopkIjbB+PYwRz2L2jeAY2CG
         LRe6fChOqi/aLWTHoc6D1lFQ4RoSpw1rtzAFhgOKEQybAkfCeC/hgnsg/k4yDvQh3HR6
         cBDAS9FMqk724Qiwv/f5vcdenRzsRmRDI50dPYthMQBlTnlj218PhOmle3uE2mdiqhB1
         W0JUVgEHmQIccVc4IhXfmjAnHb6I0djsSqngHiLV6bDGsn9lb6jORATBhp4sxbw96STq
         gCu5z45dKG9WFEJXd0heGhFiOhqZK6xUTwdJVEBx3OUPOdenJqkfcjot8w3KvrX+h5OA
         JdAA==
X-Gm-Message-State: ACrzQf3Xt4GnpucKMZdQ4yVTrivZxkDJ+f6OuXANP4QwVwitdGgEK5c2
        o0c2KzDLmfffLfPYdVutbyhYYbwHOb+HuuYJt8Pl7A==
X-Google-Smtp-Source: AMsMyM4f7HZsorZh9Oc9dnMigbdijdeZCWk/IN1jZJHRpTNiH4MjQiAYgzR8hOZ6mUUDLZ/VbEGM6NB97xPlvZUhZs8=
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id
 r12-20020a056870580c00b0012af136a8f5mr8779885oap.269.1663869359794; Thu, 22
 Sep 2022 10:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220922143655.3721218-1-vkuznets@redhat.com> <20220922143655.3721218-3-vkuznets@redhat.com>
 <CALMp9eSVQSMKbYKr0n-t3JP58hLGA8ZHJZAX34-E4YWUa+VYHA@mail.gmail.com> <YyyhBTXdj96crwbZ@google.com>
In-Reply-To: <YyyhBTXdj96crwbZ@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 22 Sep 2022 10:55:49 -0700
Message-ID: <CALMp9eSwFYX67OL3rTNR4-nDT1i5cD36B4KcPh-RHM2UmXBMNw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] KVM: x86: Introduce CPUID_8000_0007_EDX
 'scattered' leaf
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 22, 2022 at 10:53 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Sep 22, 2022, Jim Mattson wrote:
> > Why do we need a new 'scattered' leaf? We are only using two bits in
> > the first one, right? And now we're only going to use one bit in the
> > second one?
> >
> > I thought the point of the 'scattered' leaves was to collect a bunch
> > of feature bits from different CPUID leaves in a single feature word.
> >
> > Allocating a new feature word for one or two bits seems extravagant.
>
> Ah, these leafs aren't scattered from KVM's perspective.
>
> The scattered terminology comes from the kernel side, where the KVM-only leafs
> _may_ be used to deal with features that are scattered by the kernel.  But there
> is no requirement that KVM-only leafs _must_ be scattered by the kernel, e.g. we
> can and should use this for leafs that KVM wants to expose to the guest, but are
> completely ignored by the kernel.  Intel's PSFD feature flag is a good example.
>
> A better shortlog would be:
>
>   KVM: x86: Add a KVM-only leaf for CPUID_8000_0007_EDX

Thanks. The 'scattered' terminology seems more confusing than enlightening.
