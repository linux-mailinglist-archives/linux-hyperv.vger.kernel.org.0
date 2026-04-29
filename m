Return-Path: <linux-hyperv+bounces-10457-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKOiD7B38WkxhAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10457-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 05:14:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A60DF48EA03
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 05:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF35830B0A1B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959AB344DAE;
	Wed, 29 Apr 2026 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Os8/7qns"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020074.outbound.protection.outlook.com [52.101.193.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91B3537CD;
	Wed, 29 Apr 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777432363; cv=fail; b=SZbSoeqMQEqI6L+jZYEoE1kXLkTyfexJPvhLd9Pq8s6yhRCyn3EZAaeN+l5zyBCRUtP8uSwaV1M3EOpUib1gToZFKn+DYus5SAdY9qlLIGXvHz6wE1UAd7RxRtIVAZ9agmEdsAdD9L8gT4215A5R3EO2a7d34SLEJkt+HpWR7WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777432363; c=relaxed/simple;
	bh=zJslbvrF/wIVZ7S/wLjwoCpO37FVniwUy6azi9X1s3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X9G55yH6/zf02j0zwYd1rEavxpYv9ZZtuOzknl2+BzAX/lTwaWFMDFO+CuSVtvVe4a7M22vi+k6tFV4t+xr+mU8soK85fj4xNmNdZ1iRQbsLQ8Pfru/DA0ULostF9otMOnFPkVOQ/kXKFbh/k2CYp4V3wP+gLs36xDnNk0GANvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Os8/7qns; arc=fail smtp.client-ip=52.101.193.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDym/t+W54ZAqHsgt+wFQ0PLf0GNHykkudrrL9lwH0KTKUAoS+2LXIn1+S9yxMrs4/JAygypp1kUGY8Cq8TwsXcp7zCLFgg6U+7bmMk9KSsX7rHW7e34bA+IxMX3XulD9+IwwKzC0rIiq7Gcc6O7rAdr2x4MubF6+F9FQfEmQNYR0vUJEn67Kf+mmCzj642QQWf6KFe+ITvV0sXSuw134Y0U4TarwEzRPrOX0XTW6rvjrXvwG4EV44DVUq1PqVH1Ne5+EuBjvxSPV1PdQWFbA7n+yF0AbH4RoagoljhNiQmvZbl9bKejTG+Jr8mRRr9Be5EnPNKuSkmxHUrTSRJstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rZpPkAznm8Tx9vl+iKPdv4yHONmgtMDKsI/6Ejaf2c=;
 b=jaB4gftWHELlRDxPYCrTPeKMobnsTqd5mHqvS0dFsXfwXGysUutXaa2oCt5Iwwn213Ms9ohGzVoiumHwRbqBkivO7VuA/0fmYATu5IeW4HwVgBl2WHkgbAXUxYB7itAkBSp/7yw6vMDRH7dAYbbveR5iqfNctR21x6fkO3rdOHKexOb/EBaB1pHE700A5GE/9sQB5doC0ywkMpO6XYLc570+IFqVpZ9jlBJr+2HFPc8o1shbbN3iYDCelBXF1Qb/1I4t8aLD9VTX7vsCN4f6kNhOS3BKkESGA9KXrAMf2ldRqz1CVwGH0L/V+YV6EZWC0Syez+RcMD0KqySeRaKtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rZpPkAznm8Tx9vl+iKPdv4yHONmgtMDKsI/6Ejaf2c=;
 b=Os8/7qnsQqJXC3AhRfhnTEfJQqasi4EgzTsrK6VomK4twfJvvqwyqxk125bIL9hUwzTQ4MDE1eKUrmuwnxWPZsQ4SsBDmBbmdZRzpikeWwlQPdrasOBhaL+bK6JbUpZ1LoycnSfZC6qsGdl2tswBcnvc13cGNFqwvfVbRtuKoNw=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.3; Wed, 29 Apr
 2026 03:12:36 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 03:12:35 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
Thread-Topic: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHczc/fn1PdG2gkFEeUWQdp0QjV5bXs9OVggAhpmHA=
Date: Wed, 29 Apr 2026 03:12:35 +0000
Message-ID:
 <SA1PR21MB69214DC322549834104D26E0BF342@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260416183529.838321-1-decui@microsoft.com>
 <SN6PR02MB41576A849B6C4967622B4BA8D42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41576A849B6C4967622B4BA8D42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49b9d1c8-8fee-4a3e-9934-39f7930a63c5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-29T02:08:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|PH7PR21MB3263:EE_
