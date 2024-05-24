Return-Path: <linux-hyperv+bounces-2212-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890AC8CE246
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 May 2024 10:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD028305D
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 May 2024 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018682D6C;
	Fri, 24 May 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mj1pR8fn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36203381B8;
	Fri, 24 May 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538959; cv=fail; b=E5SiV7qFfm+lc+Mnwr+yNhxjFfbqtuHn2GLdHfnaYvRdi2yuvfMnqMe0Bgiv0tBNulLiGgSAmBsdhzgGMwmQXUu3QVPMNS0Il/TqHUA04RHmKYdjuFluUHYYNOEgk5r+c50sGFbeV/7cdCsd6cXa7b3GfSul1+WIyPbv61m3OJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538959; c=relaxed/simple;
	bh=OccS24XZHJIjxGWJ97MWQYDVnQSjjcCML12K7CjQKq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W094j7mhJd0l60mKXVLp/MsYtsbJzGGitwqZvzx5qHvVrSYeRsOTjkYoMxV2V9V2e2C/yGegTcL8ONPas794UBiRKfFgpKG/BNBRdGouT5B6T6wKdNKlgomuUFxDN0sZpXRLmbnp8EsZX+m2/SZlFCfXUPEMdmKWCCCoCgfGrDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Mj1pR8fn; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOMvvk7KUkjD8K2qVbHzTQXagQQKvPQlWRqBblu0LcuoL167i33KBXLyQrswWg22hKpt+brQSFU6HpVpPniV9b6GkGHQ6pzhzGftGBGEsUKaNbrJQEMDnBTw+sak6P0LgUYKVYUQPi7z2cDm18qNr+9ovHxU0ys0bFt3xm8c9khJC2DUbZh83uIdP+lBA6096JwyAL2S1aPe/g6RkBJ47FQ1saIJUfnZAFoEjJFvMEhoxH3Z7JdMY95YHIkP8sg+w8ndz9+F5INIT46lEeR9FlZi6IALEEl97MrFothDbdQPsvhbDwTzdA2VAYL90kJGoxMawTL43qEZvYk6DfQS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtQHB3djsvelPGcAJPaccV6hvHItyo80diS0+o4uMU4=;
 b=BCWvKYBYzq084zTStedZuAeVhdpLBAJR8im4xG1XPxIk2RCNXnvRwYcT5aQDxBvXehBSJnSKHFHsIdHQq3V7vHtYEf9CXerv3OLK3sjgzozsoF7Cky3mFjXQH/u90f3D61prrjPtXj2THoBtS1INUJw7oZh4MQckw+ggPeH8i1cAS+S8jp0hNuJqL08VnXQSnfE68z74X04FNGfDqwBXu8tEVLiXCf1jTP0zjGPmfE8qLUSy3hRcyF8By4AiFGELxdirkAq2v/ZOe2oPyowWdOh91uaJQUrPVSHkqb7I2KfzV4a3MkKIcW6kYGTJPKkOnOkK5MdcOjmbbgGPYq8Olg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtQHB3djsvelPGcAJPaccV6hvHItyo80diS0+o4uMU4=;
 b=Mj1pR8fn7J6IuGDPeV1/uS1fjVrCx2P+FjxZIqnrLcmYooU068/qZN6xikyHhD2tqpEk1HeARrEfCj277dCJoB0P3FlNH5YO66SFNM/IC4VeP7LkmCyDeLv46BUGhnYE0RUi9IUMI8eJCKveGE9sxVZhriD//NNCz8hSkn8Ka5I=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by MW1PEPF0000E7B2.namprd21.prod.outlook.com (2603:10b6:329:400:0:2:0:5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10; Fri, 24 May
 2024 08:22:34 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7633.001; Fri, 24 May 2024
 08:22:34 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@intel.com" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan
	<kys@microsoft.com>, "luto@kernel.org" <luto@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>, jason
	<jason@zx2c4.com>, "mhklinux@outlook.com" <mhklinux@outlook.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tytso@mit.edu"
	<tytso@mit.edu>, "ardb@kernel.org" <ardb@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>, Elena Reshetova <elena.reshetova@intel.com>
Subject: RE: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Thread-Topic: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Thread-Index: AQHarQmvBFzCpOqjJUiLi0r0Fn45m7Gl/gfQ
Date: Fri, 24 May 2024 08:22:33 +0000
Message-ID:
 <SA1PR21MB1317CD3794E1AAC1FCE77F22BFF52@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240523022441.20879-1-decui@microsoft.com>
 <7yos4yh6te7zcwga3swddpyjyxlif2c5vqad2rouwf7euw47df@jvouxfoakct6>
