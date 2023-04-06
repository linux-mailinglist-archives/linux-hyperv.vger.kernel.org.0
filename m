Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641BC6D8F16
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjDFGL0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Apr 2023 02:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFGLZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Apr 2023 02:11:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F0577AA6;
        Wed,  5 Apr 2023 23:11:24 -0700 (PDT)
Received: from [10.156.156.87] (unknown [167.220.238.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id 55373210DEFE;
        Wed,  5 Apr 2023 23:11:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55373210DEFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680761483;
        bh=ezHWNn7n387QVTk8qA/7+6tmpBJrUdIWMn5BsSB4Rfc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kizOPtsSEfmhjfyYE/LRhkxpKxpUYiH50s2GFISVPlIbUaC6f0LM5W6sAshQu57Ff
         4EHQL2HORqxfiy+Y/9mbVMQleoj8tPW5sb+m9bqvtPvbwDr496LS5o+j8Lz2RtDCZY
         VlA30pH1mVnhDQtVTezWL6FlqAQzHTCMxJy+m204=
Message-ID: <c0b2454c-3945-debf-f991-79139413f370@linux.microsoft.com>
Date:   Thu, 6 Apr 2023 11:41:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nunodasneves@linux.microsoft.com
References: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
 <ZC4BlSo0D1uNliFk@liuwe-devbox-debian-v2>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
In-Reply-To: <ZC4BlSo0D1uNliFk@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This was observed while testing pass-through PCI devices on the nested 
MSHV setup.

Regards,

Jinank

On 4/6/2023 4:47 AM, Wei Liu wrote:
> On Tue, Apr 04, 2023 at 11:35:46AM +0000, Jinank Jain wrote:
>> In case of nested MSHV, retargeting interrupt hypercall should be sent
>> to L0 hypervisor instead of L1 hypervisor.
>>
>> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> While I think this is a sensible change -- how did you discover this?
> Can you provide a bit more information?
>
>> ---
>>   drivers/pci/controller/pci-hyperv.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index f33370b75628..2123f632ecf7 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -704,8 +704,14 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>>   		}
>>   	}
>>   
>> -	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
>> -			      params, NULL);
>> +	if (hv_nested)
>> +		res = hv_do_nested_hypercall(HVCALL_RETARGET_INTERRUPT |
>> +					     (var_size << 17),
>> +					     params, NULL);
>> +	else
>> +		res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT |
>> +				      (var_size << 17),
>> +				      params, NULL);
>>   
>>   exit_unlock:
>>   	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
>> -- 
>> 2.34.1
>>
