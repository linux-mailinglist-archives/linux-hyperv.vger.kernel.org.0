Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE5761B43
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jul 2023 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGYOUw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjGYOUt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0229269F;
        Tue, 25 Jul 2023 07:19:06 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9JtW2y40ztRbF;
        Tue, 25 Jul 2023 22:14:11 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 22:17:24 +0800
Subject: Re: [PATCH -next] hv: hyperv.h: Remove unused extern declaration
 vmbus_ontimer()
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230725135834.1732-1-yuehaibing@huawei.com>
 <SN6PR2101MB1693201F3C3FD2BCDD0843B3D703A@SN6PR2101MB1693.namprd21.prod.outlook.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <03317f44-3c5f-e221-6fb7-41b5fcfa700d@huawei.com>
Date:   Tue, 25 Jul 2023 22:17:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <SN6PR2101MB1693201F3C3FD2BCDD0843B3D703A@SN6PR2101MB1693.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2023/7/25 22:12, Michael Kelley (LINUX) wrote:
> From: YueHaibing <yuehaibing@huawei.com> Sent: Tuesday, July 25, 2023 6:59 AM
>>
> 
> I'd suggest using "Drivers: hv: vmbus:" as the prefix in the commit message Subject.
> I see that "hv: hyperv.h:" has been used a few times in the past, but my suggestion
> is much more commonly used and would give better overall consistency.

Ok, will send v2.
> 
>> Since commit 30fbee49b071 ("Staging: hv: vmbus: Get rid of the unused function
>> vmbus_ontimer()")
>> this is not used anymore, so can remove it.
> 
> Indeed, yes!
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  include/linux/hyperv.h | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index bfbc37ce223b..3ac3974b3c78 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -1239,9 +1239,6 @@ extern int vmbus_recvpacket_raw(struct vmbus_channel
>> *channel,
>>  				     u32 *buffer_actual_len,
>>  				     u64 *requestid);
>>
>> -
>> -extern void vmbus_ontimer(unsigned long data);
>> -
>>  /* Base driver object */
>>  struct hv_driver {
>>  	const char *name;
>> --
>> 2.34.1
> 
> .
> 
