Return-Path: <linux-hyperv+bounces-8575-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOe6E31hemk75gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8575-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 20:20:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7EFA81DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 20:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16CFE3030EA5
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A943536E47F;
	Wed, 28 Jan 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oC2lwDSN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010021.outbound.protection.outlook.com [52.103.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7FA2D9EDC;
	Wed, 28 Jan 2026 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628014; cv=fail; b=o3VIL9iuZ1lZOvdNLAazbVltzF/LCEjXbYItoVyqvmZYoI+Db5ZGnmh2zAderykbZr4OqeOcAmsoEZ1vZgpuA+Sfe8BCtvaNzbrVlZWuV5y2jndsun9w5njronkbLnh9KAIy2d15FVC3vHuyygMx216ixoQ6ZzEonUvdx7M/t4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628014; c=relaxed/simple;
	bh=6MIB2WmG5a+NkHb4HiJ+SxeDMcwbkkIDb77Ud7bFamQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KdkZPSC/sHQdwop0zmQUBjeabLfAPFqaoolBVjuJobIEY/nBUa+fFgWpdsWhgugjHZ+DSW7AQWv6dLru34Ov/jBocxgIUgj1tvs/OAQ1oqBfkaFTihADpya7BNbawkN8aHZ+dSr5xe7ZVj9EuoPbyJSc68eDvUHPSVb2ntyH8Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oC2lwDSN; arc=fail smtp.client-ip=52.103.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ouqed5ry4SrAfEpA4V7dWKuyukMm+u+3seurSOauD73PmqXThv+XEVm4Zx8Py7BnPcBSbk3Pt+vc49+iPqYdiExxnsJnr8KF4lf8/N/MthO0WHhu0YymK3iHcY4VsaiKHKYNlScgOdB43vqKPpTNa/BODdQxY/z7M7ThfgxZOidOv8mJmGIgbTamOZ3o7U4P45SqmSdGAGY6tYoJsbyci+rlN/gUvKbQw3G2Mof+Hf+aFracc9dMyu7nviWuSwP+U2/F1yMYG4aSiwMYWSU+iOCxORsg2QD6xgLbzXAVhgcoeeSelbH0Y8oZL33hstzvwjb71dP2TNhDRwK1wtb3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOJOnapXKRbI3FycG3AIdHKz24Y+RrhPt5t0QVCCNTE=;
 b=DqqnW53GyIAZKfOH/VZ0DaPWggqwan+1yf8llrXGz7Aqa6m6e7eU2Tq6YNS5fa7Ijx5Q9es3DseFZi5vp3UlErGmrWAvCYN7RzmEpYCnXWRduTlGUTEaY4xF211mW+ycLGjw4qusFT8PyY5dwuQ5xs0w6l8sJ+KP8GUzeEwRDrQhk6XGH8QgNrRMEjo3Z5MVRPGEzSZFMYyQ8d5mPOQM+XgEmaftN1gc+CQHTj2nTW0Zbua/MYirdrrF+7kvNtOwDwrj4jDShYfHt/kq35ntFDN5d1YtRPnFXMRfwp1fYk3U+9/N/ELGfMbeX0rg3R115md7AhWgm1kDqtVZmPW33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOJOnapXKRbI3FycG3AIdHKz24Y+RrhPt5t0QVCCNTE=;
 b=oC2lwDSN1h9zHtTvyf0d5Hx+UasA8xkPu2DGMHeGkktLeDih8K4NqP4NY0wRJNmL0VDE451FawGZYno6299UPaJ0OvjY34sh25BBUtzHlbqbP5VGROEwLBMxOyKxrUWU0Py6Io7dlggF/SlQzF/rSpSL0sf9sh0sBFk5m3lAaPGjKU7eG6z5oxTDGTYmQ/RMz62k86vl/7ANzwN08s+VrIemD24cawQR3hXd9PpUhybskeAIDVlPL4+ZGDEsLtCHF2sqBSEc9I48uVfmFE8wsHwQksSiD6Vx+nDvcKk13USKq7+UnVHxZNYARp9tzrYNJltIUTBq7PGczF0Mmst/WQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8728.namprd02.prod.outlook.com (2603:10b6:806:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 19:20:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 19:20:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v6 0/7] mshv: Debugfs interface for mshv_root
Thread-Topic: [PATCH v6 0/7] mshv: Debugfs interface for mshv_root
Thread-Index: AQHckIGS0PKjuGa7rEuZsJjqXKz60rVn9OaQ
Date: Wed, 28 Jan 2026 19:20:10 +0000
Message-ID:
 <SN6PR02MB4157774303E3E31251C6804AD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260128181146.517708-1-nunodasneves@linux.microsoft.com>
In-Reply-To: <20260128181146.517708-1-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8728:EE_
x-ms-office365-filtering-correlation-id: 1650f32b-18f0-4aff-28c7-08de5ea24175
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/ddKIhkiwYV/V9rzSeWQ5wt7F2mn/7P7JSMHOx97MZvyeE1VnuCy/vS5UxBKAek8qEHn+oLAKASqcifEnE954lgNkLyiX81xwxITVzzA1UV1ourMWVN0WArA/AizwxmyuEFmki+sW3fGIqdz7L+/4T9xo+Hl6YbjqSV26aFWm2WmJSr24HpXH9uG91HwMO/wChjHCBuyqmD/JZL/HrTTFkxwuB8CcJcAZ99JgR4e/b2xx6rnCBtx6ACN6wZJ1zM5u6xcmWnOboZ8Ph6rFm1E1p+VYKn2QYYRBDIK4eo9rDXsaiTCdei61HHUrsbWw/tHS2Xlc6Z8x2ayJgxWlBt6OMu3N/yXy3ibd5/9/8MQCuAlZ+ttJqphqkcv8f1gUDlrUQsVmKcdVcMhfXfS5FfJhpIKJm1w3aMGipDo4CDqZleAkOQuBAjrWFdKJlp8XcSdGmvXivS6k+lkDefMGJKJfwOCI8nGgqxGRqCG8rTRew73Cpbrv0/N0DyJUtOmQZswVR8iB99Pw2d7s9dDgxFp5AWQaGb4ckkvPSkCWH/NFfvwFq/AXCg1Yvk9J44Qj/dEXn4Id5sdhC+Ngy4xV1aRh91GoTUkGwKPOqTlsdnu/fuxlEiFZqHhKPxpY0gsVf6UiZVcr4pdSzVHMwCed1ALFZYG7YmBZsL2lvl8+F8ceZTIE+W0pYaFIVB8sBqjjoKsxGlnSsNXtjFWQANxFGu0hb025jBjwuixj37zdPAaAfxY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|13091999003|15080799012|19110799012|461199028|51005399006|8062599012|8060799015|41001999006|40105399003|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e4D7ZbeetxfuogKwmIyi+l9+7SSNpbNiqE6yN1EfpUjM6v9duXaBZN4gtgLK?=
 =?us-ascii?Q?NcujFqXuSNF6rtX0sxZ73wylmTqHf1ABxTnfcwL0m8XLYP6a760H5G+CJfOh?=
 =?us-ascii?Q?ohquJfH1RSyh7U8fKHwpxlE2oBwC8hZcNVTv5fQ/LLMVgWVB6vKiBlrPeuql?=
 =?us-ascii?Q?wibhaL3kQ+jzAjr0gQfXa3eV4eJz/63/P3Te6QAhtlscJ/+8gxrFSICYBKVC?=
 =?us-ascii?Q?BZpACG+sTDV8XPrtU4Aa4JbHmuGC9soNbBjZkDf8ivDSHmiEVC8drPFEhzZC?=
 =?us-ascii?Q?L6E293PlqaFwHxHZJbVCCse9OSqIVVYQ/CwJ78MegG+CGJzI3HzzGXuKw+Yh?=
 =?us-ascii?Q?lgNo2jTg+5lS266bhjQrLcKPDZyDP6Sgqp5XTZqdYFz3Kjpo9OKa/B4FkX7d?=
 =?us-ascii?Q?j4ei7IZRf0qR/nQ9+lSkjuHQu7BOP6/l2/OmDJ8vwZjk26tyYy/2GXwgcANw?=
 =?us-ascii?Q?f/sTqrgoXIbRiwFgBHgIzNqied4o4Mg/9a4CAjQz8G7QS9QUynMGZjmwK8Kr?=
 =?us-ascii?Q?pRwVB3ULen+pPaMLZZeci5uBdW0gWC6fC8KOop2q4CCNZcGczfyqPc7fQ+rC?=
 =?us-ascii?Q?8Ge30+R8CgsYJjE0NSBITiIa53vayT0dIdKlqCaW37bviprQKJNEoPLvdeVW?=
 =?us-ascii?Q?X6NDoYWoZWFE1LVoki1hVGyHlWJDC9/otkaaq6xt8cnOqyn/NhfKsvuiCEBU?=
 =?us-ascii?Q?q+t0mWwJRaiF1BNojAQqlOmFEXqVDrfHUqppuH73hAIe49ZQdIyq3xwGtnnX?=
 =?us-ascii?Q?hgqDu96hgdZZ/3d+ukKGAKWLmmA0FmixjFApmgcK61qujdRSEUHxgTZBi520?=
 =?us-ascii?Q?76EKqOC1eF2BRM1CaCwPeUIhRDryr7KRmESSZ25CeZTexCozqXWgNdyGyD+y?=
 =?us-ascii?Q?G15Xy7N4J7F3UwCJ7Shz6QH/gBYncutFQ9lzGXeEzeyas/c3FrCuacxcDVbJ?=
 =?us-ascii?Q?keA3QqRLwLP8rPwujmS47ebfsqlS88oAoj/5mKjY6QwjPZeOItnNv8cRl+rD?=
 =?us-ascii?Q?Hb6DaBHvDgBjaaDbzCnn7T4R+5y5OpZ8Ju0RV9YIbxP3s5FAFzA6a2btw256?=
 =?us-ascii?Q?F5Xvu1few7sQlRrdCnITc44IITnDs0HrNPpi1g5YYtfjgBceGsHP8oZs1FD8?=
 =?us-ascii?Q?9YOWZQXLFvzXuDHQyz7dlOZzT745quZPNEO4mu/KYF+p11XftEqxJjGtt3jH?=
 =?us-ascii?Q?D0qeXOQfk0OfiC+EPpQ/0snBkdtcGkRsJE6dPwA2LIKgOE2MQmT+3vQnz8aq?=
 =?us-ascii?Q?5RnNMsI4GRYlMDZSntaF+dbaSkxGIBlJNQVMWLcmoQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tu3mttgyR1LLafdUXhsK5X7SmReH2UwJtOX+Iahs5ccRjaG4cPEUEolVHlmN?=
 =?us-ascii?Q?DoyxkXpCS9Bd3vHnF0epMfAHGuGDulpG4JFpYdoR4ZEsDO7i/SsAZD9Tqvfx?=
 =?us-ascii?Q?NptIO4aRkDWucZ0iCEUMbZNWNZ8g9wZ10mJtjL4SuHxqohLvfkAbAQ0pSW6K?=
 =?us-ascii?Q?/Uu0vD/UPKRfW2nkfFTv8AWta5wpd7Skhx1hKfPmCd+fGxWt2UzjJZM4pCjc?=
 =?us-ascii?Q?ocRdsDZKH6EeCelDwc332Mhee9bLbgx7xq7t+NoA7OvoqEVqAOOJGajNFv8N?=
 =?us-ascii?Q?4qgoR+NaAi1ubBmi1OJv6fQs/dtG1iPRwen+bdK+a3HslMYmNEB/lpobTk09?=
 =?us-ascii?Q?uocvHZbfkQwwzpOhq+toX+uYtW7/S7joEuOxU12ZdomwSaNY+2r5gfLCSRlt?=
 =?us-ascii?Q?pcT18V5D7M+4YEyOTvqpFV5VJT93RbtY8H1B7FVthabgd0T2ibe+AAqeGaeS?=
 =?us-ascii?Q?EBxp56NKcmh/ccjnhnnxHJ5myBxfWfLiPvoG37sMRDUhshjCLCcwahUj3nXf?=
 =?us-ascii?Q?eNmZQnKG7kmLeZkKM8dybHZJGQWSNxe4u42AxJXUACO37kD1pCdgvduPn02Y?=
 =?us-ascii?Q?Pg+5ELmckQXSneSBzmDsnr9p2dLQ+sUgZ3oxDbzb9yvz0KtrZNukeh0r3ALD?=
 =?us-ascii?Q?HmWW4lcuahSvj9PChbEwpWFDPQEUG/6+A216aivznwRD0+ogeJgpnL4uhV5O?=
 =?us-ascii?Q?sYJkyYFlMNBm5WJ690iOM3GqLPOkbTvVtjQRxYyglLGUDbocjQr4iQHwn12U?=
 =?us-ascii?Q?3wGKvFV6hu1RmS84DnuJ76BEJxecVIN0JKoypNsV4Qqi/goB3XfIr576bBQ5?=
 =?us-ascii?Q?tD5N0ogeU5ZnWIgt5fmn5s2Y2wMqoz5yHHFRU4SP3Wkfa3fY9XREdIcNZQi/?=
 =?us-ascii?Q?oYImiDO4SzuwRcT1rdRup2yUyp45ad31myvs9fspsup4aMPA6Nn9RY1Rhq77?=
 =?us-ascii?Q?kvKjupAXONh5VjWU8ApyqZVOFeqCv0VFdCEZO9mDwNKBbxGLf1yJc4NRNwlI?=
 =?us-ascii?Q?5qZOtGB5vR2hMJwpHNv5O/BIhHyhIbZhsNurQJ8llLPPrepeomrg+X85qNlB?=
 =?us-ascii?Q?fWOtjgxd8hOPzxbph8P3iDeBIEa8E/62vFGlZOxaX968rx7agKHjNBmVIzDn?=
 =?us-ascii?Q?k11956axX5yNtdGynbsxydOS6TweHG9VJTe28MURIVNEUaPgrZuzIBQ4JbmO?=
 =?us-ascii?Q?nQ6e8hv8KmBXv8vp/pXk0qw1CKNmZ0fWTQEMw/j1fkSR1p9nLG1gFqhoUZpn?=
 =?us-ascii?Q?K+1tP0GsADO3FX5fIG9kL9964KA5e/qQQuh8KblX5akqcbeaEEFgxeaj1QKs?=
 =?us-ascii?Q?HXw1w2G4yiJ9JIZ3fGysodDzbwLHXMONfKsKYK5xlHR2QNEeZfila6ru+ymf?=
 =?us-ascii?Q?L6mNssw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1650f32b-18f0-4aff-28c7-08de5ea24175
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 19:20:10.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8728
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8575-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: AF7EFA81DF
X-Rspamd-Action: no action

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Ja=
nuary 28, 2026 10:12 AM
>=20
> Expose hypervisor, logical processor, partition, and virtual processor
> statistics via debugfs. These are provided by mapping 'stats' pages via
> hypercall.
>=20
> Patch #1: Update hv_call_map_stats_page() to return success when
>           HV_STATS_AREA_PARENT is unavailable, which is the case on some
>           hypervisor versions, where it can fall back to HV_STATS_AREA_SE=
LF
> Patch #2: Use struct hv_stats_page pointers instead of void *
> Patch #3: Make mshv_vp_stats_map/unmap() more flexible to use with debugf=
s
>           code
> Patch #4: Always map vp stats page regardless of scheduler, to reuse in
>           debugfs
> Patch #5: Change to hv_stats_page definition and
>           VpRootDispatchThreadBlocked
> Patch #6: Introduce the definitions needed for the various stats pages
> Patch #7: Add mshv_debugfs.c, and integrate it with the mshv_root driver =
to
>           expose the partition and VP stats.
>=20
> ---
> Changes in v6:
> - Fix whitespace and other checkpatch issues [Michael]
>=20
> Changes in v5:
> - Rename hv_counters.c to mshv_debugfs_counters.c [Michael]
> - Clarify unusual inclusion of mshv_debugfs_counters.c with comment. Afte=
r
>   discussion it is still included directly to keep things simple. Includi=
ng
>   arrays with unspecified size via a header means sizeof() cannot be used=
 on
>   the array.
> - Error if mshv_debugfs_counters.c is included elsewhere than mshv_debugf=
s.c
> - Use array index as stats page index to save space [Stanislav]
> - Enforce HV_STATS_AREA_PARENT and SELF fit in NUM_STATS_AREAS with
>   static_assert and clarify with comment [Michael]
> - Return to using lp count from hv stats page for mshv_lps_count [Michael=
]
> - Use nr_cpu_ids instead of num_possible_cpus() [Michael]
> - Set mshv_lps_stats[idx] and the array itself to NULL on unmap and clean=
up
>   [Michael]
> - Rename HvLogicalProcessors and VpRootDispatchThreadBlocked to Linux sty=
le
> - Translate Linux cpu index to vp index via hv_vp_index on partition dest=
roy
>   [Michael]
> - Minor formatting cleanups [Michael]
>=20
> Changes in v4:
> - Put the counters definitions in static arrays in hv_counters.c, instead=
 of
>   as enums in hvhdk.h [Michael]
> - Due to the above, add an additional patch (#5) to simplify hv_stats_pag=
e,
>   and retain the enum definition at the top of mshv_root_main.c for use w=
ith
>   VpRootDispatchThreadBlocked. That is the only remaining use of the coun=
ter
>   enum.
> - Due to the above, use num_present_cpus() as the number of LPs to map st=
ats
>   pages for - this number shouldn't change at runtime because the hypervi=
sor
>   doesn't support hotplug for root partition.
>=20
> Changes in v3:
> - Add 3 small refactor/cleanup patches (patches 2,3,4) from Stanislav. Th=
ese
>   simplify some of the debugfs code, and fix issues with mapping VP stats=
 on
>   L1VH.
> - Fix cleanup of parent stats dentries on module removal (via squashing s=
ome
>   internal patches into patch #6) [Praveen]
> - Remove unused goto label [Stanislav, kernel bot]
> - Use struct hv_stats_page * instead of void * in mshv_debugfs.c [Stanisl=
av]
> - Remove some redundant variables [Stanislav]
> - Rename debugfs dentry fields for brevity [Stanislav]
> - Use ERR_CAST() for the dentry error pointer returned from
>   lp_debugfs_stats_create() [Stanislav]
> - Fix leak of pages allocated for lp stats mappings by storing them in an=
 array
>   [Michael]
> - Add comments to clarify PARENT vs SELF usage and edge cases [Michael]
> - Add VpLoadAvg for x86 and print the stat [Michael]
> - Add NUM_STATS_AREAS for array sizing in mshv_debugfs.c [Michael]
>=20
> Changes in v2:
> - Remove unnecessary pr_debug_once() in patch 1 [Stanislav Kinsburskii]
> - CONFIG_X86 -> CONFIG_X86_64 in patch 2 [Stanislav Kinsburskii]
>=20
> ---
> Nuno Das Neves (3):
>   mshv: Update hv_stats_page definitions
>   mshv: Add data for printing stats page counters
>   mshv: Add debugfs to view hypervisor statistics
>=20
> Purna Pavan Chandra Aekkaladevi (1):
>   mshv: Ignore second stats page map result failure
>=20
> Stanislav Kinsburskii (3):
>   mshv: Use typed hv_stats_page pointers
>   mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
>   mshv: Always map child vp stats pages regardless of scheduler type
>=20
>  drivers/hv/Makefile                |   1 +
>  drivers/hv/mshv_debugfs.c          | 726 +++++++++++++++++++++++++++++
>  drivers/hv/mshv_debugfs_counters.c | 490 +++++++++++++++++++
>  drivers/hv/mshv_root.h             |  49 +-
>  drivers/hv/mshv_root_hv_call.c     |  64 ++-
>  drivers/hv/mshv_root_main.c        | 140 +++---
>  include/hyperv/hvhdk.h             |   7 +
>  7 files changed, 1412 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/hv/mshv_debugfs.c
>  create mode 100644 drivers/hv/mshv_debugfs_counters.c
>=20
> --
> 2.34.1

Everything looks good to me.

For the entire series,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>


