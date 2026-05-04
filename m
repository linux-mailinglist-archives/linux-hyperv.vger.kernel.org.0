Return-Path: <linux-hyperv+bounces-10589-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFWhIAq3+Gn1zAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10589-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 17:11:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB54C0790
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BF28301C96F
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6313E0242;
	Mon,  4 May 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n238YqRd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010094.outbound.protection.outlook.com [52.103.10.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C873DFC6F;
	Mon,  4 May 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907402; cv=fail; b=oIZHIWk6yOrDOusnX1V0fwnspx08u+2MUXQYiAmByC0KfaGQFiINap0jqZWAm4Zwxg8B2+kUKqKBchcVhC8ueHs2LYILicYp5csHDYw9x1GgahwUm4XpJhJ+oabBbfO/eRrpC+1eiZ9F/yioNXl9E8mmIro99XIWV5t3wcoEPrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907402; c=relaxed/simple;
	bh=d/nk+N2fegG9a3bF8XhAKI/x8b4Y3YUE6k8i6TxpMXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KE00B8VL0KNiGRvyr7yAcZ6ESAmgMhFxjnNgda+RnEgHRuy3aBJrpXA1WPDIoUDnut3L6oSNAUXgq4lUtkOnGK40HaC60vAIptO4xTMEcLdnP52iK2ETBE9uba1rMkT+z2OKLzrkdEFa7SQN6mOFMNbVkU5wqvF0za+WwuQdSUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n238YqRd; arc=fail smtp.client-ip=52.103.10.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbgwwSShu9rBfs7JWMIH/DzzmyP7MBiCM3g5Ev/VP5iuLx+whTpBbQgakB9yQVUiB90FxtYPLFwkBMO93LK7YVXwe4qRXuxMogY5Mw3lJQlIhRnXBXBwWAz7Gye1Zvvn4i+P0LPScVmxo8XyFoW8T2Frr/sCBbNT/YNzSS8lIbaDmxhAthnkN1VGp2qBuzDAcZV77JWFyKtkILiE76J5jiaKhJLNn8WemLuIwGgimjdiSU7m5GgUZbKpQOERQykI/q79EnIl+5I5KBmGPAC9XIGIJx4rghTZBqLLCJdezz80ccCEEdH9KJJdxYB1jpWW8fstkWrWcwuWmSxq8bjU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5a2TM9yDTuOV7Q4SCARAUCHlwsaM9PApHJGsf+dEaQ=;
 b=hRu/4WiosLDw87QwNf2ZoCnibTl30wCBVo7x21jxCi008eoEbrgqWxvi38qmB2DN2dd7m82gIjS6EP+dmSRpE5ZDB+j5jV0e6erYMc/PQ6i89CnHXyTAoy/2CQR4dlUhTqVMDga31aF9RDfL5XrP2dnmwKB0LJeb1oh1+tWDxX/VpiTAq/hj9V88ztbKRBh6gCbphLhQKP15ajGsvHe0f2sBwsz4aNQPeo+50I/mAKf7KUB1Iu8WzFAx5QWuZPwhhEjc4V12m7BXbikTx9CXiv0XatlOWZUx0rG0OFfNVI0+ytU1tj1PXOPY29yJgg5YhYRjqzXtb4csZ4S1IgALzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5a2TM9yDTuOV7Q4SCARAUCHlwsaM9PApHJGsf+dEaQ=;
 b=n238YqRdnIUyV+AS7/PNNfjdK6+1aXeDYsQ2b2R8w+X8bIsjgXATEYtGkJXp1nujcjjEaMF68S2t7/LnAEoKhUIUcSJ98edBEzWC6zMb5jPgoVrQzDmgw0XIg1Kvxau0BLL6LqG7rrh+U56YmvMHYmAg3OR3lDTnbyGY58yqIC8T3ffvlDi7nbgGTaWyPNJRnR7275sfaErsSGnw2R9xZSjz/OUT12iZow6v34bY0nrnvct1wIcVUNKJML3hw+jVyxMuc9HN3ivmYBsnIrsbSmu52BfLThUqNDiKLOVl9/Cb1hUhsUAL+lxI+/Prnkp8/g2ZPhBuAZFYukKOzCgtWg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9818.namprd02.prod.outlook.com (2603:10b6:303:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 15:09:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 15:09:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jork Loeser <jloeser@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnd
 Bergmann <arnd@arndb.de>, Michael Kelley <mhklinux@outlook.com>, Anirudh
 Rayabharam <anirudh@anirudhrb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] mshv: limit SynIC management to MSHV-owned
 resources
Thread-Topic: [PATCH v4 1/3] mshv: limit SynIC management to MSHV-owned
 resources
Thread-Index: AQHc1o5Hld1ACBSF0EugPSqrlhovB7X+AwNg
Date: Mon, 4 May 2026 15:09:55 +0000
Message-ID:
 <SN6PR02MB4157280E305E11C5840B444DD4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
 <20260427213855.1675044-2-jloeser@linux.microsoft.com>
In-Reply-To: <20260427213855.1675044-2-jloeser@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9818:EE_
x-ms-office365-filtering-correlation-id: f5e48e1d-2f96-470a-a83b-08dea9ef3339
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|41001999006|8060799015|8062599012|19110799012|51005399006|13091999003|461199028|55001999006|19101099003|31061999003|440099028|3412199025|12091999003|102099032|56899033|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CTscFpwQkEmVMNl9mNnpLLlGOqfCr8TQTeUNP9yt0DvclccoU5upm0DPgTu3?=
 =?us-ascii?Q?cArOChJXVgnqRipGspSf+QStGOA/lRiyvqZzBpo+14+R8mQRGrtpGwheJD8r?=
 =?us-ascii?Q?z/woS/uItj258lgBtlL+A5y8GiHjICu4BzHTCw3ahaBUCcd5MX/7uPCGIDvW?=
 =?us-ascii?Q?zXhBYI2OyytuRMH5SSjYmddtfH6tC+hAdt5fX1GE7yuyCrcHZ2in1CL+BS0F?=
 =?us-ascii?Q?SkkO7KLwgME0+EXrp5KE3f4GjysJ2iYbtCpzm495nhkoKQ/wSH6C6FVbR/w7?=
 =?us-ascii?Q?/a81rFC4flSqVYFGIIdt6hhcaYpyGR/o+HeZaHZoiE14LL28Q+LPnuwLFlfl?=
 =?us-ascii?Q?SCC6ONE4V1Wbf76tQGs3yyeEuiuVyjBRjN6y9OcaFN2Wx78A+gobkejULmsn?=
 =?us-ascii?Q?YccUYrzEbsz/RSisuEpdYyiLR3gX3cWEnPUz9yyMLuVbmEjQv1ehM8goP9mw?=
 =?us-ascii?Q?TjXD75HwuAYAcJiHL+3EReJsAerAMxyb0bENvTzqmRlTa64B5qz6jxe9MK/b?=
 =?us-ascii?Q?oqmBOhfdbHkXX55nVjHAnx3mHcjookPFxeM4G/dPlWn1LrNH8Au6KL1HDetw?=
 =?us-ascii?Q?Tuw74MMwfCdFCwshBnjhsQ8OfkUQJ9B/AaNGPKm/cHlTwBCpz6luQfLntPKd?=
 =?us-ascii?Q?+LjAw92kSm2z8Qy/8XT8cPG21VOBfxm+74SCAIAwaGbRgYQ5xs5EApgYC8L6?=
 =?us-ascii?Q?9bW4+ccIXLofq7m4iCkTFWdb6UC042NbZAP1qpdFRMbyYTfx1BHK5qZxRVBC?=
 =?us-ascii?Q?JO6xBIJZx+UPsyLFmM8nEePQl7IcSO8ysEi7Mv5l8B/GX8w3iKy6qGn9ai4g?=
 =?us-ascii?Q?qNXh61yZ0cwW5K9nssA2IQ8XHFnX4K8AadXn3u6Bv4JgVL1sv0pG8cVBjBYl?=
 =?us-ascii?Q?ixuQEyAUp+z6mar6ALA4wyflPBr4L6O1CqWGPNgPzrfZFdhpw3hij+VANj+B?=
 =?us-ascii?Q?ziJ7Mhbw5rtmWY3ewoMcdofGCRTUF+fx38aiSe9gSaAoqRp0DsnLHGpJtuMX?=
 =?us-ascii?Q?Rg0fiHR1IQuU1O2xViKkuSKIEtqArKLGvF0je9t6dTGMToA7uMXeRtButm/W?=
 =?us-ascii?Q?PDGxu97oxwGd+jV/CgvsPcx+Hq75RWnmaEpWeLXOSCn8oXT+NVV2U0xE9cxQ?=
 =?us-ascii?Q?voVOCgiikZgp?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LL6YEMKvFbQ5GQwnZwMHADq7MKo9dj39NTA3RJ9aQ8nU4wumwxjSwAhO/M75?=
 =?us-ascii?Q?CWkjFyvmDCeabkc0eYTZzNGbVJ39IHySW0B35pWkGDS+irzDgPl9GNlp+xui?=
 =?us-ascii?Q?OovfSCmU+1pG6JOjKTjzveJqkMGFVRGEyD73kXmvhPOnhl99g5ANBLLwh2Ks?=
 =?us-ascii?Q?7pvBkAYwkgrssFGHcQWVC4eEXJQWpSPVXO9PoFcsIM5IKM97N5uCc6Douhrd?=
 =?us-ascii?Q?Uetl1OOBXOyiQD6fvhF40oJxuD3W+7tEAfzFbSTOThsZjhlnK3za4w0KoRXd?=
 =?us-ascii?Q?Rda6qs9J9LIcdmydruJIZlTDXXSM9C55NZNO+aB5tmQl+8RpxMx07Yafq3xd?=
 =?us-ascii?Q?Rc/D3usdoms/nojcLIE98k3robtpgHd5aSCgfNKizaBcgFNbzLqfV7fyR+IO?=
 =?us-ascii?Q?W+PJptWkGqxPMymwR7FPL+VTRdStE3L5eLfixrtrhPjTi75wKhw5ZzL6gIXr?=
 =?us-ascii?Q?a+/jBpMOTeS2Ep1tnghkRUqOlxdiVlM0bBtIjCILJjW+pvMqm0HyhAR7jYvR?=
 =?us-ascii?Q?F5Bo8kpXOG0anFGkIRDhXz12SwWqtRdd+0J43rp41saySxQQLX1Sh1nOFITR?=
 =?us-ascii?Q?MsnqBZn4C+YqtdehV/8wWS3ZUtss0s64KO0aVgDm+0Fl0jMdXs4cl1wuxKqE?=
 =?us-ascii?Q?GxupZ/Mb8/hJ858g9NA7xMNOhrXujevYY9XlEqihnFen6ioETKep0Vbhy1Ew?=
 =?us-ascii?Q?T9FhonoCBJlChVtEjIeQYnj8SKhHU7Pznwt+vCr58jxk0NtNX12zhC6HAfz1?=
 =?us-ascii?Q?ift8RPxFTf5hPrJi8d0XLwzq8iSLtcQEcAw8H+VphRCYNCn1gbeTLUoh7v6F?=
 =?us-ascii?Q?OTN0RRm3uzo/PnBf0nxgjJkutxGf50ltMWG/kE1R9MgfoIFI17SgzrmFqhAB?=
 =?us-ascii?Q?6h1//aYjXiri41PRr46OiZ4DZo63qpexLcILC4z5mmSBrd2pY/HbGXxrTZ1N?=
 =?us-ascii?Q?173zrbWTtZWDwaYgIxLGaTQf/La86Qp+UvZPmWULlLziRXsCRZ3G9wfkJ3G/?=
 =?us-ascii?Q?/bZH2ZUXx4x8mtSfKhPDLDgpPBu91njD+Zb5crvrJrKSLQw3LrgPj3TJRDEq?=
 =?us-ascii?Q?uRoCj1Bh6eyNoRS50qqFGb5eUG3DyS8osYolb2z1f4iDbfaQy2uV3p7nI9Ws?=
 =?us-ascii?Q?TzQ3ocvlUOInAaQ3DYQQwBDgYVGk6qyF6J/Anml3E6RmMEQPhRSpylM0KmlB?=
 =?us-ascii?Q?5CxZ3gpOa/P7ok4APxmAyqOzVCkQagau1o1RwR9VVTutD6eZ5cLKiXK9z0bm?=
 =?us-ascii?Q?z0boSBhtE2hVOTgLTGTj5hg5zA0UZGJDNUrIpNwIsPPb7D/bqBSnlw8QPKPc?=
 =?us-ascii?Q?SJI30B7IeigEsVhOoiWh2Ar2PYZgnISjK9+inbvZZGK5+d9T1Y6AfvUNw1OR?=
 =?us-ascii?Q?tPx9gJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e48e1d-2f96-470a-a83b-08dea9ef3339
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 15:09:55.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9818
X-Rspamd-Queue-Id: EAEB54C0790
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10589-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,anirudhrb.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]

