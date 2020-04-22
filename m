Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3C1B33E0
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 02:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDVASD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 20:18:03 -0400
Received: from mail-dm6nam10on2133.outbound.protection.outlook.com ([40.107.93.133]:6881
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgDVASC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 20:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFoDcc7DQDzJzNWArBiNmmAKmQ0+0T8BM7DO9UhCzZW5aNfnW6e3M/NSNBUBndJrtlQFnYvoiU1oMImD8Wjt2kn4+VgJQAm26iAJsKZCOVIzE6NOn2Km7Ssi0Ickg/BQhggZJ2tB+z7okIQg/Y4CisZux0pUnDG8jgoFeb9hRnFixzwASgq/sNMHQHV9hr48ouJ4oTAwjmXUjYOecBCst5Ilannre4iTdrGiXKF8mBFZztSAa5XEpQzYiyQ9Gh1x29RU6QqstMlAJOuyHxLUHE9r5xEzi6ys5rIZxIGhZTl65N8I1ePqgE0WgBFWMn3+l4p8ei/qQRsl82zGW0HGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4caw7Xgo2COSQKj4uL05+8SqQMchdBV2Ke6WgO2PPA=;
 b=PdYk2z8mosJINY4fF6PfYDwUGQS2eS31xY7DeMdVaDbFi7uXucJxOoEaduchmO/dk1e07w7TzqteMbO/Kq4e5cBtro34djvtVp0cpsrRluq8QjLqzKIhd6hAxTYlGMpu/Jqk2C0DShkVriBFaTIEGfUB8z7eg/l0+mp94QQcLqsyehriiJeBjyyASbj7FjSDLG8IUSagTZK5SlmvvQAn5O6qaSnYNm80iYgcj2fftPN296VivWRQzEDfEgGS9ABVlIPV8m9Q4pASUW1eGLRHFb3M6kF0QH6AGuCFUDAgz3hvCu7Mi9lNeEabUZUH5+unujmnt4tAzKQr6WA9hqX0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4caw7Xgo2COSQKj4uL05+8SqQMchdBV2Ke6WgO2PPA=;
 b=iYrM4AFhpvfGTQEYU5OgY4wSxnGFYT8BlZsGeLkSuvNK3GePxDLZ7+gzLJ1KKrJgwT1S11LMhmD9fTAUWmmfgcc9H95p+DK9eWb/bbu6i8pPeFpXTDdU8A18inUb7Gkgr5rTip4h3vkQcNDl1YXAvV7YGqlDrj80mgOWTi06png=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (2603:10b6:404:94::7)
 by BN6PR21MB0849.namprd21.prod.outlook.com (2603:10b6:404:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.3; Wed, 22 Apr
 2020 00:17:59 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::171:e82f:b9f2:3a68]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::171:e82f:b9f2:3a68%13]) with mapi id 15.20.2958.001; Wed, 22 Apr 2020
 00:17:59 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, bvanassche@acm.org, hare@suse.de,
        mikelley@microsoft.com, longli@microsoft.com, ming.lei@redhat.com
