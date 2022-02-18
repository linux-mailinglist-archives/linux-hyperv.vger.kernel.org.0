Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A54BBFBC
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Feb 2022 19:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiBRSnC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Feb 2022 13:43:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239406AbiBRSm6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Feb 2022 13:42:58 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EFD166A43;
        Fri, 18 Feb 2022 10:42:41 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id w37so2217446pga.7;
        Fri, 18 Feb 2022 10:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTDO2ijH97Okb1V/c6+V1GCrGsDIxaa5nQMyVR65+So=;
        b=Pc1SubqIG7PeXuoDJlxerZb7XZz2VYt5/HIAP8fhBnPYFUTEbRoPc/hD0zar1bma3V
         4HokjUXlFlCzkXeRBqZNmGCQ3l8CKYg2jhW1k3CKkxdouixmWBwlfbye2k3T5UVN4AWn
         52n/4TpQSOJ6fiHWHFjwReUOQC0he3x2HgAi44cVWeTV8w05Sa1D9bOyeAsYJF4B+JWR
         mBc9C6T9ZP/m0MlZ+TuVliGVdVQimrRNJyC5IpsM6L0bfkOB3XBCD/HU3/YKOhebN7mq
         J+lsn34usoaevMCZEEoXO5bPVPzQN4y1vAeuDaooWztwMJK90R8IU55MMcJYkL/7yE9H
         qIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTDO2ijH97Okb1V/c6+V1GCrGsDIxaa5nQMyVR65+So=;
        b=GhXkPohLkACB6+Ol+G9yfDoeZkPN67Lxxf9R/dJ9Itgn4Z84mLaXeAfnLfHqaYQVsM
         avT1iaQp+/ss5uz8/3OPZP0+rKeRCtSCMTZeExO3db4Z5UJONvglXn6dTSMgxjEkyVNL
         gTpN/2cLN5Qv3s3GEz8BFpkkDpcnsHWRZdRHgW07PLg8r+ioMPojOBWswwtbaWkPMUwZ
         PClxteRWwXtY31Gphr4IYpsqdsmgbQjOzqARbSFZzBnoI/7d4VOP/jVRqsVWo9R/7+rJ
         p9gr2B8kHilWWfs6F9Azb03iWKMQYKqBCoeFfFOyVlAgshhUCwZIpiN58klYpwY1yzCg
         y2Dw==
X-Gm-Message-State: AOAM5303tAz8BA0muh0kGAS6TeVVqoS9UjJ2yLRaT353PNb3C+pM+/G7
        UhxwjefG6KBFys1QWdXSl5M=
X-Google-Smtp-Source: ABdhPJwlYmGekFiFlVU1QipHTqjBlqB1DVOw04uJcuNNV1Cz3CVl3v/qDadRl9ArZAyNjW9xzofVrg==
X-Received: by 2002:a65:6e4b:0:b0:373:8350:cef3 with SMTP id be11-20020a656e4b000000b003738350cef3mr7362940pgb.219.1645209761285;
        Fri, 18 Feb 2022 10:42:41 -0800 (PST)
Received: from vm-111.3frfxmc3btcupaqenzdpat1uec.xx.internal.cloudapp.net ([13.77.171.140])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090ab79100b001b89fd7e298sm130132pjr.4.2022.02.18.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:42:40 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     mikelley@microsoft.com, jejb@linux.ibm.com, kys@microsoft.com,
        martin.petersen@oracle.com, mst@redhat.com,
        benh@kernel.crashing.org, decui@microsoft.com,
        don.brace@microchip.com, R-QLogic-Storage-Upstream@marvell.com,
        haiyangz@microsoft.com, jasowang@redhat.com, john.garry@huawei.com,
        kashyap.desai@broadcom.com, mpe@ellerman.id.au,
        njavali@marvell.com, pbonzini@redhat.com, paulus@samba.org,
        sathya.prakash@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sreekanth.reddy@broadcom.com, stefanha@redhat.com,
        sthemmin@microsoft.com, suganath-prabu.subramani@broadcom.com,
        sumit.saxena@broadcom.com, tyreld@linux.ibm.com,
        wei.liu@kernel.org, linuxppc-dev@lists.ozlabs.org,
        megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        storagedev@microchip.com,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com
Cc:     andres@anarazel.de
Subject: [PATCH RFC v1 5/5] scsi: storvsc: Hardware queues share blk_mq_tags
Date:   Fri, 18 Feb 2022 18:41:57 +0000
Message-Id: <20220218184157.176457-6-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218184157.176457-1-melanieplageman@gmail.com>
References: <20220218184157.176457-1-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Decouple the number of tags available from the number of hardware queues
by sharing a single blk_mq_tags amongst all hardware queues.

When storage latency is relatively high, having too many tags available
can harm the performance of mixed workloads.
By sharing blk_mq_tags amongst hardware queues, nr_requests can be set
to the appropriate number of tags for the device.

Signed-off-by: Melanie Plageman <melanieplageman@gmail.com>
---
As an example, on a 16-core VM coupled with a 1 TiB storage device having a
combined (VM + disk) max BW of 200 MB/s and IOPS of 5000, configured with 16
hardware queues and with nr_requests set to 56 and queue_depth set to 15, the
following fio job description illustrates the benefit of hardware queues sharing
blk_mq_tags:

[global]
time_based=1
ioengine=io_uring
direct=1
runtime=60

[read_hogs]
bs=16k
iodepth=10000
rw=randread
filesize=10G
numjobs=15
directory=/mnt/test

[wal]
bs=8k
iodepth=3
filesize=4G
rw=write
numjobs=1
directory=/mnt/test

with hctx_share_tags set, the "wal" job does 271 IOPS, averaging 13120 usec
completion latency and the "read_hogs" jobs average around 4700 IOPS.

without hctx_share_tags set, the "wal" job does 85 IOPS and averages around
45308 usec completion latency and the "read_hogs" job average around 4900 IOPS.

Note that reducing nr_requests to a number sufficient to increase WAL IOPS
results in unacceptably low IOPS for the random reads when only one random read
job is running.

 drivers/scsi/storvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 0ed764bcabab..5048e7fcf959 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1997,6 +1997,7 @@ static struct scsi_host_template scsi_driver = {
 	.track_queue_depth =	1,
 	.change_queue_depth =	storvsc_change_queue_depth,
 	.per_device_tag_set =	1,
+	.hctx_share_tags = 1,
 };
 
 enum {
-- 
2.25.1

