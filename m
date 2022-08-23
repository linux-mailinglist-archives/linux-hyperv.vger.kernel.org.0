Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7252959EA06
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Aug 2022 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiHWRny (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Aug 2022 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiHWRmx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Aug 2022 13:42:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C2E4E625
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Aug 2022 08:31:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jl18so13148767plb.1
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Aug 2022 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=rPJEhUskbEuhZn5UA0VRxGqCt2ycgFbaFmo1YwbQDCs=;
        b=DOyuZ2DfDHo6PdftwMOSLANQo+RXcgn8aKot/yQS4w0BpH/12ThLtf/aUdXHWx2ykL
         Oee+34wOXm90is6sA3C1KZgU8QGqujMVxtqyexAurhJ43I5qY0TTSQ2PUyRfCkbRlI3t
         lrD83eW8bdfgcBoYlYp1J5U3lzxlwJ+Tx0eJp0+QQaUEMqm5NPKz33TPNaFd5FoYqqmS
         6BG2yWKzNDCVpb09Ny2BVvbukaEnA+gjzKQWPUJm16wKJIIRFP2v6ztboSDTGLoK6gWw
         weVusjX6vrC7oND5KRgWOxPjiE62/5/8eJULKkKNr86FTehQz7c54cM5SwQ6uxWOrKZ8
         +dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rPJEhUskbEuhZn5UA0VRxGqCt2ycgFbaFmo1YwbQDCs=;
        b=bQBttUr76fUdlumq0Wjzqbtj12QEdrI9eX5H1UtyuzzViHy1cbBgYQLbY0JzFJxzL5
         mNgRDPVfsQVD7C2vXvDYYBZ6HqYDE7i8CDqYxPe+hvcuJm4r+EpJ9QeTReSRNYZmRzv7
         NkjcZvuKF+a8trc+ueyL2L3wexGniwZZb9X9M6zpoyJIajIcayKlo3k3M1m2p6OTAdkp
         lFPqfOzMEGahUBJghv9Wrf77+cs5aGqFTqzxFTy5t2jWVUx9GBzW6QaIk20grX1xmuxS
         vOWUBUfOkQmzTYnXOifl7K9txKNntwyH+2HRe92z1T2mTmlN+VoWQfJfNCYpWESVNpvZ
         QyXw==
X-Gm-Message-State: ACgBeo1OthGNGnI5RthePD43nse4MNBqdN1lJQGssopZQCT2ZyX93FUL
        xOBRBbdd5qCWVjEgNXi/0qLWRQ==
X-Google-Smtp-Source: AA6agR4teugBk55hCVUg1jS+OSM50LM+YswrnzcEa3qGxXrae3Vo99tlJTyAYNu2PU1z50tnAONynQ==
X-Received: by 2002:a17:90b:4c08:b0:1fb:66d3:79c with SMTP id na8-20020a17090b4c0800b001fb66d3079cmr2934289pjb.121.1661268690966;
        Tue, 23 Aug 2022 08:31:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b0016892555955sm10738749plr.179.2022.08.23.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:31:30 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:31:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/26] x86/hyperv: Update 'struct hv_enlightened_vmcs'
 definition
Message-ID: <YwTyzk2TiC226n33@google.com>
References: <875yiptvsc.fsf@redhat.com>
 <Yv59dZwP6rNUtsrn@google.com>
 <87czcsskkj.fsf@redhat.com>
 <YwOm7Ph54vIYAllm@google.com>
 <87edx8xn8h.fsf@redhat.com>
 <YwO2fSCGXnE/9mc2@google.com>
 <878rngxjb7.fsf@redhat.com>
 <YwPLt2e7CuqMzjt1@google.com>
 <87wnazwh1r.fsf@redhat.com>
 <YwTrlgeqoAqyH0KF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwTrlgeqoAqyH0KF@google.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 23, 2022, Sean Christopherson wrote:
> On Tue, Aug 23, 2022, Vitaly Kuznetsov wrote:
> > >> In any case, what we need, is an option for VMM (read: QEMU) to create
> > >> the configuration with 'TscScaling' filtered out even KVM supports the
> > >> bit in eVMCS. This way the guest will be able to migrate backwards to an
> > >> older KVM which doesn't support it, i.e.
> > >> 
> > >> '-cpu CascadeLake-Sever,hv-evmcs'
> > >>  creates the 'origin' eVMCS configuration, no TscScaling
> > >> 
> > >> '-cpu CascadeLake-Sever,hv-evmcs,hv-evmcs-2022' creates the updated one.
> 
> Ah, I see what you're worried about.  Your concern is that QEMU will add a VMX
> feature to a predefined CPU model, but only later gain eVMCS support, and so
> "CascadeLake-Server,hv-evmcs" will do different things depending on the KVM
> version.
> 
> But again, that's already reality.  Run "-cpu CascadeLake-Server" against a KVM
> from before commits:
> 
>   28c1c9fabf48 ("KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES")
>   1eaafe91a0df ("kvm: x86: IA32_ARCH_CAPABILITIES is always supported")
> 
> and it will fail.  There are undoubtedly many other features that are similarly
> affected, just go back far enough in KVM time.

The one potential issue I see is that KVM currently silently hides TSC_SCALING
and PERF_GLOBAL_CTRL, i.e. migrating from new KVM to old KVM may "succeed" and
then later fail a nested VM-Entry.

PERF_GLOBAL_CTRL is solved because Microsoft has conveniently provided a CPUID
bit.

TSC_SCALING is unlikely to be a problem since it's so new, but if we're worried
about someone doing e.g. "-cpu CascadeLake-Server,hv-evmcs,+vmx-tsc-scaling", then
we can add a KVM quirk to silently hide TSC_SCALING from the guest when eVMCS is
enabled.
