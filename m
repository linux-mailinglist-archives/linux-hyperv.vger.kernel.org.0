Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EF1549A12
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbiFMRfE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiFMRev (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 13:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B11B92DCE
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655125125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3+xwBi+u2qELbxSp/FN6uIklUfCnibg/SuxCdSI9f8=;
        b=FVKK0ILGjcLrek7q2OwVOaSDDip4icjnXpKE6OERUlK3YyHPkFTODKR/opDOD/y4bSkFJ2
        zyCmDbBlW+dnsE8imrF56bqwFacPOv5BQaZYXhhBaa4o1rCdNEvuT44DYlhLd8mIleTYtP
        M2IkEvgJqIKAcp+4ogXYMwf/I117xHg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-v-6D-NWJPZen5FizdQ9ocA-1; Mon, 13 Jun 2022 08:58:44 -0400
X-MC-Unique: v-6D-NWJPZen5FizdQ9ocA-1
Received: by mail-qv1-f72.google.com with SMTP id x17-20020a0cfe11000000b004645917e45cso3836361qvr.4
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 05:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=r3+xwBi+u2qELbxSp/FN6uIklUfCnibg/SuxCdSI9f8=;
        b=XVuVKCcoQygRHSaKc197+vfQjZZfkSoazqOKTBpKrT3NL0OAGnb/nR9Ln2qyIjf61M
         aH6ajtoDwzGQYBaQFezydwndOy5Pbz/vYT/nSipkPVzJljUEGpl5EMMBtAV/k7MM/iOp
         MK0cMSihscrOC6BcDXLUkOKAjYfwrZCWvUmA0xnwZ2GN5XQZiJoOnBSDku4D63UGbaC3
         oWNLpSwFO+q3z6GwmEasv/nSMuqDXfa9ALuWTP5UAL9koo8odNG/Q4kXvMSbtbf3MXoo
         JmnYUPwWv1hJ3xQl8l/XrFra2zHHLI/Z3GveOQ77Lj9R85HsXnGzfbfYxCCkIbv138LN
         wOOg==
X-Gm-Message-State: AJIora816dyyLjihuTWurbab78ApsFnPKFqFHx9XEElc9lI/7it2ziTF
        Iv9cZCPWIA6YmzBF/0Yx/PA1pG3uZytheODZ1E2WSkih9PrXe0Usbem4g14Gce/3FVpCMz8F9WE
        7IlGxHRk2IbRi9LHgJ0tSvbTj
X-Received: by 2002:a05:6214:5006:b0:46e:4e1f:ea35 with SMTP id jo6-20020a056214500600b0046e4e1fea35mr879423qvb.68.1655125123991;
        Mon, 13 Jun 2022 05:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tL9fgKHjbNjyqFoi6DzUlAioH+r6UanL+5qTwTn0I1yFmLx2E7F1WajeO/SQAtWbydoyjEzw==
X-Received: by 2002:a05:6214:5006:b0:46e:4e1f:ea35 with SMTP id jo6-20020a056214500600b0046e4e1fea35mr879404qvb.68.1655125123731;
        Mon, 13 Jun 2022 05:58:43 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ez11-20020a05622a4c8b00b002f905347586sm4919508qtb.14.2022.06.13.05.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:58:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/38] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
In-Reply-To: <0a7cada4844181d50b7ca971af5d8a4731171336.camel@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
 <20220606083655.2014609-6-vkuznets@redhat.com>
 <0a7cada4844181d50b7ca971af5d8a4731171336.camel@redhat.com>
Date:   Mon, 13 Jun 2022 14:58:39 +0200
Message-ID: <87leu0k9ds.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

...

>> =C2=A0
>> =C2=A0void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kvm_vcpu_hv_tlb_f=
lush_fifo *tlb_flush_fifo;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kvm_vcpu_hv *hv_v=
cpu =3D to_hv_vcpu(vcpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 entries[KVM_HV_TLB_FLUSH_=
FIFO_SIZE];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, j, count;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gva_t gva;
>> =C2=A0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvm_vcpu_flush_tlb_guest(vcpu=
);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!hv_vcpu)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tdp_enabled || !hv_vcpu)=
 {
> I haven't noticed that in the review I did back then, but
> any reason why !tdp_enabled?

This follows the logic in kvm_vcpu_flush_tlb_guest():

	if (!tdp_enabled) {
		/*
		 * A TLB flush on behalf of the guest is equivalent to
		 * INVPCID(all), toggling CR4.PGE, etc., which requires
		 * a forced sync of the shadow page tables.  Ensure all the
		 * roots are synced and the guest TLB in hardware is clean.
		 */
		kvm_mmu_sync_roots(vcpu);
		kvm_mmu_sync_prev_roots(vcpu);
	}

and as !tdp_enabled should be a rare debug or special case I decided to
take the shortcut and not drag any of this logic into hyperv emulation
code.

--=20
Vitaly

