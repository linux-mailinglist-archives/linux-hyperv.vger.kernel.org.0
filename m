Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BEC59C40B
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Aug 2022 18:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiHVQXf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiHVQXd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 12:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A755FE7
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661185401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bj0u0rbGbus5Dq/FJao2yGhu5YXJhcLCBMsadHoSqdo=;
        b=eHWwqfG/cOypsHucJdg4aKMEFLGxLOmMoHYhGHw+/qdNCojKis/nTEzi8rfPpFT8G+Zdnq
        /92GM/hfGWFVPzCOkgT9IMI6pKRHGW1YJgE/nDtJPxzKrz4I+7hY2UGHGB00ml99ceIh6U
        9Z9MJ/3uDNkoN1euVJ/RMogO9GtsecY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-7ZiNGuSGOR2onXYNfL65kw-1; Mon, 22 Aug 2022 12:22:01 -0400
X-MC-Unique: 7ZiNGuSGOR2onXYNfL65kw-1
Received: by mail-wm1-f70.google.com with SMTP id m22-20020a7bca56000000b003a652939bd1so697048wml.9
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Aug 2022 09:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=bj0u0rbGbus5Dq/FJao2yGhu5YXJhcLCBMsadHoSqdo=;
        b=Q1Kq3IOUMzyC6xNUxyZy/1CrSUx3SLPH643c6krtpDp5c6iuAaPmC5pubOqLVbWJyh
         AsjkZFhpbLum/QDJjKxqsPnT7uVo8a3g/Dp+ItOW520OgAgKRADNzJwnmGgnXBhXK0P9
         1OwwY9NuLTTVHv51RduzkQh56dZCzUa7m/Y14GCIq0cMaxDSzQ4qlTrE21tPbTsPgZhK
         ViRJPJabcfkTW4X1ghLBQDCDTJukFqpweePxDBX0qNhQEWw/3GDDf4L9XEP0WcJDHVdk
         rq8Zpi2refnmfhf/VHMzqXVisqRETNPEaYTRjEMBlGINnONN5qod8+Q62lx2P+GzC0kT
         rHHg==
X-Gm-Message-State: ACgBeo3vBCh7Wfo8tIwPQ+CdKO4ID6+qD34JQSWazgePFA/eg/KdXzyr
        GWsghdY/FtdXEQG0eBhm9X+oMUyxi15dUQ83xnH9zshG5STayiXs3zpisb/aVcuXPRvR/MehHzx
        3P7PCyKmFmLJ+Z8VYQFgWcutx
X-Received: by 2002:a05:600c:3c9b:b0:3a6:58b2:b80 with SMTP id bg27-20020a05600c3c9b00b003a658b20b80mr5223070wmb.132.1661185312218;
        Mon, 22 Aug 2022 09:21:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Kn2mEJXNUBEvtI+h/P2RDMUSo7Laz1MIfn2LUJ5bhNZYgLeYAwA6bjpOc6ng8CeUauHnPPw==
X-Received: by 2002:a05:600c:3c9b:b0:3a6:58b2:b80 with SMTP id bg27-20020a05600c3c9b00b003a658b20b80mr5223047wmb.132.1661185311985;
        Mon, 22 Aug 2022 09:21:51 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm11988449wrs.116.2022.08.22.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:21:51 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/26] x86/hyperv: Update 'struct
 hv_enlightened_vmcs' definition
In-Reply-To: <YwOm7Ph54vIYAllm@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-4-vkuznets@redhat.com>
 <Yv5ZFgztDHzzIQJ+@google.com> <875yiptvsc.fsf@redhat.com>
 <Yv59dZwP6rNUtsrn@google.com> <87czcsskkj.fsf@redhat.com>
 <YwOm7Ph54vIYAllm@google.com>
