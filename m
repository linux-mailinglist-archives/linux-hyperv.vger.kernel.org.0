Return-Path: <linux-hyperv+bounces-2341-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309CD900AF6
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FCC1F265FB
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4013719923C;
	Fri,  7 Jun 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Acyy7jMF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2052.outbound.protection.outlook.com [40.92.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FC190688;
	Fri,  7 Jun 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779886; cv=fail; b=kgI0WR+ZJ3a35QcK6iH90Bl8K3B9MLYQYggH0w9Z0Ym03AK2lu7RhEmg5DDX3V7atoexsy8Sj8O9lnSVtlJZZ/VeV9dIkBdRUHw+R96Uk3t7/BJjbOExpHzCo1cxM6OzIGzMrdkGHqOcGj8rD3c/R1IkwfATCdjeZGY8sWYEAVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779886; c=relaxed/simple;
	bh=/APxzBdGAgCQHYOYy6c4nInDZafkzaHQiFIO8imWRiE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SAG9Zndv6KczJGTZI1JuzHN/w4DI07ICiNc8XspYu5A5Gx7TeTZD/VIDrUacq8YHy+PneicmIcF7NnfILmu+ITiOXvjaZ9AVsbw/5fiyWcEoWeM55qRFbYZfszJxMDo4M56Mucp9C+ghFFfBd/YOdfejBUzoelGgOgGEdNy35qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Acyy7jMF; arc=fail smtp.client-ip=40.92.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOC//jrf+iCdMI+ddKAALgzfejKMmud2WHC96QjxcWxr2E5bOnfXw2gLSSCZ9OdbrvNfh6QNk1SO+ghdtC3VfolSRShCaSbfi6UAbehGyo17i7sHV/KRbxqlZ9uh/zhmkhd8AY6smfTsurtbb5RXN+P+czSMHLj8pZkOkz6Zw8S7er5sq7aCQ1+DxjT46hjm/J5ydxH6DSotjw0V7TsycokJmd4+e/KdSOfDrqg/7nDACfFj/WCsiKUjIYNHtE2BBciZYDIbpVK1R/3H2t8TfYiBQ1jZ5m3GvTiplTv61SsPlscWoGAN9XShwSgPi6SpkUfZrg22iyqQZHMipQ8ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny7VFuoEWNcQDzleN9fURMkBSPtAa8xUyfA1sR83lBY=;
 b=hIHYv76/dmms1lnC/hHyrpy5eGArqckXoWIYvowKPHL+cKVBj7Irm0xyIq+XDV7vm8ATyUmB3mDPfTCP1qNEf0bv4UpDd/l7PCDefRSoqQQFHaPV23RDMxYR8C+upTaHJtP6Tgkmg1p8WmcMExhpa3f/zcR/Ii1o6BmGbdqiVrBwNd5dhz7MvslgrwaICHdix47LiGCqSJlnEYPYT1gIZty37JtR3RUzgWN5iaNtVMQuClkEySEYPCKRcCldA7C8kibJGzn7cpPKrndDj6ZRole4L5xwkZbIMWz14TQfbT97KFC5wb/0tqqQytdCg7d1RmV2nT2gBf9dlDik97d+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny7VFuoEWNcQDzleN9fURMkBSPtAa8xUyfA1sR83lBY=;
 b=Acyy7jMFEMynlmbwEStYSQnQt0qUdWh1XwUvFGoGLizb7urvZdp1SqG8m5+W4leqj+2OoGQUVZiEMHzsZHNwD3zLeBo4eTOUlK0XePjQDe6X57xiFDN7j3Z8cVXppjuTbjg3kiVbuUZ2DMEc7MoAwfb+hAUO8Ajf7VrVedq7TF2NOZaT4j38uaHz8s5tLRCGv3QuFCXVoh7wGUYJqIBosf5+kfEwpAqg21RFYkUe8pxYEMSMtzRJBueTf28In1J8G7nCHALktFDsJ1PKsO1IczMs8aK9JIRMlEIjoET++WNNJbPnyTEM2AAB+kBXO8nDpLovR6K1HmN8WM60HOKffg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS4PR02MB7925.eurprd02.prod.outlook.com (2603:10a6:20b:4b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Fri, 7 Jun
 2024 17:04:40 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 17:04:40 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Stephen Chandler Paul <thatslyude@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Input: serio - use sizeof(*pointer) instead of sizeof(type)
Date: Fri,  7 Jun 2024 19:04:23 +0200
Message-ID:
 <AS8PR02MB7237D3D898CCC9C50C18DE078BFB2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [dvbqOSLz1KQslgDXxDtV2E6m9/LG8Bu7]
X-ClientProxiedBy: MA2P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::12) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240607170423.10654-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS4PR02MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bf67e8-b015-482a-ecd4-08dc8713eb85
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	g7++UpJXAeFjvG1VvrY86WUaIIdelj18I4EXpPfUZoy+iJ7yTcfJVgJRO3OX5jXzYBr79VWkYe/dZwSmqA4wBUlyUWy1vypToG4AJe8WtDgGMijGJuw72NhkyVYXuwFIrvoGXI6rU0p6m0R0CI1RKfP/gfrc43jxrOM2lC8TJLK6RMJBEFFXbT3GM0X4hkZ0IbO1m8otH9h3npQqqgfwYNw2xhTpTF2N8C6idJDsf60cHmPUQUEVGfpJVeRyunOgOzFzYoawaL5LYHALAe1/5XmWdLhNTSuk0Km2CRTxMwkzdvuKjm56uEUH+DkrWaTqO9puh7JVZJ0zPO0JiCzCqd9bHNb29yx0VXyrBUFmdTyGbhgGVf9pDLhIFCeL/f0YvlT7/9Zz0C+fNrkp9XrpmNV/3Zf4Z0SIU4mlqWqvsWy78ZuiZmH6b7x/02/aFjV4VLcHTvxch+Bm1kL/7ZonWtPulaSPLZmLeKRw+fjELzM5msqHnZHIa2LEh62dZtx89y/0pWL/TM4F0LJ1jQUZWK4wzaT2yIiBa0eWyNc8mwC8ekySyYLLYMFd1Qlrl2B0nSS1xFrxhgAWZKIIqLnOClJUJCVT8Qyp/5tzY3u8H9p1fRFQOV5eNHX5+gnQ/KK8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgL3luBTyVrYerYLRXYoe5DYG44XQG058xyWLRWyPjfofTqAxOc/pgyZ39pZ?=
 =?us-ascii?Q?zAG/89clXbx6x3XMG9nFCYvOooxzFVsOm+do1eoOW/t8yySnXLXi70y488ga?=
 =?us-ascii?Q?4aDABBvDPSjJNpo22pkqWmIqHccKuUl3OjnSaSgvvybCtuMEfV46FTU5KwFf?=
 =?us-ascii?Q?kZmI+kHM0kgIGZNnn0bwhSORQjJtNSuOUK2eDxLd19HLBQKJL7hgpcBvpFpT?=
 =?us-ascii?Q?xGiS3PqQYhVMrJu9xYvqRLCLbDW0OE1pSHdiyaH6W1qpWQRcsXCtSdaVTIFA?=
 =?us-ascii?Q?T5m9tPPmEbWp6Yx8EXzcTnpcBsifWMi3SQWHD05YZ2HTOmuJdz2GJMDuqkx7?=
 =?us-ascii?Q?T8+dT13afJesaqrVRkh2mWZSA84e3FYyd34oE6SgaR1FK98jKxWko9aVman0?=
 =?us-ascii?Q?i1LFmR2nYRvUD8+isfxGTOcoUOcM9wuwwh2/5qOzadRLMjgT4trh5KcX0X0e?=
 =?us-ascii?Q?IYvLIeJ65v3NTp70ExytVyRNfFt+HUDyRKzML534NohCOMLdp39rPkjO/TCF?=
 =?us-ascii?Q?RSszpEMg0n2SQUbHEMCIJdu8o/maYZ6f3QA3sQ9QletRKZ6Jd4oTjlHjtlhU?=
 =?us-ascii?Q?K42nk3woCL+kVRMq7Bp5j9+keIEL2AaPAxIkjOSlHrBQbYGhRKiGRiHzY7TO?=
 =?us-ascii?Q?I5OFyJ/fdCwaW0E1WY+1b5afdYCtAd+TOCEE0jYpaEBmuIRENp5oQmJN4EfA?=
 =?us-ascii?Q?SR59jC4AVMFW5qF6J8SAs0KJ3Z0F12Z2fgbzXXna8peO8CSiOtNnUIqEVnW3?=
 =?us-ascii?Q?hxTx+v6JACO/KagE7J0jrNzPuNRbJ6l1jD9op2KN9YcHiwiLUHWrXGYhKhUf?=
 =?us-ascii?Q?l4r/Ymw8PEC0bGddyurv7hA7ZDmkFFYqzabcPCXzfoF/rX2ndfXT+8N0SYGG?=
 =?us-ascii?Q?OWm0dFXCwfNrxyziVYpxi5f9iJjY8uEiru1OQdMaEhpzowk3U8UVE4lGv1kW?=
 =?us-ascii?Q?XukDUZtaDB0dndnf4mBsnakfVXm7EnrSSyFZm7MCq5fU8QitbOMMiQTXuY6Q?=
 =?us-ascii?Q?u2KWP1B61jn6n9jhPL+uE5Cp9sgIEu+RLSCmE1v5XOXWczPJAiNL95yjfKLi?=
 =?us-ascii?Q?IWz+TvZ1IzsF7eGD6Cbu0BrOT56C907PK1dyWaLNc0pyrkAyutDhcMr2L45P?=
 =?us-ascii?Q?qhitC2LVwikXwZBOIyTfKLDQJ0H/M38J/EeAQGshMVxr23d7HXFOoMUv1cvp?=
 =?us-ascii?Q?btSTZAcHEBbKRt7i7gIbb4I0RyvZWdH9tzSSKjpdQTETa4vSZ8XAHG4ydjuS?=
 =?us-ascii?Q?Rf7d8Ltnn6G32ZlcrjbC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bf67e8-b015-482a-ecd4-08dc8713eb85
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 17:04:40.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB7925

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). This patch has no effect
on runtime behavior.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/input/serio/altera_ps2.c      | 2 +-
 drivers/input/serio/ambakmi.c         | 4 ++--
 drivers/input/serio/apbps2.c          | 2 +-
 drivers/input/serio/arc_ps2.c         | 2 +-
 drivers/input/serio/ct82c710.c        | 2 +-
 drivers/input/serio/gscps2.c          | 4 ++--
 drivers/input/serio/hyperv-keyboard.c | 4 ++--
 drivers/input/serio/i8042.c           | 4 ++--
 drivers/input/serio/maceps2.c         | 2 +-
 drivers/input/serio/olpc_apsp.c       | 4 ++--
 drivers/input/serio/parkbd.c          | 2 +-
 drivers/input/serio/pcips2.c          | 4 ++--
 drivers/input/serio/ps2-gpio.c        | 4 ++--
 drivers/input/serio/ps2mult.c         | 2 +-
 drivers/input/serio/q40kbd.c          | 4 ++--
 drivers/input/serio/rpckbd.c          | 2 +-
 drivers/input/serio/sa1111ps2.c       | 4 ++--
 drivers/input/serio/serio.c           | 2 +-
 drivers/input/serio/serio_raw.c       | 4 ++--
 drivers/input/serio/serport.c         | 4 ++--
 drivers/input/serio/sun4i-ps2.c       | 4 ++--
 drivers/input/serio/userio.c          | 4 ++--
 drivers/input/serio/xilinx_ps2.c      | 4 ++--
 23 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index c5b634940cfc..611eb9fe2d04 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -100,7 +100,7 @@ static int altera_ps2_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 496bb7a312d2..de4b3915c37d 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -114,8 +114,8 @@ static int amba_kmi_probe(struct amba_device *dev,
 	if (ret)
 		return ret;
 
-	kmi = kzalloc(sizeof(struct amba_kmi_port), GFP_KERNEL);
-	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	kmi = kzalloc(sizeof(*kmi), GFP_KERNEL);
+	io = kzalloc(sizeof(*io), GFP_KERNEL);
 	if (!kmi || !io) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index dbbb10251520..4015e75fcb90 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -165,7 +165,7 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 	/* Set reload register to core freq in kHz/10 */
 	iowrite32be(freq_hz / 10000, &priv->regs->reload);
 
-	priv->io = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	priv->io = kzalloc(sizeof(*priv->io), GFP_KERNEL);
 	if (!priv->io)
 		return -ENOMEM;
 
diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 9d8726830140..a9180a005872 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -155,7 +155,7 @@ static int arc_ps2_create_port(struct platform_device *pdev,
 	struct arc_ps2_port *port = &arc_ps2->port[index];
 	struct serio *io;
 
-	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	io = kzalloc(sizeof(*io), GFP_KERNEL);
 	if (!io)
 		return -ENOMEM;
 
diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index d5c9bb3d0103..6834440b37f6 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
@@ -158,7 +158,7 @@ static int __init ct82c710_detect(void)
 
 static int ct82c710_probe(struct platform_device *dev)
 {
-	ct82c710_port = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	ct82c710_port = kzalloc(sizeof(*ct82c710_port), GFP_KERNEL);
 	if (!ct82c710_port)
 		return -ENOMEM;
 
diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 633c7de49d67..d94c01eb3fc9 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -338,8 +338,8 @@ static int __init gscps2_probe(struct parisc_device *dev)
 	if (dev->id.sversion == 0x96)
 		hpa += GSC_DINO_OFFSET;
 
-	ps2port = kzalloc(sizeof(struct gscps2port), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	ps2port = kzalloc(sizeof(*ps2port), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!ps2port || !serio) {
 		ret = -ENOMEM;
 		goto fail_nomem;
diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 31def6ce5157..31d9dacd2fd1 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -318,8 +318,8 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
 	struct serio *hv_serio;
 	int error;
 
-	kbd_dev = kzalloc(sizeof(struct hv_kbd_dev), GFP_KERNEL);
-	hv_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	kbd_dev = kzalloc(sizeof(*kbd_dev), GFP_KERNEL);
+	hv_serio = kzalloc(sizeof(*hv_serio), GFP_KERNEL);
 	if (!kbd_dev || !hv_serio) {
 		error = -ENOMEM;
 		goto err_free_mem;
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 9fbb8d31575a..e0fb1db653b7 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1329,7 +1329,7 @@ static int i8042_create_kbd_port(void)
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_KBD_PORT_NO];
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
@@ -1359,7 +1359,7 @@ static int i8042_create_aux_port(int idx)
 	int port_no = idx < 0 ? I8042_AUX_PORT_NO : I8042_MUX_PORT_NO + idx;
 	struct i8042_port *port = &i8042_ports[port_no];
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
diff --git a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
index 5ccfb82759b3..42ac1eb94866 100644
--- a/drivers/input/serio/maceps2.c
+++ b/drivers/input/serio/maceps2.c
@@ -117,7 +117,7 @@ static struct serio *maceps2_allocate_port(int idx)
 {
 	struct serio *serio;
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (serio) {
 		serio->id.type		= SERIO_8042;
 		serio->write		= maceps2_write;
diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index 240a714f7081..0ad95e880cc2 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -188,7 +188,7 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 		return priv->irq;
 
 	/* KEYBOARD */
-	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	kb_serio = kzalloc(sizeof(*kb_serio), GFP_KERNEL);
 	if (!kb_serio)
 		return -ENOMEM;
 	kb_serio->id.type	= SERIO_8042_XL;
@@ -203,7 +203,7 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	serio_register_port(kb_serio);
 
 	/* TOUCHPAD */
-	pad_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	pad_serio = kzalloc(sizeof(*pad_serio), GFP_KERNEL);
 	if (!pad_serio) {
 		error = -ENOMEM;
 		goto err_pad;
diff --git a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
index 0d54895428f5..328932297aad 100644
--- a/drivers/input/serio/parkbd.c
+++ b/drivers/input/serio/parkbd.c
@@ -165,7 +165,7 @@ static struct serio *parkbd_allocate_serio(void)
 {
 	struct serio *serio;
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (serio) {
 		serio->id.type = parkbd_mode;
 		serio->write = parkbd_write;
diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
index 05878750f2c2..6b9abb2e18c9 100644
--- a/drivers/input/serio/pcips2.c
+++ b/drivers/input/serio/pcips2.c
@@ -137,8 +137,8 @@ static int pcips2_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (ret)
 		goto disable;
 
-	ps2if = kzalloc(sizeof(struct pcips2_data), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	ps2if = kzalloc(sizeof(*ps2if), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!ps2if || !serio) {
 		ret = -ENOMEM;
 		goto release;
diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index c3ff60859a03..0c8b390b8b4f 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -404,8 +404,8 @@ static int ps2_gpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int error;
 
-	drvdata = devm_kzalloc(dev, sizeof(struct ps2_gpio_data), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!drvdata || !serio) {
 		error = -ENOMEM;
 		goto err_free_serio;
diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
index 902e81826fbf..937ecdea491d 100644
--- a/drivers/input/serio/ps2mult.c
+++ b/drivers/input/serio/ps2mult.c
@@ -127,7 +127,7 @@ static int ps2mult_create_port(struct ps2mult *psm, int i)
 	struct serio *mx_serio = psm->mx_serio;
 	struct serio *serio;
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 3f81f8749cd5..cd4d5be946a3 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -108,8 +108,8 @@ static int q40kbd_probe(struct platform_device *pdev)
 	struct serio *port;
 	int error;
 
-	q40kbd = kzalloc(sizeof(struct q40kbd), GFP_KERNEL);
-	port = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	q40kbd = kzalloc(sizeof(*q40kbd), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!q40kbd || !port) {
 		error = -ENOMEM;
 		goto err_free_mem;
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index 9bbfefd092c0..e236bb7e1014 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -108,7 +108,7 @@ static int rpckbd_probe(struct platform_device *dev)
 	if (tx_irq < 0)
 		return tx_irq;
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	rpckbd = kzalloc(sizeof(*rpckbd), GFP_KERNEL);
 	if (!serio || !rpckbd) {
 		kfree(rpckbd);
diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 2724c3aa512c..1311caf7dba4 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -256,8 +256,8 @@ static int ps2_probe(struct sa1111_dev *dev)
 	struct serio *serio;
 	int ret;
 
-	ps2if = kzalloc(sizeof(struct ps2if), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	ps2if = kzalloc(sizeof(*ps2if), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!ps2if || !serio) {
 		ret = -ENOMEM;
 		goto free;
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index a8838b522627..04967494eeb6 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -258,7 +258,7 @@ static int serio_queue_event(void *object, struct module *owner,
 		}
 	}
 
-	event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC);
+	event = kmalloc(sizeof(*event), GFP_ATOMIC);
 	if (!event) {
 		pr_err("Not enough memory to queue event %d\n", event_type);
 		retval = -ENOMEM;
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 1e4770094415..0186d1b38f49 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -92,7 +92,7 @@ static int serio_raw_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	client = kzalloc(sizeof(struct serio_raw_client), GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client) {
 		retval = -ENOMEM;
 		goto out;
@@ -293,7 +293,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	struct serio_raw *serio_raw;
 	int err;
 
-	serio_raw = kzalloc(sizeof(struct serio_raw), GFP_KERNEL);
+	serio_raw = kzalloc(sizeof(*serio_raw), GFP_KERNEL);
 	if (!serio_raw) {
 		dev_dbg(&serio->dev, "can't allocate memory for a device\n");
 		return -ENOMEM;
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 1db3f30011c4..5a2b5404ffc2 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -82,7 +82,7 @@ static int serport_ldisc_open(struct tty_struct *tty)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	serport = kzalloc(sizeof(struct serport), GFP_KERNEL);
+	serport = kzalloc(sizeof(*serport), GFP_KERNEL);
 	if (!serport)
 		return -ENOMEM;
 
@@ -167,7 +167,7 @@ static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file,
 	if (test_and_set_bit(SERPORT_BUSY, &serport->flags))
 		return -EBUSY;
 
-	serport->serio = serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	serport->serio = serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!serio)
 		return -ENOMEM;
 
diff --git a/drivers/input/serio/sun4i-ps2.c b/drivers/input/serio/sun4i-ps2.c
index aec66d9f5176..95cd8aaee65d 100644
--- a/drivers/input/serio/sun4i-ps2.c
+++ b/drivers/input/serio/sun4i-ps2.c
@@ -213,8 +213,8 @@ static int sun4i_ps2_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int error;
 
-	drvdata = kzalloc(sizeof(struct sun4i_ps2data), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!drvdata || !serio) {
 		error = -ENOMEM;
 		goto err_free_mem;
diff --git a/drivers/input/serio/userio.c b/drivers/input/serio/userio.c
index 9ab5c45c3a9f..a88e2eee55c3 100644
--- a/drivers/input/serio/userio.c
+++ b/drivers/input/serio/userio.c
@@ -77,7 +77,7 @@ static int userio_char_open(struct inode *inode, struct file *file)
 {
 	struct userio_device *userio;
 
-	userio = kzalloc(sizeof(struct userio_device), GFP_KERNEL);
+	userio = kzalloc(sizeof(*userio), GFP_KERNEL);
 	if (!userio)
 		return -ENOMEM;
 
@@ -85,7 +85,7 @@ static int userio_char_open(struct inode *inode, struct file *file)
 	spin_lock_init(&userio->buf_lock);
 	init_waitqueue_head(&userio->waitq);
 
-	userio->serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	userio->serio = kzalloc(sizeof(*userio->serio), GFP_KERNEL);
 	if (!userio->serio) {
 		kfree(userio);
 		return -ENOMEM;
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index bb758346a33d..1543267d02ac 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -252,8 +252,8 @@ static int xps2_of_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
-	drvdata = kzalloc(sizeof(struct xps2data), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
 	if (!drvdata || !serio) {
 		error = -ENOMEM;
 		goto failed1;
-- 
2.25.1


