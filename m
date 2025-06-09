Return-Path: <linux-hyperv+bounces-5814-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD272AD24FF
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 19:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CE216E335
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60102185B1;
	Mon,  9 Jun 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iCGb8LwG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020117.outbound.protection.outlook.com [52.101.61.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7361DB12E;
	Mon,  9 Jun 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490419; cv=fail; b=gYAAFv1HJh+3s8G2mBLBBC9tOwEDVKVZsPFqfbLkWaMpMQFQaC7vph/xkIEat4MuSAkQoC+RNYQdXj3nJdaylucyxdjsoGLBMlcqLU3oSbNykEyCVURKIWW0lHUkKy/t44/aJlwfKBoQMph2r3PjyETGuAtw9UC/VAQedvvI4Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490419; c=relaxed/simple;
	bh=+huekAqsPl6ZnHbINOtbHqGWOyM1XB8XUkRc7to+KjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ViIyviObwgewnCfvc5pYFbcawFW6ff5jjIL5GACy/3Q6G4jqKOSHlZ2g51zC2ySDai9LYn/M1cv4Wmq7MO4406h6+OAiMoC+n6IZK7lxjs1q/rOq2MCmRtxKWPqHTMxuY38jolUOmEkZlUI9esOQwOgxpitW/97yyCJ4oM5xnJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iCGb8LwG; arc=fail smtp.client-ip=52.101.61.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isYST8hRFmPAtR5IITbHysUziQnfvCg263nICTtSvcpIJN0kd7+Uoc60moxpbTdox7ZZalRzK4QEhta+by+1nlYNVS+51aB3RgTuhDrSqSQytKeD9jgqvEgt/wJmZt+YxuwTAI2F+e5noSLZ7B/N5U6ztU9GgjScqG/GMkxHZEQqiOpm6dRTHuIXz27Q+XIfWsKyC6zKMeAm582VGwZ1VOSL2f7sx1z6KyGM/T3VrIjw6N3dLZdf81IR8aoyyIcr85GQ0IBAndTSVXk6LPPyd67lz+qw+z0mZn2vrj02R4aI6ZPpWyXvbba67jLHdGp9usU3O2lGADpwqBUH4mmF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+uVzLCGjq4bejQrLD0K3594i4IQ+BzOjEwG596AGlU=;
 b=X+tgY2eJZQgP1aErY5izq8enQU2iFKxI7M0NhFjE/OFXvXbwZyHe3ST8DNrYY0kFvwMIxU4GF0napabvxYcDtKJ+vVSK5qsaSbm9EPuGbNmnsG1pZ89/SzIb4uRlRprMnpj2PNq0yZm1gaofREboT39j0xK3deZ3S1DREDIx1FnfW8hVk6dO661RElzL4QI0CW5kZvOrBtX1WNzOI/jGJWnbu3z9wSgApQPNtN5G4yJf4hm7PSXqyoY/IUR+NaRPnPXlAFq6GDmraFI1gfHJSKTqLPDJfikWJjCrjVmQ2u/74BNAKruClT2etPMGHvCyaqVZ3vbvWxdJ4Oui8MIGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+uVzLCGjq4bejQrLD0K3594i4IQ+BzOjEwG596AGlU=;
 b=iCGb8LwGHKtdsNkFML1KIhfWvDUFbedce2p5WEwBZf7rx42zMBgGmMEL6WoeFq70UPvFIsrDQqr7H2KQ4gpROFdWuho09AjxZ/7YBMSFCknoPekJn4iZtLVbjfJERoehuNBB3vgx7jcWTePNn47C5bKBIXVGE50b4TJho8dJly0=
Received: from LV2PR21MB3300.namprd21.prod.outlook.com (2603:10b6:408:172::18)
 by LV3PR21MB4163.namprd21.prod.outlook.com (2603:10b6:408:275::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.14; Mon, 9 Jun
 2025 17:33:29 +0000
Received: from LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380]) by LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380%3]) with mapi id 15.20.8835.006; Mon, 9 Jun 2025
 17:33:28 +0000
From: Long Li <longli@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>
CC: Dexuan Cui <decui@microsoft.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Increase the timeouts to storvsc_timeout
Thread-Topic: [PATCH] scsi: storvsc: Increase the timeouts to storvsc_timeout
Thread-Index: AQHb1yWrGpavb0K/k0iYW7d2jXPMCLP7Go5A
Date: Mon, 9 Jun 2025 17:33:28 +0000
Message-ID:
 <LV2PR21MB3300D46E256FA430C67F19ADCE6BA@LV2PR21MB3300.namprd21.prod.outlook.com>
