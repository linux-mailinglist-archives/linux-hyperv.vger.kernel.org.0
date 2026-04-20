Return-Path: <linux-hyperv+bounces-10229-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MjuDnhy5mlgwgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10229-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 20:37:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 983C3432F43
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 20:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9244D30911F0
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5439D6D5;
	Mon, 20 Apr 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dd0oE/1J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011005.outbound.protection.outlook.com [52.103.1.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F31E7C12;
	Mon, 20 Apr 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705495; cv=fail; b=m4sGoot3hwI5txGiguqlpMYfU+cXsHbW9BapAQUqaVhDTrSSOtnpvla/vUOfMfnnX3dhU817DnRILUsx3RPX+GNDzPB33/TyE9NY3Nn52R1CkEPYwkqDa7oRO690wJZ0woo1raEXBnAY0NQ3IOP7VKL0LcntO0sdZYeJRykWKe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705495; c=relaxed/simple;
	bh=tmlPMrFZrUP9dRBVGOJpmE4obVLCzJnFhFFUKXRkYKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJm2xyHApZn0vj3prLTABEUKgQ0LgUb2Qu26WUKjKzBq5lMnMfa5HPv+Cb2V7DWeAIDB4crCwPCoPwR8jWRawgxn3LZ7P8J6UREtSMMAB3dlMkestPk0nF9DtHy3lwdwcWPbN7MpSODsxJWOejJbqe3GOyrekfcI0FYEgQX4Zd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dd0oE/1J; arc=fail smtp.client-ip=52.103.1.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2J1NzzEBFzAbjmC2JCqG4zuez2qefcZAlj/DRTURhXK08jNCGBGSse/X6g6bQJo4Oc1sHZsqX5HZjts9tg5rgETsDBl4uSrBQQ37Yd1YygcId0F4GpQnYFQppzd/mV2MerrAlcWvfnjJr2dcfLz1ZP5smUugZlsNhU8YXBA5//HD1GsdhMXXIyzdNAe+48UTKO4NCqP9+Jnt7EZofdTHIstQE2oEf1RQbfyrnj6rvHYa6ZkSuZ0RZLpZ7kI1hm9NAl+6HYsdHfUhDfNbcsHrUB+wTNjiC6hEirTMq2Q35CtuFICGz6P8UuqpYjthsEgQwbOYmJMAmOmJEcJcq1a3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmlPMrFZrUP9dRBVGOJpmE4obVLCzJnFhFFUKXRkYKg=;
 b=Fb4MToe5o+CMExgg6iKyYbnMH+hzgyCGzsbFYfctq89nBSZmo6VUXGzK0L9mHCnNj3cq8JxD6t+E5p5K8nNpDN2SFBUAggidD20jYBTqlUtltUDfd7+3uw6dGt1vOsVX7oxjLb9A8CIgiREIZsN+8P+3ijtk5+17SSIi2io7bR2wTep1a9uAVlXjYktaLEs9YwpZA5rvgZAgD3iR7Q3dYBL011bHL6ml7IdHlZKujcPmNR4q+w2BZBcSay82LUfbcMYXpjuYCoR70+WPdisRCQ44iUqVQnLmPCHZQmeXbJQce5io7wuh5ALcth1/WYZcUFHkcQ5+qcGpMovfWNdryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmlPMrFZrUP9dRBVGOJpmE4obVLCzJnFhFFUKXRkYKg=;
 b=dd0oE/1JOMA3xM981+YQ+Fl2rVf34i/HHIUbs5TnPqy1eldFZVUnphgULI5Tv4ekYdQZgZpTKjd/7/F0/ZAWNXZ6tpRwu3T/zc6qkB8QzCLOqWXrXECZde8jE2JgPrQ7fSfWfJ7L7ZMSlbTLyjNP8XKPKwAByq95Zp0WJC7SqW3rMGNRGGK89BE40YzIbgLfNCK4f0+k8jLXHbQYVctNmBZeVMqxJThuYMWhm79enTvPEBSewlp3vyooqPNumOUjVAizJd1n0V7GbSP0FI1iE8GkzdNOD6UwFw2BeJ2MKeYYD30sTlXjs11OHq/FqnE6WWRD8coK+NEJgEGGtOjKoQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8271.namprd02.prod.outlook.com (2603:10b6:408:15a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 17:18:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 17:18:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] mshv: Convert from page pointers to PFNs
Thread-Topic: [PATCH 1/7] mshv: Convert from page pointers to PFNs
Thread-Index: AQIU4Z+TtrNiAr8jNsFOwdDCIL2bZAEyNeRRtWAzUaCADjtVAIAAD6/Q
Date: Mon, 20 Apr 2026 17:18:10 +0000
Message-ID:
 <SN6PR02MB41571DD9045771941F371750D42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490105758.81669.969284388846280218.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157CD26728B2D4BFD171DB7D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aeZSnjgSkm7vJxhW@skinsburskii.localdomain>
In-Reply-To: <aeZSnjgSkm7vJxhW@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8271:EE_
x-ms-office365-filtering-correlation-id: b4742c23-f2bc-4ffc-a31c-08de9f00cbf0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|41001999006|15080799012|31061999003|13091999003|51005399006|461199028|37011999003|19110799012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDNrUTdlQ0FzaDk1blppREI2TG1GUXBSQzdSZnB2V0E5VXV1V0dRZ1o3dXl3?=
 =?utf-8?B?Y3ZkYkFPZ3VSaERiaGNFYVBJcVF1Sit0NTA1YUZkUzZsaUFwVlNkOFlZRnV4?=
 =?utf-8?B?UGlsbWZZU1krZEIrS2FhZnVxTDZtbVM0Tkx3U2dhQmVRZjdUMGphVjBCTEFn?=
 =?utf-8?B?cnlrTEhYSEE0RXpFYi9peC9mcVlCUDZKYUsrV3pFQk01TElVSllaWk9CWkxY?=
 =?utf-8?B?SEdGVG1jYm9YTkFWL1o4cmVIMkovSXpETk1UTTVJODgwRGUvMVZwY2ZKZUU4?=
 =?utf-8?B?a2tqdHh5ditFZHRuZlpoa0F3OHhMMzZydnZMOWdGUTZRZjFpd3djeHVvZFFq?=
 =?utf-8?B?bldobFVoMWtlWTFRSFVDVzA3NEo0WW1NdnpON2FuUEM3SlNmVHZ0OU5VMFRW?=
 =?utf-8?B?N2dKZ2RiVUc3ODl4N1hVaEY4QmhzNFdiZE9PQWNXOVppbkMwdEYzekpMQzVT?=
 =?utf-8?B?Qy8yNW5ZeWZUbHJGdUlTYmxEMjZycENZaGpFYkNyaTBsK0ZyUVZJa3g2ODMx?=
 =?utf-8?B?VlpCN0gvTUY0NThDQVdoY3J5aWtoRlY1ZjVuNkNxemM4V2M4WWc3NE5MYjMr?=
 =?utf-8?B?TkFJU0dzNFFINkxycVovalFIemR3enJPRW9RZDRmVlpaZnVTanozV0xqQkZI?=
 =?utf-8?B?VHExOUFIMVpIaFRSUitmT3Z1NlpQUS9HT3ladk9DQTB2MzdGMjVMMTRjUWNy?=
 =?utf-8?B?aWtpcmx6SjFmSnl1MmFHTHpKbTArbk83cVRNUlpJNGoyZzFtQ0JjRFpwbmhW?=
 =?utf-8?B?NzBXQytXa0FtUXdZbFlzWGxrd2J6czlIZ3pSTjk5THU0M3d4bExwQjIyS2xn?=
 =?utf-8?B?VkcvL010YzRGN1hMcFFGTWRoMm0vaUNRS3FUMW5FM2xSZ2F5MkV1bUVmUFlk?=
 =?utf-8?B?Nm05bzd4VWh5eTZoZ0ZRaGoyWFJ2RUNObThEYVFqTHE4Y2cvTjl2Qi9PaHdU?=
 =?utf-8?B?UWhLQzBuMXhqelM0elZlczYrazlaVzF5eFh6VHJWck45YmRQUCs5enVLd1pQ?=
 =?utf-8?B?Z3o2aWlrOHBFWmd1dmRBUEZHY3FHUGJKN3ZIWlNDM2ZZeEQrc2hIWmFVcnBt?=
 =?utf-8?B?RkhJbDEzeERKcnV6eFh0eHFMR0hyTGNoU05OWGtqc3FjbXc1MVIrZXFvZE5F?=
 =?utf-8?B?VzF0OS9mTnhWYjdBSEY2ZHd0ZmpyWXRqVkVQT1k1bHFieFhoWGp0M0xLWndY?=
 =?utf-8?B?bVFDZzVYaTVuL0Njb3lRSVlLaEhyaXgwc3hrQ0twM3dSRXhpb0NpWms5QXFt?=
 =?utf-8?B?VHI4L3g0bG1DSW5QQXdwQmRRNWpoQXJmWXBIelJ3WUczNk05UDJjZGVNVEFx?=
 =?utf-8?Q?hpYMpR0+X63UZIqoySKR03q3NeVxBXFGpl?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWsxczFZQWpDNURmOXdrVFgyR2RlK3lVbkIxZVA1UzNNaEdSTzhaVFdWZGls?=
 =?utf-8?B?Q0w3MkR2QWtuYVVnOUs3SFhLK2I4dmtMV3YwQkJPMklmcUVBZElzZDVDdDNx?=
 =?utf-8?B?MDI2NDZvcnIzTjZyTWFUa0h6N2UvYzhwQUQxUHdPbjROdHhmZVp5WjFiWGJY?=
 =?utf-8?B?czhHMmM1TEZrc2ZKUm15cVM2TUtkQjh5U3BzWHhxZ09pcnR4bVdQSTJmMFZl?=
 =?utf-8?B?SUZMZWhoNlN6RnJTclorR1FhM0FOYXJIKy8vaGRrbTZFUW9yOG8rL1Z4d2Fo?=
 =?utf-8?B?YzhTdnBSMk56MlcxZmlwcWhqbHRQemRkeGoyU0hsOURTOE9vMkZHdmEzZGVV?=
 =?utf-8?B?bVk0c0ZsMmFTMzdvT0R3Z3g5TnVucDZtQ0FsNjZBdGxoRWdaTmEzWWdKbWRB?=
 =?utf-8?B?bmFrU1c1WllFQXZqb21MeVhxWW0xZHBrNXl5a2EyVDMzUkZHL2FOSEtGK3pl?=
 =?utf-8?B?YmFxZDRxbTYxeFJQY25BaklSK0VIOWlQazlNdFE5MHFxdTBmdTBEZ0hzaGQ5?=
 =?utf-8?B?dVA4MDZFZjJvLzJkSmh5TC9kYW1TQnQ3b0tyNGlQMDJENkpNbGIxZStEcXN0?=
 =?utf-8?B?c0VoZXdTZ1dWN3A4b0dkN0dxSytDYVJqb3ZwY2kvOW56RVo2dmdGS1UzYk50?=
 =?utf-8?B?UzFGWmZ3aXdzVVRKbE1YZWZySDd1S1JSanVOUERyd0k3dGxHZy84SVdVZlY2?=
 =?utf-8?B?TGJJMWVvSmJ0OTRnUUl4Z2JXWkJNQllRWDJpY3ZxS21PZXZQVkFqdmNoc3Q4?=
 =?utf-8?B?NVN6eFEzTkJTQ2ovQm53SkJMalYzcTJvdmVlcGYxaGpZbS83ZWFJc3JvL2tm?=
 =?utf-8?B?bmRvMzlGMGVGeEhBL1VhVHR5dkRONlVNdjh5MTcxWUJITGZTSitlTnpLaEY2?=
 =?utf-8?B?YTZxQ2hIZm1RVFUwZmJleEtReXNLWjZjTnA3dDZIcm0rTTlBTU4vQ0dESjNO?=
 =?utf-8?B?U0pPM2hXTWNsdnd3Qk5tSk9PamZyODl6S1dORmVJT3VNVjkvM243ZlE4Z05r?=
 =?utf-8?B?MFFwRHZjb1k5cFJZVkpHOWFzNWg2ZXhIUGtid2JVU0VtLy9wT3lpK0ZRR2Z6?=
 =?utf-8?B?eHk5NUNFOTA5Q3gxbmtXd2VZTDlzSlh3MTB1SjQ5OXhkTFZJSjhiWWV2NXhT?=
 =?utf-8?B?ZElDL3Z6U0ZteEM2NnNzK3hlMXZsT1lGaUdFamQ1eFlkVFAzeTdJVzVwdkpy?=
 =?utf-8?B?dGtXd05PYXJHMEVsT2ZpV0pYWStuM2poTkdOY0RsYlFzTmhGcWdLNmVXN050?=
 =?utf-8?B?a1B6MjZzSUJBcjBkTzBKei9CRkthbjRONUhsS1NvR1pOSWN2R2dKN2ZZeDQw?=
 =?utf-8?B?ZExSMTNOT0I5QWtpa3M0UU0vYmcwMThJVVQrbnRrZE10ckpVb1Y3RHlWVUhW?=
 =?utf-8?B?L0JGMXlFZ3lZeStvTXcyMFVLbWpQK3hpVzJFMEljOFpTQ2Y0WGRDbk5IVXZt?=
 =?utf-8?B?UkN1V0VRMzVNOVhTZTFPOHZIUWlTNGR4TGl4cFdDWlFPelRFZjVwRXdZeEpz?=
 =?utf-8?B?cVpkTXBuTWZUWlBONlY3eGp4ZHZUMGNCMlp5anBDVDZJZ09VNTFua0lEbm1G?=
 =?utf-8?B?SXVzWHVSaEg4L0NJMFkxdEMzbEtNazA2K2RZTFplR1ZwamV4dklwL0d1OFJY?=
 =?utf-8?B?cWhvWFd5OCt2VGVUR080OWZLOW5rWjlUWnBPSXBJak5SZU4wcGhzSDc3eGda?=
 =?utf-8?B?N0JDbmVvK01kdzUzSGxwaU1yTXFvQk8zeDNGUEFpQVpnM2RUMnhwa3k1ek9M?=
 =?utf-8?B?dHcyOFcyZk9NYjdINzJ4MHVvWGdCMzZNazNxcy92WkFtdmNDalJiOG82WWlq?=
 =?utf-8?B?RndJN1lMRlhtZTRKbDRib2dWcERaR0FOQlFCdUJxendNa1VmQjhnM2ExWkFq?=
 =?utf-8?B?bGdvSUMxNnZqbnJnbmxzNkdYclZZbEpIL1BjVEE1ZlE4YW1xbTNDNW0yaita?=
 =?utf-8?Q?SvPDr/9F/G0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4742c23-f2bc-4ffc-a31c-08de9f00cbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 17:18:10.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8271
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
	TAGGED_FROM(0.00)[bounces-10229-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 983C3432F43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogTW9uZGF5LCBBcHJpbCAyMCwgMjAyNiA5OjIyIEFNDQo+IA0KPiBPbiBNb24s
IEFwciAxMywgMjAyNiBhdCAwOTowODoxNlBNICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gPiBGcm9tOiBTdGFuaXNsYXYgS2luc2J1cnNraWkgPHNraW5zYnVyc2tpaUBsaW51eC5taWNy
b3NvZnQuY29tPiBTZW50OiBNb25kYXksIE1hcmNoIDMwLCAyMDI2IDE6MDQgUE0NCj4gPiA+DQoN
CltzbmlwXQ0KDQo+ID4gPiBAQCAtNTcsNjAgKzU4LDYxIEBAIHN0YXRpYyBpbnQgbXNodl9jaHVu
a19zdHJpZGUoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ID4gPiAgLyoqDQo+ID4gPiAgICogbXNodl9y
ZWdpb25fcHJvY2Vzc19jaHVuayAtIFByb2Nlc3NlcyBhIGNvbnRpZ3VvdXMgY2h1bmsgb2YgbWVt
b3J5IHBhZ2VzDQo+ID4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluIGEgcmVn
aW9uLg0KPiA+ID4gLSAqIEByZWdpb24gICAgIDogUG9pbnRlciB0byB0aGUgbWVtb3J5IHJlZ2lv
biBzdHJ1Y3R1cmUuDQo+ID4gPiAtICogQGZsYWdzICAgICAgOiBGbGFncyB0byBwYXNzIHRvIHRo
ZSBoYW5kbGVyLg0KPiA+ID4gLSAqIEBwYWdlX29mZnNldDogT2Zmc2V0IGludG8gdGhlIHJlZ2lv
bidzIHBhZ2VzIGFycmF5IHRvIHN0YXJ0IHByb2Nlc3NpbmcuDQo+ID4gPiAtICogQHBhZ2VfY291
bnQgOiBOdW1iZXIgb2YgcGFnZXMgdG8gcHJvY2Vzcy4NCj4gPiA+IC0gKiBAaGFuZGxlciAgICA6
IENhbGxiYWNrIGZ1bmN0aW9uIHRvIGhhbmRsZSB0aGUgY2h1bmsuDQo+ID4gPiArICogQHJlZ2lv
biAgICA6IFBvaW50ZXIgdG8gdGhlIG1lbW9yeSByZWdpb24gc3RydWN0dXJlLg0KPiA+ID4gKyAq
IEBmbGFncyAgICAgOiBGbGFncyB0byBwYXNzIHRvIHRoZSBoYW5kbGVyLg0KPiA+ID4gKyAqIEBw
Zm5fb2Zmc2V0OiBPZmZzZXQgaW50byB0aGUgcmVnaW9uJ3MgUEZOcyBhcnJheSB0byBzdGFydCBw
cm9jZXNzaW5nLg0KPiA+ID4gKyAqIEBwZm5fY291bnQgOiBOdW1iZXIgb2YgUEZOcyB0byBwcm9j
ZXNzLg0KPiA+ID4gKyAqIEBoYW5kbGVyICAgOiBDYWxsYmFjayBmdW5jdGlvbiB0byBoYW5kbGUg
dGhlIGNodW5rLg0KPiA+ID4gICAqDQo+ID4gPiAtICogVGhpcyBmdW5jdGlvbiBzY2FucyB0aGUg
cmVnaW9uJ3MgcGFnZXMgc3RhcnRpbmcgZnJvbSBAcGFnZV9vZmZzZXQsDQo+ID4gPiAtICogY2hl
Y2tpbmcgZm9yIGNvbnRpZ3VvdXMgcHJlc2VudCBwYWdlcyBvZiB0aGUgc2FtZSBzaXplIChub3Jt
YWwgb3IgaHVnZSkuDQo+ID4gPiAtICogSXQgaW52b2tlcyBAaGFuZGxlciBmb3IgdGhlIGNodW5r
IG9mIGNvbnRpZ3VvdXMgcGFnZXMgZm91bmQuIFJldHVybnMgdGhlDQo+ID4gPiAtICogbnVtYmVy
IG9mIHBhZ2VzIGhhbmRsZWQsIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBpZiB0aGUgZmlyc3Qg
cGFnZSBpcw0KPiA+ID4gLSAqIG5vdCBwcmVzZW50IG9yIHRoZSBoYW5kbGVyIGZhaWxzLg0KPiA+
ID4gKyAqIFRoaXMgZnVuY3Rpb24gc2NhbnMgdGhlIHJlZ2lvbidzIFBGTnMgc3RhcnRpbmcgZnJv
bSBAcGZuX29mZnNldCwNCj4gPiA+ICsgKiBjaGVja2luZyBmb3IgY29udGlndW91cyB2YWxpZCBQ
Rk5zIGJhY2tlZCBieSBwYWdlcyBvZiB0aGUgc2FtZSBzaXplDQo+ID4gPiArICogKG5vcm1hbCBv
ciBodWdlKS4gSXQgaW52b2tlcyBAaGFuZGxlciBmb3IgdGhlIGNodW5rIG9mIGNvbnRpZ3VvdXMg
dmFsaWQNCj4gPiA+ICsgKiBQRk5zIGZvdW5kLiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgUEZOcyBo
YW5kbGVkLCBvciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUNCj4gPiA+ICsgKiBpZiB0aGUgZmlyc3Qg
UEZOIGlzIGludmFsaWQgb3IgdGhlIGhhbmRsZXIgZmFpbHMuDQo+ID4gPiAgICoNCj4gPiA+IC0g
KiBOb3RlOiBUaGUgQGhhbmRsZXIgY2FsbGJhY2sgbXVzdCBiZSBhYmxlIHRvIGhhbmRsZSBib3Ro
IG5vcm1hbCBhbmQgaHVnZQ0KPiA+ID4gLSAqIHBhZ2VzLg0KPiA+ID4gKyAqIE5vdGU6IFRoZSBA
aGFuZGxlciBjYWxsYmFjayBtdXN0IGJlIGFibGUgdG8gaGFuZGxlIHZhbGlkIFBGTnMgYmFja2Vk
IGJ5DQo+ID4gPiArICogYm90aCBub3JtYWwgYW5kIGh1Z2UgcGFnZXMuDQo+ID4gPiAgICoNCj4g
PiA+ICAgKiBSZXR1cm46IE51bWJlciBvZiBwYWdlcyBoYW5kbGVkLCBvciBuZWdhdGl2ZSBlcnJv
ciBjb2RlLg0KPiA+ID4gICAqLw0KPiA+ID4gLXN0YXRpYyBsb25nIG1zaHZfcmVnaW9uX3Byb2Nl
c3NfY2h1bmsoc3RydWN0IG1zaHZfbWVtX3JlZ2lvbiAqcmVnaW9uLA0KPiA+ID4gLQkJCQkgICAg
ICB1MzIgZmxhZ3MsDQo+ID4gPiAtCQkJCSAgICAgIHU2NCBwYWdlX29mZnNldCwgdTY0IHBhZ2Vf
Y291bnQsDQo+ID4gPiAtCQkJCSAgICAgIGludCAoKmhhbmRsZXIpKHN0cnVjdCBtc2h2X21lbV9y
ZWdpb24gKnJlZ2lvbiwNCj4gPiA+IC0JCQkJCQkgICAgIHUzMiBmbGFncywNCj4gPiA+IC0JCQkJ
CQkgICAgIHU2NCBwYWdlX29mZnNldCwNCj4gPiA+IC0JCQkJCQkgICAgIHU2NCBwYWdlX2NvdW50
LA0KPiA+ID4gLQkJCQkJCSAgICAgYm9vbCBodWdlX3BhZ2UpKQ0KPiA+ID4gK3N0YXRpYyBsb25n
IG1zaHZfcmVnaW9uX3Byb2Nlc3NfcGZucyhzdHJ1Y3QgbXNodl9tZW1fcmVnaW9uICpyZWdpb24s
DQo+ID4gPiArCQkJCSAgICAgdTMyIGZsYWdzLA0KPiA+ID4gKwkJCQkgICAgIHU2NCBwZm5fb2Zm
c2V0LCB1NjQgcGZuX2NvdW50LA0KPiA+ID4gKwkJCQkgICAgIGludCAoKmhhbmRsZXIpKHN0cnVj
dCBtc2h2X21lbV9yZWdpb24gKnJlZ2lvbiwNCj4gPiA+ICsJCQkJCQkgICAgdTMyIGZsYWdzLA0K
PiA+ID4gKwkJCQkJCSAgICB1NjQgcGZuX29mZnNldCwNCj4gPiA+ICsJCQkJCQkgICAgdTY0IHBm
bl9jb3VudCwNCj4gPiA+ICsJCQkJCQkgICAgYm9vbCBodWdlX3BhZ2UpKQ0KPiA+ID4gIHsNCj4g
PiA+IC0JdTY0IGdmbiA9IHJlZ2lvbi0+c3RhcnRfZ2ZuICsgcGFnZV9vZmZzZXQ7DQo+ID4gPiAr
CXU2NCBnZm4gPSByZWdpb24tPnN0YXJ0X2dmbiArIHBmbl9vZmZzZXQ7DQo+ID4gPiAgCXU2NCBj
b3VudDsNCj4gPiA+IC0Jc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ID4gPiArCXVuc2lnbmVkIGxvbmcg
cGZuOw0KPiA+ID4gIAlpbnQgc3RyaWRlLCByZXQ7DQo+ID4gPg0KPiA+ID4gLQlwYWdlID0gcmVn
aW9uLT5tcmVnX3BhZ2VzW3BhZ2Vfb2Zmc2V0XTsNCj4gPiA+IC0JaWYgKCFwYWdlKQ0KPiA+ID4g
KwlwZm4gPSByZWdpb24tPm1yZWdfcGZuc1twZm5fb2Zmc2V0XTsNCj4gPiA+ICsJaWYgKCFwZm5f
dmFsaWQocGZuKSkNCj4gPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4NCj4gPiA+IC0Jc3Ry
aWRlID0gbXNodl9jaHVua19zdHJpZGUocGFnZSwgZ2ZuLCBwYWdlX2NvdW50KTsNCj4gPiA+ICsJ
c3RyaWRlID0gbXNodl9jaHVua19zdHJpZGUocGZuX3RvX3BhZ2UocGZuKSwgZ2ZuLCBwZm5fY291
bnQpOw0KPiA+ID4gIAlpZiAoc3RyaWRlIDwgMCkNCj4gPiA+ICAJCXJldHVybiBzdHJpZGU7DQo+
ID4gPg0KPiA+ID4gIAkvKiBTdGFydCBhdCBzdHJpZGUgc2luY2UgdGhlIGZpcnN0IHN0cmlkZSBp
cyB2YWxpZGF0ZWQgKi8NCj4gPiA+IC0JZm9yIChjb3VudCA9IHN0cmlkZTsgY291bnQgPCBwYWdl
X2NvdW50OyBjb3VudCArPSBzdHJpZGUpIHsNCj4gPiA+IC0JCXBhZ2UgPSByZWdpb24tPm1yZWdf
cGFnZXNbcGFnZV9vZmZzZXQgKyBjb3VudF07DQo+ID4gPiArCWZvciAoY291bnQgPSBzdHJpZGU7
IGNvdW50IDwgcGZuX2NvdW50IDsgY291bnQgKz0gc3RyaWRlKSB7DQo+ID4gPiArCQlwZm4gPSBy
ZWdpb24tPm1yZWdfcGZuc1twZm5fb2Zmc2V0ICsgY291bnRdOw0KPiA+ID4NCj4gPiA+IC0JCS8q
IEJyZWFrIGlmIGN1cnJlbnQgcGFnZSBpcyBub3QgcHJlc2VudCAqLw0KPiA+ID4gLQkJaWYgKCFw
YWdlKQ0KPiA+ID4gKwkJLyogQnJlYWsgaWYgY3VycmVudCBwZm4gaXMgaW52YWxpZCAqLw0KPiA+
ID4gKwkJaWYgKCFwZm5fdmFsaWQocGZuKSkNCj4gPg0KPiA+IHBmbl92YWxpZCgpIGlzIGEgcmVs
YXRpdmVseSBleHBlbnNpdmUgdGVzdCB0byBiZSBkb2luZyBpbiBhIGxvb3ANCj4gPiBvbiB3aGF0
IG1heSBiZSBldmVyeSBzaW5nbGUgcGFnZS4gSXQgZG9lcyBhbiBSQ1UgbG9jay91bmxvY2sNCj4g
PiBhbmQgbWFrZSBvdGhlciBjaGVja3MgdGhhdCBhcmVuJ3QgbmVjZXNzYXJ5IGhlcmUuIFNpbmNl
DQo+ID4gbXJlZ19wZm5zW10gaXMgcG9wdWxhdGVkIGZyb20gbW0gY2FsbHMsIHRoZSBvbmx5IGlu
dmFsaWQgUEZOcw0KPiA+IHdvdWxkIGJlIE1TSFZfSU5WQUxJRF9QRk4gdGhhdCBjb2RlIGluIHRo
aXMgbW9kdWxlIGhhcw0KPiA+IGV4cGxpY2l0bHkgcHV0IHRoZXJlLiBKdXN0IHRlc3RpbmcgYWdh
aW5zdCBNU0hWX0lOVkFMSURfUEZODQo+ID4gd291bGQgYmUgYSBsb3QgZmFzdGVyIGhlcmUgYW5k
IGVsc2V3aGVyZSBpbiB0aGlzIG1vZHVsZS4gSXQncw0KPiA+IHJlYWxseSBhICJwZm4gc2V0L25v
dCBzZXQiIHRlc3QuIERlZmluaW5nIGEgcGZuX3NldCgpIG1hY3JvDQo+ID4gaGVyZSBpbiB0aGlz
IG1vZHVsZSB0aGF0IHRlc3RzIGFnYWluc3QgTVNIVl9JTlZBTElEX1BGTg0KPiA+IHdvdWxkIGFj
Y29tcGxpc2ggdGhlIHNhbWUgdGhpbmcgbW9yZSBlZmZpY2llbnRseS4NCj4gPg0KPiANCj4gWWVz
LCB3ZSBjb3VsZCBkbyBpdCB0aGUgd2F5IHlvdSBzdWdnZXN0LiBGb3IgY29tcGxldGVuZXNzLCBJ
IHNob3VsZCBhZGQNCj4gdGhhdCBwZm5fdmFsaWQoKSBpcyBleHBlbnNpdmUgb25seSBvbiAzMi1i
aXQgQVJNIGFuZCBBUkMsIHdoaWNoIHdlDQo+IGRvbuKAmXQgY2FyZSBhYm91dC4NCj4gDQoNCkNv
dWxkIHlvdSBlbGFib3JhdGU/IE9uIHg4NiwgSSdtIHNlZWluZyB0aGF0IHBmbl92YWxpZCgpIGlz
IGFib3V0DQoyMjAgYnl0ZXMgb2YgY29kZS4gSXQncyB0aGUgdmVyc2lvbiBpbiBpbmNsdWRlL2xp
bnV4L21tem9uZS5oLCBub3QNCnRoZSBzaW1wbGUgdmVyc2lvbiBpbiBpbmNsdWRlL2FzbS1nZW5l
cmljL21lbW9yeV9tb2RlbC5oLiBUaGUNCmxhdHRlciBpcyB1c2VkIG9ubHkgZm9yIENPTkZJR19G
TEFUTUVNPXkuIE9yIGlzIHRoZSByb290IHBhcnRpdGlvbg0Ka2VybmVsIGJ1aWxkIHNldHRpbmcg
Q09ORklHX0ZMQVRNRU1fTUFOVUFMIGFuZCBoZW5jZSBnZXR0aW5nDQp0aGUgc2ltcGxlIHZlcnNp
b24/DQoNCk1pY2hhZWwNCg==

