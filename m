Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24127672F5
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjG1RLY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjG1RLX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 13:11:23 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020019.outbound.protection.outlook.com [52.101.56.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D6AB5;
        Fri, 28 Jul 2023 10:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuqWGfm5xQSGT7IRCvL+S95fi3dT+64omqxgZDhngSgjk1xzNbOQKj4zlAYwdzcBkgPRZqiXEb6weBYr1VFJJWMcdGQioF082xebXvxqik8+X+AO2/g1GhRm8MPzG/wmPbY6wejz4duhkjQ3u8Ma54rCt2YVxScp4VlSJy74bXFX1UDUyON8s9+vD/gf0IXbcL9dL6OL+GS5LOAz2QFpaHfDgBvmeYqYDGf99xXjN6I211u/4nVjmfnl3asQWskI3rzQwdhhY7MPbCfNyIRHrhs2vRtT7k1R9UsCCBWoxNkIfNeuxKajzbifZQgqFt5V4aJ1ZPmwrm7AmGFjGjCRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49PLg98LpjBGtF+deZsBwiDRJinyKju40W/hXksdshg=;
 b=Sw3iIzhFqJn/kVTDuHCsw01IPDsmojNF6rAEUT9cDJK17gLUdA803urJN1ulTLxe5N/yxl+mrh/FPnaxxl2nj/L76pbQTHyraptBOmo9ci0NVEMmbwACB4Zx4SIVN1VsikVsLqY9wJq1KyFJ6FkUijILqFYE3zSOFzc2gdIKgJJyEh+QgCVVBHw8Hbs+y2PSaW96YlvkcFDuBklGBYsold3j3DsNJXa0xdEgAnZiAnbzSkkVA5SVUs7JQ7fqE4xDVjas+0rU3EB8FFh0pDJIgdOlbzLZqYF4DeM+IrPNb/n8VFickScuGFitya68gZgGWvcy4whn0XB7l8DOt/ZkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49PLg98LpjBGtF+deZsBwiDRJinyKju40W/hXksdshg=;
 b=jqz/HrZmB6csJsl9emIpLMiSkX4J/U+soOx4t3sRYIjMIf1SAwY9oEOCPHlsRnYj5m8tzJpoW0q2a6ivAMRQ1OqAv9t/PfhYS9vr1OtLr2ECCA+2Fd4eZ1y7V8HBMwwXfXTC30o//OO1LTJAvP+yHfo92tM/gONDasPA09JXesg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MN2PR21MB1454.namprd21.prod.outlook.com (2603:10b6:208:208::11)
 by SN7PR21MB3824.namprd21.prod.outlook.com (2603:10b6:806:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 17:11:17 +0000
Received: from MN2PR21MB1454.namprd21.prod.outlook.com
 ([fe80::ef62:5020:8772:8bd]) by MN2PR21MB1454.namprd21.prod.outlook.com
 ([fe80::ef62:5020:8772:8bd%4]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 17:11:17 +0000
From:   Wei Hu <weh@microsoft.com>
To:     netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, longli@microsoft.com,
        sharmaajay@microsoft.com, jgg@ziepe.ca, leon@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, vkuznets@redhat.com,
        ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com,
        weh@microsoft.com
Subject: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib driver.
Date:   Fri, 28 Jul 2023 17:07:49 +0000
Message-Id: <20230728170749.1888588-1-weh@microsoft.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::24) To MN2PR21MB1454.namprd21.prod.outlook.com
 (2603:10b6:208:208::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR21MB1454:EE_|SN7PR21MB3824:EE_
X-MS-Office365-Filtering-Correlation-Id: a52db633-00cf-43d2-4b52-08db8f8da77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBvWU6Y+fj9bSLhw+nW8LPHcupqyeUJktUt4ZC1GcjzS1ypKe2vBC/0BW2afH5ANrE6g7V/3zx+YzC/EfCprXQA841t4bCExr4l3f1J7czWtSp00Ol7Vp29/adJtIKinkSUb5WR8LE8o1GNUJf1MHmpR/XyypZZbqCaD9ACl0x2GryPzp7ttoJDOy3JAzmrq7sHEt3OcRcJp+naQdjnt802e1MJ/t8ALQCi6iJsQiS+MMEWZqzQhRvNyqEfRxSWvAqxTb5cdHGCPVezciAcnRuFoi01mfoCJfnqXwdnODZO/VbqzfiMTaOhlNQGQsZBrecsjso2C0RyYaQI12Jhtipg2FSDxmMmVTDJLMiFBz1UVfN4SIWvqHjBV5ca4guwAolNwR5RFG+3BJ0hhXuGhdJRkeUhrE5T1brPJR5iEe5prOs30OVmSZDceVyacnjowH14IwdVyMPkgGDXI0ws6R58JY8zOfamYUecwOmoiRLZUjCJbMjxdFNxw6yoSIda40pc7CfpPvMFcD/oJf9+IdndvvI4Jt+vZe1s7Vwm4ecHVCVyULI0cBbzlX7kR3CozXX1Cfv/n9zy13GrxsJvs+DZP+r3qQZ2mTdMtL94TXBza+9yTDCZ7UTFWayEh4G/tyspaBSO4Hm5pv3GfN4w6gpa5NiiDXWCQjBSUsaAfnO+r3LKyDmTEAlXQSGty85VB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1454.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(38350700002)(41300700001)(478600001)(6512007)(8936002)(8676002)(921005)(38100700002)(82950400001)(10290500003)(82960400001)(66946007)(66556008)(66476007)(6666004)(66899021)(316002)(2616005)(6486002)(52116002)(83380400001)(86362001)(2906002)(6506007)(36756003)(30864003)(5660300002)(1076003)(7416002)(186003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmLKmuNZwUpiS/N4t1WA1YUsZH+qykdima5w7gK1BC5CiAInnm1BcYaI8sBQ?=
 =?us-ascii?Q?QMzPRGkR3h0fJGA+5yYdadf0lWrip7nh0WrxYHWlmp1KhAcOJW5MZ23ZZ3PL?=
 =?us-ascii?Q?w2GSyKtbgmamrDkt/uOV+NK2I2D+dM4Fma0DAEEaHAm1mrM9Oi0mCh1D5MJs?=
 =?us-ascii?Q?gVFjBFx+WPIjSlRIqLghrCXHN2tytfDzhU9pw2AJKf4u66Kj8asRgdP+cM0T?=
 =?us-ascii?Q?UZuwXXilZy9LJCaldS6e2iuwMcORbcFLhaGy4W/hejJk7r+gK466WPk0zCXh?=
 =?us-ascii?Q?hKMsYtKUJkbyL+lIwOplCCyzvyTiUu8VKS1BSNPgVg3x/xlri3KPd5fU9nUd?=
 =?us-ascii?Q?9US7NfQLg/L117r/jJyNqY2U3zME1aN1L59AIWEvuJNa8VPlL8YhJ5KWiRUU?=
 =?us-ascii?Q?GRG/fEle7c30yJZsmX296DbnRtTI8fUWs2gE4E2emFFTfVvaOUhV4zJ9FtHP?=
 =?us-ascii?Q?aj7Rl1DXJAbPBoLeAyPiynWfzyhjGR+11ftYBshJfkoBbbcqe69LlwyUr53w?=
 =?us-ascii?Q?eKY0Daj55m5lRVjhqkdD4sT4C1nAye2+G5gitn0Ri9cQIbQbKYzIzM8mlQ/v?=
 =?us-ascii?Q?biNQ7IxlhJSXHoUU7GdstKJBzb7J9vRt+WsYRpnBAqnLDDzI3O7oiIgH1suu?=
 =?us-ascii?Q?WHlRXm0+mUT8+6W9csJiwYCy8k1BdqSKgcdhZV8nK66qG77rZxllCGFn8Bs5?=
 =?us-ascii?Q?hW4qroBnU1q8tbqrzqjDSGy4oqk5GZFjOTZ5jBPeFndTiuWiyePyC6xHRtmv?=
 =?us-ascii?Q?xx140rX1jykAtB52SntnoikwTw/uVGzMafEYgbmuXuBkxzZYS8kLdVGXw7qW?=
 =?us-ascii?Q?WwU7zyzT0S4HavnrV40ozlQgB1RaARG0axUEjjO9rqTNBfpUs/AUlYspomRU?=
 =?us-ascii?Q?8Q/ys9xM7M7tF/i6gAOeD7DP5IuMkOi25xvnDgywYH4cLo+zeiac/fOcvK8c?=
 =?us-ascii?Q?btmuMC9vJQ9PlbbRAJb2mjnc1EUAlY8F1D2i2o4IyUEcsRQa9tO+Mq3qh0IB?=
 =?us-ascii?Q?w/pCAMNUxiQsvtRt5943zA2iS524YAVTZ6vaYH/VJuPQfT6Uq3jDKfhSZwVv?=
 =?us-ascii?Q?jLJulm1cIKyfk5DGn4IogPJyDref/t/Q6gxLsUgjBHlXE2H7fP5E88jc40qi?=
 =?us-ascii?Q?iigRi+g7iQ37h86E6crGkXgn/DyVYltIcLYSRWs8yj1yoCpr8lKlguTQxMiR?=
 =?us-ascii?Q?UhrZ8qY5nT04Ow4ZnFyr+p85AfsImC3DIrXCwrTogCOWVMzgoRlGQNQRrr1V?=
 =?us-ascii?Q?gnQORI39dROuZSOflYpa8pAwp2T5mPVZnIyd5w5sw+iPrzWgTEdyCipBuapX?=
 =?us-ascii?Q?/Cvu35tJjIPiJDwoyY31upIEBMrVK+e2caE8G/9/Zqzs1ZEngfO7qNfPBZYQ?=
 =?us-ascii?Q?DYGmh1obV6zI3F1k9sdXXfr3xLWRmR5zSte06C0DJaaJj5nBPw8mD4rzUcIR?=
 =?us-ascii?Q?vEiSzb7TNRQSY9foOtmTjqXBApWlrM90+PhO5+2/vs3bjWUlAdyMC3aVXv0T?=
 =?us-ascii?Q?P3fnhEw50KsI5Jbx3yH00To51ojx+eI/XSp5vrUecZNvojnmVtfuRvAF3UqK?=
 =?us-ascii?Q?XRO4ILZk2oFPEcsr7xt17F+52xRvHfKRI8lOVJm6?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52db633-00cf-43d2-4b52-08db8f8da77a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1454.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:11:17.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVmOD7jOnFz0+bLfNOxGGYOcEzfxCICHirvx/pzKDZ13G3Itug7kzJHKZkfH+/j0Fv0X01y5Gop5XJDmwaatNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3824
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
handler when completion interrupt happens. EQs are destroyed when
ucontext is deallocated.

The change calls some public APIs in mana ethernet driver to
allocate EQs and other resources. Ehe EQ process routine is also shared
by mana ethernet and mana ib drivers.

Co-developed-by: Ajay Sharma <sharmaajay@microsoft.com>
Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
Signed-off-by: Wei Hu <weh@microsoft.com>
---

v2: Use ibdev_dbg to print error messages and return -ENOMEN
    when kzalloc fails.

v3: Check return value on mana_ib_gd_destroy_dma_region(). Remove most
    debug prints.

v4: Fix couple nits and performed thorough test in production evn.

 drivers/infiniband/hw/mana/cq.c               |  35 ++++-
 drivers/infiniband/hw/mana/main.c             |  84 +++++++++++
 drivers/infiniband/hw/mana/mana_ib.h          |   4 +
 drivers/infiniband/hw/mana/qp.c               |  79 ++++++++++-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 131 ++++++++++--------
 drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
 include/net/mana/gdma.h                       |   9 +-
 7 files changed, 278 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index d141cab8a1e6..6865dab66d48 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -12,13 +12,20 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
+	struct gdma_context *gc;
+	struct gdma_dev *gd;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gd = mdev->gdma_dev;
+	gc = gd->gdma_context;
 
 	if (udata->inlen < sizeof(ucmd))
 		return -EINVAL;
 
+	cq->comp_vector = attr->comp_vector > gc->max_num_queues ?
+				0 : attr->comp_vector;
+
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
 		ibdev_dbg(ibdev,
@@ -69,11 +76,35 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_dev *mdev;
+	struct gdma_context *gc;
+	struct gdma_dev *gd;
+	int err;
+
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gd = mdev->gdma_dev;
+	gc = gd->gdma_context;
+
 
-	mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
-	ib_umem_release(cq->umem);
+
+	if (atomic_read(&ibcq->usecnt) == 0) {
+		err = mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
+		if (err) {
+			ibdev_dbg(ibdev,
+				  "Failed to destroy dma region, %d\n", err);
+			return err;
+		}
+		kfree(gc->cq_table[cq->id]);
+		gc->cq_table[cq->id] = NULL;
+		ib_umem_release(cq->umem);
+	}
 
 	return 0;
 }
+
+void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
+{
+	struct mana_ib_cq *cq = ctx;
+
+	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+}
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 7be4c3adb4e2..b20a6c6c1de1 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -143,6 +143,78 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return err;
 }
 
+static void mana_ib_destroy_eq(struct mana_ib_ucontext *ucontext,
+			       struct mana_ib_dev *mdev)
+{
+	struct gdma_context *gc = mdev->gdma_dev->gdma_context;
+	struct gdma_queue *eq;
+	int i;
+
+	if (!ucontext->eqs)
+		return;
+
+	for (i = 0; i < gc->max_num_queues; i++) {
+		eq = ucontext->eqs[i].eq;
+		if (!eq)
+			continue;
+
+		mana_gd_destroy_queue(gc, eq);
+	}
+
+	kfree(ucontext->eqs);
+	ucontext->eqs = NULL;
+}
+
+static int mana_ib_create_eq(struct mana_ib_ucontext *ucontext,
+			     struct mana_ib_dev *mdev)
+{
+	struct gdma_queue_spec spec = {};
+	struct gdma_queue *queue;
+	struct gdma_context *gc;
+	struct ib_device *ibdev;
+	struct gdma_dev *gd;
+	int err;
+	int i;
+
+	if (!ucontext || !mdev)
+		return -EINVAL;
+
+	ibdev = ucontext->ibucontext.device;
+	gd = mdev->gdma_dev;
+
+	gc = gd->gdma_context;
+
+	ucontext->eqs = kcalloc(gc->max_num_queues, sizeof(struct mana_eq),
+				GFP_KERNEL);
+	if (!ucontext->eqs)
+		return -ENOMEM;
+
+	spec.type = GDMA_EQ;
+	spec.monitor_avl_buf = false;
+	spec.queue_size = EQ_SIZE;
+	spec.eq.callback = NULL;
+	spec.eq.context = ucontext->eqs;
+	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_allocated = true;
+
+	for (i = 0; i < gc->max_num_queues; i++) {
+		spec.eq.msix_index = i;
+		err = mana_gd_create_mana_eq(gd, &spec, &queue);
+		if (err)
+			goto out;
+
+		queue->eq.disable_needed = true;
+		ucontext->eqs[i].eq = queue;
+	}
+
+	return 0;
+
+out:
+	ibdev_dbg(ibdev, "Failed to allocated eq err %d\n", err);
+	mana_ib_destroy_eq(ucontext, mdev);
+	return err;
+}
+
 static int mana_gd_destroy_doorbell_page(struct gdma_context *gc,
 					 int doorbell_page)
 {
@@ -225,7 +297,17 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 
 	ucontext->doorbell = doorbell_page;
 
+	ret = mana_ib_create_eq(ucontext, mdev);
+	if (ret) {
+		ibdev_dbg(ibdev, "Failed to create eq's , ret %d\n", ret);
+		goto err;
+	}
+
 	return 0;
+
+err:
+	mana_gd_destroy_doorbell_page(gc, doorbell_page);
+	return ret;
 }
 
 void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
@@ -240,6 +322,8 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev->gdma_dev->gdma_context;
 
+	mana_ib_destroy_eq(mana_ucontext, mdev);
+
 	ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
 	if (ret)
 		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 502cc8672eef..9672fa1670a5 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -67,6 +67,7 @@ struct mana_ib_cq {
 	int cqe;
 	u64 gdma_region;
 	u64 id;
+	u32 comp_vector;
 };
 
 struct mana_ib_qp {
@@ -86,6 +87,7 @@ struct mana_ib_qp {
 struct mana_ib_ucontext {
 	struct ib_ucontext ibucontext;
 	u32 doorbell;
+	struct mana_eq *eqs;
 };
 
 struct mana_ib_rwq_ind_table {
@@ -159,4 +161,6 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
+void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq);
+
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 54b61930a7fd..b8fcb7a8eae0 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -96,16 +96,20 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 	struct mana_ib_dev *mdev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
+	struct ib_ucontext *ib_ucontext = pd->uobject->context;
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
 	struct mana_ib_create_qp_rss ucmd = {};
+	struct mana_ib_ucontext *mana_ucontext;
 	struct gdma_dev *gd = mdev->gdma_dev;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
+	struct gdma_queue *gdma_cq;
 	struct mana_context *mc;
 	struct net_device *ndev;
 	struct mana_ib_cq *cq;
 	struct mana_ib_wq *wq;
+	struct mana_eq *eq;
 	unsigned int ind_tbl_size;
 	struct ib_cq *ibcq;
 	struct ib_wq *ibwq;
@@ -114,6 +118,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	int ret;
 
 	mc = gd->driver_data;
+	mana_ucontext =
+		container_of(ib_ucontext, struct mana_ib_ucontext, ibucontext);
 
 	if (!udata || udata->inlen < sizeof(ucmd))
 		return -EINVAL;
@@ -180,6 +186,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	for (i = 0; i < ind_tbl_size; i++) {
 		struct mana_obj_spec wq_spec = {};
 		struct mana_obj_spec cq_spec = {};
+		unsigned int max_num_queues = gd->gdma_context->max_num_queues;
 
 		ibwq = ind_tbl->ind_tbl[i];
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
@@ -193,7 +200,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq_spec.gdma_region = cq->gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
-		cq_spec.attached_eq = GDMA_CQ_NO_EQ;
+		eq = &mana_ucontext->eqs[cq->comp_vector % max_num_queues];
+		cq_spec.attached_eq = eq->eq->id;
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
 					 &wq_spec, &cq_spec, &wq->rx_object);
@@ -215,6 +223,22 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		resp.entries[i].wqid = wq->id;
 
 		mana_ind_table[i] = wq->rx_object;
+
+		if (gd->gdma_context->cq_table[cq->id] == NULL) {
+
+			gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+			if (!gdma_cq) {
+				ret = -ENOMEM;
+				goto free_cq;
+			}
+
+			gdma_cq->cq.context = cq;
+			gdma_cq->type = GDMA_CQ;
+			gdma_cq->cq.callback = mana_ib_cq_handler;
+			gdma_cq->id = cq->id;
+			gd->gdma_context->cq_table[cq->id] = gdma_cq;
+		}
+
 	}
 	resp.num_entries = i;
 
@@ -224,7 +248,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 					 ucmd.rx_hash_key_len,
 					 ucmd.rx_hash_key);
 	if (ret)
-		goto fail;
+		goto free_cq;
 
 	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
 	if (ret) {
@@ -238,6 +262,23 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 	return 0;
 
+free_cq:
+	{
+		int j = i;
+		u64 cqid;
+
+		while (j-- > 0) {
+			cqid = resp.entries[j].cqid;
+			gdma_cq = gd->gdma_context->cq_table[cqid];
+			cq = gdma_cq->cq.context;
+			if (atomic_read(&cq->ibcq.usecnt) == 0) {
+				kfree(gd->gdma_context->cq_table[cqid]);
+				gd->gdma_context->cq_table[cqid] = NULL;
+			}
+		}
+
+	}
+
 fail:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
@@ -269,10 +310,12 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
 	struct mana_port_context *mpc;
+	struct gdma_queue *gdma_cq;
 	struct mana_context *mc;
 	struct net_device *ndev;
 	struct ib_umem *umem;
-	int err;
+	struct mana_eq *eq;
+	int err, eq_vec;
 	u32 port;
 
 	mc = gd->driver_data;
@@ -350,7 +393,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.gdma_region = send_cq->gdma_region;
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
-	cq_spec.attached_eq = GDMA_CQ_NO_EQ;
+	eq_vec = send_cq->comp_vector % gd->gdma_context->max_num_queues;
+	eq = &mana_ucontext->eqs[eq_vec];
+	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
 				 &cq_spec, &qp->tx_object);
@@ -368,6 +413,23 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	qp->sq_id = wq_spec.queue_index;
 	send_cq->id = cq_spec.queue_index;
 
+	if (gd->gdma_context->cq_table[send_cq->id] == NULL) {
+
+		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+		if (!gdma_cq) {
+			err = -ENOMEM;
+			goto err_destroy_wqobj_and_cq;
+		}
+
+		gdma_cq->cq.context = send_cq;
+		gdma_cq->type = GDMA_CQ;
+		gdma_cq->cq.callback = mana_ib_cq_handler;
+		gdma_cq->id = send_cq->id;
+		gd->gdma_context->cq_table[send_cq->id] = gdma_cq;
+	} else {
+		gdma_cq = gd->gdma_context->cq_table[send_cq->id];
+	}
+
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
 		  qp->tx_object, qp->sq_id, send_cq->id);
@@ -381,12 +443,17 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed copy udata for create qp-raw, %d\n",
 			  err);
-		goto err_destroy_wq_obj;
+		goto err_destroy_wqobj_and_cq;
 	}
 
 	return 0;
 
