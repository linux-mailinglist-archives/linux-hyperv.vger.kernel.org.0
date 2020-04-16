Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD71AB8DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2020 08:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437582AbgDPG5x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Apr 2020 02:57:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437800AbgDPG5v (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Apr 2020 02:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587020265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jIfsQLzFAdFaLNbfCoGQ8zkTgNktZzjgnJVMtvlPM4=;
        b=RNMNlLK0M8ly8sw0Qa4jfWtKwNA6ZGVd5618T1/fxTogOPSt2Uxq1hUGu6iotl04Fw6+gs
        oOW0WpDMin1Dz3oB85TdeNblQW43ckgVGgdShk2YGkQshvnIYhaXMCNqXi674f76XoQ6cL
        448ihi8zFBjAi6Enx/i0A3TYE2Y2aiY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-HT8PgkexPBCzMVwicc1O3g-1; Thu, 16 Apr 2020 02:57:43 -0400
X-MC-Unique: HT8PgkexPBCzMVwicc1O3g-1
Received: by mail-wr1-f72.google.com with SMTP id j22so1248145wrb.4
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Apr 2020 23:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+jIfsQLzFAdFaLNbfCoGQ8zkTgNktZzjgnJVMtvlPM4=;
        b=IKnVDz+UV24o+RisGvCg69R//T2CmVBhTcxg7RjX7EYohIT4niYdcYSMKqbsladug2
         XXcSQxwqM4BrcEnAKPqcs0TpMZpm9EQdlNkYKzVSRtO3ixnf9UxyfWCMTzZnOCPUJ2b8
         Sqx7ay7FOyJbdm8NbNsRuOB6U7f8JoLFPVPlahv9/gyWHmgTEVaWZFGJ2TTs9JHOvdlA
         1GQnTMvIHWjyzgJNxbukmEEyeSRxeaY1hGC0kCoRRmOHTMXJh2J/gm12K0j1WmU+n8vZ
         dLaAsPHn+Ap8XW0t9r1GsWGhuZBDmVVTukgbT9VZuByZHZEISz5mzQCTHN0UwL5bmfRe
         GE+A==
X-Gm-Message-State: AGi0PubX992WnDGfBdIt2BLebVKpbsOgjymMfr/hu3mxoLrBGMEFn1Ww
        GC1AO/g77XYsdd3HRgCkZYnPgizA4GFn8e1Cm/MvV+YrF8Y/vKhsnPOomjesOU7essChEI936iN
        4KnQvVsuM3FyVgoftJA5i+oYM
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr3054039wmj.12.1587020261872;
        Wed, 15 Apr 2020 23:57:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLcX3QC2WncwF4NGEdkVuDQGtURORK48xnIkC+nAChhunufhb36n/EIPEUsxuE3fYlqHZD3/Q==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr3054020wmj.12.1587020261568;
        Wed, 15 Apr 2020 23:57:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m1sm21075803wro.64.2020.04.15.23.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:57:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>
Cc:     Jon Doron <arilou@gmail.com>, Roman Kagan <rvkagan@yandex-team.ru>,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86/kvm/hyper-v: Add support to SYNIC exit on EOM
In-Reply-To: <20200409163745.573547-2-arilou@gmail.com>
References: <20200409163745.573547-1-arilou@gmail.com> <20200409163745.573547-2-arilou@gmail.com>
Date:   Thu, 16 Apr 2020 08:57:39 +0200
Message-ID: <87d087x6ho.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> According to the TLFS a write to the EOM register by the guest
> causes the hypervisor to scan for any pending messages and if there
> are any it will try to deliver them.
>
> To do this we must exit so any pending messages can be written.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

Roman says he's still with us so let's Cc: him.

> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/hyperv.c           | 65 +++++++++++++++++++++++++++++----
>  arch/x86/kvm/hyperv.h           |  1 +
>  arch/x86/kvm/x86.c              |  5 +++
>  include/uapi/linux/kvm.h        |  1 +
>  5 files changed, 65 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 42a2d0d3984a..048a1db488e2 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -548,6 +548,7 @@ struct kvm_vcpu_hv_synic {
>  	DECLARE_BITMAP(vec_bitmap, 256);
>  	bool active;
>  	bool dont_zero_synic_pages;
> +	bool enable_eom_exit;
>  };
>  
>  /* Hyper-V per vcpu emulation context */
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index bcefa9d4e57e..7432f67b2746 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -186,6 +186,49 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
>  	srcu_read_unlock(&kvm->irq_srcu, idx);
>  }
>  
> +static int synic_read_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
> +			  struct hv_message_header *msg)

I'd suggest to rename this to 'synic_read_msg_hdr()' as we don't
actually read the message here, just the header.

