Return-Path: <linux-hyperv+bounces-2995-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2697264D
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2024 02:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AC31C2363D
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2024 00:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9288B673;
	Tue, 10 Sep 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="duIPFWkD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020077.outbound.protection.outlook.com [52.101.193.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499423AB;
	Tue, 10 Sep 2024 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929158; cv=fail; b=kIHhMBavG3PQCROl2tbiU8ByE086EDtIw1CVoBA+2D/mb3Td1I+oLlyqbuRrrE+/ZnPEnsbi6ntfdmAAqy8rXOcPR9+kRLdR6+YoUusCMIvvJWQhvnhmd3i2ewUZcUwcvqqXbHJJxrAuoOWfZUH2JLmAcOT32JTORAJOYNR1tXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929158; c=relaxed/simple;
	bh=D2/kNpBduLtargRXr6ZTDi1YRv2bVTErbIA0UNKkCF0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ajFbd7rHqoRWrjyPT8h17WWdjJe/r8mUSaUQfrH1fFcPo7BPloFOy2px15EHXGu1xQqLTZKwWDgoPzBXUB48tC88DOxkI/HueW746SEU1EZgXIjLOyCVXckPSH6HsmYDM4WpvqM7N76y3Qn4gW7/mke3slP7y5GqaChLUJlMAGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=duIPFWkD; arc=fail smtp.client-ip=52.101.193.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBYmwNIueKYMDdhCtDRdyOIWYFcMJNoNLK9XqjDyzBW4/RwCturDIoaUUF3BJK+PLLltp2eirTIUJiEgrhaMbpeLZj2OBCjrGb3L7YaYixe1fD06eNI0gXjc6DpKvX6caVycrt0ABXSI3IYU2nHsTi4wXZ0R5ew+Dq5IqU7jiqpv2KaQqewKk7ONOVK7NCPCh6jFFoXEz7zeC4Ek1nDJrLDBg1Pg7WrIE0JZbxre4567VdAescs+3t74RikLiqHr90BnFx7DIXbBp0R9rmKGuEeaqiEFm1nC4wmml5hkc6e7GPlAYm8PYNchv2qci+8eSoXJW/CUlJ1s7UNIDAs9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUuf/AEBRsx05JbMV/+uwa0VrhZsiCGwV2k+3WfByN4=;
 b=YaY5FNO/RYkAJo0QnLo+u+PiRH7Wr13qDeYQD9rgIn2XrVFWzVJLaqaxcAhUqUBLEAUyExwILTzRvwCL0/QjOOpIEZtCjOhU01+oSZS7kdkYDYXRBR1/8IUeQrFVQz7RAyp0il1E2vUGyPIA8I+QMNAZ41wG234sHPXjzSXx1kOFg0xTtMl6FUlqpS2ycXoeAoKAZ0txi+bfR/lSyseVVtEg8yzg4WU2pmTeNImnoHsyYmBqJ6a08+OkRvI1JgB3TrvJqWRd9Wdfvn5Lnoh8N0PGd3XFZ5WrdSOrWjYG2RCbnTEIdFEJ0FqU1cZPf8moVjSsYrDHXIgev3EwKHg3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUuf/AEBRsx05JbMV/+uwa0VrhZsiCGwV2k+3WfByN4=;
 b=duIPFWkDxvuzRE9k6NIDkguqOhduUZ0M1kiMCx0RY3ByfrFwBASPx2VdlQonk3eYWZwmYfhAXjMPj/DLH4dsrD8dNVJ7VnBAd/gUeJaviVXoZUUeFjxV62pwZiIWbPxkDItCT1muoBXrWQpKEfqSj/KKYhrVsX7ZPdTwY4WEqts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by BY5PR21MB1425.namprd21.prod.outlook.com (2603:10b6:a03:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.5; Tue, 10 Sep
 2024 00:45:54 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::fa84:e37b:af8f:a1cb]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::fa84:e37b:af8f:a1cb%3]) with mapi id 15.20.7962.008; Tue, 10 Sep 2024
 00:45:54 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: stable@vger.kernel.org