-err_destroy_wq_obj:
+err_destroy_wqobj_and_cq:
+	if (atomic_read(&send_cq->ibcq.usecnt) == 0) {
+		kfree(gdma_cq);
+		gd->gdma_context->cq_table[send_cq->id] = NULL;
+	}
+
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
 
 err_destroy_dma_region:
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8f3f78b68592..16e4b049a6c8 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -368,53 +368,57 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	}
 }
 
-static void mana_gd_process_eq_events(void *arg)
+static void mana_gd_process_eq_events(struct list_head *eq_list)
 {
 	u32 owner_bits, new_bits, old_bits;
 	union gdma_eqe_info eqe_info;
 	struct gdma_eqe *eq_eqe_ptr;
-	struct gdma_queue *eq = arg;
 	struct gdma_context *gc;
+	struct gdma_queue *eq;
 	struct gdma_eqe *eqe;
 	u32 head, num_eqe;
 	int i;
 
-	gc = eq->gdma_dev->gdma_context;
+	list_for_each_entry_rcu(eq, eq_list, entry) {
+		gc = eq->gdma_dev->gdma_context;
 
-	num_eqe = eq->queue_size / GDMA_EQE_SIZE;
-	eq_eqe_ptr = eq->queue_mem_ptr;
+		num_eqe = eq->queue_size / GDMA_EQE_SIZE;
+		eq_eqe_ptr = eq->queue_mem_ptr;
 
-	/* Process up to 5 EQEs at a time, and update the HW head. */
-	for (i = 0; i < 5; i++) {
-		eqe = &eq_eqe_ptr[eq->head % num_eqe];
-		eqe_info.as_uint32 = eqe->eqe_info;
-		owner_bits = eqe_info.owner_bits;
+		/* Process up to 5 EQEs at a time, and update the HW head. */
+		for (i = 0; i < 5; i++) {
+			eqe = &eq_eqe_ptr[eq->head % num_eqe];
+			eqe_info.as_uint32 = eqe->eqe_info;
+			owner_bits = eqe_info.owner_bits;
 
-		old_bits = (eq->head / num_eqe - 1) & GDMA_EQE_OWNER_MASK;
-		/* No more entries */
-		if (owner_bits == old_bits)
-			break;
+			old_bits =
+				(eq->head / num_eqe - 1) & GDMA_EQE_OWNER_MASK;
+			/* No more entries */
+			if (owner_bits == old_bits)
+				break;
 
-		new_bits = (eq->head / num_eqe) & GDMA_EQE_OWNER_MASK;
-		if (owner_bits != new_bits) {
-			dev_err(gc->dev, "EQ %d: overflow detected\n", eq->id);
-			break;
-		}
+			new_bits = (eq->head / num_eqe) & GDMA_EQE_OWNER_MASK;
+			if (owner_bits != new_bits) {
+				dev_err(gc->dev, "EQ %d: overflow detected\n",
+					eq->id);
+				break;
+			}
 
-		/* Per GDMA spec, rmb is necessary after checking owner_bits, before
-		 * reading eqe.
-		 */
-		rmb();
+			/* Per GDMA spec, rmb is necessary after checking
+			 * owner_bits, before reading eqe.
+			 */
+			rmb();
 
-		mana_gd_process_eqe(eq);
+			mana_gd_process_eqe(eq);
 
-		eq->head++;
-	}
+			eq->head++;
+		}
 
-	head = eq->head % (num_eqe << GDMA_EQE_OWNER_BITS);
+		head = eq->head % (num_eqe << GDMA_EQE_OWNER_BITS);
 
-	mana_gd_ring_doorbell(gc, eq->gdma_dev->doorbell, eq->type, eq->id,
-			      head, SET_ARM_BIT);
+		mana_gd_ring_doorbell(gc, eq->gdma_dev->doorbell, eq->type,
+				      eq->id, head, SET_ARM_BIT);
+	}
 }
 
 static int mana_gd_register_irq(struct gdma_queue *queue,
@@ -432,44 +436,47 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 	gc = gd->gdma_context;
 	r = &gc->msix_resource;
 	dev = gc->dev;
+	msi_index = spec->eq.msix_index;
 
 	spin_lock_irqsave(&r->lock, flags);
 
-	msi_index = find_first_zero_bit(r->map, r->size);
-	if (msi_index >= r->size || msi_index >= gc->num_msix_usable) {
-		err = -ENOSPC;
-	} else {
-		bitmap_set(r->map, msi_index, 1);
-		queue->eq.msix_index = msi_index;
-	}
-
-	spin_unlock_irqrestore(&r->lock, flags);
+	if (!spec->eq.msix_allocated) {
+		msi_index = find_first_zero_bit(r->map, r->size);
+		if (msi_index >= r->size || msi_index >= gc->num_msix_usable)
+			err = -ENOSPC;
+		else
+			bitmap_set(r->map, msi_index, 1);
 
-	if (err) {
-		dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
-			err, msi_index, r->size, gc->num_msix_usable);
+		if (err) {
+			dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
+				err, msi_index, r->size, gc->num_msix_usable);
 
-		return err;
+			goto out;
+		}
 	}
 
