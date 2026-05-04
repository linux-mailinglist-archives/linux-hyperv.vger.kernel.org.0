Return-Path: <linux-hyperv+bounces-10587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNsPKW23+Gn1zAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10587-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 17:12:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7244C07E4
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791CE301DBB0
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3C3DFC77;
	Mon,  4 May 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JC+/DuPK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011071.outbound.protection.outlook.com [52.103.23.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496923D5254;
	Mon,  4 May 2026 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907343; cv=fail; b=V5CVKhwahas+H488ZVPnpflqk6Q5GGjmg/dccTJ5RFvjYbMqiZVVSBQSqCgfH01b75c9170BnehphIBMcZk3crM/DcpC4gzdI6d+CLHcKkV5Kvc/xg/m1ziu6qgpVcSJ2qit7OpZ/pb3/SBdal82C0jI+l+hOGAu8kXOtS5jjw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907343; c=relaxed/simple;
	bh=42tMFRRl31EzIwBUj0Yapg2u9VmvVFke5U3tfQNY9X4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJGYQppsZv6ItwWYFpVEPQaVJEoDm/2AOLGD71jRE5PkzXc3KZIAzXhZS+B0Uo0GfOPghhDO5+YQ8yThSiBkRqKuLM62jLmprDbv17d9cHnq6KMt/reIC+svaNDJFWZthh+GHp/WGZZWHfBrTha9/dvTtOUwVcwlfFYD87BD3MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JC+/DuPK; arc=fail smtp.client-ip=52.103.23.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Adyw4/uqbNTDAsFwVSnI1ZwCbm5/Oc0BdTLQ+jaf5WFaIbcbBfjdGSLEjt9khfhd8c2UT36d2DxvK0sHwcYBAAekMYa8a5vYq6/42+llwkm1exoJx3J/SM7R08wfEG45erJR+4BdULn/fvKWknw0LIqeHVMkVkC6WeGoQz7u+9XYFO4thB03B2N9jmZlCsT2xfpFTCyaRty+Wp2eFMNQqY5rtaRPoYohyL2CiIYkmW4IEIJtWLSsW1iw5YRMXgrlXQKb4FKBMV/DwONSYQmljSRRepf51+DZM96jEfcUHh/NwxOy7ejCjTnVnWxijOIcQj3pxdkqNcBAbbn4NuMw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4FLr2UmJC3aoTx7N1SMiIy2DnkhMthM+J9iQ59WVa0=;
 b=qJ7x65oKOzFqF1XPrAxr+pqUirUSA4dTAX/RJcpaqP2CHXOKUBd07ztgIk2TEXgGJeUX/N5CrEct9YCaYr2UXnvXgUC/2DJtN1U9Fn+7M39rQHUHTNmDR7Vd/Gb6bihU5X55iiluCMVQJGhpcfy2taJE3vvn38lwzhIfiEP33RyPJ+STS1wlg+g87/L9ZVo4GoE7iFMuuqOxi3Dy/pFpmVRfFAQvsfzYEfqSKsVI6P4+fkO1Q5Eylo24OXdr2sO9yPZz6mvpmTYFicX8C/d+EHQcgCCywJAFS4qgzHismp0BAuX/amf8/mwtf9IYq+Xx+HAhrZZcOECCwgle5OH5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4FLr2UmJC3aoTx7N1SMiIy2DnkhMthM+J9iQ59WVa0=;
 b=JC+/DuPKkSygETlkR3aw/DHRmODgTp6zudGmtSK1x8Edy/JCU8giQakkpilRP4ZhCXxJ72WpNjtn4X5/e3Yj16VaSVj4bGPOiK2iUddOki6GCMJtYl3P9oJx1kPkimki2MzJIXPFMb1pR8giwFFBhVt/eqvkDmod9dRDEv8TA2OLmHKRe7NyATTK4qcNGDHgrnZtqZk+puJUh5HyumR7xivUikFQlim4l/MuS5UCqvHOoYEOrP8/K9WnTK4zJx+htEUD75+F5sJaM/iz0Qf3at8tg++yxBpW14k861gvKPgs6WkWgr+kA+Uy4+YqsWeOxHpouiUrhaFwQopXrmx0pg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9818.namprd02.prod.outlook.com (2603:10b6:303:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 15:08:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 15:08:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jork Loeser <jloeser@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnd
 Bergmann <arnd@arndb.de>, Michael Kelley <mhklinux@outlook.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>
Subject: RE: [PATCH v3 2/6] x86/hyperv: move stimer cleanup to
 hv_machine_shutdown()
Thread-Topic: [PATCH v3 2/6] x86/hyperv: move stimer cleanup to
 hv_machine_shutdown()
Thread-Index: AQHcxvg2HmTNS6NSCE6evZbMLg7HuLX+IeTw
Date: Mon, 4 May 2026 15:08:58 +0000
Message-ID:
 <SN6PR02MB4157B671B7580BD8D4B5D5FDD4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260408013645.286723-1-jloeser@linux.microsoft.com>
 <20260408013645.286723-3-jloeser@linux.microsoft.com>
In-Reply-To: <20260408013645.286723-3-jloeser@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9818:EE_
x-ms-office365-filtering-correlation-id: 390b5c6c-ab97-4edc-ef07-08dea9ef1150
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|8060799015|8062599012|19110799012|51005399006|13091999003|461199028|55001999006|19101099003|31061999003|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?89sRy92F0vWKlZZQIRqKi8sJY0D2reVxaKQvgoxwZk5ZnhBnZ79j4+68DzXh?=
 =?us-ascii?Q?CxxaAW4c9WLIruHyP4uvaCrbjZkvlWNq7nQ3rYTjTmPHlePKU5bZiafMvvxK?=
 =?us-ascii?Q?Vqkt0DpXDGcujGfiTDF1J6sirvIvS19u6PVizWbnEpEeag1Sv/JkKvbLI4XQ?=
 =?us-ascii?Q?hH+/zhO6hF61CEEkvQUUhdFn0hP/mUH5xHJJTeThQs3sN3zSe1JY5weezs95?=
 =?us-ascii?Q?R4JGRXZBVvpG0sWiaZO+u0TqzheUgzqtXujkm1zJg0ndyHVvZAjsRmeG8xA5?=
 =?us-ascii?Q?bQB1m9y2NvrLCtFMQ3iYLgQCdRn95zgWBG3klZoNnzhl6cdctzgWm8wZrDif?=
 =?us-ascii?Q?hgyuEZYAJXMgZLRNdO0CRciAsizCW5eyqNog2FpkDJDm82oQO2HH6yKxiW4M?=
 =?us-ascii?Q?vT8ivOC+tQO+vhgtsj632kaLrap5whENgP9H5h/6T4Md8b9DamN/SUYy7x9+?=
 =?us-ascii?Q?OqTtE48oQoPfltql3wXuusoCd6J6LeHp0+2CZCYbhOavt8GaEQjwOZh9Hugm?=
 =?us-ascii?Q?EoaeOlYIRYyAG5H/oh/F7CAkCUJ9WtB2IBoyVYKWdjwzi6gQrcALhculyFkM?=
 =?us-ascii?Q?HpRzeT8TqWv35AKcBgO36syt4F5MpJ4idnD2zxefeSymoOiyJisy1kp2gle5?=
 =?us-ascii?Q?4LZYk0ccqXYo+8xFv9rW4akVIhW69qaDLtqybRnPnE/GpUvguSXL2S53txfU?=
 =?us-ascii?Q?YbwnbMc95cojnYTbvXrZngWmaxN+rnc4IEzEDisEBCP9I+WalmmLAXpodvRo?=
 =?us-ascii?Q?d9vdYyE3uMeDamK4cQoiHPS5BzZpr61Kw2uIZ1A7mmJojb/YQMYAZD1NEQeM?=
 =?us-ascii?Q?H/8eMBcZGm8N7C2Y9KEvDvN9icfaZt3300PdZDyEbJKq4oUi6PzHzNFeZz1v?=
 =?us-ascii?Q?E9GU6Xrk4hXK0fkyYF4TIZRP0BzDaPMkDLQR9WWAghr5L5oz+hqthnN1nzgr?=
 =?us-ascii?Q?Yhb2SnpSE0Y21D36cdb76ALnbsM5o4HhkCJk9UxyXT8TirjzDA0MzqdoAFew?=
 =?us-ascii?Q?dZbsISa/X0ehNkP/i84rsofGVWqNjbCMeyTdh2E219dtuEfQt5XJBUM3bXmz?=
 =?us-ascii?Q?s2v2sLE/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7hzVY7AMugTgPrZECYaMYZkM7obIKDyIixvZnApEqWMjvUv2XL4Z+j32ZukY?=
 =?us-ascii?Q?G43mosyLnlSkMV2Nv6FbqcNvWK7fqAhKQIjf1ZFZUsQnj0lRLfQndjf6qwJE?=
 =?us-ascii?Q?TnURUVOQgLbIiodIkzgK9mb9SW9xxYSisUzaVlr90FGWJSJpT9uRbQeria9W?=
 =?us-ascii?Q?5BL1WqXxN5qB/rJ0uJfSCndHX+Fvt7lNCAupKczIFR52OW2agNYKnlNaYkHr?=
 =?us-ascii?Q?alRRZ7t14wTfeHOJ0M35PzRG9Jgo2eUyPC1yzR2noXnLcz7ggPYJQqr0HJmO?=
 =?us-ascii?Q?fArZ6p6Q91fpG71dOSslqeNT2CHXA865duPVIuqxW3E/lhxCZiSyccyuNprN?=
 =?us-ascii?Q?6eQKJeBpDXY7OwLzra2+5GkEOlABXz/qyutYW2UeKotueMKJMG9mbgINH8Rl?=
 =?us-ascii?Q?3jPunerEjQNnaFQXm0StrHtzZpTtZL+0N/6FGA6Kd4zZnlrEbJ4FGW421JhS?=
 =?us-ascii?Q?BysOWJdo+8M4pzhK9Me2idH7L+huRFlgl91zwJo9Ea1i+MQRNa3grqEdlgL4?=
 =?us-ascii?Q?1kWcFA/UJrFuVzsfFnN2math6EQ4M7+DFFS3NHYp/PGU8Kuj9IrtOBBaXPic?=
 =?us-ascii?Q?k/uySo0hsLtKU7jDEfMEqwO6XojH8oAv0kuYHux84v28MQw1wIEhOr+A2VYq?=
 =?us-ascii?Q?q/LDSsgBBPNjjN5wxfNMZdhK6NusT8odbMReBt9FyFcWGF2sTBUbANj24TmG?=
 =?us-ascii?Q?MhrMkmRlkvQc0SceA6SUeHf6P0t23T95s4xfJ4G2Rie3gXzsuk4QDpWKdyI4?=
 =?us-ascii?Q?EB/gxmxo41xmc9lnJEHDvCwc3CjSqu6aQ62kJho7WsWSl2rco803tXLQnCr2?=
 =?us-ascii?Q?f4l/ZLEDb2J1cGE9vZBWzfXXjcEKHadw5OBuo/XK+fu8TL9XUGx2bAZgfX60?=
 =?us-ascii?Q?/WZO3nO3WjV6W1/7i+D9DnAwX6+l2eZwSylliUQHr3wz1J/C4l9pQ5LwBB43?=
 =?us-ascii?Q?B0AWc+cqGAd7AL2asDtOVtDpJMSeMrypL9c3myVfD3sFXi8vlDs0wInmogEH?=
 =?us-ascii?Q?i3/B17L/IL/ZTAtRGFebBuITDfN0H43ejkjhGG2iB9CPtc5SStVEUC6k2cHs?=
 =?us-ascii?Q?4GFIvT3sRmebBPXz6XYtShCLWiNVl+eWDGlksdOR+7HLoiwUoDVMlewLtLkV?=
 =?us-ascii?Q?BohsvRZl+WnVdyHnUQDKde0+luthcak1co+n3r2aXi5652VrzaubAD53SUUg?=
 =?us-ascii?Q?v7SAHzm89gR2OglHSApVoxOx1BojFKtnljPZYZCh1jkdAVl4TCeYZxujgh9c?=
 =?us-ascii?Q?QOogZadrgs10bW/HLxgtM5GfO+7+yQ6ztJ5kIsGkshn/kppRLCJuc1+2xdJ8?=
 =?us-ascii?Q?0f00cix5lUl4XH0k4kZrHAztIMqu27UyWuIx/BaJgjzFt8BmqFAMx/lY+54i?=
 =?us-ascii?Q?bMbPz8s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 390b5c6c-ab97-4edc-ef07-08dea9ef1150
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 15:08:58.5715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9818
X-Rspamd-Queue-Id: 9C7244C07E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10587-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim]

From: Jork Loeser <jloeser@linux.microsoft.com> Sent: Tuesday, April 7, 202=
6 6:37 PM
>=20
> Move hv_stimer_global_cleanup() from vmbus's hv_kexec_handler() to
> hv_machine_shutdown() in the platform code. This ensures stimer cleanup
> happens before the vmbus unload, which is required for root partition
> kexec to work correctly.

I know I'm late to the party in commenting on this patch set. But I'll add
my $.02 anyway on this patch and a couple others in the set.

I had difficulty understanding this patch's intent. The commit message
says the intent is to make sure stimer cleanup happens before VMBus
unload. But at first glance, the code in this patch doesn't change the
ordering. It appears to be immaterial whether hv_stimer_global_cleanup()
is called just before invoking hv_kexec_handler(), or as the first step of
hv_kexec_handler().

But then I realized that hv_kexec_handler isn't set unless the VMBus driver
is loaded and initialized, and that doesn't happen in the root partition.
In the old code, stimer cleanup is dependent on the VMBus driver being
loaded, and that's a wrong dependency, as stimer operation is independent
of VMBus (almost -- there's the old non-direct mode stimer path that
depends on the VMBus interrupt handler, which muddies the conceptual
separation). So the patch does the right thing, but the commit message
doesn't make the real reasoning clear. My feedback would be to improve
the commit message.

Michael

>=20
> Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
>  drivers/hv/vmbus_drv.c         | 1 -
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index a7dfc29d3470..e498b6b2ef19 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -237,8 +237,12 @@ void hv_remove_crash_handler(void)
>  #ifdef CONFIG_KEXEC_CORE
>  static void hv_machine_shutdown(void)
>  {
> -	if (kexec_in_progress && hv_kexec_handler)
> -		hv_kexec_handler();
> +	if (kexec_in_progress) {
> +		hv_stimer_global_cleanup();
> +
> +		if (hv_kexec_handler)
> +			hv_kexec_handler();
> +	}

Immediately following your code change is this code:

        if (kexec_in_progress)
                cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);

So with this change there are two "if (kexec_in_progress)"
statements in a row. It's not wrong, but it looks like the
patch wasn't fully integrated into the existing code. The
cpuhp_remove_state() and the comment should be moved
under the newly added "if (kexec_in_progress)" and the
duplicate "if (kexec_in_progress)" can be dropped.

Michael

>=20
>  	/*
>  	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 5e7a6839c933..c5dfe9f3b206 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2891,7 +2891,6 @@ static struct platform_driver vmbus_platform_driver=
 =3D {
>=20
>  static void hv_kexec_handler(void)
>  {
> -	hv_stimer_global_cleanup();
>  	vmbus_initiate_unload(false);
>  	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
>  	mb();
> --
> 2.43.0
>=20


