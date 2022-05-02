Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D65516B7C
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 May 2022 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383602AbiEBIBm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 May 2022 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376532AbiEBIBl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 May 2022 04:01:41 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DC029CB3;
        Mon,  2 May 2022 00:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3dkt7+nCLig1weRU071EqvTJRkOBP46J8KG81Hqizu7ELsNu7xjPmr2n6KAeHLcinr1piNe0DWYsrQwRpw4OX6YmWjd9AlR9mUs/N0ijwHYUCO864cvpU4xOEOJCQmZU+7fg5lq1ubAtqr7nMxyI4YmjglHDraMOiDeHcwuD1fU1cphHAG3SYIl1GAPAA/w7D7ZtUHSlNmTzvgrwwSU7O9oSzrRe0+ymuEht7bXzMaXliWHIrglVmBTVWTlLdbNidQ8X9TZ0DsK0JsfcUyd5HcrCt9SRaRShIjnMP+HBGbq60fu21l0H3OG+GW5rrq5izY/kZs1s648ZcDUriUpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbUIZVvmh/wiSrp8bG5PwsR2tyAoOE4BtdcOQuS4gw8=;
 b=ZF4KZnVpdG1yjwuiUczfbnR1vsGKrxZEaF6lGsUFsdrvZqtvg+Z6Q+3GYE75aKNq7sijHafvakrDM3aTZzVkvezqklo847S0B3veMe60C1MVyLK2mD+L1n5QTzWekWqSAR/eZbVpeJbrM0FdfAm2fWwKr/9nx/3rLnMcVVyonw0KsXvdYngB8NbniWDO1JwANdN5irpIy5T3ntiJu2rWx/nfg8TMVXJO+yFvgS+MypUglz4xuYRcPlaFkb6cMnoXdkKq9TRiCBJmJn/QIYBDnZvuAb3gtlFTnWUC6oXoLhEKxpnNV8WcyNgZNkenLgeAt4qxEI/dW7T5qbrG1uLdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbUIZVvmh/wiSrp8bG5PwsR2tyAoOE4BtdcOQuS4gw8=;
 b=R/MZlXYoj7gtUivT9O6/Jebuq6FfJZyXZMhddcf2ISMzrdsgoyUhc8vpg5S1I+agQCuihdquZEGSAL6UpTpSa2lklLeI5j9n3WsslhC57ixRsOutJFI+1Ag0mvh7cm6B2I5ujaLbtGR91ikDqhlymukaF9FK5P15Itz4D8mjDgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26) by BN6PR21MB0273.namprd21.prod.outlook.com
 (2603:10b6:404:9b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.4; Mon, 2 May
 2022 07:43:41 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::c45a:9279:12d9:eca1]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::c45a:9279:12d9:eca1%9]) with mapi id 15.20.5250.004; Mon, 2 May 2022
 07:43:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, robh@kernel.org, kw@linux.com,
        helgaas@kernel.org, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com