x-ms-office365-filtering-correlation-id: 0e6f2c2c-a5db-4cf8-b08a-08dea59d297b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 PJYIFvzh/Cr9YJ4IYfU3Dy8/Ik5OtTOIR5/AY/hwtweO/uiENF0vHczvV9LaExntvahvB4K2Uqk1dqM/c/u8rEEHu47Rg3zoaEjxPm0V8OFbu4xqYt0O4V9aVlcJhWaCDLx+vmECzHc+MWEoNb3Hh/i8dUcYTfSMoeOYUArSZbRwzaMyneLMA5dBks5OJBLRseC4CDSpnJJFB59kc5cfxauV4m702FLJrINjUFexyU+k7Sxr3zKt9Sgw9MwZtnrWs1xuZPQdxFq7QNA4EHOp52sexz7w2Og7SqzMpGztvaBHDmIEiwQ2pc7dzgpu0UD2r5mAGjKp48/yrE3+2k+jcT+eOmfn37zqUVMCebdsqkd6rsjFe4ihfoKbK03tagWCShqEyn6NAobvHKnRg7/Q0n+aDXDaHTyg/evCic5G49DaF6fg5mpPi4EqWFHwtfHfEeQzUrg6w1ER4UPR0ucUkd+mSJK79z+kmvM+ydvCHdivXWG6X04o4URFmOb4LeNkOL2jpsYCNVsH8ylRmiNgNRbUv8NEEDQXBl2RfyAU/eE+MjLHSme83KwzftKMKtGT1HHzB5OhVyNkGYkVMAqmx4o7Zu0ingGcww6WmPzRkFY/lvhkcpoLQgFsVaXYbj3rsu+TBCI987or0AGYnwN6J1O+njGJqekQS7FCcmyQ6QhjiZJJzdQ5udsR4GnBDb+IfWqOgxNs+8yYV5VF7dNMjZ1/xL+/tJrsH1RVs79/yHwRguRbB2juVMGsp4CHZPuGcXvXFXx5cDodFjCa9et8CEdBu2+6Uo1Z2RL9lrRoUiY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rUgqviowavPYAt7fNbFD/Z4GTw5K/E6rFfx6vmCghMO4KiGYlVmsa69UDq5X?=
 =?us-ascii?Q?IaochO5llhFoIREWQiAJPyOz1qouDbbSizrZRHxOXpgAbhMU5PXMKxz+wEgu?=
 =?us-ascii?Q?THHKz7H1+vfwZWvDPqMHiQJLLZ8or66OjdVNp6V6IwLj/wcNXCssrViBMR/L?=
 =?us-ascii?Q?rw9b5vZdbPmn8e/PESOaKjkcQpenIa4h6szAw9MW5G/RTARIR9TkJqqN2qrk?=
 =?us-ascii?Q?OP4CdnkPJVhwiRzI4qzSjfC1XebkYxMDd+KU3kb9IIjp/MA7UZv5PiPrZqxQ?=
 =?us-ascii?Q?+LgQ04jznnCstqf+8pLkCoanePStA+qjRe0KoJUgK0kNovnVnuw0IRU0wTW2?=
 =?us-ascii?Q?UHPP16u+vZkF0A+Z0kcZ4u361+byrNswqaz7cBYygPTCt8BneJXKCRltJED3?=
 =?us-ascii?Q?cF3ATSB9RtZKnPPM8YnMgEKRmcUDQCfkk+rI5VR1OnDuW/lqXYl74+XXFYGS?=
 =?us-ascii?Q?LBtsEdACMRb1FaUiQ76BHaGM4rGAt37s1co5Piv0u+5UGuTPz/wUS3sOKaFk?=
 =?us-ascii?Q?/tgsZC4VYGXba/1LbL4C2xy0YHa6+wQmdOv/dB9vlhZ6AmTfUPd6MQXPrIU/?=
 =?us-ascii?Q?ljTPuGWThkM/m/N5dVb1v30iHL0j01cR6jVY9cNYDCD2wU0Lz3LYBnnT3j2t?=
 =?us-ascii?Q?eTTQZPoECB42dSq3PGJDs1bw0hrE69fzyCWfHEO5zer/XrWflMg76VDcZ8ZE?=
 =?us-ascii?Q?6nqRQXxllrqWTkHE6pRLbgCAypf2YR2TZCItPIfXo1Pp0ktPtx1ZenRPwseX?=
 =?us-ascii?Q?b15hgk4aOCLNcWSTVDufka8q8PPTk/y8g+N7Ymv1oNc9cBTFe5SAtPb2ywp6?=
 =?us-ascii?Q?8IIwcmKLTPrgWSTGPXCZrhAssQ4Fs4Mn31DyU3jLySWGesZsKl+mdt9e3Tpc?=
 =?us-ascii?Q?UZLeIgzYOfNS52dbEMDM+6rg3jaCvlRW7QK+BUwzxj1QPfyogQ9AUX/+kHNm?=
 =?us-ascii?Q?VMtLuPt1kcmyznczwuxpartiYS1r9158VgkVkyrhg1xUW7d8tb3NSt033qHL?=
 =?us-ascii?Q?Z0hUMyZKRTQSLZUYTGR2vKDWtvD6Bca5aWOkWaGGOf1eNPTEhrCu7VtAE83P?=
 =?us-ascii?Q?63Dxdhsa+eOZMUoLTT0FRSlp3ZHim22DFIkAtaKYsCnf1YGx+wdoRyqyz31Y?=
 =?us-ascii?Q?MS/8R8n18mZUM4pb6mX0ol1jw5iZ1BcWVS3foQ2R9Wprfu2c1XIj2lEAKHwX?=
 =?us-ascii?Q?7Wfudyj8Ekw5BSHZ6NlpbI1RfeTROZH9G2GbuwT4FFOJViKDG7aCTXi6OB/w?=
 =?us-ascii?Q?0wf5KLYmTigqFNrn1EN2z4Fr7F03zGizu9Ut0c5UMONsUHO5UOYctE1b6930?=
 =?us-ascii?Q?+br0Zvq5QPzsybII/TmCcsKzJnLhM2Km5Nb571wNocNmRgxl2b56oYNgzzkd?=
 =?us-ascii?Q?3tZpu4HNF0hhtGlMlgFbMdJNsCD4bDgr7jfvdhpU/BcuHevUZmjzV45NM7yU?=
 =?us-ascii?Q?4KXxnt5Qnq5SU07qZXJFyJzLHiKpBfVWPkyw0Hiqi3RdPeuXtmGhG+i4ZmS8?=
 =?us-ascii?Q?pvMmWJ/oCm5VIOms6i8DKD21s7SIA2LVNT1485DChsJK65Cv6c0wTKYr34ku?=
 =?us-ascii?Q?XIy17OrDh38yB6ruorB8/Iz9kJTQR5Ih0MDAdp3K02wAW+FV2zDiReB6gWFD?=
 =?us-ascii?Q?GVgUjpStkAC1WFba3NCOq/1CMIOD3JFWO+tYrLLMZy/dgBHOyWkj2yTc6Pkp?=
 =?us-ascii?Q?oo+MOw5tLi+DNFrmQVuj9OwetHQgpBJR4Hs61QGyecxs5eAwy7zmC+y+jz6I?=
 =?us-ascii?Q?F4SZ5Uc4DQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f2c2c-a5db-4cf8-b08a-08dea59d297b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 03:12:35.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h25zw2FeAm4qdTyqyK6lHZRzU1psVYEBeFEDW0jr8Df5oz70ud18b6eS43RWdkuZzK6532MKo+Et+I8Zu4FoKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3263
