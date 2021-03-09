Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09013322AB
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Mar 2021 11:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCIKML (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Mar 2021 05:12:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2667 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhCIKLw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Mar 2021 05:11:52 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvrVS0xBYz67wrv;
        Tue,  9 Mar 2021 18:07:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 11:11:50 +0100
Received: from [10.210.172.22] (10.210.172.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 10:11:49 +0000
Subject: Re: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
References: <20210305232151.1531-1-melanieplageman@gmail.com>
 <MWHPR21MB1593078007256C5155ED5A86D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210308175618.GA2376@goldwasser>
From:   John Garry <john.garry@huawei.com>
Message-ID: <01aa44d0-f0a5-6de6-6778-a1658a3d8a8f@huawei.com>
Date:   Tue, 9 Mar 2021 10:09:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210308175618.GA2376@goldwasser>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.22]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 08/03/2021 17:56, Melanie Plageman wrote:
> On Mon, Mar 08, 2021 at 02:37:40PM +0000, Michael Kelley wrote:
>> From: Melanie Plageman (Microsoft) <melanieplageman@gmail.com> Sent: Friday, March 5, 2021 3:22 PM
>>>
>>> The scsi_device->queue_depth is set to Scsi_Host->cmd_per_lun during
>>> allocation.
>>>
>>> Cap cmd_per_lun at can_queue to avoid dispatch errors.
>>>
>>> Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
>>> ---
>>>   drivers/scsi/storvsc_drv.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>>> index 6bc5453cea8a..d7953a6e00e6 100644
>>> --- a/drivers/scsi/storvsc_drv.c
>>> +++ b/drivers/scsi/storvsc_drv.c
>>> @@ -1946,6 +1946,8 @@ static int storvsc_probe(struct hv_device *device,
>>>   				(max_sub_channels + 1) *
>>>   				(100 - ring_avail_percent_lowater) / 100;
>>>
>>> +	scsi_driver.cmd_per_lun = min_t(u32, scsi_driver.cmd_per_lun, scsi_driver.can_queue);
>>> +
>>
>> I'm not sure what you mean by "avoid dispatch errors".  Can you elaborate?
> 
> The scsi_driver.cmd_per_lun is set to 2048. Which is then used to set
> Scsi_Host->cmd_per_lun in storvsc_probe().
> 
> In storvsc_probe(), when doing scsi_scan_host(), scsi_alloc_sdev() is
> called and sets the scsi_device->queue_depth to the Scsi_Host's
> cmd_per_lun with this code:
>      
> scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
>                                          sdev->host->cmd_per_lun : 1);
> 
> During dispatch, the scsi_device->queue_depth is used in
> scsi_dev_queue_ready(), called by scsi_mq_get_budget() to determine
> whether or not the device can queue another command.
> 
> On some machines, with the 2048 value of cmd_per_lun that was used to
> set the initial scsi_device->queue_depth, commands can be queued that
> are later not able to be dispatched after running out of space in the
> ringbuffer.
> 
> On an 8 core Azure VM with 16GB of memory with a single 1 TiB SSD
> (running an fio workload that I can provide if needed), storvsc_do_io()
> ends up often returning SCSI_MLQUEUE_DEVICE_BUSY.
>                                                                        
> This is the call stack:
>      
> hv_get_bytes_to_write
> hv_ringbuffer_write
> vmbus_send_packet
> storvsc_dio_io
> storvsc_queuecommand
> scsi_dispatch_cmd
> scsi_queue_rq
> dispatch_rq_list
> 
>> Be aware that the calculation of "can_queue" in this driver is somewhat
>> flawed -- it should not be based on the size of the ring buffer, but instead on
>> the maximum number of requests Hyper-V will queue.  And even then,
>> can_queue doesn't provide the cap you might expect because the blk-mq layer
>> allocates can_queue tags for each HW queue, not as a total.
> 
> 
> The docs for scsi_mid_low_api document Scsi_Host can_queue this way:
> 
>    can_queue
>    - must be greater than 0; do not send more than can_queue
>      commands to the adapter.
>          
> I did notice that in scsi_host.h, the comment for can_queue does say
> can_queue is the "maximum number of simultaneous commands a single hw
> queue in HBA will accept." However, I don't see it being used this way
> in the code.
>                            

JFYI, the block layer ensures that no more than can_queue requests are 
sent to the host. See scsi_mq_setup_tags(), and how the tagset queue 
depth is set to shost->can_queue.

Thanks,
John


> During dispatch, In scsi_target_queue_ready(), there is this code:
> 
>          if (busy >= starget->can_queue)
>                  goto starved;
> 
> And the scsi_target->can_queue value should be coming from Scsi_host as
> mentioned in the scsi_target definition in scsi_device.h
>      /*
>        * LLDs should set this in the slave_alloc host template callout.
>        * If set to zero then there is not limit.
>        */
>      unsigned int            can_queue;
> 
> So, I don't really see how this would be per hardware queue.
> 
>>
>> I agree that the cmd_per_lun setting is also too big, but we should fix that in
>> the context of getting all of these different settings working together correctly,
>> and not piecemeal.
>>
> 
> Capping Scsi_Host->cmd_per_lun to scsi_driver.can_queue during probe
> will also prevent the LUN queue_depth from being set to a value that is
> higher than it can ever be set to again by the user when
> storvsc_change_queue_depth() is invoked.
> 
> Also in scsi_sysfs sdev_store_queue_depth() there is this check:
> 
>            if (depth < 1 || depth > sdev->host->can_queue)
>                  return -EINVAL;
> 
> I would also note that VirtIO SCSI in virtscsi_probe(), Scsi_Host->cmd_per_lun
> is set to the min of the configured cmd_per_lun and
> Scsi_Host->can_queue:
> 
>      shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);
> 
> Best,
> Melanie
> .
> 