Cc:     linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Date:   Tue, 21 Apr 2020 17:17:24 -0700
Message-Id: <1587514644-47058-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:300:117::25) To BN6PR21MB0161.namprd21.prod.outlook.com
 (2603:10b6:404:94::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR03CA0015.namprd03.prod.outlook.com (2603:10b6:300:117::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 00:17:57 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fa28811-c28d-42cf-d9e4-08d7e6529ca2
X-MS-TrafficTypeDiagnostic: BN6PR21MB0849:|BN6PR21MB0849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB0849E96B26A84333FCFDC13CBFD20@BN6PR21MB0849.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0161.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(966005)(8676002)(107886003)(956004)(2616005)(2906002)(16526019)(81156014)(8936002)(186003)(26005)(6486002)(5660300002)(478600001)(6506007)(52116002)(6512007)(316002)(10290500003)(7416002)(6666004)(66556008)(86362001)(3450700001)(66476007)(36756003)(66946007)(82950400001)(82960400001)(4326008)(921003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZgYcfz9929uv7+8xzbBpV+16JywUNYH8rMjdV/b4RcEKlHtjXN8yWkt55uYO+PhajEL1tiY9XvwAZ4rvBNhU/Ue8qLRHOTOzldooj4RbM+nmaaUYA+t33T7FWfeumK4TEfVTqw0Mgfqs4OkGdn/D1kohvjcWXK6O1gpqR028AG7X3d11IHTM6nKffOthLV4FahmWfctLrNjfLEeHVG91N4WE0A2/964NUDIENoySHi0olnlxi29FbidXrNWsJ9XHFHXPgAlMWCUoN3F0ISG9AZ2STTCsDgLjsq/VtjTAOWasc00mKhTTs4ZfL0WBN3ynAiSYQkStLheIWnh4kYRRZlS7+zreQmcO4cCFcUQXSi3mMRIjG/FX3eIBmb44uK+0/rW3u7TQGYuS+5BcwODvm/QnRB5TlYplZzJYmO1757h/EFJ6T+erTnu4kzQmAEKI0pru2QnUMGbbW7ezRhQ+M5QLGqJ++/IeE/nWG3gIXo1XJDEA8l+sMYjIjP5tuj0N1Cj4vjFusdQz105fwzVczafgjkw6y0EKMbVjEx+IC/SUEGG3yKyjd7fcnZUAuYu
X-MS-Exchange-AntiSpam-MessageData: kQV/kEjx9fe/dEJjC7zZyAp4s29ymf+liRUNj7xaS8tUFk7nUcG20iZPV/9jUUezSjOlChp0LxqQjIK1JyIiLGnomfzj93oMJPv6PPxiL5VxEr+7Ip9zeWb12c/LiZ/J7fEeUSjOdxA5tdT0dDvccydoBIQB/FiagBGQU3vVFaHvBZlv6EdXMNR/Oqx32cjJVPoXuKvGbv4bUKModlSyN+8tSnPFmkAhxXwZufavySyE0hbAEpNy4PHG4xytzdkwXyhoO+zFQBXcZUfkaFLWQgmY3oQ0DrNyV0carub8E8QeBxOj+3+3oEGdn0MYdGVz0QhbpXP8BJoUi5/qf+rFCDCLHxzZ3xVsQs9bsrP+p1DElkltniDhdtWONZKprITWUBqoATJeDiDtD3Otw2d79XI9sMPWQCiBIdCR67EGN7WlhnB648NzrY8xSlyCyQXQruR9ujCU5EAU+NZ/CRkpvN5QLYa12nrG8IFhzmD+bMwX6/4/9XXC3Gc7yBO2l1lhFYAyetlTyBQwSKd+hdK600VwbTrw+7pQQjapJhLT61epupam2b+NDeDvX8MrPPcFzDxfIcjoVkWzGFyZYdOTH34YTcoXpQT45klfOi2vJGXgmHyRYMGF3AvYkD+qN1GFnKFk0ibOUmMxtyX/YkMjAQGo8O9960byhseJ2fSQp0/vOYbmXw2/lfVNSuFWuNCOo7qeM07Z67c63ShjpvBN8zRFzwHEvZGgnWaOsgmm3yBu3H2HGv9zL8PtdqIvjM219mAKo47VA1BXxuKicUUGQH5q5NJhtNQEe7y2PdRaIGo=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa28811-c28d-42cf-d9e4-08d7e6529ca2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 00:17:59.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyYNYErjZBpFSJXChEtxLe8xBSHSgljRnWEEBoMIdRmIlDos4kQiF1sxmyGXzbSrHQHItmVfrNtcXUEvPltN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0849
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

During hibernation, the sdevs are suspended automatically in
drivers/scsi/scsi_pm.c before storvsc_suspend(), so after
storvsc_suspend(), there is no disk I/O from the file systems, but there
can still be disk I/O from the kernel space, e.g. disk_check_events() ->
sr_block_check_events() -> cdrom_check_events() can still submit I/O
to the storvsc driver, which causes a paic of NULL pointer dereference,
since storvsc has closed the vmbus channel in storvsc_suspend(): refer
to the below links for more info:
  https://lkml.org/lkml/2020/4/10/47
  https://lkml.org/lkml/2020/4/17/1103

Fix the panic by blocking/unblocking all the I/O queues properly.

Note: this patch depends on another patch "scsi: core: Allow the state
change from SDEV_QUIESCE to SDEV_BLOCK" (refer to the second link above).

Fixes: 56fb10585934 ("scsi: storvsc: Add the support of hibernation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index fb41636519ee..fd51d2f03778 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1948,6 +1948,11 @@ static int storvsc_suspend(struct hv_device *hv_dev)
 	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
 	struct Scsi_Host *host = stor_device->host;
 	struct hv_host_device *host_dev = shost_priv(host);
+	int ret;
+
+	ret = scsi_host_block(host);
+	if (ret)
+		return ret;
 
 	storvsc_wait_to_drain(stor_device);
 
@@ -1968,10 +1973,15 @@ static int storvsc_suspend(struct hv_device *hv_dev)
 
 static int storvsc_resume(struct hv_device *hv_dev)
 {
+	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
+	struct Scsi_Host *host = stor_device->host;
 	int ret;
 
 	ret = storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
 				     hv_dev_is_fc(hv_dev));
+	if (!ret)
+		ret = scsi_host_unblock(host, SDEV_RUNNING);
+
 	return ret;
 }
 
-- 
2.19.1

