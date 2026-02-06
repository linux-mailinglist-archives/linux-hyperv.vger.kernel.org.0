Return-Path: <linux-hyperv+bounces-8764-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCgeLF85hmmcLAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8764-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 19:56:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468C102508
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 19:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A86E43044813
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Feb 2026 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA83B8BA5;
	Fri,  6 Feb 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QMMDiKYt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011071.outbound.protection.outlook.com [52.103.23.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45635371074;
	Fri,  6 Feb 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404098; cv=fail; b=SW/ajXQxMy/fHc+6dJjiUcx53Y59OVYW6An6gNeRN0bO3SDCWN2At3+RlFYblb01E/CHlLnF/yhO2H4LlcgvNnylCfFVKmBALy58AVznftYMiNHGjFs4Dp8FjWYGoOqgNb+lJa+HJEMnu6wg2C/estGorSsfE7AzagSAqlEjLYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404098; c=relaxed/simple;
	bh=jU4g6oPyWpWqdNNvhcbEv7EDbrQQCJ1INEir99L0lV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4X8KzC+/v9ANVu55wOf4wpMKYK3osLbNVgzEsjv7RitxSV7X2kSbieNk0hfseZv3v+Vi1GcIhcmGUjN/OfUX8j0nYiXPSxhoxBDN2lf81MLPvvbU51Oqu3rGz1LpRmndqsKYXvRO/kdVcO+lzw8UpBw0QnavI0FdqOm9+BvMjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QMMDiKYt; arc=fail smtp.client-ip=52.103.23.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g62smc/2GXoaLuheMdO76P/6svK43KfY32ZSaZFHlC8oRCxJsz9RKcJdMxyNHGVlwh7LYMm9ZZj0dR/BTq9Yox4FX+ekHTc+hZrvNgdioduUm7es0q/O2XIiv8zJmKamvay3WrvMRiEJomh7b/4sYGE9QUCA0D4HfrJOwGElxxIHIixdTeUPoWYqsp+5yTsWsIfvJ8JAB64XerJvnIBgKHE7KL3tZwjIWafSd9t8mLFkxcnzJKHuMEs/bsheYHA4V/99/nTN9nskSqq0CXGwP6pID6cR9HUnrt9L7CJz4IHE9a5VJ0TWRIY7ns8xC3orWtQ16js7/mrkBFTXLlqxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU4g6oPyWpWqdNNvhcbEv7EDbrQQCJ1INEir99L0lV0=;
 b=i2mWZ1kVnKO2l+DKrDPG6pgcaUq3WM70loroPeatp+IsPXlQZX8rQKiZl3xbGiO3e8F2O7cNruXAJyY2U2X3K31/TRLswwXGb5D+QNEqAELSnv7deWcKYVI0OGDy7N7hM20QXX3t72oXBWFQ0TKLSv/T1bQkfkOuPA1XYJqV+Zr4UDA900T0pVm0HQNxhNuzddkhKljov1K6uFzTicqZiWrTwSR+pmUjRtaoFcbmTEVEONlgVp9GjyKcgP/tqz9rMPJtKJgbVQjJUlTnmxSdfjpzifC6goT8QGO+mIy0+IuYTVtbUwl0tGgJPTgpcckkqvCU9bY/34blZaT9LkN3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU4g6oPyWpWqdNNvhcbEv7EDbrQQCJ1INEir99L0lV0=;
 b=QMMDiKYtLy0mNoaHeNIkCBNowWQg/pz83B2v6ya8ab+ZOo+YAxXFllgRU3CULD7SN777uyFuuv7Z1dF6KhODKAYKS7JRfMdFAi7fFC1f8AEX0gv50V8z+GrMooo4biSwr/rAmUJvy6zwpDywu+BKhnGo4WcYoOrmlaYISNKr8nOmVPs4y2qvC+Jgfp2d7oke9ILsM2kT9Gx6Hi+hjcs7oXW1owAVB3TcS76o2eMIwPRPsXiYe5RdFBRJOse1JG1AEcLYqeoqJkDMloqSHcRyDgMFyMIHant4VdaSzHhKqkoIikj5Y0Nq+Riv37D4pMKbHQl8ru7Na4fdciGTafFpbg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB7065.namprd02.prod.outlook.com (2603:10b6:5:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 18:54:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 18:54:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Thread-Topic: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Thread-Index: AQHcls88tda8qIZxSECOt7EB4utS/rV2An0A
Date: Fri, 6 Feb 2026 18:54:55 +0000
Message-ID:
 <SN6PR02MB4157F28C4F4CEFB886CF949ED466A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB7065:EE_
x-ms-office365-filtering-correlation-id: b535d4d2-9438-494c-7b90-08de65b13837
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|13091999003|31061999003|461199028|41001999006|19110799012|8062599012|8060799015|12121999013|15080799012|440099028|3412199025|102099032|13041999003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFR0UGZXc2ZNR0NocEVnczc4dU1zNEpZeU56NThjTWhVaTlSRWlhWWFsOWRq?=
 =?utf-8?B?b0k3dXFxNGkwWkpaR2RwRkhWbkZtUXI1MTZuSHNJVjg0K2hZZkNSM1kxT21x?=
 =?utf-8?B?RVk1dWJDMGNaVGlhUlpvdmxYeTE5eFpZam5ZUnU3dUhsWDRCZHhUOFl6T2F5?=
 =?utf-8?B?OExkY1pQZ29zbWpVd1doSVc0MG1uNnR2bG9OUURNUnpHVFEyM24zTnRjL2xs?=
 =?utf-8?B?WmRHdkpIbnVLdEpUaXpBN1cweUZ5RkRFcFlmOGt3OG1HWlBVemxTay94aDVR?=
 =?utf-8?B?N0Q1VmxWazN1dXJYdGE0YXkzcmU0SFlHaTkzZGYrZmdBeFRoQ01CbkJaOEF6?=
 =?utf-8?B?NTFXVEtKTVJRbkJ0Y1FBZGdlbXdkd2pLVVVpS3BJaDNxZW5qdkk1K05NVjh5?=
 =?utf-8?B?L2kxaHd5U3FTbityRjY0OFo4TDB5U0QxM0xHVUZrTWlpWmxHUUpaaUU5Y2hY?=
 =?utf-8?B?YkdUYVJFUFM1R1RwRjk0U3FudVpxclRwb3JPa2puUkkvbXhXb0xpSWtzU1Nx?=
 =?utf-8?B?K3AvelZFTnZTTnhEdzBDV0RHY3MrYm4xdjRWRzlvZ3RudjFyTHpWY2hSNFF5?=
 =?utf-8?B?anNLTExSNGZBLzlRdUxmcUJCMnJSVHNnOGo1bU9jbkppRTlaT1MwUkVkR283?=
 =?utf-8?B?OUdjUlFmeDBrbTM4L1RYQ2YzankrQ3lJK2dVTWNNWmJ4WnhWejk3S2dtSXJR?=
 =?utf-8?B?N3I2d3N4dzAxeGozS2crL1hDRXBnWU1pc1RGd0FnZFI4RkJqbmlCQjZOM2VF?=
 =?utf-8?B?YVVDMzNsRGdqK2lUanhuMVk5TU9sZnZUYzBNTEIyR0tlN0JHV3dWSG9ZalAr?=
 =?utf-8?B?Mk41NDA1N0RTZDRHdGg5QmxiTHJxYnYyajFTNEI5cUJpcjZuazk3MkxuY1Rj?=
 =?utf-8?B?S2poSW0zdUdGY2Y4UmpCWVR4S0ZvMkx6YUw1MEc0bjM5SHBCZ0ZIVEhvdmlV?=
 =?utf-8?B?QjNLRFFIckFpcDM4RjZReXppT1E3KzdXc0t1clJiMjJRcFdZdDlFMkNiV3hx?=
 =?utf-8?B?ZnhDeFFkLzRBeTFjOFRoNDlJSys3VWJ2eFJySDdaWG5DT1ZMdFVEeUdqNml0?=
 =?utf-8?B?SVZZMUpMSU01d1hZM2pFdGp6dnBWVkVFdlkrbEw3emFpVzNrdU1VU2ZFb3Bj?=
 =?utf-8?B?TTM1WldoWVpsbkNnWWdQbGZDUXR2eUtxdTEweU5uZHF0UjBCVHFHRjI3MmVs?=
 =?utf-8?B?NzlZV3RLTDJ6MXliVThOQXpRQWQzTnVhdGxOUTZLb3FmaEdOU3NvV0hESVVZ?=
 =?utf-8?B?QVFxVDJsSDZ3a01BVktSMmhUV2F1N2hZNFMzYWY4SmZiaytDck9LQWlrakVr?=
 =?utf-8?B?Y1MwSzhNZ1F0czNON0pQWndYc2JaTWdzaUJ0dUw2WXFxOFp6am5sblMvbGdr?=
 =?utf-8?B?Q3ppUU02akxETW1GQ3luRnhnRnRNRmQ4WnE0cDhmemsxUnRTZ1ZOZWEvQ28r?=
 =?utf-8?B?bFNoZ2s4NE9LRHNBTUNuRUlza1F4VkQvSnNjdzlwUmVONFVNSzZrMitEWG4v?=
 =?utf-8?B?ZDYvRHZpdEtMb3lrVU9VVGNqMkp4MU5PVVZYeHpQNXV0ZCt4c0MvaDhRQ1FH?=
 =?utf-8?B?TVNMK0NPdFhyYTRyWjhSbFVLbUxKOUVmQ0NobzhsYVNzZy9BU3l3SVJjLzRz?=
 =?utf-8?B?S1dDenhNYksrNW92Q1BuYjJMOXAwUG5aYm41ekdFQk5Td3ljRXpKUnplbllK?=
 =?utf-8?B?dUhWdFU0a2ZzUisxUWtFM1BJRG1KNjN6WEdqUk0ra0MvY1M4STB3c1c4dFhS?=
 =?utf-8?Q?6RLVg8RE9qWp5V1VoSNkaA02IO9rQPVrnc1giwf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3VPS2pOZ29KOW5ZRjVhaTZEQWE2dzZnRkUrYWFTaTJyREFYME1XTytya28y?=
 =?utf-8?B?M1lMaDlZYnhyNGt0TnI2b2Zrd3NiMHN5MitiTCtxWldGOXBicnFWZ0x4eUJt?=
 =?utf-8?B?bEZoWDZaTkRqdm82TDlncDI4YW9HZGwxT1ZzZ25aOXRPeEY5cXNNVWZJM2w5?=
 =?utf-8?B?aEZCbFBtQjhlZWhNVndRWnlWODQwMldLL0ZFVXVzRDlhR3JHZ1M2S1I0Q01F?=
 =?utf-8?B?RC9iY2k5dkNic0ZzMlEwcEpZOXEyaXpBOTZhZTlLZFRVRmxiR05KWElpWVJk?=
 =?utf-8?B?N3p6S05zNnlBVGdGdHg0N0dwaEtGQjlPemt0bitXL3czcEpER20yTEZ4RTI3?=
 =?utf-8?B?N3phRnVuckJIMGpKOHlaNyszWXlYVkpQcTFWYUplaUpxaWRnQVdjdkhWTHl2?=
 =?utf-8?B?TVAxZU81Nk9XeDJZSzhBbUg3cDZyMEpKNGF3ZTBvYXpibXdzeCs3UURHdGNP?=
 =?utf-8?B?WGdZV3Ryc3Q3c1N4N1J5aU5oWEVua3dTQklLWVY1cyt6Z3NrUHRoL0drV3Rp?=
 =?utf-8?B?Y3ZCZGtLTVhxcUVobllLUXc3Z0IvS2JKaVZkVno4SmJJMDBhZmpkQTROUDJm?=
 =?utf-8?B?UVlDSTZieWRnMWY1dTJ4bUNDK2daWEI5Rm9PYlRtNDlsZTcxT1hISG1nV0Nv?=
 =?utf-8?B?MElYc2UzQlUwMjlUUHB1SGhMb2EwQ3RxdGtwU2xMc3grUDJsT3I2T3BhN2Ji?=
 =?utf-8?B?TEdubWtlNWdIQmVWUW9hN2l6ejlHc2s2SlZ0Rmc4c3hQUG5ueTlsSUdDbENI?=
 =?utf-8?B?Vy9oalJUbDdERkdKTjVGT3FOZUFWdGtPUUMvRm54alV1eDIwejEwNEhlVFZa?=
 =?utf-8?B?N1pJaC9tQ29UNGhJc2RHYndkb2tzajVsUEZBNEF0ZGtyUXZBM1ZvRm8vMS83?=
 =?utf-8?B?TCtYNlJ6Nm9RZkZBcHhpeVQwNGNqbHZ6SGxQQUZzK3kwbVE2NXdGMExOdEZu?=
 =?utf-8?B?cFhKL25uOStXcktCS2N0Q1BLWWxpNWtkKzdoQXhtQ2pYUDE4d0xYNUpQbGJj?=
 =?utf-8?B?NjVSaXh2VTRrYzh2TjJpdkV3Y29yVkFzM3paKzNDWHI3QVlaUUJPeDMzSml5?=
 =?utf-8?B?ZjcyZFBIOWJqU2VyVHhkeFdYR3g3MUlRSUZuTlVIaFV4aGZvUm1GSEh1R1VB?=
 =?utf-8?B?VEYwNnlqTVNQRE9NMlFhaWNqVEhKUGRNQkMrNDkrelFSbTdTeERydFVINkhK?=
 =?utf-8?B?bVRralBRZzNhdEF2UnQ2SFFUVjlJN0ZNUGVIR3dLaGVqNi9PaklXYlZZVDM0?=
 =?utf-8?B?eGhBeU9DUDRydWg1V3NkTE1IOWhiTFM1YzZhZUJJYlpwUSswVHpJVkFKZFEy?=
 =?utf-8?B?NDlLMzU3RFIzaURiT3R1MlNBbWNjRm5aOEJCU3hKcG4xd3JRWllGOXZMTGk3?=
 =?utf-8?B?MlBtWDlraU5LMUdvcXlNWkdBWkV1RnpWVkt3Y0ljeDIxeDQwekVlNkRQV1Br?=
 =?utf-8?B?K3dYYzNMaklqTkU3azh3cGpJQ1hmanFEN2NNaFVIa2k3UnI4R3BwYTF5azFV?=
 =?utf-8?B?L3A1M0M3bXhEQXd2YStxc0FYT1dRTGNWZ0ZJcWRQdGZaTDlQTmFiandySFpT?=
 =?utf-8?B?S29rb085STMzckhMWjlIQUpvY0V5WklPUGhNOEZYVnVuRGpLdTBtSVhTZCtl?=
 =?utf-8?B?V20va1JUeGhvVzBhVWRWTmpwZjBWRklNTG5rdEVxQ0F2Z0xLL1o2SUFxbG5E?=
 =?utf-8?B?TEN1ZkZoUHZuQURjTlUwVjVvbjF3Nis2VHZBbGFrTlFiWHVVSmpJcHBtV1hq?=
 =?utf-8?B?MmU1bys4UjVDajhpeHlGWW5VaFJIYWpPL2RJWlBveUo5ZHRiZVJXdWhSTmUx?=
 =?utf-8?B?cFgwME8xR3dlVS9maVo3WlNYMlhqcUJ0cncyUHhPRlkxeitudWFjNGtjMlFl?=
 =?utf-8?B?QTNqWTF0QWdERWsyQ0FXeG5GSmZTMFlPMno4elpuc2FwY3Q3MGphZk40V3Nw?=
 =?utf-8?Q?mSrXbvKTLF4Xiipw8TGpV+Vq/xZPtWLa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b535d4d2-9438-494c-7b90-08de65b13837
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 18:54:55.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8764-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1468C102508
X-Rspamd-Action: no action

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDUsIDIwMjYgMTA6NDIgQU0NCj4gVG86IGt5
c0BtaWNyb3NvZnQuY29tOyBoYWl5YW5nekBtaWNyb3NvZnQuY29tOyB3ZWkubGl1QGtlcm5lbC5v
cmc7DQo+IGRlY3VpQG1pY3Jvc29mdC5jb207IGxvbmdsaUBtaWNyb3NvZnQuY29tDQo+IENjOiBs
aW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyA0LzRdIG1zaHY6IEhhbmRsZSBpbnN1ZmZpY2llbnQgcm9v
dCBtZW1vcnkgaHlwZXJ2aXNvciBzdGF0dXNlcw0KPiANCj4gV2hlbiBjcmVhdGluZyBndWVzdCBw
YXJ0aXRpb24gb2JqZWN0cywgdGhlIGh5cGVydmlzb3IgbWF5IGZhaWwgdG8NCj4gYWxsb2NhdGUg
cm9vdCBwYXJ0aXRpb24gcGFnZXMgYW5kIHJldHVybiBhbiBpbnN1ZmZpY2llbnQgbWVtb3J5IHN0
YXR1cy4NCj4gSW4gdGhpcyBjYXNlLCBkZXBvc2l0IG1lbW9yeSB1c2luZyB0aGUgcm9vdCBwYXJ0
aXRpb24gSUQgaW5zdGVhZC4NCj4gDQo+IE5vdGU6IFRoaXMgZXJyb3Igc2hvdWxkIG5ldmVyIG9j
Y3VyIGluIGEgZ3Vlc3Qgb2YgTDFWSCBwYXJ0aXRpb24gY29udGV4dC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpaSA8c2tpbnNidXJza2lpQGxpbnV4Lm1pY3Jvc29m
dC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9odi9odl9jb21tb24uYyAgICAgIHwgICAgMiArDQo+
ICBkcml2ZXJzL2h2L2h2X3Byb2MuYyAgICAgICAgfCAgIDE0ICsrKysrKysrKysNCj4gIGluY2x1
ZGUvaHlwZXJ2L2h2Z2RrX21pbmkuaCB8ICAgNTggKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAy
OCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L2h2X2NvbW1vbi5j
IGIvZHJpdmVycy9odi9odl9jb21tb24uYw0KPiBpbmRleCBmMjA1OTYyNzY2NjIuLjZiNjdhYzYx
Njc4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi9odl9jb21tb24uYw0KPiArKysgYi9kcml2
ZXJzL2h2L2h2X2NvbW1vbi5jDQo+IEBAIC03OTQsNiArNzk0LDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBodl9zdGF0dXNfaW5mbyBodl9zdGF0dXNfaW5mb3NbXSA9IHsNCj4gIAlfU1RBVFVTX0lO
Rk8oSFZfU1RBVFVTX1BST1BFUlRZX1ZBTFVFX09VVF9PRl9SQU5HRSwJLUVJTyksDQo+ICAJX1NU
QVRVU19JTkZPKEhWX1NUQVRVU19JTlNVRkZJQ0lFTlRfTUVNT1JZLAkJLUVOT01FTSksDQo+ICAJ
X1NUQVRVU19JTkZPKEhWX1NUQVRVU19JTlNVRkZJQ0lFTlRfQ09OVElHVU9VU19NRU1PUlksCS1F
Tk9NRU0pLA0KPiArCV9TVEFUVVNfSU5GTyhIVl9TVEFUVVNfSU5TVUZGSUNJRU5UX1JPT1RfTUVN
T1JZLAktRU5PTUVNKSwNCj4gKwlfU1RBVFVTX0lORk8oSFZfU1RBVFVTX0lOU1VGRklDSUVOVF9D
T05USUdVT1VTX1JPT1RfTUVNT1JZLCAJLUVOT01FTSksDQo+ICAJX1NUQVRVU19JTkZPKEhWX1NU
QVRVU19JTlZBTElEX1BBUlRJVElPTl9JRCwJCS1FSU5WQUwpLA0KPiAgCV9TVEFUVVNfSU5GTyhI
Vl9TVEFUVVNfSU5WQUxJRF9WUF9JTkRFWCwJCS1FSU5WQUwpLA0KPiAgCV9TVEFUVVNfSU5GTyhI
Vl9TVEFUVVNfTk9UX0ZPVU5ELAkJCS1FSU8pLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9o
dl9wcm9jLmMgYi9kcml2ZXJzL2h2L2h2X3Byb2MuYw0KPiBpbmRleCAxODFmNmQwMmJjZTMuLjVm
NGZkOWMzMjMxYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi9odl9wcm9jLmMNCj4gKysrIGIv
ZHJpdmVycy9odi9odl9wcm9jLmMNCj4gQEAgLTEyMSw2ICsxMjEsMTggQEAgaW50IGh2X2RlcG9z
aXRfbWVtb3J5X25vZGUoaW50IG5vZGUsIHU2NCBwYXJ0aXRpb25faWQsDQo+ICAJY2FzZSBIVl9T
VEFUVVNfSU5TVUZGSUNJRU5UX0NPTlRJR1VPVVNfTUVNT1JZOg0KPiAgCQludW1fcGFnZXMgPSBI
Vl9NQVhfQ09OVElHVU9VU19BTExPQ0FUSU9OX1BBR0VTOw0KPiAgCQlicmVhazsNCj4gKw0KPiAr
CWNhc2UgSFZfU1RBVFVTX0lOU1VGRklDSUVOVF9DT05USUdVT1VTX1JPT1RfTUVNT1JZOg0KPiAr
CQludW1fcGFnZXMgPSBIVl9NQVhfQ09OVElHVU9VU19BTExPQ0FUSU9OX1BBR0VTOw0KPiArCQlm
YWxsdGhyb3VnaDsNCj4gKwljYXNlIEhWX1NUQVRVU19JTlNVRkZJQ0lFTlRfUk9PVF9NRU1PUlk6
DQo+ICsJCWlmICghaHZfcm9vdF9wYXJ0aXRpb24oKSkgew0KPiArCQkJaHZfc3RhdHVzX2Vyciho
dl9zdGF0dXMsICJVbmV4cGVjdGVkIHJvb3QgbWVtb3J5IGRlcG9zaXRcbiIpOw0KPiArCQkJcmV0
dXJuIC1FTk9NRU07DQo+ICsJCX0NCj4gKwkJcGFydGl0aW9uX2lkID0gSFZfUEFSVElUSU9OX0lE
X1NFTEY7DQo+ICsJCWJyZWFrOw0KPiArDQoNClBlciB0aGUgZGlzY3Vzc2lvbiBpbiB2MSBvZiB0
aGlzIHBhdGNoIHNldCwgaWYgdGhlIG51bWJlciBvZiBwYWdlcyB0aGF0IHNob3VsZCBiZQ0KZGVw
b3NpdGVkIGluIGEgcGFydGljdWxhciBzaXR1YXRpb24gaXMgZGlmZmVyZW50IGZyb20gd2hhdCB0
aGlzIGZ1bmN0aW9uIHByb3ZpZGVzLA0KdGhlIGZhbGxiYWNrIGlzIHRvIHVzZSBodl9jYWxsX2Rl
cG9zaXRfcGFnZXMoKSBkaXJlY3RseS4gRnJvbSB3aGF0IEkgc2VlLCB0aGVyZSdzDQpvbmx5IG9u
ZSBzdWNoIGZhbGxiYWNrIGNhc2UgYWZ0ZXIgYSBoeXBlcmNhbGwgZmFpbHVyZSAtLSBpbiBodl9k
b19tYXBfZ3BhX2hjYWxsKCkuDQpUaGUgb3RoZXIgdXNlcyBvZiBodl9jYWxsX2RlcG9zaXRfcGFn
ZXMoKSBhcmUgaW5pdGlhbCBkZXBvc2l0cyB3aGVuIGNyZWF0aW5nIGENClZQIG9yIHBhcnRpdGlv
bi4NCg0KQnV0IGlmIGh2X2NhbGxfZGVwb3NpdF9wYWdlcygpIGlzIHVzZWQgZGlyZWN0bHksIHRo
ZSBsb2dpYyBhZGRlZCBoZXJlIHRvIGRldGVjdA0KaW5zdWZmaWNpZW50IHJvb3QgbWVtb3J5IGFu
ZCBkZXBvc2l0IHRvIEhWX1BBUlRJVElPTl9JRF9TRUxGIGlzbid0IGFwcGxpZWQuDQpTbyBpZiB0
aGUgaHlwZXJjYWxsIGluIGh2X2RvX21hcF9ncGFfaGNhbGwoKSBmYWlscyB3aXRoIGluc3VmZmlj
aWVudCByb290DQptZW1vcnksIHRoZSBkZXBvc2l0IGlzIGRvbmUgdG8gdGhlIHdyb25nIHBhcnRp
dGlvbiBJRC4gSWYgdGhhdCBjYXNlIGNhbg0KYWN0dWFsbHkgaGFwcGVuLCB0aGVuIHNvbWUgYWRk
aXRpb25hbCBsb2dpYyBpcyBuZWVkZWQgaW4NCmh2X2RvX21hcF9ncGFfaGNhbGwoKSB0byBoYW5k
bGUgaXQuIE9yIHRoZXJlIG5lZWRzIHRvIGJlIGEgZmFsbGJhY2sNCmZ1bmN0aW9uIHRoYXQgY29u
dGFpbnMgdGhlIGxvZ2ljLg0KDQpPdGhlciB0aGFuIHRoYXQsIGV2ZXJ5dGhpbmcgZWxzZSBpbiB0
aGlzIHBhdGNoIHNldCBsb29rcyBnb29kIHRvIG1lLg0KDQpNaWNoYWVsDQoNCj4gIAlkZWZhdWx0
Og0KPiAgCQlodl9zdGF0dXNfZXJyKGh2X3N0YXR1cywgIlVuZXhwZWN0ZWQhXG4iKTsNCj4gIAkJ
cmV0dXJuIC1FTk9NRU07DQo=

