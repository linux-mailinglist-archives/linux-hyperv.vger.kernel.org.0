Return-Path: <linux-hyperv+bounces-8929-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sApHJmaUmGlaJwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8929-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 18:05:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF7169913
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 18:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A361E304A5AF
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29087302149;
	Fri, 20 Feb 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UdzwQ1Zb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012051.outbound.protection.outlook.com [52.103.2.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D32EC09B;
	Fri, 20 Feb 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607114; cv=fail; b=d3G7HRq2FNuSmLycm0lkH4OHQLeWCNZzvbNgNOLWo7O5o12a71WOs9rlkDL3cu91Ws7hYAiHTNmnqN/0Bucl+WnObdG+6RbpBDSairqYADKtthUnqnR3nv62grZ1jhJMyC1mktrBWcxxWlAQjDzPtvmqgMYgHZmFH2WgSXzJ9tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607114; c=relaxed/simple;
	bh=54C1OzqCxrU80nLlTzRCF8q4X56GZ1EbuTfgWuwYriE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NUDddG7GrzXS4nFfQr0tqzAYcpnv8dY8xDl0SW6yFz0a8dOhg+np8+ptpQwu6v/lCumAqiWBKQ2sUTCWHrcy2uR/8hw45IkpF1n0niZzqOzX4pWhS1+7P9M8bQe+Xv3hZiwMUQ9oe5kczpHVOewskCvdz2qzKOyhAf0U4jVlEog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UdzwQ1Zb; arc=fail smtp.client-ip=52.103.2.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrktQCRYoarRaTaahi299QWOh55FvdznWBKKqqdUMQBplGwtpKwEGbi3/obf0ZkaUtNEm30e5FPsPebOZGZu4ehphhK12OBQ0mC0Nr0k6x6FX/pD+QzNKwjd1gOxXobQDS7iA2+IprbQiVKca5+d6jVh1IWUJZVh7Jww+7TyVqET7u1+34zOkzWsvaHEu0HPLXmka9QboU7V85EwzA6qZZRL/LfLzedEIMwfyB33lhgMTiWcpEPXQnJwXyeXZRpnopfDf+YJw2JJtbSS2wT/HePtWx0ipYMYOzYKmQkc3hUZWFeN1zq3nNSleQovlRBBZGNjYYQjgI6zU+Ua5S4vFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54C1OzqCxrU80nLlTzRCF8q4X56GZ1EbuTfgWuwYriE=;
 b=h5Z/nM9UjqVufdh0DrxPgQu9p1VuiOSXBNWAZ2+Bwgjua9z00j6N+EesDMNOuERoTJDgjQuoi+vzUsXkhoxzcghbicdowDNsB7ugZBWpSqzbX1CoUF1IyESxIYQTvHMRduUmWkQmTP2EOVLT/iAvoYKoE+LJZkZNuNcvHkEbhu2X82zY5WKr9QRKb7rCeGCBb+/Cu7/DfYt0q6RKnRtLB5N80mbXS9cg3Ujf0X56acc9oPl7aLxvhQ9aqeVpP+FyPODdYYBMJ4KhHlWm3IVSqLrzQvqGlKHK4A5EOrm5GKqOaUqWjmO/fKT1+7lzPJT9I5gXx7fMvgBQ4jJcBx7RqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54C1OzqCxrU80nLlTzRCF8q4X56GZ1EbuTfgWuwYriE=;
 b=UdzwQ1ZbvT09JW24yDlDdG8GpGcwJ/64nPAawprNvckEtCtw4nECHq4wA+xbX1RRM29P47ND2x73+hioWcGHn4S5mR/j7avxvVzmAoH1nRBSejEJOc6ht2B81cbnLdkIjiJo5u+WB6rX+LyRF5NEaF3PhmY824Dy8ENZ3iZD/rz9MTOJZYjOJhyR0lY+yvqj4JAP45OwhQTODN/w4uWJmIygxgwyqVbcaX2KUTnc8O8Ye6k+4gvAei+wiPXxGUJhjNuBbCpxdvPNc6rwXTzOyEfUYvUQ4qMlOUawlf53VCVmTehmgRJ9+Wryz9DoxJdMjpPbd5PDUv4uIolNMkcRXw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10155.namprd02.prod.outlook.com (2603:10b6:610:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 20 Feb
 2026 17:05:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.013; Fri, 20 Feb 2026
 17:05:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: Replace fixed memory deposit with status driven
 helper
Thread-Topic: [PATCH] mshv: Replace fixed memory deposit with status driven
 helper
Thread-Index: AQJg/fADswYCRXHJtJb49/bC/YNqNrSDFspg
Date: Fri, 20 Feb 2026 17:05:09 +0000
Message-ID:
 <SN6PR02MB415705AA10C44D52CFFC0D31D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10155:EE_
x-ms-office365-filtering-correlation-id: b538014e-b574-404c-aee1-08de70a2348f
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc6c3c4/rztiZGf6bH6e/ZC65Sl2rvp0TZvWU4K/SkdE8ySuZ+C0ak6dBW87qFBT2ATWbehAUSuabaY4vuURlJGWdlYkk642rRu5JE9iMJ+4ASdlI1OkYj0nGv6hu/V47i/tNhzlVrDg6mvKPdj42iy7qyDgH2Ctb/588C1/vJ78jGMkEr+ybADB6HL8XcJFvlE9Gehbfwb9GcNkrpOYP74LLj2i5H9312WY6o8LcsX0TW+P9X3YymeczWueENDVqnVGr6DYVqXPmtobNMCfUCWZQNVmcYHJ0KoykDT/mRQUj5xCkhz/g0MLVckk/1+NN0HwWz4s73tU7idJQ+JPQIG0ZFnbSgpY1RJElpWyten9Maj7OxOHN0k/RYN0faQyG2XjElTcvl5sBBmKBO8vJuprP8R5SrP6VKIghX1PmLoBlzOwyzf+UOt+dFtr1tX8SExkQGPhWTcMe4A0fQaG5JW9NVM5bnqkzeQ6lrz6dqKzxS0oupYwz0HFywmTE66gHDqjDbvTKVUAkT+w0dwKRGZZAipW+DAeQrtSFwAjbbAuX2btIot+feLMq0H+f92Yau2dXAJQeWGFYHRTcs+B0O5mumragKL16ERPGnKRMD5mVygC+eIPt7UNs7Q5jfNDQvYjFDmkNJMZilRnbI/dkvI70Ag2n7zcuWp97Jd2q3dku8195xdnGPjjr+PB3AawOyQDifnHWMsl7W85i+c75GyBe08x4wvmkgV5julHCRpyxj0tFGM7y3n
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|11091999009|15080799012|31061999003|51005399006|13091999003|461199028|12121999013|440099028|3412199025|102099032|13041999003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2VFQVRJWWV2MmZTenAvZ3JSVXRYeTYyTzlhTThSSHhIWkZlaCtRb3dYa1dh?=
 =?utf-8?B?YlRQZi90dEtaTkhabXNTeWlxUDg2bG0zNXBEc2M0SUJjbldxMm5yR0w4azdJ?=
 =?utf-8?B?VU9iNkdQbjB2bVozVFZRcHhtckE5QU5SOXRmd1g1VmFaRUpJTzIwbmNVejZY?=
 =?utf-8?B?K1dhWXMvSTdBcXRqYUVaeDVKb09URHpvQ3NrK0JLZUFqK0RSUUp2UjF6bEJi?=
 =?utf-8?B?L2JTZVJVME5TVi9OT2JzamRCRWZQZTRYMHdNYjNtYk5CbWZVdFJvblNucjBP?=
 =?utf-8?B?TEZlYllIajRqTnA1dFZtZWFEelRhWHVLeG1NRm1FTUg1bkZOSVV2ZUY5aHBZ?=
 =?utf-8?B?QkJZMGZNQk4raC85Y0dNMTVmRkt0Yi8xU2UzSXI2dk5lSUlpeHFHUG1PZ25Q?=
 =?utf-8?B?VzR3bm93NWgzclFOZDRNY3VmbkhseHdhOTYrZDBhODkvMWFvVGYyejRpRE0x?=
 =?utf-8?B?dmQzaXIvcTd1VVE0b0lWR0dRTjhmM0d6Uit1ZXhuNUNlQ1JyZzRTR0N3dHlY?=
 =?utf-8?B?ekpLMktFM0VYN3FKbzJaZFh6RjhWb3hEVVBKZjNjY1daMUhpQlBxK3pDUVY3?=
 =?utf-8?B?VDRidVNzVEdDSUF4OXBJMTVaSWU2a0x6VkFidGZTKzJ1ZnlrREpnSFUzd3ZX?=
 =?utf-8?B?WGY4TTluQllEMUFFWE9yOTZJYzdFRXVTYmlzNndoWXpXNFlhT04rTDNpU0sy?=
 =?utf-8?B?b08xalBOQ3l4cEhZaENsaUpoU2RWMVlXVEdnSXBDekFIUnVRdGh5TU9uclRK?=
 =?utf-8?B?bWk5WnhjRmlhbndVRFBlaGRwRFY0VndaQnFFVk1CNWpoYi9Eb2VNdm9CZTky?=
 =?utf-8?B?UDYxNldZTWE0M3JXT1R2Tm5JaHp0aEJJWUtpL0tKSVE4eTlGNkFEUzhCRnRw?=
 =?utf-8?B?RVB2TWhJZWVSWWlQUkRjMEZ6SGxpUlVFcjhFck9vV2hrajRpb0lQM2s2R01X?=
 =?utf-8?B?aFVkR0x6dG9WbmNVakliMXlUYnlXNDZ5ZVpqTmVHT051bmt4OU5BdFBEekRi?=
 =?utf-8?B?bzI5Y1lobXpMd0ZmbTdCUFJHSWxiTXMyMHA1RS9wYS9kZVlVbXBaSzIxeHZu?=
 =?utf-8?B?L0hMNlF0N3Z2b1FlL1ZOTjRQZ2pMSFNBUG90dWMyRlduYzhJTVpRZGFkZ1Mz?=
 =?utf-8?B?eERYT2RycnBYWDAvbGY2NkdPWElQUDM2aXBSTjRrY1JQMm1ZMVhpMmdERklw?=
 =?utf-8?B?a3FYYmZ0K05sNm9xM0RROGlKNlVkbHBFMENqVE1BRTdRNTB6TVMzdHRudGEy?=
 =?utf-8?B?dDMxNkFhdlUvb2F6YlZPMVNlbjBDbk5mTmxucGJVeXRLc1BxeFV0TS83Vmhz?=
 =?utf-8?B?UThiM1BiVVdha3NxZVZCUzNvNlVBY1BmbjVXQUxTMlRtQk9KZU5Pd0lpZy9i?=
 =?utf-8?B?S3d6YUhNVHY4TU9JL2kvcERvNWJGNXhtMVVGa04vOHU4S1RRRjZ1Mmk4QlA4?=
 =?utf-8?B?S1FxYWhRUVZUM2p6clJSUGhtWGEvRnYyTVB2eTBraXQ4SnJ5U0xsa1dhbHpp?=
 =?utf-8?B?OXI0NlNZOU9nZkJZRm12TERudEF1aWJMUlVjWFN6TmVmSTJmcGxYNjNPME8v?=
 =?utf-8?B?N0NtcFgvc1BDR0ViRDNLRGMvaXlGNk5CVkE4dHptRkNRVmV1NjMrdHhaeTRj?=
 =?utf-8?B?VGNVaWRHT3J2RWhLTWlwZEpUSy9BTnZsdFBxMFA4Slk5MFllTjNTTWh3b2ty?=
 =?utf-8?B?b3pHRy9idWtyMmxxN1JRRnZXM0NQR1V2OExkZThGSTNKdGlIY043eXJtdW4w?=
 =?utf-8?Q?V3s8lLBM4BzZN1Ga3H9oYgyMbAa7rI3Fv8VME8F?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MklvL25mamo2M2ZmTXM3Um5hOUdmUGFyaUNHc1FrNEpWTTIrZThJdk00KzVN?=
 =?utf-8?B?YTZGeUtzK2tCZnlhdE52Q0lHeXIrbjY3cVVOVlZnZ0gwVG1hRktHQ3VXUDlt?=
 =?utf-8?B?UEV3WjRWbjRLRXFhU3JvTEtuZUlaQmFsK080dUhTR3hjV3paNUhVVWI3bVhT?=
 =?utf-8?B?bjZRcjc1SkJpTWJ6YUliR2krWEh2ZDdHTjFIRm9PbDA3OEtYWG5YaW9XdHFC?=
 =?utf-8?B?bDFQRlhyLy90NmFURHBkdmgwR1VESUdDUW1hU1A0OG9tTmN6dllpb2pPOUtt?=
 =?utf-8?B?NXpoMHhHN3Y4OHFuam5uTFlQLzdoS3NGTFVjcW1hbFlLL3M2MU5Fa2Q0Vm00?=
 =?utf-8?B?UFVBdGs2T3oreFJtM1NGdTh3M2JDektldHJVS2xYZGJ5Y1p5ZnpObDNiaDlo?=
 =?utf-8?B?aFVoZVRIZGo5Y1lQTk91YjlQM29JV2gwZHVqWEUzcG8rcUpiVVVabk5WQXBm?=
 =?utf-8?B?cCtzTEVyUzFRYS9jeHYwbGZ4L25OandtaFAvNnZhZmNtNUR4WGtvdFpyYUJJ?=
 =?utf-8?B?cUZPSDZsM2lpWnAwRCt6aEtqem5rMFV0Y1IzVG94REN4V3Z3WTBJTys3VjJ5?=
 =?utf-8?B?VCtUS3I4em8rcGExUmVwVGE4L1RDdnhmWlZJdUFMejV0SjFheENWS1BaRUkr?=
 =?utf-8?B?dGN0Unp2N2VGcHFNbWwzczZYSWhNQWV1TGNLUnhYS3NMSDhxZU9JTkpkV3RQ?=
 =?utf-8?B?MmJKT2dLckxNNVVrQTk0UGpKNjlQeFVjRVdDeEluTlEzdHJiOUFMaW5xSllS?=
 =?utf-8?B?RCtnd1JuK2dEUGEvRktqVjg0aGllaXUrbExPV2I4bDh5M3hhNGhDSmxjOUhS?=
 =?utf-8?B?VjNlNjJSNTZlajcwZmZ0bm5wNUVTeUtMYjNiT3FsZGoyZWdpVUVQNlRxYTdW?=
 =?utf-8?B?SlRFZVBlR2dabFhoM1FXWHphcTJsUzNncG16T0tXcWpYVm1heHpCUzJaSG1i?=
 =?utf-8?B?ZDg2RlRPTzV5OWdGeSsvbU1jT1FKMzBYd0ZyRy9KSWZVSWJzbWRCVmo5U3BS?=
 =?utf-8?B?aXFoWGhJcmFnM29NOFBybUoyN2ZISFdtZlhscldwZ3VHNDJ3WUJvQWtPUW5L?=
 =?utf-8?B?OGxxbnFRbHpyY0VYejllRGVjN2V0cjZobnVwNGprOUFjcit4Vkl1MGdtMEVR?=
 =?utf-8?B?Ukh2Vm5OaUdRbVNiR1hyMUoyd2VUNitSMWg1b1A2enovVDJzQndRVC8vS1Bs?=
 =?utf-8?B?R09YeFdIKzBiSnRUZ3p5VEN6WmNMNjA4czRISDRlM2hRUjRaekVBVFNDMHJ3?=
 =?utf-8?B?SktpcUd6ZnFIZ2hVaXBVRzEwbE5BbEl4V1B1MW5LTWNjZ2dqSHFUbU9zQnUv?=
 =?utf-8?B?dWU2WWNaay9LZEZkeDF5MjRjd3pTQ0NKeWdzZmJ3UGU5YVp2dXIxZnFlRnFC?=
 =?utf-8?B?TWwvN3JuMldCeHNxclJLYnhPWWtrb1JGdTBYRlNHNS9hSkIwK0ZmK3pENEFJ?=
 =?utf-8?B?QlRaYmVXUElYWlRWdWpXaXVmck9BcnlSS1Rrc2JhSlNubjMrUmJINXB2VEFM?=
 =?utf-8?B?bTJGamphZnJ2cXJJUGpsVVBqOWVpVU40S1REVFJEd2hWb2FnUGtUYnIzdTRW?=
 =?utf-8?B?Z05yRW5ocUgzWkdiSllJOUNaNTloTnJuc1BPaTVSUnkwMDFQYzhkWmNQaFBP?=
 =?utf-8?B?SlN6S3V3aFBwZi9kS1B1aWlHQUUrT282Q3RkN0xXZVAzR3NmZmJSTHpORjM3?=
 =?utf-8?B?MnJza2t0Zyt4QnBQdXQvL2hUNTVrUlVFYUw1TlZIczFSR1NFYTlnc3RZYmdW?=
 =?utf-8?B?dkd1Tm01M3lIa2FOYU9Pa2VyZFVFdnpZM3JGd0ZPUE9yUEFPbW0yb00wbkJZ?=
 =?utf-8?Q?nLrjrixcNrOwhYwNj61jUmwlrGOXxjMebWj4k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b538014e-b574-404c-aee1-08de70a2348f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 17:05:10.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8929-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: F1CF7169913
X-Rspamd-Action: no action

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDE5LCAyMDI2IDI6MTAgUE0NCj4gDQo+IFJl
cGxhY2UgaGFyZGNvZGVkIEhWX01BUF9HUEFfREVQT1NJVF9QQUdFUyB1c2FnZSB3aXRoDQo+IGh2
X2RlcG9zaXRfbWVtb3J5KCkgd2hpY2ggZGVyaXZlcyB0aGUgZGVwb3NpdCBzaXplIGZyb20NCj4g
dGhlIGh5cGVyY2FsbCBzdGF0dXMsIGFuZCByZW1vdmUgdGhlIG5vdy11bnVzZWQgY29uc3RhbnQu
DQo+IA0KPiBUaGUgcHJldmlvdXMgY29kZSBhbHdheXMgZGVwb3NpdGVkIGEgZml4ZWQgMjU2IHBh
Z2VzIG9uDQo+IGluc3VmZmljaWVudCBtZW1vcnksIGlnbm9yaW5nIHRoZSBhY3R1YWwgZGVtYW5k
IHJlcG9ydGVkDQo+IGJ5IHRoZSBoeXBlcnZpc29yLg0KDQpEb2VzIHRoZSBoeXBlcnZpc29yIHJl
cG9ydCBhIHNwZWNpZmljIHBhZ2UgY291bnQgZGVtYW5kPyBJIGhhdmVuJ3QNCnNlZW4gdGhhdCBh
bnl3aGVyZS4gSXQgc2VlbXMgbGlrZSB0aGUgZGVwb3NpdCBtZW1vcnkgb3BlcmF0aW9uIGlzDQph
bHdheXMgc29tZXRoaW5nIG9mIGEgZ3Vlc3MuDQoNCj4gaHZfZGVwb3NpdF9tZW1vcnkoKSBoYW5k
bGVzIGRpZmZlcmVudA0KPiBkZXBvc2l0IHN0YXR1c2VzLCBhbGlnbmluZyBtYXAtR1BBIHJldHJp
ZXMgd2l0aCB0aGUgcmVzdA0KPiBvZiB0aGUgY29kZWJhc2UuDQo+IA0KPiBUaGlzIGFwcHJvYWNo
IG1heSByZXF1aXJlIG1vcmUgYWxsb2NhdGlvbiBhbmQgZGVwb3NpdA0KPiBoeXBlcmNhbGwgaXRl
cmF0aW9ucywgYnV0IGF2b2lkcyBvdmVyLWRlcG9zaXRpbmcgbGFyZ2UNCj4gZml4ZWQgY2h1bmtz
IHdoZW4gZmV3ZXIgcGFnZXMgd291bGQgc3VmZmljZS4gVW50aWwgYW55DQo+IHBlcmZvcm1hbmNl
IGltcGFjdCBpcyBtZWFzdXJlZCwgdGhlIG1vcmUgZnJ1Z2FsIGFuZA0KPiBjb25zaXN0ZW50IGJl
aGF2aW9yIGlzIHByZWZlcnJlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5z
YnVyc2tpaSA8c2tpbnNidXJza2lpQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQoNCkZyb20gYSBwdXJl
bHkgZnVuY3Rpb25hbCBzdGFuZHBvaW50LCB0aGlzIGNoYW5nZSBhZGRyZXNzZXMgdGhlDQpjb25j
ZXJuIHRoYXQgSSByYWlzZWQuIEJ1dCBJIGRvbuKAmXQgaGF2ZSBhbnkgaW50dWl0aW9uIG9uIHRo
ZSBwZXJmb3JtYW5jZQ0KaW1wYWN0IG9mIGhhdmluZyB0byBpdGVyYXRlLiBodl9kZXBvc2l0X21l
bW9yeSgpIGFkZHMgb25seSBhIHNpbmdsZQ0KcGFnZSBmb3Igc29tZSBvZiB0aGUgc3RhdHVzZXMs
IHNvIGlmIHRoZXJlIHJlYWxseSBpcyBhIGxhcmdlIG1lbW9yeSBuZWVkLA0KdGhlIG5ldyBjb2Rl
IHdvdWxkIGl0ZXJhdGUgMjU2IHRpbWVzIHRvIGFjaGlldmUgd2hhdCB0aGUgZXhpc3RpbmcgY29k
ZQ0KZG9lcy4NCg0KQW55IGlkZWEgd2hlcmUgdGhlIDI1NiBjYW1lIGZyb20gdGhlIGZpcnN0IHBs
YWNlPyAgV2FzIHRoYXQNCmVtcGlyaWNhbGx5IGRldGVybWluZWQgbGlrZSBzb21lIG9mIHRoZSBv
dGhlciBtZW1vcnkgZGVwb3NpdCBjb3VudHM/DQoNCkluIGFkZGl0aW9uIHRvIGEgcG90ZW50aWFs
IHBlcmZvcm1hbmNlIGltcGFjdCwgSSBrbm93IHRoZSBoeXBlcnZpc29yIHRyaWVzDQp0byBkZXRl
Y3QgZGVuaWFsLW9mLXNlcnZpY2UgYXR0ZW1wdHMgdGhhdCBtYWtlICJ0b28gbWFueSIgY2FsbHMg
dG8gdGhlDQpoeXBlcnZpc29yIGluIGEgc2hvcnQgcGVyaW9kIG9mIHRpbWUuIEluIHN1Y2ggYSBj
YXNlLCB0aGUgaHlwZXJ2aXNvcg0Kc3VzcGVuZHMgc2NoZWR1bGluZyB0aGUgVk0gZm9yIGEgZmV3
IHNlY29uZHMgYmVmb3JlIGFsbG93aW5nIGl0IHRvIHJlc3VtZS4NCkp1c3QgbmVlZCB0byBtYWtl
IHN1cmUgdGhlIGh5cGVydmlzb3IgZG9lc24ndCB0aGluayB0aGUgaXRlcmF0aW5nIGlzIGEgDQpk
ZW5pYWwtb2Ytc2VydmljZSBhdHRhY2suIE9yIG1heWJlIHRoYXQgZGVuaWFsLW9mLXNlcnZpY2Ug
ZGV0ZWN0aW9uDQpkb2Vzbid0IGFwcGx5IHRvIHRoZSByb290IHBhcnRpdGlvbiBWTS4NCg0KQnV0
IGZyb20gYSBmdW5jdGlvbmFsIHN0YW5kcG9pbnQsDQpSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxs
ZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9odi9tc2h2X3Jv
b3RfaHZfY2FsbC5jIHwgICAgNCArLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9tc2h2X3Jv
b3RfaHZfY2FsbC5jIGIvZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5jDQo+IGluZGV4IDdm
OTEwOTZmOTVhOC4uMzE3MTkxNDYyYjYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2L21zaHZf
cm9vdF9odl9jYWxsLmMNCj4gKysrIGIvZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5jDQo+
IEBAIC0xNiw3ICsxNiw2IEBADQo+IA0KPiAgLyogRGV0ZXJtaW5lZCBlbXBpcmljYWxseSAqLw0K
PiAgI2RlZmluZSBIVl9JTklUX1BBUlRJVElPTl9ERVBPU0lUX1BBR0VTIDIwOA0KPiAtI2RlZmlu
ZSBIVl9NQVBfR1BBX0RFUE9TSVRfUEFHRVMJMjU2DQo+ICAjZGVmaW5lIEhWX1VNQVBfR1BBX1BB
R0VTCQk1MTINCj4gDQo+ICAjZGVmaW5lIEhWX1BBR0VfQ09VTlRfMk1fQUxJR05FRChwZ19jb3Vu
dCkgKCEoKHBnX2NvdW50KSAmICgweDIwMCAtIDEpKSkNCj4gQEAgLTIzOSw4ICsyMzgsNyBAQCBz
dGF0aWMgaW50IGh2X2RvX21hcF9ncGFfaGNhbGwodTY0IHBhcnRpdGlvbl9pZCwgdTY0IGdmbiwg
dTY0DQo+IHBhZ2Vfc3RydWN0X2NvdW50LA0KPiAgCQljb21wbGV0ZWQgPSBodl9yZXBjb21wKHN0
YXR1cyk7DQo+IA0KPiAgCQlpZiAoaHZfcmVzdWx0X25lZWRzX21lbW9yeShzdGF0dXMpKSB7DQo+
IC0JCQlyZXQgPSBodl9jYWxsX2RlcG9zaXRfcGFnZXMoTlVNQV9OT19OT0RFLCBwYXJ0aXRpb25f
aWQsDQo+IC0JCQkJCQkgICAgSFZfTUFQX0dQQV9ERVBPU0lUX1BBR0VTKTsNCj4gKwkJCXJldCA9
IGh2X2RlcG9zaXRfbWVtb3J5KHBhcnRpdGlvbl9pZCwgc3RhdHVzKTsNCj4gIAkJCWlmIChyZXQp
DQo+ICAJCQkJYnJlYWs7DQo+IA0KPiANCj4gDQoNCg==

