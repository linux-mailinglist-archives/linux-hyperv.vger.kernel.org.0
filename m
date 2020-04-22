Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415A31B4DC4
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDVT4I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 15:56:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44951 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgDVT4H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 15:56:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id q18so1620279pgm.11;
        Wed, 22 Apr 2020 12:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T7jv4WALSCbwCxt/WWU6VfVtrOA11iUOI8kpnNfScSA=;
        b=o6cPFfV2k3qs+aA/TsTbbyuYico53/W5sStijcok19DAj2CklBCIUcJ4GwYyl6tSb3
         X9dGdsSYqj+nGEu/GuSEvJrpp+u5r3/71nlG0z8XB5ErkwNsYWm6PF55Hdrit9RpKJlh
         qFLujphPXriUfc9/cvEiEgEFdIOipssIIVNFc2vX+SSw+bfjMEYNlI9SmlGE74URLc3y
         nJJp/cFtuardxUxkkg4+7rsyYDyZ7G5lgjfB76KcSViztzkJpuPBgiNblJS3bG3DL3EG
         vfaeNCUfyACByUwX2rBpRnbyH/sy4CO42aEBkZHJkDzVb71ebKEkJV9h02eAsX2q+GIq
         mNOA==
X-Gm-Message-State: AGi0Pua5Nq/2yR+xKKW9Vfi7zhflk8qItvdyH7eN6sc/wHimNOvmYhTs
        P40eZ9egeo74v25BzThxXjY=
X-Google-Smtp-Source: APiQypIltU5kif74UMY4LjqqRD7zQ6tV9b/TvkWSQqeAAtnFaCwhnF30JYWUwu/x3/yNWL2aISlqRg==
X-Received: by 2002:a62:144c:: with SMTP id 73mr166355pfu.37.1587585365922;
        Wed, 22 Apr 2020 12:56:05 -0700 (PDT)
Received: from [100.124.11.187] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id r189sm44673pgr.31.2020.04.22.12.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 12:56:05 -0700 (PDT)
Subject: Re: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
To:     Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Balsundar P <Balsundar.P@microchip.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
 <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c55d643c-c13f-70f1-7a44-608f94fbfd5f@acm.org>
Date:   Wed, 22 Apr 2020 12:56:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/21/20 11:24 PM, Dexuan Cui wrote:
> Upon suspend, I suppose the other LLDs can not accept I/O either, then
> what do they do when some kernel thread still tries to submit I/O? Do
> they "block" the I/O until resume, or just return an error immediately?

This is my understanding of how other SCSI LLDs handle suspend/resume:
- The ULP driver, e.g. the SCSI sd driver, implements power management 
support by providing callbacks in struct scsi_driver.gendrv.pm and also 
in scsi_bus_type.pm. The SCSI sd suspend callbacks flush the device 
cache and send a STOP command to the device.
- SCSI LLDs for PCIe devices optionally provide pci_driver.suspend and 
resume callbacks. These callbacks can be used to make the PCIe device 
enter/leave a power saving state. No new SCSI commands should be 
submitted after pci_driver.suspend has been called.

> I had a look at drivers/scsi/xen-scsifront.c. It looks this LLD implements
> a mechanism of marking the device busy upon suspend, so any I/O will
> immediately get an error SCSI_MLQUEUE_HOST_BUSY. IMO the
> disadvantage is: the mechanism of marking the device busy looks
> complex, and the hot path .queuecommand() has to take the
> spinlock shost->host_lock, which should affect the performance.

I think the code you are referring to is the code in 
scsifront_suspend(). A pointer to that function is stored in a struct 
xenbus_driver instance. That's another structure than the structures 
mentioned above.

Wouldn't it be better to make sure that any hypervisor suspend 
operations happen after it is guaranteed that no further SCSI commands 
will be submitted such that hypervisor suspend operations do not have to 
deal with SCSI commands submitted during or after the hypervisor suspend 
callback?

> It looks drivers/scsi/nsp32.c: nsp32_suspend() and
> drivers/scsi/3w-9xxx.c: twa_suspend() do nothing to handle new I/O
> after suspend. I doubt this is correct.

nsp32_suspend() is a PCI suspend callback. If any SCSI commands would be 
submitted after that callback has started that would mean that the SCSI 
suspend and PCIe suspend operations are called in the wrong order. I do 
not agree that code for suspending SCSI commands should be added in 
nsp32_suspend().

> So it looks to me there is no simple mechanism to handle the scenario
> here, and I guess that's why the scsi_host_block/unblock APIs are
> introduced, and actually there is already an user of the APIs:
> 3d3ca53b1639 ("scsi: aacraid: use scsi_host_(block,unblock) to block I/O").
> 
> The aacraid patch says: "This has the advantage that the block layer will
> stop sending I/O to the adapter instead of having the SCSI midlayer
> requeueing I/O internally". It looks this may imply that using the new
> APIs is encouraged?

I'm fine with using these new functions in device reset handlers. Using 
these functions in power management handlers seems wrong to me.

> PS, here storvsc has to destroy and re-construct the I/O queues: the
> I/O queues are shared memory ringbufers between the guest and the
> host; in the resume path of the hibernation procedure, the memory
> pages allocated by the 'new' kernel is different from that allocated by
> the 'old' kernel, so before jumping to the 'old' kernel, the 'new' kernel
> must destroy the mapping of the pages, and later after we jump to
> the 'old' kernel, we'll re-create the mapping using the pages allocated
> by the 'old' kernel. Here "create the mapping" means the guest tells
> the host about the physical addresses of the pages.

Thank you for having clarified this. This helps me to understand the HV 
driver framework better. I think this means that the hv_driver.suspend 
function should be called at a later time than SCSI suspend. From 
Documentation/driver-api/device_link.rst: "By default, the driver core 
only enforces dependencies between devices that are borne out of a 
parent/child relationship within the device hierarchy: When suspending, 
resuming or shutting down the system, devices are ordered based on this 
relationship, i.e. children are always suspended before their parent, 
and the parent is always resumed before its children." Is there a single 
storvsc_drv instance for all SCSI devices supported by storvsc_drv? Has 
it been considered to make storvsc_drv the parent device of all SCSI 
devices created by the storvsc driver?

Thanks,

Bart.