References: <1749243459-10419-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1749243459-10419-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=422ddaf8-90ba-4cb6-8ac6-96f8a912c688;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-09T17:32:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3300:EE_|LV3PR21MB4163:EE_
x-ms-office365-filtering-correlation-id: 06b71517-3b4d-4aa4-6372-08dda77bbf17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aKHLnOSwD/9lPnk85MHizWPUCArdudmLkogIJJPajX/JT9lm2kcSwMyRmOWL?=
 =?us-ascii?Q?gUFr/T3IrCVzQ+k6ZT+7Zv97/H0IyuXJrLEYBn0Fla2ljXdLmaGwWc9HVF/E?=
 =?us-ascii?Q?TLV3ak65Pqc4XY3t1pzPsLQZnYTi5V4Z1oIBvAGDvwpIdO0/dnkwE9fR2t3Q?=
 =?us-ascii?Q?/1weMXXkDk3rrrQ8pdqN6VvHYyPAmSMkHMoQFcOag/YLhIHHQ4vnlaXSDYbK?=
 =?us-ascii?Q?oCbhGiNElAqiNEC01hyNJwLFH36PACtvPcsS8hKhqTe1tz1MYvHFVhOVSzp9?=
 =?us-ascii?Q?TNWu8ilhJCUHKNkVFOmsxnVQB9hM7Z5uTa4uFyDe81ThooGhi8OwRqyfN59y?=
 =?us-ascii?Q?UkzE7zuOyeT1Jv3XivhwqekbXutC6xq1LpKbzazaqukfkR2XNt592B54A5Cz?=
 =?us-ascii?Q?8yEP+Coz/e+0g8Cr1yXyQQJEx5aIH63RY5M+It9VAISuE4iHpN+xax2Mj2sy?=
 =?us-ascii?Q?KXQ3yRBi5n/ybdto9IB+V9Q+tPPzbA+vrCibTaf/98psxCexCkCnIRsXZh14?=
 =?us-ascii?Q?k3ZnBIMB8d9XHBguF6K9eZpzEzgPDCFoMSTud/gS3Gla9+nwp0hgsT7KOf61?=
 =?us-ascii?Q?JY9s7w2tinghx0PYyxWkInvnFebtWakTOkoghfvWHbFS53sMRxCGNRb+NxA7?=
 =?us-ascii?Q?443SjGfsJPVXaN/1CPey7wzGCodV6r1ShMFo67ydbcL+My9douZEhJkDPrDy?=
 =?us-ascii?Q?97mh55PVydHFex6TphwdbnWIfU5AUrECW9H1y9XtTRnlCFlnxZtY5+1cJC0o?=
 =?us-ascii?Q?ji6XEUYi+hDzR7m3kxIuBcU/FIuRWB6NSvehwqCQzNfnk99fBMUO9AIrmwcK?=
 =?us-ascii?Q?gjdQsWsVnf4INZDA411ewCkbhF03Kg565GMIpA1MGNynf6yXS2P8xG+pICF5?=
 =?us-ascii?Q?BW9qgd3FoVgKVdObllnuzyZU9U0s8M6qKfJzcFfeob+caQDwfy6fBKzbbm1X?=
 =?us-ascii?Q?NYuOH+gK0hzN1SIOrendmuC8ibMlXauI3/mQKMntCx7kaQb5xEy04AzXus76?=
 =?us-ascii?Q?2ZS5SUccneKu9S0V/qSLcyUKEE2v1gcA9tT1h/81sRs/SFPdblQJvhBt3Q51?=
 =?us-ascii?Q?zs7HTsf5VlxDLn4QZVGLY3DIOg+mmb8DiTd8ynPiT1+aoJoYjZfN7/jzWdzu?=
 =?us-ascii?Q?HC15yiWfrGc3NATeTtw07YlyEdASjKaxVUIlgnzJ2v41rTqlzczMRciTyGNO?=
 =?us-ascii?Q?KtF+/QpE4t5T9EFPCYMqQakEl1/VBCUyiue4s8WVL6LmoDb7r8NcJ5tROsAx?=
 =?us-ascii?Q?icLLRSm0+ciJtYtwHUYJUADAcycHF+xGguYIREIkz/KK0pj4pXZuwbk1MVrg?=
 =?us-ascii?Q?OBgTezsKnLfsdCZJQiXim/DyS+wZsTlHn40wLbRmW7sE/PkZNNAejxg+LOca?=
 =?us-ascii?Q?DpaCLO4l+jGMuQoxTsoiNXee7O9wEvDxf2GQ5JLIFMxgGeG0zHcWppIVLl5m?=
 =?us-ascii?Q?zfItnYEC1mLDvsZsCJ+TB7RjTMHOgOX16Go/P9+8Xkn8wJ3YTgpEMQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3300.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2MCyj/RHBBOgDlWswaw4f88nSBdcaj4FXta5EdEZaLGX5h5oO9/W9Y2Hzbld?=
 =?us-ascii?Q?NiDACkgUmo+2+VFfffzouppCLwtzk1LjvNl04+e6qlrD1+iRn/U9x5UUB/K9?=
 =?us-ascii?Q?V7/4CnK6SftHD2hZCFfJ8pQEp2QyB0h455dvkueFepw8zLCEFf7PAVIsSS2f?=
 =?us-ascii?Q?LHxbpqfXMjUGrLCvNzErff3s9ReMfQatiAf8rmqwbUItEYtO1V0bKEtWCyRA?=
 =?us-ascii?Q?hCyEYjIwYytuHQgRm/oMrRau2tJs9YZU0SUawHjJxI9J3OwvOfcThrnzqVYF?=
 =?us-ascii?Q?N1pd84vzlu8ip1yYpxAsvKf0U5hNNbbBPxQakUyZPoc7Hhicup/zLwb3et1N?=
 =?us-ascii?Q?/kmFIaVCwWxe4QbBC4oWlaSNrVULYJhcbL8UWRwTXqPXlJ5NvvGfHMBRc/Uq?=
 =?us-ascii?Q?ydSLm9pclM/pPgO3ThZbVEWDE0OYhpTFHP+ai6BLy1PGuseowDoB+ajWQOFX?=
 =?us-ascii?Q?F/Q06paNZKDZYe7YCXygqarO4/iV03CnlCcqDIRGATqhCOddoemoKIKArBVu?=
 =?us-ascii?Q?m4aMkoiXfLot0cIZlUGjaTZZPvoyPAAjOUG49w7y0EQtbNhSgjOxUlmaeo4b?=
 =?us-ascii?Q?bVuXOtKk/7tje+5iU4NDnoRuCls0vNEVf1zy2Pm5a59zCjwY04gohij7Wbmm?=
 =?us-ascii?Q?ZFDfANMmcqT396eYuiTlbBTTuQS5UCH5PA6aiHHt4gYEl7tU7jFuCBeGoyUM?=
 =?us-ascii?Q?y11X79NDO65zHXWZOQZHYKOGAPg4c+5N4zJz/gzPRKNd9kY2/Qk2IycCWnkC?=
 =?us-ascii?Q?YjhVHeBOK8Smr33VCsaxqJ0zVl0g2ALh3gPS6L8Xh2v4LOreZMqbdBRF7ixb?=
 =?us-ascii?Q?OATHGqaZj0+/tPb5hkx4uVcfhv8Jt9b6EIdKji/0V9kxliBz+q15Fv8s2M6R?=
 =?us-ascii?Q?QtsHyLlJlmabz537i+k1oENhq3JYuwhrGJ0/SMEtLwQO2oJkYBUtXPhOUL5n?=
 =?us-ascii?Q?NHp9Nr/VA/1BfP1tARE21XZQTbMYYI0JZc9KKKv3lplIdkgtjWqEENhkYyC2?=
 =?us-ascii?Q?79H3BwOEIECl3tCJFURUvF8zuxlq6QttD3elgavj92sE+wl0oXXXbFh2Nx/i?=
 =?us-ascii?Q?RlNboXulBiRqoUStIU4s4TAb8bhkJkYZxQcaoIYoTljNZhtoPjf71Ore46XV?=
 =?us-ascii?Q?T2GEfwS4MS61QxhcReRHigC910/gpw7APlF6p5bDy6POMTvaqQGk7dBDFPTh?=
 =?us-ascii?Q?1lBe9X5+i+dND+6A7s/GfcerooYOKGoUOQZ4ipWAyTfKcNZzK6AF3Vc81Ixa?=
 =?us-ascii?Q?+7mULb+olmxxwzYlxAXD8kVLiFxhvofF8kocQii4JyvZc5wyrcuWsoJVZSyr?=
 =?us-ascii?Q?FGbOgPfYJEEWLIJ2aRGMIrfwNPQeozwc9NqH+XCZUwP9H3zk76pz9txC1BG5?=
 =?us-ascii?Q?1GU5L4ZE/WrzSLwJ6bIr8X7N5sHnlJL7ICSDjF7ZRd93boPdeVz2m6lYY+9J?=
 =?us-ascii?Q?80oUm97ehBzDMw+4UCPoZQlMLllIGZujXCfktKuArEND5unS3TzMc8SK2J/W?=
 =?us-ascii?Q?mbI6jdrEgj6Ble5/5BXsW033u8jDtpswnKdX5eSqCHKE+gSOE45LQbmh8Rnf?=
 =?us-ascii?Q?3CqZFHrO7lOrhvV+jnCiT/Mq6T+Xc9aBkxwPg0DG?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3300.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b71517-3b4d-4aa4-6372-08dda77bbf17
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 17:33:28.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blzqgpjOEMsNBidFJ0iHEe7YqAXI8BgEZxRAz6wCyYO7CYQcim1JcOjkR+e6ekwbxh9SnGq3i7/tehNVe9d6Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR21MB4163