Cc:     jakeo@microsoft.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot time
Date:   Mon,  2 May 2022 00:42:55 -0700
Message-Id: <20220502074255.16901-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:303:b6::10) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5684d03c-f94f-4c9f-bfe3-08da2c0f7a04
X-MS-TrafficTypeDiagnostic: BN6PR21MB0273:EE_
X-Microsoft-Antispam-PRVS: <BN6PR21MB027380E4184691E1EE328911BFC19@BN6PR21MB0273.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsG/otRtLmDOZ27E4aMWpTfukSFTmBvAtoL1VHtTnJLXC1nJKYH/sDCguZxUIpKEo/n+u1+0pgPJ1izbLlu3805O9b1CjglwdrDoLsQlLkWihUGXPKQJ4B6e/CuFrOVDcccOgt4mY8j9hdMbdRi8FB/W5eGo7Y57qNw5pvLjfsUkw9xzH12BBEit8H6Ee1D0OxQQNDLe3judKcmZNHWEoqOu8YsWeaY93uVJhGJ6VUQl74LD9Si7nV6AOjGHtVGQsvRLtkUb0is3r9XoWGNwceiU97+B/fJ2Oi6rjAyOHtnOGxEdtUNYL/QZmIjJEFbBMs5w1qAVRNR4u9Wl2ImeWyBCpcPICwrUf4BD5FA3Zywm5nzbuLb249o7/94OLEzX0lDLRQVB06t1nWTgX/1ibTZ+uCaU24p1b4MbCDx6+jxUQ727t1S9/FC7g82NGXwAC4+wWxPIn0vORxuNJ/2oAt9G5Wvq9ewzBCRIlfY0XLReO5j0D1gR4oUDbycdz7Auro70V3sfOb6WNdyXY3DR6qcuJ6cEzagGv/7Vi1o5e+GJY1uAy9HbsU1yKc9YGxzXYBWdiKjWwmAl7GQHvHkQ71xMG3nlXWUiFxkL5XBtt5Y7u76OD+ytlPUw0JDspIJ8YtsAFCe600e1xdv6gOScOTIVhuVEXHDn/w2Xpfoo0DcNQq+Ho7wzP2CzD9WVoW9n5AAPme3m5pklmJVeGdGejOPWWGKDSqD/p5aFzTUWZjMEzaSVui0Fce6wKE7fCjpXcnSRppP3KrbiXLwcMQ2vZ7cRBfJh7aZ18U1uqF3JNiiAdlRIEUqkRLHwr30MGR1Uc4QTa6v1sk+pxoYEzB+SdaWzizUGx0jPNGe+kLDv9J8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6486002)(966005)(38100700002)(6512007)(86362001)(4326008)(8676002)(1076003)(6666004)(316002)(10290500003)(6636002)(186003)(66946007)(66556008)(66476007)(2616005)(82950400001)(6506007)(508600001)(52116002)(921005)(107886003)(7416002)(83380400001)(5660300002)(2906002)(8936002)(82960400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ABnBg/7F1yvDCGpM9KcBPeAceozRRCc2HSQx7VW/QrcwkgBVtJRT5SIAXNB?=
 =?us-ascii?Q?ozjEVupnOFSK4NIRLcb5qVukgA2cZSwvCTv08oNrY1FxYbjIrLgcKVCFz5rd?=
 =?us-ascii?Q?5TlFNFu1bcPIlqY7od8qA3Okqxq+Ujq05zG/eqZxBOurO0n0Q8bkF63U78bX?=
 =?us-ascii?Q?K59f57aX4bhuqU6vMhkciie5dSHizv2AEzT/A9gS9NW9YOFpiADmeOQC5uPR?=
 =?us-ascii?Q?WWC1pmXjEjUHCHm56w+Zg9vlZ/e8k6pinI08W7/xqLWJtB8NhybpORvcG2Zf?=
 =?us-ascii?Q?zPVEAztxZPpGc3xQf2NlA4VZBLU9sKltRT3KvzLu9Up8T7ieBnaPIbJPygmg?=
 =?us-ascii?Q?5TRlW/LgJDEOmFs6gPJnhQoM8yCMDJBT0uM25I4zXQBgjHRmje5Zsx7hk9St?=
 =?us-ascii?Q?REbCTZW2TiZA2Tj1fHjLAXW6CL4e8WwU2UlK54GwLhazq1vUhxZj/mNnsdGE?=
 =?us-ascii?Q?tyOnJ5YSud/RzmvXufmBmcKJYULPae/4hUWwaP+xq4LrzTZsCZ/z4R42WLMP?=
 =?us-ascii?Q?9FQ0NQkKjw/9m/pQMiKnYmjcLobA61RhpTMQQp0Nv3QksZ66VWgp2vpy6f2J?=
 =?us-ascii?Q?2mjVm6q3C1/nd6LsG7CJLTif1T5Vv2su/Ol+SL2cPZIf9b9WA22rzVQ11Poy?=
 =?us-ascii?Q?SwZcV5iG/z7ERy1PjNpimggsH+iibTwZ1AbQvosB2VqMjG4OtKKvGhRN7yLV?=
 =?us-ascii?Q?68wk3+/GyKQRD27shv5VHIh2kDO1Mmp+Ou2GLzh4lDu0WFzF1u62A4wIhigP?=
 =?us-ascii?Q?nUD7+6mkRN/taQmCKuu04TAkMQby/r4UQxP6E0CevnIMesJX4iBtU0WML30V?=
 =?us-ascii?Q?RqioBq/BC+BYm00G6mEsxL7vr+3ccjSByYEZw/t/2dmVFYuUfKgmROxZzrFm?=
 =?us-ascii?Q?8hpAPYlNFiVzMFOSCOcEvcOx+aC3jg9dGiL1mJljKsF8hbn1Q/ct5aa7EcrY?=
 =?us-ascii?Q?NhwxX92fmBoTY+PXh5hjLyuKwvpjcbyZh0eKlX5QO59RUA5mLo8gK5xr6HIg?=
 =?us-ascii?Q?3KbP2bPLk39UyDIE7zNK3tr7ptyYTcSlIRhd9scrj2OlFEk7PLeRNhPI3Vit?=
 =?us-ascii?Q?2Lu8D/mx8fgWtYNaussSO+jKTksDcHcunxCquQgtGc5d0QNyUCOXh0Esh0sG?=
 =?us-ascii?Q?U0AiDgaczn2X6XQbGLkGVYIbXYkIMsPKwSm36Tyc4ut+WHCYUDlKmdTK0PTK?=
 =?us-ascii?Q?VmhrhAt67Hhtoq2FhgNTp4TJnvbFjASkz3vOqnvuymlusXlyqW4zKejeAlYy?=
 =?us-ascii?Q?OZqceYWz/m2pyp8bJSB6/PtrFMrLWUijyjjf/6jdLLo2578B2+2A8PQJtIZ+?=
 =?us-ascii?Q?sL+3GF0aB8dJK9zkZr/iUp8+ivfrS9pqMyJIsveQaiLW6k+MrkfW4RNon+RI?=
 =?us-ascii?Q?Hszec5bjkGM6ZrGjfp7rysN/JO4U+t9ZodEyr76B17qyJe+Z+ugx/wjDmQV/?=
 =?us-ascii?Q?B6WKSEpppehdOBe2GBAQyCIjXNDYY99+7JGot3hTHo/yOU/0oHt7bq32CppV?=
 =?us-ascii?Q?FgoFJCr34PksLSnDP32Qjfgc4gGCKA4Zl0Km4KpRL+Wc5NKy60zxgzXQluO+?=
 =?us-ascii?Q?okGTRKKDWs2jnlcMLbHEHEfg2Qiu2bAnA8MqLVisbhFrsgybpwzpJj4n8Zlv?=
 =?us-ascii?Q?s8aiBdHOrq5nl3R9RfhmHRlalSGqhmZbSEC43SWi/dHmX0q73iKON5LwZBBS?=
 =?us-ascii?Q?lYJNNzMTL5VzbvpHxgS1tAnfeocC94e0hyiwgb/xkeINpwH47Hy6GDe05uDB?=
 =?us-ascii?Q?ywi4kwKaWx97cnJHQ8VJ2NM5W7BWqbSg/NpnRghlPWmUE8sClGGzO+qxaAST?=
X-MS-Exchange-AntiSpam-MessageData-1: weL/5FPy0baCtA==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5684d03c-f94f-4c9f-bfe3-08da2c0f7a04
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 07:43:41.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE8rfMz+nda6DqZAkyKlFR4Gu6jtYygSE7ZgGjsPcDAgR6zxty4psOxYy2fMqKVCk/OAgsCX8SmhtI+8YVly+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0273
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently when the pci-hyperv driver finishes probing and initializing the
PCI device, it sets the PCI_COMMAND_MEMORY bit; later when the PCI device
is registered to the core PCI subsystem, the core PCI driver's BAR detection
and initialization code toggles the bit multiple times, and each toggling of
the bit causes the hypervisor to unmap/map the virtual BARs from/to the
physical BARs, which can be slow if the BAR sizes are huge, e.g., a Linux VM
with 14 GPU devices has to spend more than 3 minutes on BAR detection and
initialization, causing a long boot time.

Reduce the boot time by not setting the PCI_COMMAND_MEMORY bit when we
register the PCI device (there is no need to have it set in the first place).
The bit stays off till the PCI device driver calls pci_enable_device().
With this change, the boot time of such a 14-GPU VM is reduced by almost
3 minutes.

Link: https://lore.kernel.org/lkml/20220419220007.26550-1-decui@microsoft.com/
Tested-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jake Oshins <jakeo@microsoft.com>

---

Changes in v2:
	Added Michael's Reviewed-by, Lorenzo's Acked-by, and a Link.
	Rewrote the commit message by following Lorenzo's suggestion.

	Thanks all for the informatie discussion!

@ Wei Liu: Lorenzo agrees that this patch can go via the Hyper-V tree's
hyperv-next branch (the patch should not go via the hyperv-fixes branch),
but in general we should keep the PCI folks in the review loop for PCI
hyper-V changes: https://lore.kernel.org/lkml/YmuzOJy%2F6F5wSjY7@lpieralisi/

 drivers/pci/controller/pci-hyperv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index d270a204324e..f9fbbd8d94db 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2082,12 +2082,17 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 				}
 			}
 			if (high_size <= 1 && low_size <= 1) {
-				/* Set the memory enable bit. */
-				_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2,
-							 &command);
-				command |= PCI_COMMAND_MEMORY;
-				_hv_pcifront_write_config(hpdev, PCI_COMMAND, 2,
-							  command);
+				/*
+				 * No need to set the PCI_COMMAND_MEMORY bit as
+				 * the core PCI driver doesn't require the bit
+				 * to be pre-set. Actually here we intentionally
+				 * keep the bit off so that the PCI BAR probing
+				 * in the core PCI driver doesn't cause Hyper-V
+				 * to unnecessarily unmap/map the virtual BARs
+				 * from/to the physical BARs multiple times.
+				 * This reduces the VM boot time significantly
+				 * if the BAR sizes are huge.
+				 */
 				break;
 			}
 		}
-- 
2.17.1