In-Reply-To: <7yos4yh6te7zcwga3swddpyjyxlif2c5vqad2rouwf7euw47df@jvouxfoakct6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8a49603b-7362-4b92-a0c5-020edd0643e2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-24T07:29:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|MW1PEPF0000E7B2:EE_
x-ms-office365-filtering-correlation-id: 7486d029-845d-45b8-6c75-08dc7bcaa995
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KEXTkGnW2MKCc+ZohTbyxA488S8vWjcMry5QRwgS6SsSgrSmb/0DyUPBASME?=
 =?us-ascii?Q?Z+Y/LEr11UASJslav36eZYW27Vnn+lo+Yd1FctEIVniFiLUYTrOtMfFPGvs/?=
 =?us-ascii?Q?80+jSFbN0GWbt1zsH6vesuGdK1iG5/gikKwh2VcUUMU+c7/mJuyY4IO1EdLM?=
 =?us-ascii?Q?3Fv5vXJcITY2FDbHeDNj6Pw7A+sG9Z/wH+iPFYfbUqM0FAfybGGGQzERazI0?=
 =?us-ascii?Q?GnvrnZHp61RLGqO61Cu95QUROHR2WgfkXSApgnLwbQDEwcl4aIIHN7HwKa6M?=
 =?us-ascii?Q?G8ohp6mBxPP4KkOq0F1q1SzHOLSuVXnV+k5dDo3WwDkQ3L4BpX/XHP9daa7I?=
 =?us-ascii?Q?6TRJ9hcJUspcYJNicHsXxnOUzlm3QK2nVDHmaDOvSRKmCpolaSs4cDwKhTAF?=
 =?us-ascii?Q?C+P4lApvqYaDnJfvWjc6U6/Woq0lurxEqEJ7MpIrT6xY87eAfSYBif04aM4P?=
 =?us-ascii?Q?B+yk7kQEWH3PkcZLKo/hjqA2SJFMfriOPWNUdQzxvzzGsTWwczJUI+uxSzep?=
 =?us-ascii?Q?ghjLOP9gkr0VnEqx4IKEWZlyxSrABu4N2F/MXLXgxollb6UKmNb5TI5reCvD?=
 =?us-ascii?Q?BPmSpQ4r9lMqRJlJzVgoWCeiSfgGsQ5azqSVqJSnc5/oQJ6Nxe5X7eNLEnDX?=
 =?us-ascii?Q?UyaKI7sKTs+B7mgD+XqEziakusQ4loYNlu14+JxJSu52N+ycTGFmmXki5mcs?=
 =?us-ascii?Q?Qu/FxgQQVMevhRr5ZjHvvmpW1YVKYaGS1T2qCmI8ZAvmDdS95x6sRuHB8su3?=
 =?us-ascii?Q?1LC301LOHm38mTLU4CYe5dwjXdL8QztAay8jzONwLuypx6HS2abCZnpm0K3f?=
 =?us-ascii?Q?Y8C6NfkiaLutRMMzkTq3V1h48fr0urselygO9QMSNvrgkIwLlXhvyEi5MxaH?=
 =?us-ascii?Q?EUEa+qqC3XX7tcmXvKkdGBfb4xxNfnNgsTZGhTvsJSX9kzQLYgXCJbU1TyRV?=
 =?us-ascii?Q?2m5fOPrCwDbE1+nWKjjzXXcsxtDC4lY1zFXb8M1P5WoGaq6whMYbpzMqVCmt?=
 =?us-ascii?Q?ROOhcy+p00dm3kLlL0g5jzJN+mKtDYLYygCVPtm5GeAweubP/JduB/ZEkwN0?=
 =?us-ascii?Q?9WQn/UeLOeW0NayFUdI0IDX1QG99WaeVqvtdiP2AKRC4wfnLWscUF36PKBgG?=
 =?us-ascii?Q?v1m0JNmFsZBXScOQIWb+DNbaMB9BWIJgBgazcUHHOlRuD6gGVcTompgrUwao?=
 =?us-ascii?Q?qPuNpPPtrKAJtysN9l6Rw91lh091XVOPGUjJkO0vHEwZKj+bONs9JFW/6eLh?=
 =?us-ascii?Q?der3ibEhD7MM7e56YFbLRNEOuqvGb72GXyQRXurto9m/e4dBPYcJaMoQVvU0?=
 =?us-ascii?Q?4Cj0aKsfcLjsjIsZtT0R8D1HiOq3tVGKA+GgrV33P7oEKg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n85iWO0eWA6MCP2guRSPOkw7Hxxx208YYYLmjiZh6dX9ODHC+PFo4iBcxAwu?=
 =?us-ascii?Q?pAiObByWsvnBzr9RFcohUfhhg7XH44SWuHJsC5qmwasLNhK/gDaNM0aCIeBw?=
 =?us-ascii?Q?922l1RxBdwif70zC8idsQ7dVf25cT/oHglrU6iUTMMYNr62OE/KgzWkcZUd8?=
 =?us-ascii?Q?wLP8HxLVVPqLQDb/dWQ41STj+qrc3nZnsR4WekdYjl/7oXMGUw26VwIeGRZS?=
 =?us-ascii?Q?8r/LrmMxbBfkhH6aMTbQ3c7FI5s+AVd1QY8OvRRPylszNnRU6PyCgxeNkkPx?=
 =?us-ascii?Q?30eyaIhPruWhXuBKKogi3UDA9idNuCg51aRvo6ruz5cDTfzfmlsPVoa33DZ8?=
 =?us-ascii?Q?h8pj89TUBEB7IDxEY3g0vvnZYlis1Yl/QViMrsjMmmko4KZluKUwQ/i4PWYi?=
 =?us-ascii?Q?U4FQtU8ED0fgmEiRMFla4iLF8fztw4xbKqvCNbQSmC8jVIqU2+Nh6eBL6teP?=
 =?us-ascii?Q?D1I3lcVZ3kdoIhtUscwxgJHJkE6WeAipHUKeJcYSX8tb5CAZMqgoP7ui10Rr?=
 =?us-ascii?Q?tJWTFIsOyQBbt2Vxop9JDfyInVbQTK7tB97fyXSrCBWLx8PVUItysOWrspwW?=
 =?us-ascii?Q?JNnJCeJbH86GIpu1d05IAT5w3hljmj2YiooiuXZZ+7lXxzzL3dtL5ZbsfhA/?=
 =?us-ascii?Q?v/8yftfdumDIsiEC0asOBmNpt5JU8iSKcTNEPveuAC17bGkpPC0yeEPI/nrP?=
 =?us-ascii?Q?74mvA2lWdwbAc/vaqW5iMqQg5AGdTgY1pkxy5NfBanu1ndr53HkJX7geULku?=
 =?us-ascii?Q?1xUsgoBEnnrpKmjq6tQQIELdV0Pyj4UqDL6YMBSAchoHvMBgbqqx0DRYr2l3?=
 =?us-ascii?Q?Tu6i8zARX24Ht4R9B6O4NB0+wltey/7Sg36mNIPXh1fTEJBOuttp3WsJXNE9?=
 =?us-ascii?Q?dRyEYGSHFyoYfuh6taeQuERwZjVupCPNNAILSFbETrph+2DbYO/DJqQCfriT?=
 =?us-ascii?Q?MLyeEhn3gQxNKBU8FvL+TGrQU466hBig1n6Gnvfx3N5Wf6JYPzXAZdznK2YH?=
 =?us-ascii?Q?zzbpJM+oEsc1kI/m/SV1QZTfONWCohwnDOgYyfkvrJBhmt6cpqNXjC2Xcj8P?=
 =?us-ascii?Q?+e7EhtYmpnxXnM3s4A04uxIw9+6Pc+1aWBCVCp07TDlhPss8cTMo6iwCPTLf?=
 =?us-ascii?Q?UplerNH+ZxXmIkUwXp/FcLIeY+9wDFsBzgzeb8yUTuIhA2Hr6h3xfrG6PCJm?=
 =?us-ascii?Q?XGTPF5E3kK9fLpE9RdCPuPSNRjqLvEy7V2XyPLGfucvpy50BsDzXx41iDr0p?=
 =?us-ascii?Q?dAyVUoZ/kI+dNQgC4gcdiEALzUts4VGCmmEnd43os8aRtUiPABRbA4V/HcE2?=
 =?us-ascii?Q?1Qz5lI4vzVdu3x8AxyokEVrFHPcoaYetYP9v59HITl1vbMvs4ZA1iUM8bQQ1?=
 =?us-ascii?Q?iHCkgOVwuMvQWNYjEEef6CJ9qWs1pnAC+Y+yGeNVSdfSglGIOqNuCJ59wQp1?=
 =?us-ascii?Q?a1l25Um+sf/tnP6TSPQtFbqGUJYtpfBHFY78BSt/dd43Bkm6ppNlOvrCUirV?=
 =?us-ascii?Q?r8zou2prUZoOkzS3vwBAJtnAysmOPJCIrJow1keQU34b6SWr2wJXMvavQkRX?=
 =?us-ascii?Q?xEjwj44eZB+w9Q/uQhQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7486d029-845d-45b8-6c75-08dc7bcaa995
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 08:22:33.8220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cga/NoRSXSCgfDLYwSRDbXaZ+/QDN5JZbVnPsl0WDV5oYYgaGZeHgboLvcLM6nqhv+rlMzzd7J8j+ioWY/lRTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW1PEPF0000E7B2

> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Thursday, May 23, 2024 5:06 AM
> To: Dexuan Cui <decui@microsoft.com>
> [...]
> On Wed, May 22, 2024 at 07:24:41PM -0700, Dexuan Cui wrote:
> > A TDX VM on Hyper-V may run in TD mode or Partitioned TD mode (L2). For
> > the former, the VM has not enabled the Hyper-V TSC page (which is defin=
ed
> > in drivers/clocksource/hyperv_timer.c: "... tsc_pg __bss_decrypted ..."=
)
> > because, for such a VM, the hypervisor requires that the page should be
> > shared, but currently the __bss_decrypted is not working for such a VM
> > yet.
>=20
> I don't see how it is safe. It opens guest clock for manipulations form
> VMM. Could you elaborate on security implications?

The intention of the patch is not to enable Hyper-V TSC page as a clocksour=
ce
in such a VM. The default clocksource is still TSC.

The intention of the patch is to enable Hyper-V TSC page only for Hyper-V
timer. My understanding is that: "Hyper-V timer + Hyper-V TSC page" should
be as safe as "local APIC timer + TSC" because the VM needs the hypervisor
to emulate the timers, anyway. The guest may get a bad value of Hyper-V
TSC page from a malicious hypervisor, and consequently the Hyper-V timer
may fire too early or too late, but the similar thing can also happen to a =
local
APIC timer, if a malicious hypervisor decides to deliver the timer interrup=
t
too early or too late.

