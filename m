Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A85BD546
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Sep 2022 21:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiISTkZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Sep 2022 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISTkY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Sep 2022 15:40:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4427040561;
        Mon, 19 Sep 2022 12:40:22 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42F7A2058EE3;
        Mon, 19 Sep 2022 12:40:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42F7A2058EE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663616421;
        bh=/WIWG7S6KNjk8wJWKkT0USaT8zrYtO8L6yg/Q32VY8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bts77QXA7BIrksUVQUovqbWAmFI3bpzKeiU2AbO0s5K6L2ituJwwTMAded8eQr+Zg
         U2XMFQzI0S3yMf2Xm7JH7Q2h/6jmFucuASrd5IGlY2eBEHD7LdV8SLUmc3blUxNHfv
         Zw8NEVv5cRyYHdohuwnSgem5YW3ZGTzKZCUTqI2c=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     wei.liu@kernel.org
Cc:     decui@microsoft.com, eahariha@linux.microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        sthemmin@microsoft.com, vkuznets@redhat.com
Subject: Re: [PATCH v2 1/2] hv: Use PCI_VENDOR_ID_MICROSOFT for better discoverability
Date:   Mon, 19 Sep 2022 12:39:52 -0700
Message-Id: <1663616392-11897-1-git-send-email-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Yx9H+semY705LUkB@liuwe-devbox-debian-v2>
References: <Yx9H+semY705LUkB@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Mon, 12 Sep 2022, Wei Liu wrote:

> On Fri, Sep 09, 2022 at 11:50:24AM -0700, Easwar Hariharan wrote:
>> From: Easwar Hariharan <easwar.hariharan@microsoft.com>
>>
>> Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
>
>> ---
>>  drivers/hv/vmbus_drv.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 3c833ea..6b77a53 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -39,6 +39,8 @@
>>  #include <clocksource/hyperv_timer.h>
>>  #include "hyperv_vmbus.h"
>>
>> +#define PCI_VENDOR_ID_MICROSOFT 0x1414
>> +
>
> There is a patch in hyperv-fixes that puts this definition to a proper
> header. You can wait for that to land and rebase this patch.
>
> In the future when you send out a series, please chain all the patches
> to a cover letter.

Hi Wei,

This patch is already rebased on hyperv/fixes in response to Vitaly's 
pointer in this thread: 
https://lore.kernel.org/lkml/87leqsr6im.fsf@redhat.com

I'll pull in the pci_ids.h inclusion if that's more acceptable.

Thanks,
Easwar

>> --
>> 1.8.3.1
>>
>
