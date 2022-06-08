Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58385542749
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiFHGz5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Jun 2022 02:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbiFHFyL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jun 2022 01:54:11 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064021.outbound.protection.outlook.com [52.101.64.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DB392A1F;
        Tue,  7 Jun 2022 20:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzv/EZhxviljfn/wqhoi8O/JeduCKe2Mr4lF7ZqcyFTrWzSNwwZ0TRGhEkk3looOvJFkAkMvbvcmp+IZlAIvZkVhNwd70iufyF5CDkOINckYo8yyhlxvGYL2hl4FuBTl9WFgnxmRvNJ2lfliMkMY5Zf0DTHMW7XqV+wRUXmx9b7HPdB7k8y8kLk9BRtIgZXV80OqSi7c3mkOk1JPREMFpX+StbVbZRpi0KYt2RYxXb9KgrnCT8l1+bsqA9ALDad27Qavv3U4M1eAnhHyLjEf2Fqi+3K/8pUdohtDomr+iQqG81ZbHn09gpt9SqKKsg/eE11JFOU3FabNLVYH4kNcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQCEWsBoEhimCAQcWrgDX92W8vb2QCc3ZdPSMPj2VnI=;
 b=KLa3Q0Qxci73I25KT/6+wEQhAsSQbZf9p2eOsIBmTezGYMbA+IFCG4kLV86UgNsYPZktiUCU8IoDr9gLD3wQJtRP1rbGEOFtopIgEgwFClxqja1TO2wvLZ+q0RrqaqfKyvuIPZQFrQfnPb7c2wnATcLrn4BQ3DKQX53qUTB8k/e1EI9v3NKFFg9CCoqbspXgqSvc+yZIAR2tKzh/S8KtVZhQxQvb4utXarq1LK39dDSulyaJ5YsTEDCIHgVeAarnR5NuSgwwV1OFHQjn4gTCDuq9tFHjDF60KcW2CaEqjUej49N7bONCx1kvKsYR/XC1oEwmpGJIfGgSXBirabHpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQCEWsBoEhimCAQcWrgDX92W8vb2QCc3ZdPSMPj2VnI=;
 b=gamrpBT2vvP10dhWoutOJJQrHMFbyY3cilfEnlRb4trT3c/DjsB0QQyrE4Ua8ulQrxeT7VgpUN9pc0rWd3jgSXLk+HrDzjMF3/zfXLPSdHX0R3B/qpKyZnbHJNURwhSjqC+lVEtJwFdjZFG+RtRSweAnqpCCcax0rrEDNBSLhAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by CO1PR21MB1299.namprd21.prod.outlook.com (2603:10b6:303:162::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.4; Wed, 8 Jun
 2022 03:50:21 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8%8]) with mapi id 15.20.5353.001; Wed, 8 Jun 2022
 03:50:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, haiyangz@microsoft.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] HID: hyperv: Correctly access fields declared as __le16
