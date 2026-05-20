Return-Path: <linux-hyperv+bounces-11055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJyzMyzGDWrg3AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11055-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 16:33:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF1158FAE8
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4038930013A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370A39B94C;
	Wed, 20 May 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YzD/PpBO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011030.outbound.protection.outlook.com [52.103.14.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EA33260C;
	Wed, 20 May 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287084; cv=fail; b=t4Bg6EDHNyn2kb+yHQmjmEt/pJh5apiG9+Kttw5SiBeMD7m7iqIWqo+NgwCLIyXFLOBFg5A3yuyZJEqIzimkSQnNRbqTVEY5vfd2Z4eKcfu+UHJw+0Dk5+DGJZ/i6XlwkCEQsc2qLP4EWEUhHf4URBLgoswo3/m2rTZ6DYL1q3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287084; c=relaxed/simple;
	bh=I9trZLp3OJkIKoceb44VwXqqO4Suf+MVGbZDNhTiVos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NCJHAZgmjbm9Fj+HDzdBxaTqAdQevo94JxZiPsBO65XZt+dWQnouOGrh79gCQOOhtXW3aIdwFx2X+BVbxQRar4ewWiTYmBYh7tWLACBdOPZ8Z8q5Iw3VwsicKH7yUGw39Mu0hcMWilonwqm4OvVQ9DPtFnGssIuvECwdzc1cAJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YzD/PpBO; arc=fail smtp.client-ip=52.103.14.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxJ6vdh9gTmSaspVzRNbfmhpNWLUPjcbO5yFCpP5zbHhI+7yKxN96DyIfOAvcRvRaWfiDhzwH9ZH319PAwWpqf7pf3tLP8vxcaL+1mArakgM2qSTqiDLf2lrQnOEy7VPNpDYH+Z9uK+LLHAqqYbGnHW8OjIln4UjFgsQG3Ibb9Z9xJF44jL2ZxP2dUbDKbAmyy1lffgjlxktOCexgRt6cvaleKQ7FI6t94wRQTK5KJUVMdIocl8Z5Ogjfw3OFrBYb/ihMBPDkTEvCRDj8o3lYWojUV8BcJtDY/WYKT4QWJPsb9rCF1o/+2XIubZb8acveSAA2l0pq1wlf9X5HAvaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9trZLp3OJkIKoceb44VwXqqO4Suf+MVGbZDNhTiVos=;
 b=Iykx+mBJq87eMUOS3miL154Y/In3Bkrp5sTCHXZvR1VyOjIfnYanS1tpXjzzWm51PM4Y5ZdkdIal18m5O+4VvvQYSZ6IwoyR+JiMCp93XdxCLuGpK3XbZGc2Aahmp2GaFzKOuY68l8TtDGfufQ3r2cFGmKgvDtKPPXNVyqAC0SF73oehkuOtGw5PJKtwbvjEogdlid1yvW2c+bw0gCx1P9MH3OEfdTR/3Mk40vf8iR1Ihrzt9Mx23C6N2Ucxydvoc8Si4VLuck5v+9ha2CqB6DFsOYS+0d3WnkuYo+8LpwRSJ0LHIv1NG5EUoUK42muAuMw2WKqm7P/AV9eVRUYOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9trZLp3OJkIKoceb44VwXqqO4Suf+MVGbZDNhTiVos=;
 b=YzD/PpBO3KS65l4qFzsBE2RXW5VF3Wb2kUZ3VXBRjEj7nt6jur4w3zVbj95vxsFD0O/DBH1AZQ89aF66Wp9QLl0MLRYjduP+BjSjMlkXMlRtBV8v3eoJx2cmLiC65y0Zx8pwzKjxhS7bE/gR8VnMSx8h10XDTsPkQC8RwEfrEkm/reig7U52IYbogF1ZOSxdzPlPSq2eirM6LwCLIkBS60CwhDGuT9lvy0wm5wradHeDLk5NottlKGQRCwCgbfhzqj6d5OccwrcnvSCQy6DLPd6PjZXpJ33ADKIQ5qeeRHDwzaactHJ0fc4m44+dx42D4qgHT77hbcB3JrTHC1d2KQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9338.namprd02.prod.outlook.com (2603:10b6:510:272::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:24:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:24:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>
Subject: RE: [PATCH v3 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Topic: [PATCH v3 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Index: AQHc5816N8UGGzrbNEC1JOxCe/0MVrYW6ED9gAAQ6pA=
Date: Wed, 20 May 2026 14:24:38 +0000
Message-ID:
 <SN6PR02MB415704E5C04B753EF40E5F48D4012@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <e6e63276cca2901641ab39029e4fd3d621b1ee92.1779221799.git.me@berkoc.com>
 <20260519213450.50E611F000E9@smtp.kernel.org>
 <177928341826.371979.14701698047864220449@berkoc.com>
In-Reply-To: <177928341826.371979.14701698047864220449@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9338:EE_
x-ms-office365-filtering-correlation-id: e7dea795-4d1e-46ce-6344-08deb67b8694
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|13091999003|41001999006|8062599012|19110799012|15080799012|8060799015|31061999003|37011999003|51005399006|19101099003|10035399007|440099028|3412199025|4302099013|102099032|1602099012|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rmg3cmkwV1NiQXg2ejV1WkIvMHRRNHBienNuZ21XSCt5QlFSdFNTR1NFMkV3?=
 =?utf-8?B?OWREV0hUNGdqTnJpQkFZOXB3bFZtejhyQndNUHhyWHR4NGQ0WFlNSFQrQWtH?=
 =?utf-8?B?TmhYT1pxb3diS3NOQnJOYXE5MU8rVHE0M3JTazZvdmFORndOdnFvNzFFVkFh?=
 =?utf-8?B?T25IbElQY2NmZTQzalV2N2M2NFZReWZnTVk5MWFQTzVMMmRxVDkvQnRrUUZG?=
 =?utf-8?B?TC9tbUsxTGNtYlVPVC9VcjNTTUlkc1NaeXRlWjc4UGhpYmNRN202U1NhanhZ?=
 =?utf-8?B?TlNSVVJoNXo1bnNsT24ySWxWa1FhcG02WTNKV0ZPMnVVUlpIcFdBd3BlU1hI?=
 =?utf-8?B?YlpoSGFwRVdUOFF5N3VRZ0xHSlV6UTVPL2tqS1Y0b0MrVGdwbzR1NVQwZHJl?=
 =?utf-8?B?WUJsTTRYTGdQdjNLaU1hR0hxTElpd0NKeDJLMm41cGk2NHJjNG1hRHR2MjJq?=
 =?utf-8?B?QlpTdVZBdEFrdkM5bzdPSnBOMkl3TmJ1em5WeEE2azF5UEZKYmppcUxLdUdQ?=
 =?utf-8?B?eTNEQm1tWWpodi9ybkhtWkd1VDRBSVJPNDRoMkJCYzZXa0RyZGY5OG9ITng0?=
 =?utf-8?B?MDRKNko5SkpwSnpMZW5GUEd5dGNoVG5hdDE2VXNoZXVaaWJ2a1hEL3ZYRm40?=
 =?utf-8?B?ajNRWmhVSWxhbjRTckxBWDhZbjRzWFhYWmdHMk1TV2E2OFlyMW9LZEp3TTQ3?=
 =?utf-8?B?NHZMOFE4Nm44VHZIOEJnc052TEI3YWxBWGh6QitsSFhrcVAxakU1MVpSM2Vz?=
 =?utf-8?B?ZjhYQmh4UFhOcTJpb0cxamMwajVockdha1FCUzNjWFZVc3RrVEN2MTd4MkhY?=
 =?utf-8?B?SERMOGpweVVmUzQzenZKZ2p1ZzI2T0JPN0g5aDE4SkFCVjIxSEJSc3VwSXQz?=
 =?utf-8?B?dmdlQjErVnpJczBKWkd3TUpmK0Z1MTFZYTh1bXFUcndjNDRDb3VwMXQxd0dL?=
 =?utf-8?B?WXdUaEwzYlRrcTNJWFZvbnhWd0NGeHFwOFFsbERwNkhSNmc3eVhnT1ZYMW91?=
 =?utf-8?B?RTNDc0VTcGp6YWNDZ2FWRmk4bWlraXcwQkQ5ZHhaZzVqaWhsVnEzNmM0MU5M?=
 =?utf-8?B?dms2emJSNWZ3ZTNsRUhjVk5uZHdWM0swUG56MDRHc1NoQjBoT3RuVnBRZVhI?=
 =?utf-8?B?SnZsWUkzazlTRUhqdHprZ24wWEJWZUtYR011VTVVU0w0ak1wY1p4cHRhV1V1?=
 =?utf-8?B?SFhxV3E1eFpqNGFpaVlYK3k5TUhIVG5VWTVqWWVHYlVrNVRRR2VvQjhsSU9w?=
 =?utf-8?B?TlFtNFpPUVRNcGhGbEE3UDVWR1VTNm8wOHhZcHU2VmR2OXBpVU10ZVhoWDdO?=
 =?utf-8?B?QkR5MzRGY2hvOVhTRVBCQVZpS1BHOFJzZjgyeUUvNnhvc1BXUVVtb3E0UHZD?=
 =?utf-8?B?NTA0cktNMlJjeXZpNkdUd1o0SmYwUkpldWIzNTRMakJLU2l1blRGWXBmSjZX?=
 =?utf-8?B?K3N0MUJsZ3V1U0JNMjJHenVhOEp4NE5BcDR3SVdzVXJ3bHdCekpRbGc3dmlj?=
 =?utf-8?B?THZoUlZOZlRoMHlwWkdqaDFRa205N3V0aERlUmlzamtsQkU1S2lNQjcyRDh3?=
 =?utf-8?Q?d3mQJdOs8ljWs04nGk8bdWMXVJjv57Nd2rAHego/J3Oc6m?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0s4ZFVRcGRiQyt4bEFlQS9PTWJlSmpvQzJsYXNKZGVkdVlZMkJGa3Mrdzdo?=
 =?utf-8?B?TVNrS3o5NHZabEVobkt3R1VDS09ucmxsek13bmV1TU1NQVFzQzlaUmdxWUR4?=
 =?utf-8?B?dk9RMU5JU0h4N0MvV3d5TVFhVTNyNkQ4V3ozQzlod2FZUW94WExXRUFlR3ZR?=
 =?utf-8?B?d0JjNmtZSG1RYmJUdG92SldoanR2NWpYay9Makl2ZHQ5djNmWFQzcjdOKzBQ?=
 =?utf-8?B?SlJsZkg0aVFlV0Y2Z2RiLy9zUktlWXp4aHFucnBzc1BxSFFJWjQrOFo5SU5a?=
 =?utf-8?B?dnBDcWpobmtGWlU2Mk8yTHlOYmpBVllROGxibVI4Rk4rak4rMWE2ak5NZ2xr?=
 =?utf-8?B?TklKUURVVGFKS2tEak9PanlyNVdWNG5BVGoyaXpvNVN1UUNYeVJIQkx1dVFy?=
 =?utf-8?B?eEsvQTZXZmMzeFhjY0daWWRHbFAzSk1Yc0Vra3ZFZzhMcitUTnpCcWJtbE5h?=
 =?utf-8?B?Rm9xaXNkNXQxMVhJRzZOTG1yNEhPT090eUZTVEM3Vis5YmtlaHpsNDZ6dDJ2?=
 =?utf-8?B?SGJHb2loWE12a0xEZnAxdGtCNWExQkFicFl2RVhwVDdTUDN1UW9uQ1Frdjdp?=
 =?utf-8?B?N21odi9Ca3kxcGxPVnppQnU5U0UvQ0VXblU3MU00Vk5uZWlDdkFYemV3UWJB?=
 =?utf-8?B?SXhKRlBWdzlJUzVCTkhKcGZQeDBxOWpsUGNGcnlrSlMwdG1yVlJtY0QxYjg5?=
 =?utf-8?B?MDNIUTFaWXJGdkt4N2o3N3cwd2tiRGg3aWNiaHBTbHlxOGNnZHNXZ0hPTUQy?=
 =?utf-8?B?Y0picVk2V09obys2MzkvSStySjVvaTFuN2l1V1Yza1ArY2xyK3dpNjcvL2ZS?=
 =?utf-8?B?M2xxZmJrM0RTQWJvRlh3RDBRWEZyUzRVQnJCYzM0ZGRQMTRSYVJvY3VIVlpT?=
 =?utf-8?B?eUhUOFl3b1l5WUI3YllsT1gydFZqaGNRbDh3N0hVMnk2TXZKNTNCc1g1bUQy?=
 =?utf-8?B?dmJaL0p0KzA5alQ2eDV5UW1tSkVBSTJ3Z3BNK0dMM21YWVFHa3k2VVpVZkl4?=
 =?utf-8?B?bXprNVd2VVBIdGVOcFJHcmpBa0tNY0dJMTFxK3JTcmE0TGtIekVqUGh0N0dG?=
 =?utf-8?B?cldJWjZ0R3BXVEJvZjlZK2RwR3A1RnZLTjU2OUxpVCszSmtiM1RoTGQxanpZ?=
 =?utf-8?B?akpHUENrNzE1WG5Sa0dGWnN1SHpYd0NLRnFkMHBOTDlRQU9USEt4eHdKRUdF?=
 =?utf-8?B?NFBWZVA5VWQzWERyeDIrVHpmdi9PVzVrUGg1UXdHV3E3T1B6aUd3WkFEM28v?=
 =?utf-8?B?NkN6ZE9zaGNhSzZoNExxMmZmZ3lkNTdBUmlVT0VlVzIvWk9iR29HMnIrdk1m?=
 =?utf-8?B?bHUyZG9mYWUyaTlWVW11NUtlM1ZLYVpqb2o5bGRTWkhSTUwvQjE4NmlGSzFx?=
 =?utf-8?B?SytnQ0hEMWtZN1VCOTlUK0JrZVV2aTkrdEJIb1BUTzdSNm9jMTlWVzBVQWk0?=
 =?utf-8?B?ZWNVK1pxKzMyWDFRZ3VLck5OMWk4ZEtydk95WmVFR1dwTW0zdm1OYmlwcWRV?=
 =?utf-8?B?OEthQkdETDlyQWtvY0xUd1hvVS8vY1NhWklQN0FFZ1pzcGFxK2tBY1V2NlJB?=
 =?utf-8?B?MW1lZnVqY1FHcUI5SklpbHgrVVZUa0IzSTlFTGFvdXNQbDBSYnlXWjJKQTEr?=
 =?utf-8?B?bWlRYmZLQmFqZ0RyRFFROXVoTHU0MXBycUpvcCt2QldJb2tRd3Q4U3VxeXM2?=
 =?utf-8?B?eUxuNVB2aUc0dklhWUNtNTJtazQxQ1JjeThIME5NS0p4eWZVVi9QMjdrVEZO?=
 =?utf-8?B?MzVqdmFVRDZzcWI3OU9NN1NiYmN3cFlnSnFVZ2duRHhiNXc4S0RBaERYRThl?=
 =?utf-8?Q?YotjaHPleCbb1SML7ncFVn1V0dFoO/ZaOmQG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dea795-4d1e-46ce-6344-08deb67b8694
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 14:24:38.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9338
X-Spamd-Result: default: False [6.44 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11055-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com,lists.linux.dev];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,outlook.com:dkim]
X-Rspamd-Queue-Id: CBF1158FAE8
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

RnJvbTogQmVya2FudCBLb2MgPG1lQGJlcmtvYy5jb20+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIw
LCAyMDI2IDY6MjQgQU0NCj4gDQo+IHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+ID4g
LSBbQ3JpdGljYWxdIFVzaW5nIGBieXRlc19yZWN2ZGAgZm9yIGBtZW1jcHkoKWAgd2l0aG91dCBj
aGVja2luZw0KPiA+ICAgYHZtYnVzX3JlY3ZwYWNrZXQoKWAgcmV0dXJuIHZhbHVlIGxlYWRzIHRv
IGEgbWFzc2l2ZSBoZWFwIGJ1ZmZlcg0KPiA+ICAgb3ZlcmZsb3cuDQo+IA0KPiBUaGlzIG9uZSBp
cyBib3VuZGVkIG9uIHRoaXMgY2hhbm5lbC4gaHlwZXJ2X2Nvbm5lY3RfdnNwKCkgY2FsbHMNCj4g
dm1idXNfb3BlbigpIHdpdGhvdXQgc2V0dGluZyBtYXhfcGt0X3NpemUsIHNvIHRoZSBpbmJvdW5k
IHJpbmcgdXNlcw0KPiBWTUJVU19ERUZBVUxUX01BWF9QS1RfU0laRSAoNDA5NikgYW5kIGh2X3Br
dF9pdGVyX2ZpcnN0KCkgY2xhbXBzIHRoZQ0KPiBwYWNrZXQgbGVuZ3RoIHRvIHBrdF9idWZmZXJf
c2l6ZS4gYnl0ZXNfcmVjdmQgdGhlcmVmb3JlIGNhbm5vdCBleGNlZWQNCj4gNDA5Niwgd2VsbCB1
bmRlciB0aGUgMTYgS2lCIHJlY3ZfYnVmIGFuZCBpbml0X2J1ZiwgYW5kDQo+IHZtYnVzX3JlY3Zw
YWNrZXQoKSBkb2VzIG5vdCByZXR1cm4gLUVOT0JVRlMgaGVyZSwgc28gdGhlIG1lbWNweSBsZW5n
dGgNCj4gc3RheXMgYm91bmRlZC4NCg0KQWN0dWFsbHksIHRoZSBiZWhhdmlvciBvZiB2bWJ1c19y
ZWN2cGFja2V0KCkgaXMgbW9yZSBzdWJ0bGUsDQphbmQgdGhlIHByb2JsZW0gcG9pbnRlZCBvdXQg
YnkgU2FzaGlrbyBBSSBpcyByZWFsLiBJIGhhZCBmb3Jnb3R0ZW4NCmFib3V0IHRoaXMgc3VidGxl
IGJlaGF2aW9yIGluIG15IGZpcnN0IHJlcGx5IHRvIHlvdSBvbiB0aGlzIHRvcGljLiA6LSgNCg0K
VGhlIGluY29taW5nIG1lc3NhZ2UgZnJvbSBIeXBlci1WIGhhcyBhIGxlbmd0aCBlbmNvZGVkIGlu
IGl0Lg0KaHZfcmluZ2J1ZmZlcl9yZWFkKCkgZ2V0cyB0aGF0IG1lc3NhZ2UgbGVuZ3RoLCBhbmQg
aWYgaXQgaXMgbGFyZ2VyDQp0aGFuIHRoZSBidWZsZW5fcGFyYW1ldGVyLCAtRU5PQlVGUyBpcyBy
ZXR1cm5lZC4gQnV0IHRoZQ0KcmV0dXJuZWQgYnVmZmVyX2FjdHVhbF9sZW4gaXMgYWxzbyBzZXQg
dG8gdGhlIGluY29taW5nIG1lc3NhZ2UNCmxlbmd0aCBwcm92aWRlZCBieSBIeXBlci1WLiBUaGlz
IGFsbG93cyB0aGUgY2FsbGVyIHRvIHJlYWxpemUNCml0IGRpZG4ndCBwcm92aWRlIGVub3VnaCBi
dWZmZXIgc3BhY2UsIGFuZCBhbHNvIHRlbGxzIGl0IGhvdyBtdWNoDQpidWZmZXIgc3BhY2UgaXMg
bmVlZGVkLiBodl9wY2lfb25jaGFubmVsY2FsbGJhY2soKSB1c2VzDQp0aGlzIGZ1bmN0aW9uYWxp
dHkgdG8gcmV0cnkgdGhlIHJlY2VpdmUgb3BlcmF0aW9uIHdpdGggYSBsYXJnZXINCmJ1ZmZlci4g
SSB0aGluayBhbGwgdGhlIG90aGVyIGNhbGxlcnMganVzdCB0cmVhdCAtRU5PQlVGUyBhcyBhDQpm
YXRhbCBlcnJvciwgd2hpY2ggaXMgYWxzbyBmaW5lLg0KDQo+IA0KPiBJIHdpbGwgc3RpbGwgZ2F0
ZSB0aGUgZGlzcGF0Y2ggb24gYSBzdWNjZXNzZnVsIHZtYnVzX3JlY3ZwYWNrZXQoKQ0KPiByZXR1
cm4gaW4gdGhlIG5leHQgcmV2aXNpb24sIGFzIGRlZmVuc2UgaW4gZGVwdGgsIHNvIHRoZSBib3Vu
ZCBpcw0KPiBsb2NhbCBpbnN0ZWFkIG9mIHJlbHlpbmcgb24gdGhlIHJpbmcgY2xhbXAuDQoNCklu
ZGVlZCwgdGhlIGVycm9yIGNoZWNrIGlzIG5lZWRlZCwgYW5kIGl0J3Mgbm90IGp1c3QgZGVmZW5z
ZSBpbiBkZXB0aC4NCg0KPiANCj4gPiAtIFtIaWdoXSBTdHJpY3Qgc2l6ZW9mKCkgdmFsaWRhdGlv
biBpbmNvcnJlY3RseSByZWplY3RzDQo+ID4gICBkeW5hbWljYWxseS1zaXplZCBTWU5USFZJRF9S
RVNPTFVUSU9OX1JFU1BPTlNFIHBhY2tldHMuDQo+IA0KPiBBZ3JlZWQuIFRoZSByZXNwb25zZSBj
YXJyaWVzIHJlc29sdXRpb25fY291bnQgZW50cmllcywgbm90IHRoZSBmdWxsDQo+IFNZTlRIVklE
X01BWF9SRVNPTFVUSU9OX0NPVU5UIGFycmF5LCBzbyBjaGVja2luZyBhZ2FpbnN0DQo+IHNpemVv
ZihzdHJ1Y3Qgc3ludGh2aWRfc3VwcG9ydGVkX3Jlc29sdXRpb25fcmVzcCkgaXMgdG9vIHN0cmlj
dC4gVGhlDQo+IG5leHQgcmV2aXNpb24gdmFsaWRhdGVzIHRoZSBmaXhlZCBwcmVmaXgsIHJlYWRz
IGFuZCBib3VuZHMNCj4gcmVzb2x1dGlvbl9jb3VudCwgdGhlbiByZXF1aXJlcyBvbmx5IHRoZSBj
b3VudC1zaXplZCBhcnJheS4NCg0KT0ssIGdvb2QuDQoNCj4gDQo+ID4gLSBbSGlnaF0gQ29uY3Vy
cmVudCBsb2NrbGVzcyB3cml0ZSB0byBgaHYtPmluaXRfYnVmYCBmcm9tIFZNQnVzDQo+ID4gICBj
YWxsYmFjayBhbGxvd3MgYSBtYWxpY2lvdXMgaG9zdCB0byBvdmVyd3JpdGUgZGF0YSB3aGlsZSB0
aGUgZ3Vlc3QNCj4gPiAgIGlzIHZhbGlkYXRpbmcgaXQuDQoNCkkgZG9uJ3QgdGhpbmsgdGhpcyBh
Y3R1YWxseSBoYXBwZW5zLiBJbiBodl9wa3RfaXRlcl9maXJzdCgpLCB0aGUgbWVzc2FnZQ0KaXMg
Y29waWVkIG91dCBvZiB0aGUgcmluZyBidWZmZXIgaW50byBhIHRlbXBvcmFyeSBidWZmZXIgdGhh
dCBpcyBub3QNCmV4cGxpY2l0bHkgc2hhcmVkIHdpdGggdGhlIGhvc3QuIFRoaXMgdGVtcG9yYXJ5
IGNvcHkgcHJldmVudHMgYQ0KbWFsaWNpb3VzIGhvc3QgZnJvbSBtb2RpZnlpbmcgdGhlIGRhdGEg
d2hpbGUgdGhlIGd1ZXN0IGlzIHZhbGlkYXRpbmcgaXQuDQoNCj4gPiAtIFtIaWdoXSBNaXNzaW5n
IGByZWluaXRfY29tcGxldGlvbigpYCBiZWZvcmUgcmV1c2luZyB0aGUgc2hhcmVkDQo+ID4gICBg
aHYtPndhaXRgIGNvbXBsZXRpb24gb2JqZWN0Lg0KPiANCj4gQm90aCBwcmUtZXhpc3RpbmcuIE9u
IHYyIE1pY2hhZWwgS2VsbGV5IHN1Z2dlc3RlZCBzcGxpdHRpbmcgdGhlDQo+IGNvbXBsZXRpb24g
cmVpbml0IGludG8gYSBzZXBhcmF0ZSBwYXRjaCBvbiB0aGUgcmVzdW1lIHBhdGguIFRoZQ0KPiBp
bml0X2J1ZiByZXVzZSBzaXRzIGluIHRoZSBzYW1lIGFyZWEsIHNvIEkgcGxhbiB0byBzZW5kIHRo
ZSByZWluaXQgYW5kDQo+IHRoZSByZWxhdGVkIHJlc3BvbnNlLXR5cGUgaGFuZGxpbmcgYXMgYSBz
ZXBhcmF0ZSBmb2xsb3ctdXAgcmF0aGVyIHRoYW4NCj4gZm9sZCB0aGVtIGludG8gdGhpcyBzaXpl
LXZhbGlkYXRpb24gY2hhbmdlLg0KDQpIYW5kbGluZyBhIHRpbWVvdXQsIGFuZCB0aGVuIHRoZSBo
b3N0IHByb3ZpZGluZyBhIGJlbGF0ZWQgcmVzcG9uc2UNCmlzIGEgcmVhbGx5IG1lc3N5IHByb2Js
ZW0uIFRoZXJlJ3Mgc29tZSBtZWNoYW5pc20gdXNpbmcgcmVxdWVzdCBJRHMNCmluIGh2X3Jpbmdi
dWZmZXJfd3JpdGUoKSBhbmQgdm1idXNfc2VuZHBhY2tldF9nZXRpZCgpIHRvIGhlbHAgbWF0Y2gN
CnVwIHJlcXVlc3RzIGFuZCByZXNwb25zZXMsIGJ1dCBteSByZWNvbGxlY3Rpb24gaXMgdGhhdCBl
dmVuIHRoaXMNCmV4dHJhIG1hY2hpbmVyeSBpcyBub3QgMTAwJSBmb29scHJvb2YuIFlvdSBtYXkg
b3IgbWF5IG5vdCB3YW50DQp0byBnbyBkb3duIHRoZSBwYXRoIG9mIHRyeWluZyB0byBmaXggaXQu
IDotKQ0KCQ0KQSBwcm9jZXNzIGNvbW1lbnQ6ICBUaGUgZW1haWxzIGZvciB2MiBhbmQgdjMgb2Yg
eW91ciBwYXRjaCBzZXQNCmFyZSBiZWluZyB0aHJlYWRlZCBpbiBhbiB1bmV4cGVjdGVkIHdheS4g
VGhleSBhcmUgc2hvd2luZyB1cA0KYXMgcmVwbGllcyB1bmRlciB0aGUgb3JpZ2luYWwgdjEuIFNl
ZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1oeXBlcnYvLg0KVGhlIHByZWZlcnJlZCBh
cHByb2FjaCBpcyBmb3IgZWFjaCB2ZXJzaW9uIHRvIHN0YXJ0IGEgbmV3IGVtYWlsDQp0aHJlYWQu
IFRoZSBjb3ZlciBsZXR0ZXIgc2hvdWxkIHN0YXJ0IHRoZSBuZXcgdGhyZWFkLCBhbmQgdGhlDQpw
YXRjaGVzIHNob3VsZCBzaG93IHVwIGFzIHRocmVhZGVkIHVuZGVyIHRoZSBjb3ZlciBsZXR0ZXIu
DQoNCkFsc28sIGRvbid0IHBvc3QgYSBuZXcgdmVyc2lvbiBtb3JlIGZyZXF1ZW50bHkgdGhhbiBl
dmVyeQ0KMjQgaG91cnMgYXQgYSBtaW5pbXVtLCBhbmQgdGhlcmUncyBubyBwcm9ibGVtIHdpdGgg
d2FpdGluZw0KMiB0byAzIGRheXMuIFRoZSBpZGVhIGlzIHRvIGdpdmUgcGVvcGxlIGEgY2hhbmNl
IHRvIHJldmlldyBhbmQNCnByb3ZpZGUgY29tbWVudHMgc28gdGhhdCB5b3UgY2FuIGJhdGNoIGFu
eSBjaGFuZ2VzIGluDQpyZXNwb25zZSB0byB0aGUgZmVlZGJhY2suDQoNCk1pY2hhZWwNCg==

