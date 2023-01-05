Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB21D65EF4B
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jan 2023 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjAEOv4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Jan 2023 09:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjAEOvr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Jan 2023 09:51:47 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2059.outbound.protection.outlook.com [40.92.98.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD54DE50;
        Thu,  5 Jan 2023 06:51:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo5458O2IjSBplavJ4fEG2+3bmOhAfL2acH3Jdd7EaYn5FCtxRZC/YoWvs6iIxyeijOG4FFmnoJ1MSeFncYb3L+goSucH0savXwxYf0ZOiOUGAV3QwYUb8bZkEqvkxXn31XfBK1AHOeEXuFKORm3lZyD8c54OK4dxmwL2RczqNUtBAc0jka9DfjpoElxtCO/Aovm0kEQceD4v60Mxng2UPHSqcg/8snNomLVvWGCG5FqHsSowzF7iAenL2aDWcXzaBVa3FJNRIAL0aGtOAPykd99wVAR5WiRIHfo5rbq+RwdbwKIKWIWb3IDCoon5M73myxWE113KJc4S9jIgJEcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzRMf6IPvNxTRpk6p1FdNg5o9VgYlYb0N4Sb9X2zyKg=;
 b=DpV+dScIXSKnmKynoUOBX7ZQt2YmaEjP9sREoUM8w7yr3AkgF1oQpS9ERpW2oa+D112ZonQkkh6IVzzXKKsLIwuC284+h1pIAKBIhgIaOpRRpmLJQVBxuqlAQwvZhJmFxQIArRj54ktHqsmcRqlzmL2VTE/cn/L3wknD+SAZ4CgYZlbqzNeM3z+/NPJW1U0Wb6flb1TBKMQljswVZN4wHLVMD6AaYXApS+BEIzZ2SaF/DZz5UdiFRhgAKbq4lpUuyuECqaGytEDKnlI/J046lFNQ+ZS6YkgTMIl3cBLOs+i2lBfmM6n8IWjVI85m6gmdCT9rzPJ+5hdQtjTPBlFi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzRMf6IPvNxTRpk6p1FdNg5o9VgYlYb0N4Sb9X2zyKg=;
 b=LxWWKBvuZb/49n6vT7AhWrkcbquOGh8680gCvhy0aWwrCRb7I8IiH1xdi4+ig4C3Zu/1+rsWNNGE6oFmIi/U2uydwNlsf0z1O3KUexYYpo1G0LgJxjxc+sQMBVLGg5utMsKQgu38P7fKEkO8VSMM0tDyhq0KGas0BxmrsxegZ68QsAqJPc5PiYnf0dacJPvO8F2J69tW4covrIWDuAc3M3yWxsKoySPFJdKQFwhqzR5B7cZM80T9MZbcUgj900yKdi9G86idSN70HQbOHA9T0kVxyYqAEmZItKP5FmSPWv1Pp6i3ENZYv3aGpGpSqyOX5xqwotlCbT7/DsKsQqD1tg==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYVP286MB3714.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:51:43 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:51:43 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com
Cc:     mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v3] Drivers: hv: Make remove callback of hyperv driver void returned
Date:   Thu,  5 Jan 2023 22:51:23 +0800
Message-ID: <TYCP286MB2323A93C55526E4DF239D3ACCAFA9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [G0tVtjaIOx9IGn2eUbpxDuqulXnFrt48]
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230105145123.1271897-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYVP286MB3714:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a416f8-eaf9-4849-0348-08daef2c5bf2
X-MS-Exchange-SLBlob-MailProps: a+H6FLLcF3qbS4khOCXb+acgdOv6bjW2nCCKXLjmU0BpgyOicnBRyvwhqx9M3vMT6M/2RYr88hSBF3Yy8CaXpv6xKO/MD9Bhu+vzuIU+csF7MtOU1HDdZD1bQn9doPnTWPTcMVzU2V+DjmhEZSfBNHSMLTvISLrgVilJ7UTL/omMsapxUN3yUe9ZETjt328gd7gVcFL1uf1K12zKqip2Wvc3pvmJV/WXajU/xH2G5N7vPXDHx8HaUIxvPcQB3y90z3B2KCVzxlfJzIQ15GiQEh0nIhON85PpHTFO+bfJX/FrEvZTn2ld0TGgVA9wWedmTzNGkrsjkJ3Kgo91txGGa2ASziT1VO87Ox8gkS34SRhaNLX12JJbIYm17lQQOfs4fwBpLDE/3Jw4Wc0jFdMsruZXrZToe1ZVV3btvSd3cLVvx7w7XMLqGg5UluGDWynqLSAZQ0WkFnYT0jLXGQxKEstRA2T5Z/8loSbEQatEOaH0nP1JlW0mm9Kg6+Tx4s/1Xp61nNL5HWG/INqc0UfoYFrFfKmrz49REeqyCaUEiO5heUBClr5Xm1JC16xTAycbc1IU3Yqz0Xbx+NjoV1Z9yEGv1ZSsnGfPjr9hfiAyJPxPPOo9ZwclqRScQAl6M/lL6cDcOFkXlqb49PQ8LXUbIXt3QXEpAFx6EwZ+iRYp2YCMP8khEoazeWaBVtt5aRLhbBSq8FWgqj1/1BgBmXv+tryTcbPuQ9vmplnBaw+ZePKjeSmdWVvWv+9xHmq9aGrCJdmfLyLSMx+SIT2KRN5k/44JfefIeqtQFLdccJuJFyfQUd+TlP4yDi11OlGBQa4Z
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHJvr+r1RbrlXwncLlox9dtnhhJohfcpeyDuXnJlKBcpbH+CyFRP8CEy0gyDS0LkxJUjW749pF6SPzz48Guy8rHqoNNJwsTM0Pu/FwkdBhqdPuUEjPLeBNwYkIYwMQrPDhB8rv9ENZJPPb50A57cKdAj+MppyN/OJjHOyCaN8DksCReJxQ/RWfApITt75+xlNrkYP3/VWYsyg/UBopLCOwuI6ByGsjAObHf8nGXqKtOBvVAc56pdWYTXFYoYeItpO3K5I88X7FcqlY/Zc3S/EbKcvSIgNeHSM6wdQ08WhTU22GNqmKJyW3J5MAhzV0jQeE9SOFDNa1/uoueKA/c4NF7WjTOLvgPL9ya3Y9kzErwJVkZ2QmoZ5L110H1IrjxUdCBjw78qv19VvdI3ofDBU6XwGYE6B+1bcIrqTR00ZTX2B4XkAjwEpnbZxFlMtOruIaV2I/uI08mWb4HyRNgziQNBTxHVbRrFbAC94kPc68lKnNIWmwwoJ5oZeE61jodD8TL1Wncn00Pql+TnE6AuKonXD9cKqr8hgm9hz7vRFiovqEF+7LApsfEgqPTiQuCesJDeML3pL/JrFhSoKMNvofKSXNf+FG1gvP3VRVwqT+Vv6ALWzmRxKRctJ3nWqbgtUkSfcmJlbxQLffzy1sWlkw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7wZbWwo68/DWrycgVi+s9e/i8jPMf9P10r2pvhSGi2SdK08QjNrmmjTQ5iH?=
 =?us-ascii?Q?ye8100IpKGHcpoNWM8FcIJAaB7NwJ7BLqE/klUIJLOmB4/Nm0M6B0Yy4t24Z?=
 =?us-ascii?Q?3hxOfqdlbf8rgkMv0MyzrH2lpdY23eoAjR+k0ewYTrFx0bjvk1KXDAJEqwpv?=
 =?us-ascii?Q?239clCeO/g2Sv1K9mUi5JZo1QtqHsKsDjV/D6pOne5WYdtHF+/nOKDYQI/a3?=
 =?us-ascii?Q?r/c6pJhxvBxevJ5ERHU784EV9RkKZJMpVKPL2pWwxuJgJoJ0nycy6NgBhlLG?=
 =?us-ascii?Q?4P8pVLg9W9oiqKDOLvsTX09Bx2Fgsgc6s8KBHXJv6Tv2XAPaLPPtLoRVS+r/?=
 =?us-ascii?Q?zE8YrVwcgSod2z+fOYnJ58ZEWSStwsKvyeUDi7ZwVUPMsRHexBpj9ZrNr6Lp?=
 =?us-ascii?Q?OHy4emvjH9TEicDvL+B6aLiS+v5nbP4U5G/EpGn7SRBnNGRhRO49EpasNFNK?=
 =?us-ascii?Q?YxBxMQ325XFxBdUYcCo2z7JKR3V4266QcXdm2AKAUcIL5zsxUx6Dr/h/hWH1?=
 =?us-ascii?Q?ZAqX9brekxUV/TJMnLDYKaWpdXdRU7+U1iv0KCTmLnov4BQq8Pl/zZ8nCdSb?=
 =?us-ascii?Q?VbSPGK6S4/4zFs8Qp2wAs7K5MBPiskI08Py6yHomZ+Mv4rfOdHMOToHTkpAQ?=
 =?us-ascii?Q?1BymuK0PUb8PCyg71R4oaEXIu9rWxxJ4yEDdpVjcdFOlKr7QUQBbUUYPjYri?=
 =?us-ascii?Q?TSCKubzvOc0Ntkw0QYqEIMKdWgwwYFLZgA0EIC0JXi/cE7wijXQ8/dsqAZVD?=
 =?us-ascii?Q?uZFuAToEc2o2Jc+jMRBtPf+nzdE6IQsqeyxgut+TuP3BGhj7UpcyjuwzTe2Q?=
 =?us-ascii?Q?aOawvRWglvtsKM4RKzR2ExZjNo59Ypr82bTK+SskSCpa3rsnJwb+enrbwRrw?=
 =?us-ascii?Q?41rI4+Xxjjgtxdpz4xEobkigaVGdQZBKIWfZc6Qt2WikxpJ+wGwpZwmou1C2?=
 =?us-ascii?Q?rlFsbIELUm1g/YAPKEIWMW8f3ULJGJd8ND2AGFjXpz17PBCIxTEPG/lWBipy?=
 =?us-ascii?Q?d/WYr3ZjnytF1e58+rOkHnpYU+duB4fbpXfMYpagVwsRO5p9Eb42BVRv6Ih0?=
 =?us-ascii?Q?zBuCeWm4HXIbSntVWcxOD5YD52G4HH+heVWV2P/H5O/nH3xnSq5U6xzbtE9N?=
 =?us-ascii?Q?U2tPceajbRcYM0PDhXQLn9fJ44kt7zuv5KgEkI66ehbmxq2Ht5Pe68uODYG0?=
 =?us-ascii?Q?hY+FrG/u8hMf3fY3PxEeLAGEti/jPy0AMtIAKDBQ0xienvMljTWwL1YbHMB6?=
 =?us-ascii?Q?/mAiz+MjiXdVLVTH/HeUshFKvMS6o3+1Kz7p3E9jBw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a416f8-eaf9-4849-0348-08daef2c5bf2
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 14:51:42.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since commit fc7a6209d571 ("bus: Make remove callback return
void") forces bus_type::remove be void-returned, it doesn't
make much sense for any bus based driver implementing remove
callbalk to return non-void to its caller.

As such, change the remove function for Hyper-V VMBus based
drivers to return void.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
v2 -> v3
- Update commit message and restore blank line as it is,
  based on the comments from Michael Kelley.

v1 -> v2
- Fixed null dereference issue and deprecated comments, based
  on comments by Liu Wei.
- Fixed building issue.
- Rebased on latest hyperv-next.

v1
- https://lore.kernel.org/all/TYCP286MB232373567792ED1AC5E0849FCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 +---
 drivers/hid/hid-hyperv.c                | 4 +---
 drivers/hv/hv_balloon.c                 | 4 +---
 drivers/hv/hv_util.c                    | 4 +---
 drivers/input/serio/hyperv-keyboard.c   | 4 +---
 drivers/net/hyperv/netvsc_drv.c         | 5 ++---
 drivers/pci/controller/pci-hyperv.c     | 8 ++------
 drivers/scsi/storvsc_drv.c              | 4 +---
 drivers/uio/uio_hv_generic.c            | 5 ++---
 drivers/video/fbdev/hyperv_fb.c         | 5 +----
 include/linux/hyperv.h                  | 2 +-
 net/vmw_vsock/hyperv_transport.c        | 4 +---
 12 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index ca127ff797f7..d117fff26d99 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -165,7 +165,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	return ret;
 }
 
