Return-Path: <linux-hyperv+bounces-6543-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D864AB28756
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Aug 2025 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D9456453A
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Aug 2025 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C51EDA3C;
	Fri, 15 Aug 2025 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g8yXmT9F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2011.outbound.protection.outlook.com [40.92.20.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2C26AF3;
	Fri, 15 Aug 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290816; cv=fail; b=g7nxaRi1x6++9ujxQs+ylR8sElyN5jOSi/XvplrMlLmZ4dbb7xr3UtWDU3LxDrB0ifsNuoxeimI05dc/PVjwdZdkmRmFkOwDmMRpU8e5U+52DZOiHH6j+HhzvIVJ+ld+yEC7kA3FlrO3oZw/qfWHD6q4PtyctMuo5V8WfaMgbuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290816; c=relaxed/simple;
	bh=TnxK7u2qQjy3VpUchJnRDBzW41oNWTiySSquJbzV1/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m4S4cg1899r6YDOagG+6FR6Ct7Ukq6Cwmp51of1tRT3QWsrGIK4L3LsSRu1M3marUxZ2K+tX6enY+vO1+l0m+Wz1KbpJqRq7SGSVrY+zszSWQYbrlrMYZdUprlCSE2wFcT6AgbYVxd/g0ToEzEptOYIsYDZQXNdmynT+2+uvtvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g8yXmT9F; arc=fail smtp.client-ip=40.92.20.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2DJt9LnLbMaQY4eW5zfilvWJccE1o2VYICZj/po23io5vgUWA7mvkPFwwVcFKzY+ra0PyqHpQ6pQvftB3ZWl0HmeDMvNB2/xWkMawb76LHVMM6MwVSpHn/5kNg/UjpaWpObIhY8BTff2N9Uwk2dtOst7vPKYfVHHGtGySGxqmCkBumSjySQIyMfG3b/D9nr9pswF+sH3crJrKrmfNQzxBsJ+Bz06omveD+VXO+g1b3tIqqvJqmfgWGSp4cE8uOo4dhKFk5GX95LLmqC9P0i1FhyVX4DfJOZn8LAqOJgOa1yA2Sqq2vQAEZzjxccq57CdGfYfd3BDAHxIEll2C481w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnxK7u2qQjy3VpUchJnRDBzW41oNWTiySSquJbzV1/w=;
 b=MMLAUdletV+lw/xZ0/EvITPOjOpaPzbEchRGy4sG+zUcuhiC7Qi9qy23Fp159Iuq2tJBtoRx3SnvSzUz49Z7N1LKKZ4S6BvrHhJHdj5JblXbgO3N8pSb8ZSRo8C2vBQGGPdVGXrukG9Vg6U4FYalHF9AOl98Knz3aO8WR/efrPE+Dph92oV6hg3cTVvZZVzjbQJwX7aT2P0CqhYK1NFjk9AvzU5KU8tkrAz4DiYZdlGtdUAKrkplQwbRPnoyNQmg7vFfD6+jqyX2newm1iMbuTvexy7GUqbAS+piTYW4uQZhNQTnQqHY0AVxByknbxeqRMc/idmQ1WCFyXMI1BWSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnxK7u2qQjy3VpUchJnRDBzW41oNWTiySSquJbzV1/w=;
 b=g8yXmT9FDfpSjvocL3kp2dA4sGCGpTgJSzLIp2cDWO2ZAR4WZS1soOBKS9Bq7A/ZFx+llrEl564n3NoLV2kreLHIKK1pCDozlnuSmkKISG73Rd1xJTGkPmd8sOQc3EOLa75N0XBeHyD/2aIxchcLUsi+evx2RjuSEgjAydkb6TmFYXM398JwAshSXTP3xVPGM/dWKB+humZhqqqiwCRKs0XkrpSgYfm7uI3L2HOIN2tcwGBDeqWbtRHsV5q7sjb3eacUour6aC8EvmUHF87y8/iTq3ZmlEPIO1jjvO4iXUxpoxyNjNkUXucOSdMo58ZCMv3Fi5YpHwhv7FYer0+28g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH8PR02MB10945.namprd02.prod.outlook.com (2603:10b6:610:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 20:46:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 20:46:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Wei Liu
	<wei.liu@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] hyperv: Add missing field to
 hv_output_map_device_interrupt
Thread-Topic: [PATCH] hyperv: Add missing field to
 hv_output_map_device_interrupt
Thread-Index: AQHcDH8HLgAqmBHbDkC3QPVdLVk9zrRifxMQgAApYgCAAU3DgIAAO/Pw
Date: Fri, 15 Aug 2025 20:46:52 +0000
Message-ID:
 <SN6PR02MB4157822A214FB16274317457D434A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157B75073B1E6ACDB6405C1D435A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aJ5SOFR8HNqPxBKN@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <4ebde68b-1e39-4650-9f57-500843fa8aea@linux.microsoft.com>
In-Reply-To: <4ebde68b-1e39-4650-9f57-500843fa8aea@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH8PR02MB10945:EE_
x-ms-office365-filtering-correlation-id: 951e8ab9-810f-401e-396e-08dddc3cdd82
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc43FlQvP2yewYSt45NTkBZ+tb0QS5FOldYWYMcvSL8FxbXATOL80TeAN3OUD/CAF6b6DgvrHT2jWTc+EWjSRS2cEAwNAAmMnrOs8IY1zDqLRvHIvmVE27uNq/yY3MkhIELFS6MnIV3xhBU08R124KvEASptuzct/HTAeOv9YA9OPE4VFbtj7Ade4OApUlpmDX6gNwQSG61tmH4GFISZtScMrwRsIYi1qAisgYaUe/eAR2vfOxnQaOqOnEmUXrm8lq5e/rNII59okGrirLTADAegrxqy7NUNv7th/0Pb93E+MIZm7FpJUrkakPDW0s+JuW2w8YktwhAkrUr00dO4gp3cFNkUbuEqp/EvQ0Jbb771TR/o/PK5b45zWGvHvC9gMqYAQlK5hHQvvTSX/PLiSzVtXQ5g27FFygeW+ipcOtx58f4RSOfnsyYSSpEW1HU+rhkhGwcYRNRG41IgiiuXasulsl2PhNFcG3xhjZaAoGCQaKJhA9c3OWHLyS/UyApJgvkCcBFuzAfLwQsFeCfEYhymAeUFXVFGGeeuG27FU+MBW+ZVDUr4bnE4MWtJ7yjOYgsZYNe6MrxavzqFxi/ChK7kxk/h26mNxzT9cMnDsjdEbZlFhBjlYauXyEmJ0egiKl21pMzc7cJYN382zkoXkFD3gp7U1a/NH0LEkINlh5NOHiNPyJSSvDm3GvOtpPZRwILsuApFaoCjBzW0PWTWhZFhUMLlWIhHLrcqPwOME1l5nYFiZ9EGJeP
x-microsoft-antispam:
 BCL:0;ARA:14566002|21061999006|19110799012|8062599012|8060799015|15080799012|13091999003|461199028|31061999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2Y2WGhrTVZFbDkrTCtudWRmWTVCRGh4NWk2KzlhTkVnUzh6dTBrNkJQVk0v?=
 =?utf-8?B?U295MDF2SG1uZmdPcGpNa1kzc0Rxa2duZGhuNXJjVERidFF5NkxMbXVsQksx?=
 =?utf-8?B?NUN1NWswaVV2cUZhS0orUlFoeisvTUJsVG9KSTdKbHREZkIyVk52SlZiTHlC?=
 =?utf-8?B?NUROdGFYaXU2ZCtJbEJnSE1nVTNnbGJNb0EzUDJOQUx6WjY4ZEZ0UUg3akl1?=
 =?utf-8?B?Y0syUDg2bWh0S1E0K1BJcUxoem9GVWo4M2VmemdRcjdJK3JPZ21VeDNSYjNp?=
 =?utf-8?B?VTdKVjM5TlY2OEF5amUzUlkyUzF5ZkFVMGZuK3d5KzgwQ3hyby95S2lMa2pR?=
 =?utf-8?B?TDZOODdtOEViVnBZdjFxQkRNWFo2a2dTTzRHZ05mMHN1a2tsTmM1dFh1VDVP?=
 =?utf-8?B?MVB6UXJtS3huUS92VjRmTTBZSGxmZVN2NFhlTTZvRDdDSkoxazFBeE80NjQ4?=
 =?utf-8?B?OUk3OGRxUWNrV0k3UWVDSGtmYVN2VVdsN04yZThlaitrUGhDdVBMR0FTZThG?=
 =?utf-8?B?SlNVbjkrSnpIVmZvMUwrMWpOZGFyK1BSejhPWWhkL0gyc3dESHdVbFpYRTZN?=
 =?utf-8?B?VHRjVWFnRlRiUG03RTZwL0grekRWeGMzbVJsc3picU9rUzZpcHJGcHVKQlNw?=
 =?utf-8?B?SUhoZ2d0b2NBdkdDeis4SmFOeWhYTUJDWXB5YXQ4c2x6T2dSNk9CbDM4dHlK?=
 =?utf-8?B?aHVYN0JaT1dYR3MvSVNFK2I4YVlOYU1sOHYwQWNRYi95ZFE0ME9wRlFJMmFh?=
 =?utf-8?B?NGJEQ211Tmh4d3ZrMjh3VEdPOG1FZisvMEs5R0JjZTVodCtUYjZWMTAxOVBD?=
 =?utf-8?B?azhpZUV6S1BkWmV1TTlQbXZzV0ZTTVFiV1BaOGxCcCsvQWV1NWFlbk8vY0to?=
 =?utf-8?B?cFdLdlR3Mnp5bkFZTklPVWhDVFVuZThRVWZtcVBDL2tiWVhHU3JINlg4OWsw?=
 =?utf-8?B?ZUlLaUp1MVBXdkgybzk4WnVNWnNZWkVIaG1OMkZuVlFGTkZVVkpJdmVzNGJT?=
 =?utf-8?B?ZE1BMWc3MEpET2M3ZWJkazd2S2dMTm1wOHFTaVZyeTdvcFRUMUtuWDFISkEy?=
 =?utf-8?B?b0tXZ2RBTGFCbTBDeXZob0crVVl1YWhGTkdkYzF1M2tXY1pjTDNVZEQ5clU3?=
 =?utf-8?B?MWNRYUhqT1Naei91cmkvb285UVcxVERMTVRQeGJRU0RQZWJmOGF3Q2JoNXNU?=
 =?utf-8?B?SVdhcVFtd296a3c5ZGRVQ0JTK25VNEpkdzduenVjS2gxblliVHRRaWdhSS9K?=
 =?utf-8?B?cGw0a1hOT3ZqZGxIQ1kwbEJ0cXNGblluSEF1SVFEVHhwMmNjTlZTSk1mUHl1?=
 =?utf-8?B?cnplRXBzWHA1dGd1Si9oZU5kMUJUTHBqUXBLTk1Ddmd2T1RhaTgxeG5yS3hH?=
 =?utf-8?B?NXRnckZ3ZVpqOXBJZWphUVoyclZrSEtLTmVCaUsrWWtqKzlsZCtDaWNGTzEv?=
 =?utf-8?B?RDFROGtubytrSm1UOTkxZXowUUJVcUNSN2gvanpUbFk3M2tsUGNiSWlTUW5o?=
 =?utf-8?B?bERQaldRUkNENVpYaWtsQ3dlbkM3MnhmYUFrd2xOMVFjanQ2aWRGRHMyeTYz?=
 =?utf-8?B?R29GK1dyZHphTWEzWG5vTnNCYUQvdnRDYUUyMHh1eDRsRDFZVWxNaUMxYmt4?=
 =?utf-8?B?TEQrNnRDT2xXZEFOOFFNekFnU1JrN3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1ZvUnVJb1IrWGtZWmVIQzBENmlzbk9PM3lLbHc5VEFvNXNTbG5BOSttR0J3?=
 =?utf-8?B?WisvSXUycXU4L2pzVlgwUzEvUEcyZXJXMElLN0o3ejN3SWFVam0wNnJVeXFW?=
 =?utf-8?B?cWZuNnFWVHd5WHg1SmZ5cDA3NEhzanZqSWhiS3pUMWdyUVlNZ2dhWVhYTWRL?=
 =?utf-8?B?dzFVMk5HK29WOGU4SEpjUzFNR0lHN3J6aDBIbHNrc205QklxQ0w2cGo4eTZj?=
 =?utf-8?B?OWlmYU9XR0FnK3VqVjFCVkp3UEFGZ0lkeTVqa1J6TmVVRm9JbFdFN1lpbGM4?=
 =?utf-8?B?YklLUzlwMU9JR29YVmRwY0JXRmplWGdyNWZvdlJXMDFqVEVXYmtvNUlVcHBi?=
 =?utf-8?B?NVpEVjI4dTMxK2sxQjhnaUpzOUh1M0FEYWhTdVp6ZjJNQXVQbUo5THIzdFpk?=
 =?utf-8?B?QjNDTSs5Tm1ZUW9iQk1aWlBvaFZkbkZsZndSMXNmYW05Qm43OEZjRkxrR2xU?=
 =?utf-8?B?Q1dhY1FkTUh0MTZTUlhzOVExeW5XdE1KdVZmTWJsU2hCbjdDTGRpb1d6TElJ?=
 =?utf-8?B?Z21vWXVNZEgyODRCekdRczIvNkxQQVBQVGFsWTFzV0ZQeGs5cXZ4VTI1Q2ly?=
 =?utf-8?B?OERweVdGUWo3blFIZjE1Z0d5emJVdTdMbzJJRHF0K0dQNFl1QWpGT214WlVl?=
 =?utf-8?B?emUzWHR4TmJJNkxtNjEvVi9xWFdRNGxmMEo4dDUyV2dVKzB3VVJlTWlGbHZ0?=
 =?utf-8?B?cFpuOVNnM3pBTVBmejRkTnA2eDZGWXZjSWtMazMraHJFbW1jMHg5Wm1welpP?=
 =?utf-8?B?a2lBNkczWXF2bE41bTlzVlpzck15N2NKZjROU29TOGxPSDk0SjFkWkp4M2lC?=
 =?utf-8?B?UnVRbDRXRXdqbHdPam93Y2VsR2hsaXBXTXJyT3hNS1h5bDhoOUNpZjB5bGQ4?=
 =?utf-8?B?eUZ1K3BiVDZMSEo5TmROdk9kVkZ6eVVicm50V29MYm5jWDl2cWluekF5WTMw?=
 =?utf-8?B?QjVyMitMVHpLL0F3NTZMeGdZa0lZRVVGMittUGE1YkJoK1h2RHRmMGUzekRX?=
 =?utf-8?B?NHgveTUwL0pWMnY5Nk5PS2dybEE5Qkd2N1M3eS92MUFuazVTS0MvS1ZselUv?=
 =?utf-8?B?Rmxrak1ZaWNjYUQ2YThWZmNieTJITUExMHJDalUvOHVhZy9TdHB6aEFVbWRQ?=
 =?utf-8?B?eHMvbHR2N2Y1eFlkcm02QmJaZ2R2Y2hPNzhhSzgzc1d0UVdpZjJHR05rdlly?=
 =?utf-8?B?WmdWZ25rNnAxNzVTVGJrbXQ1TkFSaHJXRlVJYmxUNG1RMm10d1ptQm1XK3hm?=
 =?utf-8?B?dUV1SFdxUHRlTG12QmJuRjhBRm8xdzRVWHFMeEZaNWtTQWYyWVlXY092a0ZX?=
 =?utf-8?B?WTVQNlFGTmdDMmxwK0NWMURVSWgxVTcvRE56Y0JlQ3VBVDZtN042YlhnVmNI?=
 =?utf-8?B?bEpXVUVObUZNbHhEaC9DcW5zWS85YXVJd21FbTY2RUdNb3UrUm1mRlByYnRB?=
 =?utf-8?B?SXJaZko1eHc0RXdleXZtMGEvcFo3bHU5OUtZTFFab2Z0R2xlaWdBcVUxWnpu?=
 =?utf-8?B?dlJRdXNmOEZDKzZOVmh3TE4xRExpNzd2MHNOdEN5TTdwU1JrOUV5OTRHci81?=
 =?utf-8?B?cVNEUmg2UVZzUm4zL3Y4aVpla0lsNTQzN3kwREZCNXpncjZkKy9LTGowM1lN?=
 =?utf-8?Q?+71xNT/TqJUavfg3O5vy0FxyrxRW/1Cj6F1IW34pEcvY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 951e8ab9-810f-401e-396e-08dddc3cdd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 20:46:52.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB10945

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIEF1Z3VzdCAxNSwgMjAyNSAxMDoxMSBBTQ0KPiANCj4gT24gOC8xNC8yMDI1
IDI6MTYgUE0sIFdlaSBMaXUgd3JvdGU6DQo+ID4gT24gVGh1LCBBdWcgMTQsIDIwMjUgYXQgMDY6
NTc6MjJQTSArMDAwMCwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4+IEZyb206IE51bm8gRGFz
IE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogV2VkbmVzZGF5
LCBBdWd1c3QgMTMsIDIwMjUgMTE6MjEgQU0NCj4gPj4+DQo+ID4+PiBUaGlzIGZpZWxkIGlzIHVu
dXNlZCwgYnV0IHRoZSBjb3JyZWN0IHN0cnVjdHVyZSBzaXplIGlzIG5lZWRlZA0KPiA+Pj4gd2hl
biBjb21wdXRpbmcgdGhlIGFtb3VudCBvZiBzcGFjZSBmb3IgdGhlIG91dHB1dCBhcmd1bWVudCB0
bw0KPiA+Pj4gcmVzaWRlLCBzbyB0aGF0IGl0IGRvZXMgbm90IGNyb3NzIGEgcGFnZSBib3VuZGFy
eS4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBOdW5vIERhcyBOZXZlcyA8bnVub2Rhc25l
dmVzQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBpbmNsdWRlL2h5cGVy
di9odmhka19taW5pLmggfCAxICsNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9oeXBlcnYvaHZoZGtfbWluaS5o
IGIvaW5jbHVkZS9oeXBlcnYvaHZoZGtfbWluaS5oDQo+ID4+PiBpbmRleCA0MmU3ODc2NDU1YjUu
Ljg1OGY2YTM5MjViMyAxMDA2NDQNCj4gPj4+IC0tLSBhL2luY2x1ZGUvaHlwZXJ2L2h2aGRrX21p
bmkuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9oeXBlcnYvaHZoZGtfbWluaS5oDQo+ID4+PiBAQCAt
MzAxLDYgKzMwMSw3IEBAIHN0cnVjdCBodl9pbnB1dF9tYXBfZGV2aWNlX2ludGVycnVwdCB7DQo+
ID4+PiAgLyogSFZfT1VUUFVUX01BUF9ERVZJQ0VfSU5URVJSVVBUICovDQo+ID4+PiAgc3RydWN0
IGh2X291dHB1dF9tYXBfZGV2aWNlX2ludGVycnVwdCB7DQo+ID4+PiAgCXN0cnVjdCBodl9pbnRl
cnJ1cHRfZW50cnkgaW50ZXJydXB0X2VudHJ5Ow0KPiA+Pj4gKwl1NjQgZXh0X3N0YXR1c19kZXBy
ZWNhdGVkWzVdOw0KPiA+Pg0KPiA+PiBZb3VyIGVtYWlsIGlkZW50aWZ5aW5nIHRoZSBwcm9ibGVt
IHNhaWQgdGhhdCB3aXRob3V0IHRoaXMNCj4gPj4gY2hhbmdlLCBzdHJ1Y3QgaHZfb3V0cHV0X21h
cF9kZXZpY2VfaW50ZXJydXB0IGlzIDB4MTANCj4gPj4gYnl0ZXMgaW4gc2l6ZSwgd2hpY2ggbWF0
Y2hlcyB3aGF0IEkgY2FsY3VsYXRlIGZyb20gdGhlIGRlZmluaXRpb24uDQo+ID4+IFRoaXMgY2hh
bmdlIGFkZHMgMHgyOCBieXRlcywgbWFraW5nIHRoZSBzdHJ1Y3Qgc2l6ZSBub3cgMHgzOA0KPiA+
PiBieXRlcy4gQnV0IHlvdXIgb3RoZXIgZW1haWwgc2FpZCBIeXBlci1WIGV4cGVjdHMgdGhlIHNp
emUgdG8gYmUNCj4gPj4gMHg1OCBieXRlcy4gSXMgYXJyYXkgc2l6ZSAiNSIgY29ycmVjdCwgb3Ig
aXMgdGhlcmUgc29tZSBvdGhlcg0KPiA+PiBjYXVzZSBvZiB0aGUgZGlzY3JlcGFuY3k/DQo+ID4+
DQo+IA0KPiBBaCwgaXQgbG9va3MgbGlrZSB0aGUgKmlucHV0KiBzdHJ1Y3Qgc2l6ZSAoMHg1MCkg
cGx1cyB0aGUgc2l6ZSBvZg0KPiAxIGNwdSBiYW5rIGlzIDB4NTguIFRoZSBvdXRwdXQgc3RydWN0
IHNpemUgc2hvdWxkIGluZGVlZCBiZSAweDM4Lg0KPiANCj4gSSBnb3QgdGhlbSBtaXhlZCB1cCBz
b21laG93IHdoZW4gd3JpdGluZyB0aGUgZW1haWwuDQo+ID4NCj4gPiBGV0lXIHRoZSBhcnJheSBz
aXplIDUgaGVyZSBpcyBjb3JyZWN0Lg0KPiA+DQoNCk9LIC0tIHRoYW5rcy4gIEp1c3Qgd2FudGVk
IHRvIGJlIHN1cmUgZXZlcnl0aGluZyB3YXMgcmlnaHQuDQoNCkZXSVcsDQoNClJldmlld2VkLWJ5
OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo=