Date:   Tue,  7 Jun 2022 20:49:37 -0700
Message-Id: <1654660177-115463-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d86e8abd-1c82-4ff0-d19d-08da490202db
X-MS-TrafficTypeDiagnostic: CO1PR21MB1299:EE_
X-Microsoft-Antispam-PRVS: <CO1PR21MB12990DBD28AC61E4F2B59EC0D7A49@CO1PR21MB1299.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VR2DYxxdQYv5QnNGyd/ZNxNyNq5PCOH3PBulOfuwNPNnYuYI22xmJrLretmFSG0hb7Y3kKRp/xT7dPSjuZ0Ht9siUl3nq0GtUlMrnCN7zjeYKGEYz14p3GVrkk118c31du2+gmAOpu5LG0Ndi+8SlkI2733umt4EIhQJfWC9lilqAaFMyaKoNjXv/E0Q4m50wPixIDWhkFcXZD1EXNu7HQn/pxCu7Z9tTkPbqWbyOtENX3cmgW9eDwhukeKArqu9Idngza6OYGAKYBk/0Ic1Qr++S8vz+jF+y1Qaj6VWbkKbjqVUxEAKubT6JIv7qdRx0kxGzfUaAQM1HotVGSjWDwngimKuae8VZ6HilJB+SrR/eIat4UUKaFP+YKEsFG7K1G24uO2fRT/frFlSyDw8bsvffy195+7eSCvAo+ANvixiMIMQQWYMilKl54u3s5uytwYDznoX8CDZKqHAJqP1W7NSi4YCDkzTc9UogjXDWjGUoM3lgmEUIqADd6Hg9zE7qudwJz+sNlXgrXfosklX5fe12N7uAimAl5QOFLI9ECOrEof0/so+UzCrk1+S2IgRkRDYKgSqMHqsoZPYbKc6VkciT30yGXccQo3TR/9iMT9yk4ObcEFQ4LbEwj4c9codRgi1koSutiEKchHmwxJbBJxKrZgYYGbHoI9NGSbYvpmt1ZQLT+rZaGzm+sl6asb1t9VSAG63osWaVgCBWAl/hGVh99Tpu9JPSgGGjNm4lXrrmXxv8spYd7LDMDJJfjkrgD0ruEN0LVd+bzmfbE7XWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(508600001)(5660300002)(6486002)(86362001)(8936002)(186003)(6512007)(26005)(6506007)(2616005)(107886003)(2906002)(52116002)(6666004)(4326008)(8676002)(66946007)(66556008)(82960400001)(316002)(38100700002)(66476007)(38350700002)(921005)(10290500003)(36756003)(82950400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5o9rNyKZOrV809lvsjEdrp9DWp2ybjy8d1sqftCML/Fi9dXgrorwVO5ITP/U?=
 =?us-ascii?Q?Rmm4+erk7XNXzqlwqBszELtKdBU10TWrPkEgFmwsFnQ+mBgeLYjeNrfHZ6y4?=
 =?us-ascii?Q?xa+HOo5yYSmoaG8WrBJa8MGMYAncQ27CpRjDnUa2LTd1LZtpjzMk4qAhDhkf?=
 =?us-ascii?Q?n0HfkgJN8JwoGzMnhVw/GqSLSCbJoPUCgDiLpm7waH0CxtLVg2ZWtUZaH9tR?=
 =?us-ascii?Q?3QKGW7kDG60dHcqgICmM0FlBcAzB4BzR4grlkX3acVIpYH1bZLpTP1CZ8H66?=
 =?us-ascii?Q?bvwfTp63HK247EdOgWD6NPCW9lrGfp8KcdJctZLJEQEEA7tWf6bSH/6JumuE?=
 =?us-ascii?Q?pfr/8PWh1wwyzID9caFq5v7PmppAKIM9fBvWQYmgJXdF8kV72DRBGilBdK1Y?=
 =?us-ascii?Q?57WJC2S+TrfTplaTMFuGZQ3tXXh+PEnzoVPs8S++Jz68GD5BbGIRaEqEoVjp?=
 =?us-ascii?Q?pPwDp8fE9S3WLpeHC0As3x4lSEjvl/nMsKnJI7GT7WYb0lA3O633ToUx5jP0?=
 =?us-ascii?Q?TfZEQtVuenzTSg11HAGEKsO+mJi1i3EnVc2aZp/sOmEWf0k1VfexXrAFLquI?=
 =?us-ascii?Q?EJjZCiK+KrZ9Zd+PtiYYfobp06UU9BDhW4lpHsdGDeeuj6rT16VvFmEjMtI3?=
 =?us-ascii?Q?dNPpvSSx0OtvHqKFYD98u+32XKoC8ibynT8CMh/DpUZ/u6I1N4fv1u38J0h8?=
 =?us-ascii?Q?4eH+cq0uPmE/ojFGhTskMSgcszt4VXfqVWtKxPF8l5nA9ZmhnH88kgbga+pA?=
 =?us-ascii?Q?FKlkDuRm+Q0kgzTQeyRXtnDxM+SK1zhv+yVrHDqIBVPEZB7sp78Arfbu4Xw0?=
 =?us-ascii?Q?plX5T5eHFXbnKFnYTUehof3VwUBh2JqNsEm683ZJ/r6svUmDPc818RdpmpR4?=
 =?us-ascii?Q?6OeCtJR6Wu4DlZ+P5Q1PQGi/Oij5wfc9Phbfo5xULXALmWaDrTH/JXonTOQk?=
 =?us-ascii?Q?bDCj3/17MS81mmALGWe/TIXj+uuoHz7dIMQMB1oCx5Q7LxH4p6xizxi0Yv4X?=
 =?us-ascii?Q?UBHMR8HoPS0xdcJeEybi0aFD7CVY5F6P4Qe2ph4cC6ncqNjzZW60KYWE0Fz+?=
 =?us-ascii?Q?U4ZF/avxIB5y4qjrLisdLnMF8RNeJfJKoaWQFyKgXbzMOvFYUN1dfzhXQvs+?=
 =?us-ascii?Q?rK7S8sLv2Saw0Fub/ny7bmHgBROEdTrl+Yj2Jyt0xgFT5Qw3WeqPM9CjRL+y?=
 =?us-ascii?Q?yBKF0Z8rP+YOnHVai36NxQphJwABH7N+QydfYfItUTqVTAqMPUq4BOJvXEQN?=
 =?us-ascii?Q?vVSM6NasLNrNxydTUitluskV9PlctBkMGOPoTNEdUySjBjh3ReFJCcWZ2Oqr?=
 =?us-ascii?Q?pdmy5YpCvq32+k/eJk4Ez979D8eT3Utr3UhcnL1qBI3i90pXBxrRsBT9XzfR?=
 =?us-ascii?Q?kSvdCOWkverw40KteUqek1kjG0G298LALU5I9LLlGJdXPbKFMvrT4IAW5I1/?=
 =?us-ascii?Q?R3yFITP0I+OqvC129r+RyuP2cNdUejj/kugk90vEPKxY2qMwha+8al5DFQfk?=
 =?us-ascii?Q?mfKB237UKrP61kEa2/2kLbonjbo/dt8x+IZu7a6aNLcBeoI1wXjXMYG+MEJS?=
 =?us-ascii?Q?NmU/SuCQtOSrDmiBqt6IitNi8dOCOUa2JZIFSd4qjINFmToUj6K/dBG2wPDH?=
 =?us-ascii?Q?GAl3k5HBbZv4CFnj+4bcDVLTa74Qv2mGZ/3dccydXsyXMtDE8hyWWgkyirO0?=
 =?us-ascii?Q?DZ9oMBW35YZV+bjzX0huIsNeWLvG4s5oe2TBDzmEor9Dlqkau/y3Ah9C3X/0?=
 =?us-ascii?Q?TnPguWC3amS6b64mT03Se+T2qOX79kw=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86e8abd-1c82-4ff0-d19d-08da490202db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 03:50:21.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtiOkZbACHz1pTtx9iZPSTJktIY9sQbEk+Xus0siniG7D5vDttJ8Aw4qoRXYO4a/hfSRrOT4expfO2A8/gVBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1299
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add the use of le16_to_cpu() for fields declared as __le16. Because
Hyper-V only runs in Little Endian mode, there's no actual bug.
The change is made in the interest of general correctness in
addition to making sparse happy. No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hid/hid-hyperv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 978ee2a..e0bc731 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -199,7 +199,8 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (!input_device->hid_desc)
 		goto cleanup;
 
-	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
+	input_device->report_desc_size = le16_to_cpu(
+					desc->desc[0].wDescriptorLength);
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
@@ -217,7 +218,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	memcpy(input_device->report_desc,
 	       ((unsigned char *)desc) + desc->bLength,
-	       desc->desc[0].wDescriptorLength);
+	       le16_to_cpu(desc->desc[0].wDescriptorLength));
 
 	/* Send the ack */
 	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
-- 
1.8.3.1

