Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8B7226BE
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jun 2023 15:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjFENB2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Jun 2023 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjFENBV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Jun 2023 09:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED21A1
        for <linux-hyperv@vger.kernel.org>; Mon,  5 Jun 2023 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685970038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aGjYzdJUv3mCKaWHOXQQVhBXGYUPAjudrmb3GbAYcs=;
        b=h9eUdP+sRAY7iqIILqaydT51jdfQxxpnu4GoJxVZfFWNJTXGdExssZYF+ez8bB2fXGKBmz
        auSRvnMydrBs4xLfe4RJ0CM7gJSXJyeRs+mbbGSInlY8tZibIazJwHvQ5rK/a2P1xlH734
        ufBLW+FJ7V8sgK7ffRepkBppT+rHLPQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-wDKG2c3OMnqEL8cGf3Tbrw-1; Mon, 05 Jun 2023 09:00:36 -0400
X-MC-Unique: wDKG2c3OMnqEL8cGf3Tbrw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f772115352so5113085e9.0
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Jun 2023 06:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685970035; x=1688562035;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aGjYzdJUv3mCKaWHOXQQVhBXGYUPAjudrmb3GbAYcs=;
        b=iBbpZfWyv59kPnp5+oMU/e5SRy0UGrbUG6Cbfs6fHA1hdmKRo7Qy+/XaNwzMIh+4Jt
         guSTou78gcWau6nLq/8YnJo59iWu9wiQOqG5VBIA9zhb/Rv1EDxK6X9XhcQ+IFG6A75Z
         3pfXsWq4CR/jYEh+nGf1aJD/AnB7iMehwDInyKDRvG01hGdUue413hpofS9K8s6VmkDv
         vIR/D1NkkbM9h21O2RlFf2qq5KzeQzFRYWSYjllPlUJ27mTs/dKZ8CEZA1i9j9UOTQgH
         VYo/nVNRm0Jna+hz2inPRlBFZ26R3PnUEQgyXrCTSJlmd8fd/zs3WbLEb6dhW0hwnbZH
         mr+Q==
X-Gm-Message-State: AC+VfDy3BQ8cW82sW78Tqxwb2OlOZW/XInO6zeTiS/PVsbRLOlMry7Tq
        wS8WJAQ5COGclrEE79Wjib+tjWZLtZ2bTYTEc/5wVnoScA/yPROPguetjhjvko0Asz2KqNqLR7N
        FqXkdylReCH/DSGlSX7RCzGg4W3ZzuYmC
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id p24-20020a05600c1d9800b003f7367a38cbmr3872774wms.2.1685970035402;
        Mon, 05 Jun 2023 06:00:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BYasbXF+HwlwoTO7ru5Jn/GlxOkdZNhWdPXcR60/ODZuYlz9paQmxJ0VSP+eJVhTa5e/f5Q==
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id p24-20020a05600c1d9800b003f7367a38cbmr3872737wms.2.1685970035044;
        Mon, 05 Jun 2023 06:00:35 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id w11-20020a1cf60b000000b003f423f5b659sm10737802wmc.10.2023.06.05.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 06:00:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
In-Reply-To: <20230601151624.1757616-6-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
Date:   Mon, 05 Jun 2023 15:00:33 +0200
Message-ID: <87wn0ijc7i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <tiala@microsoft.com>
>
> In sev-snp enlightened guest, Hyper-V hypercall needs
> to use vmmcall to trigger vmexit and notify hypervisor
> to handle hypercall request.
>
> There is no x86 SEV SNP feature flag support so far and
> hardware provides MSR_AMD64_SEV register to check SEV-SNP
> capability with MSR_AMD64_SEV_ENABLED bit. ALTERNATIVE can't
> work without SEV-SNP x86 feature flag. May add later when
> the associated flag is introduced. 
>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 44 ++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 31c476f4e656..d859d7c5f5e8 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -61,16 +61,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> +	if (hv_isolation_type_en_snp()) {

Would it be possible to redo 'hv_isolation_type_en_snp()' into a static
inline doing static_branch_unlikely() so we avoid function call penalty
here?

> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     "vmmcall"
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	} else {
> +		if (!hv_hypercall_pg)
> +			return U64_MAX;
>  
> -	__asm__ __volatile__("mov %4, %%r8\n"
> -			     CALL_NOSPEC
> -			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     :  "r" (output_address),
> -				THUNK_TARGET(hv_hypercall_pg)
> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     CALL_NOSPEC
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address),
> +					THUNK_TARGET(hv_hypercall_pg)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	}
>  #else
>  	u32 input_address_hi = upper_32_bits(input_address);
>  	u32 input_address_lo = lower_32_bits(input_address);
> @@ -104,7 +113,13 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> -	{
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__(
> +				"vmmcall"
> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input1)
> +				:: "cc", "r8", "r9", "r10", "r11");
> +	} else {
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>  				       "+c" (control), "+d" (input1)
> @@ -149,7 +164,14 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> -	{
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     "vmmcall"
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input1)
> +				     : "r" (input2)
> +				     : "cc", "r8", "r9", "r10", "r11");
> +	} else {
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC
>  				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,

-- 
Vitaly

