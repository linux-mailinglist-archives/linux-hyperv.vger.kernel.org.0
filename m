Return-Path: <linux-hyperv+bounces-211-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2B17ABEAF
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 09:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 906522852AE
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4264C469E;
	Sat, 23 Sep 2023 07:58:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44E375;
	Sat, 23 Sep 2023 07:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C6BC433C8;
	Sat, 23 Sep 2023 07:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695455927;
	bh=Ijh7USVyCy8OB6+AzeKdkPsYF66NC4GSUfQEKgKYTvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+qYPdg+tAiRoIe73SG1cFIi9CDIxIvz7tWOvjyvJLX0inuMCIdhqquAec7ze81VT
	 in/3GB4Q6PGeYXz3Cis2UWZH3tA2npiYhqeU2ElQdjq2J7sWD+NGCQCbrRfjM+ZK9j
	 ph2epph/TfJYavdBfMVeD/aVfnGXJvTs3PAvksxI=
Date: Sat, 23 Sep 2023 09:58:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	haiyangz@microsoft.com, decui@microsoft.com,
	apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
	ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
	stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023092342-staunch-chafe-1598@gregkh>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Sep 22, 2023 at 11:38:35AM -0700, Nuno Das Neves wrote:
> +static int mshv_vtl_get_vsm_regs(void)
> +{
> +	struct hv_register_assoc registers[2];
> +	union hv_input_vtl input_vtl;
> +	int ret, count = 2;
> +
> +	input_vtl.as_uint8 = 0;
> +	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> +	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
> +
> +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       count, input_vtl, registers);
> +	if (ret)
> +		return ret;
> +
> +	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
> +	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
> +
> +	pr_debug("%s: VSM code page offsets: %#016llx\n", __func__,
> +		 mshv_vsm_page_offsets.as_uint64);
> +	pr_info("%s: VSM capabilities: %#016llx\n", __func__,
> +		mshv_vsm_capabilities.as_uint64);

When drivers are working properly, they are quiet.  This is very noisy
and probably is leaking memory addresses to userspace?

Also, there is NEVER a need for __func__ in a pr_debug() line, it has
that for you automatically.

Also, drivers should never call pr_*() calls, always use the proper
dev_*() calls instead.



> +
> +	return ret;
> +}
> +
> +static int mshv_vtl_configure_vsm_partition(void)
> +{
> +	union hv_register_vsm_partition_config config;
> +	struct hv_register_assoc reg_assoc;
> +	union hv_input_vtl input_vtl;
> +
> +	config.as_u64 = 0;
> +	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
> +	config.enable_vtl_protection = 1;
> +	config.zero_memory_on_reset = 1;
> +	config.intercept_vp_startup = 1;
> +	config.intercept_cpuid_unimplemented = 1;
> +
> +	if (mshv_vsm_capabilities.intercept_page_available) {
> +		pr_debug("%s: using intercept page", __func__);

Again, __func__ is not needed, you are providing it twice here for no
real reason except to waste storage space :)

> +		config.intercept_page = 1;
> +	}
> +
> +	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
> +	reg_assoc.value.reg64 = config.as_u64;
> +	input_vtl.as_uint8 = 0;
> +
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       1, input_vtl, &reg_assoc);


None of this needs to be unwound if initialization fails later on?

thanks,

greg k-h

