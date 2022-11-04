Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDDD6191AD
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 08:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKDHRI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDHRH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 03:17:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 393C527B22;
        Fri,  4 Nov 2022 00:17:06 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 74FC520B929F;
        Fri,  4 Nov 2022 00:17:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74FC520B929F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667546225;
        bh=gUsw9l1YgzwD8/vdmQ6V2u48HygOiqCRw+PBW96+Iok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjS+NTKqeOEP+QFMydBJpHpxc9rKu3jECpcQMxRS0tEXCB+JeJelMp6v65ci+HGbb
         R8cYjIN3lQv8BbWtaKGsyeUKBjGOddhZI+Q7cyuIma1bems0LD5xWQS4Q78wJq67fB
         lkYrqQl/zFs6No3eKHQz4JrBsi80inzycGkqZGww=
Date:   Fri, 4 Nov 2022 12:46:57 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH] x86/Hyper-V: Expand definition of struct
 hv_vp_assist_page
Message-ID: <Y2S8aT7ltuqcHGVN@anrayabh-desk>
References: <1667537814-15939-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667537814-15939-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 03, 2022 at 09:56:54PM -0700, Saurabh Sengar wrote:
> The struct hv_vp_assist_page has 24 bytes which is defined as u64[3],
> expand that to expose vtl_entry_reason, vtl_ret_x64rax and vtl_ret_x64rcx
> field. vtl_entry_reason is updated by hypervisor for the entry reason as
> to why the VTL was entered on the virtual processor.
> Guest updates the vtl_ret_* fields to provide the register values to
> restore on VTL return. The specific register values that are restored
> which will be updated on vtl_ret_x64rax and vtl_ret_x64rcx.
> Also added the missing fields for synthetic_time_unhalted_timer_expired,
> virtualization_fault_information and intercept_message.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index f769b9db4630..b3d0f42853d2 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -377,11 +377,20 @@ struct hv_nested_enlightenments_control {
>  struct hv_vp_assist_page {
>  	__u32 apic_assist;
>  	__u32 reserved1;
> -	__u64 vtl_control[3];
> +	__u8  vtl_entry_reason;

This is defined as an enum in the TLFS [1]. We should do the same.
And since the TLFS defines it as an enum it is a 32 bit value and
not a u8.

> +	__u8  vtl_reserved[7];
> +	__u64 vtl_ret_x64rax;
> +	__u64 vtl_ret_x64rcx;

The TLFS groups the above VTL related fields into a struct
HV_VP_VTL_CONTROL. Any reason to not do the same?

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vp_vtl_control

Thanks,
Anirudh.

>  	struct hv_nested_enlightenments_control nested_control;
>  	__u8 enlighten_vmentry;
>  	__u8 reserved2[7];
>  	__u64 current_nested_vmcs;
> +	__u8 synthetic_time_unhalted_timer_expired;
> +	__u8 reserved3[7];
> +	__u8 virtualization_fault_information[40];
> +	__u8 reserved4[8];
> +	__u8 intercept_message[256];
> +	__u8 vtl_ret_actions[256];
>  } __packed;
>  
>  struct hv_enlightened_vmcs {
> -- 
> 2.34.1