-static int hyperv_vmbus_remove(struct hv_device *hdev)
+static void hyperv_vmbus_remove(struct hv_device *hdev)
 {
 	struct drm_device *dev = hv_get_drvdata(hdev);
 	struct hyperv_drm_device *hv = to_hv(dev);
@@ -176,8 +176,6 @@ static int hyperv_vmbus_remove(struct hv_device *hdev)
 	hv_set_drvdata(hdev, NULL);
 
 	vmbus_free_mmio(hv->mem->start, hv->fb_size);
-
-	return 0;
 }
 
 static int hyperv_vmbus_suspend(struct hv_device *hdev)
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index ab57b49a44ed..ef16c2a54362 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -535,7 +535,7 @@ static int mousevsc_probe(struct hv_device *device,
 }
 
 
-static int mousevsc_remove(struct hv_device *dev)
+static void mousevsc_remove(struct hv_device *dev)
 {
 	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
 
@@ -544,8 +544,6 @@ static int mousevsc_remove(struct hv_device *dev)
 	hid_hw_stop(input_dev->hid_device);
 	hid_destroy_device(input_dev->hid_device);
 	mousevsc_free_device(input_dev);
-
-	return 0;
 }
 
 static int mousevsc_suspend(struct hv_device *dev)
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index cbe43e2567a7..0d4b8fc47ac6 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -2042,7 +2042,7 @@ static int balloon_probe(struct hv_device *dev,
 	return ret;
 }
 