+	queue->eq.msix_index = msi_index;
 	gic = &gc->irq_contexts[msi_index];
 
-	WARN_ON(gic->handler || gic->arg);
-
-	gic->arg = queue;
+	list_add_rcu(&queue->entry, &gic->eq_list);
 
 	gic->handler = mana_gd_process_eq_events;
 
-	return 0;
+out:
+	spin_unlock_irqrestore(&r->lock, flags);
+
+	return err;
 }
 
-static void mana_gd_deregiser_irq(struct gdma_queue *queue)
+static void mana_gd_deregister_irq(struct gdma_queue *queue)
 {
 	struct gdma_dev *gd = queue->gdma_dev;
 	struct gdma_irq_context *gic;
 	struct gdma_context *gc;
 	struct gdma_resource *r;
 	unsigned int msix_index;
+	struct list_head *p, *n;
+	struct gdma_queue *eq;
 	unsigned long flags;
 
 	gc = gd->gdma_context;
@@ -480,13 +487,25 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 	if (WARN_ON(msix_index >= gc->num_msix_usable))
 		return;
 
+	spin_lock_irqsave(&r->lock, flags);
+
 	gic = &gc->irq_contexts[msix_index];
-	gic->handler = NULL;
-	gic->arg = NULL;
 
-	spin_lock_irqsave(&r->lock, flags);
-	bitmap_clear(r->map, msix_index, 1);
+	list_for_each_safe(p, n, &gic->eq_list) {
+		eq = list_entry(p, struct gdma_queue, entry);
+		if (queue == eq) {
+			list_del_rcu(&eq->entry);
+			break;
+		}
+	}
+
+	if (list_empty(&gic->eq_list)) {
+		gic->handler = NULL;
+		bitmap_clear(r->map, msix_index, 1);
+	}
+
 	spin_unlock_irqrestore(&r->lock, flags);
+	synchronize_rcu();
 
 	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 }
