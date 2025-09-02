Return-Path: <linux-hyperv+bounces-6693-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B2B40329
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105214E725A
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291F31A563;
	Tue,  2 Sep 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="k9U38kWc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013048.outbound.protection.outlook.com [40.107.44.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE231A07F;
	Tue,  2 Sep 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819500; cv=fail; b=SL/SanM5K4EMigSLHdrhuSv5E7F7BoyhhMaLwQJaBakTuGNJaxgF4O8FGd8NUFjY80dcYFi3TaS6XiQDIH7j/URuTKItkl4Ye3fmnTSogQWffPRhqeNelg6KpSBiyD20Kr3zZf88dsUApcB7f6e/EJTrF2RlwvzmkfXUqi9WF4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819500; c=relaxed/simple;
	bh=eoD4ACMbt4FD1aVw7txNQ2psFz8j9lWLPMyTyGnUv24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcSqZZDM5jV0BJr8EHlbqMTH3YPfebXSzCtgJMtLKYQwa1qQpPd+7Y/heFhdcrqlO1Z7ThKWRzwjqEa1Pw9CNx7rVtGo5Lth7hnbiZnBlmKfsVE+m4Uok6kKJJRjh04l9ONVQIxBRS8CbaK43udSpQJEmyQ12cGDxHx/Df1UgnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=k9U38kWc; arc=fail smtp.client-ip=40.107.44.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUwHBeOhBDw0xC6RMWlKN4ri4GbHbQNBRj309cWuddqKbn8MrP52tny+38nSYjeWY9UHQTlG3/jsU+9Y5QxwtnK4c9XCXV0NSwnlgnhcr50Z3WdEotsEaga9/TlYVRsWfZSUmq8U+m62qPnzKD2IEu/RO1+38twVqpeApofaJGrF3/JRJLa18kjQ28o7ttYYOYte+tD5FPmR9DGWBPMzvgRs069RNyElY4ulyKIG7kkuVqt15zAew9alXoUrrZoOs3QuRlbjdCSVx3aETEFVPOhSQpunlTk9wlNw4FNcuAnHnAFM1OJanWtOsUrLrwUWB1Q6+1oRKvzN5y/ARA5UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdO23tMuD7MKZewk48dSurrBvHCt8SznUlx+PrNfbAw=;
 b=gTSdH/9JhmVQq5TZ5ykZ/KQW9MCvqAPPUbZfFMaFRmvmBVSMLB39gqU/Ny7wscW6B2rgP1INvgr1GcBjUNRUM3BHpTCnIy29saXqFTA7ZwqQ6p565XKYclshQ//TU0BFu4RlW3QWzrO/xSlsbV9K4QJWLHdHPVX929gFnTM5H3moDva3NRbqxC/xwRh6GOlX+lr+5Vm6MAgYBy+mVIvFpmfOhFRC489y9awVQqatNB3Bt9Bv5MB6VbohTzGMmHU41sEfFHarag3fx5qU1jU0ad2kOWqA35LeAwASgkHXo5hHB8I17MnWAynKQWhd5v95ocuZBL8sBxI4y4Ska31WGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdO23tMuD7MKZewk48dSurrBvHCt8SznUlx+PrNfbAw=;
 b=k9U38kWcT3YFK4DGt493C5+hN8vsJ59mMf2QIwjbbywU+UZcmDIxeCRuRpCA+rZ2cxmyyAaMmT3ueUFKfh190UOFOYzbzVais6REyDQsOdsKEeQdVqGcVIm3wxInq8tSzshtObcDzAPdTZc4wBeR8FMr1jQMC4Be8Cz2hcJHiDo+SVo5OKbmX3P1HpaxvWfMV0sgskzy04BlwbPc9venlYkeaB2CrW+nDYOxAE+1iJpl8i2e2pzVlAKzss2oMqQ5WbO+Zn9mxl0nCKuQnsDwnD9m3Jz/N3NJYlp7KQIZ1hBjGjeNoQMnxuLXyZo/EN4njMzEqjaSkM47D8ntg9WZdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB5078.apcprd06.prod.outlook.com (2603:1096:400:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:24:54 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:24:54 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 6/6] scsi: storvsc: Remove redundant ternary operators
