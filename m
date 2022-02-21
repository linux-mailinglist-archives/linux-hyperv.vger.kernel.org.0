Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2C4BE9E5
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 19:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiBURl4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 12:41:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiBURlY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 12:41:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA5B26AF8;
        Mon, 21 Feb 2022 09:40:27 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2Twb3c5Sz67WcM;
        Tue, 22 Feb 2022 01:35:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 21 Feb 2022 18:40:25 +0100
Received: from [10.47.94.94] (10.47.94.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Feb
 2022 17:40:23 +0000
Message-ID: <9e7925d6-067c-0b3a-a788-f036272496e6@huawei.com>
Date:   Mon, 21 Feb 2022 17:40:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH RFC v1 0/5] Add SCSI per device tagsets
To:     "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>,
        <mikelley@microsoft.com>, <jejb@linux.ibm.com>,
        <kys@microsoft.com>, <martin.petersen@oracle.com>,
        <mst@redhat.com>, <benh@kernel.crashing.org>,
        <decui@microsoft.com>, <don.brace@microchip.com>,
        <R-QLogic-Storage-Upstream@marvell.com>, <haiyangz@microsoft.com>,
        <jasowang@redhat.com>, <kashyap.desai@broadcom.com>,
        <mpe@ellerman.id.au>, <njavali@marvell.com>, <pbonzini@redhat.com>,
        <paulus@samba.org>, <sathya.prakash@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>,
        <sreekanth.reddy@broadcom.com>, <stefanha@redhat.com>,
        <sthemmin@microsoft.com>, <suganath-prabu.subramani@broadcom.com>,
        <sumit.saxena@broadcom.com>, <tyreld@linux.ibm.com>,
        <wei.liu@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <megaraidlinux.pdl@broadcom.com>,
        <mpi3mr-linuxdrv.pdl@broadcom.com>, <storagedev@microchip.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <MPT-FusionLinux.pdl@broadcom.com>
CC:     <andres@anarazel.de>
References: <20220218184157.176457-1-melanieplageman@gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220218184157.176457-1-melanieplageman@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.94]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 18/02/2022 18:41, Melanie Plageman (Microsoft) wrote:
> For example: a device provisioned with high IOPS and BW limits on the same
> controller as a smaller and slower device can starve the slower device of tags.
> This is especially noticeable when the slower device's workload has low I/O
> depth tasks.

If you check hctx_may_queue() in the block code then it is noticeable 
that a fair allocation of HW queue depth is allocated per request queue 
to ensure we don't get starvation.

Thanks,
John
