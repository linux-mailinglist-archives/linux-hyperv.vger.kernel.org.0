Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3535B822B
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Sep 2022 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiINHsW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Sep 2022 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiINHsV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Sep 2022 03:48:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D2D58B4C
        for <linux-hyperv@vger.kernel.org>; Wed, 14 Sep 2022 00:48:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c24so13577657pgg.11
        for <linux-hyperv@vger.kernel.org>; Wed, 14 Sep 2022 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PYUF15A2n8Nl51K6H0o31TZgHBWYV9gZXvwxhXPU17k=;
        b=rx1o4Ie9zs2gVlJ+ZwgSw5LGCsSdFn0Gvg+IuDIVon/ITHzsjR+g3zQRC0njYmZzuF
         6fq87GESLL9c735oU/GKgLpExaFGE/QYVGZ3SasDt6heo3lG/5+aZMINDYnPIwSWbkAm
         hTsLAnoVNbXXk1vB4qz63Bw5c1eOcGHXJ0SAMNpENa2+5a4QrNpwtmoHjmhxz03XJxsG
         cbV7tppO882McKkmEjTt5EUiVOppb71fqBCoI/yxwJXUNyQdkJYaCeVqCemPMGePYKRn
         NGjtrdxS9BttGyqt+JZr6OJIoLQY/gwJXM2KtlkMUqOFYDqELmYsrcvTAQWotycykmZC
         /dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PYUF15A2n8Nl51K6H0o31TZgHBWYV9gZXvwxhXPU17k=;
        b=OmU/NUTig4CHnuVbzKpaqqQ0EFIxy5qeQy2VKHHLQwhktXRBX+qm9m3J1H4f504H27
         KJM82nj0ub5tlJ+JO3ILd+2AFtqLccNUYi/LlTvRx1mkJ0ONycKa0Ik9jV9fJZSu6bng
         bTDsrrRml5OX0CuXQc1GdPzEuLfttbTDm5GlfTY9XOgLl5snDUx9q/Eifrp3T5jr55x/
         QZgGK6BxCwWbNOIdLNAyPXUjDwwKW6whDvFyoes9/SAjiaVoljiyLp1PnzFjbu85XCH0
         g7agKEE4oAJooMMcn/7tb0N/3WKO2irV5gq3jMNIuSitprWf7n9v2MquX0fuLXMHI0T2
         x8Hw==
X-Gm-Message-State: ACgBeo0e81EXttJsIvnFNqfn3HHLk6xLFaZikY/78JFZE++08AAm4OtA
        LoWZkze2dhsPY3IOWtHo0Du89A==
X-Google-Smtp-Source: AA6agR61HVJGD3BsvcS57KDTn8lbXgq7Jfd38TBYv8TGFp/6BZ6OuhdPqFKeJvc87co8vz6E9yMClg==
X-Received: by 2002:a63:4243:0:b0:439:2031:be87 with SMTP id p64-20020a634243000000b004392031be87mr9602601pga.592.1663141699731;
        Wed, 14 Sep 2022 00:48:19 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b00176c37f513dsm10014461plg.130.2022.09.14.00.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:48:19 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:48:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: x86: Hyper-V invariant TSC control
Message-ID: <YyGHP1K9cRvQ9COE@google.com>
References: <20220831085009.1627523-1-vkuznets@redhat.com>
 <20220831085009.1627523-2-vkuznets@redhat.com>
 <Yx85fuFWR/X097SL@google.com>
 <877d27r48z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d27r48z.fsf@redhat.com>
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

On Tue, Sep 13, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Aug 31, 2022, Vitaly Kuznetsov wrote:
> >>  
> >> +/*
> >> + * With HV_ACCESS_TSC_INVARIANT feature, invariant TSC (CPUID.80000007H:EDX[8])
> >> + * is only observed after HV_X64_MSR_TSC_INVARIANT_CONTROL was written to.
> >> + */
> >> +static inline bool kvm_hv_invtsc_filtered(struct kvm_vcpu *vcpu)
> >
> > Can this be more strongly worded, e.g. maybe kvm_hv_is_invtsc_disabled()?  "Filtered"
> > doesn't strictly mean disabled and makes it sound like there's something else that
> > needs to act on the "filtering"
> >
> 
> "Hidden"? :-) I'm OK with kvm_hv_is_invtsc_disabled() too.

Hidden works for me.  Or suppressed, inihbited, whatever.  Just not filtered :-)