Subject: [PATCH] tools: hv: Fix a complier warning in the fcopy uio daemon
Date: Tue, 10 Sep 2024 00:44:32 +0000
Message-Id: <20240910004433.50254-1-decui@microsoft.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR19CA0129.namprd19.prod.outlook.com
 (2603:10b6:930:64::27) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|BY5PR21MB1425:EE_
X-MS-Office365-Filtering-Correlation-Id: daa749e1-d28b-4e2b-85cf-08dcd131ed5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|52116014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4XLnohdAEb5h4N66+mH9D0MhNzrW7vkfzUruThUc5hKltKMAXd2qDuxXkB6v?=
 =?us-ascii?Q?AEBAvnxJPJiIiE8MUgHjfYd+s7y9lqVoz592a+l9pOJz2jSG4xwi/nVOpncv?=
 =?us-ascii?Q?qEzJD8D2coQvLK5PzSbpES/kOEBG+KAhJOgDD0XpbtQBXxxUnJp6w8aBSpAg?=
 =?us-ascii?Q?vKInaevORVz7FNrjd6+T3yTYP5m3TmC5xCnVVzveXq+BNin7mgKpP3f9s38Y?=
 =?us-ascii?Q?bXmJJtTQXGng2sV81BKxwVhLJ409VoNPgFM2ipSGWpJ8/vZCmI1ZE/pawmp5?=
 =?us-ascii?Q?S9CpBEZgdWuFI2dz6rYEnGBJFNrzqAzeH6bUuzhpu8cwFgjQCL7LL+zXNE/h?=
 =?us-ascii?Q?P30Mrg/6A0BOH5JnzJPGC7snla4um3vUHwaji3fOlgXZ3ncvPIWHAjxc/RPT?=
 =?us-ascii?Q?QO+XHypoJjerwEqFxD8TWm+0p/QG08ckXKrGbjacj/VJRnR8KqpmLEHvQOEm?=
 =?us-ascii?Q?JclmwINZWPI56vxdDd7WQes8/VkyIooMGt//vGTP3HMFahEu35x2KkiCR5vY?=
 =?us-ascii?Q?ZwJn/flH2aNmECysOy5i68SA4rkpjhsi18oZGzYw/bI/zbEJjhGSNYmGvt6O?=
 =?us-ascii?Q?qgGyfS5wgNIC0huJpfWN+whoXEkwwvqnbjDLQ9ZqknaQjgUfMrRzhELpWIeM?=
 =?us-ascii?Q?VZ+NT8agyMTSPd1ewXtrn0gBu+P9Dz1ukVJrsYcsxyTDB7IJBq6HMh4xvdc4?=
 =?us-ascii?Q?ccXGmvjkl0EjSuyo26uJ27Uf8ol51YddmuPsmERyTDEMvidS7KA6/909SwNd?=
 =?us-ascii?Q?Z9iJBjb2gWLQ5Ni/3F2zhwxPB7Gw46ceiB5eKZR5ww9tK4QzHUGgoAZd2xJc?=
 =?us-ascii?Q?jnntYV+mUbhIDHSCxMgNY6HwfmSOUya5HSHPWoUvkShXb/aqnKHwTXeZLUXK?=
 =?us-ascii?Q?5+PceM4kmzUHOzeG5yaMsc8hjRWEjQQejnkg1dSuYjwvIMWBBzGFSGy5vGd2?=
 =?us-ascii?Q?qTCrLfFjimpYcymwr9AAw4j2407QD4KBR1QO2Cxj9PHCvJDuOb1HApD7WVZQ?=
 =?us-ascii?Q?S2YrWHGpJN0Hq/z4cFKpDcefLzXUtD/vY29iOgClDcE2jspZFK9J1FobIhwE?=
 =?us-ascii?Q?6nMvWJIGqlj2w7Xhmnsb/nfk0BeD8wgkCaOkZA7rJ3gLMrEtBbdsJOv/IMX3?=
 =?us-ascii?Q?nWa2BCPWy5PHq0NiueKI3gH25hJ25/J+yB428QK4t2uCB+iEGkO5lXD62TnF?=
 =?us-ascii?Q?zQTtghjqKRgrX5AHtq5MP1it3cGtxxhVluBUzknrM15D20ZGNB7YK6pecNYf?=
 =?us-ascii?Q?bLv+8vvsEd0hj7Zh5X+CJXTk85Tc4WOpj9FWEfYjhtkfVvVIUiwiV9nnuG8a?=
 =?us-ascii?Q?vI15fcUCRxVVnnkJHweME7qEp+bn/9vLinPdFuMK+pT94Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/zYqXGVI521yD0pD7AvdFfYOlbcMWIyejgyoTWkmJAxFAuUE7PKouKvcVfr?=
 =?us-ascii?Q?o1zj4uVtKES0TtRwAk4OsSfo7hlUNxS+X4XOrJJoEFiYiIrRgGFfx4Lf2YSB?=
 =?us-ascii?Q?RDfpmX15lyf5M1yExhVYhqw+y2PMcPRS9pu243taujjKb6r3H6j6tJ1BJB4+?=
 =?us-ascii?Q?IhtxscYiMacFP5aQKb23NCXpA9ojeRzTBGPXWan1UiOV2VvEeXCWUQaW93Sq?=
 =?us-ascii?Q?dTebfv3DomdfP7pp3Za3mR6+K5mrgdP6NZP3wLCZSv3B1R8e1Ow7KItLc9ZQ?=
 =?us-ascii?Q?D2g4h/Xg8L9R2sV9TSN8i1iofgokLT7+oyXb1cruqyDb5VcPt/3zo7nTxsm3?=
 =?us-ascii?Q?zud2kDWqAvLGaeSKYztcGjoyhZ0rCCuaM3mcnLy4ibz687N8Ucvp0fxogXXa?=
 =?us-ascii?Q?lDqyhWuS5088I+haeK1kqSJZZM8qovwirhkhAe0zEOKlWwWllS/BBrF24rzc?=
 =?us-ascii?Q?GUu6l5uLTTX+Du2ayBWThLkjRfbDeESbdZUrNrbmJSG+50ywrWBrXC5zO48R?=
 =?us-ascii?Q?os9ns15vi5fhxt4FX+ZBAiFzDXrQnSzg2hPa1ucceqgSyrQPRa+wQei71EKb?=
 =?us-ascii?Q?gNikaq2fxi/5YHjI+6bz8Hx/MOmRIEGhI400laMXfn7JEOBK5KiFES0YkxWn?=
 =?us-ascii?Q?L8Y1GasQxSnQBul4SQDwgQ1enz8U8kY1+XqR4vQy+hkRuH+W6y6fVFJ3V/jf?=
 =?us-ascii?Q?vcy+NtKc7qxpF1cRRIoeHg6yYsrF8Uq0wGlO0u/o3kYpnXhzlS0BsMsPM586?=
 =?us-ascii?Q?VnAd4jUvLU3hGuZxwAj4WF8isbWBCJE6GdhEI7eYiGUFQKA/U3XHYJ2wq/ZR?=
 =?us-ascii?Q?EKPfaAdvyjqM74xgsw7jWIy6s7UHsUXIWO6fxWc++pJ968zwP/C/USaUS9qN?=
 =?us-ascii?Q?sPRkFd4LKVbJ9/42AUOTf7VwonAiebyIjSB9t5C3YfN8rv/6Fhk0VTBDF4uc?=
 =?us-ascii?Q?vljGJIR9MJAeW+f++zuEdkMCXk1BYg1ux1PseOi3se8T/wGrUiSw69YOtDoL?=
 =?us-ascii?Q?cQ0pxwKCZEWDcyVBXajAe7ttQfqwHOYu/1U35lw7/nDqHTWtnpeEY33w7f+t?=
 =?us-ascii?Q?J4Fr2tT6/mwpcKqYdusMij0Pw0HwgxFclU8briRiKzpUKN1+2iouRzjoAopv?=
 =?us-ascii?Q?nw3ZHG5ZWspxXHEYO59/ZHSnv6xHHop/Bzty2sGKK5MEY2h79G2Ve6jYHNc6?=
 =?us-ascii?Q?hBVsIGwjSFeM9A0yxVcZZO9A72EYAR4Hnq2Kd0RE+AdvMEiYEoIhqAOGzKZ4?=
 =?us-ascii?Q?jwpiSdrYgg/4Ze+rTNXC0f5lbXT1NMn/AVQIKS9rm54MY/Y9hJZkciw5DhVa?=
 =?us-ascii?Q?q5afqlPQdqVXedLvH0yXa9eVOtDEyIgNgjFTqZW2V0CrfJHIE/0s3S4CxZfY?=
 =?us-ascii?Q?0XMwB8Jg9Uj05hc8NuR59noUD+c+OKHCaajeuCw3UHlm+F9prCHbUROSfhwR?=
 =?us-ascii?Q?ymXL7M+ptEPIGphnmYZhLXSlZMVitVlJdakilaovdcPNOCgV67CSTsbUgXub?=
 =?us-ascii?Q?ppN60U7Xom4bvOAD7/WATf1l2RbNfATjzR7oX0+SteUY3D10d/8ZhNlxF0ve?=
 =?us-ascii?Q?bo8ttes7O28v0olMH/WKx7K3MymLjFALrrmb5B7CnuZQorBqr7bQpui2F32N?=
 =?us-ascii?Q?klswdq5GtRJyIWjVJRujny4HUJBXuO2YpzgTJ6k/5JmH?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa749e1-d28b-4e2b-85cf-08dcd131ed5c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 00:45:54.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNEEdtpb9kpP89ryhsprA5XJzZYcU9Axx01ztN9K1fjrnDDNaU8O18gQMDDkhaXuKvzpzqNB0m1lG529kcEebw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1425