X-Rspamd-Queue-Id: A60DF48EA03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10457-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org,canonical.com,templeofstupid.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,SA1PR21MB6921.namprd21.prod.outlook.com:mid]

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Thursday, April 23, 2026 10:40 AM

Sorry for the late response! I got sidetracked by something else.

> > If vmbus_reserve_fb() in the kdump kernel fails to properly reserve the
>=20
> This problem has wider scope than just kdump. Any kexec'ed kernel would s=
ee
> the same problem, though kdump is probably the most common case. But the
> discussion here, and the mention of kdump in the code comments, should be
> adjusted accordingly.

Agreed. I'll post v2, which will use "kdump/kexec".

> > framebuffer MMIO range due to a Gen2 VM's screen.lfb_base being zero [1=
],
> > there is an MMIO conflict between the drivers hyperv_drm and pci-hyperv=
.
>=20
> You describe an MMIO "conflict" without giving the details. Is that
> intentional to keep the commit message from being too long? It might be

Yes.

> helpful to future readers to say a little more about how PCI devices must=
 not
> use MMIO space that the hypervisor has assigned to the frame buffer.

Will do.

> As you noted in the detailed discussion in the other email thread [2],
> there's a Gen1 VM case that this patch doesn't fix. For completeness,
> perhaps that case should be called out in this commit message.

Will do.
=20
> > +	/* Hyper-V CoCo guests do not have a framebuffer device. */
> > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > +		return;
>=20
> This test is testing feature "A" (mem encryption) in order to determine
> the presence of feature "B" (no framebuffer), because current
> configurations happen to always have "A" and "B" at the same time. But
> the linkage between the features is tenuous, and if configurations should
> change in the future, testing this way could be bogus. It works now, but =
I'm
> leery of depending on the linkage between "A" and "B".
>=20
> You could set up a "can_have_framebuffer" flag in ms_hyperv_init_platform=
()
> if running in a CVM, and test that flag here. But I'd suggest just droppi=
ng
> this optimization. CVMs are always Gen2 (and that's not going to change),
> so they have plenty of low mmio space.

This is not true on a lab host, e.g. I have a TDX VM on a lab host created
by these 2 commands (without the 2nd command, Hyper-V won't allow
the TDX VM to start):

    New-VM -Generation 2 -GuestStateIsolationType Tdx -Name $vmName
    Disable-VMConsoleSupport -VMName $vmName

The low_mmio_base is still 4GB-128MB. In this case, it's not a good idea
to try to reserve the 128MB:

1) the available low MMIO size is smaller than 128MB due to the vTPM
MMIO range.