@@ -550,7 +569,7 @@ static void mana_gd_destroy_eq(struct gdma_context *gc, bool flush_evenets,
 			dev_warn(gc->dev, "Failed to flush EQ: %d\n", err);
 	}
 
-	mana_gd_deregiser_irq(queue);
+	mana_gd_deregister_irq(queue);
 
 	if (queue->eq.disable_needed)
 		mana_gd_disable_queue(queue);
@@ -565,7 +584,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	u32 log2_num_entries;
 	int err;
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
+	queue->eq.msix_index = spec->eq.msix_index;
 
 	log2_num_entries = ilog2(queue->queue_size / GDMA_EQE_SIZE);
 
@@ -602,6 +621,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	mana_gd_destroy_eq(gc, false, queue);
 	return err;
 }
+EXPORT_SYMBOL(mana_gd_create_mana_eq);
 
 static void mana_gd_create_cq(const struct gdma_queue_spec *spec,
 			      struct gdma_queue *queue)
@@ -873,6 +893,7 @@ void mana_gd_destroy_queue(struct gdma_context *gc, struct gdma_queue *queue)
 	mana_gd_free_memory(gmi);
 	kfree(queue);
 }
+EXPORT_SYMBOL(mana_gd_destroy_queue);
 
 int mana_gd_verify_vf_version(struct pci_dev *pdev)
 {
@@ -1188,7 +1209,7 @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
 	struct gdma_irq_context *gic = arg;
 
 	if (gic->handler)
-		gic->handler(gic->arg);
+		gic->handler(&gic->eq_list);
 
 	return IRQ_HANDLED;
 }
