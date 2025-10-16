Return-Path: <linux-hyperv+bounces-7229-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC372BE53D0
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6163E54779F
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25B2D9EE1;
	Thu, 16 Oct 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OD1/VE3a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010005.outbound.protection.outlook.com [52.103.20.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759F22424E;
	Thu, 16 Oct 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642954; cv=fail; b=mbQ9xseYrk97o3ZKcQK5XRvZEhavLmf91nXKh8lWMk66b0jxsqGd78Esafyz6xoW19FiIGzTfY104OG0L/WLbdEtt71D/KohMYst36j2hTUovM+wqYmJ6ss8whWkEJhQWQI/XgE/MwqHs7BYmT/3bDaYn7TBXTqTwuRU+s+7pbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642954; c=relaxed/simple;
	bh=6XL7/t4ucvKMq6v5uCwmtboKmXmIpWGj41+LVLuzIYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G6sIn2V/S4qUk03xGaAe9IyPWTk2ecCRP6IKFr5lgjG2XTauxfG/69F4WzkqON0kechBBXmXeaIDY+YF1lWicwOjaR1+JlshvwLWNFounwRWP7HEYG+aVcWfvBSRaedr+i2f4Lbt1i/FtrWtAXwMeyHqeScinKeX5dvqNY+U1uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OD1/VE3a; arc=fail smtp.client-ip=52.103.20.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+7KWf4p6MEBmjviBNmlOgh1ks8XqaIHoWjaKdYbhoQxzbRgNRNB6pzqvFCqypw5emrMtiGk60mJ1DUvVxEtLO4bNN5mLkAiXnVUfZ+o4hmg1Yrkh2kb7WCvgLoNldyrKENDL/+0tastkvf7Wy6yNy8wTxuUOneq6A5z6/d/26aM746ePICAKACE1e74+68Ivte6KKte9Rl5UzTzpSOl2+0G5H5VkXvwjmrgkR6TxHyu5aSm0fPK3ijza+Nj63z0obmYfwZdh29NTb9qKR5Sq+ppIk+lMLiyAGGIbKcy21XWWLr5oIo28CswmR59l6R7t+jIf+EX/wmttwIBD7gT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrJPl2YjUzyV9aONHgVPor8y2N6Hnau25dph4TQQBlM=;
 b=TbHh+E0MJkRPo7iHvs8AWfKanuPlYByAuJEcDqa6SjPQpPn3wNytUQ2FpxL6q/4DzaMxy4p/IuVj6+ULqdEO/l0m4EjySQwmDBwJ5OGNB0Jlj+29mmgfHYYSAMKfiK0tj+hddkdkUAJf4tLEfLkLKaTkJ0SZXZ2mMGT+5M8HvbYK0qDWBROuYr/W2JjQyfaWVVnMQ64ld+ivMiG4IwmHtGub5PNS9rrhL+/ebwDhjqK61NeHNVENl3K96UJi3Hw+trPZWTrSqNEkIKQwceRgRjp8JfRmE7ujdyNxq6PR0AfEK+9rBHkC4LDYGjsAFAoCJQRWx4tTYQlbLmKmfowfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrJPl2YjUzyV9aONHgVPor8y2N6Hnau25dph4TQQBlM=;
 b=OD1/VE3a8B2CAydJEFwK4nAV1y6lKxZWcnohnRTh4mJej+yaOBzkF9h5T9FAlD07GscQ/xPq3YNQIq9j72RUXi7UV+avX4U1VOzx/sYvocSrCvX/pJeC1XRJjHqnODbXlop/MC6Fi6OGktlmjWFAkS7axSPTSBu7C/uq9yyWijOFwd0DG85+k/eDkzBX38BNzYJJhH5dx5D8PFAOa3ppV/e/CGoRzxo63XB02HcgmG0R7THHe8cVIASmCWvl7GuhwLGCosjTGTWUrmLLW5g/Nk5mI5yrVJie/cb9oOg/pDN/5Xnoi+giQKFIyXPLlfBv0kawBRmqhVFY9y5zTVmWlw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7451.namprd02.prod.outlook.com (2603:10b6:806:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 19:29:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 19:29:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>
CC: "anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Thread-Topic: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Thread-Index: AQHcPSm8o+gOyOR+00uJ8u6QFjaVJbTFIVIg
Date: Thu, 16 Oct 2025 19:29:06 +0000
Message-ID:
 <SN6PR02MB4157FBBE5B77C65B024D3589D4E9A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251014164150.6935-1-prapal@linux.microsoft.com>
 <20251014164150.6935-3-prapal@linux.microsoft.com>
In-Reply-To: <20251014164150.6935-3-prapal@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7451:EE_
x-ms-office365-filtering-correlation-id: 64747f49-57e0-415e-3ec1-08de0cea458e
x-ms-exchange-slblob-mailprops:
 rYPt1fhvLTUem4+YyY73AGh/GMpkrRb3fxIHETpLWiiA9aaud9toBOJrr6qr6agUJNpRwlsnGgkNyhhOd0dVud0jRBgeeNsAmCdnDS6N6sDe1WtOl8vEd3RYc0SKmrDhn3jhWQbB9llvPSMlLmQGGl2VisWNpVvD/Klq1gPqmJRN9lkuS5W4Lrh7CkDtWsejf5C2TsBl64j7c7uvygGrgFCTBjXMmNG9cAzGqmMVBXkyy/ubMVSVOuRNhX0DDDkTOKvJTSGrjDkhQsh7Ah16RWFL2AV6gtAFUcrRj5f32TSZ3cGML3Wlk8+nhTXkSEX9U30rD9cDdXcyz0Jm0Ysghp8Qq+LMKh9Nd7mg86Do0LYgUgA5PN+ocX3OXf4qPR24y98pdtI9W40RSRDXSjmVoMw2TgwHoyYBfIYh8I0D/4u3bqmu2mwQzyyCjgMjxi4A4Z8aD4XEWZ5EpOwWiAOh2B1W3pZaQMBypp7By5DjZMQdfuOqFaGeZBKj5vTtLVx1Y6vmSSpr54r0yUHBpRlZwcPh+kRTEKWMjgRinmZu45xK0mGaUiEEq1r26Q0BBtimbamGTLV1eULyIl3M8EX1VH5P35Xh3HF2z2cvdm2DMwpfO1I487Xyu5YYzQAHd85TxJ91MNsxGyItjYqsFSU1Puj8IGlec2jZHLcWSNEapxXUXzTacwg8zZjYWIZjA2o1LkXFFssYmq8g3JjWycTdFQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|19110799012|41001999006|13091999003|8062599012|8060799015|15080799012|31061999003|461199028|40105399003|51005399003|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CIDfzRMu2IKFmwCFsdjeuEp1L+e5FhN1BHx1iBlY3hs52FRjRmp+rztoPCGZ?=
 =?us-ascii?Q?qcDDxR8FK8fARTvrzyb/auEGDa2V7FElZkASCWek32kcJmAOWgEs2T435Fbh?=
 =?us-ascii?Q?jPJXt+WCDAduUUCkxHvVA7nQwtj/D4luL5iLGhryFzVjnoW8QFHVvDs/rL5S?=
 =?us-ascii?Q?+ExBjJ8fPHUHXWyd2MGJny/8TzHPVcuYtUbRzwfwb4Xt7NmtutIMduNJN+dT?=
 =?us-ascii?Q?rGiaAlCNC5uToWWWsERqBx+whqwxwREOCTCLtYNxRWdVEOR45nfMrdnQT8SN?=
 =?us-ascii?Q?JhhDKtkAkdKdUmyh/i9ezWNTruHE+wU5Z37LDdbaYt4U+Hu0xOPVigv6cXmX?=
 =?us-ascii?Q?6uaEAl12HonoxqzH2H36xRUR+wL0XJ33L0DxcnjrMK7rE2KchOYlngAphjpn?=
 =?us-ascii?Q?hSX8WcwVL/0C8MwFaTc8YbGnwGdxF3O3P+1LxMonkG8U3/6S0rTwz6tiiela?=
 =?us-ascii?Q?qHtXIvXspRJBo6is4vaT/G//W9hDj47sAaSj6qmAFFavqv60L8vNTwoaNhCl?=
 =?us-ascii?Q?HyEXS9uaXOibsaX/HoGINsOEowYV6ciFO4tWJmzgQhNwuTmkDvkfDDVpxVvs?=
 =?us-ascii?Q?lAqFjjFaZfsVLlH/o/E74lpkQORPXSTxTsmh5VeU/Gt+AxasUnGf3/c+S+Wd?=
 =?us-ascii?Q?2M99/quVf9SB7QPR6K6lcZrpiEFRIG2/lTFqpgP6odiBCrwtQKv+11n3lC9U?=
 =?us-ascii?Q?Qpr7R0aS/7s+rXQbj+7j6TVkChhZCNfW0KNNERNJ8X/2pXJdDGCKbfuSlD1W?=
 =?us-ascii?Q?UCzumQe4rJaPzcrrWyvUdEEdWPAf+w/qUb2Ippx7S627+uFBl1g4XncBaLpE?=
 =?us-ascii?Q?yy9/YDPw/5fVA8VBKXftR1xtmYFGvDHw0ETr3JQ90cfIwTs3f+Wm+NKk/dBa?=
 =?us-ascii?Q?cAi3Gp0K7zAOtjYBgsMonrYOSmrDOLg7PPKzwySHTJnZrQD/9FvlEt+N9Rv+?=
 =?us-ascii?Q?P2vGcjXR57efjGta3wNj9QjEbJsNLk2IbW4vOMR+FsA1yBqOI1QCGwQ8ldoG?=
 =?us-ascii?Q?pLonb9VBdELnA1qfSccCfnITk+ZfXQLrzxoh7JxaIlOJZC8CVKrJcGyGXh1P?=
 =?us-ascii?Q?l3icT9P2NrKTiSWKmIHrAGYaqH6Vs8Yugj10CO3KZcRPy3HmirqkEiGQDm9t?=
 =?us-ascii?Q?sqYm0UmDBCgo5K5OSh3i2BpZogn9G+BJ7fpCu2JBwz0rg14JqSTGFJ2BjP+l?=
 =?us-ascii?Q?ZbcYA70B7/OtDDxRvUwJY3PxdJv/yv83I6mBQhGF7+fnHxGsxx7pFekqVic8?=
 =?us-ascii?Q?Is2ddzqH6SCNw2zBs4Qv5imFMcssPl9zd5egih79f2Mluh8joNRDJfqOck/4?=
 =?us-ascii?Q?ARi0YbotB+GYsjqwAVh8g0qK?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1paCUfzyffH4Lh/34eUwV2fK3/07VNA2q9yt/8OpXpgHrqCKmV/21W8uDrXe?=
 =?us-ascii?Q?xVMz+VgmYxYbSa3NlhTWFS+sfuAiv4ZiUKk0HjMFeigmQ/1BbKplD7CIlV4r?=
 =?us-ascii?Q?gC22NhARNwr+P5WIjAqvagnHN1pS1Hyg3RuiDTDZQq+woT4vN6kb2KAE0/67?=
 =?us-ascii?Q?W0WuVBCc4VxG0fDm49pOa9FdAvkChu3w5z6ZiAZCym8yDAJqxrbAsBBQaOgz?=
 =?us-ascii?Q?7e8kY2esAS+aJAJeldBQGN77WWkKgyodFV+Qtxv+FK7m+gFcb6XeV7NtRp7P?=
 =?us-ascii?Q?wcu1xTeDiUoHQxyNKz+zDpTuga2E15QUF/StePphF4NXxUCqgQ++V352bFSX?=
 =?us-ascii?Q?XKo1bdsYDhwZwxE7yf9JbGeQ40TFtrpwmXsKPL24O4nwOBOj4kHGH9+5Yeog?=
 =?us-ascii?Q?Hm/bWcra6HLfiIPMeej7SYYXxAOtEBrcFkck3lHV+LnwwkVb8nxMT8HgeVh8?=
 =?us-ascii?Q?CQ9X48Jfz0jXY5wHRFbPU/cZaU7H82svhW8vhPO9UC12M+kNL0tS3vPNYyHM?=
 =?us-ascii?Q?sbJZADjB8xgXzfeyz1/zdju2LnjxZkOds9NQglVLWcFiKvhnGjGzWA390Kv6?=
 =?us-ascii?Q?brVElD54UmDg9NP29995sAmDlLcOfyQYqLCjyfp/KkaNPhwED8k9Im5JC7d9?=
 =?us-ascii?Q?Kqf8BDN3qa6u+JZyuonMt4ROW+ee92drVCP0IBODcFHjMMOb6zvGRxw9bxax?=
 =?us-ascii?Q?OxOqovCHRgRZ/bFoxAUwwBNkRNIpu2ojVaq6L03x030V0HyV/ehoyGmwFQTZ?=
 =?us-ascii?Q?Mw3PGrgkshUSNcPP5ZBuxSRGfYTKvqDSDUyUAwlKErTJMvLD4SNaQU3sCqng?=
 =?us-ascii?Q?FE3rbveS5uuiDePzhO6ysjD8oWu8KKbPL4AiT6hfmtidDeIP1V8bL3x4gh8f?=
 =?us-ascii?Q?qjBL3/4rz/XjgxWFqWRxvhLWHND62zQiTBFBewOwrVA2jJa1zpEirEOqJm59?=
 =?us-ascii?Q?eJoDebviC0XZWGs8oErJmNpq5a/nE3PIlXqs+Q3/U95AaillgQilHkn19liE?=
 =?us-ascii?Q?CPGyrn5WAxWoOoE9oauLtaJmUyi/y0nDMHF6F8Rr9Cw/p3Y8A6NS7i63OCXO?=
 =?us-ascii?Q?ZLz0t6LVcA2hA16FU2rl0TlKXjepvDrapgrysrYiVG9JOUItCtkySG5fukLa?=
 =?us-ascii?Q?5unzLL7/dyxrsEiTgIKhi4c4ZZek+swuPaFSUz/Isz8fm1ipLNCEhM3mJ/R7?=
 =?us-ascii?Q?Tqpp8BWvzDM1/H58+xxgTLKJG86myNzz3uh2QLjVBbUrsovV2RNMPdbelII?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64747f49-57e0-415e-3ec1-08de0cea458e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 19:29:06.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7451

From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Tuesday, Octobe=
r 14, 2025 9:41 AM
>=20
> When a shutdown is initiated in the root partition without configuring
> sleep states, the call to `hv_call_enter_sleep_state` fails. In such case=
s
> the root falls back to using legacy ACPI mechanisms to poweroff. This cal=
l
> is intercepted by MSHV and will result in a Machine Check Exception (MCE)=
.
>=20
> Root panics with a trace similar to:
>=20
> [   81.306348] reboot: Power down
> [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 B=
ank 0: b2000000c0060001
> [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea=
9
> [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 S=
OCKET 0 APIC 0 microcode ffffffff
> [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --asc=
ii'
> [   81.314716] mce: [Hardware Error]: Machine check: Processor context co=
rrupt
> [   81.314717] Kernel panic - not syncing: Fatal machine check
>=20
> To prevent this, properly configure sleep states within MSHV, allowing
> the root partition to shut down cleanly without triggering a panic.
>=20
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |   7 ++
>  arch/x86/include/asm/mshyperv.h |   1 +
>  drivers/hv/hv_common.c          | 119 ++++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index afdbda2dd7b7..57bd96671ead 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -510,6 +510,13 @@ void __init hyperv_init(void)
>  		memunmap(src);
>=20
>  		hv_remap_tsc_clocksource();
> +		/*
> +		 * The notifier registration might fail at various hops.
> +		 * Corresponding error messages will land in dmesg. There is
> +		 * otherwise nothing that can be specifically done to handle
> +		 * failures here.
> +		 */
> +		(void)hv_sleep_notifiers_register();
>  	} else {
>  		hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_p=
g);
>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index abc4659f5809..fb8d691193df 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -236,6 +236,7 @@ int hyperv_fill_flush_guest_mapping_list(
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
>  bool hv_vcpu_is_preempted(int vcpu);
> +int hv_sleep_notifiers_register(void);
>  #else
>  static inline void hv_apic_init(void) {}
>  #endif
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index e109a620c83f..cfba9ded7bcb 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -837,3 +837,122 @@ const char *hv_result_to_string(u64 status)
>  	return "Unknown";
>  }
>  EXPORT_SYMBOL_GPL(hv_result_to_string);
> +
> +#if IS_ENABLED(CONFIG_ACPI)
> +/*
> + * Corresponding sleep states have to be initialized in order for a subs=
equent
> + * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as =
per
> + * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be suppor=
ted.
> + *
> + * ACPI should be initialized and should support S5 sleep state when thi=
s method
> + * is called, so that it can extract correct PM values and pass them to =
hv.
> + */
> +static int hv_initialize_sleep_states(void)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_set_system_property *in;
> +	acpi_status acpi_status;
> +	u8 sleep_type_a, sleep_type_b;
> +
> +	if (!acpi_sleep_state_supported(ACPI_STATE_S5)) {
> +		pr_err("%s: S5 sleep state not supported.\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	acpi_status =3D acpi_get_sleep_type_data(ACPI_STATE_S5,
> +						&sleep_type_a, &sleep_type_b);
> +	if (ACPI_FAILURE(acpi_status))
> +		return -ENODEV;
> +
> +	local_irq_save(flags);
> +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(in, 0, sizeof(*in));
> +
> +	in->property_id =3D HV_SYSTEM_PROPERTY_SLEEP_STATE;
> +	in->set_sleep_state_info.sleep_state =3D HV_SLEEP_STATE_S5;
> +	in->set_sleep_state_info.pm1a_slp_typ =3D sleep_type_a;
> +	in->set_sleep_state_info.pm1b_slp_typ =3D sleep_type_b;
> +
> +	status =3D hv_do_hypercall(HVCALL_SET_SYSTEM_PROPERTY, in, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "\n");
> +		return hv_result_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> +
> +static int hv_call_enter_sleep_state(u32 sleep_state)
> +{
> +	u64 status;
> +	int ret;
> +	unsigned long flags;
> +	struct hv_input_enter_sleep_state *in;
> +
> +	ret =3D hv_initialize_sleep_states();
> +	if (ret)
> +		return ret;
> +
> +	local_irq_save(flags);
> +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	in->sleep_state =3D sleep_state;
> +
> +	status =3D hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);

If this hypercall succeeds, does the root partition (which is the caller) g=
o
to sleep in S5, such that the hypercall never returns? If that's not the ca=
se,
what is the behavior of this hypercall?

> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "\n");
> +		return hv_result_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> +
> +static int hv_reboot_notifier_handler(struct notifier_block *this,
> +				      unsigned long code, void *another)
> +{
> +	int ret =3D 0;
> +
> +	if (code =3D=3D SYS_HALT || code =3D=3D SYS_POWER_OFF)
> +		ret =3D hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);

If hv_call_enter_sleep_state() never returns, here's an issue. There may be
multiple entries on the reboot notifier chain. For example,
mshv_root_partition_init() puts an entry on the reboot notifier chain. At
reboot time, the entries are executed in some order, with the expectation
that all entries will be executed prior to the reboot actually happening. B=
ut
if this hypercall never returns, some entries may never be executed.

Notifier chains support a notion of priority to control the order in
which they are executed, but that priority isn't set in hv_reboot_notifier
below, or in mshv_reboot_nb. And most other reboot notifiers throughout
Linux appear to not set it. So the ordering is unspecified, and having
this notifier never return may be problematic.

> +
> +	return ret ? NOTIFY_DONE : NOTIFY_OK;
> +}
> +
> +static struct notifier_block hv_reboot_notifier =3D {
> +	.notifier_call  =3D hv_reboot_notifier_handler,
> +};
> +
> +static int hv_acpi_sleep_handler(u8 sleep_state, u32 pm1a_cnt, u32 pm1b_=
cnt)
> +{
> +	int ret =3D 0;
> +
> +	if (sleep_state =3D=3D ACPI_STATE_S5)
> +		ret =3D hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
> +
> +	return ret =3D=3D 0 ? 1 : -1;
> +}
> +
> +static int hv_acpi_extended_sleep_handler(u8 sleep_state, u32 val_a, u32=
 val_b)
> +{
> +	return hv_acpi_sleep_handler(sleep_state, val_a, val_b);
> +}

Is this function needed? The function signature is identical to hv_acpi_sle=
ep_handler().
So it seems like acpi_os_set_prepare_extended_sleep() could just use
hv_acpi_sleep_handler() directly.

> +
> +int hv_sleep_notifiers_register(void)
> +{
> +	int ret;
> +
> +	acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
> +	acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);

I'm not clear on why these handlers are set. If the hv_reboot_notifier is
called, are these ACPI handlers ever called? Or are these to catch any case=
s
where the hv_reboot_notifier is somehow bypassed? Or maybe I'm just
not understanding something .... :-)

> +
> +	ret =3D register_reboot_notifier(&hv_reboot_notifier);
> +	if (ret)
> +		pr_err("%s: cannot register reboot notifier %d\n",
> +			__func__, ret);
> +
> +	return ret;
> +}
> +#endif

I'm wondering if all this code belongs in hv_common.c, since it is only nee=
ded
for Linux in the root partition. Couldn't it go in mshv_common.c? It would =
still
be built-in code (i.e., not in a loadable module), but only if CONFIG_MSHV_=
ROOT
is set.

Michael

> --
> 2.51.0
>=20