hv_fcopy_uio_daemon.c:436:53: warning: '%s' directive output may be truncated
writing up to 14 bytes into a region of size 10 [-Wformat-truncation=]
  436 |  snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);

Also added 'static' for the array 'desc[]'.

Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 tools/hv/hv_fcopy_uio_daemon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 3ce316cc9f97..f7741af08a79 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -35,8 +35,6 @@
 #define WIN8_SRV_MINOR		1
 #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
 
-#define MAX_FOLDER_NAME		15
-#define MAX_PATH_LEN		15
 #define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
 
 #define FCOPY_VER_COUNT		1
@@ -51,7 +49,7 @@ static const int fw_versions[] = {
 
 #define HV_RING_SIZE		0x4000 /* 16KB ring buffer size */
 
-unsigned char desc[HV_RING_SIZE];
+static unsigned char desc[HV_RING_SIZE];
 
 static int target_fd;
 static char target_fname[PATH_MAX];
@@ -402,8 +400,8 @@ int main(int argc, char *argv[])
 	struct vmbus_br txbr, rxbr;
 	void *ring;
 	uint32_t len = HV_RING_SIZE;
-	char uio_name[MAX_FOLDER_NAME] = {0};
-	char uio_dev_path[MAX_PATH_LEN] = {0};
+	char uio_name[NAME_MAX] = {0};
+	char uio_dev_path[PATH_MAX] = {0};
 
 	static struct option long_options[] = {
 		{"help",	no_argument,	   0,  'h' },
-- 
2.25.1


