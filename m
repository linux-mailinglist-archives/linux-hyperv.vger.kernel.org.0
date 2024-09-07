Return-Path: <linux-hyperv+bounces-2985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D063B96FEC0
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 02:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8B1F23CE9
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 00:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7FC125;
	Sat,  7 Sep 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a7l54SMd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022140.outbound.protection.outlook.com [40.93.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D2522A;
	Sat,  7 Sep 2024 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670387; cv=fail; b=tt8WGL8GZXtqvYObc6MnFzoX2u+UoFLUPuPgMC3HUhnQZjYirUmeOfz4kOYDY2So9dLi3+WVjWSpdIVNM0kzJbwdkqPifXc9oBrI810YW93qolUFkjMApCinQjSQnn716ZsNPWhgvzjsCJkHFILie6rgjf77/73kxFpe26eCJaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670387; c=relaxed/simple;
	bh=nwUFiFhV9sxsQkBkQ6PNOBvP7P9XSkJwv5D19LcxZbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ct5skniaog6JVdDIjg5HCZwFvZiCuhpAa025/oVxSZGuCtOvwEtJt+bhKvqd+eY2q3QL+87LFkPyTinjPdjHBm/FEQHKHu8g2cFaHUp54xlVX/fvLBRjCIIMNjEXzuSRXp2hZaxemg1z70/LDZeYAm3p0ShyWo7j7sOH9VAio0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=a7l54SMd; arc=fail smtp.client-ip=40.93.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBvRIc8LmI9hz5WQcjJYdukD9qzMi7Sc+rJsmBP1ST39R4M0Neaavz4+RDf99axt9lReqATDHM3lZH/7ip2TnvO4h2SRtVMc4hz/pdm9QMPbrzc17a9+VumDPgTXcbnFHrAULMtyFADP6ZQkaCDYhjKJaap38Q73hlWAqOefJeLmv/7QuCd6iLRacTfkGZmiDI59fwwoBukYcOBM9cABbmLR3uXZp3HMnAIQNRmACHngcRPTin/ke6Qf9L5QKeqGvzdiYh228IpT9EwuvTWTt8z/m0zdQyeT5PDQfu63TCzDw4Cg5nz9bEIYDuUyNzDvp1qBb2gqT3zSvIoXnX0ITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwUFiFhV9sxsQkBkQ6PNOBvP7P9XSkJwv5D19LcxZbs=;
 b=IqpKfZc7/3F2qiiv0N5XOD+PAQpbb8FlKU8261uvbCLTOqGsGPO0JMGnzjJOgObMtcrIDwVbWMmtw/BpJ9ZCUlMRLQD0By7SRWrv3ZHz94ia7UPStnU/NxBukHz9iz/Cx/G6XPI51LB6bS5/B29iCzSftkIGjzcDFPRPp6pt7X2eCkwHG9Z940997zSRYkidpqG2CYmhw1WTZM2XAjeZ9aRxEEmM63Ztxxrq20T2KDLwqlX9lV1rM6/NVQbgKsXoBJa399t+xJhFCW25Sdpeynfeh7gj/PFiP2Ft6ILRCClx+oiOmEvYGc+aiJZ/ASNlcvtB/Sl5lRlbVUZ2GjBx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwUFiFhV9sxsQkBkQ6PNOBvP7P9XSkJwv5D19LcxZbs=;
 b=a7l54SMdJ+jF4osrIFFMe5n/wkViyjWcRTh9uRI4uBXMYn28JhPYu+qGeSp6rpvMEZOv8ioT+X52nvcY17xizzSJA/5oTunU6ml4uSJZuTT4iJn9ywtF5WlP1/u/txH5tiCBGRgRv6yt0t1M97lF8AkyyOH4+xE/ZhL59lOiP5M=
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com (2603:10b6:a03:3f0::13)
 by BL1PR21MB3043.namprd21.prod.outlook.com (2603:10b6:208:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.4; Sat, 7 Sep
 2024 00:53:02 +0000
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::4e67:9db5:14b6:2606]) by SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::4e67:9db5:14b6:2606%7]) with mapi id 15.20.7962.002; Sat, 7 Sep 2024
 00:53:02 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] tools/hv: Add memory allocation check in
 hv_fcopy_start
Thread-Topic: [PATCH v3] tools/hv: Add memory allocation check in
 hv_fcopy_start
Thread-Index: AQHbAD0SCTzRDXVA9EKiixzdR2y3IbJLf8nQ
Date: Sat, 7 Sep 2024 00:53:02 +0000
Message-ID:
 <SJ0PR21MB13241C31DBE2ED848F80E663BF9F2@SJ0PR21MB1324.namprd21.prod.outlook.com>
