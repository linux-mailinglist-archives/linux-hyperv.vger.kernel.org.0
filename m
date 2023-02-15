Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE386980FE
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Feb 2023 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBOQgD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Feb 2023 11:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBOQgB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Feb 2023 11:36:01 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A28613432B;
        Wed, 15 Feb 2023 08:35:59 -0800 (PST)
Received: from [10.156.156.87] (unknown [167.220.238.87])
        by linux.microsoft.com (Postfix) with ESMTPSA id 74E9420F9E11;
        Wed, 15 Feb 2023 08:35:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74E9420F9E11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676478959;
        bh=nomOdbPeDhEzigXCEi71x3qLQ63ZFTaVqUa/cGDkask=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FGAhZ7kFkmVIhH8hZ3OpbAfwBSjcPNPME/+AojzNwyoTvAofgamGSQMIjgoGedWDF
         qUE27d9gCIe139zE4cQrO0NR7uv8lfSQn9h+aG3kT5RKDCgMFSuBdtQ05OuLxW6/gZ
         CWFuBC130ymFeouVROLoviKVbeP/ArCA6ZEbYfYE=
Subject: Re: [PATCH] x86/hyperv: Fix hv_get/set_register for nested bringup
To:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, mikelley@microsoft.com, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
References: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Message-ID: <45ca8d38-34f4-2d17-bcd6-f62c1b7f0c3a@linux.microsoft.com>
Date:   Wed, 15 Feb 2023 22:05:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-20.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The patch looks good to me, apart from the comments from Wei regarding 
styling.

On 2/13/2023 7:58 PM, Wei Liu wrote:
> A few comments on style.
>
> On Thu, Feb 09, 2023 at 02:02:52PM -0800, Nuno Das Neves wrote:
>> hv_get_nested_reg only translates SINT0, resulting in the wrong sint
>> being registered by nested vmbus.
> Please put a blank line between paragraphs.
>
>> Fix the issue with new utility function hv_is_sint_reg.
>> While at it, improve clarity of hv_set_non_nested_register and hv_is_synic_reg.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>   arch/x86/include/asm/mshyperv.h | 11 +++++++----
>>   arch/x86/kernel/cpu/mshyperv.c  |  8 ++++----
>>   2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 9ae1a344536b..684c547c1cca 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -225,10 +225,13 @@ extern bool hv_isolation_type_snp(void);
>>   
>>   static inline bool hv_is_synic_reg(unsigned int reg)
>>   {
>> -	if ((reg >= HV_REGISTER_SCONTROL) &&
>> -	    (reg <= HV_REGISTER_SINT15))
>> -		return true;
>> -	return false;
>> +	return (reg >= HV_REGISTER_SCONTROL) &&
>> +	       (reg <= HV_REGISTER_SINT15);
>> +}
> Please put a new line here.
>
> I can fix these issues too if you don't end up sending a new version due
> to other issues.
>
> Jinank, please take a look. The code looks sensible to me, but I would
> like you to have a look too.
>
> Thanks,
> Wei.
>
>> +static inline bool hv_is_sint_reg(unsigned int reg)
>> +{
>> +	return (reg >= HV_REGISTER_SINT0) &&
>> +	       (reg <= HV_REGISTER_SINT15);
>>   }
>>   
>>   u64 hv_get_register(unsigned int reg);
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 0ceb6d1f9c3c..6bd344e1200f 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -44,6 +44,9 @@ struct ms_hyperv_info ms_hyperv;
>>   #if IS_ENABLED(CONFIG_HYPERV)
>>   static inline unsigned int hv_get_nested_reg(unsigned int reg)
>>   {
>> +	if (hv_is_sint_reg(reg))
>> +		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
>> +
>>   	switch (reg) {
>>   	case HV_REGISTER_SIMP:
>>   		return HV_REGISTER_NESTED_SIMP;
>> @@ -53,8 +56,6 @@ static inline unsigned int hv_get_nested_reg(unsigned int reg)
>>   		return HV_REGISTER_NESTED_SVERSION;
>>   	case HV_REGISTER_SCONTROL:
>>   		return HV_REGISTER_NESTED_SCONTROL;
>> -	case HV_REGISTER_SINT0:
>> -		return HV_REGISTER_NESTED_SINT0;
>>   	case HV_REGISTER_EOM:
>>   		return HV_REGISTER_NESTED_EOM;
>>   	default:
>> @@ -80,8 +81,7 @@ void hv_set_non_nested_register(unsigned int reg, u64 value)
>>   		hv_ghcb_msr_write(reg, value);
>>   
>>   		/* Write proxy bit via wrmsl instruction */
>> -		if (reg >= HV_REGISTER_SINT0 &&
>> -		    reg <= HV_REGISTER_SINT15)
>> +		if (hv_is_sint_reg(reg))
>>   			wrmsrl(reg, value | 1 << 20);
>>   	} else {
>>   		wrmsrl(reg, value);
>> -- 
>> 2.25.1

Reviewed-by: Jinank Jain <jinankjain@linux.microsoft.com>

