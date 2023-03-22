Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038D06C5345
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Mar 2023 19:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCVSI1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Mar 2023 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVSI0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Mar 2023 14:08:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5EEC5F;
        Wed, 22 Mar 2023 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679508506; x=1711044506;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=O11Y0CG8yuz3Da/mUeLcxz/NEho14L5fzyH0HQnchsM=;
  b=A3HA7MMcaEWZnPOxbsx6TZ2scvZXOJgzngbU1qhMB/dM1UNvOalkqjQr
   YNZ/0R+CBkHMRsxItIL6vLnee7IYAEXSlBfhK+kiZr043il7rTlxVkr3r
   4iU9zK4/8JqzGbnDEFNHQNtjcU2SKzvyvr4bXA6LDsXjhc+AOpauhQQti
   W++TOAoPkQh9TDtReRkXVB5XD8JMx9+94lhfwmb+c9ErE6ar6r6W28HXV
   +Cf+uI4XRlctdK0K0fbLe6sDoYLurzTtZSok6gRFsSkGoslGWlabPfeSB
   UfyRnhTHLfjW0F5EWQ8slDVWGR3A/anjPshsKYfuHGZMFtulrLpn39g8z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339331846"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="339331846"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 11:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792677529"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792677529"
Received: from mtfreder-mobl1.amr.corp.intel.com (HELO [10.209.35.23]) ([10.209.35.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 11:07:30 -0700
Message-ID: <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com>
Date:   Wed, 22 Mar 2023 11:07:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Content-Language: en-US
To:     Michael Kelley <mikelley@microsoft.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/27/23 10:46, Michael Kelley wrote:
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 766ffe3..9f668d2 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -211,6 +211,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
>  #ifdef CONFIG_X86_MCE_THRESHOLD
>  	sum += irq_stats(cpu)->irq_threshold_count;
>  #endif
> +#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
> +	sum += irq_stats(cpu)->irq_hv_callback_count;
> +#endif
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	sum += irq_stats(cpu)->irq_hv_reenlightenment_count;
> +	sum += irq_stats(cpu)->hyperv_stimer0_count;
> +#endif
>  #ifdef CONFIG_X86_MCE
>  	sum += per_cpu(mce_exception_count, cpu);
>  	sum += per_cpu(mce_poll_count, cpu);

This seems fine, especially since arch_show_interrupts() has them.  But,
what's with the "#if IS_ENABLED" versus the plain #ifdef?  Is there some
difference I'm missing?  Why not just be consistent with the other code
and use a plain #ifdef for both?
