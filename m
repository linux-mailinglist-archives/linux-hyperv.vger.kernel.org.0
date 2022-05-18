Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC852BCA7
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 May 2022 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiERMtv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 May 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiERMtu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 May 2022 08:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2DE618DADC
        for <linux-hyperv@vger.kernel.org>; Wed, 18 May 2022 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652878186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ud+EoewnZynIABdLMtBZtAj7r2i0k69OeMeQkGeRK8k=;
        b=FerM3AaQf4sOabJ6AbxkBUzVic7OrT3xI5qr0rc2RHclIwOMF+929wSHNzNcTwDSLKSWrj
        iipYnDh9jPGoEhPJk31dKHSQZNXlIPOQNFI9WVvgrMCKF/UBtVIMXTUOGLsRfACNUqgzDl
        ahK9HPAtBBQBo+mGnuik0/8/xqyXiH8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-y84T1USJP3O-JM7cwBbXYA-1; Wed, 18 May 2022 08:49:43 -0400
X-MC-Unique: y84T1USJP3O-JM7cwBbXYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C1C429DD9B4;
        Wed, 18 May 2022 12:49:43 +0000 (UTC)
Received: from starship (unknown [10.40.192.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C65C42026D6A;
        Wed, 18 May 2022 12:49:40 +0000 (UTC)
Message-ID: <57aa037a77ba8d8e182d8c77233c5954dd2fa2d9.camel@redhat.com>
Subject: Re: [PATCH v3 14/34] KVM: x86: Introduce .post_hv_l2_tlb_flush()
 nested hook
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 18 May 2022 15:49:39 +0300
In-Reply-To: <871qwrui3o.fsf@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
         <20220414132013.1588929-15-vkuznets@redhat.com>
         <deae695da02d7f22dcfa4635eec53ab61baf9026.camel@redhat.com>
         <871qwrui3o.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 2022-05-18 at 14:43 +0200, Vitaly Kuznetsov wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Thu, 2022-04-14 at 15:19 +0200, Vitaly Kuznetsov wrote:
> > > Hyper-V supports injecting synthetic L2->L1 exit after performing
> > > L2 TLB flush operation but the procedure is vendor specific.
> > > Introduce .post_hv_l2_tlb_flush() nested hook for it.
> > > 
> > > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h |  1 +
> > >  arch/x86/kvm/Makefile           |  3 ++-
> > >  arch/x86/kvm/svm/hyperv.c       | 11 +++++++++++
> > >  arch/x86/kvm/svm/hyperv.h       |  2 ++
> > >  arch/x86/kvm/svm/nested.c       |  1 +
> > >  arch/x86/kvm/vmx/evmcs.c        |  4 ++++
> > >  arch/x86/kvm/vmx/evmcs.h        |  1 +
> > >  arch/x86/kvm/vmx/nested.c       |  1 +
> > >  8 files changed, 23 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/x86/kvm/svm/hyperv.c
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index 8b2a52bf26c0..ce62fde5f4ff 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -1558,6 +1558,7 @@ struct kvm_x86_nested_ops {
> > >  	int (*enable_evmcs)(struct kvm_vcpu *vcpu,
> > >  			    uint16_t *vmcs_version);
> > >  	uint16_t (*get_evmcs_version)(struct kvm_vcpu *vcpu);
> > > +	void (*post_hv_l2_tlb_flush)(struct kvm_vcpu *vcpu);
> > >  };
> > >  
> > >  struct kvm_x86_init_ops {
> > > diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> > > index 30f244b64523..b6d53b045692 100644
> > > --- a/arch/x86/kvm/Makefile
> > > +++ b/arch/x86/kvm/Makefile
> > > @@ -25,7 +25,8 @@ kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
> > >  			   vmx/evmcs.o vmx/nested.o vmx/posted_intr.o
> > >  kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
> > >  
> > > -kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o svm/sev.o
> > > +kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o \
> > > +			   svm/sev.o svm/hyperv.o
> > >  
> > >  ifdef CONFIG_HYPERV
> > >  kvm-amd-y		+= svm/svm_onhyperv.o
> > > diff --git a/arch/x86/kvm/svm/hyperv.c b/arch/x86/kvm/svm/hyperv.c
> > > new file mode 100644
> > > index 000000000000..c0749fc282fe
> > > --- /dev/null
> > > +++ b/arch/x86/kvm/svm/hyperv.c
> > > @@ -0,0 +1,11 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * AMD SVM specific code for Hyper-V on KVM.
> > > + *
> > > + * Copyright 2022 Red Hat, Inc. and/or its affiliates.
> > > + */
> > > +#include "hyperv.h"
> > > +
> > > +void svm_post_hv_l2_tlb_flush(struct kvm_vcpu *vcpu)
> > > +{
> > > +}
> > > diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
> > > index 8cf702fed7e5..a2b0d7580b0d 100644
> > > --- a/arch/x86/kvm/svm/hyperv.h
> > > +++ b/arch/x86/kvm/svm/hyperv.h
> > > @@ -48,4 +48,6 @@ static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
> > >  	hv_vcpu->nested.vp_id = hve->hv_vp_id;
> > >  }
> > >  
> > > +void svm_post_hv_l2_tlb_flush(struct kvm_vcpu *vcpu);
> > > +
> > >  #endif /* __ARCH_X86_KVM_SVM_HYPERV_H__ */
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 2d1a76343404..de3f27301b5c 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -1665,4 +1665,5 @@ struct kvm_x86_nested_ops svm_nested_ops = {
> > >  	.get_nested_state_pages = svm_get_nested_state_pages,
> > >  	.get_state = svm_get_nested_state,
> > >  	.set_state = svm_set_nested_state,
> > > +	.post_hv_l2_tlb_flush = svm_post_hv_l2_tlb_flush,
> > >  };
> > > diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> > > index 87e3dc10edf4..e390e67496df 100644
> > > --- a/arch/x86/kvm/vmx/evmcs.c
> > > +++ b/arch/x86/kvm/vmx/evmcs.c
> > > @@ -437,3 +437,7 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
> > >  
> > >  	return 0;
> > >  }
> > > +
> > > +void vmx_post_hv_l2_tlb_flush(struct kvm_vcpu *vcpu)
> > > +{
> > > +}
> > > diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
> > > index 8d70f9aea94b..b120b0ead4f3 100644
> > > --- a/arch/x86/kvm/vmx/evmcs.h
> > > +++ b/arch/x86/kvm/vmx/evmcs.h
> > > @@ -244,5 +244,6 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
> > >  			uint16_t *vmcs_version);
> > >  void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata);
> > >  int nested_evmcs_check_controls(struct vmcs12 *vmcs12);
> > > +void vmx_post_hv_l2_tlb_flush(struct kvm_vcpu *vcpu);
> > >  
> > >  #endif /* __KVM_X86_VMX_EVMCS_H */
> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index ee88921c6156..cc6c944b5815 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -6850,4 +6850,5 @@ struct kvm_x86_nested_ops vmx_nested_ops = {
> > >  	.write_log_dirty = nested_vmx_write_pml_buffer,
> > >  	.enable_evmcs = nested_enable_evmcs,
> > >  	.get_evmcs_version = nested_get_evmcs_version,
> > > +	.post_hv_l2_tlb_flush = vmx_post_hv_l2_tlb_flush,
> > >  };
> > 
> > I think that the name of the function is misleading, since it is not called
> > after each L2 HV tlb flush, but only after a flush which needs to inject
> > that synthetic VM exit.
> > 
> > I think something like 'inject_synthetic_l2_hv_tlb_flush_vmexit' 
> > (not a good name IMHO, but you get the idea) would be better.
> > 
> 
> Naming is hard indeed,

Indeed :-)

https://www.monkeyuser.com/2019/_/


> 
> hv_inject_synthetic_vmexit_post_tlb_flush()

Looks great!

Best regards,
	Maxim Levitsky

> 
> seems to be accurate.
> 


