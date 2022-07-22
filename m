Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6254757D739
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiGUXG0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 19:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiGUXGL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 19:06:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC493688
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 16:06:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so2993241pgs.3
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87wZkeERCeXfVURi93ftUkOINKaeWlxijauUdSoY5xA=;
        b=fM7VSUuZ5Z2PC40pfTNXIOFR0ofADrIZupwXOuFZhywxnAMqmaPx48sy1+hMoc5Wqt
         FAi4s5QxJF54Lg7m2esjHEMCFKCKudPDf7tsK1/UFKyR1mbSV95qW1fRUO01lcIWbrjz
         XuuAZ1C6oDRlmtqgPKzeuwGkgYx0H15gFKsyurzqg51IJhkNQeQCrY+X/hGLsAPlOaD2
         ujIg5nluWzJ6c8kIFeOelQfVI1BU2WEexH/pIPL3SZOndpDyb8PnGoXviwhiVCIQDPfy
         jsNB13dFGzEjbviib46KqFfA3AMa40SYAZVCezff3OmUJSxGx7sVVmKLeOfTAExUucVJ
         0Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87wZkeERCeXfVURi93ftUkOINKaeWlxijauUdSoY5xA=;
        b=ay0mpepzpdBuCPgrwKlO7/GE2/C+4cV9CdzkqY0FJ3hA81dCwKLJkDCWdW+0CYaMRG
         zwVqpR87dWmE55Bz9JFGwvtBDv8RREkvp0UHxog8uclbt1A0QWFPxzu0mAkuqq1UioZV
         TaxXIL4phZ0zQm62avt4RTHzisS5DRLRT5aORoTgKzOfdifBHfoa1aj3+VaypdBlL7No
         1Dl/TDdaKRciRgXptje2GnZw8R5o4gSFhT0vgFPfM31ApaTftuTiuCpmtdMimuDkOJYP
         1nGI/HmvckSceCzcqUdopwVTkbHCNbzPGEnvInatqeqM2W7VKJwySYQGZRogDyDK0bQz
         SBwA==
X-Gm-Message-State: AJIora9T/PgMBVbdvB0ZtHPs6tdzN89I1GZ2w1hSqiJS9rYm+bPD/R16
        XrgJiRKNiImuiPpqOgAJjjCUag==
X-Google-Smtp-Source: AGRyM1tcNPwrEFwaYRNv6k4BCQmt+bqE5SrACmuSFUKgq3xmhBDBrnyyEmcV4r/DfgnNtdc+SgWcJA==
X-Received: by 2002:a05:6a00:2484:b0:52b:2be0:2191 with SMTP id c4-20020a056a00248400b0052b2be02191mr489868pfv.51.1658444765755;
        Thu, 21 Jul 2022 16:06:05 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id c6-20020a62f846000000b0052ac99c2c1csm2324716pfm.83.2022.07.21.16.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 16:06:05 -0700 (PDT)
Date:   Thu, 21 Jul 2022 23:06:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/25] KVM: VMX: Cache MSR_IA32_VMX_MISC in vmcs_config
Message-ID: <Ytnb2Zc0ANQM+twN@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-25-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091327.1085353-25-vkuznets@redhat.com>
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

On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> @@ -2613,6 +2614,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  	if (((vmx_msr_high >> 18) & 15) != 6)
>  		return -EIO;
>  
> +	rdmsrl(MSR_IA32_VMX_MISC, misc_msr);

Might make sense to sanitize fields that KVM doesn't use and that are not exposed
to L1.  Not sure it's worthwhile though as many of the bits fall into a grey area,
e.g. all the SMM stuff isn't technically used by KVM, but that's largely because
much of it just isn't relevant to virtualization.

I'm totally ok leaving it as-is, though maybe name it "unsanitized_misc" or so
to make that obvious?

>  	vmcs_conf->size = vmx_msr_high & 0x1fff;
>  	vmcs_conf->basic_cap = vmx_msr_high & ~0x1fff;
>  
> @@ -2624,6 +2627,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  	vmcs_conf->cpu_based_3rd_exec_ctrl = _cpu_based_3rd_exec_control;
>  	vmcs_conf->vmexit_ctrl         = _vmexit_control;
>  	vmcs_conf->vmentry_ctrl        = _vmentry_control;
> +	vmcs_conf->misc	= misc_msr;
>  
>  	return 0;
>  }
> @@ -8241,11 +8245,9 @@ static __init int hardware_setup(void)
>  
>  	if (enable_preemption_timer) {
>  		u64 use_timer_freq = 5000ULL * 1000 * 1000;
> -		u64 vmx_msr;
>  
> -		rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
>  		cpu_preemption_timer_multi =
> -			vmx_msr & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
> +			vmcs_config.misc & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
>  
>  		if (tsc_khz)
>  			use_timer_freq = (u64)tsc_khz * 1000;
> -- 
> 2.35.3
> 