> +{
> +	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
> +	int msg_off = offsetof(struct hv_message_page, sint_message[sint]);
> +	gfn_t msg_page_gfn;
> +	int r;
> +
> +	if (!(synic->msg_page & HV_SYNIC_SIMP_ENABLE))
> +		return -ENOENT;
> +
> +	msg_page_gfn = synic->msg_page >> PAGE_SHIFT;
> +
> +	r = kvm_vcpu_read_guest_page(vcpu, msg_page_gfn, msg, msg_off,
> +				     sizeof(*msg));
> +	if (r < 0)
> +		return r;
> +
> +	return 0;
> +}
> +
> +static bool synic_should_exit_for_eom(struct kvm_vcpu_hv_synic *synic)

'for_eom' or 'on_eom'?

> +{
> +	int i;
> +
> +	if (!synic->enable_eom_exit)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
> +		struct hv_message_header hv_hdr;
> +		/* If we failed to read from the msg slot then we treat this
> +		 * msg slot as free */

Coding style: multi-line comments should look like
  /*
   * line1
   * line2
   * ...
   */

> +		if (synic_read_msg(synic, i, &hv_hdr) < 0)
> +			continue;
> +
> +		/* See if this msg slot has a pending message */
> +		if (hv_hdr.message_flags.msg_pending == 1)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
>  {
>  	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
> @@ -254,6 +297,9 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
>  
>  		for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
>  			kvm_hv_notify_acked_sint(vcpu, i);
> +
> +		if (!host && synic_should_exit_for_eom(synic))
> +			synic_exit(synic, msr);

Generally, message communication is not performance critical, however,
we have synthetic timers and in case the new KVM_CAP_HYPERV_SYNIC_EOM
cap is enabled we will be exiting to userspace for every timer
expiration. This will measurably slow down the guest I'm afraid.

Would it be possible to come up with an interface for userspace to tell
KVM that it has a pending message for the guest and only exit to
userspace in this case? Or maybe we need to queue all messages from
userspace in KVM and deliver them when we get a chance and not exit to
userspace at all?

>  		break;
>  	}
>  	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
> @@ -571,8 +617,9 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
>  	struct hv_message_header hv_hdr;
>  	int r;
>  
> -	if (!(synic->msg_page & HV_SYNIC_SIMP_ENABLE))
> -		return -ENOENT;
> +	r = synic_read_msg(synic, sint, &hv_hdr);
> +	if (r < 0)
> +		return r;
>  
>  	msg_page_gfn = synic->msg_page >> PAGE_SHIFT;
>  
> @@ -582,12 +629,6 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
>  	 * is only called in vcpu context so the entire update is atomic from
>  	 * guest POV and thus the exact order here doesn't matter.
>  	 */
> -	r = kvm_vcpu_read_guest_page(vcpu, msg_page_gfn, &hv_hdr.message_type,
> -				     msg_off + offsetof(struct hv_message,
> -							header.message_type),
> -				     sizeof(hv_hdr.message_type));
> -	if (r < 0)
> -		return r;
>  
>  	if (hv_hdr.message_type != HVMSG_NONE) {
>  		if (no_retry)
> @@ -785,6 +826,14 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
>  	return 0;
>  }
>  
> +int kvm_hv_synic_enable_eom(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
> +
> +	synic->enable_eom_exit = true;
> +	return 0;
> +}
> +
>  static bool kvm_hv_msr_partition_wide(u32 msr)
>  {
>  	bool r = false;
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 757cb578101c..ff89f0ff103c 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -56,6 +56,7 @@ void kvm_hv_irq_routing_update(struct kvm *kvm);
>  int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vcpu_id, u32 sint);
>  void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector);
>  int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages);
> +int kvm_hv_synic_enable_eom(struct kvm_vcpu *vcpu);
>  
>  void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
>  void kvm_hv_vcpu_postcreate(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 027dfd278a97..0def4ab31dc1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3350,6 +3350,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_HYPERV_SPIN:
>  	case KVM_CAP_HYPERV_SYNIC:
>  	case KVM_CAP_HYPERV_SYNIC2:
> +	case KVM_CAP_HYPERV_SYNIC_EOM:
>  	case KVM_CAP_HYPERV_VP_INDEX:
>  	case KVM_CAP_HYPERV_EVENTFD:
>  	case KVM_CAP_HYPERV_TLBFLUSH:
> @@ -4209,6 +4210,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  		return -EINVAL;
>  
>  	switch (cap->cap) {
> +	case KVM_CAP_HYPERV_SYNIC_EOM:
> +		kvm_hv_synic_enable_eom(vcpu);
> +		return 0;
> +
>  	case KVM_CAP_HYPERV_SYNIC2:
>  		if (cap->args[0])
>  			return -EINVAL;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 428c7dde6b4b..78172ad156d8 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1017,6 +1017,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_VCPU_RESETS 179
>  #define KVM_CAP_S390_PROTECTED 180
>  #define KVM_CAP_PPC_SECURE_GUEST 181
> +#define KVM_CAP_HYPERV_SYNIC_EOM 182
>  
>  #ifdef KVM_CAP_IRQ_ROUTING

-- 
Vitaly