-static int balloon_remove(struct hv_device *dev)
+static void balloon_remove(struct hv_device *dev)
 {
 	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
 	struct hv_hotadd_state *has, *tmp;
@@ -2083,8 +2083,6 @@ static int balloon_remove(struct hv_device *dev)
 		kfree(has);
 	}
 	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
-
-	return 0;
 }
 
 static int balloon_suspend(struct hv_device *hv_dev)
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 835e6039c186..24995ac41c86 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -602,7 +602,7 @@ static int util_probe(struct hv_device *dev,
 	return ret;
 }
 
-static int util_remove(struct hv_device *dev)
+static void util_remove(struct hv_device *dev)
 {
 	struct hv_util_service *srv = hv_get_drvdata(dev);
 
@@ -610,8 +610,6 @@ static int util_remove(struct hv_device *dev)
 		srv->util_deinit();
 	vmbus_close(dev->channel);
 	kfree(srv->recv_buffer);
-
-	return 0;
 }
 
 /*
diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index d62aefb2e245..31def6ce5157 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -369,7 +369,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
 	return error;
 }
 
-static int hv_kbd_remove(struct hv_device *hv_dev)
+static void hv_kbd_remove(struct hv_device *hv_dev)
 {
 	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(hv_dev);
 
@@ -378,8 +378,6 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 	kfree(kbd_dev);
 
 	hv_set_drvdata(hv_dev, NULL);
-
-	return 0;
 }
 
 static int hv_kbd_suspend(struct hv_device *hv_dev)
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 89eb4f179a3c..025f805e1ed9 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2594,7 +2594,7 @@ static int netvsc_probe(struct hv_device *dev,
 	return ret;
 }
 
-static int netvsc_remove(struct hv_device *dev)
+static void netvsc_remove(struct hv_device *dev)
 {
 	struct net_device_context *ndev_ctx;
 	struct net_device *vf_netdev, *net;
@@ -2603,7 +2603,7 @@ static int netvsc_remove(struct hv_device *dev)
 	net = hv_get_drvdata(dev);
 	if (net == NULL) {
 		dev_err(&dev->device, "No net device to remove\n");
-		return 0;
+		return;
 	}
 
 	ndev_ctx = netdev_priv(net);
@@ -2637,7 +2637,6 @@ static int netvsc_remove(struct hv_device *dev)
 
 	free_percpu(ndev_ctx->vf_stats);
 	free_netdev(net);
-	return 0;
 }
 
 static int netvsc_suspend(struct hv_device *dev)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 583d3aad6908..e46d9a14053f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3813,13 +3813,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 /**
  * hv_pci_remove() - Remove routine for this VMBus channel
  * @hdev:	VMBus's tracking struct for this root PCI bus
- *
- * Return: 0 on success, -errno on failure
  */
