Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267375B936
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jul 2023 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGTVFh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jul 2023 17:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGTVFg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jul 2023 17:05:36 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C52196;
        Thu, 20 Jul 2023 14:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBJQdU6CUPNCBfMaFzG8hysogsv94RbY3cbbblSVW8qSSGeYyIWHW+2YRfRKw5C4xIw3nCqe1jWM/i7vkp4LqmIif7w0IUQF2DDCHnBzxlFtrwO2pyFtgYS2XFCOPgd4kddy5Dn7jh1VZd6gS6dfaSsjpQHrMELokXDnmYWv42rc8n/9kym4QkwBxAlw2nHhzGGECjqewy/wH9/Lh7K4/f+RiD2RF9vwIdtfejcGZSKQP0NheCMQOTibIqZ12Dg1iNQSn75sda7lE/Pa+hhqozLJPi7OV4vy/ksaAPsglsHRrEnET2GH+baXyMuNyhoKE1bzWqR6ZRlbm3wgivgXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2samRq9B+dMbI9687fQBJ9zkwc+sIZeOXsA7UR5tbRg=;
 b=cusvvPtxLO0JD/6o2T7bl7659z+/y+VQO2mXTIFwYkbFI7I8bXn1UP4FQg/nvk41bPuDn7U/A+rsqKVDNfKReY2uNtUPNF5AQfgILIjgOED16a4PSU7g9Qikpx+5xlfQtMWBmGcXWycEyT1LLGMG70DUtg0aQiWphj1pkkcXz1EMx2Ba0d8Vuqsf8rfwHD9mNITLtWPVrnMpR8IAeKMJ6W9SYbyC9hMnvLSG6hH4H2fqXGbfYb+FTwLXa3RSroKkQTVSkbczGODHOgY2S07fUCzt3h5BEGDQWgkLu7DDCd5NwXJI8BoZSIcCb01nMnGi1lgCy3+6h3N/szxhmWfpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2samRq9B+dMbI9687fQBJ9zkwc+sIZeOXsA7UR5tbRg=;
 b=aXCJqJur/7tkRhnyTl8rQzByFgRLzaFnEG6GXBFZ40DB9Hcya4lRA4PWFtGGWJUBgt5qNf/PrgniBMDZVAl9RRbBGSBrRkfPCLoD2K5hw40Pt3Yr8HRjiRGrhJl/5QrxC3jAWLNGtcopoeLEYADqi4IUI35NmdmBKq0QDUX2OGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by IA1PR21MB3451.namprd21.prod.outlook.com (2603:10b6:208:3e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.7; Thu, 20 Jul
 2023 21:05:32 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df%7]) with mapi id 15.20.6631.011; Thu, 20 Jul 2023
 21:05:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com, stable@vger.kernel.org
