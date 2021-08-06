Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD83E2EC4
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Aug 2021 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbhHFRN5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Aug 2021 13:13:57 -0400
Received: from mail-mw2nam12on2120.outbound.protection.outlook.com ([40.107.244.120]:25761
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240060AbhHFRN4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Aug 2021 13:13:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIpICOrnPxU+R5Yz+rmiQwELvRYxxgQWbqxiZBWIOADwXzRwGLI9Mvv14Hu4YcZiE9Xah/BddHXn3b9gXfBo61ROx4QY/amtCkksANESu16sXh8BLstR58QS3njKaGVpFazIrbnApb145S6bT8mYql2hyM9yeOf0wFJ3/HX6QovDKo61gE1KqSYijtyir/Rr71+zFk3xiBKJ8N+bO98exTWe9oCL6T4YmS55/zjyeefTjoVOnaTYwQo95QZe45CeXetovzMvW7JDMOBiCagevDmpp8zA8vrRF3AZgE7EVwfpG0Kt5SdxU7Na4LMF7cns8p4qt0ALO/7L3ti6UEi6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMg/Ex1knzITTGLOlsQMCcuBLJO9tqAq8WapbMwJLcA=;
 b=IX8VpcW9AB1L//Sjqhe5kK8TV3GTGCUIEYyv+WZ6TBtxaJmHC/iBbjOXSC9XL6SXUqnV2butXzYVJLtVoIHPujdLuvu+CNn/wpA186kxqMsdPh59MLHIq1NtfDH2EvkLXeew6DyQ8D9NFnMJNlvaloLDT49f6+a70pdAmp/bwTaRwxU9bKxhpJRw9J3JopOLEdIyjNAe84iWF0arChARb3B2WUMForO137KkO9PVMMy24AW86ezKhKqlkJLsU9JdThe9trdYc7s/I21n9LMpzbzj9eu/uCnV7Z0FVvugh6ceFLTjMlOnFgWS2VJwe6AnzY4hO7Bx04mv2PKApzUcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMg/Ex1knzITTGLOlsQMCcuBLJO9tqAq8WapbMwJLcA=;
 b=Vj6vt9yOeaAx2P0OWb31Q/Jh0MdjY9tH+fVqERSN5o+LDMIm0Kfdmc2MmepiYHUE0okxD6wJJmJSnPVlMOVKpSk4hHFevoN9S9xVMiu6cwQg9r9eSp6b/InfKbufTQ+1dEUk96XwykETuwQuf0jmq+OkURhpYpFANsyUO0iIsSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1273.namprd21.prod.outlook.com (2603:10b6:5:16c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.0; Fri, 6 Aug
 2021 17:13:28 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670%9]) with mapi id 15.20.4415.009; Fri, 6 Aug 2021
 17:13:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Log TEST_UNIT_READY errors as warnings