-static int hv_pci_remove(struct hv_device *hdev)
+static void hv_pci_remove(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus;
-	int ret;
 
 	hbus = hv_get_drvdata(hdev);
 	if (hbus->state == hv_pcibus_installed) {
@@ -3842,7 +3839,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		pci_unlock_rescan_remove();
 	}
 
-	ret = hv_pci_bus_exit(hdev, false);
+	hv_pci_bus_exit(hdev, false);
 
 	vmbus_close(hdev->channel);
 
@@ -3855,7 +3852,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 	hv_put_dom_num(hbus->bridge->domain_nr);
 
 	kfree(hbus);
-	return ret;
 }
 
 static int hv_pci_suspend(struct hv_device *hdev)
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 3c5b7e4227b2..02f9d1a6f4ac 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -2092,7 +2092,7 @@ static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 	return scsi_change_queue_depth(sdev, queue_depth);
 }
 
-static int storvsc_remove(struct hv_device *dev)
+static void storvsc_remove(struct hv_device *dev)
 {
 	struct storvsc_device *stor_device = hv_get_drvdata(dev);
 	struct Scsi_Host *host = stor_device->host;
@@ -2108,8 +2108,6 @@ static int storvsc_remove(struct hv_device *dev)
 	scsi_remove_host(host);
 	storvsc_dev_remove(dev);
 	scsi_host_put(host);
-
-	return 0;
 }
 
 static int storvsc_suspend(struct hv_device *hv_dev)
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index c08a6cfd119f..20d9762331bd 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -355,20 +355,19 @@ hv_uio_probe(struct hv_device *dev,
 	return ret;
 }
 
