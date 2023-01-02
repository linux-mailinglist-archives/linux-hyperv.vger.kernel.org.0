Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8DC65AD0F
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jan 2023 06:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjABFEf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Jan 2023 00:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABFEd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Jan 2023 00:04:33 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2030.outbound.protection.outlook.com [40.92.98.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B6610BE;
        Sun,  1 Jan 2023 21:04:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyTX5regTt4R302yZ1fPRzxZMV69hW7Z3K7Q6v8jAj3e3gf6yfKMzuprZfsyhR9joavjhN9A3RufOQPS0Xt1WCKAYTpzYp/y8csm4ctSG3Cjjgv4gRlvu6q1lGwQGG80XT1QDmW6gDPLjBy0babO06rcmoCh0xsgKOlbo33k3+Ct6q5MxS0CCtoyD3NyZ90b+KvA8q5l+pRb2v3b1vzILgYbn7/nEFrSA74s7kNrvtJk00Vk+1TF4WnmAkR5VN/h2GU9q4F8D6nBDhlwBqXqkdunzTtXfhCrixGBV92ZOFN/qR8GimwSoFnaDU5r4Jmg0xOkFHfqim8sEljA+4vGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orETFkCrNVuvx//NhvJ1WczwBLhqFiawwdwk9u9tKe4=;
 b=nEMboiqX/AHUvlPbLbTppT0TPuy04AmpNxcMU5Q5Ookq1b1LO7SeClaAxplZBn+iTllOkkVyXYHYIvvgZP6bWtft1V3o6BiM9yl5Q6LkGAeNgYBaHwYnpgRKLILOm0mmdtEGxe3QsfW/gwrLUTZMPXrtY+jZoMyc/Pz+sgoX2phv3LjtDsZf4rGYCn24LcKpTTfYxcysp3xPMzD4cAtMhdgSOc/bRLTt9zH+l/iJgIPnJi0dI9gf4zesP6JAofkq9/rfJwq0Oj0rpA6Y0NBjk7dVQAJWGJw8c6MEdRydHrRiJkT9RJiJrfNKvWDoIzaOBn0pWaRt8Yv21OjwupNyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orETFkCrNVuvx//NhvJ1WczwBLhqFiawwdwk9u9tKe4=;
 b=qQ2YvXEdwXUJHX57E21V1zawaU9gEHxlOsH2ELUa9lG2cfCRgLuKupAqxglu3/HXENNRTvODZnfLKsmyfHmvYA3Wzft33JVcLpm6U1TCHtI11HV2GBQP+vCcpCdyWGtKlnnv8I2vUzJvxc6ry68qdueur6zGVJl5qaX43CkN1SFhFhvuLwM6iqSWJ72x/Esbr/DZx136tZL8YPfGUWwkT9W1mqjykWsfi5KxoF8W6Bps8bpS3WMabtrkX3i4AcA0BbZWSPlXRNkF6UBVJaW+pqRfemlALRQHUiP9asRhz+onjob1fauGtRqQ3Y+W2J8Fz75UWBQZCCcfA8eaHUnm3g==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYWP286MB3159.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 05:04:28 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 05:04:28 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] hyperv: Make remove callback of hyperv driver void returned