Subject: [PATCH 1/1] scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
Date:   Thu, 20 Jul 2023 14:05:02 -0700
Message-Id: <1689887102-32806-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:302:1::16) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|IA1PR21MB3451:EE_
X-MS-Office365-Filtering-Correlation-Id: 5085a2dd-466d-4208-999e-08db89650e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jYckPg+y+/uRBDoh05muZKdSDRIAZVkW7xGUyCewle8zcLygpWdQEHsm/EIVptZcISEI357J4S2/zk2gRj7zQp1yRbAQrqVA08fUwpn/9jbG2nc/j0WmFKjZpzjFP7N1eZSIse6JbuUEYiJ2CxpuEtFDZ5PV6iWH/WxcMarQ/o2Z/KKPe6J6AKWPHxu6a0Jtkuja6Z00+N0a0YRG1/YOprLikG6SO3el6nicduWTNpQAQuo2Zeiu+mAEigOm115OegChsIAaZLj5bMvE6YmTMy5p/bHyTiNL9IzdSXnEFtuQLTvI0/Z4mW+LFFGgQ+dl0xfS5gR9K2R6im2uS5wHpynj/RoKlrJ0mjHJBFEp/fecl/brqSaGw8zOPgWVX7UyS7pLkPPBrrXLcfnf1WzEo3ZSEXFD/UJVzCOKOuZc9kW7Ey3UnkrAexhzUBCYnOZLqhRvHcXJcuiENSL8K1EmA6iujjcxJOXWasJIBejCBiYw3SVnBaCW+IXborZ2W2hsMnU3EX6qRPGFO5IkaB2/TJxQrRhepyRqTnglXSK8q9KoMEX7TN05Lu1sBv4T+zuA/YxEcJXEabAXwiqcvDx6C5ioKoa0r2cX/jFLHJhte2qi571IjWO0fBIj1qOdP2by7iT4mHfSdgz4l5tlNd+4r+iFc8c/m65ZbDl3x7EuTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(82960400001)(82950400001)(38350700002)(38100700002)(36756003)(86362001)(186003)(6506007)(8936002)(8676002)(6512007)(83380400001)(41300700001)(2616005)(5660300002)(2906002)(478600001)(52116002)(10290500003)(316002)(6666004)(6486002)(66556008)(66476007)(66946007)(26005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrBOTVNhFMYHjPtunNwotHARMdWg9vu5tV3Am0U1pn1jnVFc7ecxUP2KSkdj?=
 =?us-ascii?Q?15W57b8QW9vq9deHO+Lr97AG8WLmApULNUu5dQjD8Ft18fVaEtBw+LJIumtB?=
 =?us-ascii?Q?IloFSJjIlaEzO0UzkN3FhtIEChN7S+F/9UX5mme0EebU8Tv6t33PCFpPCooF?=
 =?us-ascii?Q?Zn/vz/D5PjQLjtN/pKGq0WAsNavdf2eaOwFPR50Xbv8MhwCcKMOTsFgahz1/?=
 =?us-ascii?Q?qyALOCAL/5YZbvi3RSRDA4KnwHmVuH4rWWn5us3a/pY3xDLdezh4UCo+EVDR?=
 =?us-ascii?Q?6YbXr4Af05znvaJKnpLVBL9jo6D0ACm6IB38538mPoAaKl1/eDN5iV6t0gfU?=
 =?us-ascii?Q?XCpmCWF2D3rDvRIvmm9g8qbwgLCIAIeF9Rv8Zzxi6ELCcOkesSuZ1rFrEFd8?=
 =?us-ascii?Q?sMD/ear4y3O5A4sXpfhnGXFaxE91ye0p2kp+FNkP2G9/XsV1BlBwIVu28JQO?=
 =?us-ascii?Q?kthu2mApt8NQhbdZSmCOdgYNTHASZkIXyvBAjDfhSL2I90Nc5TQVctHcoiMD?=
 =?us-ascii?Q?vBT7X9qUS05a13+izLZdwkShz53pSIppRuYZdiRYIWyxKgU4GFP9MB0oOwmi?=
 =?us-ascii?Q?r1NdkCl5tlPJiMOcPj+dZbU/zBvb762wElbCpZMG5ymusGZwea8P2oebCVGt?=
 =?us-ascii?Q?ncOEPWDR+Njp5g1KMJQuoIzctmOHpBpFg/tvz45SVciKdEDuT/XAYmZpTK8m?=
 =?us-ascii?Q?34GbX9EDQTicoM8c7UfQJyWsnlj4hNPIYZuNSGSXDYYXzAdH/M7LwQVBS4Ae?=
 =?us-ascii?Q?1+WOuDXQygUiDnIH5m1YhmneO1vgC+/whackZ9ytgBpGcrki1b0mtgq/P93i?=
 =?us-ascii?Q?jUNaKu6LLlbVR5Dw6mXh+JpkZJ1IVU+bRN7ve0whSg8RVW9JHpj5G4iPM89w?=
 =?us-ascii?Q?u4n2Fq4xqi2NTc7eBeZISWm//wiPQ0aMzBaFeEQBRjr0jp4giaVsV0PUIqZ2?=
 =?us-ascii?Q?ARIbdGpmt7FwlVXTtXjBG5YxfMTwx8CxhAcgSdIyap264pJ9AYSZQfRXfznE?=
 =?us-ascii?Q?5PHkpsUtYdYZ/ee85LCk7y42WoIYipFFL1weXG1okTj9CvK1N+vLc3dk9pw5?=
 =?us-ascii?Q?h9hrkPfLJiQki33Dokbruq4nE4mAHfdt22bmK3SAiqfzvnRZbhyMYT5it2TM?=
 =?us-ascii?Q?eh9oZuxY7gCk/eoE04f1CGb8ltIauTh4kfODFLH2T+tDzP9nd+zoz/FIQaGU?=
 =?us-ascii?Q?bBFtFIGEjn2GZmfK4YcRqNr2ixLvBQWsHwg6Peebg4XdzJh8jJRBjN4VnPgR?=
 =?us-ascii?Q?ofBn3onRdvq9OvpSF9rsNQe3NaAUENdIoEDL0RZk5HiO/yNlSrQKkOgYekar?=
 =?us-ascii?Q?olaFh7n0mS1Kf2kC8DegCV16Rb7NLPL2jyQK2ctUu9N3vMWLWedNtlywMwGf?=
 =?us-ascii?Q?xF7xGiUCEHUgsrmhwHBpXL2GEU1SfUSACnJPykdymDGc+PlLLBwMFGfrnV7q?=
 =?us-ascii?Q?nnpfFi/pXaBq+BbJvjvjWir3MvVB4RAjPJpiqEgsCIhcFAe6586n4D99o4il?=
 =?us-ascii?Q?IpM9BYpOB4uoIyJKgc7umUUErNrc2x30MQhFhld3I2KbYzZrd5P1no3Ip6sV?=
 =?us-ascii?Q?ZJCu62cquUSBF8jVXzitz6qC2MjmpANWkkSTCUYX?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5085a2dd-466d-4208-999e-08db89650e1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 21:05:32.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjRc3hcG6nXEwwBJ2EOXee+Dp0zpACum7GFtmQ+zGJOdAEd5VRv88tMoEijCcwPyFy3nmAMa55+4LY+n7/LhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The Hyper-V host is queried to get the max transfer size that it
supports, and this value is used to set max_sectors for the synthetic
SCSI controller.  However, this max transfer size may be too large
for virtual Fibre Channel devices, which are limited to 512 Kbytes.
If a larger transfer size is used with a vFC device, Hyper-V always
returns an error, and storvsc logs a message like this where the SRB
status and SCSI status are both zero:

hv_storvsc <GUID>: tag#197 cmd 0x8a status: scsi 0x0 srb 0x0 hv 0xc0000001

Add logic to limit the max transfer size to 512 Kbytes for vFC devices.

Fixes: 1d3e0980782f ("scsi: storvsc: Correct reporting of Hyper-V I/O size limits")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7f12d93..f282321 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -366,6 +366,7 @@ enum storvsc_request_type {
 #define STORVSC_FC_MAX_LUNS_PER_TARGET			255
 #define STORVSC_FC_MAX_TARGETS				128
 #define STORVSC_FC_MAX_CHANNELS				8
+#define STORVSC_FC_MAX_XFER_SIZE			((u32)(512 * 1024))
 
 #define STORVSC_IDE_MAX_LUNS_PER_TARGET			64
 #define STORVSC_IDE_MAX_TARGETS				1
@@ -2006,6 +2007,9 @@ static int storvsc_probe(struct hv_device *device,
 	 * protecting it from any weird value.
 	 */
 	max_xfer_bytes = round_down(stor_device->max_transfer_bytes, HV_HYP_PAGE_SIZE);
+	if (is_fc)
+		max_xfer_bytes = min(max_xfer_bytes, STORVSC_FC_MAX_XFER_SIZE);
+
 	/* max_hw_sectors_kb */
 	host->max_sectors = max_xfer_bytes >> 9;
 	/*
-- 
1.8.3.1

