Return-Path: <linux-hyperv+bounces-9498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IyNMLiVuWlcKwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9498-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:56:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F32B05E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7E33129F19
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8463176FD;
	Tue, 17 Mar 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qb28pCDo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011035.outbound.protection.outlook.com [52.103.12.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AA2DECC6;
	Tue, 17 Mar 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768325; cv=fail; b=bEu/ogxEthunqJfCLizXQuljc4TE+0+Jydcbbg7A8d1fZnKvq3NVqTBPFyBzc4+buwvTxuCq1Z8bdQh2rMvr4mp9rLxVQ9CAzz6mH/Ar7aEuSqlUUSqyhvRjcRcbxYb4OKEZNThN+k8uRXBvkkyyk8MchNLg4vdSRwrRmYKPE6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768325; c=relaxed/simple;
	bh=dNwqunabSR2HSMYG5teHeBhIp8pPHoCeQMe1c48thrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2lXAC8WBE0vYGdne/mmBnDuZZBeMdNQ+/Grry764z4dqPNc/lG3LAvwvrJ2AE6jdUQyj2fA91QjwFGuH7r8vboyhFca3A9jM0pywU+vr+1D990gXR1x7MfJqrUYag136/Gt/9lYRyRdSdrX1+mFi1qZieYqkNoUiubbh4WLsWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qb28pCDo; arc=fail smtp.client-ip=52.103.12.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE2GTtaRlrZWlTr9UTQQVYM2DAzQ+4NJnv8+qNUmV2shr+Ifthmrjm/Q4VlKCmpRfXOGorhGaIF9ApyA3YxwT+BbilZ/KZa+exg1FKfnmOWrcPwVaehJp9rvF5uLP055t6+cIyBf0oEb4E06b2lVF7f69Tar9H7P4MIXt4DwN2uLri7OzueQLMJufQ9ZsP+fimImt5OzLypjcFFnctxppmMD9H8xYgPv+PbRuSZX0rbCVgP0vgnMLRWQjfXig6PmN9U4/dA3wOwI0PgiXYvVCzWNffer7yK66MlkadIgzqs4wV1mSd5ufTKDReRPLIzdNq32lSgORW3vPjXH1VXseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNwqunabSR2HSMYG5teHeBhIp8pPHoCeQMe1c48thrw=;
 b=QQYEywpSBq+0/3Cq4sweLMsUZYWWyngOau8QnL/OwuBdFe/e05pmXXR8G/U/+j6cGXef26j9JmSoW1jJnx2Ol4KzMwQrrsb4Ier3q/oLvI3gm4QDHNCw1WYjW8vzYuuw2wnZp4WgU+WBq7zHS3vfLBBE/LeqdFjuGoF4cQ2zDtNkxhSbW972oEZs4ht9xWeW3gmXu9/1gmObA1Nq11D1a4TkwRKoEXJNMiiqsi/a/AAGgrhvaJfbQIkM4nnAtn9DsZDKry+PkT7n6yqnd3nEVIZYulQK/DDs76vA5C76yAiVhxKGI128y+mH4LdWe6TjpPC1kwKIWri+lQN1noHG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNwqunabSR2HSMYG5teHeBhIp8pPHoCeQMe1c48thrw=;
 b=qb28pCDoipYa1AWaHcBKhJuqQvahp5W55oM6FxAFpGZn3QRcSykf6cxAHJpDu5lwyFVHbYr8pO/WCEr/nb3shbt62s6Srdh8gr7rRGKEczSiHxS8aYXz9hVy93CNN1qPZcUUsq+dBfv/D7aLtK6ZuOrBx3O+yuLd8k2QOR2u5OPaQR02u5PGi26pAdhm6v5upc0DteDGGCgPCaWtgF7zGAgCZZ1fhCD8M2UCDU3A1LNhvMsMb3u2JN1bbRuPPzyPLk17y7tEv7hoJpVMUVtSO3QrPOtohnZ+QDL6FBm+ZYYGdn1JXPOmPidkVX0xqhHoAbGVEuJcAtjlB49nQ197Xw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8076.namprd02.prod.outlook.com (2603:10b6:610:109::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 17:25:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 17:25:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jan Kiszka
	<jan.kiszka@siemens.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, RT <linux-rt-users@vger.kernel.org>, Mitchell
 Levy <levymitchell0@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Naman Jain
	<namjain@linux.microsoft.com>
Subject: RE: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Thread-Topic: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Thread-Index: AQIAms3Sl3Iu/SbQhdgR6pEC9I2+4LVjT72AgAfgs4A=
Date: Tue, 17 Mar 2026 17:25:20 +0000
Message-ID:
 <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
In-Reply-To: <20260312170715.HA08BHiO@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8076:EE_
x-ms-office365-filtering-correlation-id: a392b30c-8b35-4160-742d-08de844a2a9e
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|13091999003|51005399006|37011999003|41001999006|461199028|8060799015|8062599012|19110799012|15080799012|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejBFUmVWR3k3cHZ2YnBJM1lKcUU2eXVaaHRWT093ak0rN1hvdXRKUnNDMEgr?=
 =?utf-8?B?djNzcjFsYXMwcXA2ZkU3R1BQaW5iMnFZa0RRN3lwdzk2bkMxS3NCSjhqSStG?=
 =?utf-8?B?TWpTSzdONDQ4RDFvdE5iT1lHM0NCbVVrYVhNWUVLZkd1c1lVMW1mTGh3M0kr?=
 =?utf-8?B?L29OMHFLS0JLS3hSVHI5UVpvRXd3ci9zcFI4Q21uMzE1S1NTNkZqWHpNN2Fm?=
 =?utf-8?B?S2tTMFR0VXBydjc4Z3dka1JzaFFkOU14czlpSkh3M2o3QzVqWm1ZUmpmY0dP?=
 =?utf-8?B?RWVsalFmTDhTeHNNRVJLNGdPaC9MQngvaC9XRHlBZ0JXcUpkNnJXb0haMlND?=
 =?utf-8?B?YVQ4aTl3ekRNRTdsZXNDb2ZTNS9nenVtYnpMRjhyTGhUTU5wc21RV1djRldD?=
 =?utf-8?B?SEJEVExBcCtLWFRQUXowWW90S2FpSzY4MjU1S2xDMDh0Qnh6MVk5RU9YUSta?=
 =?utf-8?B?d2REOERCMDJtcDU1RlMyeWRxeTdoR0krY1pwdW1LWXR3azRGenhZRjYySVJZ?=
 =?utf-8?B?VFVyOGJJdUpWaFNqK2hmcTJBR2UzN2RjR0UrZGlFYjhwQzkrNTFpTEZHR1Nk?=
 =?utf-8?B?MFQrL1ZBQ2NwUkQxbGU5SndiSjBCTHViUERKYTRUdlljZWdLa1VrOTBTajlQ?=
 =?utf-8?B?RUF6cnh6Q1VudGxrL2ljNHRwemQvTnNUZFNuMzBKbGdpN1VXbGswTUNNSG9E?=
 =?utf-8?B?dHRlRElYMVA2MWQ0MGtWWVFpRUtSa0hWSHd3ajg1UE5PczVxQnBWQWIxODVE?=
 =?utf-8?B?Q0VWVXBkWmdSdVBLZ29ndVNqUkxhVFFHMTU3bFpTYUxTYThRcldlZG5peXow?=
 =?utf-8?B?L01KUVg4UUpzUVI4YWFUNjFHTkw4cEVoL01uTW04T1lYMmsySEs5dlc2YVFx?=
 =?utf-8?B?dURLVGk5bGJKVlhtenkzS09DLytQMzdxQm5JV040cEhpcU56NlVLMUpSMi8v?=
 =?utf-8?B?RFN5bDJlWmcrNk4xREhRVEFjYnlseS9sNm8wc080czlpUzNoYTZBV1YvbFZ1?=
 =?utf-8?B?ajhUSTA1MFI3SDdybUs0MzByNVZqNkVxVG55TS9Rd050a2E4czYxSGJHZXN6?=
 =?utf-8?B?QUY2VHAvNXJ3d0FGd0FnR2paNFZwMzRMaWFvOFk0ZTlyNTdlclk1QkRGd1o0?=
 =?utf-8?B?d2hhM3lIMDNObSsxY0pnaU1JV0NUQzJtNGZTQUxGKzZyME5wbXI3aEx4cFRh?=
 =?utf-8?B?VFNONEttdVNWcTIzUHo5NDV5WXM3NHVvVDQzQnlyTjdyNDJaTTljQUluWlpM?=
 =?utf-8?B?aTFkdGdHSTJKNU42VS81UTdQWlp6UXp6S0ZLNmVUY3kvRG8yOGl2SHRtNFZV?=
 =?utf-8?B?b2EyWnhoVlZrUXM5dm4wa0lvcDMyYU95bW5HeTRIbHVBd2hoZlZPNkIyQWxv?=
 =?utf-8?Q?40M+Gs5efHwv14KvFIkUeKfjBxBW5dac=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjRseC93UXJCQUJ0WHZUK3kvUkZXUzhTcjExZU1KVS94VTBOdVowOFRTK2ZO?=
 =?utf-8?B?bW1SSGRwN2c4RWFYaDU4TWN6RkxXWE4rTVNJZjdXNGRlVUZod2dwOGR0UmV0?=
 =?utf-8?B?QVp5RkhJUy9XREZJaHViK2t1dlJYNWxNdDg3NzVrMVFyKzJFbG9LcjR6ZVVD?=
 =?utf-8?B?K0NULzNaV0xOSUROakdYNzJoS3JwRkVSc2x4b3dPdGkvTWlaM0xhOXVjcG9z?=
 =?utf-8?B?RFh2T0pFMFl1V0phU2p4UmNEYVVlbmxla2JiVWxTRmlGVnZmN0tZdThLQ1Vw?=
 =?utf-8?B?N1hUdjhGL3M4RkZJRTFKUUMrUkNORFdGRXBJN1cwc0Z6OVpGakppVWRSZlFy?=
 =?utf-8?B?RUZDejBUVXoyb21zYjZLVVVpYnRKR0V5TkVaekZvVW9HS3hZQ1hFZytEZFVB?=
 =?utf-8?B?ZExzekl3ajZTT3BiVEtxVXRiVk54RUZycWJQSkNXSDU3aHBPazFlY1Jua3lv?=
 =?utf-8?B?eWtMOFFueXVXUGxiRm1YSDRMTDlLYmt2NjRjak1oMUl5czM3Y2dzVnFlZlhz?=
 =?utf-8?B?aWZ4a2EzaS85Z1g4VXU4MGlKenF0TkFZb1R0NjRoVE41Q3UrRnFJNUdjVnBG?=
 =?utf-8?B?RUI1aEhmNVdocE5uVHZTUVZnQnhzcHU0U0RxSXRsS2ozcEdiWVVDTkhVS01h?=
 =?utf-8?B?UUc2clFPNE5kSy9wTXlZdzNSMWNkc2JiTkZyWnRnQndTYUdBOWpJNEZvdjky?=
 =?utf-8?B?L1NCbEw5U3F6b1FFT09FU1ZkWmdtTHgzYW8zcXN6Mmpmc0NRcjVzUmNpNHlw?=
 =?utf-8?B?N0RuNVJkUERTREpmbmFwTFZlemZ3YlRzY0tMV1h5WU1VdVhXSFZrbStqQWsr?=
 =?utf-8?B?aFJGcFE0WDZBVXhZNVh4QkNNdXpQTVIvZWZqY04zWk5ZcGIremlZajlhc1d3?=
 =?utf-8?B?TFNEMDljZTR1c2JlUkJXbXNaL1Bmd0RmSUZtRzVSY0lvWGl2WW9oK0djK1Nl?=
 =?utf-8?B?TWRHSzJ4S2FjUGNYbjByWnZiaWVYeVJyTkNsVWpqZ21yODhQbEJxOXFFTEtl?=
 =?utf-8?B?ZWV1TXVFakNVcm0reVNBcUpqcDVqQ2FkN1ZSN0g3YVVUTkd1VVRleFh2Zmpk?=
 =?utf-8?B?Q1ozN1gwWGp1WFpiTEtFVDg0MTcwUUZ3Y3d0KzhkMXJyRG9xRkh6ZnVnTE1i?=
 =?utf-8?B?V3Zka3NDU1FQY0txcnBUaCtaK2V0Nk1TdDdWcS9FdG9ZNlVWU0VrTE1LQXpj?=
 =?utf-8?B?ek9NT1lOR1hzNkRnOFpoL2VjbW5vWnZ3cTg5a3NydjI3YVFBenIzZ2JIZEdY?=
 =?utf-8?B?cEhmalR1MnhoTUMvNnB0OWc2UklZbStjUFBKWmoxengyajdqOHJ4bVJEaUd1?=
 =?utf-8?B?WE4rczFnOGh0VmpQTlcvYlA0SlJuSjZDQzJLV3NCakRpQlRZRXlsRTExSmcy?=
 =?utf-8?B?eEIxeE5taXVudUMrdzNKWEZCemZCaEFEdHp3d3d2U0Y4dmw2ZURXRXJXOFJ4?=
 =?utf-8?B?blA1UmRpV2hPd05ha1M3RTl6d21qUFZEaXZWb1ZaY2RnZVNUMlhhekg4dStY?=
 =?utf-8?B?QnJaZHYrL3NMbG5URFNKbmg3QkhLanJiU3VYc0J2K01URkxzbFVSMjd1dU1K?=
 =?utf-8?B?NmUzeU1HZ2UvckNEcWZxUHphdENQbE5yRmJ1Wi91cTZuam9tSkRjLy8wd0g1?=
 =?utf-8?B?Y2psRnl2d1NiZVR2WU1VOEZLcG9zQkdaOURvN3NKWitMekhWNUhVRGR0MzZw?=
 =?utf-8?B?UENxM05ZQmZMa0sycFpESFRFM0lsei9mN3dlbS9DYkR4Q3ZLZHVqN3JvTS9F?=
 =?utf-8?B?T0RUMGZ2WTZmRDIzUm1sV3Bua0Q1ODViRnRJWmxsS2ZRY1lOdzQzUTBRTkxp?=
 =?utf-8?Q?CTPu3UGH0+yR5bC5cJh1yNc8pMLYZhMXAHyB4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a392b30c-8b35-4160-742d-08de844a2a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:25:21.0419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8076
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-9498-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 328F32B05E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggMTIsIDIwMjYgMTA6MDcgQU0NCj4NCg0KTGV0IG1lIHRyeSB0
byBhZGRyZXNzIHRoZSByYW5nZSBvZiBxdWVzdGlvbnMgaGVyZSBhbmQgaW4gdGhlIGZvbGxvdy11
cA0KZGlzY3Vzc2lvbi4gQXMgYmFja2dyb3VuZCwgYW4gb3ZlcnZpZXcgb2YgVk1CdXMgaW50ZXJy
dXB0IGhhbmRsaW5nIGlzIGluOg0KDQpEb2N1bWVudGF0aW9uL3ZpcnQvaHlwZXJ2L3ZtYnVzLnJz
dA0KDQppbiB0aGUgc2VjdGlvbiBlbnRpdGxlZCAiU3ludGhldGljIEludGVycnVwdCBDb250cm9s
bGVyIChzeW5pYykiLiBUaGUNCnJlbGV2YW50IHRleHQgaXM6DQoNCiAgIFRoZSBTSU5UIGlzIG1h
cHBlZCB0byBhIHNpbmdsZSBwZXItQ1BVIGFyY2hpdGVjdHVyYWwgaW50ZXJydXB0IChpLmUsDQog
ICBhbiA4LWJpdCB4ODYveDY0IGludGVycnVwdCB2ZWN0b3IsIG9yIGFuIGFybTY0IFBQSSBJTlRJ
RCkuIEJlY2F1c2UNCiAgIGVhY2ggQ1BVIGluIHRoZSBndWVzdCBoYXMgYSBzeW5pYyBhbmQgbWF5
IHJlY2VpdmUgVk1CdXMgaW50ZXJydXB0cywNCiAgIHRoZXkgYXJlIGJlc3QgbW9kZWxlZCBpbiBM
aW51eCBhcyBwZXItQ1BVIGludGVycnVwdHMuIFRoaXMgbW9kZWwgd29ya3MNCiAgIHdlbGwgb24g
YXJtNjQgd2hlcmUgYSBzaW5nbGUgcGVyLUNQVSBMaW51eCBJUlEgaXMgYWxsb2NhdGVkIGZvcg0K
ICAgVk1CVVNfTUVTU0FHRV9TSU5ULiBUaGlzIElSUSBhcHBlYXJzIGluIC9wcm9jL2ludGVycnVw
dHMgYXMgYW4gSVJRIGxhYmVsbGVkDQogICAiSHlwZXItViBWTWJ1cyIuIFNpbmNlIHg4Ni94NjQg
bGFja3Mgc3VwcG9ydCBmb3IgcGVyLUNQVSBJUlFzLCBhbiB4ODYNCiAgIGludGVycnVwdCB2ZWN0
b3IgaXMgc3RhdGljYWxseSBhbGxvY2F0ZWQgKEhZUEVSVklTT1JfQ0FMTEJBQ0tfVkVDVE9SKQ0K
ICAgYWNyb3NzIGFsbCBDUFVzIGFuZCBleHBsaWNpdGx5IGNvZGVkIHRvIGNhbGwgdm1idXNfaXNy
KCkuIEluIHRoaXMgY2FzZSwNCiAgIHRoZXJlJ3Mgbm8gTGludXggSVJRLCBhbmQgdGhlIGludGVy
cnVwdHMgYXJlIHZpc2libGUgaW4gYWdncmVnYXRlIGluDQogICAvcHJvYy9pbnRlcnJ1cHRzIG9u
IHRoZSAiSFlQIiBsaW5lLg0KDQpUaGUgdXNlIG9mIGEgc3RhdGljYWxseSBhbGxvY2F0ZWQgc3lz
dmVjIHByZS1kYXRlcyBteSBpbnZvbHZlbWVudCBpbiB0aGlzDQpjb2RlIHN0YXJ0aW5nIGluIDIw
MTcsIGJ1dCBJIGJlbGlldmUgaXQgd2FzIG1vZGVsbGVkIGFmdGVyIHdoYXQgWGVuIGRvZXMsDQph
bmQgZm9yIHRoZSBzYW1lIHJlYXNvbiAtLSB0byBlZmZlY3RpdmVseSBjcmVhdGUgYSBwZXItQ1BV
IGludGVycnVwdCBvbg0KeDg2L3g2NC4gQWNvcm4gaXMgYWxzbyB1c2luZyBIWVBFUlZJU09SX0NB
TExCQUNLX1ZFQ1RPUiwgYnV0IEkNCmRvbid0IGtub3cgaWYgdGhhdCBpcyBhbHNvIHRvIGNyZWF0
ZSBhIHBlci1DUFUgaW50ZXJydXB0Lg0KDQpNb3JlIGJlbG93IC4uLi4NCg0KPiBPbiAyMDI2LTAy
LTE2IDE3OjI0OjU2IFsrMDEwMF0sIEphbiBLaXN6a2Egd3JvdGU6DQo+ID4gLS0tIGEvZHJpdmVy
cy9odi92bWJ1c19kcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gPiBA
QCAtMjUsNiArMjUsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvY3B1Lmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9zY2hlZC9pc29sYXRpb24uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVk
L3Rhc2tfc3RhY2suaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NtcGJvb3QuaD4NCj4gPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BhbmljX25v
dGlmaWVyLmg+DQo+ID4gQEAgLTEzNTAsNyArMTM1MSw3IEBAIHN0YXRpYyB2b2lkIHZtYnVzX21l
c3NhZ2Vfc2NoZWQoc3RydWN0IGh2X3Blcl9jcHVfY29udGV4dCAqaHZfY3B1LCB2b2lkICptZXNz
YWdlDQo+ID4gIAl9DQo+ID4gIH0NCj4gPg0KPiA+IC12b2lkIHZtYnVzX2lzcih2b2lkKQ0KPiA+
ICtzdGF0aWMgdm9pZCBfX3ZtYnVzX2lzcih2b2lkKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgaHZf
cGVyX2NwdV9jb250ZXh0ICpodl9jcHUNCj4gPiAgCQk9IHRoaXNfY3B1X3B0cihodl9jb250ZXh0
LmNwdV9jb250ZXh0KTsNCj4gPiBAQCAtMTM2Myw2ICsxMzY0LDUzIEBAIHZvaWQgdm1idXNfaXNy
KHZvaWQpDQo+ID4NCj4gPiAgCWFkZF9pbnRlcnJ1cHRfcmFuZG9tbmVzcyh2bWJ1c19pbnRlcnJ1
cHQpOw0KPiANCj4gVGhpcyBpcyBmZWVkaW5nIGVudHJvcHkgYW5kIHdvdWxkIGxpa2UgdG8gc2Vl
IGludGVycnVwdCByZWdpc3RlcnMuIEJ1dA0KPiBzaW5jZSB0aGlzIGlzIGludm9rZWQgZnJvbSBh
IHRocmVhZCBpdCB3b24ndC4NCg0KSSdsbCByZXNwb25kIHRvIHRoaXMgdG9waWMgb24gdGhlIG5l
dyB0aHJlYWQgZm9yIHRoZSBuZXcgcGF0Y2gNCndoZXJlIEphbiBoYXMgbW92ZWQgdGhlIGNhbGwg
dG8gYWRkX2ludGVycnVwdF9yYW5kb21uZXNzKCkuDQoNCj4gDQo+ID4gIH0NCj4gPiArDQo+IOKA
pg0KPiA+ICt2b2lkIHZtYnVzX2lzcih2b2lkKQ0KPiA+ICt7DQo+ID4gKwlpZiAoSVNfRU5BQkxF
RChDT05GSUdfUFJFRU1QVF9SVCkpIHsNCj4gPiArCQl2bWJ1c19pcnFkX3dha2UoKTsNCj4gPiAr
CX0gZWxzZSB7DQo+ID4gKwkJbG9ja2RlcF9oYXJkaXJxX3RocmVhZGVkKCk7DQo+IA0KPiBXaGF0
IGNsZWFycyB0aGlzPyBUaGlzIGlzIHdyb25nbHkgcGxhY2VkLiBUaGlzIHNob3VsZCBnbyB0bw0K
PiBzeXN2ZWNfaHlwZXJ2X2NhbGxiYWNrKCkgaW5zdGVhZCB3aXRoIGl0cyBtYXRjaGluZyBjYW5j
ZWxpbmcgcGFydC4gVGhlDQo+IGFkZF9pbnRlcnJ1cHRfcmFuZG9tbmVzcygpIHNob3VsZCBhbHNv
IGJlIHRoZXJlIGFuZCBub3QgaGVyZS4NCj4gc3lzdmVjX2h5cGVydl9zdGltZXIwKCkgbWFuYWdl
ZCB0byBkbyBzby4NCg0KSSBkb24ndCBoYXZlIGFueSBrbm93bGVkZ2UgdG8gYnJpbmcgcmVnYXJk
aW5nIHRoZSB1c2Ugb2YNCmxvY2tkZXBfaGFyZGlycV90aHJlYWRlZCgpLg0KDQo+IA0KPiBEaWZm
ZXJlbnQgcXVlc3Rpb246IFdoYXQgZ3VhcmFudGVlcyB0aGF0IHRoZXJlIHdvbid0IGJlIGFub3Ro
ZXINCj4gaW50ZXJydXB0IGJlZm9yZSB0aGlzIG9uZSBpcyBkb25lPyBUaGUgaGFuZHNoYWtlIGFw
cGVhcnMgdG8gYmUNCj4gZGVwcmVjYXRlZC4gVGhlIGludGVycnVwdCBpdHNlbGYgcmV0dXJucyBB
Q0tpbmcgKG9yIG5vdCkgYnV0IHRoZSBhY3R1YWwNCj4gaGFuZGxlciBpcyBkZWxheWVkIHRvIHRo
aXMgdGhyZWFkLiBEZXBlbmRpbmcgb24gdGhlIHVzZXJsYW5kIGl0IGNvdWxkDQo+IHRha2Ugc29t
ZSB0aW1lIGFuZCBJIGRvbid0IGtub3cgaG93IGltcGF0aWVudCB0aGUgaG9zdCBpcy4NCg0KSW4g
bW9yZSByZWNlbnQgdmVyc2lvbnMgb2YgSHlwZXItViwgd2hhdCdzIGRlcHJlY2F0ZWQgaXMgSHlw
ZXItViBpbXBsaWNpdGx5DQphbmQgYXV0b21hdGljYWxseSBkb2luZyB0aGUgRU9JLiBTbyBpbiBz
eXN2ZWNfaHlwZXJ2X2NhbGxiYWNrKCksIGFwaWNfZW9pKCkNCmlzIHVzdWFsbHkgZXhwbGljaXRs
eSBjYWxsZWQgdG8gYWNrIHRoZSBpbnRlcnJ1cHQuDQoNClRoZXJlJ3Mgbm8gZ3VhcmFudGVlLCBp
biBlaXRoZXIgdGhlIGV4aXN0aW5nIGNhc2Ugb3IgdGhlIG5ldyBQUkVFTVBUX1JUDQpjYXNlLCB0
aGF0IGFub3RoZXIgVk1CdXMgaW50ZXJydXB0IHdvbid0IGNvbWUgaW4gb24gdGhlIHNhbWUgQ1BV
DQpiZWZvcmUgdGhlIHRhc2tsZXRzIHNjaGVkdWxlZCBieSB2bWJ1c19tZXNzYWdlX3NjaGVkKCkg
b3INCnZtYnVzX2NoYW5fc2NoZWQoKSBoYXZlIHJ1bi4gRnJvbSBhIGZ1bmN0aW9uYWwgc3RhbmRw
b2ludCwgdGhlIExpbnV4DQpjb2RlIGFuZCBpbnRlcmFjdGlvbiB3aXRoIEh5cGVyLVYgaGFuZGxl
cyBhbm90aGVyIGludGVycnVwdCBjb3JyZWN0bHkuDQoNCkZyb20gYSBkZWxheSBzdGFuZHBvaW50
LCB0aGVyZSdzIG5vdCBhIHByb2JsZW0gZm9yIHRoZSBub3JtYWwgKGkuZS4sIG5vdA0KUFJFRU1Q
VF9SVCkgY2FzZSBiZWNhdXNlIHRoZSB0YXNrbGV0cyBydW4gYXMgdGhlIGludGVycnVwdCBleGl0
cyAtLSB0aGV5DQpkb24ndCBlbmQgdXAgaW4ga3NvZnRpcnFkLiBGb3IgdGhlIFBSRUVNUFRfUlQg
Y2FzZSwgSSBjYW4gc2VlIHlvdXIgcG9pbnQNCmFib3V0IGRlbGF5cyBzaW5jZSB0aGUgdGFza2xl
dHMgYXJlIHNjaGVkdWxlZCBmcm9tIHRoZSBuZXcgcGVyLUNQVSB0aHJlYWQuDQpCdXQgbXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IEphbidzIG1vdGl2YXRpb24gZm9yIHRoZXNlIGNoYW5nZXMgaXMg
bm90IHRvDQphY2hpZXZlIHRydWUgUlQgYmVoYXZpb3IsIHNpbmNlIEh5cGVyLVYgZG9lc24ndCBw
cm92aWRlIHRoYXQgYW55d2F5Lg0KVGhlIGdvYWwgaXMgc2ltcGx5IHRvIG1ha2UgUFJFRU1QVF9S
VCBidWlsZHMgZnVuY3Rpb25hbCwgdGhvdWdoIEphbiBtYXkNCmhhdmUgZnVydGhlciBjb21tZW50
cyBvbiB0aGUgZ29hbC4NCg0KPiANCj4gPiArCQlfX3ZtYnVzX2lzcigpOw0KPiBNb3Zpbmcgb24u
IFRoaXMgKHRyeWluZyB2ZXJ5IGhhcmQgaGVyZSkgZXZlbiBzY2hlZHVsZXMgdGFza2xldHMuIFdo
eT8NCj4gWW91IG5lZWQgdG8gZGlzYWJsZSBCSCBiZWZvcmUgZG9pbmcgc28uIE90aGVyd2lzZSBp
dCBlbmRzIGluIGtzb2Z0aXJxZC4NCj4gWW91IGRvbid0IHdhbnQgdGhhdC4NCg0KQWdhaW4sIEph
biBjYW4gY29tbWVudCBvbiB0aGUgaW1wYWN0IG9mIGRlbGF5cyBkdWUgdG8gZW5kaW5nIHVwDQpp
biBrc29mdGlycWQuDQoNCj4gDQo+IENvdWxkbid0IHRoZSB3aG9sZSBsb2dpYyBiZSBpbnRlZ3Jh
dGVkIGludG8gdGhlIElSUSBjb2RlPyBUaGVuIHdlIGNvdWxkDQo+IGhhdmUgbWFzay8gdW5tYXNr
IGlmIHN1cHBvcnRlZC8gcHJvdmlkZWQgYW5kIHRocmVhZGVkIGludGVycnVwdHMuIFRoZW4NCj4g
c3lzdmVjX2h5cGVydl9yZWVubGlnaHRlbm1lbnQoKSBjb3VsZCB1c2UgYSBwcm9wZXIgdGhyZWFk
ZWQgaW50ZXJydXB0DQo+IGluc3RlYWQgYXBpY19lb2koKSArIHNjaGVkdWxlX2RlbGF5ZWRfd29y
aygpLg0KDQpBcyBJIGRlc2NyaWJlZCBhYm92ZSwgSHlwZXItViBuZWVkcyBhIHBlci1DUFUgaW50
ZXJydXB0LiBJdCdzIGZha2VkIHVwDQpvbiB4ODYveDY0IHdpdGggdGhlIGhhcmRjb2RlZCBIWVBF
UlZJU09SX0NBTExCQUNLX1ZFQ1RPUiBzeXN2ZWMNCmVudHJ5LCBidXQgb24gYXJtNjQgYSBub3Jt
YWwgTGludXggcGVyLUNQVSBJUlEgaXMgdXNlZC4gT25jZSB0aGUgZXhlY3V0aW9uDQpwYXRoIGdl
dHMgdG8gdm1idXNfaXNyKCksIHRoZSB0d28gYXJjaGl0ZWN0dXJlcyBzaGFyZSB0aGUgc2FtZSBj
b2RlLiBTYW1lDQp0aGluZyBpcyBkb25lIHdpdGggdGhlIEh5cGVyLVYgU1RJTUVSMCBpbnRlcnJ1
cHQgYXMgYSBwZXItQ1BVIGludGVycnVwdC4NCklmIHRoZXJlJ3MgYSBiZXR0ZXIgd2F5IHRvIGZh
a2UgdXAgYSBwZXItQ1BVIGludGVycnVwdCBvbiB4ODYveDY0LCBJJ20gb3Blbg0KdG8gbG9va2lu
ZyBhdCBpdC4NCg0KQXMgSSByZWNlbnRseSBkaXNjb3ZlcmVkIGluIGRpc2N1c3Npb24gd2l0aCBK
YW4sIHN0YW5kYXJkIExpbnV4IElSUSBoYW5kbGluZw0Kd2lsbCAqbm90KiB0aHJlYWQgcGVyLUNQ
VSBpbnRlcnJ1cHRzLiBTbyBldmVuIG9uIGFybTY0IHdpdGggYSBzdGFuZGFyZA0KTGludXggcGVy
LUNQVSBJUlEgaXMgdXNlZCBmb3IgVk1CdXMgYW5kIFNUSU1FUjAgaW50ZXJydXB0cywgd2UgY2Fu
J3QNCnJlcXVlc3QgdGhyZWFkaW5nLg0KDQpJIG5lZWQgdG8gcmVmcmVzaCBteSBtZW1vcnkgb24g
c3lzdmVjX2h5cGVydl9yZWVubGlnaHRlbm1lbnQoKS4gSWYNCkkgcmVjYWxsIGNvcnJlY3RseSwg
aXQncyBub3QgYSBwZXItQ1BVIGludGVycnVwdCwgc28gaXQgcHJvYmFibHkgZG9lc24ndA0KbmVl
ZCB0byBoYXZlIGEgaGFyZGNvZGVkIHZlY3Rvci4gT3ZlcmFsbCwgdGhlIEh5cGVyLVYgcmVlbmxp
Z2h0ZW5tZW50DQpmdW5jdGlvbmFsaXR5IGlzIGEgYml0IG9mIGEgZm9zc2lsIHRoYXQgaXNuJ3Qg
bmVlZGVkIG9uIG1vZGVybiB4ODYveDY0DQpwcm9jZXNzb3JzIHRoYXQgc3VwcG9ydCBUU0Mgc2Nh
bGluZy4gQW5kIGl0IGRvZXNuJ3QgZXhpc3QgZm9yIGFybTY0Lg0KSXQgbWlnaHQgYmUgd29ydGgg
c2VlaW5nIGlmIGl0IGNvdWxkIGJlIGRyb3BwZWQgZW50aXJlbHkgLi4uDQoNCk1pY2hhZWwNCg0K
PiANCj4gPiArCX0NCj4gPiArfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0ZPUl9NT0RVTEVTKHZtYnVz
X2lzciwgIm1zaHZfdnRsIik7DQo+ID4NCj4gPiAgc3RhdGljIGlycXJldHVybl90IHZtYnVzX3Bl
cmNwdV9pc3IoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiANCj4gU2ViYXN0aWFuDQoNCg==

