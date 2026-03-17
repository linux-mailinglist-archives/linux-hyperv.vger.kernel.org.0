Return-Path: <linux-hyperv+bounces-9503-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HJzLt6guWmiLQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9503-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:43:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D7A2B10F5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFBE63001393
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDFB3F54CC;
	Tue, 17 Mar 2026 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VdQtJMlC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020082.outbound.protection.outlook.com [52.101.85.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2537D12C;
	Tue, 17 Mar 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773017; cv=fail; b=pI+D1QgF5G82lRmk3BWKo2Dl8sUozQDJgAvhbGMvRSHghwXXvQI/XzDsc4Pfy42+A0HoKrGBdReKxD6fhljk7/4aR1+BhXeeusibWHnTO+XZrT88ZFw3b0imyKP/jEaUMAr8sFk5kK87dpo14+Se/PrYXPVgzoh7jMjZappIVyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773017; c=relaxed/simple;
	bh=ebJZ6RjsH06SN/39gsOjq/5FLnyd6F6Ze2kHy35teEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P2ajVD7DRj4qnxVzQfm/ARHymEApsp7F2TLg4VD80aBA3Jueg1LXH/k47f4iLkKBt+cfF+Hiv4UvzHVAzH74IxJCwd5PHgtS6zkO9HCY+J/nHghqRUV0eJUWlZak9FOqHyjURkHVGncHjkRKejnqM2AdXrRl8Nk71uCrYo5hd08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VdQtJMlC; arc=fail smtp.client-ip=52.101.85.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn91dvXxOmhnS4CHHtVhOkVeY+q8qKY6Gl4gol2XE40z68hfBY+8FICHtqiBcAthsj/mX2BiHCu5PLDfWF9uhRdg8NCM0bfvPEloBVCv/yoNU7isW/SNU/ZjLhQxOrjTGE5aqvz5KcQiuea6f2Ek7ZV9eaWQ+z0a3i/WTpuobKpn541HugoyrCcBRy5Ey/0A0YMUa5+tsOD9rQzjOBZ5VA9yEIPYVC+w5BDf2SA43rnUjDrH4yUIM+TZTKeKg0mVNz0etophKtK7fpiSNHDxuEodjQ8SYgywDG93nYVzvKHQjOTc1ctTVusBs4yoyk5DZ4OUxAPU+OZEW/P8vgf4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFKqUgXkLsfQcVsJ5CBTFejgTAVmjrCAy8pEbpvnDUY=;
 b=M2mb9ZnMq0Bp7iiy6CTfmV86MgHAofT0IA7p3B3m8ZJ9tnuTgk0QbyPzlkdAu4nWVFuuN+Sb3wGVBoc/vQbtiSVwI0AnbHDcZUQXMP8vk79vYrtBYh7oetvBaAHUjCJvN8TSpSRdyRwctoV6EKYH/YHnhoKM0eaQIc8mcGqrz1QDr9cEwo7e9gOt8d7eqmcJzkre/0fbZ47d6ADWwXqxQ0zV2PlrUnMw0WSEd0eYoFvUKsqZLVGStW+lI3L2lIftN9h+bRLsX2EilQrWpRJQYwsDntHCEa5sqSzBCTQwkGLvHH/3j0Ir2GzdKUdvPqjWPHjG/Ox09WHy/a6wCmtZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFKqUgXkLsfQcVsJ5CBTFejgTAVmjrCAy8pEbpvnDUY=;
 b=VdQtJMlC/f7c3MC2KklpctvumJKdG9/+YfTvurJZofk5tiFg2quNUpy4S9Sbpat0EEBidypyx6RM5cdhEeA5DkpheVKl9obUG0RQpXqgghGNwHDq19SyCfNtnmpn0pqfpvjJnvQiBbdi4CsrseVRYY6u4gV6kyH47469NZ8YrbU=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV5PR21MB4944.namprd21.prod.outlook.com (2603:10b6:408:304::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.8; Tue, 17 Mar
 2026 18:43:24 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Tue, 17 Mar 2026
 18:43:19 +0000
From: Long Li <longli@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, "drawat.floss@gmail.com"
	<drawat.floss@gmail.com>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"ryasuoka@redhat.com" <ryasuoka@redhat.com>, "jfalempe@redhat.com"
	<jfalempe@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 2/2] drm/hyperv: During panic do VMBus unload
 after frame buffer is flushed
Thread-Topic: [EXTERNAL] [PATCH 2/2] drm/hyperv: During panic do VMBus unload
 after frame buffer is flushed
Thread-Index: AQHcmZIQtxt9JG8bZkCPM2etCipilbWzSHcA
Date: Tue, 17 Mar 2026 18:43:19 +0000
Message-ID:
 <SA1PR21MB66838F5A06CB286CB3DCE287CE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260209070201.1492-1-mhklinux@outlook.com>
 <20260209070201.1492-2-mhklinux@outlook.com>
In-Reply-To: <20260209070201.1492-2-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=81bd080a-a735-4d31-8c36-5a4ff1b0442c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T18:42:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV5PR21MB4944:EE_
x-ms-office365-filtering-correlation-id: df8c6b25-ba80-49a7-52a2-08de84550f2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info:
 O/hY/pSDmKLl0/VosDb8G0r3Vzftr/+Weq6EcjU4NRN5AMgM6M6kmvlKJEfowImZvPF+aDevknx1Bamdtewk1p5qC4ICtwEy421duxe3GYr+8YAh8kRjtdcazyx6Ih2b6IOjQ2KPQRL+uc9GoqYNZ1GKSF9XXcWR86CQYzWEMx5vR+WDf8bU3IjW10hGfdTgQLchFBkNYAxZ7r+rsQuveKyjjiL2GrKruLBstDzFz0hxwIn6BSaq+8YhcUDp2zQ5tgHJq9XITFtof10HNso56Adaj3AWGUzuB7LuDwFjivIquX+0ugr7W0Wv7sPov5ZhuV+LgEisoijLfhngEwWxPozJmU/ee2RmeqEOKE+ERQtysEOSajQZiPRj9jXChDOZyOf7/Pdr91QzcGxRa8Ohtc3YEYvWQgLQv8HuccIVy19xCjpsnIwcV8GnofISkHKQ5wSxgAB7etUX6HZXpegvpyEF6f17u8Ka+mAs4/SrIaZUkw2wwncnsaW3DLqN5tmtI5WHCfrORLzQIpD/D/95kydPua3EtYjucUHHLqGDUwKgwFtLb9ZC5EY0OaxtTO/8VDBsL2QqeRM+pObVJudPFKITFrmaRnVpXXwg0CyoFj4+vP6RC+5FPJhp9JPvFe1ygbdvEcFouUpto5D5gu60WAkWqBFUV+gsRXSkVsZY0HHEmZD7AeQ+Fu6MBTSryV4WZrt/2XdprNPFJmmao6F3Amx+wpfr2o6whvl7fitbof9z2ThCqLF9feY2jlzeTOYxx4rY3+Iave4RnnvxEEIw2GWKOGpzRNRz4ZphGFsjfcjSZih0ncR0GhEN1Og2xWPg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dIyt6MvgxAGZxsDmM14ipJ8BhF6/gYN+S1jt/8/ycUlEnpU0fvwiSkAHy+vA?=
 =?us-ascii?Q?iBAJCYYHJ8yyMWN0Sda8KQGyl3EpRPK0ZnvPumFBIGGRP9rYJ9+t5U3bvJpq?=
 =?us-ascii?Q?LabVh29MPPvY65o7YNdtpYTMWvD/pTOjJTECtHtVke8V93QsmqlIuF1VRM81?=
 =?us-ascii?Q?5ez+HFkxNmdv7m06LbJt2T1MrukYBk9sz29+gp/hVLeqB1iEx8i6UkIo50L1?=
 =?us-ascii?Q?xk2BeTYOeWMJXOm5NHfyJcdSIWG0uCfWdBg+Q15ATQGYNgecvimhXaXWtsYU?=
 =?us-ascii?Q?7MVau63du54bvw2Vyw0XYxGe9beaLCrfc9PnknmluIcvUCfv9ONQW8Tfzl3r?=
 =?us-ascii?Q?vRl5vuHJmgO9TPLs/5XET1X8vAsAZlG9hCQkOAbPhLb6cHr5eGqwPqjAciYF?=
 =?us-ascii?Q?PxwTgdkEiocxtvG6Mic7zEdfFNrzbwXS2MXrmT+FFQ3lDdIOuAodepcSf/jO?=
 =?us-ascii?Q?y7UiaWEX5MBwWfSzmGupnswVlU0HhN2vcCvFd4MrLlymseXYoax3CgtLqw5g?=
 =?us-ascii?Q?6QQhrNcmHQNvy7wpyk0LHRB2gMudPmBZJh0fap41/htgkeNVJTolg2WPlToM?=
 =?us-ascii?Q?rgw2PN/kuBtU3GG/Eg+UtX3hZPLjabG4M5W6RYdkpEgfLE/Qg+XCPBmqXFwm?=
 =?us-ascii?Q?dcO40EzP/l5NjkTwYQXUMwPcHvvefDEtp9gEJfKlEE/giMrOiSX9oKQQBgZZ?=
 =?us-ascii?Q?caAJwFFYyzI73fG9NRK+ReVLitDM1RGXevfmqWsWtdatcKkNrSVb6mKHO/lE?=
 =?us-ascii?Q?n0m/OQIBNAtzh1+ET7J2pQ2Nyi+PncbX9Mg4PAW6U8L+iDGoS1zG66BKLrDh?=
 =?us-ascii?Q?ZLbxFzNbW9WYqoI3HU3IzYm8djM99vgj8eIOEGxkRxQ5j+K83BZVfmFPBl0D?=
 =?us-ascii?Q?ZyPjdySKZkSRrs3BTV0XdymnPUZ4a66B6SECWDmGLgn16TK/TugNJ3oqif25?=
 =?us-ascii?Q?YyJMuVfjT6emaFihTWI71Pg56fEu0ln/YabTT4z8tUWEB+uzG5Uvw6oEKlYP?=
 =?us-ascii?Q?GTj/Zc7ZazMCY+HQ31o5FHwHzoKCueA1lJjQRkGmCgJGypea3GrP+khBc03B?=
 =?us-ascii?Q?3d0ELDsC/Q1E7KBnp7LLOUThYtp+eu4uhLG3VrkAvcQHMRurZgfuQ2YaaAiP?=
 =?us-ascii?Q?RaYoZK9xU0WES4I0GakUG0jd5uVKJ7Z/ErxnZcPLRWwYjkGjcKy81OD3ALK+?=
 =?us-ascii?Q?kMUzcCkEUsUJfkx+/TAv5UI2uorRycBqOnxK0ZvBzIfA8ugX5KYoQPp4sj62?=
 =?us-ascii?Q?NcFwuXrzugf8CZhVuWkarHrnV7TxCBypmaH9jre/2qdjY2nhbIJNWByzG2Oo?=
 =?us-ascii?Q?cIxMyjpRisBXYFBtYaeCRWvBx/c/Rx+JPqZ8F5haNDQJoY07u0Y4FS6nK1sb?=
 =?us-ascii?Q?PM1V9eAFGOjDbdy+nfAVkYtnmJGDXmFFc0VMUmNFanubqAZjVRRDI42VqVDr?=
 =?us-ascii?Q?igaH6woy7Wcs3GJbfyUP9c3fLUcDjnn72ADXO3ob50qW+CoXhaG1LJymM14j?=
 =?us-ascii?Q?HZNRuqT92Rkc/AVuaJ31Ak4Nrqq141GnMpJY+2q8MXnMMNfy7of5andsp2yw?=
 =?us-ascii?Q?dGERKL1fiXNB2uYOF3gLx0S89eZjsnljIQeYPcyt1V9rG/N1ZehJMiuUYOc+?=
 =?us-ascii?Q?NVHeKnDNrcKuSxMB/sPTnVEZVMPXsc3Odi/eMy8zCPmGC0WpECCBm6pBDZzg?=
 =?us-ascii?Q?7o/k/FOcHlie3cuC5mxAOc7QHCUbGbHLrpmzQBykRRJNrtMI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df8c6b25-ba80-49a7-52a2-08de84550f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 18:43:19.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2axIL38ql/rxmM9KCdq2YWUe2kqrJlJCpztFK7tA3jGRWLkwmG8Fl5b8FajR69PbyP7WSZFgY5iKRRLiopHmDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4944
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9503-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C4D7A2B10F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> In a VM, Linux panic information (reason for the panic, stack trace,
> etc.) may be written to a serial console and/or a virtual frame buffer fo=
r a
> graphics console. The latter may need to be flushed back to the host hype=
rvisor
> for display.
>=20
> The current Hyper-V DRM driver for the frame buffer does the flushing
> *after* the VMBus connection has been unloaded, such that panic messages =
are
> not displayed on the graphics console. A user with a Hyper-V graphics con=
sole is
> left with just a hung empty screen after a panic. The enhanced control th=
at DRM
> provides over the panic display in the graphics console is similarly non-=
functional.
>=20
> Commit 3671f3777758 ("drm/hyperv: Add support for drm_panic") added the
> Hyper-V DRM driver support to flush the virtual frame buffer. It provided
> necessary functionality but did not handle the sequencing problem with VM=
Bus
> unload.
>=20
> Fix the full problem by using VMBus functions to suppress the VMBus unloa=
d that
> is normally done by the VMBus driver in the panic path. Then after the fr=
ame
> buffer has been flushed, do the VMBus unload so that a kdump kernel can s=
tart
> cleanly. As expected, CONFIG_DRM_PANIC must be selected for these changes=
 to
> have effect. As a side benefit, the enhanced features of the DRM panic pa=
th are
> also functional.
>=20
> Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++++
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 15 ++++++++-------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 06b5d96e6eaf..79e51643be67 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -150,6 +150,9 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>  		goto err_free_mmio;
>  	}
>=20
> +	/* If DRM panic path is stubbed out VMBus code must do the unload */
> +	if (IS_ENABLED(CONFIG_DRM_PANIC) &&
> IS_ENABLED(CONFIG_PRINTK))
> +		vmbus_set_skip_unload(true);
>  	drm_client_setup(dev, NULL);
>=20
>  	return 0;
> @@ -169,6 +172,7 @@ static void hyperv_vmbus_remove(struct hv_device
> *hdev)
>  	struct drm_device *dev =3D hv_get_drvdata(hdev);
>  	struct hyperv_drm_device *hv =3D to_hv(dev);
>=20
> +	vmbus_set_skip_unload(false);
>  	drm_dev_unplug(dev);
>  	drm_atomic_helper_shutdown(dev);
>  	vmbus_close(hdev->channel);
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 7978f8c8108c..d48ca6c23b7c 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -212,15 +212,16 @@ static void hyperv_plane_panic_flush(struct
> drm_plane *plane)
>  	struct hyperv_drm_device *hv =3D to_hv(plane->dev);
>  	struct drm_rect rect;
>=20
> -	if (!plane->state || !plane->state->fb)
> -		return;
> +	if (plane->state && plane->state->fb) {
> +		rect.x1 =3D 0;
> +		rect.y1 =3D 0;
> +		rect.x2 =3D plane->state->fb->width;
> +		rect.y2 =3D plane->state->fb->height;
>=20
> -	rect.x1 =3D 0;
> -	rect.y1 =3D 0;
> -	rect.x2 =3D plane->state->fb->width;
> -	rect.y2 =3D plane->state->fb->height;
> +		hyperv_update_dirt(hv->hdev, &rect);
> +	}
>=20
> -	hyperv_update_dirt(hv->hdev, &rect);
> +	vmbus_initiate_unload(true);
>  }
>=20
>  static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs =3D=
 {
> --
> 2.25.1


