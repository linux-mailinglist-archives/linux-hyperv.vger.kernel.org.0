Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80C93A3CE8
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jun 2021 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFKHWQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Jun 2021 03:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231357AbhFKHWQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Jun 2021 03:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623396018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYjg/yEV7PUq2GYWP2SW746eR9Kq3NCgJS7G1o1Lc6A=;
        b=QDGLPaAFQibGR777424sOA9NEpuqmkzxI23N1S8oV1DJJ7wTSkhjt0vEhuy6JBG43ftAZi
        RVbi50UD6OHZPgDQtnX+pxsZ2beV8nbFsmtGOxa6PJZbfDC7z0eTdoXcuKSLEREMasIYi4
        16xO8aOpYwa3qzhJ/diJfaF/tvWn4c8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-bUWTM8RnOHWgD2fZuQjJEg-1; Fri, 11 Jun 2021 03:20:15 -0400
X-MC-Unique: bUWTM8RnOHWgD2fZuQjJEg-1
Received: by mail-wr1-f70.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso2204169wrf.4
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Jun 2021 00:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gYjg/yEV7PUq2GYWP2SW746eR9Kq3NCgJS7G1o1Lc6A=;
        b=Si4/+Y18n0lQTTrjFsdFOVv2g3O2+Jktfs9GkdKFjAwIcX0CNzckzq/Zk6+Pn8calG
         3skTa3nOQ2o4AUozZDPXBNjseueTUT8Sdy5GkAaVSXB8RJg39fglVo3gsYox4r+Yhhf/
         XcCnn01foJaTFeD69dnVbkxV81e1Gb3m5nPXQwnPAyHv+xIIStTl4/GfIntsbNp9quSj
         d6Ywshhq1ANFU86ENa9t1qiMol4qmXhjY4YPZgAtVx24Wr73OBTy5EsNbrUWFaM0r10O
         p3dHRnb1hcBIBL9EwwfM+Angad0zDxMQ0CoChqItmd2U7GEpEXL/nujxiEIj83aQayYR
         0/KQ==
X-Gm-Message-State: AOAM533mpTNTa/Mkmz1MkPT4heaxB3vXHJLQkoDFD+ujbec9X/a18ofj
        CXli4DPWb8OV6GRk4ioHOS4OOeJaG3jul22HAAOXxbN0GTRWNY/g3vBMVPtXZq3SwIUAj1UEaEs
        jBf+EXrn3C2cSQZxnuojahE3E
X-Received: by 2002:a05:600c:1d1b:: with SMTP id l27mr2490774wms.62.1623396014389;
        Fri, 11 Jun 2021 00:20:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxHECOXihNxXks5FPLEuvHTTQDpLVvf1IgC3Th2TxpBzLVOMuJTQ6q1LPQpSSDkIJn2XS3GA==
X-Received: by 2002:a05:600c:1d1b:: with SMTP id l27mr2490733wms.62.1623396014106;
        Fri, 11 Jun 2021 00:20:14 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m7sm6299020wrv.35.2021.06.11.00.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:20:13 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH v5 3/7] KVM: x86: hyper-v: Move the remote TLB flush
 logic out of vmx
In-Reply-To: <3b74b538-0b28-7a00-0b26-0f926cd8f37e@redhat.com>
References: <cover.1622730232.git.viremana@linux.microsoft.com>
 <4f4e4ca19778437dae502f44363a38e99e3ef5d1.1622730232.git.viremana@linux.microsoft.com>
 <87y2bix8y1.fsf@vitty.brq.redhat.com>
 <3b74b538-0b28-7a00-0b26-0f926cd8f37e@redhat.com>
Date:   Fri, 11 Jun 2021 09:20:12 +0200
Message-ID: <87k0n0yij7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/06/21 13:20, Vitaly Kuznetsov wrote:
>
>>> +static inline void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root=
_tdp)
>>> +{
>>> +	struct kvm_arch *kvm_arch =3D &vcpu->kvm->arch;
>>> +
>>> +	if (kvm_x86_ops.tlb_remote_flush =3D=3D hv_remote_flush_tlb) {
>>> +		spin_lock(&kvm_arch->hv_root_tdp_lock);
>>> +		vcpu->arch.hv_root_tdp =3D root_tdp;
>>> +		if (root_tdp !=3D kvm_arch->hv_root_tdp)
>>> +			kvm_arch->hv_root_tdp =3D INVALID_PAGE;
>>> +		spin_unlock(&kvm_arch->hv_root_tdp_lock);
>>> +	}
>>> +}
>>> +#else
>>> +static inline void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root=
_tdp)
>>> +{
>>> +}
>>> +#endif
>>> +#endif
>>=20
>> Super-nitpick: I'd suggest adding /* __ARCH_X86_KVM_KVM_ONHYPERV_H__ */
>> to the second '#endif' and /* IS_ENABLED(CONFIG_HYPERV) */ to '#else'
>> and the first one: files/functions tend to grow and it becomes hard to
>> see where the particular '#endif/#else' belongs.
>
> Done, thanks.  I've also changed the #if to just "#ifdef CONFIG_HYPERV",=
=20
> since IS_ENABLED is only needed in C statements.

