Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033C5E5534
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIUVbY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIUVbX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 17:31:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6944D895E4
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 14:31:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e67so1088662pgc.12
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MtHodFxpfz6Gd8VuxCE0ViD4vs9jhJutX1fWItr/j34=;
        b=d/69TAR/VfwBMGYP3zlfZyRm+hhaplJtmqpWZYe78x77tqVCAbJn1D2nLta5dg+KGo
         x7jupg9vOzqIDJCLP5FIU//ELQEMV7Ym28srfz2QQ9/YFOfW6fz4m7kHAsRKW7qa4GSi
         SqG1hpNajJYSuUwHSwks6GRNlCWlY0KjZ1bFroyxvkUZT2F1j3bKuKruOBDIHRNxs/s3
         ZTnb1Fa4O97KAElFERhEFxcyMt3wLqRFs7Zt5qsK7aZpz8/1O/gPZIxDzzP4tXNol4hV
         xThWMpqFyLKwxwdtqD98Sk3a6CXxbee8MDfm+8Lm5kvv4Qau/dmst0JEsOLoVNExktUw
         rcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MtHodFxpfz6Gd8VuxCE0ViD4vs9jhJutX1fWItr/j34=;
        b=yp2VQO7+Rw2gTCYYPswHLS5725USdLl2hAjYw9JgpJxR11IqBzFvUwoRgMnksdTHI/
         +Q/9AlMXFeWTH6ou/TFr/0h3wRyO/FX19qK43n5j50GoH5UzyquTHDWnzs6eeLIk84Bl
         wWxfbzQXB7/WsMVghq6Whr11Wyz75fXOId3kSbp3nkUL/DCVtTxG2rTQViuVwYh/my2r
         wtx+Kp87Awd3iuwGKM9j81bPOyRxITzY9hycyk1lrtw7SyliHRI8FUgrYOgV4Eq6FoB4
         82jkafrbQXPTXFwZONwtZMjHRKIYlLA+bqwNooP/Cq6TrJoh+IlX1sPd5uUU7TRhGqEE
         GpjA==
X-Gm-Message-State: ACrzQf2Ufuc/V9j279HSTkyuqwAtH2tSzvektUkpR/lXC0PoyrXX+VQZ
        jihi4gEQhEncmlR8wOjU3WZK1A==
X-Google-Smtp-Source: AMsMyM5h3bF9mCl9EVNRQPewWgdZv/U+piqP0003MlWzlT8JkoV1js20ExBLIK/x/qJWpUey0JIIoQ==
X-Received: by 2002:a63:a501:0:b0:434:ff77:1fda with SMTP id n1-20020a63a501000000b00434ff771fdamr183421pgf.310.1663795881839;
        Wed, 21 Sep 2022 14:31:21 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902e88d00b00176dc67df44sm2528349plg.132.2022.09.21.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:31:21 -0700 (PDT)
Date:   Wed, 21 Sep 2022 21:31:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 21/39] KVM: nSVM: hyper-v: Enable L2 TLB flush
Message-ID: <YyuCpelHQa00qNNF@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-22-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152436.3673454-22-vkuznets@redhat.com>
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

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
> diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
> index dd2e393f84a0..7b01722838bf 100644
> --- a/arch/x86/kvm/svm/hyperv.h
> +++ b/arch/x86/kvm/svm/hyperv.h
> @@ -33,6 +33,9 @@ struct hv_enlightenments {
>   */
>  #define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
>  
> +#define HV_SVM_EXITCODE_ENL 0xF0000000
> +#define HV_SVM_ENL_EXITCODE_TRAP_AFTER_FLUSH   (1)

Same as the synthetic VMX exit reason, these should go in hyperv-tlfs.h.  Keeping
these out of KVM also helps avoid the need for svm/hyperv.h.

https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/nested-virtualization#synthetic-vm-exit

> +
>  static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -48,6 +51,33 @@ static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
>  	hv_vcpu->nested.vp_id = hve->hv_vp_id;
>  }
>  
> +static inline bool

Strongly prefer 'int' with 0/-errno over a boolean.  Hrm, maybe add a prep patch
to convert kvm_hv_get_assist_page() to return 0/-errno?  That way this can still
return kvm_hv_get_assist_page() directly.

> nested_svm_hv_update_vp_assist(struct kvm_vcpu *vcpu)

Maybe s/update/verify since there isn't a true update anywhere?

> +{
> +	if (!to_hv_vcpu(vcpu))

This check isn't necessary, it's covered by kvm_hv_assist_page_enabled().

> +		return true;
> +
> +	if (!kvm_hv_assist_page_enabled(vcpu))
> +		return true;
> +
> +	return kvm_hv_get_assist_page(vcpu);

As mentioned earlier, I think this belongs in arch/x86/kvm/hyperv.h.
