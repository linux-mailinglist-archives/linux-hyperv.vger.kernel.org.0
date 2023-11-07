Return-Path: <linux-hyperv+bounces-713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBD7E4A55
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152661C209B7
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AA3C6AE;
	Tue,  7 Nov 2023 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dHQofh1I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1C321BB;
	Tue,  7 Nov 2023 21:08:20 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E46B11F;
	Tue,  7 Nov 2023 13:08:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABixIoGjOLICJR+ioHrMcR30oMP/oNxQeWaX6/JAGEJh55BUXvqNYCWNIAQ2arTER6bdl9WZLkKasRTbu5W3E/IrkxB7vPJaqsIV8XOd4nqqCIyQ9JIZ07iA1N1BNjP3s1m+3FC284Kvuk7Ib+EApq2cxpEhVCchgDBeI72KKgr/dQGwKQp+IhTYu1j9MnwWV50rpRjKw5EBMmuGRp3Qx/YK2ugDtMh4Y/su3mDGh9UGeczAwFGDxR/8Oojbud9KwmSGO8iosz2ihOg9t1Vfscr5DwgiFN+ufsYyo3VBczp3v+92kITxprtqRbi4mtkKTNCZyUEkJ2Umb+9aRDBhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/k7FwDQVU3PnLzIOdH9zfrvVY3gmIexqWraG8UqOPc=;
 b=jZHu2evpCrMZE02cN5rbKApCpGpw1Guo2wj2enfKbnBiMJuHzSQ5PKMId8yTSrVIR2lLEgeNtnH8j3WreC8Oc8qbDemdolczdTanOsgfGQAGo8IoMeGe9crIpoC+6VbGbIESZO4YYHrecx933g2KhPPbsGfesUvAaVzunCxLGYg8qvXFhARfQ18MAUx59a3Aj4NIPkbDGE6tPTpCGRNtK1vvg5N4gRG6GydyQUqWL9EneYV6GVEF8Fg7dlmfuamYkXfRNjlNMIpcQivpObTaZXtRWweBnMVmK0IhZwS63e/oSMgUTqQ1SHEXWS4OkT0/axOzDuolCVySXXchoqtdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/k7FwDQVU3PnLzIOdH9zfrvVY3gmIexqWraG8UqOPc=;
 b=dHQofh1IPnZ3jRLUI1Tv281oTdC7Fs0VqpuKPXYej+mGtjPOryhTtAQMzTjq/zYR95MzftBtSLl9dQLAwwwF6RkrbIXBWuHoQcymEC7OszPGbyJar4dnjYeT5s0uPPZT/Po6BWd4Lk4ZV0+LxQVRUcCgydqy+jrTOQN0c4kvO+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DS0PR21MB3929.namprd21.prod.outlook.com (2603:10b6:8:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.0; Tue, 7 Nov
 2023 21:08:17 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e8f3:a982:78ac:3cea]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e8f3:a982:78ac:3cea%3]) with mapi id 15.20.7002.001; Tue, 7 Nov 2023
 21:08:17 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net,v3, 2/2] hv_netvsc: Fix race of register_netdevice_notifier and VF register
