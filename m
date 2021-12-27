Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF90B47FA07
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Dec 2021 05:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhL0EEd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Dec 2021 23:04:33 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30178 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhL0EEd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Dec 2021 23:04:33 -0500
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JMkWf0xGZz8w3F;
        Mon, 27 Dec 2021 12:02:06 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 12:04:30 +0800
Subject: Re: [PATCH -next] scsi: storvsc: Fix unsigned comparison to zero
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211224120216.35896-1-yuehaibing@huawei.com>
 <MWHPR21MB15936A0B092F7467CC18B3C1D7419@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <eae60bf8-98b0-254c-8191-553f68850f2f@huawei.com>
Date:   Mon, 27 Dec 2021 12:04:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB15936A0B092F7467CC18B3C1D7419@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021/12/27 3:49, Michael Kelley (LINUX) wrote:
> From: YueHaibing <yuehaibing@huawei.com> Sent: Friday, December 24, 2021 4:02 AM
>>
>> The unsigned variable sg_count is being assigned a return value
>> from the call to scsi_dma_map() that can return -ENOMEM.
>>
>> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Good catch!  But I wonder if a simpler fix is to just remove the "unsigned"
> from the declaration of sg_count.  Then we don't need to add the
> sg_cnt local variable.  A little less complexity is almost always better. :-)

Ok， will respine
> 
> Michael
> 
>> ---
>>  drivers/scsi/storvsc_drv.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>> index ae293600d799..072c752a8c36 100644
>> --- a/drivers/scsi/storvsc_drv.c
>> +++ b/drivers/scsi/storvsc_drv.c
>> @@ -1837,7 +1837,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>>  		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
>>  		struct scatterlist *sg;
>>  		unsigned long hvpfn, hvpfns_to_add;
>> -		int j, i = 0;
>> +		int sg_cnt, j, i = 0;
>>
>>  		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
>>
>> @@ -1851,11 +1851,11 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>>  		payload->range.len = length;
>>  		payload->range.offset = offset_in_hvpg;
>>
>> -		sg_count = scsi_dma_map(scmnd);
>> -		if (sg_count < 0)
>> +		sg_cnt = scsi_dma_map(scmnd);
>> +		if (sg_cnt < 0)
>>  			return SCSI_MLQUEUE_DEVICE_BUSY;
>>
>> -		for_each_sg(sgl, sg, sg_count, j) {
>> +		for_each_sg(sgl, sg, sg_cnt, j) {
>>  			/*
>>  			 * Init values for the current sgl entry. hvpfns_to_add
>>  			 * is in units of Hyper-V size pages. Handling the
>> --
>> 2.17.1
> 
> .
> 