References: <20240906091333.11419-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240906091333.11419-1-zhujun2@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b37c061f-1394-488c-bc81-1fed5ff94f68;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-07T00:51:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR21MB1324:EE_|BL1PR21MB3043:EE_
x-ms-office365-filtering-correlation-id: 8c1564dd-4d89-486e-c2a0-08dcced76d25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z5GnOes5V3hMFHyqN5jwzhlQAVewh6gNo9DAE0x4EDl/7X1misZq5g4p26fB?=
 =?us-ascii?Q?U9O3PDAqDX25VuOLMVCplaARldiJaeCJvaK9EyAJ11YMR1RGeWqFnItzWPNe?=
 =?us-ascii?Q?vF2HCspwXIWZGWCSe0IdaMFRU8+CHSgLEPWbomgfw4A5kQ6MeclmGKcOU/BH?=
 =?us-ascii?Q?jeYeY+buePHtFPsa1AguXa6t23iWpNibJVN10W23+krNuKSi+fsFu9WpCsnu?=
 =?us-ascii?Q?qiU40vtLaLX+aVk7OKjRMZFtaAX13V4E66rAm1lRs0y9N4f9jrkiVqog1KRd?=
 =?us-ascii?Q?GpvMfOkr6uZuxOmMmzwRPINpUjK0v63zxk3bOxXF4id2d0Q/nxJLq4/hkFcg?=
 =?us-ascii?Q?iII3MGNet36Xy3DJl+25+GKQvGxdrBxY1ifAQ2HcHaO6HCSjjp+nh/xNwDjk?=
 =?us-ascii?Q?TY5GrjebR+sM73xLNn02bAaUnqxoGjwjxGcv2B2A28DO496UPgvSNnfca8G4?=
 =?us-ascii?Q?gZcPfEpasAJCbzyzBCQLxS5UPyG1rm7BLz34Z4XuIpLE7u36Qq3PqBMaLxK9?=
 =?us-ascii?Q?jGkuPzEvMq1GQugwrnXH3b+Wx5ovxiG17kRUphBLjYt07Se9nTV25IGV5tEl?=
 =?us-ascii?Q?RMHPsZZWfC2cAhi3Z3wjv7FArAYQNmO5N7bG8XTlwSOuKg59VrDUDHHacp6c?=
 =?us-ascii?Q?mvZ248dJsM2KWxNRMmAYs60OMpJOgp+SO21BpHjMUh5ZwkrFltR6//2Ai/Ql?=
 =?us-ascii?Q?3nISIxVGIc+0GoBifzS/jJ6mBKqUv8rAdkZIQqZLtQch34WRLYGsheN2A8Kd?=
 =?us-ascii?Q?mfyEexaNVIeShM2PL7p8TV4J6stqQhJCudrTHLfQfpXjCGLXq/rqZbzlLnT1?=
 =?us-ascii?Q?/SuH0mcKNdtmNeIcOR3aAunRt4AQGEEoRktoPwdLF1X7Tb4R+9bv+anoQbck?=
 =?us-ascii?Q?qMar98b/84z9xKIbPl1Um/NZRk2GjB6vkJd58sgL31ovOi2QeoMZUL8nZaYk?=
 =?us-ascii?Q?n4KC6rUHkgAeQhx9OGXTalEE+LmsqS9MKzvha3ExKFPx+uiRyvs/bgqiqyE8?=
 =?us-ascii?Q?X1vA/M0HHGVsnNqJP69c11Wq0ELSElqiXqHzbaTG6aEcEgNo+Koo6lXjy5RI?=
 =?us-ascii?Q?RCLK3QKluiX4m423VPWY5N1vMzDofhUU2JT60r9LUJzxuijW1XRgBbUtqNUc?=
 =?us-ascii?Q?YwJKklG8i9KcEpt8P7ERUuIY7bP3IgF597S8W+2oCV2HcTSdWbs2WBOL3y4E?=
 =?us-ascii?Q?/OYctr4vpQzzhxyNHt1cFJZuJc71amfO+sGHrJOHoWiW8VPOysfIGQyLobsU?=
 =?us-ascii?Q?e/1OfcPBEfZY9CiL8e/K7BoHKOH0eq2c/RcFy17X1FeWa/XOmUDdKz4WVxzz?=
 =?us-ascii?Q?qiJm9RZd5pC/7uyYqh5ItB8PhoWWzFBz8enfatGtcqECPzXygDxcHkAK67s9?=
 =?us-ascii?Q?dDcTP6Enhe/kSF9RRmTLAxqidCo49Z7Iv1HUC63qk37N0+pk2Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1324.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uQV8JQWqmfl6olncSNvxD/0tj/Hlbm/pOiHCLFU4Nqehu2fGFqrDst4pRKP/?=
 =?us-ascii?Q?XSJx29Clka9MA7VdV6T8fXY6s9msx33oNeAdNE+5ZZIbsKkPTkJqQ/+5/d3S?=
 =?us-ascii?Q?/RoBaqAaRq9syw3I2GDLHJf1eQvK5ypEQ//cpK9rAzDxLW5mDKW9RuUJbmW4?=
 =?us-ascii?Q?Ewgy0T7p4IZ+vafTBmWlkVqObZytFcwU2FJ4L0ZoP7jGyPVoV/JVLbkD78Np?=
 =?us-ascii?Q?rhNZGbzZGovOQnZO+5rsN1/EE2R5zzsfZ/Hmt/F3P+wy193g4pOsWrBKAJ1Z?=
 =?us-ascii?Q?HgVp6yLuK6mDT4CGCEn0KalFkfxYUNL/QaMz6jXc0uuc8rIdSl9TbuLzTCI8?=
 =?us-ascii?Q?pZ0dm5ffAmOHPgSqgSnp5iqk6Wpt7TKaKHt2DGO7ZvMuV68wpfVyzKrI4Qyw?=
 =?us-ascii?Q?FyXXAp1u8uLZcFGtUxmbbNsBmglXcut1hR2LBTtK+9YqrP6JjGGd765OCF2M?=
 =?us-ascii?Q?1UYZXjqRz5NQS/a8/lGxZ2kfUCYncM0HYpf9CgrRFw2JmaBXir378gn7sDgG?=
 =?us-ascii?Q?dzc4KZa+NlJSaaV4pz3uWmwfQ/HlVzZZaPdy6SMtYKYqAt9l/DE5/qxDl1xX?=
 =?us-ascii?Q?jWV1qkoeeq/XVfSGGEx7IcqtCs9ItD3levCfDxOj2EyIsQbcpi2P4jQnvnto?=
 =?us-ascii?Q?Dw/Zg/QgyxGVxlZoLteEC9kcZ/XHkDUepUsoogEosoxVqNv/fDH4YwL3Mq1W?=
 =?us-ascii?Q?ntLjLTJGI9fADazSOVECmv7FYnD7UVr6DEmqy9E/J7lhYmWxaDybYmfpnDIN?=
 =?us-ascii?Q?HZtlSLb2qx1yIaY9t/EfnNWgDfWnJkB8hdeIkbzxeYu3Vq3lP3oc0FtGCDZy?=
 =?us-ascii?Q?nAKreLvpVrBiKJuDYhU0ZY97LjC8jgf8ltWrXq28PGsJsrnDLkoKP8LALZ7b?=
 =?us-ascii?Q?WnGVQr+cDVc2P396DS4Gz8kn2Jj/dOj0H1gvcYYcEBj85fExL+VS9bB3OjOx?=
 =?us-ascii?Q?pgoh/YBq/niQb8t2s5PLYFSPKE3/6dsAvx7RxzI0jug0SuWSCDxS5vA3o8Fa?=
 =?us-ascii?Q?oLlT4ldtX2OjQ7lMWRZCwdfZkr7KHvJnkWwWEIttfDsMDDU2i8QSpv6oDIov?=
 =?us-ascii?Q?vmjxzxt8DUW69Ea7PS3c1i4XhSwJ3r2aKIgDuWUlqFxjOzfJYkhKeP9wBY8N?=
 =?us-ascii?Q?fvOaXzpJsy91AeGiYSZq69DdNisLllL1kEkylA5Jg8smKQKcG+hXtnZP4rqi?=
 =?us-ascii?Q?hHO8c3vO5sPOs+eHDbZ/tBhUIUyp3VX6XPd1m1SKCUKdqWh2uBveRNhvjEOk?=
 =?us-ascii?Q?OxUtj/AWGsht20jkk8oj6SQ3jaexaz8K41U9YFStQsOcVqtESRb+hX7V0HnZ?=
 =?us-ascii?Q?eT7Sswikr1d1icj239ayUd7yVukngQ6Vt6ESnY/3jzeMbOfW0z6pi+vaj9GR?=
 =?us-ascii?Q?ZoVTqGdnhD+ScFKzhoN48iDaRZC9hZtxyMOILLqaPIUWWXjXU78SiE2bGuKQ?=
 =?us-ascii?Q?g/N9+X+A4JRr/IdZ2sQRLmgvW0+HZFklJ3CLPf7t4xOFZkVIlAsrIxv9QKB4?=
 =?us-ascii?Q?O/2GUq1/fgBBEM3yB10rKy6UbKaeKdHqSOMMRT8OBJ4CGg9Fwnh0c049sBgn?=
 =?us-ascii?Q?xVY7w8yZCrnmlBE88VKA1SXZNXR2CS/Y2twlrFTZN7V4EljZdssUYnsrAwaX?=
 =?us-ascii?Q?0jmwufu3S/PWmpM5wejdllaV78HP+RjS8KD/Jr1flUIG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1324.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1564dd-4d89-486e-c2a0-08dcced76d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 00:53:02.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkQmHmRD5agwU7WfBLCltzjgHLbBRUnnclzhggzM5Tc1eDG8j7TkxWOgYW+rGOTwyVNp55cNSgd2/11xCHGspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3043

> From: Zhu Jun <zhujun2@cmss.chinamobile.com>
> Sent: Friday, September 6, 2024 2:14 AM

Reviewed-by: Dexuan Cui <decui@microsoft.com>

