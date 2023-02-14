Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A17697097
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Feb 2023 23:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjBNWR6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Feb 2023 17:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjBNWR5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:57 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CF854EDC;
        Tue, 14 Feb 2023 14:17:54 -0800 (PST)
Received: from [192.168.0.5] (unknown [71.212.161.12])
        by linux.microsoft.com (Postfix) with ESMTPSA id 56EF720C8B1C;
        Tue, 14 Feb 2023 14:17:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56EF720C8B1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676413073;
        bh=ryZDpDmOU/WupxdHJb2WUUHVsmFljdKTMhBbzruNJjE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kd+9k8douoZ1y9eqmZkQwaGbYNhmvDt0o1MvO70YNQ0oqVHUy/RdkaBHeW2Y7LsXS
         q8CCh8bCcSP7rALXJ0n6UPbbybx7qds2Iiqa//L47OPmV6nIXzXYdL+daHH/a+tNmi
         kMnbfIZr3ih0YbQTy8VREhzvuEaSFN9NwRZjbTwI=
Message-ID: <8d0b36c0-dfca-6d4b-076d-033f9ccda4c7@linux.microsoft.com>
Date:   Tue, 14 Feb 2023 14:17:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] x86/hyperv: Fix hv_get/set_register for nested bringup
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, jinankjain@linux.microsoft.com,
        mikelley@microsoft.com, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
References: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
Content-Language: en-US
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/13/2023 6:28 AM, Wei Liu wrote:
> A few comments on style.
> 
> On Thu, Feb 09, 2023 at 02:02:52PM -0800, Nuno Das Neves wrote:
>> hv_get_nested_reg only translates SINT0, resulting in the wrong sint
>> being registered by nested vmbus.
> 
> Please put a blank line between paragraphs.
> 

Ok

>> Fix the issue with new utility function hv_is_sint_reg.
>> While at it, improve clarity of hv_set_non_nested_register and hv_is_synic_reg.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/x86/include/asm/mshyperv.h | 11 +++++++----
>>  arch/x86/kernel/cpu/mshyperv.c  |  8 ++++----
>>  2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 9ae1a344536b..684c547c1cca 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -225,10 +225,13 @@ extern bool hv_isolation_type_snp(void);
>>  
>>  static inline bool hv_is_synic_reg(unsigned int reg)
>>  {
>> -	if ((reg >= HV_REGISTER_SCONTROL) &&
>> -	    (reg <= HV_REGISTER_SINT15))
>> -		return true;
>> -	return false;
>> +	return (reg >= HV_REGISTER_SCONTROL) &&
>> +	       (reg <= HV_REGISTER_SINT15);
>> +}
> 
> Please put a new line here.
> 

Ok

> I can fix these issues too if you don't end up sending a new version due
> to other issues.
> 
> Jinank, please take a look. The code looks sensible to me, but I would
> like you to have a look too.
> 

I'll wait for Jinank to take a look before posting another version...

