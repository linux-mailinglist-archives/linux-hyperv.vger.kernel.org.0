Return-Path: <linux-hyperv+bounces-1091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5347FB30B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5DB1C20BB0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449B14A97;
	Tue, 28 Nov 2023 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiZd/QDp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916A183
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701157446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtKgFk3CHBTEPt7gp/Kob8Ku/rlWDYksUTZDpLhR1S0=;
	b=fiZd/QDptuM5MGhjozWDM83wF6y3kYPtWaWgIb8ondEsHTavyhEiClhD57Q73Vi94Kp4SV
	3l1lyklC33xjVSa6YAZWMi0dMaCV9nH9tb5UqXSgTcuyKBXgfD8zECpfOWjDkRvWHR/dxm
	FXIwNKKntyXnJzfnYhRhhJJNCjvAstM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-IyE1F4QrMmGgGj5rILIEfw-1; Tue, 28 Nov 2023 02:44:04 -0500
X-MC-Unique: IyE1F4QrMmGgGj5rILIEfw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33309619b52so407766f8f.1
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157443; x=1701762243;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtKgFk3CHBTEPt7gp/Kob8Ku/rlWDYksUTZDpLhR1S0=;
        b=Y8iOiOM/wDZmyLtVVszI5R15+dIj05zHRcaG7b+R+ztpJMsWF+2qS+p0BNpfQLTsn3
         45QVubSz8KRmTy3VWCgnu+oO3D6oVnc73oSCZnmYjHd8/WqVzWopIXik/EH71iTsPglV
         3tpSRb/1HDOekERftjnRes3f8+Q3/IA2hDleWPi6Qw0x/tHI2OlcHebe/v717hgzatW8
         hWk9n0MAqNYErpeN3KfGcmlP7yvbwWBj1WsgGw7dPtS5Jbh2EGRb9fThqp3af0fs1uK9
         TDZWNT9/syXup7CBBvUiJmAnju0MdNbD/m36EH7epUfSXy2V/Esc1b/0ZBewtzcdK9Kc
         NZcw==
X-Gm-Message-State: AOJu0YzzPnkq34oI+YvblqlHcunYXlV8fSMEDif379jyopqs8pptfoK6
	L7v7xDn4c08SIaxqsA8kRqBZ21OV4R8HAp7n61DyyRB2gnC9BmcrCQ+crmmcZBld/lGqilYjazK
	JUBGNHIcnleVHkk9rRemCCst2
X-Received: by 2002:adf:f88d:0:b0:332:e9ff:7fad with SMTP id u13-20020adff88d000000b00332e9ff7fadmr10210250wrp.12.1701157443563;
        Mon, 27 Nov 2023 23:44:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSrzOfVFXXaYd5bwOlRnKvmus8guyrTlPsH/3Zw/WlyXTEMG/LN54CkOejsPqYFMufXdBSmw==
X-Received: by 2002:adf:f88d:0:b0:332:e9ff:7fad with SMTP id u13-20020adff88d000000b00332e9ff7fadmr10210233wrp.12.1701157443271;
        Mon, 27 Nov 2023 23:44:03 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d6c65000000b00332f6202b82sm8573153wrz.9.2023.11.27.23.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:44:02 -0800 (PST)
Message-ID: <4f3d9563a4246a97eae28486eee1730d134b222b.camel@redhat.com>
Subject: Re: [RFC 26/33] KVM: x86: hyper-vsm: Allow setting per-VTL memory
 attributes
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
 anelkz@amazon.com,  graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
 corbert@lwn.net,  kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:44:00 +0200