kvm/queue fails to compile and I blame this change:

In file included from arch/x86/kvm/svm/svm_onhyperv.c:16:
arch/x86/kvm/svm/svm_onhyperv.h: In function =E2=80=98svm_hv_hardware_setup=
=E2=80=99:
arch/x86/kvm/svm/svm_onhyperv.h:56:34: error: =E2=80=98hv_remote_flush_tlb=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98sv=
m_flush_tlb=E2=80=99?
   56 |   svm_x86_ops.tlb_remote_flush =3D hv_remote_flush_tlb;
      |                                  ^~~~~~~~~~~~~~~~~~~
      |                                  svm_flush_tlb
arch/x86/kvm/svm/svm_onhyperv.h:56:34: note: each undeclared identifier is =
reported only once for each function it appears in
arch/x86/kvm/svm/svm_onhyperv.h:58:5: error: =E2=80=98hv_remote_flush_tlb_w=
ith_range=E2=80=99 undeclared (first use in this function)
   58 |     hv_remote_flush_tlb_with_range;
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:272: arch/x86/kvm/svm/svm_onhyperv.o] =
Error 1
make[2]: *** Waiting for unfinished jobs....
In file included from arch/x86/kvm/svm/svm.c:47:
arch/x86/kvm/svm/svm_onhyperv.h: In function =E2=80=98svm_hv_hardware_setup=
=E2=80=99:
arch/x86/kvm/svm/svm_onhyperv.h:56:34: error: =E2=80=98hv_remote_flush_tlb=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98sv=
m_flush_tlb=E2=80=99?
   56 |   svm_x86_ops.tlb_remote_flush =3D hv_remote_flush_tlb;
      |                                  ^~~~~~~~~~~~~~~~~~~
      |                                  svm_flush_tlb
arch/x86/kvm/svm/svm_onhyperv.h:56:34: note: each undeclared identifier is =
reported only once for each function it appears in
arch/x86/kvm/svm/svm_onhyperv.h:58:5: error: =E2=80=98hv_remote_flush_tlb_w=
ith_range=E2=80=99 undeclared (first use in this function)
   58 |     hv_remote_flush_tlb_with_range;
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:272: arch/x86/kvm/svm/svm.o] Error 1
arch/x86/kvm/vmx/vmx.c: In function =E2=80=98hardware_setup=E2=80=99:
arch/x86/kvm/vmx/vmx.c:7752:34: error: =E2=80=98hv_remote_flush_tlb=E2=80=
=99 undeclared (first use in this function)
 7752 |   vmx_x86_ops.tlb_remote_flush =3D hv_remote_flush_tlb;
      |                                  ^~~~~~~~~~~~~~~~~~~
arch/x86/kvm/vmx/vmx.c:7752:34: note: each undeclared identifier is reporte=
d only once for each function it appears in
arch/x86/kvm/vmx/vmx.c:7754:5: error: =E2=80=98hv_remote_flush_tlb_with_ran=
ge=E2=80=99 undeclared (first use in this function)
 7754 |     hv_remote_flush_tlb_with_range;
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


(Note: CONFIG_HYPERV can be 'm'.)

The following:

index 96da53edfe83..1c67abf2eba9 100644
--- a/arch/x86/kvm/kvm_onhyperv.h
+++ b/arch/x86/kvm/kvm_onhyperv.h
@@ -6,7 +6,7 @@
 #ifndef __ARCH_X86_KVM_KVM_ONHYPERV_H__
 #define __ARCH_X86_KVM_KVM_ONHYPERV_H__
=20
-#ifdef CONFIG_HYPERV
+#if IS_ENABLED(CONFIG_HYPERV)
 int hv_remote_flush_tlb_with_range(struct kvm *kvm,
                struct kvm_tlb_range *range);
 int hv_remote_flush_tlb(struct kvm *kvm);

saves the day for me.

--=20
Vitaly

