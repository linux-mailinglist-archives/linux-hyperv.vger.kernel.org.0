Return-Path: <linux-hyperv+bounces-10845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN8qNJbFBGrdNwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10845-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:40:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FECD53920F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32BD312BBF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A4355F5F;
	Wed, 13 May 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DyerB9D6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020125.outbound.protection.outlook.com [52.101.193.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D23A48F0;
	Wed, 13 May 2026 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697030; cv=fail; b=GzIzK9hQvVdDQrE8LQde2o+kTMEgJ5P1BV4xcVTzq/CQBGKQnkvba8gUXg8dFvnDeXdLMzqCgWVXstuFSP7CVLDAZhZN5Qzjp9A6H0Igwkltv8wyRzeaQx2DUVtk1MBPPiLcLw4VwoPE1AZxvUObeKOIODM6dqvFixcmEw26ZJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697030; c=relaxed/simple;
	bh=otOUc8Zb8Mi9axtxj83hZtN2J4qiubsHTzPJLev877I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/i0AbZ/PqUnDbz+q23iZ/FyOqfE/amcdvjVXI00l3HAyAZlfk9xEGwHHZ/ZoPiPQioFog9KOxbjROrsGZ3y3FZ9A2w6vyQ9xc+/ixEBlECuhapZleowW9aAvLtzuyNoWxxxPxYlICwYMjPwdN9AVqc+1EkFJgjcI5msGK/s6iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DyerB9D6; arc=fail smtp.client-ip=52.101.193.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSY0gR49QeRcSOYXUa+4NsmJzKlO+CTNhCWa34xhpdYBRLpoc7tjfydrxR34Fh5H69/Ayy2CFr1yo34NzfhymcBPvLfLwxI6rY2bEbjPLB5AR03HNhKqPwvMwv/kGLsG4GEtzDp7a/jKfxsZM1vIgI2D6lSrdJvQID/ksCBK86Iqq+jgB70GZOgx90DiitorvsjeUkVnSpaEvrrG3WkpxQLTyNqfDWKyjMij89+YrlUIp3+eMkaaPoVKlZ7g5wsjpMRPhwtYkEXHIZYtCSrhNZcD9mfsfKhw2dcw/1mHFA3PiIa39gfSkToz8Lgaf1z2w1M7zin9NbUpjU2Ciaa0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ulj9K6DnfWLEEtGz185VrhguuTpFktUo9//Hofrp6M=;
 b=JSzMFqsSSg+/MKC+uGdQHxD7ahR094mDnYsmUF3EArD7XpVZ5z52HWNSNuC42w3xbYZvzStQk99pBFc08lUER5Gt1TFDU7/0kGcDxrdKuczbSNpD3JOAMAxunTFKFkeDNPYc5ndXBOoNulXaFHBPrSAnvQ5F7hp99pFsFi6uMY+zy11s192jG2bjU307Rsip8HMYWUSViJYonY9odkd6SaKrK30osOvkzI7M5i3b1yTenFq4JWM6fOBZY3HQks/GeM/gzBpj//h9MdywdY3ivSvi3YlNjV7VXfhfaoOwYcG5AUBTFf2hYg9/J4FcuOAl1Mo81+nyS9wejnxpBohgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ulj9K6DnfWLEEtGz185VrhguuTpFktUo9//Hofrp6M=;
 b=DyerB9D6DuLaNqCiVsKf7aCreye+wjU9nSKf+GjkenE8GUj+2Em6Mge/gm4Qvo+3BBEjsm+zlmWcyPzzuDeyx6LsBN7HPtD1T3SE0m8fDQD6B8ESUrFm74oaJ59yGIDS/0Ip1rhTkVkbhQRGY+JHuJ4oZskC57jfBEXVqPkLC5Y=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5744.namprd21.prod.outlook.com (2603:10b6:806:499::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.4; Wed, 13 May 2026
 18:30:26 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Wed, 13 May 2026
 18:30:26 +0000
From: Long Li <longli@microsoft.com>
To: Tianyu Lan <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, Allen Pais <apais@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "vdso@hexbites.dev" <vdso@hexbites.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>
Subject: RE: [EXTERNAL] [PATCH] x86/VMBus: Confidential VMBus for dynamic DMA
 transfers
Thread-Topic: [EXTERNAL] [PATCH] x86/VMBus: Confidential VMBus for dynamic DMA
 transfers
Thread-Index: AQHcxymwZ5mHLuYf1kmcwCM6M0ty37YMfFug
Date: Wed, 13 May 2026 18:30:25 +0000
Message-ID:
 <SA1PR21MB6683C18151A933242F826BCDCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260408073105.272255-1-tiala@microsoft.com>
In-Reply-To: <20260408073105.272255-1-tiala@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=10059987-fd20-4a3f-91a9-83aaab7ccba5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-13T18:21:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5744:EE_
x-ms-office365-filtering-correlation-id: 66e60cd0-f68b-400a-27d7-08deb11db3a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|11063799003|38070700021|56012099003|4133799003;
x-microsoft-antispam-message-info:
 UxiQd1w13ig6GjFwShmbQBFD/48uSNGvZJDx2bt+P8imx8c1S+s6IuzxuGjYgDhOzNeGuc+du8BrzAmToaRFnFvoy62XAJ9o5GDCEB4BPhJ4j0IoYlP8x57WEq/imfbfTPt8mjVf5pw4CMBhj6ygnVc6sJvR0bgOEjAmMxJWjm1levz9Qj5zoCIsK2mh+sJ9it7X79zELdqrhyQV1cBFJ5D7By0nyhkt6I5/IaBRdFZsykYDU0wdvHCB746ns8GBQaB0M+jMnZlde5HG5kYA5jW+CAMEC1tKa3HZovwJ2YoviFPK1KePSzXGuW/ABpUafj/Lz1v+YwfS06J5As3FLM8nCutc3w1KqrwRpgodsyoxQqkROSFkDDjoGipIw7QPXu6OqJfp0bjy+S+rrn+r6fs8+dyis1csl3uGzoXRSQSIu/41mgOuBMMuXvNYRSRxnOB+/a/BJyJdBN/frHcyipawgPY/wkVAP60VZrLiKPQkOf7AlIuKTW9kvVbcYXlCgZOtwBSPJc5flXXRd2BIyw97KABUKODsAlLBjJG4xrgGgNeM5i0u3AcGQJglKNEOOpwuiiFxZw+QrOPef1b9+vJPrkZQzgRHrZeHic6KDJyk9iPJC+30ONT7GoaqVf5Ap6+HPrUuqSl/FaR02ebf6STjhIfXjgP5dfbX7Oo20oLXQ0IU7r9JSmL5+Lf+hQMWn/N8jfMgairE/fFjEw6U0zjaLUD6hPZGMuzArlFiS3hJEBfjPJGtLIHTzT4nKXq6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799003)(38070700021)(56012099003)(4133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xCVEcD5IdTNFn3Y1dgDJNB3fe32vddLidw/QF1H1Dwxk1Aq37yk/6f9aLADI?=
 =?us-ascii?Q?vveWCIgjYuXRvXilK/bDwBaOqxwgtNcWzlGCCKNTa7udcjQeji+5OxcJClva?=
 =?us-ascii?Q?tvqX/Xvg30KN3iYkYzE7ToO9HT1jf9dDkkIhgcidZkgy8DsA4H0aC1jOKV9i?=
 =?us-ascii?Q?yjLOUQEywmq22FTQRMIH/m6Us39ozO5SapPMETqqZ0g/tIdr2XTQH3zRiCi9?=
 =?us-ascii?Q?X072NqBZAV+FGUmI82BC7gReJWe4cqmWUSuk50ZyZSY+kCQN+vZLDHf4nu3K?=
 =?us-ascii?Q?vXuMJVyoQCdCowkbvkjNKorrAdgRaztcrX0oKpyjNi7uXnZ1DPTr9mnp7Sza?=
 =?us-ascii?Q?Rg+TafVCy02A4uGq/fO40vNSXEAUEZGXK1TyIdh/5GvaWmfqLGL6mBcUhPSa?=
 =?us-ascii?Q?JnmeC+5vl5aG7mj/hDd7ibwLInorgwudKEckeAbq8KP4p9At5rrYdT9+iZux?=
 =?us-ascii?Q?u+cOfFYPbeeE5u4mzW4S/Iu9yiUFU3ZGlLl8IfbGkME4gunhTFzER1nDbKdz?=
 =?us-ascii?Q?bD/CPWjGqeUn/xFnZ9VCmgUVfpgCIfa/N3hTzqCv/+iSMeZAYwtWAhdWm3Uj?=
 =?us-ascii?Q?G0MQA7W5R53K1zoALZYtn13prUUYU/L2zAXZQFghiKFl3Gz8DUr6zFfwWSGf?=
 =?us-ascii?Q?xny5p6FXTj/BhZYnT4GrUA9nyexaGn179T2m/F1f04cuG6/UKLtOcqoIptkL?=
 =?us-ascii?Q?oWBihiKvnZ40iVBrD0pfViZsoqpyzIQdDY8EVNzaSToXp8VVuDDxc0t+IFEk?=
 =?us-ascii?Q?ez7yHzTAOaU7DnjW4axNHKSeQwbTVW5YPNJVdBvRxrSx3lVqXDSPuGrochHs?=
 =?us-ascii?Q?QAb3xlMr5pwoGVcoBxbr0O0+omfDTX9xWs7BM0ccJF0YMV8b/PIjEac+7VnR?=
 =?us-ascii?Q?OLlyEJ7IaRyoOww9ylDFMguj/8um8nbQVciFWid0P8UB+l25PAJFKvo+Rs6H?=
 =?us-ascii?Q?4grs8F+wyu7wmMXDuJKI+/DnJCfDVpkfY8tbfUMGKFlsLWDJ3vR5h0rKmaU2?=
 =?us-ascii?Q?P2nPHMFGD6Brrm+bQ1qP6cFsbXVECZJS2psnyQ5VRL8tsKfvbFQvCDVtomur?=
 =?us-ascii?Q?51vUcOa2Cf5z7T/NwdST3nNntGc5vx/lUidQrC0FauvFgKjrmPDFnOwCtriq?=
 =?us-ascii?Q?IDVdoc2+ug2CDknX34pK+OkAacJQ/PB8usXB3hADRiEbMTOt/LD2eNDShaLo?=
 =?us-ascii?Q?X7CkFHvYAvF9b6ObSz/Tgp8psHC+jMQ/hYIHh0BcbtS4suXKP1hFSm5Nwgbc?=
 =?us-ascii?Q?3jwRZFrelt2K1eilydAVXm+eYaX7DkdlGhwkFfOVRrdpoUTt6mDVGZkbUWeB?=
 =?us-ascii?Q?jLrtZMCrVHQ4cseaMw30A75/E63JqpVXzeCqAiaOIQ6FTQ1gdvFVMUvx/tcF?=
 =?us-ascii?Q?zp8MvUkrfroS/VVAZARvetUcmQRy8+hkZTFXVIjRilWAQSrJ8lYZZIioh++B?=
 =?us-ascii?Q?RG3/SPv4G+6wdLa2DW8S8vATBpvC7fVvWlYnaz6tmsruNUQDGVtEjuwLuw2w?=
 =?us-ascii?Q?fpxESCdTzL9DIPrz3swjG8vDU9l4P99yemebxCSFDD/qp87tQ6+GhaNOHYE6?=
 =?us-ascii?Q?E55jjNy2j7D8zVC798dRAmaXCqMy1oYdVdh36l44fs/1OYN4GvKwGkKu7cvo?=
 =?us-ascii?Q?C3YTZqaQjqGtOcsRF4Xa3W1DTo2K/lqiuuiG6XzjC9cUJUNwXtbYXCiKdotj?=
 =?us-ascii?Q?/3VpyqVCA89jU3F7Jr7rFpDr9S3YaxgivWdpfQdM0CuXX1Ez?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e60cd0-f68b-400a-27d7-08deb11db3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 18:30:25.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyM2CcQtBsgRGOwoMHzzVQxz9+uGLBy5+VTaHnli2qlQpG/J5lsRpD3ghB5C4oJs9dpW0s/gw0xoOTyd/K+kYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5744
X-Rspamd-Queue-Id: 2FECD53920F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10845-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org,HansenPartnership.com,oracle.com];
	FREEMAIL_CC(0.00)[microsoft.com,vger.kernel.org,hexbites.dev,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:url,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Action: no action

> Hyper-V provides Confidential VMBus to communicate between device model
> and device guest driver via encrypted/private memory in Confidential VM. =
The
> device model is in OpenHCL
> (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fopen=
vm
> m.dev%2Fguide%2Fuser_guide%2Fopenhcl.html&data=3D05%7C02%7Clongli%40mi
> crosoft.com%7C0ccfea7cda8e4500ae9808de9540d01e%7C72f988bf86f141af91a
> b2d7cd011db47%7C1%7C0%7C639112302777934798%7CUnknown%7CTWFpbG
> Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIk
> FOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5Uc%2FM4ZVgJT1
> NAq08cIlNtfF5oW4n%2FTj%2Bqg3YqBUeZg%3D&reserved=3D0) that plays the
> paravisor role.
>=20
> For a VMBus device, there are two communication methods to talk with
> Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic DMA transfer.
>=20
> The Confidential VMBus Ring buffer has been upstreamed by Roman Kisel(com=
mit
> 6802d8af47d1).
>=20
> The dynamic DMA transition of VMBus device normally goes through DMA core
> and it uses SWIOTLB as bounce buffer in a CoCo VM.
>=20
> The Confidential VMBus device can do DMA directly to private/encrypted
> memory. Because the swiotlb is decrypted memory, the DMA transfer must no=
t
> be bounced through the swiotlb, so as to preserve confidentiality. This i=
s different
> from the default for Linux CoCo VMs, so not use DMA(SWIOTLB) API in VMBus
> driver when confidential dynamic DMA transfers capability is present.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 28 +++++++++++++++++++++-------
>  include/linux/hyperv.h     |  1 +
>  2 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> ae1abab97835..79b7611518b7 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1316,7 +1316,8 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  					continue;
>  				}
>  				request =3D (struct storvsc_cmd_request
> *)scsi_cmd_priv(scmnd);
> -				scsi_dma_unmap(scmnd);
> +				if (!device->co_external_memory)
> +					scsi_dma_unmap(scmnd);
>  			}
>=20
>  			storvsc_on_receive(stor_device, packet, request); @@ -
> 1339,6 +1340,8 @@ static int storvsc_connect_to_vsp(struct hv_device *dev=
ice,
> u32 ring_size,
>=20
>  	device->channel->max_pkt_size =3D STORVSC_MAX_PKT_SIZE;
>  	device->channel->next_request_id_callback =3D storvsc_next_request_id;
> +	if (device->channel->co_external_memory)
> +		device->co_external_memory =3D true;
>=20
>  	ret =3D vmbus_open(device->channel,
>  			 ring_size,
> @@ -1805,7 +1808,7 @@ static enum scsi_qc_status
> storvsc_queuecommand(struct Scsi_Host *host,
>  		unsigned long offset_in_hvpg =3D offset_in_hvpage(sgl->offset);
>  		unsigned int hvpg_count =3D HVPFN_UP(offset_in_hvpg + length);
>  		struct scatterlist *sg;
> -		unsigned long hvpfn, hvpfns_to_add;
> +		unsigned long hvpfn, hvpfns_to_add, hvpgoff;
>  		int j, i =3D 0, sg_count;
>=20
>  		payload_sz =3D (hvpg_count * sizeof(u64) + @@ -1821,7 +1824,11
> @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host=
,
>  		payload->range.len =3D length;
>  		payload->range.offset =3D offset_in_hvpg;
>=20
> -		sg_count =3D scsi_dma_map(scmnd);
> +		if (dev->co_external_memory)
> +			sg_count =3D scsi_sg_count(scmnd);

scsi_sg_count() returns unsigned int, sg_count can't be negative. The check=
 for sg_count < 0 below becomes dead code. Add a comment to say this is exp=
ected behavior.

> +		else
> +			sg_count =3D scsi_dma_map(scmnd);
> +
>  		if (sg_count < 0) {
>  			ret =3D SCSI_MLQUEUE_DEVICE_BUSY;
>  			goto err_free_payload;
> @@ -1836,9 +1843,16 @@ static enum scsi_qc_status
> storvsc_queuecommand(struct Scsi_Host *host,
>  			 * Such offsets are handled even on other than the first
>  			 * sgl entry, provided they are a multiple of PAGE_SIZE.
>  			 */
> -			hvpfn =3D HVPFN_DOWN(sg_dma_address(sg));
> -			hvpfns_to_add =3D HVPFN_UP(sg_dma_address(sg) +
> -						 sg_dma_len(sg)) - hvpfn;
> +			if (dev->co_external_memory) {
> +				hvpgoff =3D HVPFN_DOWN(sg->offset);
> +				hvpfn =3D page_to_hvpfn(sg_page(sg)) + hvpgoff;
> +				hvpfns_to_add =3D	HVPFN_UP(sg->offset
> + sg->length) -
> +							hvpgoff;
> +			} else {
> +				hvpfn =3D HVPFN_DOWN(sg_dma_address(sg));
> +				hvpfns_to_add =3D
> HVPFN_UP(sg_dma_address(sg) +
> +							 sg_dma_len(sg)) -
> hvpfn;
> +			}
>=20
>  			/*
>  			 * Fill the next portion of the PFN array with @@ -1860,7
> +1874,7 @@ static enum scsi_qc_status storvsc_queuecommand(struct
> Scsi_Host *host,
>  	ret =3D storvsc_do_io(dev, cmd_request, smp_processor_id());
>  	migrate_enable();
>=20
> -	if (ret)
> +	if (ret && (!dev->co_external_memory))
>  		scsi_dma_unmap(scmnd);
>=20
>  	if (ret =3D=3D -EAGAIN) {
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> dfc516c1c719..bcb143766d6e 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1285,6 +1285,7 @@ struct hv_device {
>=20
>  	/* place holder to keep track of the dir for hv device in debugfs */
>  	struct dentry *debug_dir;
> +	bool co_external_memory;

You don't need to introduce co_external_memory in hv_device, vmbus_channel =
already has co_external_memory. Is it possible that you can check the vmbus=
_channel->co_external_memory directly? If you can remove this,  you can rew=
ord this patch to " scsi: storvsc: Confidential VMBus for dynamic DMA trans=
fers".

Thanks,
Long