In-Reply-To: <20231108111806.92604-27-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-27-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> Introduce KVM_SET_MEMORY_ATTRIBUTES ioctl support for VTL KVM devices.
> The attributes are stored in an xarray private to the VTL device.
> 
> The following memory attributes are supported:
>  - KVM_MEMORY_ATTRIBUTE_READ
>  - KVM_MEMORY_ATTRIBUTE_WRITE
>  - KVM_MEMORY_ATTRIBUTE_EXECUTE
>  - KVM_MEMORY_ATTRIBUTE_NO_ACCESS
> Although only some combinations are valid, see code comment below.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/hyperv.c | 61 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 0d8402dba596..bcace0258af1 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -62,6 +62,10 @@
>   */
>  #define HV_EXT_CALL_MAX (HV_EXT_CALL_QUERY_CAPABILITIES + 64)
>  
> +#define KVM_HV_VTL_ATTRS						\
> +	(KVM_MEMORY_ATTRIBUTE_READ | KVM_MEMORY_ATTRIBUTE_WRITE |	\
> +	 KVM_MEMORY_ATTRIBUTE_EXECUTE | KVM_MEMORY_ATTRIBUTE_NO_ACCESS)
> +
>  static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
>  				bool vcpu_kick);
>  
> @@ -3025,6 +3029,7 @@ int kvm_vm_ioctl_get_hv_vsm_state(struct kvm *kvm, struct kvm_hv_vsm_state *stat
>  
>  struct kvm_hv_vtl_dev {
>  	int vtl;
> +	struct xarray mem_attrs;
>  };
>  
>  static int kvm_hv_vtl_get_attr(struct kvm_device *dev,
> @@ -3047,16 +3052,71 @@ static void kvm_hv_vtl_release(struct kvm_device *dev)
>  {
>  	struct kvm_hv_vtl_dev *vtl_dev = dev->private;
>  
> +	xa_destroy(&vtl_dev->mem_attrs);
>  	kfree(vtl_dev);
>  	kfree(dev); /* alloc by kvm_ioctl_create_device, free by .release */
>  }
>  
> +/*
> + * The TLFS lists the valid memory protection combinations (15.9.3):
> + *  - No access
> + *  - Read-only, no execute
> + *  - Read-only, execute
> + *  - Read/write, no execute
> + *  - Read/write, execute
> + */
> +static bool kvm_hv_validate_vtl_mem_attributes(struct kvm_memory_attributes *attrs)
> +{
> +	u64 attr = attrs->attributes;
> +
> +	if (attr & ~KVM_HV_VTL_ATTRS)
> +		return false;
> +
> +	if (attr == KVM_MEMORY_ATTRIBUTE_NO_ACCESS)
> +		return true;
> +
> +	if (!(attr & KVM_MEMORY_ATTRIBUTE_READ))
> +		return false;
> +
> +	return true;
> +}
> +
> +static long kvm_hv_vtl_ioctl(struct kvm_device *dev, unsigned int ioctl,
> +			     unsigned long arg)
> +{
> +	switch (ioctl) {
> +	case KVM_SET_MEMORY_ATTRIBUTES: {
> +		struct kvm_hv_vtl_dev *vtl_dev = dev->private;
> +		struct kvm_memory_attributes attrs;
> +		int r;
> +
> +		if (copy_from_user(&attrs, (void __user *)arg, sizeof(attrs)))
> +			return -EFAULT;
> +
> +		r = -EINVAL;
> +		if (!kvm_hv_validate_vtl_mem_attributes(&attrs))
> +			return r;
> +
> +		r = kvm_ioctl_set_mem_attributes(dev->kvm, &vtl_dev->mem_attrs,
> +						 KVM_HV_VTL_ATTRS, &attrs);
> +		if (r)
> +			return r;
> +		break;
> +	}
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	return 0;
> +}
> +
>  static int kvm_hv_vtl_create(struct kvm_device *dev, u32 type);
>  
>  static struct kvm_device_ops kvm_hv_vtl_ops = {
>  	.name = "kvm-hv-vtl",
>  	.create = kvm_hv_vtl_create,
>  	.release = kvm_hv_vtl_release,
> +	.ioctl = kvm_hv_vtl_ioctl,
>  	.get_attr = kvm_hv_vtl_get_attr,
>  };
>  
> @@ -3076,6 +3136,7 @@ static int kvm_hv_vtl_create(struct kvm_device *dev, u32 type)
>  			vtl++;
>  
>  	vtl_dev->vtl = vtl;
> +	xa_init(&vtl_dev->mem_attrs);
>  	dev->private = vtl_dev;
>  
>  	return 0;

It makes sense, but hopefully we won't need it if we adopt the VM per VTL approach.

Best regards,
	Maxim Levitsky




