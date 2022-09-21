Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D7B5BFFED
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIUOdF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIUOdC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 10:33:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807102714
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 07:33:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r23so6118496pgr.6
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TXX2kEYvP+keRhbXIQlLBE8g6in+6NE/OdqG2arPwcQ=;
        b=MVUX+DY8Drl/QkKSc5ik7I/HVpcLaN6bNdGTiLOx29pNGXl3j3QktzEY9wY4J+K/DX
         vuzON9X+2TZ6BJD87LwDBcUkXYSO94kYJJ/5yYxNNVEoL9xiRqrQt/HvsjfbO3SZH+Cn
         FVKo8Kj4pmMREeVAcjzK0xORYjk4JXyfmVhtWKHHsC/j9IzYumj5reHFZWXpmSs++c4m
         84dnkQmUZhz19T1UatvP5QwKjCXF2NZg+oo7nnw1YOej4yN8N0TFX1VyPBcS6pW/076y
         ZwhccIH2Mo2T/MGGyZCphjnrOVSDKl8W8DHykZ8AgZtBVwqQ9LZ/hID3/BvfQegiveYQ
         XlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TXX2kEYvP+keRhbXIQlLBE8g6in+6NE/OdqG2arPwcQ=;
        b=uzhL4c2wp47FK/0ykZF+D1TlyWz0TkZE628SIR8u/MyC48zE1YvaP/rANmcW+OTxxf
         HP89xDb2s+s2SxcRD0/uvLZe/ROwzIUBiDGtPjaLKUmY/5EbcmGyeT2u8itZhJ5QNFIb
         nB5iF454+53n9YB6nL1IYfjczahexin696vnTFjPKL8+M+XgwFW2p/kD+kx1YqLIkeDi
         sBJQVOEYDJKfV+ipu+J5lP9AbfJkuWEdE2oI49YH8NXfWwHmhzp7P4LpwKLtun4iZeyX
         9KjFOXYLDxUQCOPwGyRwFZfqpnmW9Xn0yWoOBkefrQCLsHFD5PSsIzMN3g/e+oMK+tgA
         uoQg==
X-Gm-Message-State: ACrzQf3Q4fvy2AjuuauY3CZ/jOf4hUi4ZzTXtrbafx62uKxyhrUHevf9
        ORrlN7RodIQzpETqg0VaQ7vhfQ==
X-Google-Smtp-Source: AMsMyM5bkHpte9sxPJF9TD4rLdpx62EGBicjptAbuNtHBB1FwmoNBbypoRde9PMErtKckon+2kpyIg==
X-Received: by 2002:a63:778d:0:b0:438:5c5b:f2ac with SMTP id s135-20020a63778d000000b004385c5bf2acmr24975144pgc.401.1663770780693;
        Wed, 21 Sep 2022 07:33:00 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e2-20020a63f542000000b0043a09d5c32bsm1908021pgk.74.2022.09.21.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:33:00 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:32:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] KVM: x86: Hyper-V invariant TSC control
Message-ID: <Yyset3mEVytKdWd8@google.com>
References: <20220916135205.3185973-1-vkuznets@redhat.com>
 <20220916135205.3185973-4-vkuznets@redhat.com>
 <YypGs6BOX7Wvtl/H@google.com>
 <87zgetnnf9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgetnnf9.fsf@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > It's still not obvious to me why KVM shouldn't do:
> >
> > 	if (!hv_vcpu)
> > 		return false;
> >
> > 	return !(hv_vcpu->cpuid_cache.features_eax & HV_ACCESS_TSC_INVARIANT) ||
> > 	       !(to_kvm_hv(vcpu->kvm)->hv_invtsc_control & HV_INVARIANT_TSC_EXPOSED);
> >
> > I.e. why is invariant TSC _not_ suppressed on Hyper-V by default?
> 
> In case we switch to suppressing invtsc (CPUID.80000007H:EDX[8]) by
> default, i.e. when HV_ACCESS_TSC_INVARIANT was not set in guest visible
> CPUIDs, this is going to be a behavioral change for the already existing
> configurations and we certainly don't want that. It was expirementally
> proven that at least some Windows versions are perfectly happy when they
> see invtsc without this PV feature so I don't see a need to break the
> status quo.
> 
> this is VMM's job, not KVM's. 

Gotcha.  Can you add a comment to capture this?  In particular, the part about it
being KVM's responsibility iff the Hyper-V control is exposed to the guest.

Hmm, and I think it makes to repackage the code so that the "is KVM responsible"
check is separated from the "is the control enabled".  E.g.

	/*
	 * If Hyper-V's invariant TSC control is exposed to the guest, KVM is
	 * responsible for suppressing the invariant TSC CPUID flag if the
	 * Hyper-V control is not enabled.
	 */
	if (!hv_vcpu ||
	    !(hv_vcpu->cpuid_cache.features_eax & HV_ACCESS_TSC_INVARIANT))
		return false;

	return !(to_kvm_hv(vcpu->kvm)->hv_invtsc_control & HV_INVARIANT_TSC_EXPOSED);