2) even if we can reserve the 109.25 low mmio range
[0xf8000000-0xfed3ffff], we may not want to do that, just in case
some assigned PCI device has 32-bit BARs.

So, IMO we need to keep the check:
 +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 +		return;

BTW, I think this may be a slightly better check here:
+        if (hv_is_isolation_supported())
+                return;

A CVM on Hyper-V won't start without the command line
    Disable-VMConsoleSupport -VMName $vmName

IMO this is very unlikely to change in the future, because the Hyper-V
synthetic framebuffer VMBus device is not a trusted device for a CVM,
so there is no reason for Hyper-V to offer such a device to CVMs; even
if the host offers it, currently the guest hv_vmbus driver ignores it.

When we assign a physical PCI GPU device to a CVM, I'm not sure if there
is any framebuffer from the GPU or not. Even if there is, that's a complete=
ly
different scenario and not reserving some low MMIO for "framebuffer"
is unrelated: I think hyperv_drm (or the deprecated hyperv_fb) is the only
driver that sets the fb_overlap_ok parameter of vmbus_allocate_mmio().

> And at the moment, CVMs don't
> support PCI devices,=20

This is not true: recently I created a "Standard DC16eds v6" TDX CVM
on Azure, and I did see two NVMe local temporary disks in "nvme list"
 (here TDISP is not used). In 2023, we added the commit
2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs")
and I believe some users are running CVMs with GPUs.

> so can't encounter a conflict (though conceivably

Correct, since there is no legacy or synthetic framebuffer device for CVMs.

> some new flavor of CVM in the future could support PCI devices).
>=20
> > +
> >  	if (efi_enabled(EFI_BOOT)) {
> >  		/* Gen2 VM: get FB base from EFI framebuffer */
> >  		if (IS_ENABLED(CONFIG_SYSFB)) {
> >  			start =3D sysfb_primary_display.screen.lfb_base;
> >  			size =3D max_t(__u32,
> sysfb_primary_display.screen.lfb_size, 0x800000);
> > +
> > +			low_mmio_base =3D hyperv_mmio->start;
> > +			if (!low_mmio_base || low_mmio_base >=3D SZ_4G ||
> > +			    (start && start < low_mmio_base)) {
> > +				pr_warn("Unexpected low mmio base
> 0x%pa\n", &low_mmio_base);
> > +			} else {
> > +				/*
> > +				 * If the kdump kernel's lfb_base is 0,
>=20
> As mentioned earlier, this case isn't just kdump kernels.

Yes, the first kernel also runs here with a non-zero 'start'.

>=20
> > +				 * fall back to the low mmio base.
> > +				 */
> > +				if (!start)
> > +					start =3D low_mmio_base;
> > +				/*
> > +				 * Reserve half of the space below 4GB for
> high
> > +				 * resolutions, but cap the reservation to
> 128MB.
> > +				 */
> > +				size =3D min((SZ_4G - start) / 2, SZ_128M);
> > +			}
> >  		}
> >  	} else {
> >  		/* Gen1 VM: get FB base from PCI */
> > @@ -2433,6 +2457,8 @@ static void __maybe_unused
> vmbus_reserve_fb(void)
> >  	 */
> >  	for (; !fb_mmio && (size >=3D 0x100000); size >>=3D 1)
> >  		fb_mmio =3D __request_region(hyperv_mmio, start, size,
> fb_mmio_name, 0);
>=20
> Just above this "for" loop, "start" is tested for 0. This patch eliminate=
s the main
> reason start might be 0. But I guess it's still possible that the legacy =
PCI device
> BAR might return 0 for a Gen1 VM?
IMO the legacy PCI BAR's base in a Gen1 VM can't be 0.


> Or you might get 0 if the pr_warn() about low
> mmio base is triggered. But I'm thinking maybe a pr_warn() should be done=
 if
> start is zero.

Ok, will add a pr_warn() here.

> > +
> > +	pr_info("hv_mmio=3D%pR,%pR fb=3D%pR\n", hyperv_mmio,
> hyperv_mmio->sibling, fb_mmio);
>=20
> Outputting the above info is nice!
>=20
> Michael

Thanks for all the good input!  Will post v2 for review.

Thanks,
Dexuan

