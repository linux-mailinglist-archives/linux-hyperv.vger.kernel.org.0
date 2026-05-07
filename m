Return-Path: <linux-hyperv+bounces-10702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGTEK+np/GkMVQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10702-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 21:37:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49E4EE1E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23F0630036C9
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81236441032;
	Thu,  7 May 2026 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CV470yFd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013065.outbound.protection.outlook.com [52.103.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A42701CB;
	Thu,  7 May 2026 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182630; cv=fail; b=Zg1HtG1HqUbj1bU4G4BAXmcoRmHBndDvL6VDfZb6c9DwVlZWjYAtuEAFQG0dDI7reBnfGTMwIEVipJk4s33HBqduWEuxoEtsEpKSuTyfjFJkL18f2oPVa8/gfv9r0qr/0o2TqvUC/VDLaBKFMK7G6WFwtvJycYB04lVw4Wyxvas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182630; c=relaxed/simple;
	bh=Zx3qm68EZB8lNX1QZTZ49IuTTa2X4v2Iblc3DnDT3j4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bqfyf+mFoeOkcWwTCNYIqINjJUKzZZsfhi4KZWLMja2ySRRPnXmDLdcxSM41ztpEBHX12D4JvY6p6HUa+QTv4bH9mxqb0IR5xP3334L4SrRldoQJAbpFBU9WueBnZ5U8zyFLqh8jBNVNz0gKKNz5nxBgHSolP5W6TzlVVVxtJpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CV470yFd; arc=fail smtp.client-ip=52.103.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THBiOxHOAhrAXICcwCsCgnu6k2CA+UkfOlcB0SbV58/3loar4XMqopjY/xygovZNhygMUMFCq3oNX7WGUgGdVIB/sSgsePNtYgx3e7jnyXbHeG6y/TGo5WoNu62lvELiYmEwUEtFF+pWO1t1KS0U4PLkI4oiAuBsw4Qt/w9dqngIg/KExBPMTkFU5wQqsjhAQPdoMA628OTrYr7dyF3IxDNlTmqDnaJQUxHRoqGFVza/3NRUf9XGCgwsKqUbrahOnShHwLpgj1M9Jtut+pH+tzsLaBg71etme1XSky/PdbV5S/nxu8w4NcK/EpG6IQYHkYVjUarjsdsTUH8egXjxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx3qm68EZB8lNX1QZTZ49IuTTa2X4v2Iblc3DnDT3j4=;
 b=J1ZuOb8zJdXYZxlBClRQPIbZuFABuGAbwZ7qkhNoHlfkdMO5dqwBwEhBObVW+7nHxge2d6FXEJZDeXPjE7l1lxMh6hUB49hDrpQewcQEhy7hRX8y3oThtOruyQLMHcyOomCSU0uX35dDIOyd9vrC4Rpx/PsPW1bksXK8B/T/ELfbGjds7aQ2QBCLJeOez2bosGKg16SgEIsj/qXPr80xESCQAwrjFMV/oRLo2yB7ivlyF7wnSRPQLfphne2HzgI0og11SDYmnpEovgdd5FOAmNCq+G8PxsCHWUDWui7MhimjtqBkfi6q4Z1DzDZeSTfPn9bLUvs+tkfiRdv7wrIeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx3qm68EZB8lNX1QZTZ49IuTTa2X4v2Iblc3DnDT3j4=;
 b=CV470yFdM6Ncnu1O9YXPu+xN11vI3mfFvbfqjyEiMBNDNx6K6b81BiB3827vrNuBZ6+y+vNL/w/I8ktPFIvYg/6sVlnr2dv/qMUTlY+73WOcrfKn6N/XePqsOPbonlIQIv9WAuQvudgtAAvNd1kNufRbIZieMwJvJ52I0azqiViqQzRvrsKKZDtZjiWmQkcYlSGBhPO9x7HD43jc20Mdo5ACRUS9jcW5KriRfsXn5zm43kYe1jM+3qSAzU3v45wv1vCD7S/7Hwo0X3fqDoFcUJgayDRLVuofAVzpG2BSrrL+rt8blhSmLhUFtNtbVqxrqZuOAfBVxckIhth//xqdxw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 19:37:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 19:37:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Thread-Topic: [PATCH v3] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Thread-Index: AQIvXS4g03wegVw2OM69lsL0rBxQLrVd9VcQ
Date: Thu, 7 May 2026 19:37:05 +0000
Message-ID:
 <SN6PR02MB415714E20A5A221AA79A9962D43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com>
In-Reply-To: <20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8121:EE_
x-ms-office365-filtering-correlation-id: 87be8208-6105-47fb-dc9a-08deac700532
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|55001999006|51005399006|19101099003|13091999003|41001999006|8062599012|19110799012|15080799012|8060799015|461199028|12121999013|31061999003|19061999003|1602099012|40105399003|3412199025|4302099013|440099028|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0NMRi9lUHFnanlsV3Yza3ByZW5PNkJmNlU5MXExRVdtR09WRDFHODF3QW0w?=
 =?utf-8?B?UUYwRkpqclVVcEdURWJ5cWxCY1p1M1R3b2txK2VncHVpZGg3aHBra0lvSXI2?=
 =?utf-8?B?QWhTTlh6Zi9YM2JNbEUrTXFvdnMrTCtzMnNRR0kwbGNWYmVwbGpBaElVZm1p?=
 =?utf-8?B?bkxVT3Fwczh5bW5ueDdFNFRUYUU1L1pZS3dqWjNHRHpnMVVudmdwckEzenBB?=
 =?utf-8?B?U1pKa3VDdkE0MEthN1ZOM0FiWFdRSTBhWmZIL24zdlFRM3NiZ1RiNnNsekJZ?=
 =?utf-8?B?amYxbGxydzFiblpZRDN0YVpaTTRpRG1DOWtWUHE0MDZyNDM0K3I2NUlFM1BW?=
 =?utf-8?B?SmFCdUh5RUNaZmRVVUt4alJ0eUhxNEtub2VwQkFEeC9rcUk4OUlzRmVDY283?=
 =?utf-8?B?SDZVbFFSWm1hYXR2YmpnVXl3YVJlUlBibkxCaFpqMVI0YnZ3RUJidTRqekNa?=
 =?utf-8?B?SnUyMVErUzloUzQxcUo4Wmtld2RjajNrRndNSEpjaXR3UTlqZkkwdnN4Sysv?=
 =?utf-8?B?UWRJcVpUQWp4ZnEzVWZKR2Z5d3NTSlpybHpHQzg4SEJVNFJKNE5RSDkwSXM2?=
 =?utf-8?B?WFlkRDQ0aDQrMnhDWDZsS2wzN2xTOEJWMzh6N1k3VTFScGdiSEtEOGRkRnBH?=
 =?utf-8?B?R1VObzh6U0g3QTdHWlJXOUNOVlBxRExWTWdHeURPU3BMeVFJUDBIcTgyWVFP?=
 =?utf-8?B?b251dGtHSndOY25VbC9QQ2N6Q3h3M2dZeGpwSjBNTkFNb2hjbjFXYlFkZ2lp?=
 =?utf-8?B?eUJYbGhvdVgyWGY5MitlUnRDR0hQZnlxNzV1eElQcEVkdUlkK3MzQjNWWnZY?=
 =?utf-8?B?VFMrUk0rVmgzL1RVZW5KS1dkNTZranJZYUV3MWZtL3prR3NxRmNzcC8yY3U1?=
 =?utf-8?B?Znd5Nm5kcHMzRDQzaWZ5b0pDbVowWkFpb2poeXpMWTkxZk9KT2ZIV291eUxl?=
 =?utf-8?B?MWVEOTErVE5UOEFRRlJvcUdWVGU3VUxRMzRaU2U0cXEzV2FoclNVRmI3aVJy?=
 =?utf-8?B?N1A1NmFxUXVlTGlxNkxJdVZqMmdINkFteHJYV2V4bEVHYitIdXdtRHNtV0I4?=
 =?utf-8?B?c0xMYWtOdTI1b1R4eVd6ZzZoM0NNVlBXNWp0ZFFvTG0vMXVFYlR6Q2s5OWNO?=
 =?utf-8?B?QVlnb01qMk5wNEdtRDgwdDNReXkwZHptUlprcHYzZVdFdm93bWlJc2pUckx4?=
 =?utf-8?B?dzU0aE9zOWwvd3RlOVQ0akN1dFNlQnZvbjYrQkFWY1I4d0llUmNpZ284aUNY?=
 =?utf-8?B?WHpmdnJRRlFvekRLSy80RUQ2UWJxQ0FsK3QwcHFLT2VnL21EM2drRUMyRGgz?=
 =?utf-8?B?eloxdU9JVmR2SUNDMnRvZ2ppRHhUc04zMlpYT0VRbVpwakJwS0xqZzFxR1pn?=
 =?utf-8?B?R2VkR3FiQ0t6UERCaFdsWnlZejA0WERINThQWFpqbUdUbU1JSmVkeUFCWmdZ?=
 =?utf-8?B?WTdLYzJWQU53T0lkRmUwSFZMc2J3aEgzMWdPT3NrT093d1Y0cythZFpTTC9R?=
 =?utf-8?B?bm5GZHo0YVRBeDlNR0R2bEQyTm5YQVZnb1Z4RlhKZ29neUY3Njd3eEtnK3Vu?=
 =?utf-8?B?eXVuekZQVHZneXJZSnMzQTJuQUorMHR5aTNNSHdwWjA3U1lib2hjTHh6aDFa?=
 =?utf-8?B?eWM3Ym1JVXNtYU5pMzl3NWp4MnJBU1VpeG5tSHlVZTFpWXdvUENyZnZuSS9S?=
 =?utf-8?Q?gSQI0YRH6r3t3DF6ffdV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkVJYXlLbW5QZXBoaVlIMFQyRUVGaXBOVTRzUWloUEFxY2NQaGh3UXNDU0Yz?=
 =?utf-8?B?TENhTndSZTlla0NWTlVXSysyM21UemJNdGtiVEZGdUgzVFo2a1ZqQkI2bmtM?=
 =?utf-8?B?Rk5iMWtnbHZSZnZidGdXaU5pWDhIdEROUDZjS0tVbHNFdjBpMzJDNFI3S3Bn?=
 =?utf-8?B?d1RRWXl2ang5NDhPdDU3RjJ1aFhUd0ZrODNrWXc5b3paUHBWUlhzSElwNnFO?=
 =?utf-8?B?K3hCQWhkNTBlZ2pGL1I5ZHk4WGJ1Z1FWei83ZUF3K2ZrNGxsSTF4dWl1U1lF?=
 =?utf-8?B?eGVyeXlIWE1FaktNS1RjbDBVUGlhMWZYMmVRemlPcW1lQ0l2TTY3dDhrYXFp?=
 =?utf-8?B?ZlVhbnJKUlVvRGNkMHJ4UFR1QXhIeExKSVN1aWF3c0k2Y0VHRVN6V0xDZmha?=
 =?utf-8?B?MFpVV0p4eGp4UWVIVUhNWEl1MEFSVGJEb3VPT3hTbTArdURZNDdpZ0lJb3Vu?=
 =?utf-8?B?aS9sbUZ3RVU3YXRkUGtuekdIdEFIOWJkMXZxNmpJSnJqWTNLcG0ySjllUC9U?=
 =?utf-8?B?ZkI0cFNmTkczaWNuL3hZcXpKNkpaUEJMVkwyS2RySDlhZUtsY3o3TGFsWExs?=
 =?utf-8?B?bzlFRnlQUmgzdjVJSUdEZExKOWdrdEkzMFBxclJnYWp4WUN5UmFVMTVjVGQv?=
 =?utf-8?B?RUVDVlRFL1VlY2pUbUdGc0VtYUJOclQrRjQ5NGV5NzlOSXBnbEpxYTRSNytN?=
 =?utf-8?B?WVY2VTljb1Y2T0RFbkJScTBBNk9zUXVJYjFWRlVTeDRxRHltU3JleU5hMncw?=
 =?utf-8?B?N1pqY1lvdE1XV2tYV2RjRUdkZVBOOGNLZm1qV3BuQWQxZ2dDeEY5aXppTVc4?=
 =?utf-8?B?OGpUbHkrNk9HdXJGZHE2VUp2MEJyUHdjejhkbU9LL0FWZEFlTDN3OHFWTWZL?=
 =?utf-8?B?SjRmMmVJeVd0S0JGT2tRYVFPdjNFUUlBUUJuYlBFNzNJak5xckFPS0ZwU1VX?=
 =?utf-8?B?SU9KWDYvT0grSkNsSXVSbC9uSFprb3dXMkxnZEljcGx2TFl6c1Z4cy90Z2N0?=
 =?utf-8?B?NndwbzJYbHl4U2lUbmtDOWNtVzFDSW9WTzNGRWZnZHdzMlBQRitUQWVJQm5o?=
 =?utf-8?B?RDFvaWZFVkIwZE9JSDY3NFpOLy9GWjRiNGIyY3g1Tkl2Z0dTMW9kZDRCVGVK?=
 =?utf-8?B?MStMd3RVUUV5WnFjMEtpQStvWUlyWGZEeTc5bXBITFNaSkw0b2YyM2JFTTJM?=
 =?utf-8?B?RVplY0Z1eVZOYmR1MVg3RG5SSGlNQ3BtejBYaHM5NThQcnRMa1hTVjBFQ0xi?=
 =?utf-8?B?K1BjSjVxNEJYYjlwS1ZMRHBPZk5oZU80UWpZMWxIcm9Sd3VaQmROVkhpakdh?=
 =?utf-8?B?WkttQ0I0dEZJUS9vOGpjS3ZxeEJ0Ry8yY1dCM3l0RE5sSlRxU3A4bXZlTWJX?=
 =?utf-8?B?WnE2NmJZZ0pSQmdJY0xYaTdxOG9rZXdDT3RtUUw2cGtlUzFtV2ptNUlZcUFm?=
 =?utf-8?B?ajhqdVZyMEZOYW9IczBVSTUzVWIxcUpBVXhnanZDRlFWWngyTXN0UFduZXo3?=
 =?utf-8?B?eEFaRTZtS1F4cVNlTG1xV0Y1NnZLSUtBNFlCQk5jVXZjYmtMeVVmcGV6V3dH?=
 =?utf-8?B?QmFkVlRFWkVlc3JPNmJNWWVoTGFrM05QaFJmVUpKQnRlS1BCVDZEYkt4aUhq?=
 =?utf-8?B?K3ludk5hZzM3bGp5QjFuNGpwaXpNTlpmQ0xTa1E4VXlCVW9CZ24xN1BRbVVN?=
 =?utf-8?B?cnhFWnFNWG9TamJhcWVnSU1XQXFyZ3A5SHNtMWhxZGdxNXF6ZWVVRTk3ZmVK?=
 =?utf-8?B?dE9HbzRBdlhtM2wwMkhpNzFrSXlFYklWd3NMam1yOVErTExKL2d1Vkh4YzFT?=
 =?utf-8?Q?TJYPXdr1qDwkW+wwIYZMqdGhhRO+N+LsRxh48=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87be8208-6105-47fb-dc9a-08deac700532
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 19:37:05.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8121
X-Rspamd-Queue-Id: 2C49E4EE1E4
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
	TAGGED_FROM(0.00)[bounces-10702-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,anirudhrb.com:email]
X-Rspamd-Action: no action

RnJvbTogQW5pcnVkaCBSYXlhYmhhcmFtIChNaWNyb3NvZnQpIDxhbmlydWRoQGFuaXJ1ZGhyYi5j
b20+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDYsIDIwMjYgNjo0NSBBTQ0KPiANCj4gVGhlIGh5cGVy
dmlzb3IncyBtYXAgR1BBIGh5cGVyY2FsbCBjb2FsZXNjZXMgY29udGlndW91cyAyTS1hbGlnbmVk
DQo+IGNodW5rcyBpbnRvIDFHIG1hcHBpbmdzIHdoZW4gYWxpZ25tZW50IHBlcm1pdHMsIHNvIHRo
ZSBkcml2ZXIgY2FuDQo+IHN1cHBvcnQgMUcgaHVnZXBhZ2VzIGJ5IGZlZWRpbmcgdGhlbSBpbiBh
cyAyTSBjaHVua3MuIE5vdGUgdGhhdCB0aGlzDQo+IGlzIHRoZSBvbmx5IHdheSB0byBtYWtlIDFH
IG1hcHBpbmdzOyB0aGVyZSBpcyBubyB3YXkgdG8gZGlyZWN0bHkgbWFwDQo+IGEgMUcgaHVnZXBh
Z2UgdXNpbmcgdGhlIGh5cGVyY2FsbC4NCj4gDQo+IFVwZGF0ZSBtc2h2X2NodW5rX3N0cmlkZSgp
IHRvOg0KPiANCj4gICAtIEFjY2VwdCAyTS1hbGlnbmVkIHRhaWwgcGFnZXMgb2YgYSBsYXJnZXIg
Zm9saW8uIFRoZSBwcmV2aW91cw0KPiAgICAgUGFnZUhlYWQoKSBjaGVjayByZWplY3RlZCBldmVy
eSBwYWdlIGFmdGVyIHRoZSBoZWFkIG9mIGEgMUcNCj4gICAgIGh1Z2VwYWdlIGFuZCBmZWxsIGJh
Y2sgdG8gNEsgbWFwcGluZ3MgZm9yIHRoZSByZW1haW5pbmcgMTAyMiBNQi4NCj4gICAgIFJlcGxh
Y2UgaXQgd2l0aCBhIFBGTiBhbGlnbm1lbnQgY2hlY2sgc28gYW55IDJNLWFsaWduZWQgcGFnZSBv
ZiBhDQo+ICAgICBzdWZmaWNpZW50bHkgbGFyZ2UgZm9saW8gaXMgYWNjZXB0YWJsZS4NCj4gDQo+
ICAgLSBBbHdheXMgZW1pdCBhIDJNIChQTURfT1JERVIpIHN0cmlkZSBmb3IgdGhlIGh1Z2UtcGFn
ZSBjYXNlLiBUaGUNCj4gICAgIGh5cGVyY2FsbCBoYXMgbm8gMUcgc3RyaWRlLCBzbyAxRyBmb2xp
b3MgYXJlIHByb2Nlc3NlZCBhcyBhDQo+ICAgICBzZXF1ZW5jZSBvZiAyTSBjaHVua3MuIEZvbGlv
cyB3aG9zZSBvcmRlciBpcyBuZWl0aGVyIFBNRF9PUkRFUiBub3INCj4gICAgIFBVRF9PUkRFUiAo
ZS5nLiBtVEhQKSBmYWxsIGJhY2sgdG8gc2luZ2xlLXBhZ2Ugc3RyaWRlOyBtYXBwaW5nDQo+ICAg
ICB0aGVtIGFzIDJNIHdvdWxkIGZhaWwgaW4gdGhlIGh5cGVydmlzb3IgYW55d2F5Lg0KPiANCj4g
QXNzaXN0ZWQtYnk6IENvcGlsb3QtQ0xJOmNsYXVkZS1vcHVzLTQuNw0KPiBTaWduZWQtb2ZmLWJ5
OiBBbmlydWRoIFJheWFiaGFyYW0gKE1pY3Jvc29mdCkgPGFuaXJ1ZGhAYW5pcnVkaHJiLmNvbT4N
Cj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gRml4ZWQgdmFyaW91cyBjb3JuZXIgY2FzZXMg
cmVwb3J0ZWQgYnkgU2FzaGlrby4NCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjYwNTA1LWh1Z2VfMWctdjItMS1iNmE5MTMyN2E4OGRAYW5pcnVkaHJiLmNvbQ0K
PiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBIYW5kbGVkIHRoZSBjYXNlIHdoZXJlIHdlIGNhbiBo
YXZlIDJNIGFsaWduZWQgcGFnZXMgaW4gdGhlIG1pZGRsZSBvZiBhDQo+ICAgMUcgcGFnZQ0KPiAt
IEJyb3VnaHQgYmFjayB0aGUgcGFnZSBvcmRlciBjaGVjayBidXQgZXhwYW5kZWQgaXQgdG8gaW5j
bHVkZSAxRw0KPiAtIENsYW1wIHN0cmlkZSB0byByZXF1ZXN0ZWQgcGFnZSBjb3VudCBpbiBtc2h2
X3JlZ2lvbl9wcm9jZXNzX2NodW5rDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI2MDQxNi1odWdlXzFnLXYxLTEtZTA2NjczOGNkZGZiQGFuaXJ1ZGhyYi5jb20N
Cj4gLS0tDQo+ICBkcml2ZXJzL2h2L21zaHZfcmVnaW9ucy5jIHwgMzIgKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAx
NyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L21zaHZfcmVnaW9u
cy5jIGIvZHJpdmVycy9odi9tc2h2X3JlZ2lvbnMuYw0KPiBpbmRleCBmZGZmZDRmMDAyZjYuLjE3
NTZiNzMzOTY4YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi9tc2h2X3JlZ2lvbnMuYw0KPiAr
KysgYi9kcml2ZXJzL2h2L21zaHZfcmVnaW9ucy5jDQo+IEBAIC0yOSwyOSArMjksMjggQEANCj4g
ICAqIFVzZXMgaHVnZSBwYWdlIHN0cmlkZSBpZiB0aGUgYmFja2luZyBwYWdlIGlzIGh1Z2UgYW5k
IHRoZSBndWVzdCBtYXBwaW5nDQo+ICAgKiBpcyBwcm9wZXJseSBhbGlnbmVkOyBvdGhlcndpc2Ug
ZmFsbHMgYmFjayB0byBzaW5nbGUgcGFnZSBzdHJpZGUuDQo+ICAgKg0KPiAtICogUmV0dXJuOiBT
dHJpZGUgaW4gcGFnZXMsIG9yIC1FSU5WQUwgaWYgcGFnZSBvcmRlciBpcyB1bnN1cHBvcnRlZC4N
Cj4gKyAqIFJldHVybjogU3RyaWRlIGluIHBhZ2VzLg0KPiAgICovDQo+IC1zdGF0aWMgaW50IG1z
aHZfY2h1bmtfc3RyaWRlKHN0cnVjdCBwYWdlICpwYWdlLA0KPiAtCQkJICAgICB1NjQgZ2ZuLCB1
NjQgcGFnZV9jb3VudCkNCj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgbXNodl9jaHVua19zdHJpZGUo
c3RydWN0IHBhZ2UgKnBhZ2UsIHU2NCBnZm4sDQo+ICsJCQkJICAgICAgdTY0IHBhZ2VfY291bnQp
DQo+ICB7DQo+IC0JdW5zaWduZWQgaW50IHBhZ2Vfb3JkZXI7DQo+ICsJdW5zaWduZWQgaW50IHBh
Z2Vfb3JkZXIgPSBmb2xpb19vcmRlcihwYWdlX2ZvbGlvKHBhZ2UpKTsNCj4gDQo+ICAJLyoNCj4g
IAkgKiBVc2Ugc2luZ2xlIHBhZ2Ugc3RyaWRlIGJ5IGRlZmF1bHQuIEZvciBodWdlIHBhZ2Ugc3Ry
aWRlLCB0aGUNCj4gLQkgKiBwYWdlIG11c3QgYmUgY29tcG91bmQgYW5kIHBvaW50IHRvIHRoZSBo
ZWFkIG9mIHRoZSBjb21wb3VuZA0KPiAtCSAqIHBhZ2UsIGFuZCBib3RoIGdmbiBhbmQgcGFnZV9j
b3VudCBtdXN0IGJlIGh1Z2UtcGFnZSBhbGlnbmVkLg0KPiArCSAqIHBhZ2UgbXVzdCBiZSBjb21w
b3VuZCwgdGhlIHBhZ2UncyBQRk4gbXVzdCBpdHNlbGYgYmUgMk0tYWxpZ25lZA0KPiArCSAqIChz
byB0aGF0IGEgMk0tYWxpZ25lZCB0YWlsIHBhZ2Ugb2YgYSBsYXJnZXIgZm9saW8gaXMgYWNjZXB0
YWJsZSksDQo+ICsJICogYW5kIGJvdGggZ2ZuIGFuZCBwYWdlX2NvdW50IG11c3QgYmUgaHVnZS1w
YWdlIGFsaWduZWQuDQo+ICAJICovDQo+IC0JaWYgKCFQYWdlQ29tcG91bmQocGFnZSkgfHwgIVBh
Z2VIZWFkKHBhZ2UpIHx8DQo+ICsJaWYgKCFQYWdlQ29tcG91bmQocGFnZSkgfHwNCj4gKwkgICAg
IUlTX0FMSUdORUQocGFnZV90b19wZm4ocGFnZSksIFBUUlNfUEVSX1BNRCkgfHwNCj4gIAkgICAg
IUlTX0FMSUdORUQoZ2ZuLCBQVFJTX1BFUl9QTUQpIHx8DQo+IC0JICAgICFJU19BTElHTkVEKHBh
Z2VfY291bnQsIFBUUlNfUEVSX1BNRCkpDQo+ICsJICAgICFJU19BTElHTkVEKHBhZ2VfY291bnQs
IFBUUlNfUEVSX1BNRCkgfHwNCj4gKwkgICAgKHBhZ2Vfb3JkZXIgIT0gUE1EX09SREVSICYmIHBh
Z2Vfb3JkZXIgIT0gUFVEX09SREVSKSkNCj4gIAkJcmV0dXJuIDE7DQoNCklzIHRoZSB0ZXN0IGZv
ciBQYWdlQ29tcG91bmQoKSBub3cgcmVkdW5kYW50PyBTaW5jZSBhbnkNCnBhZ2Vfb3JkZXIgb3Ro
ZXIgdGhhbiBQTURfT1JERVIgb3IgUFVEX09SREVSIG5vdyANCnJldHVybnMgMSAoaW5zdGVhZCBv
ZiBhbiBlcnJvciksIHRoYXQgd291bGQgc2VlbSB0byBjb3ZlciB0aGUgY2FzZQ0Kb2YgYSBzaW5n
bGUgNEtpQiBwYWdlIHdpdGggb3JkZXIgMC4gQnV0IG15IGV4cGVydGlzZSBpbiBmb2xpb3MgYW5k
IA0KY29tcG91bmQgcGFnZXMgaXMgbGltaXRlZCwgc28gbWF5YmUgdGhlcmUncyBzb21lDQpyZWFz
b24gdG8gdXNlIFBhZ2VDb21wb3VuZCgpIHRoYXQgSSBkb24ndCBrbm93IGFib3V0Lg0KDQpNaWNo
YWVsDQoNCj4gDQo+IC0JcGFnZV9vcmRlciA9IGZvbGlvX29yZGVyKHBhZ2VfZm9saW8ocGFnZSkp
Ow0KPiAtCS8qIFRoZSBoeXBlcnZpc29yIG9ubHkgc3VwcG9ydHMgMk0gaHVnZSBwYWdlICovDQo+
IC0JaWYgKHBhZ2Vfb3JkZXIgIT0gUE1EX09SREVSKQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4g
LQ0KPiAtCXJldHVybiAxIDw8IHBhZ2Vfb3JkZXI7DQo+ICsJLyogVXNlIDJNIHN0cmlkZSBhbHdh
eXMgaS5lLiBwcm9jZXNzIDFHIGZvbGlvcyBhcyAyTSBjaHVua3MgKi8NCj4gKwlyZXR1cm4gMSA8
PCBQTURfT1JERVI7DQo+ICB9DQo+IA0KPiAgLyoqDQo+IEBAIC04NiwxNSArODUsMTQgQEAgc3Rh
dGljIGxvbmcgbXNodl9yZWdpb25fcHJvY2Vzc19jaHVuayhzdHJ1Y3QgbXNodl9tZW1fcmVnaW9u
DQo+ICpyZWdpb24sDQo+ICAJdTY0IGdmbiA9IHJlZ2lvbi0+c3RhcnRfZ2ZuICsgcGFnZV9vZmZz
ZXQ7DQo+ICAJdTY0IGNvdW50Ow0KPiAgCXN0cnVjdCBwYWdlICpwYWdlOw0KPiAtCWludCBzdHJp
ZGUsIHJldDsNCj4gKwl1bnNpZ25lZCBpbnQgc3RyaWRlOw0KPiArCWludCByZXQ7DQo+IA0KPiAg
CXBhZ2UgPSByZWdpb24tPm1yZWdfcGFnZXNbcGFnZV9vZmZzZXRdOw0KPiAgCWlmICghcGFnZSkN
Cj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAgCXN0cmlkZSA9IG1zaHZfY2h1bmtfc3RyaWRl
KHBhZ2UsIGdmbiwgcGFnZV9jb3VudCk7DQo+IC0JaWYgKHN0cmlkZSA8IDApDQo+IC0JCXJldHVy
biBzdHJpZGU7DQo+IA0KPiAgCS8qIFN0YXJ0IGF0IHN0cmlkZSBzaW5jZSB0aGUgZmlyc3Qgc3Ry
aWRlIGlzIHZhbGlkYXRlZCAqLw0KPiAgCWZvciAoY291bnQgPSBzdHJpZGU7IGNvdW50IDwgcGFn
ZV9jb3VudDsgY291bnQgKz0gc3RyaWRlKSB7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGNk
OWYyZTdkNmU1YjE4MzdlZjQwYjk2ZTMwMGZhMjhiNzNhYjVhNzcNCj4gY2hhbmdlLWlkOiAyMDI2
MDQxNi1odWdlXzFnLWU0NDQ2MTM5M2M4Zg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBB
bmlydWRoIFJheWFiaGFyYW0gKE1pY3Jvc29mdCkgPGFuaXJ1ZGhAYW5pcnVkaHJiLmNvbT4NCj4g
DQoNCg==