Date:   Mon,  2 Jan 2023 13:04:14 +0800
Message-ID: <TYCP286MB2323ABFF6E0E47B7E07C95EDCAF79@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bofoPI+zO9POka1KWHXd/TRGvJvqqgYK]
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230102050414.29406-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYWP286MB3159:EE_
X-MS-Office365-Filtering-Correlation-Id: f0915615-9228-40e8-d33e-08daec7ed37e
X-MS-Exchange-SLBlob-MailProps: 7J/vb0KDx3gtHkCmh0mi67k3hmSTQ3Rxm/EmMGqKBnhnpHAJ3qOrI7O4+goeLWxjYlx96ZxZ7U60y7HkJBQxTis5cfyjSeJqQ/z5++wiNqryn+MPn3TdzuRWLgiTdbC60CKBINOM3LHY3v743Q6HmJigCuqJxgMlvWETNLPr0Eh4uPRPjGANZRFOunMgfhmG5DOzSbtrbtUeXOcCtY6evPTAt3B6CXTjgWOgtdu/ta3JaMhjoV07QDofpnkFROhxtrxYJHJTik39HdvWgTBRJDB7+b7mdndO6ficiTt7RRbhWOajO5aofJ2pUoEWB33aPscJs8ArlvPX3acsr9F3K9BaUdi4aTxz97cSxqkZqv4Nnu582Dj4jzUYA5y/2a9HmongduUWV+Nnxluy5AF3xdWC6myDDX7yzbkCF9dGSCA4716hNaJ3EigciyjefHmcFWqSpcWtL1lFQa427pewo32+QynMtliaqyaI7RtCEmin7SYzpumQxliNAk2A25o5zYjtu+nO7v/Dk57o6E6v/XkObaprTaq44WJic7ubCCerz5BDtQyjB9BrZ9y7bMGVg7KWkefJ+WxePqJLjUAnO2H66ClyMoLSyxqfk7RdEcNz7/dTcs7EwfzvLuVW88MRUdYNZoFb6cvbajIyO6zH6UUPHD9FXkJS+HMAaGrAi4SJ7pDpWXuTRRrStysX3zFMxHuti2wzNbbxsd4grfdUdkbbD/uHbs6Yah2lNDSjg5s/sXK7RELPtX9r2ZDKam9fBdBPwxrLjX8682ZUV/gXOn4JuhhcllWQWA7D9Mi000o=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MOBksHPBYGGY4zP80B2OI16JM594KriE5w9VlZNn2YLzT6cdWBpLXZpo0jrrjCK2yEnSZXnFKUIJiZZv8IdkprbEVYa4Y9Z9qNv2hTJBoHMdKS6jQQiPJRuu9qU4IY9bZnXa0QPm6hqZwkTkVoECfXXXzcyBto4Ia1JT2iTzX14FsVd1l5ZzO96qctHA6NXv7jgnpyCDm9Ce1VW8sdkZMsI77fWuaZUo0shmiHftJ1mbvdISrAb/vcZdcTRJ7rCY3H6ALm2kiNSEmv7Tb5onZmrqmuYoGo3YHgEeq7VscVMWXawMr+vgDVhQ/kCtG62Sff7Doy23S6QJasefKmc0syjUgOEWAWDoHGV3chzW42vXip5fRoSrysGSnOXE3vG39GAJvKMI/Frk+1BCkqza/6vFqcpd6D2wkhf0K8xDukXQEae7gWx2Q4x4mZGWkIlQh3slIJuOVYRSmuSuSkqeaK6ytMA6NRc8xnEqCVl3cBnbzH40jNST2D06M7MvJFOkGDFrq5srvGC23uBYrefPuVjWniTsLePDCEAUcF5SJvnoRILyCyzAH3kKJdk0TTs/JugBI3fI1uYu+nWxEVSnbibjQ04V3Dx1xWzqWtVtu0H33mSyL+J2IKJoWUpT/bml5RsDkudJt/S1AGWB+4d1w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u4h+XtN6S19MqwpDbJ4DYAC/zuIDMOUeqh/MdqEluGrYoExME5vCiQ4OckQH?=
 =?us-ascii?Q?6UcTc+w6mFaWNO/N+EC7ctD7p9HdVdvJYyRDrYte11A1OSOTP/sjAU8P1IcB?=
 =?us-ascii?Q?wuZmnNf4LxuzX1pkaIfQkcg6Ax/l7BmLMmhXLit4yMWOtLd6/P1pRUsjxPCR?=
 =?us-ascii?Q?qz2/NOqERYMHRV7B7Ad4/wvy088sCp9w/ChXxyh1BlMZ9MwPrCT6BAGo+Mkz?=
 =?us-ascii?Q?sSFzxRqmlOKDADrCyKrX+Rhtf00o8bXMjb1zYoNyBhkvSezwlF4DCgfSNI9p?=
 =?us-ascii?Q?Cmh4VTkyzCiuHphuMYqxXoZiBtlHPhPZ6kc23z4AbUEzR/URmpkG0QOoALWj?=
 =?us-ascii?Q?2C47hELG9JQzx5jDVn4hWfQJoD7XVhBibCgLyftFJPmCBv+WIh0xCC/aRv4i?=
 =?us-ascii?Q?7Cdp7E1rJLdmYrEHIlEZcSWi5wXeIHKIN6fmJ1Z55mKrrvb760RpRjAiTT7o?=
 =?us-ascii?Q?IOyZ+zNesh++ei6kVOJhn/rPuFUej+QJ6AKRI6Pfn6F/euEe8ZFA5D0jv9Y2?=
 =?us-ascii?Q?7fThr5Udm7X4nFPBBNQKiAHU6U9Z6yalZqncoAjfX+7279IUuyokF8l4emUq?=
 =?us-ascii?Q?KYebK0dLEOe8L4ncDWv7gTLVsAmPZTFQ3XCExSViKdQoFo1tWa7fdAdTciFJ?=
 =?us-ascii?Q?l7Tl1lLO3I7rCfowoNHLmQ/Imf7JgUTyXndALF4orzsbcuNuF3+IAryDVGzX?=
 =?us-ascii?Q?rXbt2SctL7DILvVFoN2PN7LrTgV9iRwM1sW7AoZv9I3Gwo8nANRIv41hJHK1?=
 =?us-ascii?Q?V9J20CNSXLZT70r93YtTbB1Ovvi/7ecYzRRxf9oEaS8MDlUsMJSF52zVbQK2?=
 =?us-ascii?Q?HZWfy2IQkIrViqIElZNZjKR/dbwfkLKLR42/L7LTqikPJa50rArWwaK98KBt?=
 =?us-ascii?Q?iKgK8JwPvmDH4inM94I3JVVfOSvA8RY2Jcz+mvMY9BJRy6h8fahcXW8fxzzS?=
 =?us-ascii?Q?no+jFHjhLLdBt6McTFT1G75brTdKmFNfR7Z6S6RBqlM27Q+o2bfOZ2Qasrv9?=
 =?us-ascii?Q?pP5CGLTnl6+bc+N6Fad6TyagQD1LcazsmTbhLr9yRm2ftIMaFTRoroi4yQCj?=
 =?us-ascii?Q?9XIRdCIk4xX6D9NjetagBzajUX6jpS7apYM+LtV4PWxk4Kympy8mfelATrgl?=
 =?us-ascii?Q?Fof24xKIgJGbABvf3Lt4S8JnbWIw994CsoS1JnilIDjC1xh+MADi1FV8GO2q?=
 =?us-ascii?Q?AfTYO796pjQJBmkoZPiUUQuVCYQBW6+lhnnpJyNHsyMUFNkIzynPLe6uBQbm?=
 =?us-ascii?Q?SpGREuj0IOpuItYEhUVmpgs6IVNmrQItH1m08kUrOA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0915615-9228-40e8-d33e-08daec7ed37e
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 05:04:28.7664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since commit fc7a6209d571 ("bus: Make remove callback return void") forces
bus_type::remove be void-returned, it doesn't make much sense for any bus
based driver implementing remove callbalk to return non-void to its caller.

