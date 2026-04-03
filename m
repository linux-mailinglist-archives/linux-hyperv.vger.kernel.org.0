Return-Path: <linux-hyperv+bounces-9967-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGLiFtgI0Gno2gYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9967-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 20:37:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083E39754B
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 20:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22150300ADA5
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A40369203;
	Fri,  3 Apr 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DIueocOs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011013.outbound.protection.outlook.com [52.103.1.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D2625;
	Fri,  3 Apr 2026 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241426; cv=fail; b=duRe8cwc/I3d978ZsRKheVp3958vSsWZntNEin1F9j3Jx4CWq0Ik2Z69gdYUIJwO6LQRnF7AuyqLuM4U0wPrPXnY13d09eotJn8hIJh55hEj3mu4v5TxrbdRzhZSo/zMcejnQP8FHOzgYel464k1Z1wu12TJVMoj4yl/VR8qw4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241426; c=relaxed/simple;
	bh=zDF2YSMpohr16lCWFrbuiJ3cVtMsJe99mUKuRDrW6mE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAV9ob3xzKcEWthBcXAWERiJ/btnE6hQBsHtpCyGUEFNE8f60GD3/pVbkQNgwomADeGb1FUPX6nOaY+51JLRrOr4hTF8HE8Qb1Uvbqyo/yEmJiJci7T59fStxlW29UW5iRxLv/C1F2WdlQVOGuQ4Ax+ngQ/6gCp1w5utLymbvvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DIueocOs; arc=fail smtp.client-ip=52.103.1.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPQenY61mu7UmKWlCz/oaYhdxyVFk4YBTfZCnsTzzbs3NUnf36gGC2E/r0j0c4RLuMAHUPzm+4tPbOhquHOmFcLLewH+U74Fe6HFvNXuYBzi+ePajxuaj0dISp5pZojVhofmawt7lwiD1lYIykPEtaESHpxLW1m1mrOzX9KpSGVKTZMRVVsI4DQb/Bchb1okdmA9Atojga6mdgaEnwz/po04Ql7dXNvxAeUyp+x7SezbOI2G8to00thqkR2hDY8EVfTCwik7gygsMQr6pEzUMHBi3NmeEydTtvWD5NyYr1dC6ST2yW8vcELXuWCG7KSin0bW60CFujwZz+mRkAxrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDF2YSMpohr16lCWFrbuiJ3cVtMsJe99mUKuRDrW6mE=;
 b=nbdrmtT/D1pYRH9XG/3nxu5yNA9MtFX2aYHAVzAZUslsLs0W3nJY3u2VvFk8Gws/71ZBHdwLKY8eAQ5aRDxNBw5MaWXi0gyyuyAzh+ofKNsUcdc3iKNph3fBNGNo04Wpqp4HoAbhmxJ+yTIRIFLmrHtW/YFEzHY7/FK4UoLWGO0i9IwzMrN8zXa9WJlzzGwhk8p6kAVr5ZXCZK6dSES3jlIiw9kzvxHf90ebkzOxO5kuA+gYaQ0EnkVPxNz+MRmDwwB7cWBXgz9Tc1ZWOaCgLLztbrxqAeq25Cp65zevFYfwexHyrCQ/t026hdWTEZ7+gUXIbH98DcsoowiTJghvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDF2YSMpohr16lCWFrbuiJ3cVtMsJe99mUKuRDrW6mE=;
 b=DIueocOsCbQ3VNhiL8YYPDm2uOWwIobNIYkLEqW7PSdcNCfHpxd3rXr+ExVhAvieNwmGkkGgVemoAVID0t2ybCz6b5WB4UMWF68HDXf1Hlnbmh1hLYGXIp7XokfyCE2tcJq0F+Rjxq12uoHTXHciGAcpJzorTcUAUQGoWfTNLVkkrOflT4ROBK7tWzvUwbw8k61tMl1IPy034Vw4vpWHSo9W3LkFHkOrxLCciaK/ssd+pXNisJsXwvPg4itlJ2znp4NAjEJk8aCt5oOLQsuM/15bFjLWLSM4txtxGhcVfZZd1OlnrcL11UYBVOWbezCSqrDqo8YSPmVw84mMzZNfNQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9504.namprd02.prod.outlook.com (2603:10b6:930:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 3 Apr
 2026 18:37:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 18:37:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: mshv_vtl: Fix vmemmap_shift exceeding
 MAX_FOLIO_ORDER
Thread-Topic: [PATCH] Drivers: hv: mshv_vtl: Fix vmemmap_shift exceeding
 MAX_FOLIO_ORDER
Thread-Index: AQHcwZoDNywBiQBIX0+QO58Q+eAfu7XMsqfggABALQCAALuuEA==
Date: Fri, 3 Apr 2026 18:37:01 +0000
Message-ID:
 <SN6PR02MB4157550DA8F143F4DAFBEEE4D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260401054005.1532381-1-namjain@linux.microsoft.com>
 <SN6PR02MB415797828F8DC5C9AC7E9131D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <9f0e27ac-099b-4b7d-b082-f43245331bbc@linux.microsoft.com>
In-Reply-To: <9f0e27ac-099b-4b7d-b082-f43245331bbc@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9504:EE_
x-ms-office365-filtering-correlation-id: c7f494b7-cbc8-4759-710d-08de91affefb
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|41001999006|8060799015|15080799012|461199028|51005399006|13091999003|31061999003|19110799012|12121999013|37011999003|3412199025|440099028|12091999003|26121999003|102099032|56899033|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2lkcHFEcFBobTB1TVlHQmFHeDZDOFl6SXRGdjNoaDI3MisvQWdFcmFFRVdQ?=
 =?utf-8?B?SGdlanpKblFVd0VhYUkzejFKV05ZNUFBNTIzVnZBbU9QWGdDOS9CTnBjN29B?=
 =?utf-8?B?Q3NwZXMxSjhoS1Z3OHZYQy80ZTZ1MlJWUWxIckxPdUpna0RVdVRsWHBPY1kr?=
 =?utf-8?B?NlBCbmRGYlZPR1gwc0l0Z1JkUWtUbmtxQWpGZ3BpRkgxOEZ0eTVmaEExcDN5?=
 =?utf-8?B?clcwZ2tuR01kSFV2cWhpVDdEaE1FMEt6Z20vNWNJdVcxQ0V5OVNqQnIxNXkv?=
 =?utf-8?B?OS9BOGVWMkorMEdjdnV1VzkrVVJ3VGVmZEhvQ2VZdnpYejNUZE1mTGFabWI2?=
 =?utf-8?B?WTF0d0xJVzk4V2dwTXJKczRFaUVCTi9BcmRTZDZZZ0lOOElyTzN2anAxMkZB?=
 =?utf-8?B?VUc3RmtRM0R0Uyt5Q0JDQTYyRWNrMXEyQmFSaUFER1FmMEhyUWJIdXp1NWhq?=
 =?utf-8?B?T0hDQm4yYVl3RkNsRVppR2hHTjBnajJOa2UzMlBVb052dmFodUN2Zm10QnNj?=
 =?utf-8?B?cTJrdTRjMnE4VDJ0dzVMRU94K0M4MkdVMVpWdCtPUUlFL3YweFMzMVZqR0pQ?=
 =?utf-8?B?MU1lSk5JWi81ZUcxVnB1UHJYVExWL01ZSm1kcFA2ZVBML04yZzFWUkZFT1Z6?=
 =?utf-8?B?TjFXeGowTHR3ZzRmaUNHSlZkUWFESDE2UzhGWmlFK1dDUWxKTXNpZE9HQStN?=
 =?utf-8?B?WEoxZWIwMnNldU0xcXFNbGtRYWdabUdHclFsUDNEQi92ZVV6MlFpdll0MStF?=
 =?utf-8?B?YUtCWWFFTjJ2YmVnekxNOElQRjFvLzZhMEcxWUhlK0UzWGFHQjlwQjdEOEdK?=
 =?utf-8?B?bTdiakZlS05mQ0x1bVdpWnVwd0FKN1ZLVjd2YStLOFN3WlB6SFRON3p6QlBT?=
 =?utf-8?B?NkxxanJzUWliR3grcmk2ZGs4eHJGdjJmVEhhWXAwb0FneS90ZDlmYkdDSU14?=
 =?utf-8?B?SFJYYUxzTnNzWDZRMXhuQ0p4YjNpa2lTNXRqOUdTYnBwK0N4bkltQzBQRjJu?=
 =?utf-8?B?OVRGK2x4b2hlUS9qdjN3blFGSjh5MkVFUG5GdVZKSkRDV2xHd2hkdnpkWW9u?=
 =?utf-8?B?VTgrTVE2WlN6ZnVyTXBsdGxNdkNMKzJMdzB0TkZsZ2dxVDE2RTBjTjNleTYv?=
 =?utf-8?B?b0JSUk9DdktBaEhFd0JWY0RkZVBFSWJxOG1uS0tJanY5SzJIZWZCazBXNFRX?=
 =?utf-8?B?bm9YS1p0VldpKzl4QnNzZFh3dFd1cS9ucWpaNVN6QVNoZzdEc2lHSlh0dktz?=
 =?utf-8?B?elRHOUdxd3FBblF6SStjN1ZuRDYxdG01OXcyRkozSFgvMXNPeHBlWXh2eEJz?=
 =?utf-8?B?Q0Z0T1dDTXVXdkx4bTRiOUVNaHViMVd0aUtXQjhFTGlva1ZWUW1VNlk3S3Vp?=
 =?utf-8?B?bWc2bnNKeUtLdWJKK1ZVMU9KVC9FQ0Fpcm5MTFgvZ3RtYXIwQU8vMXZ5Tmhk?=
 =?utf-8?B?dkliaVdudW9OMlpUNjFrMjFFK21aNUYyeHVGRXNKWS84eis5Qkdab2VYSnlP?=
 =?utf-8?Q?0Q1fkqtSXC6reDAsfv4CDQN74QK?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L05kY0QvRDYxY2M0bTk0azN3T3UrU0ZTR3Y3ZTRJcktpUTZVOFBha3pDWDNR?=
 =?utf-8?B?ZmhjTG5JbWhlUUU1dG9kMTdKeXp5cDNmYjBHcSs1Ky9DUEY1Vngzam5UMDRJ?=
 =?utf-8?B?dm9LWHE3b3lyM0djSG90MlB5QUsvdE9lQ2hjQ0dVUEh1QmFvY3N0aDY1Z09T?=
 =?utf-8?B?VUpXVzFIMTFBVnQveUhsYjFXcDFqdURzVWZweStHV3Iwc0taSm50SXM1TXEz?=
 =?utf-8?B?K3hVOEVrRzRiNUVvalZwTk90d0N2aENxU3h4c1VGQTBxRXBpZmpNbzI5NlND?=
 =?utf-8?B?ZVRWamR6NUxOMGU0WjBPa2xSUnRna1JNbThaQVJpYXFJK0VzV2QwY0YxbzNj?=
 =?utf-8?B?RVYwNTdPb25sTWRDRUROYU9ocHJTalh6R1FhVW1JelN6Z3d2K1FTbTFremZ1?=
 =?utf-8?B?QzBmQXBhQ0Q4SG9JbDRvODhCbnhMdTZLYVdNM0F3SE1IRE8zdklERFRocks2?=
 =?utf-8?B?V1MzblNSYmx0dWlzMTlmcnNLZElLZzNvMkZMa3V1NmczRGNsR3phWm95dTNG?=
 =?utf-8?B?MGJ5Z1VRdVJsU0NsSm5VaEtyS1QxT2ttT3Q5R2I2c2xQWjFLWTdTaFdVbjhn?=
 =?utf-8?B?KzVmZ0gwOFlQZ0Y4Q0FsRGVKQkc0bm1YL2x4RnRCd2FtZHpDZzNsTktvT3dS?=
 =?utf-8?B?YXdxRkpFd2hkajA2NUQyeEloeFQ0bC83UUZLRGtTZG0wK1RZQVQzNHIza1FJ?=
 =?utf-8?B?U2g1UEU2eGJpRHdGNXoyaG92Si9vajJqMnd5TE1QWUlJclJJNVkrZ0M5UWJS?=
 =?utf-8?B?VVBFNEhTTVJSaGludnVUcUsyZ0ZDZUlJUDRDZjhpU2pqMEhvT0RDeElZeVVB?=
 =?utf-8?B?UkZVS25rdjExRWdsL0xLRU1uZ1NLSlFaanF4bXEzVWZwdktYemliUG0zREpJ?=
 =?utf-8?B?SjFsVmtLTWhPeXJXV2lSbkc4bHErT3NRY3BpWTJtREIyWXQ0cmpRYWxHNlhX?=
 =?utf-8?B?MW1rQ3RsTStJNVJ4RUlkRTFvWk1hTTc2RFl0emVwdEhJRXNrUTJPWjQ2TkFI?=
 =?utf-8?B?T1Y1Q0VWajNmajJUcDhEM0g0U1l5NmUxbzY0QjRqNTdHWFFnVjJ0d1JDUlpP?=
 =?utf-8?B?U1JIaXRRU21zOENyOGFnU2ZvU1oxeWJXN2pnd3pZdGVaMnJuRUt0akNRNHBu?=
 =?utf-8?B?aHlCTGZpbU1UTFI5Y1JWcHUrVmN3a0VwanJqNjk4cGQzUzhRTVFZcktHcnFp?=
 =?utf-8?B?MVZReDFvZTZpdzdOa0luaFBwcm13K0sxVWRHREtia3hxU2pCUzBVd3ZUMG9v?=
 =?utf-8?B?dGV5Sk51VTlTbWlQYmxBMWhQYmU3WHBMVWZ6ZmdTc29KL29QVTdjZXQ2bGVi?=
 =?utf-8?B?M01pYzBITUQ2Q3ZJMVhSdmxaR3JWVHdydjBaTU1Dbmwydm8xaXVDWGFVVXA3?=
 =?utf-8?B?c2xFaXlpNUE1bExjbzVEclV3ZUlOcGlyUCsrNzlzbmdoend5WENaTkJKYjlr?=
 =?utf-8?B?RC8wYVFXSTNaUUdzVFRCeDFZMGg0R0hWdnF1TXJJN3RwM2ZNTFNIUUNRa2x5?=
 =?utf-8?B?aENrTCtJRnJGejNpZzIxMTFnQ0pOR09tWFRZR09KUTJwQ1REWTNOQlhTVG1o?=
 =?utf-8?B?SU5YaEEyYUcyak95Q2tiRzFkN3h2eHFBZTg0OTh1SFFqZXdBeWFIZ3hFQmpo?=
 =?utf-8?B?dFFCaXgwcUVNZjVQaXoyc202dkxQNU9qWFBBbDJ1ZUFlMkZpelBVUUs4SnF1?=
 =?utf-8?B?SWMrL0UwQ0s5Ujh2OURxYXppdjBjMmJPR0ZmRzkwZjk4TXhYbExpbHRncEpW?=
 =?utf-8?B?WWhjZTBWNnVkY1FhZVNMaHZ0RGJOeTZmOXR2WEFWaW55bjZ4Q25HVjlkbDdC?=
 =?utf-8?Q?PLv1Mubct9NCYOhr5IbjK1w8LnGtSguXceOeM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f494b7-cbc8-4759-710d-08de91affefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 18:37:01.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9504
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9967-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4083E39754B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlk
YXksIEFwcmlsIDMsIDIwMjYgMTI6MjUgQU0NCj4gDQoNCk5pdDogSSB3b25kZXIgd2hhdCdzIHRo
ZSBiZXN0IHByZWZpeCB0byB1c2UgaW4gdGhlIHBhdGNoIFN1YmplY3QgZmllbGQuDQoiRHJpdmVy
czogaHY6IG1zaHZfdnRsOiIgaXMgcmF0aGVyIGxvbmcuICBUaGVyZSB3YXMgYWdyZWVtZW50IHRv
IHVzZQ0KanVzdCAibXNodjoiIGZvciB0aGUgcm9vdCBwYXJ0aXRpb24gY29kZSwgYW5kIEkgcHJv
YmFibHkgbWlzdXNlZCB0aGF0DQppbiBjb21taXQgNzU0Y2Y4NDUwNGVhLiBIb3cgYWJvdXQganVz
dCAibXNodl92dGw6IiBhcyB0aGUgcHJlZml4IGZvciB0aGlzDQpwYXRjaCBhbmQgb3RoZXIgVlRM
IHBhdGNoZXMgZ29pbmcgZm9yd2FyZD8NCg0KPiBPbiA0LzMvMjAyNiA5OjA1IEFNLCBNaWNoYWVs
IEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4Lm1pY3Jv
c29mdC5jb20+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMxLCAyMDI2IDEwOjQwIFBNDQo+ID4+DQo+
ID4+IFdoZW4gcmVnaXN0ZXJpbmcgVlRMMCBtZW1vcnkgdmlhIE1TSFZfQUREX1ZUTDBfTUVNT1JZ
LCB0aGUga2VybmVsDQo+ID4+IGNvbXB1dGVzIHBnbWFwLT52bWVtbWFwX3NoaWZ0IGFzIHRoZSBu
dW1iZXIgb2YgdHJhaWxpbmcgemVyb3MgaW4gdGhlDQo+ID4+IE9SIG9mIHN0YXJ0X3BmbiBhbmQg
bGFzdF9wZm4sIGludGVuZGluZyB0byB1c2UgdGhlIGxhcmdlc3QgY29tcG91bmQNCj4gPj4gcGFn
ZSBvcmRlciBib3RoIGVuZHBvaW50cyBhcmUgYWxpZ25lZCB0by4NCj4gPj4NCj4gPj4gSG93ZXZl
ciwgdGhpcyB2YWx1ZSBpcyBub3QgY2xhbXBlZCB0byBNQVhfRk9MSU9fT1JERVIsIHNvIGENCj4g
Pj4gc3VmZmljaWVudGx5IGFsaWduZWQgcmFuZ2UgKGUuZy4gcGh5c2ljYWwgcmFuZ2UgMHg4MDAw
MDAwMDAwMDAtDQo+ID4+IDB4ODAwMDgwMDAwMDAwLCBjb3JyZXNwb25kaW5nIHRvIHN0YXJ0X3Bm
bj0weDgwMDAwMDAwMCB3aXRoIDM1DQo+ID4+IHRyYWlsaW5nIHplcm9zKSBjYW4gcHJvZHVjZSBh
IHNoaWZ0IGxhcmdlciB0aGFuIHdoYXQNCj4gPj4gbWVtcmVtYXBfcGFnZXMoKSBhY2NlcHRzLCB0
cmlnZ2VyaW5nIGEgV0FSTiBhbmQgcmV0dXJuaW5nIC1FSU5WQUw6DQo+ID4+DQo+ID4+ICAgIFdB
Uk5JTkc6IC4uLiBtZW1yZW1hcF9wYWdlcysweDUxMi8weDY1MA0KPiA+PiAgICByZXF1ZXN0ZWQg
Zm9saW8gc2l6ZSB1bnN1cHBvcnRlZA0KPiA+Pg0KPiA+PiBUaGUgTUFYX0ZPTElPX09SREVSIGNo
ZWNrIHdhcyBhZGRlZCBieQ0KPiA+PiBjb21taXQgNjQ2YjY3ZDU3NTg5ICgibW0vbWVtcmVtYXA6
IHJlamVjdCB1bnJlYXNvbmFibGUgZm9saW8vY29tcG91bmQNCj4gPj4gcGFnZSBzaXplcyBpbiBt
ZW1yZW1hcF9wYWdlcygpIikuDQo+ID4+IFdoZW4gQ09ORklHX0hBVkVfR0lHQU5USUNfRk9MSU9T
PXksIENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUD15LCBhbmQNCj4gPj4gQ09ORklHX0hVR0VUTEJf
UEFHRSBpcyBub3Qgc2V0LCBNQVhfRk9MSU9fT1JERVIgcmVzb2x2ZXMgdG8NCj4gPj4gKFBVRF9T
SElGVCAtIFBBR0VfU0hJRlQpID0gMTguIEFueSByYW5nZSB3aG9zZSBQRk4gYWxpZ25tZW50IGV4
Y2VlZHMNCj4gPj4gb3JkZXIgMTggaGl0cyB0aGlzIHBhdGguDQo+ID4NCj4gPiBJJ20gbm90IGNs
ZWFyIG9uIHdoYXQgcG9pbnQgeW91IGFyZSBtYWtpbmcgd2l0aCB0aGlzIHNwZWNpZmljDQo+ID4g
Y29uZmlndXJhdGlvbiB0aGF0IHJlc3VsdHMgaW4gTUFYX0ZPTElPX09SREVSIGJlaW5nIDE4LiBJ
cyBpdCBqdXN0DQo+ID4gYW4gZXhhbXBsZT8gSXMgMTggdGhlIGxhcmdlc3QgZXhwZWN0ZWQgdmFs
dWUgZm9yIE1BWF9GT0xJT19PUkRFUj8NCj4gPiBBbmQgbm90ZSB0aGF0IFBVRF9TSElGVCBhbmQg
UEFHRV9TSElGVCBtaWdodCBoYXZlIGRpZmZlcmVudCB2YWx1ZXMNCj4gPiBvbiBhcm02NCB3aXRo
IGEgcGFnZSBzaXplIG90aGVyIHRoYW4gNEsuDQo+ID4NCj4gDQo+IFllcywgdGhpcyB3YXMganVz
dCBhbiBleGFtcGxlLiBJdCBpcyBub3QgZ2VuZXJhbGl6ZWQgZW5vdWdoLCBJIHdpbGwNCj4gcmVt
b3ZlIGl0Lg0KPiBNQVhfRk9MSU9fT1JERVIgY291bGQgZ28gYmV5b25kIDE4Lg0KPiANCj4gPj4N
Cj4gPj4gRml4IHRoaXMgYnkgY2xhbXBpbmcgdm1lbW1hcF9zaGlmdCB0byBNQVhfRk9MSU9fT1JE
RVIgc28gd2UgYWx3YXlzDQo+ID4+IHJlcXVlc3QgdGhlIGxhcmdlc3Qgb3JkZXIgdGhlIGtlcm5l
bCBzdXBwb3J0cywgcmF0aGVyIHRoYW4gYW4NCj4gPj4gb3V0LW9mLXJhbmdlIHZhbHVlLg0KPiA+
Pg0KPiA+PiBBbHNvIGZpeCB0aGUgZXJyb3IgcGF0aCB0byBwcm9wYWdhdGUgdGhlIGFjdHVhbCBl
cnJvciBjb2RlIGZyb20NCj4gPj4gZGV2bV9tZW1yZW1hcF9wYWdlcygpIGluc3RlYWQgb2YgaGFy
ZC1jb2RpbmcgLUVGQVVMVCwgd2hpY2ggd2FzDQo+ID4+IG1hc2tpbmcgdGhlIHJlYWwgLUVJTlZB
TCByZXR1cm4uDQo+ID4+DQo+ID4+IEZpeGVzOiA3YmZlM2I4ZWE2ZTMgKCJEcml2ZXJzOiBodjog
SW50cm9kdWNlIG1zaHZfdnRsIGRyaXZlciIpDQo+ID4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVs
Lm9yZz4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNy
b3NvZnQuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL2h2L21zaHZfdnRsX21haW4uYyB8
IDggKysrKysrLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9tc2h2X3Z0bF9t
YWluLmMgYi9kcml2ZXJzL2h2L21zaHZfdnRsX21haW4uYw0KPiA+PiBpbmRleCA1ODU2OTc1ZjMy
ZTEyLi4yNTVmZWQzYTc0MGMxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2h2L21zaHZfdnRs
X21haW4uYw0KPiA+PiArKysgYi9kcml2ZXJzL2h2L21zaHZfdnRsX21haW4uYw0KPiA+PiBAQCAt
NDA1LDggKzQwNSwxMiBAQCBzdGF0aWMgaW50IG1zaHZfdnRsX2lvY3RsX2FkZF92dGwwX21lbShz
dHJ1Y3QgbXNodl92dGwgKnZ0bCwgdm9pZCBfX3VzZXIgKmFyZykNCj4gPj4gICAJLyoNCj4gPj4g
ICAJICogRGV0ZXJtaW5lIHRoZSBoaWdoZXN0IHBhZ2Ugb3JkZXIgdGhhdCBjYW4gYmUgdXNlZCBm
b3IgdGhlIGdpdmVuIG1lbW9yeSByYW5nZS4NCj4gPj4gICAJICogVGhpcyB3b3JrcyBiZXN0IHdo
ZW4gdGhlIHJhbmdlIGlzIGFsaWduZWQ7IGkuZS4gYm90aCB0aGUgc3RhcnQgYW5kIHRoZSBsZW5n
dGguDQo+ID4+ICsJICogQ2xhbXAgdG8gTUFYX0ZPTElPX09SREVSIHRvIGF2b2lkIGEgV0FSTiBp
biBtZW1yZW1hcF9wYWdlcygpIHdoZW4gdGhlIHJhbmdlDQo+ID4+ICsJICogYWxpZ25tZW50IGV4
Y2VlZHMgdGhlIG1heGltdW0gc3VwcG9ydGVkIGZvbGlvIG9yZGVyIGZvciB0aGlzIGtlcm5lbCBj
b25maWcuDQo+ID4+ICAgCSAqLw0KPiA+PiAtCXBnbWFwLT52bWVtbWFwX3NoaWZ0ID0gY291bnRf
dHJhaWxpbmdfemVyb3ModnRsMF9tZW0uc3RhcnRfcGZuIHwgdnRsMF9tZW0ubGFzdF9wZm4pOw0K
PiA+PiArCXBnbWFwLT52bWVtbWFwX3NoaWZ0ID0gbWluX3QodW5zaWduZWQgbG9uZywNCj4gPj4g
KwkJCQkgICAgIGNvdW50X3RyYWlsaW5nX3plcm9zKHZ0bDBfbWVtLnN0YXJ0X3BmbiB8IHZ0bDBf
bWVtLmxhc3RfcGZuKSwNCj4gPj4gKwkJCQkgICAgIE1BWF9GT0xJT19PUkRFUik7DQo+ID4NCj4g
PiBJcyBpdCBuZWNlc3NhcnkgdG8gdXNlIG1pbl90KCkgaGVyZSwgb3Igd291bGQgbWluKCkgd29y
az8gIE5laXRoZXIgY291bnRfdHJhaWxpbmdfemVyb3MoKQ0KPiA+IG5vciBNQVhfRk9MSU9fT1JE
RVIgaXMgZXZlciBuZWdhdGl2ZSwgc28gaXQgc2VlbXMgbGlrZSBqdXN0IG1pbigpIHdvdWxkIHdv
cmsgd2l0aA0KPiA+IG5vIHBvdGVudGlhbCBmb3IgZG9pbmcgYSBib2d1cyBjb21wYXJpc29uIG9y
IGFzc2lnbm1lbnQuDQo+ID4NCj4gDQo+IG1pbiBjb3VsZCB3b3JrLCB5ZXMuIEkganVzdCBmZWx0
IG1pbl90IGlzIG1vcmUgc2FmZXIgZm9yIGNvbXBhcmluZyB0aGVzZQ0KPiB0d28gZGlmZmVyZW50
IHR5cGVzIG9mIHZhbHVlcyAtDQo+IGNvdW50X3RyYWlsaW5nX3plcm9lcyBiZWluZyAnaW50Jw0K
PiBNQVhfRk9MSU9fT1JERVIgYmVpbmcgYSBtYWNybywgY2FsY3VsYXRlZCBieSBhcHBseWluZyBi
aXQgb3BlcmF0aW9ucy4NCj4gDQo+IGFuZCBkZXN0aW5hdGlvbiBiZWluZyB1bnNpZ25lZCBpbnQu
DQo+IA0KPiANCj4gaW5jbHVkZS9saW51eC9tbXpvbmUuaDojZGVmaW5lIE1BWF9GT0xJT19PUkRF
UiAgICAgICAgICBNQVhfUEFHRV9PUkRFUg0KPiBpbmNsdWRlL2xpbnV4L21tem9uZS5oOiNkZWZp
bmUgTUFYX0ZPTElPX09SREVSICAgICAgICAgIFBGTl9TRUNUSU9OX1NISUZUDQo+IGluY2x1ZGUv
bGludXgvbW16b25lLmg6I2RlZmluZSBNQVhfRk9MSU9fT1JERVIgICAgICAgICAgKGlsb2cyKFNa
XzE2RykgLSBQQUdFX1NISUZUKQ0KPiBpbmNsdWRlL2xpbnV4L21tem9uZS5oOiNkZWZpbmUgTUFY
X0ZPTElPX09SREVSICAgICAgICAgIChpbG9nMihTWl8xRykgLSBQQUdFX1NISUZUKQ0KPiBpbmNs
dWRlL2xpbnV4L21tem9uZS5oOiNkZWZpbmUgTUFYX0ZPTElPX09SREVSICAgICAgICAgIChQVURf
U0hJRlQgLSBQQUdFX1NISUZUKQ0KPiANCj4gSSBhbSBmaW5lIHdpdGggYW55dGhpbmcgeW91IHN1
Z2dlc3QgaGVyZS4NCg0KVGhlcmUncyBhIGZhaXIgbnVtYmVyIG9mIHBhdGNoZXMgb24gTEtNTCB0
aGF0IGFyZSByZXBsYWNpbmcgbWluX3QoKSB3aXRoDQptaW4oKS4gIEF0IHNvbWUgcG9pbnQgaW4g
dGhlIG5vdC10b28tZGlzdGFudCBwYXN0LCB0aGUgaW1wbGVtZW50YXRpb24gb2YNCm1pbigpIHdh
cyBpbXByb3ZlZCB0byBkZWFsIHdpdGggZGlmZmVyZW50IGJ1dCBjb21wYXRpYmxlIGludGVnZXIg
dHlwZXMuDQpNeSBzZW5zZSBpcyB0aGF0IG1pbigpIGlzIHRoZSBiZXR0ZXIgY2hvaWNlIGZvciBn
ZW5lcmFsIGludGVnZXIgY29tcGFyaXNvbnMsDQpwYXJ0aWN1bGFybHkgd2hlbiB0aGUgdmFsdWVz
IGFyZSBrbm93biB0byBiZSBub24tbmVnYXRpdmUuDQoNCj4gDQo+ID4gVGhlIHNoaWZ0IGlzIGNh
bGN1bGF0ZWQgdXNpbmcgdGhlIG9yaWdpbmFsbHkgcGFzc2VkIGluIHN0YXJ0X3BmbiBhbmQgbGFz
dF9wZm4sIHdoaWxlIHRoZQ0KPiA+ICJyYW5nZSIgc3RydWN0IGluIHBnbWFwIGhhcyBhbiAiZW5k
IiB2YWx1ZSB0aGF0IGlzIG9uZSBwYWdlIGxlc3MuIFNvIGlzIHRoZSBpZGVhIHRvDQo+ID4gZ28g
YWhlYWQgYW5kIGNyZWF0ZSB0aGUgbWFwcGluZyB3aXRoIGZvbGlvcyBvZiBhIHNpemUgdGhhdCBp
bmNsdWRlcyB0aGF0IGxhc3QgcGFnZSwNCj4gPiBhbmQgdGhlbiBqdXN0IHdhc3RlIHRoZSBsYXN0
IHBhZ2Ugb2YgdGhlIGxhc3QgZm9saW8/DQo+IA0KPiBObywgd2FzdGUgZG9lcyBub3Qgb2NjdXIu
IFRoZSB2bWVtbWFwX3NoaWZ0IGRldGVybWluZXMgdGhlIGZvbGlvIG9yZGVyLA0KPiBhbmQgbWVt
bWFwX2luaXRfem9uZV9kZXZpY2UoKSB3YWxrcyB0aGUgcmFuZ2UgW3N0YXJ0X3BmbiwgbGFzdF9w
Zm4pIGluDQo+IHN0ZXBzIG9mICgxIDw8IHZtZW1tYXBfc2hpZnQpIHBhZ2VzLCBjcmVhdGluZyBv
bmUgZm9saW8gcGVyIHN0ZXAuIFRoZSBPUg0KPiBvcGVyYXRpb24gZW5zdXJlcyBib3RoIGJvdW5k
YXJpZXMgYXJlIGFsaWduZWQgdG8gbXVsdGlwbGVzIG9mICgxIDw8DQo+IHZtZW1tYXBfc2hpZnQp
LCBndWFyYW50ZWVpbmcgdGhlIHJhbmdlIGRpdmlkZXMgZXZlbmx5IGludG8gZm9saW9zIHdpdGgN
Cj4gbm8gcGFydGlhbCBmb2xpbyBhdCB0aGUgZW5kLg0KPiBUaGUgaW50ZW50aW9uIGlzIHRvIGZp
bmQgdGhlIGhpZ2hlc3QgZm9saW8gb3JkZXIgcG9zc2libGUgaGVyZSwgYW5kIGlmDQo+IGl0IHJl
YWNoZXMgdGhlIE1BWF9GT0xJT19PUkRFUiwgcmVzdHJpY3Qgdm1lbW1hcF9zaGlmdCB0byBpdC4N
Cg0KT0ssIEkgZmlndXJlZCBvdXQgd2hhdCBpcyBjb25mdXNpbmcgbWUuIEkgaGFkIGEgbWlzdW5k
ZXJzdGFuZGluZw0Kd2hlbiBJIHJldmlld2VkIHRoaXMgY29kZSBkdXJpbmcgaXRzIG9yaWdpbmFs
IHN1Ym1pc3Npb24sIGFuZCB0aGF0DQptaXN1bmRlcnN0YW5kaW5nIGhhcyBpbmZsdWVuY2VkIG15
IChpbmNvcnJlY3QpIHJldmlldyBvZiB0aGlzIGNoYW5nZS4NCg0KVGhlIHN0cnVjdCBtc2h2X3Z0
bF9yYW1fZGlzcG9zaXRpb24gdGhhdCBpcyBwYXNzZWQgZnJvbSB1c2VyIHNwYWNlIGhhcw0KdHdv
IGZpZWxkczogc3RhcnRfcGZuIGFuZCBsYXN0X3Bmbi4gQnV0IGxhc3RfcGZuIGlzIHNvbWV3aGF0
IG1pc25hbWVkDQppbiBteSB2aWV3LiBGb3IgZXhhbXBsZSwgYW4gYWxpZ25lZCAyIE1pQiBvZiBt
ZW1vcnkgd291bGQgY29uc2lzdCBvZg0KNTEyIFBGTnMuIElmIHRoZSBmaXJzdCBQRk4gaXMgMHgy
MDAsIHRoZSBsYXN0IFBGTiB3b3VsZCBiZSAweDNGRi4gIEJ1dCBpbg0KdGhlIHNlbWFudGljcyBv
ZiB0aGUgc3RydWN0LCB0aGUgbGFzdF9wZm4gZmllbGQgc2hvdWxkIGJlIDB4NDAwLg0KDQpJbiBy
ZXNwb25zZSB0byBteSBjb21tZW50cyBpbiB0aGUgb3JpZ2luYWwgcmV2aWV3LCB5b3UgYWRkZWQg
dGhlIGNvbW1lbnQNCmFib3V0IGxhc3RfcGZuIGJlaW5nIGV4Y2x1ZGVkIGluIHRoZSBwYWdlbWFw
IHJhbmdlLCB3aGljaCBpcyB0cnVlLiBCdXQgaXQncw0Kbm90IGJlY2F1c2UgdGhhdCBwYWdlIGlz
IHNvbWVob3cgcmVzZXJ2ZWQgb3IgYmVpbmcgd2FzdGVkLiBJdCdzIGJlY2F1c2UNCnRoZSByYW5n
ZSBpcyBiZWluZyBkZXNjcmliZWQgYnkgc3BlY2lmeWluZyB0aGUgUEZOICphZnRlciogdGhlIGxh
c3QgUEZOLg0KDQpXaXRoIHRoZSBzdGFydF9wZm4gYW5kIGxhc3RfcGZuIGZpZWxkcyB1c2VkIHRv
IGRldGVybWluZSB0aGUgaGlnaGVzdA0KcGFnZSBvcmRlciB0aGF0IGNhbiBiZSB1c2VkLCB0aGUg
c2xpZ2h0bHkgdW5vcnRob2RveCBzZW1hbnRpY3Mgb2YNCmxhc3RfcGZuIG1ha2UgdGhhdCBjYWxj
dWxhdGlvbiBlYXN5LiBCdXQgdGhlbiB5b3UgbXVzdCBzdWJ0cmFjdCAxDQpmcm9tIGxhc3RfcGZu
IHdoZW4gc2V0dGluZyB0aGUgcmFuZ2Ugc3RhcnQgYW5kIGVuZCBmb3INCmRldm1fbWVtcmVtYXBf
cGFnZXMoKSB0byB1c2UuIEFuZCB0aGUgY29kZSBkb2VzIHRoYXQsIHNvIHRoZSBjb2RlDQppcyBh
bGwgY29ycmVjdC4gVGhlIGNvbW1lbnQgbWlnaHQgYmUgaW1wcm92ZWQgdG8gc3BlYWsgYWJvdXQg
dGhlDQpzZW1hbnRpY3Mgb2YgdGhlIGxhc3RfcGZuIGZpZWxkLCBub3QgdGhhdCBhIHBhZ2Ugb2Yg
bWVtb3J5IGlzDQppbnRlbnRpb25hbGx5IGJlaW5nIGV4Y2x1ZGVkL3dhc3RlZC4gIEFuZC9vciBt
YXliZSB0aGUgc3RydWN0DQptc2h2X3Z0bF9yYW1fZGlzcG9zaXRpb24gZGVmaW5pdGlvbiBzaG91
bGQgZ2V0IGEgY29tbWVudCB0byBjbGFyaWZ5DQp0aGUgc2VtYW50aWNzIG9mIGxhc3RfcGZuLg0K
DQpNaWNoYWVsDQo=