@@ -1241,7 +1262,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	for (i = 0; i < nvec; i++) {
 		gic = &gc->irq_contexts[i];
 		gic->handler = NULL;
-		gic->arg = NULL;
+		INIT_LIST_HEAD(&gic->eq_list);
 
 		if (!i)
 			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 06d6292e09b3..85345225813f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1156,6 +1156,7 @@ static int mana_create_eq(struct mana_context *ac)
 	spec.eq.callback = NULL;
 	spec.eq.context = ac->eqs;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_allocated = false;
 
 	for (i = 0; i < gc->max_num_queues; i++) {
 		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 96c120160f15..cc728fc42043 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -6,6 +6,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/netdevice.h>
+#include <linux/list.h>
 
 #include "shm_channel.h"
 
@@ -291,6 +292,8 @@ struct gdma_queue {
 	u32 head;
 	u32 tail;
 
+	struct list_head entry;
+
 	/* Extra fields specific to EQ/CQ. */
 	union {
 		struct {
@@ -325,6 +328,8 @@ struct gdma_queue_spec {
 			void *context;
 
 			unsigned long log2_throttle_limit;
+			bool msix_allocated;
+			unsigned int msix_index;
 		} eq;
 
 		struct {
@@ -340,8 +345,8 @@ struct gdma_queue_spec {
 #define MANA_IRQ_NAME_SZ 32
 
 struct gdma_irq_context {
-	void (*handler)(void *arg);
-	void *arg;
+	void (*handler)(struct list_head *arg);
+	struct list_head eq_list;
 	char name[MANA_IRQ_NAME_SZ];
 };
 
-- 
2.25.1

