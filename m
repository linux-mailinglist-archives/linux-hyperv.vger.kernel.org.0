Return-Path: <linux-hyperv+bounces-10838-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLRiAcaYBGqILwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10838-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 17:29:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2525361F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F129C30D1F72
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24147CC96;
	Wed, 13 May 2026 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IIi16uYS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011007.outbound.protection.outlook.com [52.103.1.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30D47B42E;
	Wed, 13 May 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685214; cv=fail; b=lmfse6ySgCBTDsLnodbJjWgz9rX1GzI9XA357SpUTqS2Hq8lds8rlGQVWqS2X9ereRbJDYG+QCRMj56G0ZD9kk9g7yJJgBTsT/XPfNXyIp6t/LKx1qy/E6NraC66LMh0WOgOEzawlR37D4/M4pSy/mhcHn5hX/3PzKO4Terc7sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685214; c=relaxed/simple;
	bh=T4FOQo06HtnRKfstQMamwdQaZFvT8rgQulimFIek7Rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hNJKMm67V+7sTFTa9lTPTFJy+x5LV5jaak/OwRs1VbHG0skdZ1J7xYHrJqWr/lpAG862AzYQ/cvBzIOWZZukI616PC8kyDTJK8Bsj+tH1KAuN3YX541VZcNFeLtlZEq5ClZ6JZ8wf+f9b994UgGRS5D+PIVW7RCmKfn4SHwy6YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IIi16uYS; arc=fail smtp.client-ip=52.103.1.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBb61tPnY6yWMAcNVmIkikf200mqsNl3J8rQGt11vyVZGcN5oyaJUIkegx9oVgjHWBsr8SRx1x+bNTNd4QzskxEQ+HGokOfUB+zARs0/hedsMtA5mUesxgqRJTU9i8nbrdD8mSX16O3XXWcDBXYOPUhsjIER4zRrDqdYmkyQYRG3F5BtVTuNts6TEmVAjZ4UK5/hs/hO/ISP3aZSQ5APYpxaGNoMXkimoJZOInJtdEGtRQXu37JV2kMIpvDf3vxbrniHWF/BrzKKYvf9YLvs5d+wXcOSr3QKUypP+TqpR3cFBLt7RoHp8kyTzibG/Gnuq8jQkAc2J3a42D6YkLx3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4FOQo06HtnRKfstQMamwdQaZFvT8rgQulimFIek7Rg=;
 b=lyKh0AdXFVzzmfZs6zmsvWqqRZiEeYDWAYf4hQLZbknbCRPP6aexLv4LPY3Rst95yhsZsz/X3wZBMzJYAsGIoG5YxiIRsw2RljgwQU7a3BuhE+SzlP7nzZpG0MsItIOagduQihtaylC2GLrt5iz+o46TZ/SjkNAUBrP2XOijKW9ESP4HD2oJ9GEcdjKFez0oJ2LdOAdVmnQZvT1VtRma23u5cnR5h8sAcN0+NyXIukfYcvdofThyvVphb/fwl2lkhYsijkwdtzfnXIjiQuI3vbbUawmvafNeK1fptDfIRWKs35co/N8q1ga65KwfzOa/4jdIk1e7e4e1XMtMrROs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4FOQo06HtnRKfstQMamwdQaZFvT8rgQulimFIek7Rg=;
 b=IIi16uYSsnT24g/Hr6wAtr65vf7++Ek9x+XWBieRvOfixxKTCYsiTMzMomX5H2CC0+3TPTQkldWXwvgkmeLQwyJcHEyJwc4O+ytdi2Fn4VSIxV43/ey2UmYIq1/+KSNhxa+CszvbyRrINogf6TFlChpYdvNmgg/5tabGIdxmTGNPuz6nijJT5sxojvvD9eQPGQpLaAX3hvkK2/UkWSu9D1uPYSaYXFWlIuosF4x2u9WJMOeXXNiIhTnhRxywC8R0+GLOeRsBjGzt6ypBLQPsBIUN1FcOzdf/YNBWZiTOWOBMgc1d9wH2kNjGQob8WhAkl2QclnfenrDOxjKuOULTpA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7516.namprd02.prod.outlook.com (2603:10b6:806:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:13:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:13:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v4] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Thread-Topic: [PATCH v4] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Thread-Index: AQJSqS6bvXIes9Gm8Dcno9BnG5suPbUgg0XQ
Date: Wed, 13 May 2026 15:13:28 +0000
Message-ID:
 <SN6PR02MB41573F5F2B9CDC4EB4D1E306D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260513-huge_1g-v4-1-33cda59e4a70@anirudhrb.com>
In-Reply-To: <20260513-huge_1g-v4-1-33cda59e4a70@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7516:EE_
x-ms-office365-filtering-correlation-id: 3161d472-67a9-4958-30f9-08deb1023026
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|19101099003|51005399006|13091999003|12121999013|55001999006|31061999003|41001999006|8062599012|8060799015|19110799012|15080799012|19061999003|1602099012|40105399003|440099028|4302099013|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHFWdW5DVCtwaG5wMktZemJCVW9XbWxKQjFvYUtUWlZic2VpVUduaXZtV1RM?=
 =?utf-8?B?aiszSXV1ZUlpaTIzRkpDN0NWN3F6aG1tbzF3YktKRmZXbVNFUXF0VW1DN1Fv?=
 =?utf-8?B?emVqMzN6ZHd0dkdlclR1TWRTMmJHeEFPRXNUM1BlSkQ2bnpuZmlWNFRGYnNQ?=
 =?utf-8?B?RS9RVG5VaHFFSmZWVy9pWDZtL0kzVWxyWVlHTWNLRWQ2L0l2V3RsL2xzdHE4?=
 =?utf-8?B?cmV4clR2L2xsYjZGU1o3TXpQZjlxQklSWllBYmlhRTFFM1BVNFY4N21PWWJh?=
 =?utf-8?B?VERtVjlnR2xJamtjc282WGRLSUZnMUcwSXhBRFpmWURkQzZIcVBQVDlDWEhD?=
 =?utf-8?B?WmdvaWVkc1Y1ak1pRGFrMCs3SkZOalZRcFNlcWxZVVBMMDdvd0NpOStUck9C?=
 =?utf-8?B?eEZRYWZSbHlxNFY2MXNSeTFjU01iZGFyYXMwVXQzZzQ4TGljMW9Lc0xZOWtN?=
 =?utf-8?B?cTFuNHpiclppcW9uSitxSUVsdTM1VEpaVGtIbTFiUDg4MmN5elRxRlh5Qzd3?=
 =?utf-8?B?ZTV4ZVkxMURaZ2lOK2JRY0c3YVNmeURhMm1RTUdqUUlsMXVlMDBRcXNwUTQ4?=
 =?utf-8?B?SGUyajd4R1RLNlJyak4wVkFvTGRFSzhKVlZKWElvNTVCbFQ4Kzg0L0RxNW9a?=
 =?utf-8?B?d0lCR2lBQlNPZG1sTXZIYS8xWlpKUWNkeTliWmRndVg2Q2RZZ29TaHNjdU9O?=
 =?utf-8?B?MXpkU1lrNFA0MC9LaXhGV21rdGQrRjlidnJqL3ZzT24rdlNxU1p0azIxc29L?=
 =?utf-8?B?Y1NjMzRkUGU5VWoweFhDSEg4MDVQRGJYRFFGMktHRU50bWdianZjWFo1MnZo?=
 =?utf-8?B?UTVLY3U4NzlIM05JVG5VVzlsZGpuRHBEcHRTYTZrSWd4cnFSNVVzUjQ2Q1da?=
 =?utf-8?B?eUZaRFk0cnZJMVgvL0k4bkVEUmg4bjI0RWVua05aZkhrWDZNN1Y2UkFTbGdv?=
 =?utf-8?B?b0FjdHI0bmdicmtjbWNpMzY4K2R5dkk2M3RVMm1maHRDUStVUVc0YWRVbmpj?=
 =?utf-8?B?NGNreDVqODE5aTBJNmUxa3BhR2VCTWk5QUp0QTVQdnF6UE5hV0xLenY1dFVB?=
 =?utf-8?B?a1lRb25nR3hvcThaTUsyTGkxNHdZT2tOTzdrUFNrbnZmTmd2YmxDbVFPNFpK?=
 =?utf-8?B?cjZSbjN6SEtkbW8vQXNBS0t6NU1KTTBDeFZobW9Dd0FMTmt3dTQwUG1LbTlr?=
 =?utf-8?B?ZUN0a2RhQTVISVMwUGRveVN0YTFlaEIxVk9saHhoTFliSGhMKy9MU1Q4SmxT?=
 =?utf-8?B?alRSd1JJZy9VaVNkejhwS05VZ09HWnB0bDBDQ3FROHR0UUxlU1F1UDRaSjg3?=
 =?utf-8?B?NGlwVm5LSjl2elJkdUcxbFFqVXFxSjdmVzA4bDA1WGsvQkFJbnUySkVXZ2tw?=
 =?utf-8?B?WXpVRTFXclRYNUl1WDdtUDhWR2ZKbnFQcXRuMzdZMStsZDRBNWdiWE4vMXpH?=
 =?utf-8?B?VGZJWkNuZHdKRDRlTDVPVjNNTFpVMGNiTVM5Nzhid04vVkxuTDNJdmlZdGN6?=
 =?utf-8?B?Z1pGSkxYeEYzQWV6QzhmcDJlRkZReUJWclZMcVFtdGhJbjZydWQ2M2hRM1RN?=
 =?utf-8?B?Zzd3bEplNDVjM05GNEMwS2R5MzBWekxkTXhYcU9tSjcyalFuc0RaTjZMelE4?=
 =?utf-8?Q?1AYYYaeDpTcS0vcc5Ljh34NUjAGp0CZ28XnJmnrzdHmM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVVSTHAyTDlQeVY0SXoxTmg4ZUd0cllVZ29sZVg3SVlKaEg5cmxMdGM0R3Q2?=
 =?utf-8?B?U0NIWkpKTXZRMGJ1MVVEZHNGcjl4VEdYV2JwYm5HaCtXMjlaOVErUzRKRWZ1?=
 =?utf-8?B?QXBDWkxlV0xjc1N3bGFGT3FSeGNVRDF1dHRJSTI0QkJyN0xSamUzL2QrcXVQ?=
 =?utf-8?B?UHl2YkI4YUFyOHprTGZzRDA0NExqa1VZWGl6UEQxOHFGRTV2OEUxV2dIaEZI?=
 =?utf-8?B?OEx6Smx3a2docXliN2hkRzd5NXlPcE5uQXU4ZmMyWUwxRnczUVEyTVloeDh6?=
 =?utf-8?B?SjVkVzc3RGJ0NjhsMGxWaHd5dEdrL3FPd0hOVVJGRWFhTzB0SlJmM0kwSFVM?=
 =?utf-8?B?bk0zN21CNDBMUFRLek1HWi8xWFpLZE5YQW5aQUg1ZjM5UXIxUkwrL2xHakU3?=
 =?utf-8?B?ZG5tbVFQbi9hZlFhbWUzUW5Dd0ZmL0g4cTljOGxZNkZLZExPRC9LcWZ2ci92?=
 =?utf-8?B?ZnNmL0RORFR2ejY2RktjMU5PM0VpREJIdkgwaGtiZkVOdFg1bGoxRVNjOTdO?=
 =?utf-8?B?bHN4RjVVbGt4dGxybzY4bWw3d1gxVTAvSnp5TlIrRUtubGZxQkYyOC9QVHNQ?=
 =?utf-8?B?amRsZXJHc3NmRGdNeFVJWVV6MnBzQjBkZ0QrM01WbklZelNQN1ZIQ0g0dU1I?=
 =?utf-8?B?Rit6WnJYYXhqZ0YyaUZZRytmNi9YUUVxcXFRSWwvZ0RVQ2ViWlFaajFHTDVP?=
 =?utf-8?B?YTh5Z3A3dm9janlDRFVVNXVaN2VBN0dacUF3UkFyNzdWTWxtVXFNdGZ1QmJQ?=
 =?utf-8?B?MTdCajJQZFFlamFWR1dyRCtJTmduWnFpQnAwKzJFbnNScGVLeFlCb0MxWmFO?=
 =?utf-8?B?T0syd0tjdjdDRHA3TDl0YUZEVWJXQ1lkS0tiM2kxS2NiRFZ6NUZ1eXpEa3ZF?=
 =?utf-8?B?OURoeXIvaDlRWk9HYllhUDlnUmdvdTcwbU5nb2ZhaHUzM2hRelc5cGpEN1hi?=
 =?utf-8?B?OG5sRHQzZlZBNVdldHFXc3hnREx2QzJYNGY4Z3NNTjhFNEpZRFZKVUp5bURC?=
 =?utf-8?B?Ky80MDJOcGJCR3pFZlpMU1ZUMXR5ekpZWEZkU3J6N0RzQjBMTE1rTUwvb1pn?=
 =?utf-8?B?OFVObEVGTXhkd1pjaUFzakRNR3JqMnpJaG01ZE8vUmlwTDRQcEduaytheWRw?=
 =?utf-8?B?MXZlWG9ybzl5b2pucEdEaC9XRVpVOVZpOUFkVjZhM3REZWFBVlpWNnZ5VVRl?=
 =?utf-8?B?S2hGMWNEbFpTdWpuaVE2a0NTTklmZ1Z5K09kOWRvNDZSeklxY3EwUTNRMTBT?=
 =?utf-8?B?d01DZE40dTZjTmc3TUtzSCtBSHMrNmlwNi9hajUzWnRNTVVHTlI3U1h4THlI?=
 =?utf-8?B?OERLZiswMTVXamJYT1JHaG1UbTFRNG5QZE01VWJlMXBNS3dBNEMzdkJzSGY4?=
 =?utf-8?B?V1B2bldJdUpKbUFwMGVVeitKblZuVUhCeDRYU3dDUjhteDNBRGoyc1lacnU3?=
 =?utf-8?B?M0RiMHBlZHRiaGVJU3hJb1c4R0FQY2Y1KzNmWllGcUJ0Q2ErM0hGa1hObnpD?=
 =?utf-8?B?WmpyU3pFQ09ZWUpxS1RVNHE4YVQ0NndrbHpyL1ZaSmlTaEM1dlB6NVZLbExn?=
 =?utf-8?B?T2RDaWZTMjIwL3VGbG1TUVFpNm9YczRwWDhtdjdSaVFtZUppVmlRYVlwYy9X?=
 =?utf-8?B?cWVRYnIvc1ZHcVpyK0lKZW8wcFlQZGFMK0gvN2NVa1NNNnRDdEYyWCthYmJB?=
 =?utf-8?B?M0ZTRHZQMnAveXNpRXBtc05oa3lCQ1FNUnZST1FqdGc5MzlVb2twaWFXSXNP?=
 =?utf-8?B?eFBLc0E4bWZGNDV5SXdxWC9GQ0lGL0VPQjFjc1JFa0ttYjNJdUo4am8xbUkv?=
 =?utf-8?Q?2m/DmJ4S2hqx4AbzDP6kB86beXS/2wEZSmOPY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3161d472-67a9-4958-30f9-08deb1023026
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 15:13:28.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7516
X-Rspamd-Queue-Id: 5F2525361F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10838-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim,anirudhrb.com:email]
X-Rspamd-Action: no action