From: Jork Loeser <jloeser@linux.microsoft.com> Sent: Monday, April 27, 202=
6 2:39 PM
>=20
> The SynIC is shared between VMBus and MSHV. VMBus owns the message
> page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
> and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
>=20
> Currently mshv_synic_cpu_init() redundantly enables SIMP, SIEFP, and
> SCONTROL that VMBus already configured, and mshv_synic_cpu_exit()
> disables all of them. This is wrong because MSHV can be torn down
> while VMBus is still active. In particular, a kexec reboot notifier
> tears down MSHV first. Disabling SCONTROL, SIMP, and SIEFP out
> from under VMBus causes its later cleanup to write SynIC MSRs while
> SynIC is disabled, which the hypervisor does not tolerate.
>=20
> Restrict MSHV to managing only the resources it owns:
> - SINT0, SINT5: mask on cleanup, unmask on init
> - SIRBP: enable/disable as before
> - SIMP, SIEFP, SCONTROL: leave to VMBus when it is active (L1VH
>   and nested root partition); on a non-nested root partition VMBus
>   does not run, so MSHV must enable/disable them
>=20
> While here, fix the SIEFP and SIRBP memremap() and virt_to_phys()
> calls to use HV_HYP_PAGE_SHIFT/HV_HYP_PAGE_SIZE instead of
> PAGE_SHIFT/PAGE_SIZE. The hypervisor always uses 4K pages for SynIC
> register GPAs regardless of the kernel page size, so using PAGE_SHIFT
> produces wrong addresses on ARM64 with 64K pages.

