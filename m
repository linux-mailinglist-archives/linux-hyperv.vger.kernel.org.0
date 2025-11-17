Return-Path: <linux-hyperv+bounces-7659-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A7C669B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 00:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A34E067A
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 23:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030532570F;
	Mon, 17 Nov 2025 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UnwPV8mA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC247322520;
	Mon, 17 Nov 2025 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423933; cv=none; b=rFuc1dzi6Vh0M0q5QfDRTwgD4IeOk5jx77Ow/yD29bChjiZrsQmwfOhoyaR4we1GVmqRl6jUUek9TQlr2B9ZVeOUpXUdbfLQT537gYVHXr6p5jDovqIZgJrCTTGPBI4coi/xPhunxYzWbuhCt3a8Ba9t+ILtbSUNBbl3acvr6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423933; c=relaxed/simple;
	bh=BQ73Od/P/55p19hBQWtBu97sJB0ge0NL4kSR7NPswQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBWe4f10MZbCVID/dQt5o5L0CjLW2q6XhftPg7gw13phrjbLcX4HzQMuAeEebd3vvkDvgi3+WtL0DKKLWu/N68ohBeMOy25X53ijJcwSpVlohiPVQHbTyaXfz7IXI5i8EwN72c5CtHb2NYy+7YR+TFFmX+26pWVLmF+lRzR3/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UnwPV8mA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95B3B2013355;
	Mon, 17 Nov 2025 15:58:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95B3B2013355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763423929;
	bh=boCn+fUA0W8b50+6vT2qAqruaDAj88lWYKrh44E63bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnwPV8mAiAODTvAzg7mtiKTxCqYcgFuAae8Z4/mvuVVJ1Y0XrpZqOoN7R8OqtlsqB
	 nFKZcitlTwRRVIdJXNaKYCVulAEbXF9BjN7mK5BpPpAnnOFrhQlzHSkPtNtzPG6ThN
	 tLe5TP+baTysqqTieh9pd05U9dTQAtfGnIqm7tcI=
Date: Mon, 17 Nov 2025 15:58:48 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	muislam@microsoft.com, anrayabh@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH v4] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <aRu2uC4VVazB_SfV@skinsburskii.localdomain>
References: <1762903194-25195-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762903194-25195-1-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Nov 11, 2025 at 03:19:54PM -0800, Nuno Das Neves wrote:
> From: Muminul Islam <muislam@microsoft.com>
> 
> The existing mshv create partition ioctl does not provide a way to
> specify which cpu features are enabled in the guest. Instead, it
> attempts to enable all features and those that are not supported are
> silently disabled by the hypervisor.
> 
> This was done to reduce unnecessary complexity and is sufficient for
> many cases. However, new scenarios require fine-grained control over
> these features.
> 
> Define a new mshv_create_partition_v2 structure which supports
> passing the disabled processor and xsave feature bits through to the
> create partition hypercall directly.
> 
> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
> the new structure. If unset, the original mshv_create_partition struct
> is used, with the old behavior of enabling all features.
> 
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changes in v4:
> - Change BIT() to BIT_ULL() [Michael Kelley]
> - Enforce pt_num_cpu_fbanks == MSHV_NUM_CPU_FEATURES_BANKS and expect
>   that number to never change. In future, additional processor banks
>   will be settable as 'early' partition properties. Remove redundant
>   code that set default values for unspecified banks [Michael Kelley]
> - Set xsave features to 0 on arm64 [Michael Kelley]
> - Add clarifying comments in a few places
> 
> Changes in v3:
> - Remove the new cpu features definitions in hvhdk.h, and retain the
>   old behavior of enabling all features for the old struct. For the v2
>   struct, still disable unspecified feature banks, since that makes it
>   robust to future extensions.
> - Amend comments and commit message to reflect the above
> - Fix unused variable on arm64 [kernel test robot]
> 
> Changes in v2:
> - Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
> - Fix compilation issue on arm64 [kernel test robot]
> ---
>  drivers/hv/mshv_root_main.c | 113 +++++++++++++++++++++++++++++-------
>  include/uapi/linux/mshv.h   |  34 +++++++++++
>  2 files changed, 126 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index d542a0143bb8..9f9438289b60 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1900,43 +1900,114 @@ add_partition(struct mshv_partition *partition)
>  	return 0;
>  }
>  
> -static long
> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS ==
> +	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
> +
> +static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
> +					struct hv_partition_creation_properties *cr_props,
> +					union hv_partition_isolation_properties *isol_props)
>  {
> -	struct mshv_create_partition args;
> -	u64 creation_flags;
> -	struct hv_partition_creation_properties creation_properties = {};
> -	union hv_partition_isolation_properties isolation_properties = {};
> -	struct mshv_partition *partition;
> -	struct file *file;
> -	int fd;
> -	long ret;
> +	int i;
> +	struct mshv_create_partition_v2 args;
> +	union hv_partition_processor_features *disabled_procs;
> +	union hv_partition_processor_xsave_features *disabled_xsave;
>  
> -	if (copy_from_user(&args, user_arg, sizeof(args)))
> +	/* First, copy v1 struct in case user is on previous versions */
> +	if (copy_from_user(&args, user_arg,
> +			   sizeof(struct mshv_create_partition)))
>  		return -EFAULT;
>  
>  	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
>  	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
>  		return -EINVAL;
>  
> +	disabled_procs = &cr_props->disabled_processor_features;
> +	disabled_xsave = &cr_props->disabled_processor_xsave_features;
> +
> +	/* Check if user provided newer struct with feature fields */
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
> +		if (copy_from_user(&args, user_arg, sizeof(args)))
> +			return -EFAULT;
> +
> +		if (args.pt_num_cpu_fbanks != MSHV_NUM_CPU_FEATURES_BANKS ||
> +		    mshv_field_nonzero(args, pt_rsvd) ||
> +		    mshv_field_nonzero(args, pt_rsvd1))
> +			return -EINVAL;
> +
> +		/*
> +		 * Note this assumes MSHV_NUM_CPU_FEATURES_BANKS will never
> +		 * change and equals HV_PARTITION_PROCESSOR_FEATURES_BANKS
> +		 * (i.e. 2).
> +		 *
> +		 * Further banks (index >= 2) will be modifiable as 'early'
> +		 * properties via the set partition property hypercall.
> +		 */
> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +		disabled_xsave->as_uint64 = args.pt_disabled_xsave;
> +#else
> +		/*
> +		 * In practice this field is ignored on arm64, but safer to
> +		 * zero it in case it is ever used.
> +		 */
> +		disabled_xsave->as_uint64 = 0;

Why not explicitly treat non-zero value as invalid here instead?
Isn't it always better than implicitly (and silently) zeroing it?

> +
> +		if (mshv_field_nonzero(args, pt_rsvd2))
> +			return -EINVAL;
> +#endif
> +	} else {
> +		/*
> +		 * v1 behavior: try to enable everything. The hypervisor will
> +		 * disable features that are not supported. The banks can be
> +		 * queried via the get partition property hypercall.
> +		 */
> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +			disabled_procs->as_uint64[i] = 0;
> +
> +		disabled_xsave->as_uint64 = 0;
> +	}
> +
>  	/* Only support EXO partitions */
> -	creation_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
> -			 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
> +	*pt_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
> +		    HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
> +
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_LAPIC))
> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_X2APIC))
> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_GPA_SUPER_PAGES))
> +		*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
>  
> -	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
> -		creation_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
> -	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
> -		creation_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
> -	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
> -		creation_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
> +	isol_props->as_uint64 = 0;

