Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523F641F53
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Dec 2022 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLDTyV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 4 Dec 2022 14:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiLDTyP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 4 Dec 2022 14:54:15 -0500
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11020022.outbound.protection.outlook.com [52.101.46.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374A10FC3;
        Sun,  4 Dec 2022 11:54:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljOMk3vhwmALLyy3clSW/TKvzZdrl54kQ0n22j75Y02bMlzMPqiPFMIrJWd2i6JptYvlbKNA0PekFZ8pYukZDSR2H6MEyFZZgrlTyWy1TCKTzFvx/NL3MbEQj/XstCExuxwg+qNdKq+3yL2Axru6l+vjnjdhbL2+0x5B4JTRSpA9QQkpbb2F9DVSZG2KwhMSVPhYANT0ffJVzo9fnEkPVyjv8htNTsaeNYH0Z+N4cF8D2JDvjsmrnhDp8ZJKzh0B2UfzRr/20QWDOF+DCkAQobcPshql1ixDJl3YCWXQPy0nIczmNrmwxHM/AymLAEzg1Eo0rssHr4FEw2juTinIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTmxjx4xcwcuYJEz0sqBD/y2s7ZYVVtD+XeJD+G5JTo=;
 b=HeAuPJQ27opI0tUJ0hEtj/oJVCkXdodunyiKbXWIo6ItAeoK9T2lW+A359vc4AvotMY31lzjW8t0wUsVOKRKI/h4iL125izPRE6CpJdz6v9Gc7oECpF+4VdOADAXA0pBkQEN1SwcA/pmhfsmGvNACP7ekNsoYlKecsamxvQl+aYOkqyMh9YIrTbhmFDRQbyAUt01c22wheIM2QDydXP7UcTvAygKfUHbNCZJCtrRf+NDPe1bsoJoj6QztmhAdKD44H3z8gG75JiYvzaCT1wldYxE2ASDdten3Tfel4vfi6/gnUPgCxnSB0rsvfIp4nnzQDA4U8tCK1muOzUKvcFdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTmxjx4xcwcuYJEz0sqBD/y2s7ZYVVtD+XeJD+G5JTo=;
 b=d0IKc25ZUU7RPvNeGO0xwgseEFZ6oThsVfjfiRkDnaRjV2iFcCDRxnS81UHeDnzdn/3eePvmoimgPbqT5ZmUz0Hx627UQXtTpF2w3S+KhQwna4Sv+Flm6ZL78DIUroDpXbYhUnZSrbniohYk9RIU1PZhrH5U7bipi8v37TcQDg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by CY5PR21MB3756.namprd21.prod.outlook.com (2603:10b6:930:d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.3; Sun, 4 Dec
 2022 19:54:12 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c3e3:a6ef:232c:299b]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c3e3:a6ef:232c:299b%8]) with mapi id 15.20.5924.004; Sun, 4 Dec 2022
 19:54:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Fix swiotlb bounce buffer leak in confidential VM