Date: Tue,  2 Sep 2025 21:23:46 +0800
Message-Id: <20250902132359.83059-7-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902132359.83059-1-liaoyuanhong@vivo.com>
References: <20250902132359.83059-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0238.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::11) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bab453-2b01-46ec-4c29-08ddea241a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3hL7zfm6Zjn4U41CD6TVQPTXUDDqKFljSawP91U49sE7xV4Rhegs+LHLzSy6?=
 =?us-ascii?Q?36v4wjnF3klPFWLCAln+unRrl+82E/OCkIa3dOnLPgndJAPGoiNR99Lfu3O8?=
 =?us-ascii?Q?ZTufjPYHJEbnCOs3GHKhkIox+Zs1x8r0O7AcPNlA/YbaL4GwmV0HHeAKvlgf?=
 =?us-ascii?Q?By9YnmhVtJK02vqtDCS1Y2Hj/2opIkEmxdgGFdN/Gq+nWzDu84oHH8iuZS32?=
 =?us-ascii?Q?jNCo6LjDmNA03o0106lIc3w+S/LFi/k8KdEemlhXjmWJVFOKML5Q5KOnKWBO?=
 =?us-ascii?Q?HvUygHGJ/BIlkUc27xbO2UVRV4ve2OhpTITnszLJ+hW6V2cYr3Y3lK3ENQao?=
 =?us-ascii?Q?nIL4QluUZuNw05qo1Nsl6sUsAWjdoADvU9z1TpRaZxGJXFMAycdgPQw7Q70O?=
 =?us-ascii?Q?c67UjjJ7Xt1ug29bRpbiny+EGzNW1GlGymyHpNaGGqixPFEnpo9uUBWEyA1W?=
 =?us-ascii?Q?nUMlr+vwrU3pAdBrHKlZY0ket32uRl7yUZ5QLSw87tRKaykdYjDLAmqysait?=
 =?us-ascii?Q?Rs1R1oIGV07yKi0jZbPx7zP+lKagor9QAMpvfjYNB+Q+wzvao2TTo0gX5gvg?=
 =?us-ascii?Q?jfvZtaB8gqaHDEvlhEVFZL9beX93AT/50D0p6Q0k4bzsATyXwfNPGn3k6O0z?=
 =?us-ascii?Q?75hMGqRjRykECFwNo1xAkecKaLe0SSnGK6Q862OUHr4xJyygQS7uBHbqgfHM?=
 =?us-ascii?Q?sVEi58fnn0JLXpBjB7ebpfzBTAe306oenedyxbeT95A/QboxZ5YmpwYQgxSm?=
 =?us-ascii?Q?krJukXZDCAcow/RaCN6lMbjU9zBo2ZBm1bm1wDXS8wEKEuVy/bEUNzNKG0D2?=
 =?us-ascii?Q?P1ViZ1Rwl7nXsiBN2tSrGOtIuBjG7Cu1YmU4vcz8wywD8uUV0VXnK6m/UDrJ?=
 =?us-ascii?Q?3Nap7MvIlUetcfD9woQJsVSs+YdmyJQ1TKGq4arw2FlHBkFlv36AMEq+/76s?=
 =?us-ascii?Q?y5cs4yQpRqC5FvGq4J4GAmuAsatpPeiIVu4kbxGHxV4datkD+24GrW5sz48S?=
 =?us-ascii?Q?izDC+n4+xHmYUAkJZsDd7VWbpuW/NHtRyIc6EqBNOGYBlwwx6wan3UQH1FlQ?=
 =?us-ascii?Q?FQU0sLsfVybfo2XDFfCNdcde+X592b4HqSGrT3Es8DMEuSMdMLVPyEtdhHgF?=
 =?us-ascii?Q?p+6UdADv+Zykj2+FaOEbHpLlARfd+Z3O+LGqOI6cR2AXXGgu+Vf8Vcl2d6GS?=
 =?us-ascii?Q?n6z1ijJBaXo/0xRJbJXugpKB/20uci5xmmu5yCCCKZjK6Sor1q572FlNqEd+?=
 =?us-ascii?Q?Pgj1jLbN+zibqvP79NUYv7jFQigQ61eP3VmGxEU1aOdUN+Md/jMmBNg2O1u9?=
 =?us-ascii?Q?deErfOrOFyCulrzUzITjGQnVzIzSFkTbT9rJvVfh7PbOKrMLxGDBGZ2djwhC?=
 =?us-ascii?Q?HV5tBoPJWIYiCFDMcnuYxA/Q6U18LYJlBfMYjZUOg0Hs76EJ8/SsUc4MUzs+?=
 =?us-ascii?Q?CbVWQAAlGutKSUEkt33gbzchW96SiyqJBWBrvFYp5dI1HgOVXM8Qsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGVR6BdGAV0GKvCs8SaWeJz+yTrFUIWpbet7TacYrQV+XV7gjyg2N59cdjyP?=
 =?us-ascii?Q?vIJ+Oxht0f2tzbIyQnjPX5qlPXdTEKhDq75NT9S5gL28GSjS1vfDKtGrkLt6?=
 =?us-ascii?Q?Fyj4SWWlDwyTYn7cGk6cq0+WIHDQYA3JCvPf2jwBVEryYSaLS6nIAA6yB9uv?=
 =?us-ascii?Q?FRPcEkA1VnDFTAW/osSXquzciPsTXQq1FRCwgpaCHzZEiWMbbDGTBLEgbShz?=
 =?us-ascii?Q?d8b8fYtr6O/5VfnPXwZYpa+LkZyeQRJ4ARktLdhzywCom7soopDgS//IImt3?=
 =?us-ascii?Q?l226CaQOOq5xI9fxrYXAwqtwNMGvCTAqpvx4Se2M0WeJCTRNUfkQata4rBML?=
 =?us-ascii?Q?ozfE0vWOOsTELCgrfi3moUH6exzDbIM4Lw7IFMfEPemmzVWoQYBAg5hqaKOb?=
 =?us-ascii?Q?RS/9tFjJCiCiFp9dqYhg34s0WuUIdGC6kFfVVWgV2KBgVwtlk8DUMTGzSrES?=
 =?us-ascii?Q?nWDGQa9jrcQ6LGYcV4MlBefVxj7mmHAXhifhDWOEVrU6sZ9vVnn4YXPcWcFY?=
 =?us-ascii?Q?3X97S6bh7WO5K8RT9Xnu0n/0J/9fln1jHGAxOAnf3PBi5y6yryvpbGQ/cZyu?=
 =?us-ascii?Q?Mxbawl6hcBTMAf1c+Frhq9WAedfU4p8XNSfTnyqGqnapj34hkkYtF+5UIqac?=
 =?us-ascii?Q?h9eio7wTjYIqPiroLSGAZmjPIlEayz8ciqYwqvErIsE0BN6Nigj0c69BkWbi?=
 =?us-ascii?Q?CeIRx8wssMSEvB+gacyJYv8YVPdrqq+8z5f7C4YRjmNwrHIAm8nGcRGouWFB?=
 =?us-ascii?Q?UwjwQGRlM5dUE5w1Mn5Ue3nzbyJ3Z/c4yF0mnJlsdI75eQHezxFseqrxxN80?=
 =?us-ascii?Q?U3b+lBtSsYvGD1lPBoDvyx6XhIwYU3AwwIwXbbqtbWLrOY9BWc2wbDHugHVh?=
 =?us-ascii?Q?wMhRW9Ba6dCi7Dp8s3K6XIzPZxW5TLujxm5WLCeka8+f0ExHiKiHVXlQCSTM?=
 =?us-ascii?Q?vtaD/3iyR+vEO4ipz+c1ezzRcyvSIVraXF/5kBlL/WjOvAkWecfDKQjaZxqE?=
 =?us-ascii?Q?GG/pqfCCtXkPh+NKGO85nsU/4nL+XZ8ExR+JJ6CChf9iU7l6J+8v31nEEIx3?=
 =?us-ascii?Q?8MIVgA3Usdnae1ecZkQNLAaNbj+CWCMsj7ftPx6iw4js/iQQyznS6/SO4rO+?=
 =?us-ascii?Q?2abjZ4DXtMTd6kZHoElzToQkBzqHQGz58XnKkcV9DSZZ3HeTU14nnUE0fBQt?=
 =?us-ascii?Q?rBkybKLnewvDKk/fTC/5Bbd6KCWEBCWencZ0vFqL5FGGVcbmDRgyt6r5i0iw?=
 =?us-ascii?Q?btDCg3mtUnHo4olzDUi0f+DaQtP7ZIZ0JCm8f6e1qd31fHJcsdtKeHefQovL?=
 =?us-ascii?Q?CmRXfYujLq9QOxisPuiFZDSu5kUxHAew7rrzNKLmGi9ufa0sdRaZUdTU+vQW?=
 =?us-ascii?Q?u+TxZoP5R4CjPhifmjHIk5Ia0pxbduVL7uyrmMQlz95YJ5ns2Z7kaLlPXYoK?=
 =?us-ascii?Q?YiBcjRD7jLtYcbXqVkOYILFA3V3K8fZ+5xCF0kc367IVYCiE68ySDBcYF23U?=
 =?us-ascii?Q?prSDNwpIhJUy1WPZnU6lykn2t4B5qbylpUJL5lrab9Nd6v2viAJQUOagIQuE?=
 =?us-ascii?Q?nhivVjBt5az8CehMkmQpthL1nTkAWby8E0zMuxHo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bab453-2b01-46ec-4c29-08ddea241a68
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:24:54.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Illi5Wu8saQuqlVyOc5HrMldvrytv5vLKadrIRkLD0N3AdR1lbxth8IwLjBu8L9wlOOqX0LgsgRN0AdkuT9wFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5078

Remove redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/scsi/storvsc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d9e59204a9c3..7449743930d2 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1941,8 +1941,8 @@ static int storvsc_probe(struct hv_device *device,
 	int num_present_cpus = num_present_cpus();
 	struct Scsi_Host *host;
 	struct hv_host_device *host_dev;
-	bool dev_is_ide = ((dev_id->driver_data == IDE_GUID) ? true : false);
-	bool is_fc = ((dev_id->driver_data == SFC_GUID) ? true : false);
+	bool dev_is_ide = dev_id->driver_data == IDE_GUID;
+	bool is_fc = dev_id->driver_data == SFC_GUID;
 	int target = 0;
 	struct storvsc_device *stor_device;
 	int max_sub_channels = 0;
-- 
2.34.1