These properties are missing the nested one.
I'd recommend squeezing that change in this patch

Thanks,
Stanislav

>  
>  	switch (args.pt_isolation) {
>  	case MSHV_PT_ISOLATION_NONE:
> -		isolation_properties.isolation_type =
> -			HV_PARTITION_ISOLATION_TYPE_NONE;
> +		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
>  		break;
>  	}
>  
> +	return 0;
> +}
> +
> +static long
> +mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
> +{
> +	u64 creation_flags;
> +	struct hv_partition_creation_properties creation_properties;
> +	union hv_partition_isolation_properties isolation_properties;
> +	struct mshv_partition *partition;
> +	struct file *file;
> +	int fd;
> +	long ret;
> +
> +	ret = mshv_ioctl_process_pt_flags(user_arg, &creation_flags,
> +					  &creation_properties,
> +					  &isolation_properties);
> +	if (ret)
> +		return ret;
> +
>  	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
>  	if (!partition)
>  		return -ENOMEM;
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 876bfe4e4227..cf904f3aa201 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -26,6 +26,7 @@ enum {
>  	MSHV_PT_BIT_LAPIC,
>  	MSHV_PT_BIT_X2APIC,
>  	MSHV_PT_BIT_GPA_SUPER_PAGES,
> +	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
>  	MSHV_PT_BIT_COUNT,
>  };
>  
> @@ -41,6 +42,8 @@ enum {
>   * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
>   * @pt_isolation: MSHV_PT_ISOLATION_*
>   *
> + * This is the initial/v1 version for backward compatibility.
> + *
>   * Returns a file descriptor to act as a handle to a guest partition.
>   * At this point the partition is not yet initialized in the hypervisor.
>   * Some operations must be done with the partition in this state, e.g. setting
> @@ -52,6 +55,37 @@ struct mshv_create_partition {
>  	__u64 pt_isolation;
>  };
>  
> +#define MSHV_NUM_CPU_FEATURES_BANKS 2
> +
> +/**
> + * struct mshv_create_partition_v2
> + *
> + * This is extended version of the above initial MSHV_CREATE_PARTITION
> + * ioctl and allows for following additional parameters:
> + *
> + * @pt_num_cpu_fbanks: Must be set to MSHV_NUM_CPU_FEATURES_BANKS.
> + * @pt_cpu_fbanks: Disabled processor feature banks array.
> + * @pt_disabled_xsave: Disabled xsave feature bits.
> + *
> + * pt_cpu_fbanks and pt_disabled_xsave are passed through as-is to the create
> + * partition hypercall.
> + *
> + * Returns : same as above original mshv_create_partition
> + */
> +struct mshv_create_partition_v2 {
> +	__u64 pt_flags;
> +	__u64 pt_isolation;
> +	__u16 pt_num_cpu_fbanks;
> +	__u8  pt_rsvd[6];		/* MBZ */
> +	__u64 pt_cpu_fbanks[MSHV_NUM_CPU_FEATURES_BANKS];
> +	__u64 pt_rsvd1[2];		/* MBZ */
> +#if defined(__x86_64__)
> +	__u64 pt_disabled_xsave;
> +#else
> +	__u64 pt_rsvd2;			/* MBZ */
> +#endif
> +} __packed;
> +
>  /* /dev/mshv */
>  #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
>  
> -- 
> 2.34.1