-static int
+static void
 hv_uio_remove(struct hv_device *dev)
 {
 	struct hv_uio_private_data *pdata = hv_get_drvdata(dev);
 
 	if (!pdata)
-		return 0;
+		return;
 
 	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
 
 	vmbus_free_ring(dev->channel);
-	return 0;
 }
 
 static struct hv_driver hv_uio_drv = {
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 3ce746a46179..cfa6a7c1eeb3 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1240,8 +1240,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	return ret;
 }
 
-
-static int hvfb_remove(struct hv_device *hdev)
+static void hvfb_remove(struct hv_device *hdev)
 {
 	struct fb_info *info = hv_get_drvdata(hdev);
 	struct hvfb_par *par = info->par;
@@ -1262,8 +1261,6 @@ static int hvfb_remove(struct hv_device *hdev)
 
 	hvfb_putmem(hdev, info);
 	framebuffer_release(info);
-
-	return 0;
 }
 
 static int hvfb_suspend(struct hv_device *hdev)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 85f7c5a63aa6..cd5cb9f6fae0 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1273,7 +1273,7 @@ struct hv_driver {
 	} dynids;
 
 	int (*probe)(struct hv_device *, const struct hv_vmbus_device_id *);
-	int (*remove)(struct hv_device *);
+	void (*remove)(struct hv_device *dev);
 	void (*shutdown)(struct hv_device *);
 
 	int (*suspend)(struct hv_device *);
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 59c3e2697069..7cb1a9d2cdb4 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -879,13 +879,11 @@ static int hvs_probe(struct hv_device *hdev,
 	return 0;
 }
 
-static int hvs_remove(struct hv_device *hdev)
+static void hvs_remove(struct hv_device *hdev)
 {
 	struct vmbus_channel *chan = hdev->channel;
 
 	vmbus_close(chan);
-
-	return 0;
 }
 
 /* hv_sock connections can not persist across hibernation, and all the hv_sock
-- 
2.25.1