> > Hyper-V TSC page can work as a clocksource device similar to KVM pv
> > clock, and it's also used by the Hyper-V timer code to get the current
> > time: see hv_init_tsc_clocksource(), which sets the global function
> > pointer hv_read_reference_counter to read_hv_clock_tsc(); when
> > Hyper-V TSC page is not enabled, hv_read_reference_counter defaults to
> > be drivers/hv/hv_common.c: __hv_read_ref_counter(), which is suboptimal
> > as it uses the slow MSR interface to get the time info.
>=20
> Why can't the guest just read the TSC directly? Why do we need the page?
> I am confused.
>=20
>   Kiryl Shutsemau / Kirill A. Shutemov

Both Hyper-V TSC page and Hyper-V Reference Counter MSR return the
absolute time in the unit of 0.1us since the VM starts to run, i.e. the "fr=
equency"
is 10M, which has a higher resolution than the emulated local APIC timer.=20

Hyper-V timer depends on Hyper-V TSC page or Hyper-V Reference Counter MSR
as it also uses the absolute time in the unit of 0.1us. We could potentiall=
y read the
TSC and convert it to the absolute time in the unit of 0.1us, but the requi=
red math
calculation is not very easy and can be unreliable (e.g. I suppose an AP's =
TSC is 0
when it's just being brought up online? But the Hyper-V TSC page value on t=
he AP
should be much bigger than 0) And, there will be an inaccuracy with the Hyp=
er-V
side conversion that may use a slightly different math calculation (e.g. sl=
ightly
different TSC frequency or 'multi' or 'shift' values).

It turns out the local APIC timer in such a VM also works! So probably the =
VM
can just use local APIC timer and doesn't use Hyper-V timer. However, I not=
iced a
strange thing: in my 128-VP VM, each local APIC timer constantly generates
100 interrupts per second, even if the VM is idle. Trying to find out why. =
I do
enable tickles in my .config:

CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HZ_100=3Dy
CONFIG_HZ=3D100

Thanks,
-- Dexuan