RnJvbTogQW5pcnVkaCBSYXlhYmhhcmFtIChNaWNyb3NvZnQpIDxhbmlydWRoQGFuaXJ1ZGhyYi5j
b20+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDEzLCAyMDI2IDY6MjYgQU0NCj4gDQo+IFRoZSBoeXBl
cnZpc29yJ3MgbWFwIEdQQSBoeXBlcmNhbGwgY29hbGVzY2VzIGNvbnRpZ3VvdXMgMk0tYWxpZ25l
ZA0KPiBjaHVua3MgaW50byAxRyBtYXBwaW5ncyB3aGVuIGFsaWdubWVudCBwZXJtaXRzLCBzbyB0
aGUgZHJpdmVyIGNhbg0KPiBzdXBwb3J0IDFHIGh1Z2VwYWdlcyBieSBmZWVkaW5nIHRoZW0gaW4g
YXMgMk0gY2h1bmtzLiBOb3RlIHRoYXQgdGhpcw0KPiBpcyB0aGUgb25seSB3YXkgdG8gbWFrZSAx
RyBtYXBwaW5nczsgdGhlcmUgaXMgbm8gd2F5IHRvIGRpcmVjdGx5IG1hcA0KPiBhIDFHIGh1Z2Vw
YWdlIHVzaW5nIHRoZSBoeXBlcmNhbGwuDQo+IA0KPiBBbHdheXMgZW1pdCBhIDJNIChQTURfT1JE
RVIpIHN0cmlkZSBmb3IgdGhlIGh1Z2UtcGFnZSBjYXNlLiBUaGUNCj4gaHlwZXJjYWxsIGhhcyBu
byAxRyBzdHJpZGUsIHNvIDFHIGZvbGlvcyBhcmUgcHJvY2Vzc2VkIGFzIGENCj4gc2VxdWVuY2Ug
b2YgMk0gY2h1bmtzLiBGb2xpb3Mgd2hvc2Ugb3JkZXIgaXMgbGVzcyB0aGFuIFBNRF9PUkRFUg0K
PiAoZS5nLiBtVEhQKSBmYWxsIGJhY2sgdG8gc2luZ2xlLXBhZ2Ugc3RyaWRlOyBtYXBwaW5nIHRo
ZW0gYXMgMk0NCj4gd291bGQgZmFpbCBpbiB0aGUgaHlwZXJ2aXNvciBhbnl3YXkuDQo+IA0KPiBB
c3Npc3RlZC1ieTogQ29waWxvdC1DTEk6Y2xhdWRlLW9wdXMtNC43DQo+IFNpZ25lZC1vZmYtYnk6
IEFuaXJ1ZGggUmF5YWJoYXJhbSAoTWljcm9zb2Z0KSA8YW5pcnVkaEBhbmlydWRocmIuY29tPg0K
PiBBY2tlZC1ieTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWlj
cm9zb2Z0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRs
b29rLmNvbT4NCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBDaGFuZ2VkIHRoZSBjaGVj
ayB0byBwYWdlX29yZGVyIDwgUE1EX09SREVSIGZvciB1c2luZyBwYWdlIHN0cmlkZSBvZiAxDQo+
ICAgLSBBbHNvIHVwZGF0ZWQgdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiAtIFBpY2sgdXAgQWNrZWQt
Ynk6DQo+IC0gTGluayB0byB2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDUwNi1o
dWdlXzFnLXYzLTEtMjZlMWU0YzQzOWU0QGFuaXJ1ZGhyYi5jb20NCj4gDQo+IENoYW5nZXMgaW4g
djM6DQo+IC0gRml4ZWQgdmFyaW91cyBjb3JuZXIgY2FzZXMgcmVwb3J0ZWQgYnkgU2FzaGlrby4N
Cj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwNTA1LWh1Z2Vf
MWctdjItMS1iNmE5MTMyN2E4OGRAYW5pcnVkaHJiLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBIYW5kbGVkIHRoZSBjYXNlIHdoZXJlIHdlIGNhbiBoYXZlIDJNIGFsaWduZWQgcGFnZXMg
aW4gdGhlIG1pZGRsZSBvZiBhDQo+ICAgMUcgcGFnZQ0KPiAtIEJyb3VnaHQgYmFjayB0aGUgcGFn
ZSBvcmRlciBjaGVjayBidXQgZXhwYW5kZWQgaXQgdG8gaW5jbHVkZSAxRw0KPiAtIENsYW1wIHN0
cmlkZSB0byByZXF1ZXN0ZWQgcGFnZSBjb3VudCBpbiBtc2h2X3JlZ2lvbl9wcm9jZXNzX2NodW5r
DQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDQxNi1odWdl
XzFnLXYxLTEtZTA2NjczOGNkZGZiQGFuaXJ1ZGhyYi5jb20NCj4gLS0tDQo+ICBkcml2ZXJzL2h2
L21zaHZfcmVnaW9ucy5jIHwgMjkgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h2L21zaHZfcmVnaW9ucy5jIGIvZHJpdmVycy9odi9tc2h2X3Jl
Z2lvbnMuYw0KPiBpbmRleCBmZGZmZDRmMDAyZjYuLjZkNjVlNWI0MjE1MiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9odi9tc2h2X3JlZ2lvbnMuYw0KPiArKysgYi9kcml2ZXJzL2h2L21zaHZfcmVn
aW9ucy5jDQo+IEBAIC0yOSwyOSArMjksMjcgQEANCj4gICAqIFVzZXMgaHVnZSBwYWdlIHN0cmlk
ZSBpZiB0aGUgYmFja2luZyBwYWdlIGlzIGh1Z2UgYW5kIHRoZSBndWVzdCBtYXBwaW5nDQo+ICAg
KiBpcyBwcm9wZXJseSBhbGlnbmVkOyBvdGhlcndpc2UgZmFsbHMgYmFjayB0byBzaW5nbGUgcGFn
ZSBzdHJpZGUuDQo+ICAgKg0KPiAtICogUmV0dXJuOiBTdHJpZGUgaW4gcGFnZXMsIG9yIC1FSU5W
QUwgaWYgcGFnZSBvcmRlciBpcyB1bnN1cHBvcnRlZC4NCj4gKyAqIFJldHVybjogU3RyaWRlIGlu
IHBhZ2VzLg0KPiAgICovDQo+IC1zdGF0aWMgaW50IG1zaHZfY2h1bmtfc3RyaWRlKHN0cnVjdCBw
YWdlICpwYWdlLA0KPiAtCQkJICAgICB1NjQgZ2ZuLCB1NjQgcGFnZV9jb3VudCkNCj4gK3N0YXRp
YyB1bnNpZ25lZCBpbnQgbXNodl9jaHVua19zdHJpZGUoc3RydWN0IHBhZ2UgKnBhZ2UsIHU2NCBn
Zm4sDQo+ICsJCQkJICAgICAgdTY0IHBhZ2VfY291bnQpDQo+ICB7DQo+IC0JdW5zaWduZWQgaW50
IHBhZ2Vfb3JkZXI7DQo+ICsJdW5zaWduZWQgaW50IHBhZ2Vfb3JkZXIgPSBmb2xpb19vcmRlcihw
YWdlX2ZvbGlvKHBhZ2UpKTsNCj4gDQo+ICAJLyoNCj4gIAkgKiBVc2Ugc2luZ2xlIHBhZ2Ugc3Ry
aWRlIGJ5IGRlZmF1bHQuIEZvciBodWdlIHBhZ2Ugc3RyaWRlLCB0aGUNCj4gLQkgKiBwYWdlIG11
c3QgYmUgY29tcG91bmQgYW5kIHBvaW50IHRvIHRoZSBoZWFkIG9mIHRoZSBjb21wb3VuZA0KPiAt
CSAqIHBhZ2UsIGFuZCBib3RoIGdmbiBhbmQgcGFnZV9jb3VudCBtdXN0IGJlIGh1Z2UtcGFnZSBh
bGlnbmVkLg0KPiArCSAqIGZvbGlvIG9yZGVyIG11c3QgYmUgYXQgbGVhc3QgUE1EX09SREVSLCB0
aGUgcGFnZSdzIFBGTiBtdXN0IGJlDQo+ICsJICogMk0tYWxpZ25lZCAoc28gdGhhdCBhIDJNLWFs
aWduZWQgdGFpbCBwYWdlIG9mIGEgbGFyZ2VyIGZvbGlvIGlzDQo+ICsJICogYWNjZXB0YWJsZSks
IGFuZCBib3RoIGdmbiBhbmQgcGFnZV9jb3VudCBtdXN0IGJlIDJNLWFsaWduZWQuDQo+ICAJICov
DQo+IC0JaWYgKCFQYWdlQ29tcG91bmQocGFnZSkgfHwgIVBhZ2VIZWFkKHBhZ2UpIHx8DQo+ICsJ
aWYgKHBhZ2Vfb3JkZXIgPCBQTURfT1JERVIgfHwNCj4gKwkgICAgIUlTX0FMSUdORUQocGFnZV90
b19wZm4ocGFnZSksIFBUUlNfUEVSX1BNRCkgfHwNCj4gIAkgICAgIUlTX0FMSUdORUQoZ2ZuLCBQ
VFJTX1BFUl9QTUQpIHx8DQo+ICAJICAgICFJU19BTElHTkVEKHBhZ2VfY291bnQsIFBUUlNfUEVS
X1BNRCkpDQo+ICAJCXJldHVybiAxOw0KPiANCj4gLQlwYWdlX29yZGVyID0gZm9saW9fb3JkZXIo
cGFnZV9mb2xpbyhwYWdlKSk7DQo+IC0JLyogVGhlIGh5cGVydmlzb3Igb25seSBzdXBwb3J0cyAy
TSBodWdlIHBhZ2UgKi8NCj4gLQlpZiAocGFnZV9vcmRlciAhPSBQTURfT1JERVIpDQo+IC0JCXJl
dHVybiAtRUlOVkFMOw0KPiAtDQo+IC0JcmV0dXJuIDEgPDwgcGFnZV9vcmRlcjsNCj4gKwkvKiBV
c2UgMk0gc3RyaWRlIGFsd2F5cyBpLmUuIHByb2Nlc3MgMUcgZm9saW9zIGFzIDJNIGNodW5rcyAq
Lw0KPiArCXJldHVybiAxIDw8IFBNRF9PUkRFUjsNCj4gIH0NCj4gDQo+ICAvKioNCj4gQEAgLTg2
LDE1ICs4NCwxNCBAQCBzdGF0aWMgbG9uZyBtc2h2X3JlZ2lvbl9wcm9jZXNzX2NodW5rKHN0cnVj
dCBtc2h2X21lbV9yZWdpb24gKnJlZ2lvbiwNCj4gIAl1NjQgZ2ZuID0gcmVnaW9uLT5zdGFydF9n
Zm4gKyBwYWdlX29mZnNldDsNCj4gIAl1NjQgY291bnQ7DQo+ICAJc3RydWN0IHBhZ2UgKnBhZ2U7
DQo+IC0JaW50IHN0cmlkZSwgcmV0Ow0KPiArCXVuc2lnbmVkIGludCBzdHJpZGU7DQo+ICsJaW50
IHJldDsNCj4gDQo+ICAJcGFnZSA9IHJlZ2lvbi0+bXJlZ19wYWdlc1twYWdlX29mZnNldF07DQo+
ICAJaWYgKCFwYWdlKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+ICAJc3RyaWRlID0gbXNo
dl9jaHVua19zdHJpZGUocGFnZSwgZ2ZuLCBwYWdlX2NvdW50KTsNCj4gLQlpZiAoc3RyaWRlIDwg
MCkNCj4gLQkJcmV0dXJuIHN0cmlkZTsNCj4gDQo+ICAJLyogU3RhcnQgYXQgc3RyaWRlIHNpbmNl
IHRoZSBmaXJzdCBzdHJpZGUgaXMgdmFsaWRhdGVkICovDQo+ICAJZm9yIChjb3VudCA9IHN0cmlk
ZTsgY291bnQgPCBwYWdlX2NvdW50OyBjb3VudCArPSBzdHJpZGUpIHsNCj4gDQo+IC0tLQ0KPiBi
YXNlLWNvbW1pdDogY2Q5ZjJlN2Q2ZTViMTgzN2VmNDBiOTZlMzAwZmEyOGI3M2FiNWE3Nw0KPiBj
aGFuZ2UtaWQ6IDIwMjYwNDE2LWh1Z2VfMWctZTQ0NDYxMzkzYzhmDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IC0tDQo+IEFuaXJ1ZGggUmF5YWJoYXJhbSAoTWljcm9zb2Z0KSA8YW5pcnVkaEBhbmly
dWRocmIuY29tPg0KPiANCg0K