Date: Tue,  7 Nov 2023 13:05:32 -0800
Message-Id: <1699391132-30317-3-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
References: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To MN2PR21MB1454.namprd21.prod.outlook.com
 (2603:10b6:208:208::11)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DS0PR21MB3929:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f5d451-987b-4b38-468d-08dbdfd5a97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AiYmVnAVaQgZ/J0jDkbn9nJuFmbH9gTQqBDFv0g3lAhWOS41jJq+ehbqywkFCtlmE0giuqRj7aDis1F1KlCamjD3i7JMIiXVvoXn3di8oTRpHjDcXeseWk5BqU7tL9KmOoB6gYpJ3AGZJh/aeggTQLJTSZJ3i/ne0sXJzUS6QjO7b8YcuboCBzK42zvMmNNPy7RPZo4wea0UdC+CaptszUiGFg7zFaW8UKgN2KkYhv68p4Cf8O5V37RpG+3TKUMKY4qELx3aCaAf+7Slxy3xdqzhzWmQoDASnC2xcAX9/Bj/oosO1FEeWafzXlC7FFo4gpqv5ftOIU4XDkVg+e6Cipfj6xBOEyfQucxHMtXMAFD+Z5hAGDG3C2JG0Jhfm4XmMw+/luGTgXsTK/djlXqXHKho3f0lV0zcy2E+0+KlT10/75rspzKsYMD4jVq7NwrqozrnLsnieTUTtrLqxraSNgCFG7bu12tRGpe+ptzrzPDaG12zWqMxs5OVKIr6gHr0epPQBQ1Rdj/b+UjRM/vCR5KthlzOST/F0Rw6Pw0BkUnhqKhdErWp2HHMMX4JaS3CPK1YS7pDEVy8f4G3X2iXGpi57XDb3jt8XvYaQ1GIn3yg3K4WEqS1TwqB+2hKulhpX1zVzlXlLkAahIMPBJdo8mkWzhudsNW3x65yW/xHALI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(83380400001)(41300700001)(38100700002)(38350700005)(36756003)(82960400001)(82950400001)(52116002)(6666004)(6506007)(7846003)(6512007)(6486002)(478600001)(66946007)(316002)(66476007)(66556008)(4326008)(8676002)(8936002)(10290500003)(5660300002)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NUtav0iNrrQe6H5XEX+srJM7mCMK+g74u0XNZWAr85Pw8CQVD4T00GgsLxSX?=
 =?us-ascii?Q?0tTVFf1hewnselrMoBEekuuFV2TttDpUGKnxDxRzi5riEMfOKTqc7hLAIj5o?=
 =?us-ascii?Q?j1qdn4+7QNo0oUVIdpRYaTF7FHyZFHRRjjFYh14goAH/Dx7PET+MmVzqWQib?=
 =?us-ascii?Q?OT2/uPYlgE9MdtWTzpwanp2dOfVcPOr02+OZ73tbr2c0SCsjRCbjijWZmNev?=
 =?us-ascii?Q?k6Hw6AsLUtKYPCH5skdufZCJD5ZCQYijZNMvduBPam87cvI9Q23BUhOtrY7R?=
 =?us-ascii?Q?7+3o9sD5DnHjX/PJoFrlui54OBCugyy5PQXe7OPs8VnMAQE995VfYeULUQ78?=
 =?us-ascii?Q?+AepYA0ndD5uM8LY03LC6DnBStSbd1gWnYGGGz6WTIRnjs/UpTucJqMeDrGc?=
 =?us-ascii?Q?unAS4VX6z7TODDy2x3DBdnYczVThKIpWSH6Pe2WMJhU0nZxsbVKCZtCsGsrM?=
 =?us-ascii?Q?NRXZxewOwZUtuRCCy2KD11LlqELrpNfOEvnYI9oSnvrnlwCbUopYJsgciS5S?=
 =?us-ascii?Q?0U0levODAa1kdsUV7UMrRh2DLVtAg/rLd/61eRrNyJa3XhOewHfANU7wrnrm?=
 =?us-ascii?Q?8+kM8LttE5lVQ3KroluJSMJjgFx+Qx4aUeYRxTEpgnN25Ik72nt/UnlGfbE+?=
 =?us-ascii?Q?bhB3fqaRCYfrqTn2Cc4PPgNouP33yXy2D9vWTotJ0sc5jBQNv5HdEIIG7p5X?=
 =?us-ascii?Q?xe5MwUCNnto6Q0tZ6vDE5BAUGuKyex4POICidUP7/1VxlyzaJDrEERN5I4bY?=
 =?us-ascii?Q?La57znLgvA204WF1ks4op0gj3cTyGTjHrIWa49bS3mhnR/0j6IWLGLWsfD03?=
 =?us-ascii?Q?OEx22ysK85kqwtSvDyVSi2Q+TZ+67sjDOXUFZl7jRBUo1wuojfr8O6i7iKMB?=
 =?us-ascii?Q?ghSqrCYep4DzSsg0euuSecrnv4wfP4ezt9+9WmjtQh+kod0r9kykT0VJYJ7o?=
 =?us-ascii?Q?kc0q4iHvDIdjBKhccqUl+VIK2kAvIU9cEBwwNb7P3Vzj5/BtqUvUEmnbhxiI?=
 =?us-ascii?Q?agLXcQzXjKytd3D5jN0ZUEYluh4Kxdc3zcftB6Tfm6H22k15y+Kn4duPtCL7?=
 =?us-ascii?Q?FIkjMlUq9kaS7MP0tMqfstZmAghF1bMm6+EbdsRbCk9KJpKcdoQ6HY0Bjw7H?=
 =?us-ascii?Q?sJ+d1sp8i1nZDuDYNAhP9uB+2pIkyomJiWdhwMRsY+MAgqVDYhBtnt/wZNcL?=
 =?us-ascii?Q?gFE4IY3WT086Eu7ju5e3wowmSwmcDXtFE5/BjTTOBR2ptvMM10SlbtUJFoS2?=
 =?us-ascii?Q?SmTcyqqeqBtsq3l4IfwIE02/1NZ5GSlCNUzm4L4RdntuhFnZ7HXf/GAA62gs?=
 =?us-ascii?Q?kwgAZk0eFhRR+nJc/YNHsexm/fyTqejPvuLJPFvwChrtNNXIeKibP1QAEefZ?=
 =?us-ascii?Q?06FEpE/KfCutfUEtzkFISV3ezxWktAZwT/Ge9dgoQtwLzcHxTS0H6IhN2s5l?=
 =?us-ascii?Q?ys2G6dzOHWP5yVE4NsLPCIlaTNAO3UgwE2YNHhqEX/O1MVr9dA/9jJ030s6q?=
 =?us-ascii?Q?v08232TU365b/6zn7f1le1lcLsRnUuB+AVPRKT561ZsCvN86p+aNvgwT5QZZ?=
 =?us-ascii?Q?7b7idV5fC8EpmiveiHqooh+uuh37gJVzi5cUShUP?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f5d451-987b-4b38-468d-08dbdfd5a97e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1454.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:08:17.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dAGTJTrnzzhz2Uxs9XhmZJvjiHFwapOxGtNE5cfixlDcYIjTqQhA9wy0uopKbCwRzBCe1SfoJrq9aBgmd4Uew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3929

If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
but NETDEV_POST_INIT is not.

Move register_netdevice_notifier() earlier, so the call back
function is set before probing.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

---
v3:
  Divide it into two patches, suggested by Jakub Kicinski.

v2:
  Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
---
 drivers/net/hyperv/netvsc_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 5e528a76f5f5..1d1491da303b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2793,11 +2793,14 @@ static int __init netvsc_drv_init(void)
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
 
+	register_netdevice_notifier(&netvsc_netdev_notifier);
+
 	ret = vmbus_driver_register(&netvsc_drv);
-	if (ret)
+	if (ret) {
+		unregister_netdevice_notifier(&netvsc_netdev_notifier);
 		return ret;
+	}
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
 }
 
-- 
2.25.1