> Subject: [PATCH] scsi: storvsc: Increase the timeouts to storvsc_timeout
>=20
> Currently storvsc_timeout is only used in storvsc_sdev_configure(), and 5=
s and
> 10s are used elsewhere. It turns out that rarely the 5s is not enough on =
Azure, so
> let's use storvsc_timeout everywhere.
>=20
> In case a timeout happens and storvsc_channel_init() returns an error, cl=
ose the
> VMBus channel so that any host-to-guest messages in the channel's ringbuf=
fer,
> which might come late, can be safely ignored.
>=20
> Add a "const" to storvsc_timeout.
>=20
> Cc: stable@kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/scsi/storvsc_drv.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> 2e6b2412d2c9..d9e59204a9c3 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -362,7 +362,7 @@ MODULE_PARM_DESC(ring_avail_percent_lowater,
>  /*
>   * Timeout in seconds for all devices managed by this driver.
>   */
> -static int storvsc_timeout =3D 180;
> +static const int storvsc_timeout =3D 180;
>=20
>  #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
>  static struct scsi_transport_template *fc_transport_template; @@ -768,7
> +768,7 @@ static void  handle_multichannel_storage(struct hv_device *devi=
ce,
> int max_chns)
>  		return;
>  	}
>=20
> -	t =3D wait_for_completion_timeout(&request->wait_event, 10*HZ);
> +	t =3D wait_for_completion_timeout(&request->wait_event,
> storvsc_timeout
> +* HZ);
>  	if (t =3D=3D 0) {
>  		dev_err(dev, "Failed to create sub-channel: timed out\n");
>  		return;
> @@ -833,7 +833,7 @@ static int storvsc_execute_vstor_op(struct hv_device
> *device,
>  	if (ret !=3D 0)
>  		return ret;
>=20
> -	t =3D wait_for_completion_timeout(&request->wait_event, 5*HZ);
> +	t =3D wait_for_completion_timeout(&request->wait_event,
> storvsc_timeout
> +* HZ);
>  	if (t =3D=3D 0)
>  		return -ETIMEDOUT;
>=20
> @@ -1350,6 +1350,8 @@ static int storvsc_connect_to_vsp(struct hv_device
> *device, u32 ring_size,
>  		return ret;
>=20
>  	ret =3D storvsc_channel_init(device, is_fc);
> +	if (ret)
> +		vmbus_close(device->channel);
>=20
>  	return ret;
>  }
> @@ -1668,7 +1670,7 @@ static int storvsc_host_reset_handler(struct scsi_c=
mnd
> *scmnd)
>  	if (ret !=3D 0)
>  		return FAILED;
>=20
> -	t =3D wait_for_completion_timeout(&request->wait_event, 5*HZ);
> +	t =3D wait_for_completion_timeout(&request->wait_event,
> storvsc_timeout
> +* HZ);
>  	if (t =3D=3D 0)
>  		return TIMEOUT_ERROR;
>=20
> --
> 2.25.1