Date:   Fri,  6 Aug 2021 10:12:50 -0700
Message-Id: <1628269970-87876-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 17:13:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b1407a4-6d10-4a7f-b46c-08d958fd81c0
X-MS-TrafficTypeDiagnostic: DM6PR21MB1273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1273A961557B5E37BCC9526ED7F39@DM6PR21MB1273.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s/24IxxNRm50mYwt9B4Tfg07S/qS/hV0ybb809upfU+TnOOGeK7JSO8u/uW+r9H9XyBiMoV6GUH2YhTXW0GtbKs1QuIxWnbnIfShTN4SCy31Onjs91OEyXfkC38Jlk8cgTNVG/eg74UDHYfeBjDNFyBHKIVth9w2mycqGc0yZhudiDoZ5uQW0l3Hm0o6V8kQuYuwL4VENwkRsaS7quRBMmjkMH/oMujz33UkIO/AtsGZlQhO5+4VW38OZHnuumnbJpBwBIWdFA+92Snm+tsDOy7zstNG161OV2Tb5eu8q8Uy3hhrHZuaDcvONTeHK6Byy84sQI5XoH8+W5UqTB3tQqOhpCZHqeBzVONFoHiZGTfvf0tOTZ2ANSnqA6xHMMlJ4/JG0LebhsrotMpmeT4bgvJmSKe/aD28ZCrlD30GEtyi4pxdDYrsY7Gfjk5tzPdrCTclObTfA0Yw3/R6w6N1svnSVttFUqDkzWMyPaDMjGgXfhb89Y9JRQsKBliyLXAY+RTMXpIdkfOG+zmx4KvEngsZyRbrRY1UofwffyLCrqWcg6ZD+f/RqIUtg8YBCkRdR5rIMBoD3Ca0NK1pXXNaJNIPQ4x1lO4caBm5Ohboopm5YvaTv8T+O0rc7YYJpjmK5cden8bHPaysqiWm48Y4ctAVFY9W/4F585cbsT8A1Xog7WIu+08LZiXK1Tush/JWO2evarI8J9f3AM4kyl3Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(10290500003)(107886003)(508600001)(6666004)(36756003)(38100700002)(8936002)(2906002)(8676002)(4326008)(5660300002)(316002)(6486002)(52116002)(82950400001)(7696005)(956004)(66556008)(66946007)(66476007)(2616005)(83380400001)(186003)(82960400001)(86362001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMznagI/wECcailEZUZENYiMOURE09F+j838oaPX9Pyc8JIo11FZNA/5KIkd?=
 =?us-ascii?Q?+bWEYyv2zuAa7QHZfYQgxGUW9JtvWNIz+TlFXuANNQqVElaa+ocXrUYnzOmt?=
 =?us-ascii?Q?w4ba42k+FoEdK7hFvES1jwtLPNCpFUlx8V6z/GMyVXqR8Bf9lBBb0rckW6ve?=
 =?us-ascii?Q?heRTE9pm0+4pmGM/YZPPe4UwsRAYZI6tO/YyIONaeBfk0yD3O4vJiG4oQSLs?=
 =?us-ascii?Q?oatcp/8SF6Hfh1ILaaWoYL0V9fTM9irxT7SCUUjnhoEcFPnT8rOCmmcpKomM?=
 =?us-ascii?Q?74JZsuAct8rE8PB9+gEW8h73pxjbNgo+QGS4r3/UYhA1XIf/HL7UZOdczWFi?=
 =?us-ascii?Q?NceIAjsABUtPHtj42lqRqi2u864oowfcK2ZIRXgTfpM6s8i4fxPMWHDvsqf7?=
 =?us-ascii?Q?9HuQia+arVbVk0W4QiGmwip5P+m2rFTEiSCqFF+NkDM02IPsrFmOZNR/ggnZ?=
 =?us-ascii?Q?AlI3Qn9as67NKK4MrMnhrb7MKvibfi8SxtS5zNfd0WyZjIIinzb4Z93Qqeox?=
 =?us-ascii?Q?dD7Q34XAd44GIfJLtrGNn1g39jXpGmPaIgQ0gUitsYpYiB8oAgsTpgnwOfNM?=
 =?us-ascii?Q?yTMTNMzEgjlTx12xFEVVvYuXAkMqwzahOSh59b7ClaLt9LIi9pbE6ryD5BCF?=
 =?us-ascii?Q?JuNMg7rTYPzxCEJpPmlubcphPV3rRspiAwmuSw2gKFotoeiI6LqqcBeqDHcq?=
 =?us-ascii?Q?3K2Ws2cy5pxfGS/cKvUPe6TZA3RMvUtX9Y9WRWW7bBeOFVAXXK4tQgiZxRfY?=
 =?us-ascii?Q?/yG173oLgfk11S2rFCRhHHf8q7t6uaNa+OB99IdExySUg4PcaOqOTOxVtvzp?=
 =?us-ascii?Q?VG4plXCC6PUxbzzS7vN0NuNSvDKm/OUNUlv+Dr+X6GeI1FhtPgCJmzR9sEB1?=
 =?us-ascii?Q?vbtnn7aTrSg9Mu4ij74rNxvbI+wvZLv0fqOey2l05a1nbYpbLFMWiS2K4KJL?=
 =?us-ascii?Q?A9VgiBflMGOUZpthoAFpeilgcfkiElZbTvIYkn1gAOcwvgNPn4L1Np0xdLPR?=
 =?us-ascii?Q?6pbK6rgFFGwCBK1EypBmt4wntOEy3TFuxl+07/CD76IeY2crZ+406xtpg4+q?=
 =?us-ascii?Q?WYm7aXkvOhdlIOBDSbvXV4vU6Cvd0SJ4i9Y9WeniATGMop59zZ1CwPPxWDzn?=
 =?us-ascii?Q?xhH29P9u5gwVQdT7Ll3ZoR5ciCIMKhh+J6KYgveG4SJok1baJMSx7c37AkaU?=
 =?us-ascii?Q?Gjt8FTLM7SEX3+igRJzsJuLceez1RqiIj5rnC1TJypkkV+NKtNnWeHOEIMPT?=
 =?us-ascii?Q?8yzY7HZ52rCiQT6E7vifZ16Ct7V3iG7K9Ai7Ts0fA0Rz+2gK8RbCTT12db5T?=
 =?us-ascii?Q?SQ4NSLw/hfivkkfgksge6DkQ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1407a4-6d10-4a7f-b46c-08d958fd81c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 17:13:27.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz1xTaqyY/jMXfWJq7KD4yiPZcGL1smXHQ6zSqXLkk0MEsouGtRjl1f5lYo1FufdOSSPwxEPUnRgRpZ6rPvn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1273
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit 08f76547f08d ("scsi: storvsc: Update error logging")
added more robust logging of errors, particularly those reported
as Hyper-V errors. But this change produces extra logging noise
in that TEST_UNIT_READY may report errors during the normal
course of detecting device adds and removes.

Fix this by logging TEST_UNIT_READY errors as warnings, so that
log lines are produced only if the storvsc log level is changed
to WARN level on the kernel boot line.

Fixes: 08f76547f08d ("scsi: storvsc: Update error logging")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 328bb96..37506b3 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1199,14 +1199,24 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		vstor_packet->vm_srb.sense_info_length);
 
 	if (vstor_packet->vm_srb.scsi_status != 0 ||
-	    vstor_packet->vm_srb.srb_status != SRB_STATUS_SUCCESS)
-		storvsc_log(device, STORVSC_LOGGING_ERROR,
+	    vstor_packet->vm_srb.srb_status != SRB_STATUS_SUCCESS) {
+
+		/*
+		 * Log TEST_UNIT_READY errors only as warnings. Hyper-V can
+		 * return errors when detecting devices using TEST_UNIT_READY,
+		 * and logging these as errors produces unhelpful noise.
+		 */
+		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
+			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
+
+		storvsc_log(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			request->cmd->request->tag,
 			stor_pkt->vm_srb.cdb[0],
 			vstor_packet->vm_srb.scsi_status,
 			vstor_packet->vm_srb.srb_status,
 			vstor_packet->status);
+	}
 
 	if (vstor_packet->vm_srb.scsi_status == SAM_STAT_CHECK_CONDITION &&
 	    (vstor_packet->vm_srb.srb_status & SRB_STATUS_AUTOSENSE_VALID))
-- 
1.8.3.1

