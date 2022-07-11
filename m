Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2357E56A9B3
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGGRer (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 13:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbiGGReq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 13:34:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964863337C
        for <linux-hyperv@vger.kernel.org>; Thu,  7 Jul 2022 10:34:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bf13so6711262pgb.11
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Jul 2022 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZkWdgnoDbGquEz4BY21XA5EPvYhUnSdDHMgpi45vYE=;
        b=aGoS0rpC+B/tEvOv7NxuN+Y7Pz+rK2bekFpku9LPo2Efm45YbwFdW7HuhOwqzB7uD6
         V4Emw9rT8b8duwWHgu03PVNsnP/gISTXS/rnEEYzDb7bKQeiIXPygnmawDlVnYGTZE5m
         xsJYflAreHSAYanGagTOSnBOb/9tT9fljaAVPrZUO+9P8YtGV30pnrV8OIOpyNMbti7C
         6l93nCMfKR+FM8G04fBWS+NE8Syz66hv7Xz6x5hqBbtlKeGaPryaRYSkPG0GTt3K5YUB
         YLLLoSX62qgOzLYwASZl23mwveiqM7PiVGxBtTdOOEx/TtPeFJb9TwPhB3Hz14WPj1Z5
         WRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZkWdgnoDbGquEz4BY21XA5EPvYhUnSdDHMgpi45vYE=;
        b=KONeeN9X0Xi4lF25ES68qFR6dImr6xAp66D9xyJpOvKfI/kQCnlKCE1KSy2CV6TFcV
         N/Bt0rAR4gXWhEupSTXVUO2GrJnCPBeu/ro8IgQcMjFLvKGr+EQzjrA+1j6NeovHAllB
         mItQZWYmm3bCX+Zzu6X7xbhyVlIwUOYOvmX58DYzUnxjHkK214hSJM0Ug373O5W3/d/O
         9NWJpu0OP4n2iGqT0WGgBG4UmEafB7rNi9xQ4JWF346XJJrLvwF9bkr5fzdj3vpTTm+F
         8rkbDUGq5wuPBn5qg3Blz4zrp+AmZIV11ykK22Gx6VXnOVARAhRJdZWp8F5dePIySr+a
         s+eQ==
X-Gm-Message-State: AJIora/77aQh8AfbcnCToQPo3MsTygLzJH8WWDWeWTFSmxgg5fNSFZrq
        OVet/DlZLvCgLUHllCErhpe0Dg==
X-Google-Smtp-Source: AGRyM1sSBy47ob/FtIIC3SZjUaHxjOTEMYeykT695pMIsoflrGgSlcKyy5/HgZwBDzRBgYmuGjT39A==
X-Received: by 2002:a63:a46:0:b0:412:b1d6:94cf with SMTP id z6-20020a630a46000000b00412b1d694cfmr5688478pgk.373.1657215284911;
        Thu, 07 Jul 2022 10:34:44 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id o66-20020a625a45000000b0052a53f8ece3sm50268pfb.42.2022.07.07.10.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:34:44 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:34:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fully initialize 'struct kvm_lapic_irq' in
 kvm_pv_kick_cpu_op()
Message-ID: <YscZMCBpuoJUlQ+H@google.com>
References: <20220628133057.107344-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628133057.107344-1-vkuznets@redhat.com>
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

On Tue, Jun 28, 2022, Vitaly Kuznetsov wrote:
> 'vector' and 'trig_mode' fields of 'struct kvm_lapic_irq' are left
> uninitialized in kvm_pv_kick_cpu_op(). While these fields are normally
> not needed for APIC_DM_REMRD, they're still referenced by
> __apic_accept_irq() for trace_kvm_apic_accept_irq(). Fully initialize
> the structure to avoid consuming random stack memory.
> 
> Fixes: a183b638b61c ("KVM: x86: make apic_accept_irq tracepoint more generic")
> Reported-by: syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 567d13405445..8a98608dad4f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9340,15 +9340,17 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
>   */
>  static void kvm_pv_kick_cpu_op(struct kvm *kvm, int apicid)
>  {
> -	struct kvm_lapic_irq lapic_irq;
> -
> -	lapic_irq.shorthand = APIC_DEST_NOSHORT;
> -	lapic_irq.dest_mode = APIC_DEST_PHYSICAL;
> -	lapic_irq.level = 0;
> -	lapic_irq.dest_id = apicid;
> -	lapic_irq.msi_redir_hint = false;
> +	struct kvm_lapic_irq lapic_irq = {
> +		.vector = 0,
> +		.delivery_mode = APIC_DM_REMRD,
> +		.dest_mode = APIC_DEST_PHYSICAL,
> +		.level = false,
> +		.trig_mode = 0,
> +		.shorthand = APIC_DEST_NOSHORT,
> +		.dest_id = apicid,
> +		.msi_redir_hint = false
> +	};

What if we rely on the compiler to zero-initialize omitted fields?  E.g.

	/*
	 * All other fields are unused for APIC_DM_REMRD, but may be consumed by
	 * common code, e.g. for tracing.  Defer initialization to the compiler.
	 */
	struct kvm_lapic_irq lapic_irq = {
		.delivery_mode = APIC_DM_REMRD,
		.dest_mode = APIC_DEST_PHYSICAL,
		.shorthand = APIC_DEST_NOSHORT,
		.dest_id = apicid,
	};

KVM doesn't actually care about the vector, level, trig_mode, etc... for its magic
magic DM_REMRD, i.e. using 0/false is completely arbitrary.  

>  
> -	lapic_irq.delivery_mode = APIC_DM_REMRD;
>  	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
>  }
>  
> -- 
> 2.35.3
> 
