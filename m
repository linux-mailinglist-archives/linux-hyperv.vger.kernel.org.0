Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF156ABDB
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiGGTa3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiGGTa1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 15:30:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D252612C
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 12:30:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e132so20277332pgc.5
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7X+8JGW1uNiGyJFuWhjxVYDvmw+5zjyFaO0LL98jJNs=;
        b=f3jXwLVz2z3coCJPhg3sCWYTft0tpmBGhJfNSzx9uubtpEK5/zCnpoceqqn+2baexp
         UOG/qaD/IdGjB5RFbgMAsXUmDxM5p50x32BaxHkCasLSuA6G90ibOyNyL20B4lP7y2mn
         VtJNn2LWPhW+SHv+sp0CQVNP6PVZatmtJ8urY/tzTCb3Tj7KJt+zUPY/G64BKNgDG6ef
         1T0QitOGrMhzoC4XOhuaJhrH6cA0qAi/BOcr2hvXzngEWFzYbPqaojK6z9G3ZA+5pF68
         OOmPZ3YSKwU4uEPAC0ePkXef1HBj5UMyDcy07XWQB3+LPDRqQS2WompLZYaIu6H7T456
         wNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7X+8JGW1uNiGyJFuWhjxVYDvmw+5zjyFaO0LL98jJNs=;
        b=uJwzVUWx5dxqZBgONyc0ai2knwsBmbbh+qYp64UhBQCNL3cabVXdvV7oG2y/3C6zTN
         zLcD0SBgcZ16RKMmMvib34HUZoB4zst7uECIX1Ah02qXSSjJSCmGZJEmteL2kpEa6DGx
         rjbWuLeMvFdEajXIwUM6rqeyiHGu+mBQ2JTNwvLxUdgYGR5f/I+KMJIGYxD+jgxrIXdV
         KY5qIYgK+J8kqIRIghYra3Y6XIPQWXfnoTKbmYhlF+gLS4UtP57Po+p823HEzO1MCFYU
         E9gpI5/DqAtlxVPz4Vx1mqJBjkARdo/F4dQ34EoEjiigG0sptYXoDHKUXe2DiVNprxPz
         qD2g==
X-Gm-Message-State: AJIora/hh+S6hK9OwvcCKGsPhGXdr1d6sT3By9n4c2yFb5KYPnFpMdVl
        oi8NBZWE3CoD+QIQQ/lD59AXiQ==
X-Google-Smtp-Source: AGRyM1ugIK1dp8lBkhHZvJzvmmKPHEtOABiIXVxNedJp6c66Y2uykzFwihBhwKUnh8y/mnoaPSqUUQ==
X-Received: by 2002:a17:903:20f:b0:16b:d01c:d689 with SMTP id r15-20020a170903020f00b0016bd01cd689mr32034998plh.92.1657222225556;
        Thu, 07 Jul 2022 12:30:25 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id x124-20020a626382000000b00525231e15ccsm27409785pfb.113.2022.07.07.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:30:25 -0700 (PDT)
Date:   Thu, 7 Jul 2022 19:30:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/28] KVM: VMX: Clear controls obsoleted by EPT at
 runtime, not setup
Message-ID: <Ysc0TZaKxweEaelb@google.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-23-vkuznets@redhat.com>
 <CALMp9eRA0v6BK6KG81ZE_iLKF6VNXxemN=E4gAE4AM-V4gkdHQ@mail.gmail.com>
 <87wncpotqv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wncpotqv.fsf@redhat.com>
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

On Thu, Jul 07, 2022, Vitaly Kuznetsov wrote:
> Jim Mattson <jmattson@google.com> writes:
> 
> > On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> From: Sean Christopherson <seanjc@google.com>
> >>
> >> Clear the CR3 and INVLPG interception controls at runtime based on
> >> whether or not EPT is being _used_, as opposed to clearing the bits at
> >> setup if EPT is _supported_ in hardware, and then restoring them when EPT
> >> is not used.  Not mucking with the base config will allow using the base
> >> config as the starting point for emulating the VMX capability MSRs.
> >>
> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Nit: These controls aren't "obsoleted" by EPT; they're just no longer
> > required.

Isn't that the definition of "obsolete"?  They're "no longer in use" when KVM
enables EPT.

> I'm going to update the subject line to "KVM: VMX: Clear controls
> unneded with EPT at runtime, not setup" retaining your authorship in v3

That's fine, though s/unneded/unneeded.
