Return-Path: <linux-hyperv+bounces-6400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D520B1202F
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1DF189BD1D
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA1202C26;
	Fri, 25 Jul 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LJfG++4+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2060.outbound.protection.outlook.com [40.92.40.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EE1E5701;
	Fri, 25 Jul 2025 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454112; cv=fail; b=MJqE5UBeUazAgqaJzrMZYAo9g8U4lVOVB9KwDNMgMSuQK5U5FJZA3tj+sqFxMAZ6ZrpBL30d7bK6sF9y/8dves9zLcQpdPzgSbVhDpJkNXN864h2pLzX5d1c4lLU77aSEztd0rkIp59wWjeVbgWRPKz+7gKEYnoq51QimDDAfMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454112; c=relaxed/simple;
	bh=s+x2KVwagMPdHmMWrgSOZTAxX+NqA+04A/BkVrj+NuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=goWvoqT9gC2QyC+4qbBWJo7xoJnRKOh7q/hK6Q9StMNCpi+Tgj9USCwOOcoFafoKdLonPvrd7O7gRXz5JxqTtdaGjVlvAxzzCBh0En6hMhTs3iSU4dVVpr3In2NKpomSLM0IEqTfKj1hNF1BfyQVXGXWVZfQsrPKWD5xDyQbPmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LJfG++4+; arc=fail smtp.client-ip=40.92.40.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJex24jFpuEmxwKukqCNBDcoOKAUR/WwCEIKVbUUNSGE/iutdpOYdOqJ8eXPFPz+Eo7t2ELiAuEAYBJs0lKzdFaO8acl3MBzc83rZG9tN9zb/WHbt6nVMvT7Z6a0adqnJIVVxFJgJgtBORmkU34n69flQ0tNxqSGsj1XeKhB/IsPI9S7rH2WFugZXDi1cRQlcjTWxDXTiZzgdXsBRgUmT4r3TlDUBQDwy1cSfL7yywef3irhEFr4QKWeE1pdY6blGP9SkJ70DOWbVDYa1gRy/85z7GuUCpgU5+Arrc2VOC/0L0AWVq8ooo/t8R3xgYb1pD5ToPsHtDGKjpsyfsyXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+x2KVwagMPdHmMWrgSOZTAxX+NqA+04A/BkVrj+NuY=;
 b=N0eyGE61eamg397P08UPBReq6SYAdsAuJBMjJ/Uq8gU42/nXhrjE0J3Apk7QeZ+3xX1VztJ7dnwzPbYRzREQnYCEgO9pEoCWvlYzypwO1LcFQN1T2xFktrwNFD/Xi3P+EhE8nmAkfn0PwVi+UiiaceXoJRqdO/YY/O01Fw8U12YovhSvlowrARzHvo8hCcKtY9RYwZVkSZizVPnmnDgwvUFV9cSxa/pzb9iaa8Xlc/oZ+Dvax6GXkK218htlbhEjqxFrbGPtO6eyemSUCJYf0vQGLikxkd3YF2FjQ4gYJJdb+4ufdyFEjQGCj3NZSRl1zG9MuhMjmIIQWvhYD9xg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+x2KVwagMPdHmMWrgSOZTAxX+NqA+04A/BkVrj+NuY=;
 b=LJfG++4+f6ExTgE4Ts/uMdjxvN9HGUvLAtreFsX9pD+VkiDfK8xaByNXet0zpsqsDEWSZv+3tlLC+iv2JSWL04BK+wVxyhxJL7vb8XGnxZOR5doaKNf5SHnzdzYa1LnnP74PIxGNIolq81qfmk+Pii2aGLkXvhX64Xm77s1k3mM//0CatX/GHj4kahMAHczPfelt+L4spzgGEM9aYvoc+x4DVGg33wFczixuNDTk8p1LeCp3k/z9LjUIDE+zeXcuT9J5OsIpt15QZ51FuFNuX76bFXkkVkwxmu3BWIHm+5MjaouIu+8ZPneOaYwUKXR2sfq//+r2AIIZ4WClQYCLbA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8787.namprd02.prod.outlook.com (2603:10b6:303:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 14:35:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 14:35:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Markus Elfring <Markus.Elfring@web.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHb/HScy3plG5a+z0miuAOMHd2V/bRCBVDwgABS5wCAAI7MwA==
Date: Fri, 25 Jul 2025 14:35:06 +0000
Message-ID:
 <SN6PR02MB41579F474B6FC43D4E5754CDD459A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <20250724082547.195235-3-namjain@linux.microsoft.com>
 <SN6PR02MB41571331AF61BE197F76B970D459A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <03c90b7d-e9b8-4f8f-9267-c273791077c2@linux.microsoft.com>
In-Reply-To: <03c90b7d-e9b8-4f8f-9267-c273791077c2@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8787:EE_
x-ms-office365-filtering-correlation-id: 9c413e4e-43d6-44dc-67f0-08ddcb88733f
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799012|461199028|8062599012|15080799012|8060799015|3412199025|40105399003|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wmp6ZkJyMm9oZ016R05oYmZNVTExSzlFVnB5ZlZMdm9BS29sVUM0RzNwSE9m?=
 =?utf-8?B?SmozbkFQd3BFUUlHemU1WFFOcENYb2I2N2lnZThHcUtNSWtSSTFxQUZORmdM?=
 =?utf-8?B?bTErbDRuTUlDbXptN2wvelh3NHZiSzZrZW10dFJRMTlReVBMeTB4cDk0UlBm?=
 =?utf-8?B?RUpBdlJUQjhLYlptOWcxNUFFZEluNTFkT1BJdklxSEFJQnRYb1FEUzkxQXZy?=
 =?utf-8?B?RFNzR1d2MVloYzBPeENlTFZsT3p1aEV4bExjTXhRNGR5SXZwOXJVMVhBYjg0?=
 =?utf-8?B?ZnBZZEt2eUZEN21TSTgrUEVtcmFoTGxla1RleTd4SmxiQTVwcHBSczhFZmZ5?=
 =?utf-8?B?cEFXcEt6YnJaejB3YXdhRnM1ZE50clMxcGNEeTY3a1J5VlVvUzRkZDI3MDd4?=
 =?utf-8?B?Mnd3RGFBUmN1QTI4ZWxpMmY3UFlCaWZGV2t2WXZWSjNNeWdneUI3VWFTdWVT?=
 =?utf-8?B?V3NJWkR2VUVTVTJsWGVVUEJsbzZRNmVRWUJ6QjZFSURDeGJua21Ealp5ZUpM?=
 =?utf-8?B?eE1Gck16U2RkcXhBeFkxWDZaMmRXeE5Hbi84cVZDSGFOQUxnRVhwVUpkeity?=
 =?utf-8?B?T0dVYTdlaDJlVWp1UVVuRFI3aGdlUEwzTit5dmNlWktLRlI3VXRCM3dWUnlK?=
 =?utf-8?B?ZVFzL0hONkVQUDUzeTNZUmZycjQ1Ym9CUTI5QTN4RXlDOXFBRUZiTjY3SGVY?=
 =?utf-8?B?RUVFdXVaWGp1YWdjaDdFVWkrTWdaYkVibVlwVTdRU0IxTWJ4cWVFK0FtdjUr?=
 =?utf-8?B?TytXMk5WdUhPbHQ2UzJCOU9UM3djMTNIbzJRSllHQUNqZXYvOXlpN01yb0ps?=
 =?utf-8?B?S3ZYcUdjV0NaNzc1aXJ6WHp5K0tlRVdCNE5rQUtCdTEyRmtIQzVxSEExRk5K?=
 =?utf-8?B?THFHWTF1WXp1ajVHZVc5OGhDR2RtY0JNWHRnWkFidlVDaDhmM2pWbzFNQllu?=
 =?utf-8?B?ZTNVZGxzMW9EV1FLYWo4aGljTTlUdnE5TmhwWHNKMW9EYWVIdlg5M0RVTWI2?=
 =?utf-8?B?Y09Ic1lCdlFBRWdSWnliMEt4Zkc5ZFhBNUttVmd0NjdXbjV0YzVhcjM3M0pG?=
 =?utf-8?B?VDRYZFZuWHphUnlMUUJwVnl4a0tFc1dRcUJCK3kvbnlnWDcxZ3pLaGpGSzFh?=
 =?utf-8?B?SkJvVXo5b1ZITmJUQ2k3OTZYTWlTVjZjTmFkTExiMkxwcUlxQnVOdmdVU0c1?=
 =?utf-8?B?akFJOEZ5aTRjNXZXYm1zbmdLRXlnVU1UUGJhd29lSUwzM1pxNkFheEhpcTVm?=
 =?utf-8?B?OUxKMytTeFRjYVhEQ25zTzRjM3lUdTdWUmtNS29paEtBK1MyZTJtMGtJWHZi?=
 =?utf-8?B?dGhVbEVxR01lcEdWc3JacVB5OFVCV2dsSXhhN3paOVNTRUNSUlVXRU9aY0RR?=
 =?utf-8?B?MzZoZVcvcS9IWm5GQ3M0OGQ3dU15K0tJTkVDOFlHZkFzQU1NYnhVR2VUUzRv?=
 =?utf-8?B?MHVvMk83bDhoK1dSK0FJUEg4VXFvZlJYY1ZMeXhSL3NvaHpQYnlTZEJWS2pX?=
 =?utf-8?B?UWtiTkxJNWRVVFFJZVQyRjNJTkJaTUExKzkwdS92SjdxbmVHYzI4Q0JSZlBY?=
 =?utf-8?Q?WZsysQkvgDJ+akvz3i7Tqt2XdqqvNIjeR/10ARHASUr8cH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFA4K3p4V1l0dDI4S3NKUGpJUWhVbU9KR0FNRmMrTkZsWGl3TUNoa0tES2RK?=
 =?utf-8?B?VXY5anhBVDN5TU9QcUI4SlJuQ3IwQVVicm5DRnhpZVU2N2d0TEQ2WDg4aWxm?=
 =?utf-8?B?T2RLMk45aVNNUHZoRVg5M0wzZ05FV25UR2dwVHp5Y0FMUDNTUGhvT0hXWkxJ?=
 =?utf-8?B?K294RW9YNGkzL3FkL2F0UVk5RVl1aVdIaSsyWDR3Rm5jR2duMFk5Wndaalc0?=
 =?utf-8?B?MmYrQ211LzhSYXNFT0lLbE5SR2lBblA1a3FMekxTRUE5WStrR3FrK1FPSjFk?=
 =?utf-8?B?VThoMjc5MG9NNCt2UFJsYkRRWWRNRWNxNWFPUVllN2pnSmsyanJTbVVFZHVi?=
 =?utf-8?B?M3JnZmpzUWI2cU5QY0NRT2ZOT0FkSFk0WDgvWkJGZjJFZ0kvK2Z1U3ZENG9j?=
 =?utf-8?B?cEZFVlloK1JiZ3cyMm9QWkh5MHhZdHNmT1YzVHBWRlUxYTJuUld0WFJJZFBp?=
 =?utf-8?B?d3RMQ2pDSmV4ZWRZUGZHVEdIOHF4OWMyK2QrdGxqb0hQTXFKNXpJTTdFdDBE?=
 =?utf-8?B?VFB6SC91RjFpdjJOVllPdEQ2dGl5bjdPTnB1eUJqL0NvOWZsVW8xQ2N0QnZ6?=
 =?utf-8?B?MDhLNmNaaTdvUFRyeWsxUm1ZQ21pOUpuRXhnMm5yMHJYc0UwRXBHaHByRnl4?=
 =?utf-8?B?dTJhSmNhWEFsUDBsNzJIOVFhYmJVSS9BRUVjMzVRd1JPSHlpM1poT29UUnhq?=
 =?utf-8?B?TGttZmkvVDVPT2pOeStwRkJVbHJjR3YwNEo1clJzZ1B3bzJBMHJvRUVWU0hm?=
 =?utf-8?B?WkdSVmRmTlZhV3BvQURKK2IvY3ZjUHlRS29lMWhxeFB0RjEzbDdzNkd1QUNQ?=
 =?utf-8?B?Yjg0UGVuTU9ZN0liNERCbTYzemNHc3kvOEVlaTlIRWhsZGRCaGRhLzJSZTQ0?=
 =?utf-8?B?WTlXUGI2T2ljcGR6TGZwc3ZBUHdEcEZvZHVvYXpuVW1SL3N3aE5SbzRZQWU4?=
 =?utf-8?B?Yk5BVUFrcWNsS0piMjhKNFROTWJiMzFWaGhXb3hGb0tVNHM0V3AvWDFYaEhq?=
 =?utf-8?B?bUZxSFBZN2RCN2hPZmJMNkRoZ3hudDRNaG8yZXFzWERPYW5tQUdWWDhWQjl3?=
 =?utf-8?B?Z09zaDBxRU1lL1pQVGsrMU1NV0xMZHYyQWNMNEp2ZGE0QXVlRy9hQ0xKS3Ux?=
 =?utf-8?B?MnVTZTZHbUdrYXpJeXY1Z3VoOEhHL1lTcVU1UXRjUGZ1NVdUeHljMzhoRlc0?=
 =?utf-8?B?ZWJvZEczdjFYbllKeUlJQXdISGMwdXdYaSswRGt6bGgwTVdINHUwTVJtTVhN?=
 =?utf-8?B?cjFlYUNoS3JkeG9xQWhlb24yY21rd3BFU3NYQW1NK3IzQWdSaXZJc3JjNDhB?=
 =?utf-8?B?Mi9uWHV5aWtIMlBxK3Bidlc1bzZHeEJWMmdoZGJkWk1xc2tVOW0wVE03bElY?=
 =?utf-8?B?ZTg5Q0RNWkp3VzByRjY4U0RHNURodjg3SCtRNC84Y0dkS0E0cmZCSHF6UlpU?=
 =?utf-8?B?RmZObDFaZ0kxSHNKTC9leDFWTUxaRlhLdjB6UWo4TXhFSGc2U3JtNWgyMUZy?=
 =?utf-8?B?NDlFL1FmamRjSHQ4NjVuREROTytrNkp0ZDVxY25uaXFPTWlxa2FNTlJXemQ3?=
 =?utf-8?B?WmFUeXpWQnV1aWdlTFI1MDkwSHU0QWlxdFNnZHBlYjhzUG9DcUhXOFZmS2to?=
 =?utf-8?Q?cxosPH0J4vsbNZ7CI/q6jUrk5rhoa95O28sVYFpMqCpM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c413e4e-43d6-44dc-67f0-08ddcb88733f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 14:35:06.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8787

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVy
c2RheSwgSnVseSAyNCwgMjAyNSAxMDo1NCBQTQ0KPiANCj4gT24gNy8yNS8yMDI1IDg6NTIgQU0s
IE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE5hbWFuIEphaW4gPG5hbWphaW5AbGlu
dXgubWljcm9zb2Z0LmNvbT4gU2VudDogVGh1cnNkYXksIEp1bHkgMjQsIDIwMjUgMToyNiBBTQ0K
PiA+Pg0KDQpbc25pcF0NCg0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW50IG1zaHZfdnRsX3NpbnRf
aW9jdGxfc2V0X2V2ZW50ZmQoc3RydWN0IG1zaHZfdnRsX3NldF9ldmVudGZkIF9fdXNlciAqYXJn
KQ0KPiA+PiArew0KPiA+PiArCXN0cnVjdCBtc2h2X3Z0bF9zZXRfZXZlbnRmZCBzZXRfZXZlbnRm
ZDsNCj4gPj4gKwlzdHJ1Y3QgZXZlbnRmZF9jdHggKmV2ZW50ZmQsICpvbGRfZXZlbnRmZDsNCj4g
Pj4gKw0KPiA+PiArCWlmIChjb3B5X2Zyb21fdXNlcigmc2V0X2V2ZW50ZmQsIGFyZywgc2l6ZW9m
KHNldF9ldmVudGZkKSkpDQo+ID4+ICsJCXJldHVybiAtRUZBVUxUOw0KPiA+PiArCWlmIChzZXRf
ZXZlbnRmZC5mbGFnID49IEhWX0VWRU5UX0ZMQUdTX0NPVU5UKQ0KPiA+PiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPj4gKw0KPiA+PiArCWV2ZW50ZmQgPSBOVUxMOw0KPiA+PiArCWlmIChzZXRfZXZl
bnRmZC5mZCA+PSAwKSB7DQo+ID4+ICsJCWV2ZW50ZmQgPSBldmVudGZkX2N0eF9mZGdldChzZXRf
ZXZlbnRmZC5mZCk7DQo+ID4+ICsJCWlmIChJU19FUlIoZXZlbnRmZCkpDQo+ID4+ICsJCQlyZXR1
cm4gUFRSX0VSUihldmVudGZkKTsNCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gKwlndWFyZChtdXRl
eCkoJmZsYWdfbG9jayk7DQo+ID4+ICsJb2xkX2V2ZW50ZmQgPSBSRUFEX09OQ0UoZmxhZ19ldmVu
dGZkc1tzZXRfZXZlbnRmZC5mbGFnXSk7DQo+ID4+ICsJV1JJVEVfT05DRShmbGFnX2V2ZW50ZmRz
W3NldF9ldmVudGZkLmZsYWddLCBldmVudGZkKTsNCj4gPj4gKw0KPiA+PiArCWlmIChvbGRfZXZl
bnRmZCkgew0KPiA+PiArCQlzeW5jaHJvbml6ZV9yY3UoKTsNCj4gPj4gKwkJZXZlbnRmZF9jdHhf
cHV0KG9sZF9ldmVudGZkKTsNCj4gPg0KPiA+IEFnYWluLCBJIHdvbmRlciBpZiBpcyBPSyB0byBk
byBldmVudGZkX2N0eF9wdXQoKSB3aGlsZSBob2xkaW5nDQo+ID4gZmxhZ19sb2NrLCBzaW5jZSB0
aGUgdXNlIG9mIGd1YXJkKCkgY2hhbmdlcyB0aGUgc2NvcGUgb2YgdGhlIGxvY2sNCj4gPiBjb21w
YXJlZCB3aXRoIHRoZSBwcmV2aW91cyB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guDQo+ID4NCj4gDQo+
IEkgZGlkbid0IGZpbmQgZXZlbnRmZF9jdHhfcHV0KCkgdG8gYmUgYSBibG9ja2luZyBvcGVyYXRp
b24sIHNvIEkgdGhvdWdodA0KPiBvZiBrZWVwaW5nIGd1YXJkKCkgaGVyZS4gQWx0aG91Z2gsIHN5
bmNocm9uaXplX3JjdSgpIGlzIGEgYmxvY2tpbmcNCj4gb3BlcmF0aW9uLiBQbGVhc2UgYWR2aXNl
LCBJIGFtIE9rIHdpdGggcmVtb3ZpbmcgdGhlIGd1YXJkLCBhcyB0aGUgbG9jaw0KPiBpcyBqdXN0
IGJlaW5nIHVzZWQgaGVyZSwgYW5kIGF1dG9tYXRpYyBjbGVhbnVwIHNob3VsZCBub3QgYmUgYW4g
aXNzdWUNCj4gaGVyZS4NCg0KWWVzLCBJIHRoaW5rIHlvdSBhcmUgcmlnaHQuIEkgc2F3IHRoZSBr
cmVmX3B1dCgpIGFuZCB3YXMgdW5zdXJlIHdoYXQNCndvdWxkIGJlIGNhbGxlZCBpZiB0aGUgb2Jq
ZWN0IHdhcyBmcmVlZC4gQnV0IHRoZSAiZnJlZSIgZnVuY3Rpb24gaXMNCnJpZ2h0IHRoZXJlIHN0
YXJpbmcgYXQgbWUuIDotKSBBbGwgaXQgZG9lcyBpcyBpZGFfZnJlZSgpIGFuZCBrZnJlZSgpLA0K
Ym90aCBvZiB3aGljaCB3b3VsZCBiZSBzYWZlLg0KDQpZb3Ugc2hvdWxkIGJlIGdvb2Qga2VlcGlu
ZyB0aGUgZ3VhcmQoKS4NCg0KTWljaGFlbA0KDQo+IA0KPiANCj4gPj4gKwl9DQo+ID4+ICsNCj4g
Pj4gKwlyZXR1cm4gMDsNCj4gPj4gK30NCj4gPj4gKw0K

