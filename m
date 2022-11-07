Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9D61F0B3
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Nov 2022 11:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiKGKdR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Nov 2022 05:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKGKdQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Nov 2022 05:33:16 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D62E114D2E;
        Mon,  7 Nov 2022 02:33:15 -0800 (PST)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id A27B320B9F80;
        Mon,  7 Nov 2022 02:33:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A27B320B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667817195;
        bh=k/T4pj655McnOOHIQH8DpxpkliaejtrrKHgE9Dz2KOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gcd4LD0jo97lKi22wAFh4K78fw8ft2d+gshAFBSxRRh0DnUHlHCyq2rsRId6HZc07
         9loLIz0Y1FFoLsHYhib5/TM24W+62kZKUdFS8vi4dzZNIZkADHR5g0oSub149otgPr
         FsuBsQ6/afS7xN15yF3E0GwPTLfBTLU69+f9L4ik=
Date:   Mon, 7 Nov 2022 16:03:07 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2] x86/Hyper-V: Expand definition of struct
 hv_vp_assist_page
Message-ID: <Y2je48OwQaRTkci+@anrayabh-desk>
References: <1667587123-31645-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667587123-31645-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 04, 2022 at 11:38:43AM -0700, Saurabh Sengar wrote:
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
> [v2]: Corrected vtl_entry_reson size from u8 to u32
> 
>  arch/x86/include/asm/hyperv-tlfs.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 3089ec3..6d9368e 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -374,11 +374,20 @@ struct hv_nested_enlightenments_control {
>  struct hv_vp_assist_page {
>  	__u32 apic_assist;
>  	__u32 reserved1;
> -	__u64 vtl_control[3];
> +	__u32 vtl_entry_reason;
> +	__u32 vtl_reserved;
> +	__u64 vtl_ret_x64rax;
> +	__u64 vtl_ret_x64rcx;
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
> 1.8.3.1

Reviewed-by: <anrayabh@linux.microsoft.com>

