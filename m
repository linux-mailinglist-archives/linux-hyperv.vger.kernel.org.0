Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657186B83C5
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Mar 2023 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCMVLr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Mar 2023 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMVLq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Mar 2023 17:11:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDDC886DF8;
        Mon, 13 Mar 2023 14:11:14 -0700 (PDT)
Received: from [192.168.0.5] (unknown [71.212.161.12])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0174C2045E4A;
        Mon, 13 Mar 2023 14:11:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0174C2045E4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678741871;
        bh=jDI63RO8/Qe9KM27TKj95SQWyy4ztEvlrXPrUwPsifM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kN02oTvFAsqJSmCKWK1RTKDKuK64x3l10bcQ3O6GyQ2nUW72XxwnOE/MDKZJ9tZDN
         ahd7DPhGbiJXizwPr+hy72F5j1gzraS8ztOFhF4oZT5zfUXg9L+o4NLGQst5hNabz2
         JDyJrpfa++BouZP7fbNKM1YuUYM3bI6Fzv4cA/Ek=
Message-ID: <e777ad2e-0bad-3a04-b831-ebd07edb7fc3@linux.microsoft.com>
Date:   Mon, 13 Mar 2023 14:11:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <1678223570-25242-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BYAPR21MB16889A9D76888A485D7BB19FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <BYAPR21MB16889A9D76888A485D7BB19FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 3/10/2023 11:30 AM, Michael Kelley (LINUX) wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, March 7, 2023 1:13 PM
>>
>> In x86 hyperv-tlfs, HV_REGISTER_ prefix is used to indicate MSRs
>> accessed via rdmsrl/wrmsrl. But in ARM64, HV_REGISTER_ instead indicates
>> VP registers accessed via get/set vp registers hypercall.
>>
>> This is due to HV_REGISTER_* names being used by hv_set/get_register,
>> with the arch-specific version delegating to the appropriate mechanism.
>>
>> The problem is, using prefix HV_REGISTER_ for MSRs will conflict with
>> VP registers when they are introduced for x86 in future.
>>
>> This patch solves the issue by:
>>
>> 1. Defining all the x86 MSRs with a consistent prefix: HV_X64_MSR_.
>>    This is so HV_REGISTER_ can be reserved for VP registers.
>>
>> 2. Change the non-arch-specific alias used by hv_set/get_register to
>>    HV_SYNTHETIC_REG.
> 
> I definitely messed this up when I first did the ARM64 support a
> few years back.  :-(    This is a necessary fix.
> 
> What about keeping HV_REGISTER_ as the prefix for the architecture
> independent alias, and creating a new prefix for the Hyper-V register
> definition?  This would allow the existing hv_get/set_register()
> invocations to remain unchanged, and eliminates the code churn
> in the arch independent code.
>> The HV_X64_MSR_ prefix is definitely good for the MSR addresses,
> especially since a lot of definitions that are x86/x64 only are still in use.
> Then perhaps use HV_HYP_REG_ or something similar for the Hyper-V
> register definition.

This could work.

Ideally, we would use HV_REGISTER_ for the vp registers as it's a direct match
to the name in HyperV e.g. HvRegisterVpIndex-> HV_REGISTER_VP_INDEX

However if you think it's better to reduce churn and go with a different
name then that's fine by me.

HV_HYP_REG_ is ok, though maybe HV_VP_REG_ is a bit more informative?
"VP_REG" indicating it's relevant to HVCALL_GET/SET_VP_REGISTERS.

> 
> If you don't like that suggestion, I wonder if the HV_SYNTHETIC_REG_
> prefix could be shortened to help avoid line length problems.  Maybe
> HV_SYNREG_ or HV_SYN_REG_ ?
>>>
>> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>> ---
>>  arch/arm64/include/asm/hyperv-tlfs.h |  25 +++++
>>  arch/x86/include/asm/hyperv-tlfs.h   | 137 +++++++++++++--------------
>>  arch/x86/include/asm/mshyperv.h      |   8 +-
>>  arch/x86/kernel/cpu/mshyperv.c       |  22 ++---
>>  drivers/clocksource/hyperv_timer.c   |  24 ++---
>>  drivers/hv/hv.c                      |  32 +++----
>>  drivers/hv/hv_common.c               |   4 +-
>>  drivers/hv/vmbus_drv.c               |  14 +--
>>  include/asm-generic/mshyperv.h       |   2 +-
>>  9 files changed, 146 insertions(+), 122 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-
>> tlfs.h
>> index bc6c7ac934a1..474025eb3d7e 100644
>> --- a/arch/arm64/include/asm/hyperv-tlfs.h
>> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
>> @@ -64,6 +64,31 @@
>>  #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
>>  #define HV_REGISTER_STIMER0_COUNT	0x000B0001
>>
>> +/*
>> + * To support non-arch-specific code calling hv_set/get_register:
>> + * - On x86, HV_SYNTHETIC_REG_ indicates an MSR accessed via rdmsrl/wrmsrl
>> + * - On ARM, HV_SYNTHETIC_REG_ indicates a VP register accessed via hypercall
> 
> Nit:  Let's use the full "ARM64" instead of just "ARM" here so that there's no
> confusion about whether 32-bit ARM is supported.
> 

Good point

>> + */
>> +#define HV_SYNTHETIC_REG_VP_INDEX		(HV_REGISTER_VP_INDEX)
>> +#define HV_SYNTHETIC_REG_TIME_REF_COUNT
>> 	(HV_REGISTER_TIME_REF_COUNT)
>> +#define HV_SYNTHETIC_REG_REFERENCE_TSC
>> 	(HV_REGISTER_REFERENCE_TSC)
>> +
>> +#define HV_SYNTHETIC_REG_STIMER0_CONFIG
>> 	(HV_REGISTER_STIMER0_CONFIG)
>> +#define HV_SYNTHETIC_REG_STIMER0_COUNT
>> 	(HV_REGISTER_STIMER0_COUNT)
>> +
>> +#define HV_SYNTHETIC_REG_SCONTROL		(HV_REGISTER_SCONTROL)
>> +#define HV_SYNTHETIC_REG_SIEFP			(HV_REGISTER_SIEFP)
>> +#define HV_SYNTHETIC_REG_SIMP			(HV_REGISTER_SIMP)
>> +#define HV_SYNTHETIC_REG_EOM			(HV_REGISTER_EOM)
>> +#define HV_SYNTHETIC_REG_SINT0			(HV_REGISTER_SINT0)
>> +
>> +#define HV_SYNTHETIC_REG_CRASH_P0		(HV_REGISTER_CRASH_P0)
>> +#define HV_SYNTHETIC_REG_CRASH_P1		(HV_REGISTER_CRASH_P1)
>> +#define HV_SYNTHETIC_REG_CRASH_P2		(HV_REGISTER_CRASH_P2)
>> +#define HV_SYNTHETIC_REG_CRASH_P3		(HV_REGISTER_CRASH_P3)
>> +#define HV_SYNTHETIC_REG_CRASH_P4		(HV_REGISTER_CRASH_P4)
>> +#define HV_SYNTHETIC_REG_CRASH_CTL		(HV_REGISTER_CRASH_CTL)
>> +
>>  union hv_msi_entry {
>>  	u64 as_uint64[2];
>>  	struct {
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 566ac26239ba..0dbb0218d0fa 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -178,7 +178,7 @@ enum hv_isolation_type {
>>  #define HV_X64_MSR_HYPERCALL			0x40000001
>>
>>  /* MSR used to provide vcpu index */
>> -#define HV_REGISTER_VP_INDEX			0x40000002
>> +#define HV_X64_MSR_VP_INDEX			0x40000002
>>
>>  /* MSR used to reset the guest OS. */
>>  #define HV_X64_MSR_RESET			0x40000003
>> @@ -187,10 +187,10 @@ enum hv_isolation_type {
>>  #define HV_X64_MSR_VP_RUNTIME			0x40000010
>>
>>  /* MSR used to read the per-partition time reference counter */
>> -#define HV_REGISTER_TIME_REF_COUNT		0x40000020
>> +#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
>>
>>  /* A partition's reference time stamp counter (TSC) page */
>> -#define HV_REGISTER_REFERENCE_TSC		0x40000021
>> +#define HV_X64_MSR_REFERENCE_TSC		0x40000021
>>
>>  /* MSR used to retrieve the TSC frequency */
>>  #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
>> @@ -205,61 +205,61 @@ enum hv_isolation_type {
>>  #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
>>
>>  /* Define synthetic interrupt controller model specific registers. */
>> -#define HV_REGISTER_SCONTROL			0x40000080
>> -#define HV_REGISTER_SVERSION			0x40000081
>> -#define HV_REGISTER_SIEFP			0x40000082
>> -#define HV_REGISTER_SIMP			0x40000083
>> -#define HV_REGISTER_EOM				0x40000084
>> -#define HV_REGISTER_SINT0			0x40000090
>> -#define HV_REGISTER_SINT1			0x40000091
>> -#define HV_REGISTER_SINT2			0x40000092
>> -#define HV_REGISTER_SINT3			0x40000093
>> -#define HV_REGISTER_SINT4			0x40000094
>> -#define HV_REGISTER_SINT5			0x40000095
>> -#define HV_REGISTER_SINT6			0x40000096
>> -#define HV_REGISTER_SINT7			0x40000097
>> -#define HV_REGISTER_SINT8			0x40000098
>> -#define HV_REGISTER_SINT9			0x40000099
>> -#define HV_REGISTER_SINT10			0x4000009A
>> -#define HV_REGISTER_SINT11			0x4000009B
>> -#define HV_REGISTER_SINT12			0x4000009C
>> -#define HV_REGISTER_SINT13			0x4000009D
>> -#define HV_REGISTER_SINT14			0x4000009E
>> -#define HV_REGISTER_SINT15			0x4000009F
>> +#define HV_X64_MSR_SCONTROL			0x40000080
>> +#define HV_X64_MSR_SVERSION			0x40000081
>> +#define HV_X64_MSR_SIEFP			0x40000082
>> +#define HV_X64_MSR_SIMP				0x40000083
>> +#define HV_X64_MSR_EOM				0x40000084
>> +#define HV_X64_MSR_SINT0			0x40000090
>> +#define HV_X64_MSR_SINT1			0x40000091
>> +#define HV_X64_MSR_SINT2			0x40000092
>> +#define HV_X64_MSR_SINT3			0x40000093
>> +#define HV_X64_MSR_SINT4			0x40000094
>> +#define HV_X64_MSR_SINT5			0x40000095
>> +#define HV_X64_MSR_SINT6			0x40000096
>> +#define HV_X64_MSR_SINT7			0x40000097
>> +#define HV_X64_MSR_SINT8			0x40000098
>> +#define HV_X64_MSR_SINT9			0x40000099
>> +#define HV_X64_MSR_SINT10			0x4000009A
>> +#define HV_X64_MSR_SINT11			0x4000009B
>> +#define HV_X64_MSR_SINT12			0x4000009C
>> +#define HV_X64_MSR_SINT13			0x4000009D
>> +#define HV_X64_MSR_SINT14			0x4000009E
>> +#define HV_X64_MSR_SINT15			0x4000009F
>>
>>  /*
>>   * Define synthetic interrupt controller model specific registers for
>>   * nested hypervisor.
>>   */
>> -#define HV_REGISTER_NESTED_SCONTROL            0x40001080
>> -#define HV_REGISTER_NESTED_SVERSION            0x40001081
>> -#define HV_REGISTER_NESTED_SIEFP               0x40001082
>> -#define HV_REGISTER_NESTED_SIMP                0x40001083
>> -#define HV_REGISTER_NESTED_EOM                 0x40001084
>> -#define HV_REGISTER_NESTED_SINT0               0x40001090
>> +#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
>> +#define HV_X64_MSR_NESTED_SVERSION		0x40001081
>> +#define HV_X64_MSR_NESTED_SIEFP			0x40001082
>> +#define HV_X64_MSR_NESTED_SIMP			0x40001083
>> +#define HV_X64_MSR_NESTED_EOM			0x40001084
>> +#define HV_X64_MSR_NESTED_SINT0			0x40001090
>>
>>  /*
>>   * Synthetic Timer MSRs. Four timers per vcpu.
>>   */
>> -#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
>> -#define HV_REGISTER_STIMER0_COUNT		0x400000B1
>> -#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
>> -#define HV_REGISTER_STIMER1_COUNT		0x400000B3
>> -#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
>> -#define HV_REGISTER_STIMER2_COUNT		0x400000B5
>> -#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
>> -#define HV_REGISTER_STIMER3_COUNT		0x400000B7
>> +#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
>> +#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
>> +#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
>> +#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
>> +#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
>> +#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
>> +#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
>> +#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
>>
>>  /* Hyper-V guest idle MSR */
>>  #define HV_X64_MSR_GUEST_IDLE			0x400000F0
>>
>>  /* Hyper-V guest crash notification MSR's */
>> -#define HV_REGISTER_CRASH_P0			0x40000100
>> -#define HV_REGISTER_CRASH_P1			0x40000101
>> -#define HV_REGISTER_CRASH_P2			0x40000102
>> -#define HV_REGISTER_CRASH_P3			0x40000103
>> -#define HV_REGISTER_CRASH_P4			0x40000104
>> -#define HV_REGISTER_CRASH_CTL			0x40000105
>> +#define HV_X64_MSR_CRASH_P0			0x40000100
>> +#define HV_X64_MSR_CRASH_P1			0x40000101
>> +#define HV_X64_MSR_CRASH_P2			0x40000102
>> +#define HV_X64_MSR_CRASH_P3			0x40000103
>> +#define HV_X64_MSR_CRASH_P4			0x40000104
>> +#define HV_X64_MSR_CRASH_CTL			0x40000105
>>
>>  /* TSC emulation after migration */
>>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
>> @@ -269,31 +269,30 @@ enum hv_isolation_type {
>>  /* TSC invariant control */
>>  #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
>>
>> -/* Register name aliases for temporary compatibility */
>> -#define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
>> -#define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
>> -#define HV_X64_MSR_STIMER1_COUNT	HV_REGISTER_STIMER1_COUNT
>> -#define HV_X64_MSR_STIMER1_CONFIG	HV_REGISTER_STIMER1_CONFIG
>> -#define HV_X64_MSR_STIMER2_COUNT	HV_REGISTER_STIMER2_COUNT
>> -#define HV_X64_MSR_STIMER2_CONFIG	HV_REGISTER_STIMER2_CONFIG
>> -#define HV_X64_MSR_STIMER3_COUNT	HV_REGISTER_STIMER3_COUNT
>> -#define HV_X64_MSR_STIMER3_CONFIG	HV_REGISTER_STIMER3_CONFIG
>> -#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
>> -#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
>> -#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
>> -#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
>> -#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
>> -#define HV_X64_MSR_EOM			HV_REGISTER_EOM
>> -#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
>> -#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
>> -#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
>> -#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
>> -#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
>> -#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
>> -#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
>> -#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
>> -#define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
>> -#define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
>> +/*
>> + * To support non-arch-specific code calling hv_set/get_register:
>> + * - On x86, HV_SYNTHETIC_REG_ indicates an MSR accessed via rdmsrl/wrmsrl
>> + * - On ARM, HV_SYNTHETIC_REG_ indicates a VP register accessed via hypercall
> 
> Same here:  "ARM64" instead of "ARM".
> 

Will do

>> + */
>> +#define HV_SYNTHETIC_REG_VP_INDEX		(HV_X64_MSR_VP_INDEX)
>> +#define HV_SYNTHETIC_REG_TIME_REF_COUNT
>> 	(HV_X64_MSR_TIME_REF_COUNT)
>> +#define HV_SYNTHETIC_REG_REFERENCE_TSC
>> 	(HV_X64_MSR_REFERENCE_TSC)
>> +
>> +#define HV_SYNTHETIC_REG_STIMER0_CONFIG
>> 	(HV_X64_MSR_STIMER0_CONFIG)
>> +#define HV_SYNTHETIC_REG_STIMER0_COUNT
>> 	(HV_X64_MSR_STIMER0_COUNT)
>> +
>> +#define HV_SYNTHETIC_REG_SCONTROL		(HV_X64_MSR_SCONTROL)
>> +#define HV_SYNTHETIC_REG_SIEFP			(HV_X64_MSR_SIEFP)
>> +#define HV_SYNTHETIC_REG_SIMP			(HV_X64_MSR_SIMP)
>> +#define HV_SYNTHETIC_REG_EOM			(HV_X64_MSR_EOM)
>> +#define HV_SYNTHETIC_REG_SINT0			(HV_X64_MSR_SINT0)
>> +
>> +#define HV_SYNTHETIC_REG_CRASH_P0		(HV_X64_MSR_CRASH_P0)
>> +#define HV_SYNTHETIC_REG_CRASH_P1		(HV_X64_MSR_CRASH_P1)
>> +#define HV_SYNTHETIC_REG_CRASH_P2		(HV_X64_MSR_CRASH_P2)
>> +#define HV_SYNTHETIC_REG_CRASH_P3		(HV_X64_MSR_CRASH_P3)
>> +#define HV_SYNTHETIC_REG_CRASH_P4		(HV_X64_MSR_CRASH_P4)
>> +#define HV_SYNTHETIC_REG_CRASH_CTL		(HV_X64_MSR_CRASH_CTL)
>>
>>  /* Hyper-V memory host visibility */
>>  enum hv_mem_host_visibility {
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 4c4c0ec3b62e..1afa77ab9a04 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -224,14 +224,14 @@ extern bool hv_isolation_type_snp(void);
>>
>>  static inline bool hv_is_synic_reg(unsigned int reg)
> 
> Should this function name be changed to hv_is_synic_msr() since
> it is based on MSR values and not register values?  Argument
> name should probably also be "msr", not "reg" to avoid
> any confusion.
> 

If we keep the generic prefix as HV_REGISTER, then I suppose it should remain
hv_is_synic_reg.

>>  {
>> -	return (reg >= HV_REGISTER_SCONTROL) &&
>> -	       (reg <= HV_REGISTER_SINT15);
>> +	return (reg >= HV_X64_MSR_SCONTROL) &&
>> +	       (reg <= HV_X64_MSR_SINT15);
>>  }
>>
>>  static inline bool hv_is_sint_reg(unsigned int reg)
> 
> Same here.
> 
>>  {
>> -	return (reg >= HV_REGISTER_SINT0) &&
>> -	       (reg <= HV_REGISTER_SINT15);
>> +	return (reg >= HV_X64_MSR_SINT0) &&
>> +	       (reg <= HV_X64_MSR_SINT15);
>>  }
>>
>>  u64 hv_get_register(unsigned int reg);
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index f924a76c6923..7140ee32d7be 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -45,19 +45,19 @@ struct ms_hyperv_info ms_hyperv;
>>  static inline unsigned int hv_get_nested_reg(unsigned int reg)
> 
> Same here.
> 

If we keep the generic prefix as HV_REGISTER, then I suppose it should remain
hv_get_nested_reg.

>>  {
>>  	if (hv_is_sint_reg(reg))
>> -		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
>> +		return reg - HV_X64_MSR_SINT0 + HV_X64_MSR_NESTED_SINT0;
>>
>>  	switch (reg) {
>> -	case HV_REGISTER_SIMP:
>> -		return HV_REGISTER_NESTED_SIMP;
>> -	case HV_REGISTER_SIEFP:
>> -		return HV_REGISTER_NESTED_SIEFP;
>> -	case HV_REGISTER_SVERSION:
>> -		return HV_REGISTER_NESTED_SVERSION;
>> -	case HV_REGISTER_SCONTROL:
>> -		return HV_REGISTER_NESTED_SCONTROL;
>> -	case HV_REGISTER_EOM:
>> -		return HV_REGISTER_NESTED_EOM;
>> +	case HV_X64_MSR_SIMP:
>> +		return HV_X64_MSR_NESTED_SIMP;
>> +	case HV_X64_MSR_SIEFP:
>> +		return HV_X64_MSR_NESTED_SIEFP;
>> +	case HV_X64_MSR_SVERSION:
>> +		return HV_X64_MSR_NESTED_SVERSION;
>> +	case HV_X64_MSR_SCONTROL:
>> +		return HV_X64_MSR_NESTED_SCONTROL;
>> +	case HV_X64_MSR_EOM:
>> +		return HV_X64_MSR_NESTED_EOM;
>>  	default:
>>  		return reg;
>>  	}
>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>> index c0cef92b12b8..0ab3fbca34c7 100644
>> --- a/drivers/clocksource/hyperv_timer.c
>> +++ b/drivers/clocksource/hyperv_timer.c
>> @@ -81,14 +81,14 @@ static int hv_ce_set_next_event(unsigned long delta,
>>
>>  	current_tick = hv_read_reference_counter();
>>  	current_tick += delta;
>> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
>> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_COUNT, current_tick);
>>  	return 0;
>>  }
>>
>>  static int hv_ce_shutdown(struct clock_event_device *evt)
>>  {
>> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
>> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
>> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_COUNT, 0);
>> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_CONFIG, 0);
>>  	if (direct_mode_enabled && stimer0_irq >= 0)
>>  		disable_percpu_irq(stimer0_irq);
>>
>> @@ -119,7 +119,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
>>  		timer_cfg.direct_mode = 0;
>>  		timer_cfg.sintx = stimer0_message_sint;
>>  	}
>> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG, timer_cfg.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_CONFIG, timer_cfg.as_uint64);
>>  	return 0;
>>  }
>>
>> @@ -387,7 +387,7 @@ static u64 notrace read_hv_clock_tsc(void)
>>  	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
>>
>>  	if (current_tick == U64_MAX)
>> -		current_tick = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
>> +		current_tick = hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
>>
>>  	return current_tick;
>>  }
>> @@ -408,9 +408,9 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
>>  	union hv_reference_tsc_msr tsc_msr;
>>
>>  	/* Disable the TSC page */
>> -	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>> +	tsc_msr.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
>>  	tsc_msr.enable = 0;
>> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
>>  }
>>
>>
>> @@ -419,10 +419,10 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>>  	union hv_reference_tsc_msr tsc_msr;
>>
>>  	/* Re-enable the TSC page */
>> -	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>> +	tsc_msr.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
>>  	tsc_msr.enable = 1;
>>  	tsc_msr.pfn = tsc_pfn;
>> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
>>  }
>>
>>  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>> @@ -456,7 +456,7 @@ static u64 notrace read_hv_clock_msr(void)
>>  	 * is set to 0 when the partition is created and is incremented in
>>  	 * 100 nanosecond units.
>>  	 */
>> -	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
>> +	return hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
>>  }
>>
>>  static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
>> @@ -543,14 +543,14 @@ static bool __init hv_init_tsc_clocksource(void)
>>  	 * thus TSC clocksource will work even without the real TSC page
>>  	 * mapped.
>>  	 */
>> -	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>> +	tsc_msr.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
>>  	if (hv_root_partition)
>>  		tsc_pfn = tsc_msr.pfn;
>>  	else
>>  		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
>>  	tsc_msr.enable = 1;
>>  	tsc_msr.pfn = tsc_pfn;
>> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
>>
>>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
>>
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index 8b0dd8e5244d..319f21205a9c 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -213,7 +213,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>>  	union hv_synic_scontrol sctrl;
>>
>>  	/* Setup the Synic's message page */
>> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>> +	simp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIMP);
>>  	simp.simp_enabled = 1;
>>
>>  	if (hv_isolation_type_snp() || hv_root_partition) {
>> @@ -227,10 +227,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>>  			>> HV_HYP_PAGE_SHIFT;
>>  	}
>>
>> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_SIMP, simp.as_uint64);
>>
>>  	/* Setup the Synic's event page */
>> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>> +	siefp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIEFP);
>>  	siefp.siefp_enabled = 1;
>>
>>  	if (hv_isolation_type_snp() || hv_root_partition) {
>> @@ -245,12 +245,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>>  			>> HV_HYP_PAGE_SHIFT;
>>  	}
>>
>> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_SIEFP, siefp.as_uint64);
>>
>>  	/* Setup the shared SINT. */
>>  	if (vmbus_irq != -1)
>>  		enable_percpu_irq(vmbus_irq, 0);
>> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
>> +	shared_sint.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SINT0 +
>>  					VMBUS_MESSAGE_SINT);
>>
>>  	shared_sint.vector = vmbus_interrupt;
>> @@ -266,14 +266,14 @@ void hv_synic_enable_regs(unsigned int cpu)
>>  #else
>>  	shared_sint.auto_eoi = 0;
>>  #endif
>> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>> +	hv_set_register(HV_SYNTHETIC_REG_SINT0 + VMBUS_MESSAGE_SINT,
>>  				shared_sint.as_uint64);
>>
>>  	/* Enable the global synic bit */
>> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
>> +	sctrl.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SCONTROL);
>>  	sctrl.enable = 1;
>>
>> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_SCONTROL, sctrl.as_uint64);
>>  }
>>
>>  int hv_synic_init(unsigned int cpu)
>> @@ -297,17 +297,17 @@ void hv_synic_disable_regs(unsigned int cpu)
>>  	union hv_synic_siefp siefp;
>>  	union hv_synic_scontrol sctrl;
>>
>> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
>> +	shared_sint.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SINT0 +
>>  					VMBUS_MESSAGE_SINT);
>>
>>  	shared_sint.masked = 1;
>>
>>  	/* Need to correctly cleanup in the case of SMP!!! */
>>  	/* Disable the interrupt */
>> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>> +	hv_set_register(HV_SYNTHETIC_REG_SINT0 + VMBUS_MESSAGE_SINT,
>>  				shared_sint.as_uint64);
>>
>> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>> +	simp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIMP);
>>  	/*
>>  	 * In Isolation VM, sim and sief pages are allocated by
>>  	 * paravisor. These pages also will be used by kdump
>> @@ -322,9 +322,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>>  		simp.base_simp_gpa = 0;
>>  	}
>>
>> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_SIMP, simp.as_uint64);
>>
>> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>> +	siefp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIEFP);
>>  	siefp.siefp_enabled = 0;
>>
>>  	if (hv_isolation_type_snp() || hv_root_partition) {
>> @@ -334,12 +334,12 @@ void hv_synic_disable_regs(unsigned int cpu)
>>  		siefp.base_siefp_gpa = 0;
>>  	}
>>
>> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_SIEFP, siefp.as_uint64);
>>
>>  	/* Disable the global synic bit */
>> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
>> +	sctrl.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SCONTROL);
>>  	sctrl.enable = 0;
>> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>> +	hv_set_register(HV_SYNTHETIC_REG_SCONTROL, sctrl.as_uint64);
>>
>>  	if (vmbus_irq != -1)
>>  		disable_percpu_irq(vmbus_irq);
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 52a6f89ccdbd..77a68f16bc6e 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -142,7 +142,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>  		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
>>  	}
>>
>> -	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
>> +	msr_vp_index = hv_get_register(HV_SYNTHETIC_REG_VP_INDEX);
>>
>>  	hv_vp_index[cpu] = msr_vp_index;
>>
>> @@ -246,7 +246,7 @@ EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>>   */
>>  static u64 __hv_read_ref_counter(void)
>>  {
>> -	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
>> +	return hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
>>  }
>>
>>  u64 (*hv_read_reference_counter)(void) = __hv_read_ref_counter;
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 1901556efe79..9ca8a7b73b81 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1405,17 +1405,17 @@ static void hv_kmsg_dump(struct kmsg_dumper
>> *dumper,
>>  	 * contain the size of the panic data in that page. Rest of the
>>  	 * registers are no-op when the NOTIFY_MSG flag is set.
>>  	 */
>> -	hv_set_register(HV_REGISTER_CRASH_P0, 0);
>> -	hv_set_register(HV_REGISTER_CRASH_P1, 0);
>> -	hv_set_register(HV_REGISTER_CRASH_P2, 0);
>> -	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
>> -	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
>> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P0, 0);
>> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P1, 0);
>> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P2, 0);
>> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P3,
>> virt_to_phys(hv_panic_page));
>> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P4, bytes_written);
>>
>>  	/*
>>  	 * Let Hyper-V know there is crash data available along with
>>  	 * the panic message.
>>  	 */
>> -	hv_set_register(HV_REGISTER_CRASH_CTL,
>> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_CTL,
>>  	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
>>  }
>>
>> @@ -1555,7 +1555,7 @@ static int vmbus_bus_init(void)
>>  		 * Register for panic kmsg callback only if the right
>>  		 * capability is supported by the hypervisor.
>>  		 */
>> -		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
>> +		hyperv_crash_ctl = hv_get_register(HV_SYNTHETIC_REG_CRASH_CTL);
>>  		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
>>  			hv_kmsg_dump_register();
>>
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 8845a2eca339..76bf968d77a8 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -147,7 +147,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg,
>> u32 old_msg_type)
>>  		 * possibly deliver another msg from the
>>  		 * hypervisor
>>  		 */
>> -		hv_set_register(HV_REGISTER_EOM, 0);
>> +		hv_set_register(HV_SYNTHETIC_REG_EOM, 0);
>>  	}
>>  }
>>
>> --
>> 2.25.1