This change is for hyperv bus based drivers.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
v1 -> v2
- Fixed null dereference issue and deprecated comments, based on comments
  by Liu Wei.
- Fixed building issue.
- Rebased on latest hyperv-next.

v1
- https://lore.kernel.org/all/TYCP286MB232373567792ED1AC5E0849FCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 +---
 drivers/hid/hid-hyperv.c                | 4 +---
 drivers/hv/hv_balloon.c                 | 5 +----
 drivers/hv/hv_util.c                    | 4 +---
 drivers/input/serio/hyperv-keyboard.c   | 4 +---
 drivers/net/hyperv/netvsc_drv.c         | 5 ++---
 drivers/pci/controller/pci-hyperv.c     | 8 ++------
 drivers/scsi/storvsc_drv.c              | 4 +---
 drivers/uio/uio_hv_generic.c            | 5 ++---
 drivers/video/fbdev/hyperv_fb.c         | 5 +----
 include/linux/hyperv.h                  | 2 +-
 net/vmw_vsock/hyperv_transport.c        | 4 +---
 12 files changed, 15 insertions(+), 39 deletions(-)

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
index cbe43e2567a7..3eece5e5b0a1 100644
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
@@ -2164,7 +2162,6 @@ static  struct hv_driver balloon_drv = {
 
 static int __init init_balloon_drv(void)
 {
-
 	return vmbus_driver_register(&balloon_drv);
 }
 
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