Date:   Sun,  4 Dec 2022 11:52:44 -0800
Message-Id: <1670183564-76254-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|CY5PR21MB3756:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbcc5a5-bfe9-4945-62f0-08dad6315045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRAyWa3WZYPCW8jutXcH3AlrqMk/4Wm/dmc43lNKDYb/FOR+MbwpxkDiSEeSc8DRUlFCnKjsv5zjrFBJTSnyMJ+NudK23L7R+eJ0JYzgXUySGxVLoflgd3eE/8D/7poCE9h4yc91MFNXr906+Vmeb/Oln9ryj586Px44+sls54KGYYvJdE9EUojajafOvlH/vRhubVi0Ud7mT4SK5RnHUB55NW4xjs/VB5PUOmOfN2ejW7ulAQAMQaqXSRflI6hKkTS9N7kw4x72UcB4UYWTL+xik6RBROuf59je/e6WPQwyI6fCHAM7Gtm8D4d0o5cbVoUuqm3PFJFRPl8NMRzHVjryPVooKizwr58S+BsdV8iMKkDBDzhjj/R74FYi3t6opzvmrd3ESMBU3oSatQY1uh6bzQc+a3Yjs8zigaHR80HmpXIPTrwfZAZTDe94wlTvSd6A5jGsxkJuuFTdH60iKi6XHWgyt19YLLYSCP+yrjTpE9sQJpHXjk26MdtVQC/+sCgGHaaw7BGcuL33k5k0xgUOvapGPZeUiZZtJsKABU92msGt1lXV6wsPjYcnwORjZe9/fi2ag7zVK0/40ZRjFt3vIWANOr56fD6+4OapniKFnTih1PkLx/kcAUWNCbT3STNsUWOkOkx4qg+U0zih53Jd6nXYoU80/JCopOSJQnwLqeq1Hby1TcIdwFzUJ36pQhn5yovhxoqKo/7mnecLUlyj0CD79QKb2YOu0Gx2KfxH0N5A7VyFQirO3e6XDvPF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(2906002)(82950400001)(5660300002)(82960400001)(38100700002)(38350700002)(86362001)(83380400001)(186003)(26005)(6512007)(478600001)(107886003)(6666004)(6506007)(10290500003)(6486002)(52116002)(8676002)(66556008)(316002)(4326008)(66476007)(41300700001)(8936002)(2616005)(36756003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rW6vaa10sCVG+Edgj9tSsRM1nV0oEk7/0j5oIrLyZQ2tAOfk3f5NyXWuGnX8?=
 =?us-ascii?Q?PfkqGCz2IMDKHc6F638CTFuN2phWQ1k67+IpY1AbO7CCLtxD+eBFrdM1pcI7?=
 =?us-ascii?Q?mRRyqofhbQw7pqX/PQ6YuGfdI+74j0GvUkXtV3SWADlnGq9hWTAOKuxyJKZw?=
 =?us-ascii?Q?Xl7iie0ri5ZGyL1SCFe7gpD23QPmKxr+zoIl9IQy2lIRKKxyL4WK2SommypM?=
 =?us-ascii?Q?CjGt1nRECvonoQB+ziQoLqA7Ukd1vuEyGmLFhrAUdKwq3gYuzMCWWxKflp5P?=
 =?us-ascii?Q?Rwn5cg7lWv5oarm+B4tsgGc47Gf02gkJe2oUlEWS/I1h9YQg4jL343agMh/M?=
 =?us-ascii?Q?CuRInfksnW2MnXaeFN/lMUumlQFoQrRgGMQ5BJElYEgbiJtE7Hqm4oDZUqYT?=
 =?us-ascii?Q?ZTBJfDwZr3H/utmZ97HpZJmvF/kUiczyuRHN2IHsDcCbiph5vNo++MW0jrJ/?=
 =?us-ascii?Q?fjZfdyFVWMXnXP+LwuOMaNMXYkglTKAqnp4fT07mcBU1MCX+t7DW0YvlVKLd?=
 =?us-ascii?Q?x0ByYPX0UEBV3thJqJDzC+3YRbEeAY2GmhwTQ3ZJpaF2Kq7r1TrKjRlunN4I?=
 =?us-ascii?Q?vFc6voeWqRfANiaPXEJH8s7ejYP9eqkqdf0n/MMfK45ZYCYKsfyZl20A+vvc?=
 =?us-ascii?Q?3u5kvJvMzhDzcWKQkxJ/5J0j78tYetZBR+WRXKLywoyArp52okHN4cqZD2qD?=
 =?us-ascii?Q?qpsDz76uWvOfjo1iWovZ97JCy0wwUJ+lRusVoN3DvFsRikTWJKnYJuU4SpRX?=
 =?us-ascii?Q?b8aPBdY0EhxyjvFjU02Xi0itu6iXi7aiWIETuTQxbB7+o+K6dkOIvE/+Lz0n?=
 =?us-ascii?Q?9AFD1I0dRyhNSWlw6UrwOTXz5odrIfygarfLPZyqj1lCSix6v48Nm7UU7u7V?=
 =?us-ascii?Q?KjUSzuI3aG0LxUwUr8+BONhWCbyCQK3+/S2PRcumktvlHGcaJW4do4vtHvCT?=
 =?us-ascii?Q?esHtA6b+bfx5LcZLT2MX50qY36tW/XSiim2/VjD1UjnRwSs31Wb9eDWeH1l9?=
 =?us-ascii?Q?YNBZCF8GxZqlAxEG8us/0LcADyIJy0lbwTnuNapSg7qLyR2Br81E98lWOEXv?=
 =?us-ascii?Q?Dee19jGQsFAvlkTVfy06XLSoqNDbCvUJSEleOu4G5Mx9Yzyo8WHmuAN676rZ?=
 =?us-ascii?Q?4W/0mI6H/QG95Sak3/A3hDa32/6XQPybEURB004zC1DItrYmAXxL/ysqBbYl?=
 =?us-ascii?Q?+Od7oY0HQk38Eo8LYTxNt1Jo9N4I4LcGmy9N0oF/5TjWnLA1FDVD1i7x2oga?=
 =?us-ascii?Q?F9vMgx66hwEsV5PSOd4zQsdaZxMy/TjZ97Anj3t01TXBY+f8Wn0V0LfLWipo?=
 =?us-ascii?Q?6EnXB8KVSe9XEnae89L1p/gwuVyC6uFhiTMZX5Wzpc0tdSDYA2/rqr6WdkqY?=
 =?us-ascii?Q?/5tpfU43S0r1ln4fQ9b9aQumKdKVBudZ4urdO2SwzHLbDRZbGq68NmUiGmp6?=
 =?us-ascii?Q?y08UzaZGpf2QFTXUx/ceopBmUuZNjX0n9Re6fTJG893lrYLsIrX5y4vjRDO9?=
 =?us-ascii?Q?4MgU9/cWiJ225o4cc/ZzJrpruCjEKeTp+ymjTcucE65kqdf4ua++jorX5Fv7?=
 =?us-ascii?Q?IGqfCsybecIpe5Yz0u+DHsBqRzjqwz3bV44tAKT9?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbcc5a5-bfe9-4945-62f0-08dad6315045
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 19:54:11.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3e8OZeyadT5Hl5Dyh29gJENMfmOvKeh/iWJa/BdDmLDWZLxSXORi11uT5TtaaWYr89+OOclBuGmlDyYRpY1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3756
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

storvsc_queuecommand() maps the scatter/gather list using scsi_dma_map(),
which in a confidential VM allocates swiotlb bounce buffers. If the
I/O submission fails in storvsc_do_io(), the I/O is typically retried
by higher level code, but the bounce buffer memory is never freed.
The mostly like cause of I/O submission failure is a full VMBus
channel ring buffer, which is not uncommon under high I/O loads.
Eventually enough bounce buffer memory leaks that the confidential
VM can't do any I/O. The same problem can arise in a non-confidential
VM with kernel boot parameter swiotlb=force.

Fix this by doing scsi_dma_unmap() in the case of an I/O submission
error, which frees the bounce buffer memory.

Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 3c5b7e4..55d6fb4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1823,6 +1823,9 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	ret = storvsc_do_io(dev, cmd_request, get_cpu());
 	put_cpu();
 
+	if (ret)
+		scsi_dma_unmap(scmnd);
+
 	if (ret == -EAGAIN) {
 		/* no more space */
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
-- 
1.8.3.1

