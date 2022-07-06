Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96581569557
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 00:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiGFWaM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiGFWaL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 18:30:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EAF15A06
        for <linux-hyperv@vger.kernel.org>; Wed,  6 Jul 2022 15:30:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a15so15652119pfv.13
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Jul 2022 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKA8akOzbkf4tNDc6jfn4CUsITOKN9yZnmEgDBs/SyQ=;
        b=q6a3Irt0falLmlOdgWGFnxHk8Agc+WjZBDzCqkjggQvyzWvyJRYgbbruahzFU3UMAO
         rijRQsr2J25PLeGwnp+Nykv+fu5KZ8KAIRn2Q00ZTduG2VN33D6+E27CZ57cDZdylV07
         NGSStd34KnxDkaHKTrMxnFoF4CUspgWJjmiE4D/WBVxvDyAjl2H1FZ6p2AbC8JZY1oYF
         erHmqIE7H/fr1T38eniUYrxC2g1AMIk390+P4dpRtGWvxFy6wzItDj0zY+M4iJdkYYRY
         ypV3OPyDukfxEG109qbDOAESZ4G9jHLj7AoAPelNTdiXLGhTOATvm5xkVn0zI6l2OrF3
         uABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKA8akOzbkf4tNDc6jfn4CUsITOKN9yZnmEgDBs/SyQ=;
        b=crWhsUDNdIxaSbmkl+Smh1A88VUZ7n/oluhyEuY+GKcd4Kk/Djk4BJGtftWNP3rAte
         51o5cxGqW4gnhzi+FQnMLF8wGElOCY3CEy//7ln3Mq6K7wLTrfIef9Acz7h75elae5cf
         osxdRNnn2avhZi8bUX+iAHkOPShuFVr7knS1TJHPR4daYBarWmnUVN6ICbXd36Wg7SRv
         N9apfsYoxcNxPTpali6zdkwnxQDl09KmV+H+cMjZkCyLbWNYXmW3PhwRVAeTVxlhE7v+
         4DyRbZ62C5dwGa0L3TeVt3NG3HU7iMK+cwtU5rAbJs0fYTA3CAOb+6dN9Lr/XKsf8oMi
         9jJQ==
X-Gm-Message-State: AJIora9UUN6QYuUDtHeAXi+PfM4PN27DZg9lOHOS2pZFDTfZ+c7FRVfN
        MIr3qhC/FjLibtewho3tWlzZDA==
X-Google-Smtp-Source: AGRyM1sLT1U7pR8GVCabA1hqq2+btL+DQYe73v4JeLKC365avmWaP7/FZnlh9V7Qy3kZGK00OgD8og==
X-Received: by 2002:a17:902:dad1:b0:16a:75cb:5d97 with SMTP id q17-20020a170902dad100b0016a75cb5d97mr49535733plx.64.1657146610443;
        Wed, 06 Jul 2022 15:30:10 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902968b00b0016a11b9aeb3sm26092000plp.224.2022.07.06.15.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:30:09 -0700 (PDT)
Date:   Wed, 6 Jul 2022 22:30:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] KVM: nVMX: Use vmcs_config for setting up nested
 VMX MSRs
Message-ID: <YsYM7VbPRQKflZrZ@google.com>
References: <20220627160440.31857-1-vkuznets@redhat.com>
 <CALMp9eQL2a+mStk-cLwVX6NVqwAso2UYxAO7UD=Xi2TSGwUM2A@mail.gmail.com>
 <87y1xgubot.fsf@redhat.com>
 <CALMp9eSBLcvuNDquvSfUnaF3S3f4ZkzqDRSsz-v93ZeX=xnssg@mail.gmail.com>
 <87letgu68x.fsf@redhat.com>
 <CALMp9eQ35g8GpwObYBJRxjuxZAC8P_HNMMaC0v0uZeC+pMeW_Q@mail.gmail.com>
 <87czeru9cp.fsf@redhat.com>
 <CALMp9eQ5Sqv3RP8kipSbpfnvef_Sc1xr1+g53fwr0a=bhzgAhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQ5Sqv3RP8kipSbpfnvef_Sc1xr1+g53fwr0a=bhzgAhg@mail.gmail.com>
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

On Wed, Jun 29, 2022, Jim Mattson wrote:
> On Wed, Jun 29, 2022 at 2:06 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> 
> > For PERF_GLOBAL_CTRL errata:
> > - We can move the filtering to vmx_vmexit_ctrl()/vmx_vmentry_ctrl()
> > preserving the status quo: KVM doesn't use the feature but it is exposed
> > to L1 hypervisor (and L1 hypervisor presumably has the same check and
> > doesn't use the feature. FWIW, the workaround was added in 2011 and the
> > erratas it references appeared in 2010, this means that the affected
> > CPUs are quite old, modern proprietary hypervisors won't likely boot
> > there).
> Sadly, Nehalem and Westmere are well-supported by KVM today, and we
> will probably still continue to support them for at least another
> decade. They both have EPT, unrestricted guest, and other VT-x2
> features that KVM still considers optional.

Nehalem doesn't have unrestricted guest.  Nehalem is the only generation with EPT
but not unrestricted guest.
