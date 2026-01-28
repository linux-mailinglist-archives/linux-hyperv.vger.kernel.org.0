Return-Path: <linux-hyperv+bounces-8559-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KKvHjQ3eml+4gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8559-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:20:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A29A5709
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FABD301D240
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A830CDA1;
	Wed, 28 Jan 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nVnICvyI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012019.outbound.protection.outlook.com [52.103.11.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC030C63A;
	Wed, 28 Jan 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615589; cv=fail; b=sZWQJcKpHsknLRzO32zPwgdBSDD1wXKvckqOqwnTos1MKl0FIpeREhtfkyIpP/5h0DFersCIEd2O3n+4DmKWEF867z0cCjswiwLbLlutW9N/+vPDljQ+f9mn8oshzPXG1P+jgthFg14yfNLQ+fM2Thw5tcEsvo1iXvzh2O84Es8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615589; c=relaxed/simple;
	bh=nnPa8+37kQsXllGAlCSPYhSPnGUsDE5XsHmO60AB9XU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNFIF2Q2Y20k5iu8Gkcme3WPNAf9f0u5lmdvimz88HJXwHKof/03Ij1gK1up9OB8m/7Rw3Wgh9teWxhWNZSSu16NLBoDWq8EQJ1j7alPuc32om1pwZbiQv7xUmWC5ydhyAEUzdSYfPnoyEmIIRs06M5F0PjQ2Y8Y0z8cQdx+F9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nVnICvyI; arc=fail smtp.client-ip=52.103.11.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT3KnZVyibUqtIV2Laaneg0+ehJVAnv/UGVDYyX/j1KKDVl4KLLK2WBJBv8b3X8e36MctIcov6aNUEknc4cA7JzLc05n2s8lQ8VnmOD9SgUBPW16v7Iik8k/S5BquZWEXhC+26DMiKguJzY0P8/mTBRpj+IVjwT1TRUOzT97a/rxplUlIjwA56kdBiuintOVlp1O6ch1bZXtdw4HExOEaRzWw9b7WbCNOA40rCGvcHwyxJ3L2R+F9pv08F3fFe9EIdJ90904fJNSG1ajPijUON8L91Co/VhXQBlFxUfzrvSqeTwmMAviW+UILhkkGF8TsqRtzlaV2UZlNN+GqSHEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnPa8+37kQsXllGAlCSPYhSPnGUsDE5XsHmO60AB9XU=;
 b=E9GOFW/SAqL8ppIlCgH++9CqJ5Fz4oZu/M5t5ftCkqaSIEmTLllSMnA8cTYH/yLQvimCqK+KvqCFn8dnILMT8Fj6K210whFF/pCwwop4Z/QvalQstj0sTMOEt1GrVBp1OEFchbOFICEX7mcSxJKAqerFmtCmYVjmxm6N8XU4avZMDZzgq/AnFbvanSfklWU2/GT2a1xAvi8fDDrRJE8dWHv3jms7zsytATwEXc7eHsz8a7ZXHxKNEwhsniddXWbpryMWQr9IDpGI2adLkohN95fjwEJbBFxTwAGTp7uUqTppXCWTOos7VweGYyHBvE+FqLHhavCczdmKaVj9AMR5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnPa8+37kQsXllGAlCSPYhSPnGUsDE5XsHmO60AB9XU=;
 b=nVnICvyI7elx/QwihiRU6RKVwzcsoxD6wX/SnQSqSJhQ7gQFMSAVQpvurL3eJOYFdkKlpSlpfjU1n0dkNk7RfI1PWtQDH6cXbIsgpMm2egL1pcStD14dtf7R5U3dULhS78BnQHG5M3RC7eOHwoBfTHw9wI323iCLaUTbnDLkM4yUO//3F72TtgAqrXtKwpwTB4np5KX2HYs+0DqUruHvhoN5vlbXupFZWjiaUSt8qAHpIJah1VLVbd8m6h1ojdWZuBZdl9BUFj2nDzCOWKJQbEY3ZmAXptIiNswwhwuSJI/zjheAYndWVIocQzDbaD6za4fm8ONyEVnVES28y+zj3w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN7PR02MB9349.namprd02.prod.outlook.com (2603:10b6:806:345::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 15:53:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 15:53:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Thread-Topic: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Thread-Index:
 AQHcjLaQ9mqQOSZflESrJ2VKoxJjVLVgc/aAgAMJhwCAAWtrgIAABqcAgAAoDACAABTLgIAAFdKAgAEOPICAACQMAIABSfTw
Date: Wed, 28 Jan 2026 15:53:04 +0000
Message-ID:
 <SN6PR02MB4157EDC69791EF24D5DA8661D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
 <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
 <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
 <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
 <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
 <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
 <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
 <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
 <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
In-Reply-To: <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN7PR02MB9349:EE_
x-ms-office365-filtering-correlation-id: 3c943986-35d2-43ab-7e70-08de5e8552fd
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|8062599012|15080799012|8060799015|13091999003|19110799012|461199028|31061999003|440099028|3412199025|102099032|11031999003|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzNkeFBQNTZ3SUhDWTVpYWI1ZVVzeDd2VG9peDhpbERUcnc4OEd4b1grYkQ3?=
 =?utf-8?B?eUN1SUk5WmsvRW5yRUhjRFN5OTRKYXJiS1VVRCsxUUIrWlNoQjlDVW9uUkJr?=
 =?utf-8?B?aUJNSkpWaFM0UVJEYk5wZEhZbjJrdGZKYUxYUlhDNno0VFF5bkQ3Q0x4UFp2?=
 =?utf-8?B?Rnl2TDliSlJUUEQzYys3VGZzeVdZaUQxUysvcVh4R3pkbTROY0lEeE4zaUln?=
 =?utf-8?B?UHJLMjZNdTV5VlJtVUtBeExxMDdGc21JakwrenEwdkEvWm1RY1ZEcHRVZlZH?=
 =?utf-8?B?OEJ2WTVUS1JqQk5OeHJIL3ZpSGFRZ29zcEpwL1ZxOFVES2pKcEJnN3NPaFdZ?=
 =?utf-8?B?ZzQwVks2Und4MGNkajlUNHhIVVZqL2pBV0dFWFNxNkREMnF3bytJYkdXVW1p?=
 =?utf-8?B?SjM0L2hoSjZJdW5rRVBNdWZNOU9paDI0WHhETm1ldDVMbjd5TlQrOEJPMVJk?=
 =?utf-8?B?R1Z2SjBNcGh6ODhoZk1wK1VCTkNxc3FvcGFybmZsaFRFdjg2N1JhWnJRVWNz?=
 =?utf-8?B?cElmdUVwYnJSeTdWZENHVXhqcHNKWmZvak1qWEhYUkFEUkRMUlFaL296UmhW?=
 =?utf-8?B?dGFiTGp1MVUxNWgvdmhZV1RiUUxPcVZpMWw0VzFIaFhwc0F3M0FqWitwbnRl?=
 =?utf-8?B?NXc0K1JseXVoZGc5TjV2bVpQUXlVTHl4RkxjQzBnTmk5ajJFa3lKNUFqdVBR?=
 =?utf-8?B?amZ2TTIzTGVuMU8xZzJXVnhISklPelpVeG4yYlhPdUxubVpHb3pMeHNYUkF6?=
 =?utf-8?B?eEFzM1pYS1U1QXdza0ZSV2k3a3ZNeEI4V1lCL3JobUFjMFpXL1d4dFRZVjRo?=
 =?utf-8?B?cmorNjRQRXFEU3BnWnZ4Ry9yWjJrYmkzUFRhVk5BQzFSb2ZnMU92ci9OUjRi?=
 =?utf-8?B?ZXRuSU43MTJNL01VdXZyN1lsVEM3Vm9DaDNLNzhIOVJoSC9KYUtQU2xQS0xW?=
 =?utf-8?B?alVnZ1M5MXVBSTF2UUpRdHA4M3JLK3RvTjdnK01FYnpYRWt1b1hvOW9DbDhP?=
 =?utf-8?B?WnJIMGpJY1VhVVJGbm01bUJxLy9qdmFRcTNHT09Ra1ZXcXlLWGJsNERLTWVm?=
 =?utf-8?B?Rzd5cWFYZVdCZGczdlBENGZUYmRwbGk1Q2FnM3FHenFIc2JaclduRWxQOTNu?=
 =?utf-8?B?bWpmVTNyUE9ob2V1ZmhPK0d5Q3pYclAwRTRRY1ZMQTVDS1VOTmhnSCtKTHd5?=
 =?utf-8?B?c3JIMTE0Z0FGaFQvUTV2SWdQcjduR2JVQy9uZlFYMGs4NE0zWHRwb1BneHRa?=
 =?utf-8?B?Q0VIczJzbEs0Q2lQTUJUYlZDalU1b3JZSEFMNDZwMmY2Uk4xOVJxOXhwakND?=
 =?utf-8?B?cTlkendoQWZBV0NSNmgyTCtqeDhvNXpkRDc2ekx4T0hHMVhmYVhBUUZ1SWpj?=
 =?utf-8?B?aXBWaG01OFRTc1FHL0xzVUh1c3ZYbWdlVmVZc0xFVGI3WiszNE41cUp3WDlK?=
 =?utf-8?B?aThnNGgwSERFamVwK2lnOC82NzNYYlFoQTg3RkZVVnpkZnhBc0o4bm52NWhm?=
 =?utf-8?B?ZHlFWC9rVGFXNURWK0JWRmtwNThhREowOU1aOWJzSjNpTmU0YTM1YWxvTWRD?=
 =?utf-8?B?YWwzeVVNRkp1NWEwTnMxOWMrSWF1OHdzS3F1elVyVlljVE43dmluZHF0ZU03?=
 =?utf-8?Q?h7HdwNuNMJkEfoQ9EIcPxxavby7tUJpGz54KppAhvULg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVE5cENkSkpCNDVaaVlrVDFmT0Iya3RTWXRjVVBPUEYvMzI4Q2NzMDFHOVhv?=
 =?utf-8?B?ZXVUOVljSWxZNHFDMi83OVRrYkwyL3NUTzh0UG54TkhiamhEMk94YnYzeTN1?=
 =?utf-8?B?TU9HVU8zem9hTC9FNE44Rk0vKzhJY0RzclgxZkRzMzYzZE9VcFhnYmljdEJu?=
 =?utf-8?B?Z1FXb3U0ZmRuZTh3bEh5aWpTS0UrS1J2dURVR1dYd25oTHloa1lRYmd0ZEdL?=
 =?utf-8?B?dXNhaC9pWm5JMHQ0UFFHMHlDSEphN1h4SFNINGJyQWpZTFYrM04yOHoxZWRS?=
 =?utf-8?B?RmxrZWkwTVhCT3I5dWVvdDBSdjlzUjJwaHhTSEoyRlN0Skg4eHhCME9WdkJK?=
 =?utf-8?B?TEU1bzU2N1BhR3J4S3puYnpXQmp3NFAwUTYrckVTV0p5eW1WWnNOcjYyRm1M?=
 =?utf-8?B?cjdZYmdtb0NqTnBBUHZ5ZGtSU2hjSE9SUGtKa1ZvQ1Exa05GdnlRK2QwcExZ?=
 =?utf-8?B?aVFWTjJ6d1EzdUVVZ1pPNU4vLzY4K2JBOVA5SVRjZ1BPQk9vUm5MYjN0Rkh5?=
 =?utf-8?B?MG0ybUFoTjUvby9WTWpYaXJjUnlHQmppdnNIR3llcWVTK0hhcTFqNjJTczJr?=
 =?utf-8?B?ald2YkI3Wlc2V3Z4SjV0aStIQjRlRUVvbmhuZ3ZPV1RwM1hPNGhhdEpyOWd2?=
 =?utf-8?B?V2VFdGY1bWlUYzM5KzZ0UndVOWxJUk5OWllzVHBIUmdwMXNiNjNBREVLYk5s?=
 =?utf-8?B?NUVGaU5ZbU5qV1lQbFNaajRIQU9FcWUzVlFLdHNOS21UTm50M2wvMGhBNDFw?=
 =?utf-8?B?WkxhTEVXZFZHcnhlMmN0YjVubjBiQlpWRGk4VlZjZDdGR0hqN2Q2UlZydG8v?=
 =?utf-8?B?ZHpmMFk5cWNydjVkcnRXaFdGVmEzUEhsM1RTVWk3Ym9vWkluUUFQa0JGL3dX?=
 =?utf-8?B?L3dScGpIZDUyYVQzOC9PTEtjWldCUzY3NmxhVUY2eEdzc21qaXNkNE4xbzNV?=
 =?utf-8?B?LzhybElkZkZuT2REWkV1TWJES0NYdXZmTVM4VFI0Y2t5WnNRdFBxNzN5cHh3?=
 =?utf-8?B?YWhVbitEU0N5MURHS0tTWE1BUlR0OHkrR1FOcVdMUmxPbkdubmdQSVhsK3ZP?=
 =?utf-8?B?QUpqQ2ErbERZTXp5SSt4Q1V3ZnVrWFVTUE1TSnV1UEo1S0ZnSG1YcTlDNG9C?=
 =?utf-8?B?RTIweWR1S3ljNmhxcjVvSVByNndudDU1U1hJeTZhMi9hV1A3elZGN2cwcThQ?=
 =?utf-8?B?V2RqajFFVGo4c2c2aXdWRUx3YVJtRS94MTJPckZoa2UrSVFqN3lEcjl5cTdu?=
 =?utf-8?B?ZHJFZjF0aThCZWJlOVNxVFA0OEk0V3IwZ2RXWHZLOHNIbEFSem82RXpYSitN?=
 =?utf-8?B?ak1FOXR1TkN6U0xndTVmYkVPcXM4am9UOHUxUnpzQVhXN0xWRVZTRHBGNzBy?=
 =?utf-8?B?K2NMakpyL2VIRlJnNGRiS2p0WWhZR2p3MHFqeWpTdXhpK0wwZTJYODUvcjk0?=
 =?utf-8?B?SGVJdGkvMjZ0c0c3MmdwSGwrS3lLTTIvdFVFTzAxdkRjUU9ZRi8vWFZ1MHhi?=
 =?utf-8?B?cmpleEJxUENpQ3JwWFFaK242U3FZUllnczhnek5FVWNML0U5cUpYMW9OU21M?=
 =?utf-8?B?S0djczZxWTlzN1MyZFA5cnVMajRuYXFzcnNTaFRmNVhPVUt1NUcweUc5b1hp?=
 =?utf-8?B?N2Rid0pEL2VPRXRFZ3VDN0NGL1E3OEtkTVZpS1RZZGx1Y3lvYTQvUUtlRENp?=
 =?utf-8?B?RGRBdGYvQVdTSVc2ejRZaGptMzU5K202ZUVFSHZmeHBpbnJ5Q0VkS1FrL1NL?=
 =?utf-8?B?UzdQRHluazJaalByd1dHbmNIb0NER0s2UGxoL2tNS2grdG4reVlhemxvR2pv?=
 =?utf-8?Q?AOKzNY08f9Bc6f6Vks/vK4OVmh4gqWLtYmMzk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c943986-35d2-43ab-7e70-08de5e8552fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 15:53:04.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9349
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8559-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2A29A5709
X-Rspamd-Action: no action

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2Rh
eSwgSmFudWFyeSAyNywgMjAyNiAxMTo1NiBBTQ0KPiBUbzogU3RhbmlzbGF2IEtpbnNidXJza2lp
IDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gQ2M6IGt5c0BtaWNyb3NvZnQu
Y29tOyBoYWl5YW5nekBtaWNyb3NvZnQuY29tOyB3ZWkubGl1QGtlcm5lbC5vcmc7DQo+IGRlY3Vp
QG1pY3Jvc29mdC5jb207IGxvbmdsaUBtaWNyb3NvZnQuY29tOyBsaW51eC1oeXBlcnZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBtc2h2OiBNYWtlIE1TSFYgbXV0dWFsbHkgZXhjbHVzaXZlIHdpdGggS0VYRUMN
Cj4gDQo+IE9uIDEvMjcvMjYgMDk6NDcsIFN0YW5pc2xhdiBLaW5zYnVyc2tpaSB3cm90ZToNCj4g
PiBPbiBNb24sIEphbiAyNiwgMjAyNiBhdCAwNTozOTo0OVBNIC0wODAwLCBNdWtlc2ggUiB3cm90
ZToNCj4gPj4gT24gMS8yNi8yNiAxNjoyMSwgU3RhbmlzbGF2IEtpbnNidXJza2lpIHdyb3RlOg0K
PiA+Pj4gT24gTW9uLCBKYW4gMjYsIDIwMjYgYXQgMDM6MDc6MThQTSAtMDgwMCwgTXVrZXNoIFIg
d3JvdGU6DQo+ID4+Pj4gT24gMS8yNi8yNiAxMjo0MywgU3RhbmlzbGF2IEtpbnNidXJza2lpIHdy
b3RlOg0KPiA+Pj4+PiBPbiBNb24sIEphbiAyNiwgMjAyNiBhdCAxMjoyMDowOVBNIC0wODAwLCBN
dWtlc2ggUiB3cm90ZToNCj4gPj4+Pj4+IE9uIDEvMjUvMjYgMTQ6MzksIFN0YW5pc2xhdiBLaW5z
YnVyc2tpaSB3cm90ZToNCj4gPj4+Pj4+PiBPbiBGcmksIEphbiAyMywgMjAyNiBhdCAwNDoxNjoz
M1BNIC0wODAwLCBNdWtlc2ggUiB3cm90ZToNCj4gPj4+Pj4+Pj4gT24gMS8yMy8yNiAxNDoyMCwg
U3RhbmlzbGF2IEtpbnNidXJza2lpIHdyb3RlOg0KPiA+Pj4+Pj4+Pj4gVGhlIE1TSFYgZHJpdmVy
IGRlcG9zaXRzIGtlcm5lbC1hbGxvY2F0ZWQgcGFnZXMgdG8gdGhlIGh5cGVydmlzb3IgZHVyaW5n
DQo+ID4+Pj4+Pj4+PiBydW50aW1lIGFuZCBuZXZlciB3aXRoZHJhd3MgdGhlbS4gVGhpcyBjcmVh
dGVzIGEgZnVuZGFtZW50YWwgaW5jb21wYXRpYmlsaXR5DQo+ID4+Pj4+Pj4+PiB3aXRoIEtFWEVD
LCBhcyB0aGVzZSBkZXBvc2l0ZWQgcGFnZXMgcmVtYWluIHVuYXZhaWxhYmxlIHRvIHRoZSBuZXcg
a2VybmVsDQo+ID4+Pj4+Pj4+PiBsb2FkZWQgdmlhIEtFWEVDLCBsZWFkaW5nIHRvIHBvdGVudGlh
bCBzeXN0ZW0gY3Jhc2hlcyB1cG9uIGtlcm5lbCBhY2Nlc3NpbmcNCj4gPj4+Pj4+Pj4+IGh5cGVy
dmlzb3IgZGVwb3NpdGVkIHBhZ2VzLg0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IE1ha2UgTVNI
ViBtdXR1YWxseSBleGNsdXNpdmUgd2l0aCBLRVhFQyB1bnRpbCBwcm9wZXIgcGFnZSBsaWZlY3lj
bGUNCj4gPj4+Pj4+Pj4+IG1hbmFnZW1lbnQgaXMgaW1wbGVtZW50ZWQuDQo+ID4+Pj4+Pj4+Pg0K
PiA+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1
cnNraWlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPj4+Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4+Pj4g
ICAgICAgZHJpdmVycy9odi9LY29uZmlnIHwgICAgMSArDQo+ID4+Pj4+Pj4+PiAgICAgICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9odi9LY29uZmlnIGIvZHJpdmVycy9odi9LY29uZmlnDQo+ID4+Pj4+
Pj4+PiBpbmRleCA3OTM3YWMwY2JkMGYuLmNmZDQ1MDFkYjBmYSAxMDA2NDQNCj4gPj4+Pj4+Pj4+
IC0tLSBhL2RyaXZlcnMvaHYvS2NvbmZpZw0KPiA+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9odi9L
Y29uZmlnDQo+ID4+Pj4+Pj4+PiBAQCAtNzQsNiArNzQsNyBAQCBjb25maWcgTVNIVl9ST09UDQo+
ID4+Pj4+Pj4+PiAgICAgICAJIyBlLmcuIFdoZW4gd2l0aGRyYXdpbmcgbWVtb3J5LCB0aGUgaHlw
ZXJ2aXNvciBnaXZlcyBiYWNrIDRrIHBhZ2VzIGluDQo+ID4+Pj4+Pj4+PiAgICAgICAJIyBubyBw
YXJ0aWN1bGFyIG9yZGVyLCBtYWtpbmcgaXQgaW1wb3NzaWJsZSB0byByZWFzc2VtYmxlIGxhcmdl
ciBwYWdlcw0KPiA+Pj4+Pj4+Pj4gICAgICAgCWRlcGVuZHMgb24gUEFHRV9TSVpFXzRLQg0KPiA+
Pj4+Pj4+Pj4gKwlkZXBlbmRzIG9uICFLRVhFQw0KPiA+Pj4+Pj4+Pj4gICAgICAgCXNlbGVjdCBF
VkVOVEZEDQo+ID4+Pj4+Pj4+PiAgICAgICAJc2VsZWN0IFZJUlRfWEZFUl9UT19HVUVTVF9XT1JL
DQo+ID4+Pj4+Pj4+PiAgICAgICAJc2VsZWN0IEhNTV9NSVJST1INCj4gPj4+Pj4+Pj4+DQo+ID4+
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBXaWxsIHRoaXMgYWZmZWN0IENSQVNIIGtl
eGVjPyBJIHNlZSBmZXcgQ09ORklHX0NSQVNIX0RVTVAgaW4ga2V4ZWMuYw0KPiA+Pj4+Pj4+PiBp
bXBseWluZyB0aGF0IGNyYXNoIGR1bXAgbWlnaHQgYmUgaW52b2x2ZWQuIE9yIGRpZCB5b3UgdGVz
dCBrZHVtcA0KPiA+Pj4+Pj4+PiBhbmQgaXQgd2FzIGZpbmU/DQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+
Pj4NCj4gPj4+Pj4+PiBZZXMsIGl0IHdpbGwuIENyYXNoIGtleGVjIGRlcGVuZHMgb24gbm9ybWFs
IGtleGVjIGZ1bmN0aW9uYWxpdHksIHNvIGl0DQo+ID4+Pj4+Pj4gd2lsbCBiZSBhZmZlY3RlZCBh
cyB3ZWxsLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNvIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUg
cmVhc29uIGZvciB0aGlzIHBhdGNoLiBXZSBjYW4ganVzdCBibG9jaw0KPiA+Pj4+Pj4ga2V4ZWMg
aWYgdGhlcmUgYXJlIGFueSBWTXMgcnVubmluZywgcmlnaHQ/IERvaW5nIHRoaXMgd291bGQgbWVh
biBhbnkNCj4gPj4+Pj4+IGZ1cnRoZXIgZGV2ZWxvcGVtZW50IHdvdWxkIGJlIHdpdGhvdXQgYSB2
ZXIgaW1wb3J0YW50IGFuZCBtYWpvciBmZWF0dXJlLA0KPiA+Pj4+Pj4gcmlnaHQ/DQo+ID4+Pj4+
DQo+ID4+Pj4+IFRoaXMgaXMgYW4gb3B0aW9uLiBCdXQgdW50aWwgaXQncyBpbXBsZW1lbnRlZCBh
bmQgbWVyZ2VkLCBhIHVzZXIgbXNodg0KPiA+Pj4+PiBkcml2ZXIgZ2V0cyBpbnRvIGEgc2l0dWF0
aW9uIHdoZXJlIGtleGVjIGlzIGJyb2tlbiBpbiBhIG5vbi1vYnZpb3VzIHdheS4NCj4gPj4+Pj4g
VGhlIHN5c3RlbSBtYXkgY3Jhc2ggYXQgYW55IHRpbWUgYWZ0ZXIga2V4ZWMsIGRlcGVuZGluZyBv
biB3aGV0aGVyIHRoZQ0KPiA+Pj4+PiBuZXcga2VybmVsIHRvdWNoZXMgdGhlIHBhZ2VzIGRlcG9z
aXRlZCB0byBoeXBlcnZpc29yIG9yIG5vdC4gVGhpcyBpcyBhDQo+ID4+Pj4+IGJhZCB1c2VyIGV4
cGVyaWVuY2UuDQo+ID4+Pj4NCj4gPj4+PiBJIHVuZGVyc3RhbmQgdGhhdC4gQnV0IHdpdGggdGhp
cyB3ZSBjYW5ub3QgY29sbGVjdCBjb3JlIGFuZCBkZWJ1ZyBhbnkNCj4gPj4+PiBjcmFzaGVzLiBJ
IHdhcyB0aGlua2luZyB0aGVyZSB3b3VsZCBiZSBhIHF1aWNrIHdheSB0byBwcm9oaWJpdCBrZXhl
Yw0KPiA+Pj4+IGZvciB1cGRhdGUgdmlhIG5vdGlmaWVyIG9yIHNvbWUgb3RoZXIgcXVpY2sgaGFj
ay4gRGlkIHlvdSBhbHJlYWR5DQo+ID4+Pj4gZXhwbG9yZSB0aGF0IGFuZCBkaWRuJ3QgZmluZCBh
bnl0aGluZywgaGVuY2UgdGhpcz8NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFRoaXMgcXVpY2sgaGFj
ayB5b3UgbWVudGlvbiBpc24ndCBxdWljayBpbiB0aGUgdXBzdHJlYW0ga2VybmVsIGFzIHRoZXJl
DQo+ID4+PiBpcyBubyBob29rIHRvIGludGVycnVwdCBrZXhlYyBwcm9jZXNzIGV4Y2VwdCB0aGUg
bGl2ZSB1cGRhdGUgb25lLg0KPiA+Pg0KPiA+PiBUaGF0J3MgdGhlIG9uZSB3ZSB3YW50IHRvIGlu
dGVycnVwdCBhbmQgYmxvY2sgcmlnaHQ/IGNyYXNoIGtleGVjDQo+ID4+IGlzIG9rIGFuZCBzaG91
bGQgYmUgYWxsb3dlZC4gV2UgY2FuIGRvY3VtZW50IHdlIGRvbid0IHN1cHBvcnQga2V4ZWMNCj4g
Pj4gZm9yIHVwZGF0ZSBmb3Igbm93Lg0KPiA+Pg0KPiA+Pj4gSSBzZW50IGFuIFJGQyBmb3IgdGhh
dCBvbmUgYnV0IGdpdmVuIHRvZGF5cyBjb252ZXJzYXRpb24gZGV0YWlscyBpcw0KPiA+Pj4gd29u
J3QgYmUgYWNjZXB0ZWQgYXMgaXMuDQo+ID4+DQo+ID4+IEFyZSB5b3UgdGFraW5nIGFib3V0IHRo
aXM/DQo+ID4+DQo+ID4+ICAgICAgICAgICJtc2h2OiBBZGQga2V4ZWMgc2FmZXR5IGZvciBkZXBv
c2l0ZWQgcGFnZXMiDQo+ID4+DQo+ID4NCj4gPiBZZXMuDQo+ID4NCj4gPj4+IE1ha2luZyBtc2h2
IG11dHVhbGx5IGV4Y2x1c2l2ZSB3aXRoIGtleGVjIGlzIHRoZSBvbmx5IHZpYWJsZSBvcHRpb24g
Zm9yDQo+ID4+PiBub3cgZ2l2ZW4gdGltZSBjb25zdHJhaW50cy4NCj4gPj4+IEl0IGlzIGludGVu
ZGVkIHRvIGJlIHJlcGxhY2VkIHdpdGggcHJvcGVyIHBhZ2UgbGlmZWN5Y2xlIG1hbmFnZW1lbnQg
aW4NCj4gPj4+IHRoZSBmdXR1cmUuDQo+ID4+DQo+ID4+IFllYWgsIHRoYXQgY291bGQgdGFrZSBh
IGxvbmcgdGltZSBhbmQgaW1vIHdlIGNhbm5vdCBqdXN0IGRpc2FibGUgS0VYRUMNCj4gPj4gY29t
cGxldGVseS4gV2hhdCB3ZSB3YW50IGlzIGp1c3QgYmxvY2sga2V4ZWMgZm9yIHVwZGF0ZXMgZnJv
bSBzb21lDQo+ID4+IG1zaHYgZmlsZSBmb3Igbm93LCB3ZSBhbiBwcmludCBkdXJpbmcgYm9vdCB0
aGF0IGtleGVjIGZvciB1cGRhdGVzIGlzDQo+ID4+IG5vdCBzdXBwb3J0ZWQgb24gbXNodi4gSG9w
ZSB0aGF0IG1ha2VzIHNlbnNlLg0KPiA+Pg0KPiA+DQo+ID4gVGhlIHRyYWRlLW9mZiBoZXJlIGlz
IGJldHdlZW4gZGlzYWJsaW5nIGtleGVjIHN1cHBvcnQgYW5kIGhhdmluZyB0aGUNCj4gPiBrZXJu
ZWwgY3Jhc2ggYWZ0ZXIga2V4ZWMgaW4gYSBub24tb2J2aW91cyB3YXkuIFRoaXMgYWZmZWN0cyBi
b3RoIHJlZ3VsYXINCj4gPiBrZXhlYyBhbmQgY3Jhc2gga2V4ZWMuDQo+IA0KPiBjcmFzaCBrZXhl
YyBvbiBiYXJlbWV0YWwgaXMgbm90IGFmZmVjdGVkLCBoZW5jZSBkaXNhYmxpbmcgdGhhdA0KPiBk
b2Vzbid0IG1ha2Ugc2Vuc2UgYXMgd2UgY2FuJ3QgZGVidWcgY3Jhc2hlcyB0aGVuIG9uIGJtLg0K
PiANCj4gTGV0IG1lIHRoaW5rIGFuZCBleHBsb3JlIGEgYml0LCBhbmQgaWYgSSBjb21lIHVwIHdp
dGggc29tZXRoaW5nLCBJJ2xsDQo+IHNlbmQgYSBwYXRjaCBoZXJlLiBJZiBub3RoaW5nLCB0aGVu
IHdlIGNhbiBkbyB0aGlzIGFzIGxhc3QgcmVzb3J0Lg0KPiANCj4gVGhhbmtzLA0KPiAtTXVrZXNo
DQoNCk1heWJlIHlvdSd2ZSBhbHJlYWR5IGxvb2tlZCBhdCB0aGlzLCBidXQgdGhlcmUncyBhIHN5
c2N0bCBwYXJhbWV0ZXINCmtlcm5lbC5rZXhlY19sb2FkX2xpbWl0X3JlYm9vdCB0aGF0IHByZXZl
bnRzIGxvYWRpbmcgYSBrZXhlYw0Ka2VybmVsIGZvciByZWJvb3QgaWYgdGhlIHZhbHVlIGlzIHpl
cm8uIFNlcGFyYXRlbHksIHRoZXJlIGlzDQprZXJuZWwua2V4ZWNfbG9hZF9saW1pdF9wYW5pYyB0
aGF0IGNvbnRyb2xzIHdoZXRoZXIgYSBrZXhlYw0Ka2VybmVsIGNhbiBiZSBsb2FkZWQgZm9yIGtk
dW1wIHB1cnBvc2VzLg0KDQprZXJuZWwua2V4ZWNfbG9hZF9saW1pdF9yZWJvb3QgZGVmYXVsdHMg
dG8gLTEsIHdoaWNoIGFsbG93cyBhbg0KdW5saW1pdGVkIG51bWJlciBvZiBsb2FkaW5nIGEga2V4
ZWMga2VybmVsIGZvciByZWJvb3QuIEJ1dCB0aGUgdmFsdWUNCmNhbiBiZSBzZXQgdG8gemVybyB3
aXRoIHRoaXMga2VybmVsIGJvb3QgbGluZSBwYXJhbWV0ZXI6DQoNCnN5c2N0bC5rZXJuZWwua2V4
ZWNfbG9hZF9saW1pdF9yZWJvb3Q9MA0KDQpBbHRlcm5hdGl2ZWx5LCB0aGUgbXNodiBkcml2ZXIg
aW5pdGlhbGl6YXRpb24gY291bGQgYWRkIGNvZGUgYWxvbmcNCnRoZSBsaW5lcyBvZiBwcm9jZXNz
X3N5c2N0bF9hcmcoKSB0byBvcGVuDQovcHJvYy9zeXMva2VybmVsL2tleGVjX2xvYWRfbGltaXRf
cmVib290IGFuZCB3cml0ZSBhIHZhbHVlIG9mIHplcm8uDQpUaGVuIHRoZXJlJ3Mgbm8gZGVwZW5k
ZW5jeSBvbiBzZXR0aW5nIHRoZSBrZXJuZWwgYm9vdCBsaW5lLg0KDQpUaGUgZG93bnNpZGUgdG8g
ZWl0aGVyIG1ldGhvZCBpcyB0aGF0IGFmdGVyIExpbnV4IGluIHRoZSByb290IHBhcnRpdGlvbg0K
aXMgdXAtYW5kLXJ1bm5pbmcsIGl0IGlzIHBvc3NpYmxlIHRvIGNoYW5nZSB0aGUgc3lzY3RsIHRv
IGEgbm9uLXplcm8gdmFsdWUsDQphbmQgdGhlbiBsb2FkIGEga2V4ZWMga2VybmVsIGZvciByZWJv
b3QuIFNvIHRoaXMgYXBwcm9hY2ggaXNuJ3QgYWJzb2x1dGUNCnByb3RlY3Rpb24gYWdhaW5zdCBk
b2luZyBhIGtleGVjIGZvciByZWJvb3QuIEJ1dCBpdCBtYWtlcyBpdCBoYXJkZXIsIGFuZCANCnVu
dGlsIHRoZXJlJ3MgYSBtZWNoYW5pc20gdG8gcmVjbGFpbSB0aGUgZGVwb3NpdGVkIHBhZ2VzLCBp
dCBtaWdodCBiZQ0KYSB2aWFibGUgY29tcHJvbWlzZSB0byBhbGxvdyBrZHVtcCB0byBzdGlsbCBi
ZSB1c2VkLg0KDQpKdXN0IGEgdGhvdWdodCAuLi4uDQoNCk1pY2hhZWwNCg0KPiANCj4gDQo+ID4g
SXQ/cyBhIHBpdHkgd2UgY2FuP3QgYXBwbHkgYSBxdWljayBoYWNrIHRvIGRpc2FibGUgb25seSBy
ZWd1bGFyIGtleGVjLg0KPiA+IEhvd2V2ZXIsIHNpbmNlIGNyYXNoIGtleGVjIHdvdWxkIGhpdCB0
aGUgc2FtZSBpc3N1ZXMsIHVudGlsIHdlIGhhdmUgYQ0KPiA+IHByb3BlciBzdGF0ZSB0cmFuc2l0
aW9uIGZvciBkZXBvc3RlZCBwYWdlcywgdGhlIGJlc3Qgd29ya2Fyb3VuZCBmb3Igbm93DQo+ID4g
aXMgdG8gcmVzZXQgdGhlIGh5cGVydmlzb3Igc3RhdGUgb24gZXZlcnkga2V4ZWMsIHdoaWNoIG5l
ZWRzIGRlc2lnbiwNCj4gPiB3b3JrLCBhbmQgdGVzdGluZy4NCj4gPg0KPiA+IERpc2FibGluZyBr
ZXhlYyBpcyB0aGUgb25seSBjb25zaXN0ZW50IHdheSB0byBoYW5kbGUgdGhpcyBpbiB0aGUNCj4g
PiB1cHN0cmVhbSBrZXJuZWwgYXQgdGhlIG1vbWVudC4NCj4gPg0KPiA+IFRoYW5rcywgU3Rhbmlz
bGF2DQo=

