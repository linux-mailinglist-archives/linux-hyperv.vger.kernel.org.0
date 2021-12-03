Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170944680D7
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Dec 2021 00:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354323AbhLCXtC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Dec 2021 18:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbhLCXtB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Dec 2021 18:49:01 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92A0C061353
        for <linux-hyperv@vger.kernel.org>; Fri,  3 Dec 2021 15:45:36 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so6343598pju.3
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Dec 2021 15:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yD6g0uGUpXofVzj8NK/B5yfkrr/b2pwl08L+HXZNmGc=;
        b=IDYdi2gcCU7orh4FCNZ/3qn99byxzKL2xcCN/fy7149//aVjPNvsiuErNGtJG6jiTk
         +vcFYKfykKTbUQrJ682QgjNeEGcYx8tYLYSM4NDVmq/OJlpjLATES0QTffx7/p1ec8GW
         Kt5/GAxt3xPVZ++X51blLwWo5Yizh8vAQTdkRk4oAVhECQFthHqToe5+J5LzMUyOFB4g
         YtqAuga7Rin6skchpNJLGJ6JZNxHXNlrLHRkGhMeuIXWGJDRFiio15Vexh6+QYSG/x0s
         SH7gh9Sifx2PMnXScCVsPV0bH/y0XTa4a/UEZjvXYNmmCQcOeFQ8H9xkjWhkz4qze/xo
         O6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yD6g0uGUpXofVzj8NK/B5yfkrr/b2pwl08L+HXZNmGc=;
        b=K3XBAO+cFCS05wIAadnahiRjSeLVtAKGKeP8ONSBMwvi3ztDSE+5i7yCLCdL2M/97L
         nMc/iFpXGPUqBiRvfRK5YKRUFizxH/f78TlP64sucyZtClNyyRCfkbMJk7wJBY3Uvxpy
         k8yx9VYdv0IeCn0s/oMQc5dk4kKBL7HFOXd7bFPEzv0lZJQH5nbTQwVb352PaYl+D+wu
         jn1eCkrIxKfHLXsyrh01Ru+N7ojHIpV2BhvvIFW6Qjm9aZ3uxjTWyWYGEnoHFHpAQg60
         E3BCDTesT14ONsRpdkjPY9izCIKDFjMJMaKhRN5uWkXAf9HnroFKZFAtifV4h2Qnvzn8
         dUHg==
X-Gm-Message-State: AOAM533U097Z3sL3aBNplk+FUhj4UfOEKfAzszgR1a9cx7+4whVrthou
        /gsilj2qJJNvlIeMMX7xCO0CAQ==
X-Google-Smtp-Source: ABdhPJwhSBTsZDHrLEJdD1LTuDAAzOLhcJfgIx6HJ3Hrk2ouSqIr1bcL3Rr3j7eKMr5wwS0weuWQ/w==
X-Received: by 2002:a17:902:f24a:b0:141:c6fc:2e18 with SMTP id j10-20020a170902f24a00b00141c6fc2e18mr26414542plc.55.1638575136288;
        Fri, 03 Dec 2021 15:45:36 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b6sm4352949pfm.170.2021.12.03.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:45:35 -0800 (PST)
Date:   Fri, 3 Dec 2021 23:45:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/8] KVM: x86: Refactor kvm_hv_flush_tlb() to reduce
 indentation
Message-ID: <YaqsHPZdXQB/q7aP@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-4-seanjc@google.com>
 <877ddskxfq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ddskxfq.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 01, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Refactor the "extended" path of kvm_hv_flush_tlb() to reduce the nesting
> > depth for the non-fast sparse path, and to make the code more similar to
> > the extended path in kvm_hv_send_ipi().
> >
> > No functional change intended.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/hyperv.c | 40 +++++++++++++++++++++-------------------
> >  1 file changed, 21 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index cf18aa1712bf..e68931ed27f6 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -1814,31 +1814,33 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
> >  		if (hc->var_cnt != bitmap_weight((unsigned long *)&valid_bank_mask, 64))
> >  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> >  
> > -		if (!hc->var_cnt && !all_cpus)
> > +		if (all_cpus)
> > +			goto do_flush;
> 
> You could've probably done:
> 
> 	if (all_cpus) {
> 		kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH_GUEST);
> 		goto ret_success;
> 	}
> 
> to get rid on the second 'all_cpus' check (and maybe even 'do_flush'
> label with some extra work) below.

Yeah, but the !ex path also uses all_cpus, and in general I'd prefer to keep the
two flush requests bundled together.