Date:   Mon, 22 Aug 2022 18:21:50 +0200
Message-ID: <87edx8xn8h.fsf@redhat.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 22, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Thu, Aug 18, 2022, Vitaly Kuznetsov wrote:
>> >> Sean Christopherson <seanjc@google.com> writes:
>> >> 
>> >> > On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
>> >> >> + * Note: HV_X64_NESTED_EVMCS1_2022_UPDATE is not currently documented in any
>> >> >> + * published TLFS version. When the bit is set, nested hypervisor can use
>> >> >> + * 'updated' eVMCSv1 specification (perf_global_ctrl, s_cet, ssp, lbr_ctl,
>> >> >> + * encls_exiting_bitmap, tsc_multiplier fields which were missing in 2016
>> >> >> + * specification).
>> >> >> + */
>> >> >> +#define HV_X64_NESTED_EVMCS1_2022_UPDATE		BIT(0)
>> >> >
>> >> > This bit is now defined[*], but the docs says it's only for perf_global_ctrl.  Are
>> >> > we expecting an update to the TLFS?
>> >> >
>> >> > 	Indicates support for the GuestPerfGlobalCtrl and HostPerfGlobalCtrl fields
>> >> > 	in the enlightened VMCS.
>> >> >
>> >> > [*] https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/feature-discovery#hypervisor-nested-virtualization-features---0x4000000a
>> >> >
>> >> 
>> >> Oh well, better this than nothing. I'll ping the people who told me
>> >> about this bit that their description is incomplete.
>> >
>> > Not that it changes anything, but I'd rather have no documentation.  I'd much rather
>> > KVM say "this is the undocumented behavior" than "the document behavior is wrong".
>> >
>> 
>> So I reached out to Microsoft and their answer was that for all these new
>> eVMCS fields (including *PerfGlobalCtrl) observing architectural VMX
>> MSRs should be enough. *PerfGlobalCtrl case is special because of Win11
>> bug (if we expose the feature in VMX feature MSRs but don't set
>> CPUID.0x4000000A.EBX BIT(0) it just doesn't boot).
>
> I.e. TSC_SCALING shouldn't be gated on the flag?  If so, then the 2-D array approach
> is overkill since (a) the CPUID flag only controls PERF_GLOBAL_CTRL and (b) we aren't
> expecting any more flags in the future.
>

Unfortunately, we have to gate the presence of these new features on
something, otherwise VMM has no way to specify which particular eVMCS
"revision" it wants (TL;DR: we will break migration).

My initial implementation was inventing 'eVMCS revision' concept:
https://lore.kernel.org/kvm/20220629150625.238286-7-vkuznets@redhat.com/

which is needed if we don't gate all these new fields on CPUID.0x4000000A.EBX BIT(0).

Going forward, we will still (likely) need something when new fields show up.

> What about this for an implementation?
>
> static bool evmcs_has_perf_global_ctrl(struct kvm_vcpu *vcpu)
> {
> 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>
> 	/*
> 	 * Filtering VMX controls for eVMCS compatibility should only be done
> 	 * for guest accesses, and all such accesses should be gated on Hyper-V
> 	 * being enabled and initialized.
> 	 */
> 	if (WARN_ON_ONCE(!hv_vcpu))
> 		return false;
>
> 	return hv_vcpu->cpuid_cache.nested_ebx & HV_X64_NESTED_EVMCS1_PERF_GLOBAL_CTRL;
> }
>
> static u32 evmcs_get_unsupported_ctls(struct kvm_vcpu *vcpu, u32 msr_index)
> {
> 	u32 unsupported_ctrls;
>
> 	switch (msr_index) {
> 	case MSR_IA32_VMX_EXIT_CTLS:
> 	case MSR_IA32_VMX_TRUE_EXIT_CTLS:
> 		unsupported_ctrls = EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
> 		if (!evmcs_has_perf_global_ctrl(vcpu))
> 			unsupported_ctrls |= VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> 		return unsupported_ctrls;
> 	case MSR_IA32_VMX_ENTRY_CTLS:
> 	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
> 		unsupported_ctrls = EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
> 		if (!evmcs_has_perf_global_ctrl(vcpu))
> 			unsupported_ctrls |= VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> 		return unsupported_ctrls;
> 	case MSR_IA32_VMX_PROCBASED_CTLS2:
> 		return EVMCS1_UNSUPPORTED_2NDEXEC;
> 	case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> 	case MSR_IA32_VMX_PINBASED_CTLS:
> 		return EVMCS1_UNSUPPORTED_PINCTRL;
> 	case MSR_IA32_VMX_VMFUNC:
> 		return EVMCS1_UNSUPPORTED_VMFUNC;
> 	default:
> 		KVM_BUG_ON(1, vcpu->kvm);
> 		return 0;
> 	}
> }
>
> void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
> {
> 	u64 unsupported_ctrls = evmcs_get_unsupported_ctls(vcpu, msr_index);
>
> 	if (msr_index == MSR_IA32_VMX_VMFUNC)
> 		*pdata &= ~unsupported_ctrls;
> 	else
> 		*pdata &= ~(unsupported_ctrls << 32);
> }
>

It's smaller and I like it but it would only work in conjunction with
KVM_CAP_HYPERV_ENLIGHTENED_VMCS2...

>
>> What I'm still concerned about is future proofing KVM for new
>> features. When something is getting added to KVM for which no eVMCS
>> field is currently defined, both Hyper-V-on-KVM and KVM-on-Hyper-V cases
>> should be taken care of. It would probably be better to reverse our
>> filtering, explicitly listing features supported in eVMCS. The lists are
>> going to be fairly long but at least we won't have to take care of any
>> new architectural feature added to KVM.
>
> Having the filtering be opt-in crossed my mind as well.  Reversing the filtering
> can be done after this series though, correct?
>

Yes, that's my plan, Get this in to fix the immediate issue with 2022
features and probably reverse the filtering before Microsoft releases
something else :-)

-- 
Vitaly

