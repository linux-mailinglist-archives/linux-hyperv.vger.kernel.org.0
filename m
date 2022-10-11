Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C175FBB3B
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Oct 2022 21:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJKTSg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Oct 2022 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJKTSg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Oct 2022 15:18:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD027B2B1
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Oct 2022 12:18:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r18so13574320pgr.12
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Oct 2022 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tN++RzycQhI0zOp3/Gpp2COjyDOKXNStECTnSP6UROw=;
        b=IyC7A4pZD44WrZ37I0tOZ64uJmBOj3T0Y6/d8vwNtfoAks/qFvpZ3aqeTRcz0CIYUA
         tVbhNkt+bZ8STsTHo+X99qTpNQeiWf/Fq9tf0E6hb4xsP3X7JEI47VZ4K5JKBiR2Ct4D
         4pC+ttie49WcFkKYXXETNWfwglxIYDq00ShX9Rgwc4sSZjVCjZaR4iM9wjVYZeZhsafT
         sDslrO6ecAGv7q1ESrKhsfj5mw+46uHk/pBArm1Vc8ZgVrWD2oi4TYbjLnyvMEzfsxox
         bE1QwJs5lO8VblHTeCGMbTBSf7IR4XJ42XC1gki7p7imZIAPvXQDutmGZq+sXl9cv8bo
         XGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN++RzycQhI0zOp3/Gpp2COjyDOKXNStECTnSP6UROw=;
        b=exf5GSkW2a0n4zyUO2VIRDmNkOI+3Rhl8EeUtAaHwpkc3MF+F5MRR+l4mzdJHCl3Si
         FMjhRKtSAsNA75huSEghcsIAh53i+Dub9tLMcF48CIvKG6rUPYDA7tsX0Lo+G+xLSOvQ
         UAECqmxa28di9KaWlqFYHNi53RgTQGWdTQKI6pZ1lO2GF9bcDPsY9B1CCg3gQFHhjzHW
         LL3Pwoq4RxXbhSMMKXQEcE3IOAbJ1CsqOp70rZBWA/R2yAEfO+BAA4UoAImpnUUZ+Uz1
         XYb9YVI+SAoSpHwzMlPID7BJO1W8NySwyYl5SI6WBOPnxYQbcgy2rTcKkgAjCSHu0AhK
         eXZg==
X-Gm-Message-State: ACrzQf0nThjPnibIuSO/KsfbUE84hEErsDdtLfixHgM+w6/IcQog7ksq
        koInzq6JhAvgxzRp9mLG4eFj5Q==
X-Google-Smtp-Source: AMsMyM4YQ4sfPYLUzw55FberGjLaMi/YCNqWtb/vNksc4dhyg3jGtswU1Y/i8QjYx5BlqBuD2nxppA==
X-Received: by 2002:a63:f349:0:b0:43a:b82b:1173 with SMTP id t9-20020a63f349000000b0043ab82b1173mr22747244pgj.534.1665515914419;
        Tue, 11 Oct 2022 12:18:34 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001750792f20asm844033plb.238.2022.10.11.12.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:18:34 -0700 (PDT)
Date:   Tue, 11 Oct 2022 19:18:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] KVM: selftests: Rename 'msr->availble' to
 'msr->fault_exepected' in hyperv_features test
Message-ID: <Y0XBhsbvy60b8Zy9@google.com>
References: <20220922143655.3721218-1-vkuznets@redhat.com>
 <20220922143655.3721218-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922143655.3721218-5-vkuznets@redhat.com>
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

Nit, s/availble,/available

On Thu, Sep 22, 2022, Vitaly Kuznetsov wrote:
> It may not be clear what 'msr->availble' means. The test actually

Same typo here.

> checks that accessing the particular MSR doesn't cause #GP, rename
> the varialble accordingly.

s/varialble/variable

At least you're consistent :-)

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  .../selftests/kvm/x86_64/hyperv_features.c    | 96 +++++++++----------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index 79ab0152d281..1383b979e90b 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -33,7 +33,7 @@ static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
>  
>  struct msr_data {
>  	uint32_t idx;
> -	bool available;
> +	bool fault_expected;
>  	bool write;
>  	u64 write_val;
>  };
> @@ -56,10 +56,10 @@ static void guest_msr(struct msr_data *msr)
>  	else
>  		vector = wrmsr_safe(msr->idx, msr->write_val);
>  
> -	if (msr->available)
> -		GUEST_ASSERT_2(!vector, msr->idx, vector);
> -	else
> +	if (msr->fault_expected)
>  		GUEST_ASSERT_2(vector == GP_VECTOR, msr->idx, vector);
> +	else
> +		GUEST_ASSERT_2(!vector, msr->idx, vector);
>  	GUEST_DONE();
>  }
>  
> @@ -153,12 +153,12 @@ static void guest_test_msrs_access(void)
>  			 */
>  			msr->idx = HV_X64_MSR_GUEST_OS_ID;
>  			msr->write = 0;
> -			msr->available = 0;
> +			msr->fault_expected = 1;

Since all of these are getting inverted, opportunistically use "true" instead of "1"?