I agree that this is a good change. But any kernel image built with
CONFIG_MSHV_ROOT set must use only 4KiB pages, as enforced
by the dependency in drivers/hv/Kconfig. The change makes the
code explicitly match the SynIC register layout, which is good,
but it doesn't actually fix a problem since root MSHV code can't
run on ARM64 with 64KiB pages. My only concern is that this
commit message should not imply that an ARM64/64KiB
configuration is possible for the root.

Michael

>=20
> Note that initialization order matters - VMBUS first, MSHV second,
> and the reverse on de-init. Ideally, we would want a dedicated SYNIC
> driver that replaces the cross-dependencies with a clear API and
> dynamic tracking. Such refactor should go into its own dedicated
> series, outside of this kexec fix series.
>=20
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/hv.c         |   3 +
>  drivers/hv/mshv_synic.c | 150 ++++++++++++++++++++++++++--------------
>  2 files changed, 103 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index ae60fd542292..ef4b1b03395d 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -272,6 +272,9 @@ void hv_synic_free(void)
>  /*
>   * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Control=
ler
>   * with the hypervisor.
> + *
> + * Note: When MSHV is present, mshv_synic_cpu_init() intializes further
> + * registers later.
>   */
>  void hv_hyp_synic_enable_regs(unsigned int cpu)
>  {
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index e2288a726fec..2db3b0192eac 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/hyperv.h>
>  #include <linux/reboot.h>
>  #include <asm/mshyperv.h>
>  #include <linux/acpi.h>
> @@ -456,46 +457,75 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
>  	union hv_synic_sint sint;
> -	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  			&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =3D
>  			&spages->synic_event_ring_page;
> +	/*
> +	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
> +	 * See hv_hyp_synic_enable_regs() for that initialization.
> +	 */
> +	bool vmbus_active =3D hv_vmbus_exists();
>=20
> -	/* Setup the Synic's message page */
> +	/*
> +	 * Map the SYNIC message page. When VMBus is not active the
> +	 * hypervisor pre-provisions the SIMP GPA but may not set
> +	 * simp_enabled - enable it here.
> +	 */
>  	simp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIMP);
> -	simp.simp_enabled =3D true;
> +	if (!vmbus_active) {
> +		simp.simp_enabled =3D true;
> +		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +	}
>  	*msg_page =3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  			     HV_HYP_PAGE_SIZE,
>  			     MEMREMAP_WB);
>=20
>  	if (!(*msg_page))
> -		return -EFAULT;
> -
> -	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +		goto cleanup_simp;
>=20
> -	/* Setup the Synic's event flags page */
> +	/*
> +	 * Map the event flags page. Same as SIMP: enable when
> +	 * VMBus is not active, already enabled by VMBus otherwise.
> +	 */
>  	siefp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIEFP);
> -	siefp.siefp_enabled =3D true;
> -	*event_flags_page =3D memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
> -				     PAGE_SIZE, MEMREMAP_WB);
> +	if (!vmbus_active) {
> +		siefp.siefp_enabled =3D true;
> +		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +	}
> +	*event_flags_page =3D memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIF=
T,
> +				     HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>=20
>  	if (!(*event_flags_page))
> -		goto cleanup;
> -
> -	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +		goto cleanup_siefp;
>=20
>  	/* Setup the Synic's event ring page */
>  	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
> -	sirbp.sirbp_enabled =3D true;
> -	*event_ring_page =3D memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
> -				    PAGE_SIZE, MEMREMAP_WB);
>=20
> -	if (!(*event_ring_page))
> -		goto cleanup;
> +	if (hv_root_partition()) {
> +		*event_ring_page =3D memremap(sirbp.base_sirbp_gpa <<
> HV_HYP_PAGE_SHIFT,
> +					    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>=20
> +		if (!(*event_ring_page))
> +			goto cleanup_siefp;
> +	} else {
> +		/*
> +		 * On L1VH the hypervisor does not provide a SIRBP page.
> +		 * Allocate one and program its GPA into the MSR.
> +		 */
> +		*event_ring_page =3D (struct hv_synic_event_ring_page *)
> +			get_zeroed_page(GFP_KERNEL);
> +
> +		if (!(*event_ring_page))
> +			goto cleanup_siefp;
> +
> +		sirbp.base_sirbp_gpa =3D virt_to_phys(*event_ring_page)
> +				>> HV_HYP_PAGE_SHIFT;
> +	}
> +
> +	sirbp.sirbp_enabled =3D true;
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>=20
>  	if (mshv_sint_irq !=3D -1)
> @@ -518,28 +548,30 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>=20
> -	/* Enable global synic bit */
> -	sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> -	sctrl.enable =3D 1;
> -	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	/* When VMBus is active it already enabled SCONTROL. */
> +	if (!vmbus_active) {
> +		union hv_synic_scontrol sctrl;
> +
> +		sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> +		sctrl.enable =3D 1;
> +		hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	}
>=20
>  	return 0;
>=20
> -cleanup:
> -	if (*event_ring_page) {
> -		sirbp.sirbp_enabled =3D false;
> -		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> -		memunmap(*event_ring_page);
> -	}
> -	if (*event_flags_page) {
> +cleanup_siefp:
> +	if (*event_flags_page)
> +		memunmap(*event_flags_page);
> +	if (!vmbus_active) {
>  		siefp.siefp_enabled =3D false;
>  		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> -		memunmap(*event_flags_page);
>  	}
> -	if (*msg_page) {
> +cleanup_simp:
> +	if (*msg_page)
> +		memunmap(*msg_page);
> +	if (!vmbus_active) {
>  		simp.simp_enabled =3D false;
>  		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> -		memunmap(*msg_page);
>  	}
>=20
>  	return -EFAULT;
> @@ -548,16 +580,15 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  static int mshv_synic_cpu_exit(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
> -	union hv_synic_simp simp;
> -	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  		&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =3D
>  		&spages->synic_event_ring_page;
> +	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
> +	bool vmbus_active =3D hv_vmbus_exists();
>=20
>  	/* Disable the interrupt */
>  	sint.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SINT0 +
> HV_SYNIC_INTERCEPTION_SINT_INDEX);
> @@ -574,28 +605,47 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	if (mshv_sint_irq !=3D -1)
>  		disable_percpu_irq(mshv_sint_irq);
>=20
> -	/* Disable Synic's event ring page */
> +	/* Disable SYNIC event ring page owned by MSHV */
>  	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled =3D false;
> -	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> -	memunmap(*event_ring_page);
>=20
> -	/* Disable Synic's event flags page */
> -	siefp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIEFP);
> -	siefp.siefp_enabled =3D false;
> -	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +	if (hv_root_partition()) {
> +		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +		memunmap(*event_ring_page);
> +	} else {
> +		sirbp.base_sirbp_gpa =3D 0;
> +		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> +		free_page((unsigned long)*event_ring_page);
> +	}
> +
> +	/*
> +	 * Release our mappings of the message and event flags pages.
> +	 * When VMBus is not active, we enabled SIMP/SIEFP - disable
> +	 * them. Otherwise VMBus owns the MSRs - leave them.
> +	 */
>  	memunmap(*event_flags_page);
> +	if (!vmbus_active) {
> +		union hv_synic_simp simp;
> +		union hv_synic_siefp siefp;
>=20
> -	/* Disable Synic's message page */
> -	simp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIMP);
> -	simp.simp_enabled =3D false;
> -	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +		siefp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIEFP);
> +		siefp.siefp_enabled =3D false;
> +		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +
> +		simp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIMP);
> +		simp.simp_enabled =3D false;
> +		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
> +	}
>  	memunmap(*msg_page);
>=20
> -	/* Disable global synic bit */
> -	sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> -	sctrl.enable =3D 0;
> -	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	/* When VMBus is active it owns SCONTROL - leave it. */
> +	if (!vmbus_active) {
> +		union hv_synic_scontrol sctrl;
> +
> +		sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> +		sctrl.enable =3D 0;
> +		hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +	}
>=20
>  	return 0;
>  }
> --
> 2.43.0
>=20


