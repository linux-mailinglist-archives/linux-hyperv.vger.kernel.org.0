Return-Path: <linux-hyperv+bounces-7067-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF40BB5ACE
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 02:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F5A19E6354
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Oct 2025 00:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C472612;
	Fri,  3 Oct 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qh7JBLAL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013073.outbound.protection.outlook.com [52.103.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA083D3B3;
	Fri,  3 Oct 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759451241; cv=fail; b=YVnNRUWMlpm2PG6TDOABdZay3CkddUhDG+28WdXmK4KlZL76fkvg+tYvi3ZfxSXcaUvZtA8FVc7hzFybFvXjw+xecmCjC7pp8PDGzrYfmdwyRRp9q9mToWV/UyxdYBIv4IKVs7W2Jnaz/0TDEdu53NFCJJeluwtQ2/PszVIVgjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759451241; c=relaxed/simple;
	bh=DPbV2a/7DuMFkcg2pLc8XQ2pHaiSbjLL1AR5KJVaT90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcorgZy7uOwp8Gpus5uwcJ2oYMM03y1spsXeqFwmYogYK7e3o0SlZnJEIB4FdQFeqYHEGTjMwii4zIB2rNHWR/wxCvDtafxeV2a6R6A6WwUke/7ksBW0W/K8HD+e75rS1aoWrGxkOXOQZUwbMviKCTCA6WrGrYbarZYD42Ch378=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qh7JBLAL; arc=fail smtp.client-ip=52.103.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuYBX+VKZM8qBY7PnrSaiaTJ1LgGSEAs19S3TsJHTWSRplbr0Ufna61EOkoqwG9KvOtK+9Rf0sUJexeK+KBQ6035lL8HYqwqILv0fF8bd4j8EirliUp7RYNTQu+maVTo2he/5DTxKjycaNg6MEL/N2uiXLAuUKKj1quvj6CcawaBi63kYt/YwPd0KVrML0u+40oFlXq9KFIROt1EFLKsItyxbniLmmWtk21RB91T8OQHFvnpQWNJSHvAt7ku8lKXaY1RPJzkSDNQt6Lz5FbgdAdh6LyiOIfi4989x64E6kPy/AKLtM2vbqxq1z7+lYle9Zc+VUCjfIyNP7p8yeh9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPbV2a/7DuMFkcg2pLc8XQ2pHaiSbjLL1AR5KJVaT90=;
 b=udpDFu7ZnBpMz8+uxWsioB/5hft6NGc/ImhBv2voA0i8USVEh1LqjYGKv3D8X3AZ4ISxdXyplAte9KsTh+aB2wDeiGamOZ7HsQStv1BQXFBqVXvEKe4I+XrgUbSm/ux2+ydfSOxiYGdko9560CK+1qDxo92Ofyw0yz8WsZEpRGx21mEGDFFrpM87NpEDp8lNL36ul14J+J3Hi7yYi+btCOA+TVx7nujOmdjO5inDBnp8gm3ZmI20akUyHIUPGL5iCq76p7NqNWYjRiDsGgklk9GdfPifp4P571cbkiHN5YqDjdTT+ds/n4wjRakthVgPpmbq7eqHeG99q/y0zPVCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPbV2a/7DuMFkcg2pLc8XQ2pHaiSbjLL1AR5KJVaT90=;
 b=qh7JBLALWJdR2mI0BDDLYIe+5YMh0pXPMdG0GMm3DKKFJ6scZQ64r13Lb/BRq0dzxCVo8TD2p/Ky4/wjw2oMw8vXlJ9JPX/ygR2jPmLLANGqsSC0I7o59nIRFtYWmm2BQEYiUXaC25WfEnvpy3WP6Ikqusap9NANeBAz8CmiJ8W0F0n+r8CBR5qkrz8XvRNsITiEssYZy1+wxlLhGEcL0HHc/irxkjjn3HxjoUPO37p3HJnUsOo2lxXU7BKu50Dv3Ofa6RM2Xg/igMEYnp2zyTlnp0vbQZJsIPQ4eXjm2kPupuG9P9fqlqRmntDwNRtfjqgRSbl/qVddV7rdtEMt2Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7838.namprd02.prod.outlook.com (2603:10b6:a03:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Fri, 3 Oct
 2025 00:27:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 00:27:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
Thread-Topic: [PATCH v3 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Thread-Index: AQHcM7q7gAyul66beU2lfOoL5uqdvLSvjriQ
Date: Fri, 3 Oct 2025 00:27:13 +0000
Message-ID:
 <SN6PR02MB415777407333F3EC40CC05B7D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175942296162.128138.15731950243504649929.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <175942296162.128138.15731950243504649929.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7838:EE_
x-ms-office365-filtering-correlation-id: d8f685ff-f9c2-4425-1ed3-08de02139981
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|461199028|8060799015|15080799012|8062599012|12121999013|19110799012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3hiZ1NFTWg5QVBkSFBrYUlKM2RTMDVUWEU5dHZpaFo5YWNDb2cybE9MR0dp?=
 =?utf-8?B?NjRUeERTc1FDSFJsdjhPZThGTDN2NkFKSmZlVDhycG0zU3NVN2Q2YkpEcnpR?=
 =?utf-8?B?S0h6N3Nnamg2MjFDWkZvWk15N2o1Tng1Yk1GeVVPT0h3bXdEVXBQOGVMN0J6?=
 =?utf-8?B?N3dJRVI1VWFDVGNJUk43b3V0VjZRL0NxckVmVnBYb2RKSHI4ZUkyc3ptSHdF?=
 =?utf-8?B?R3lwR0F2Y29TbUNrNVJmSDBmQW5SelphbitTYmRaaEE4bHk1QUZ0TVRVMk1n?=
 =?utf-8?B?K2R0UWlVQWxOQ3dOdUpaa1R6THF5dkJNNE5SNXRPc3IyZHV5M3dMVS8xenpN?=
 =?utf-8?B?a2cwR2ZMVGZqemVHKytjNS9ISTNQYnhMQVNLVHp3cHRMa2FGUFd3TXowV0hY?=
 =?utf-8?B?YWEvV0ljUG9Cb1VHWTlLZmV1SFE0Z3NBNjRkWlRuRjlJelIxZVM5UHFPcDFu?=
 =?utf-8?B?YW82UHRGb3JpcDhLSGVGTGxCWWpyR2lySytjcXNwcUpPeE9PRkczV2wwa012?=
 =?utf-8?B?VU1DQVNnMlllc1RQWDhVSWJLQ0xUS0ZxeTZHSVlMSmd1L0dkSU1nWUlubGxz?=
 =?utf-8?B?cXR6WmVsS3FmVCtjSHdLNUlSUEN4NnpZVzFZRXg2djlQanBTUHEvZG9uKyt4?=
 =?utf-8?B?MElTLzdiOTVqS21GMnZHd0ExUlRBNmNkSEVKMnZ4ckF5RHZmZHhkYlYyWEtV?=
 =?utf-8?B?cjhsK1dOMFBDUFhZWVR0cVdraWFaTmV4a2pRbmExdDBzQlRodnFML3lpaC9E?=
 =?utf-8?B?Vk9BbmNvSS9DOFRTN0dDSXVITUdNVFM3T0NPNFowMVpTeXhWc2w2SzQzQytK?=
 =?utf-8?B?UWRaRU5DaDAwOFV3WmNMNGFxMFlJaVJxM3BrcTZUNVlVZlhLVHhXMHB2Vmt2?=
 =?utf-8?B?WUtucUxqbWlCS2hESU5TeHRML0RFNUxoUzg4MjJIOHl1V1N6YnFLbE1UOE9i?=
 =?utf-8?B?YndQUjFWaVZkV1lGSnVydFI5d0E1M1poU0Y2ZVNqSk1kWkQzL1o3c3Y4Ty95?=
 =?utf-8?B?amRka0xiQlhaNmhuZDZncFJlSHNZTVpoSlNBcUJUUHZCSFJXM29oK0pVVlFO?=
 =?utf-8?B?M0YreEZkSE9CWFVMcjNYM2IzZHNjcWtuajdiSE0zZ0ZzRGk0Z3B4RjFOeTdw?=
 =?utf-8?B?RmZpYlZ5NzdTVDVBenI4eGUxT0x3SEZEdkdQVFI2YjJ3YkROTkhoeWhNRmtF?=
 =?utf-8?B?SGJNUjNxdk1ZK3VyclRqQ2wrWitiRVFiK01JVU8yeG9BUFdZUmdRaUFETkpl?=
 =?utf-8?B?cnZKMjltemRwdFo0K3NyekVRbnpmOVVnQ1FQUUVCRHVQVlhrN0FpUGZhTXBk?=
 =?utf-8?B?RHdNVzZMTi9ZOHBZSWVSdTVWS1Z5NkN0dG9CUkptQSsvOENDbk5KV3YzVC9V?=
 =?utf-8?B?QjEyNEZaRktiUXRoNjdrMmFrdTc0S2RMcTFENisvUFY2djRNR3R5Z1RLUjFu?=
 =?utf-8?B?S0MwOFFSbVNVdW5ObEpiNGQyQm0rWnpibzZrdlIvZjRTRW9VWldBSFlCWFN1?=
 =?utf-8?B?bGJ3Um1obW5aQUVuYWpOS2lZTWM4c3B5OVpoN1diRmcxakgxd2lLNWxnSllr?=
 =?utf-8?B?R1U1bmJPTjZkcmdPMlBFdDFuenFMNkw3Z0FTN2ErK2ZpV2pHVmhVRDFUanNM?=
 =?utf-8?B?djJycEovdWdkd1Y5ck1sOWdNWGR4aGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1Jha2FtaVhlMTBBeThIaUcxSVRIcm8vdFN2a3QrZGhNbzZybER1YkRlMFZD?=
 =?utf-8?B?ZUZ0czJQVDdzWXNLSXV2cFF1aC9kQ2dOdXZTVGVycEs3ZEkvV2RHZ01OWExC?=
 =?utf-8?B?WlFIdXQ2OTBzclcrSldrK3NRVHU3SHhVL2lZd3pzcGZLeXJnREZtL0ZXQjhX?=
 =?utf-8?B?Ymc4aVljZXFnSm9NVEQ3NlRyY0FZN2EvZm9WQVFjdkJhSHhrN1pENExGZG4r?=
 =?utf-8?B?YWs3Szc0Y0tORjUwMHNESkhUbVQ0WVU3amxoQjllK2hiMUlaejZ3YWEwNlYx?=
 =?utf-8?B?TmtZUk5kd2w2cmlTV25zTnY2eUZEbFlyWkdPSUFvdEx4MXphQWhJVlc2di9k?=
 =?utf-8?B?Qi9xUnE1MEtJckNyMExnTVI2NVp5cFE1MXpBVXRkM0t0aGYwTC9sQk9aL1pX?=
 =?utf-8?B?WjNtMHUxbGNMMUlNaVk1eVFCNFFuNytjT0JVZjQ1dzJwdFppWXROejUxQi9z?=
 =?utf-8?B?QW1ZSU90dkRmMGpNNGx1YXE1M05xekdEY2Z5Zy9mVGhsRkNKZHRhR3QzN2xG?=
 =?utf-8?B?QTl3aVZWbWJPWkpjTWN1QkZ5RCttMTBZRmpISmhJaHZ6OFFtNk82N2FXaFZk?=
 =?utf-8?B?ZCtiQ1EzcWZiSk9PMU5WUTYwT1g3NS9hNU5qUUlubzU5Q3pyYkl1R09JNnBJ?=
 =?utf-8?B?bjdORzlpL2NuS3Q4bWxEKzdTRW80Y1NYK2ZYNHIwTlF1Z21LQktNV3E5cHV0?=
 =?utf-8?B?aG1RODdSZCtvMlBBVWNlTkovZVVZS0Z6QllQbkdnU3hKSGMvTnlTSmltd1Jt?=
 =?utf-8?B?VE55KzFySUh0SWkzTkM4cklLL21MMUt5OTk3Njl5S0ZKY0FENzNHbGxMc0w1?=
 =?utf-8?B?VzhId0ZGelZoOEIyZ2pqeEprdWJGcytmWlRKbzlUMUdTVnlwSVdwZXcrVEVi?=
 =?utf-8?B?Q3JMaFFUUHpBNEVvS05abDZtai9MZ3JBZHdhUGF2TTg4SEsyL3BuNGJTcDVP?=
 =?utf-8?B?R3oxZVpNSWRWK2lpUnFPb0tqLys3OC9oTzVLcFhYRGZxTjVmU0dQclRYazg2?=
 =?utf-8?B?NGpndlcrSTNtaEFYU0RnalRZSGdZcWhUb0Z6UW1JK1NQc2lmbkpZTFlxVld5?=
 =?utf-8?B?T1dDSHpyK3R0Q3o0bWNGSkI0a1J2bFN2Q3J4UVFwSVNiNExTN1IwdHpGUnFZ?=
 =?utf-8?B?cW1FOEk2T1lNMDN5QUIvdmhhRE4xRnBFYTFqNEJZbTY2ZTFscS82aU8wdjV6?=
 =?utf-8?B?NUl0Tkd5MHdqL0VDRVhydkdFK2I0c00rUVNlR040MXVoUVdLaU8wZFk5RkxM?=
 =?utf-8?B?bEhQR0FKN1JKV1BXM1p6dC9za1gvR0FFc1VPT1NGeUYwdkN5UDNmekkxL2N0?=
 =?utf-8?B?VDF1RVVIWTFoZXlkMlNPS3YzZUdBNWVlL2R6c2h4SU5objdwa1VBZmk3NE43?=
 =?utf-8?B?R21RdGIvNkx0MG5VTmpBNWw1amYrbnNjYVhlelh3OTVKalFFdWF3UlRJNUxa?=
 =?utf-8?B?YTJXYitQZDh3M2p5S21Fb1o2VWNURkYrMWZpWldlYkhMVFlhcVgrem1qVDlO?=
 =?utf-8?B?bFc4N2wvMmRDaHZFbTRaY2t5WkNVTnViN0RMNGpSdjA2d0FybVY0UFIwYlgz?=
 =?utf-8?B?Z1RUL2tieWMyV1JUbWRJWUhSckpFSkhkQjZCNDE0Sytwb0M3am9QZ1h0S21W?=
 =?utf-8?Q?TuVEY4g68swqOaKeAl7v4x/Qf5ADpX1lt0UKfPqeqhqc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f685ff-f9c2-4425-1ed3-08de02139981
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 00:27:13.5898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7838

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMiwgMjAyNSA5OjM2IEFNDQo+IA0KPiBSZWR1
Y2Ugb3ZlcmhlYWQgd2hlbiB1bm1hcHBpbmcgbGFyZ2UgbWVtb3J5IHJlZ2lvbnMgYnkgYmF0Y2hp
bmcgR1BBIHVubWFwDQo+IG9wZXJhdGlvbnMgaW4gMk1CLWFsaWduZWQgY2h1bmtzLg0KPiANCj4g
VXNlIGEgZGVkaWNhdGVkIGNvbnN0YW50IGZvciBiYXRjaCBzaXplIHRvIGltcHJvdmUgY29kZSBj
bGFyaXR5IGFuZA0KPiBtYWludGFpbmFiaWxpdHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFu
aXNsYXYgS2luc2J1cnNraWkgPHNraW5zYnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvaHYvbXNodl9yb290LmggICAgICAgICB8ICAgIDIgKysNCj4gIGRyaXZl
cnMvaHYvbXNodl9yb290X2h2X2NhbGwuYyB8ICAgIDIgKy0NCj4gIGRyaXZlcnMvaHYvbXNodl9y
b290X21haW4uYyAgICB8ICAgMTUgKysrKysrKysrKysrLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9odi9tc2h2X3Jvb3QuaCBiL2RyaXZlcnMvaHYvbXNodl9yb290LmgNCj4gaW5kZXggZTM5
MzFiMGYxMjY5My4uOTdlNjRkNTM0MWI2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi9tc2h2
X3Jvb3QuaA0KPiArKysgYi9kcml2ZXJzL2h2L21zaHZfcm9vdC5oDQo+IEBAIC0zMiw2ICszMiw4
IEBAIHN0YXRpY19hc3NlcnQoSFZfSFlQX1BBR0VfU0laRSA9PSBNU0hWX0hWX1BBR0VfU0laRSk7
DQo+IA0KPiAgI2RlZmluZSBNU0hWX1BJTl9QQUdFU19CQVRDSF9TSVpFCSgweDEwMDAwMDAwVUxM
IC8gSFZfSFlQX1BBR0VfU0laRSkNCj4gDQo+ICsjZGVmaW5lIE1TSFZfTUFYX1VOTUFQX0dQQV9Q
QUdFUwk1MTINCj4gKw0KPiAgc3RydWN0IG1zaHZfdnAgew0KPiAgCXUzMiB2cF9pbmRleDsNCj4g
IAlzdHJ1Y3QgbXNodl9wYXJ0aXRpb24gKnZwX3BhcnRpdGlvbjsNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaHYvbXNodl9yb290X2h2X2NhbGwuYyBiL2RyaXZlcnMvaHYvbXNodl9yb290X2h2X2Nh
bGwuYw0KPiBpbmRleCBjOWMyNzRmMjljM2M2Li4wNjk2MDI0Y2NmZTMxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2h2L21zaHZfcm9vdF9odl9jYWxsLmMNCj4gKysrIGIvZHJpdmVycy9odi9tc2h2
X3Jvb3RfaHZfY2FsbC5jDQo+IEBAIC0xNyw3ICsxNyw3IEBADQo+ICAvKiBEZXRlcm1pbmVkIGVt
cGlyaWNhbGx5ICovDQo+ICAjZGVmaW5lIEhWX0lOSVRfUEFSVElUSU9OX0RFUE9TSVRfUEFHRVMg
MjA4DQo+ICAjZGVmaW5lIEhWX01BUF9HUEFfREVQT1NJVF9QQUdFUwkyNTYNCj4gLSNkZWZpbmUg
SFZfVU1BUF9HUEFfUEFHRVMJCTUxMg0KPiArI2RlZmluZSBIVl9VTUFQX0dQQV9QQUdFUwkJTVNI
Vl9NQVhfVU5NQVBfR1BBX1BBR0VTDQo+IA0KPiAgI2RlZmluZSBIVl9QQUdFX0NPVU5UXzJNX0FM
SUdORUQocGdfY291bnQpICghKChwZ19jb3VudCkgJiAoMHgyMDAgLSAxKSkpDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9odi9tc2h2X3Jvb3RfbWFpbi5jIGIvZHJpdmVycy9odi9tc2h2X3Jv
b3RfbWFpbi5jDQo+IGluZGV4IDdlZjY2YzQzZTE1MTUuLjhiZjBiNWFmMjU4MDIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaHYvbXNodl9yb290X21haW4uYw0KPiArKysgYi9kcml2ZXJzL2h2L21z
aHZfcm9vdF9tYWluLmMNCj4gQEAgLTEzNzgsNiArMTM3OCw3IEBAIG1zaHZfbWFwX3VzZXJfbWVt
b3J5KHN0cnVjdCBtc2h2X3BhcnRpdGlvbiAqcGFydGl0aW9uLA0KPiAgc3RhdGljIHZvaWQgbXNo
dl9wYXJ0aXRpb25fZGVzdHJveV9yZWdpb24oc3RydWN0IG1zaHZfbWVtX3JlZ2lvbiAqcmVnaW9u
KQ0KPiAgew0KPiAgCXN0cnVjdCBtc2h2X3BhcnRpdGlvbiAqcGFydGl0aW9uID0gcmVnaW9uLT5w
YXJ0aXRpb247DQo+ICsJdTY0IHBhZ2Vfb2Zmc2V0Ow0KPiAgCXUzMiB1bm1hcF9mbGFncyA9IDA7
DQo+ICAJaW50IHJldDsNCj4gDQo+IEBAIC0xMzk2LDkgKzEzOTcsMTcgQEAgc3RhdGljIHZvaWQg
bXNodl9wYXJ0aXRpb25fZGVzdHJveV9yZWdpb24oc3RydWN0IG1zaHZfbWVtX3JlZ2lvbiAqcmVn
aW9uKQ0KPiAgCWlmIChyZWdpb24tPmZsYWdzLmxhcmdlX3BhZ2VzKQ0KPiAgCQl1bm1hcF9mbGFn
cyB8PSBIVl9VTk1BUF9HUEFfTEFSR0VfUEFHRTsNCj4gDQo+IC0JLyogaWdub3JlIHVubWFwIGZh
aWx1cmVzIGFuZCBjb250aW51ZSBhcyBwcm9jZXNzIG1heSBiZSBleGl0aW5nICovDQo+IC0JaHZf
Y2FsbF91bm1hcF9ncGFfcGFnZXMocGFydGl0aW9uLT5wdF9pZCwgcmVnaW9uLT5zdGFydF9nZm4s
DQo+IC0JCQkJcmVnaW9uLT5ucl9wYWdlcywgdW5tYXBfZmxhZ3MpOw0KPiArCWZvciAocGFnZV9v
ZmZzZXQgPSAwOyBwYWdlX29mZnNldCA8IHJlZ2lvbi0+bnJfcGFnZXM7IHBhZ2Vfb2Zmc2V0Kysp
IHsNCj4gKwkJaWYgKCFyZWdpb24tPnBhZ2VzW3BhZ2Vfb2Zmc2V0XSkNCj4gKwkJCWNvbnRpbnVl
Ow0KPiArDQo+ICsJCWh2X2NhbGxfdW5tYXBfZ3BhX3BhZ2VzKHBhcnRpdGlvbi0+cHRfaWQsDQo+
ICsJCQkJCUFMSUdOKHJlZ2lvbi0+c3RhcnRfZ2ZuICsgcGFnZV9vZmZzZXQsDQo+ICsJCQkJCSAg
ICAgIE1TSFZfTUFYX1VOTUFQX0dQQV9QQUdFUyksDQoNClNlZW1zIGxpa2UgdGhpcyBzaG91bGQg
YmUgQUxJR05fRE9XTigpIGluc3RlYWQgb2YgQUxJR04oKS4gIEFMSUdOKCkgcm91bmRzDQp1cCB0
byBnZXQgdGhlIHJlcXVlc3RlZCBhbGlnbm1lbnQsIHdoaWNoIGNvdWxkIHNraXAgb3ZlciBzb21l
IG5vbi16ZXJvDQplbnRyaWVzIGluIHJlZ2lvbi0+cGFnZXNbXS4NCg0KQW5kIEknbSBhc3N1bWlu
ZyB0aGUgdW5tYXAgaHlwZXJjYWxsIGlzIGlkZW1wb3RlbnQgaW4gdGhhdCBpZiB0aGUgc3BlY2lm
aWVkDQpwYXJ0aXRpb24gUEZOIHJhbmdlIGluY2x1ZGVzIHNvbWUgcGFnZXMgdGhhdCBhcmVuJ3Qg
bWFwcGVkLCB0aGUgaHlwZXJjYWxsDQpqdXN0IHNraXBzIHRoZW0gYW5kIGtlZXBzIGdvaW5nIHdp
dGhvdXQgcmV0dXJuaW5nIGFuIGVycm9yLg0KDQo+ICsJCQkJCU1TSFZfTUFYX1VOTUFQX0dQQV9Q
QUdFUywgdW5tYXBfZmxhZ3MpOw0KPiArDQo+ICsJCXBhZ2Vfb2Zmc2V0ICs9IE1TSFZfTUFYX1VO
TUFQX0dQQV9QQUdFUyAtIDE7DQoNClRoaXMgdXBkYXRlIHRvIHRoZSBwYWdlX29mZnNldCBkb2Vz
bid0IHRha2UgaW50byBhY2NvdW50IHRoZSBlZmZlY3Qgb2YgdGhlDQpBTElHTiAob3IgQUxJR05f
RE9XTikgY2FsbC4gIFdpdGggYSBjaGFuZ2UgdG8gQUxJR05fRE9XTigpLCBpdCBtYXkNCmluY3Jl
bWVudCB0b28gZmFyIGFuZCBwZXJoYXBzIGNhdXNlIHRoZSAiZm9yIiBsb29wIHRvIGJlIGV4aXRl
ZCBwcmVtYXR1cmVseSwNCndoaWNoIHdvdWxkIGZhaWwgdG8gdW5tYXAgc29tZSBvZiB0aGUgcGFn
ZXMuDQoNCj4gKwl9DQo+IA0KPiAgCW1zaHZfcmVnaW9uX2ludmFsaWRhdGUocmVnaW9uKTsNCj4g
DQo+IA0KPiANCg0K

