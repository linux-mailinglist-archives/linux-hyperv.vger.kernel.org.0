Return-Path: <linux-hyperv+bounces-8783-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBjNKczDjGkmswAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8783-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 19:00:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09642126C3A
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 19:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6053C3004D37
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661C219E8D;
	Wed, 11 Feb 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="THe4PJ6a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011033.outbound.protection.outlook.com [52.103.13.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E3A932;
	Wed, 11 Feb 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832834; cv=fail; b=Dewhi1e5S9LwpxkJrwAAK0fFJcxi507fyFl44WI74OfJbDnKVppgmLYG6ojkp4/AZKCn59Ejqb6jGHAkTy0dmAhnLfhvNSp+08F24N6vjV4O+PUljpaJlf3T31UZbb3lQaHIq9CjzwhsK4b0cbAc5CPncjnFTSPq5priMFqF0Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832834; c=relaxed/simple;
	bh=EbBujHAsxw8E+TVhWbG+ZJpo+ZkOneN0EktI4AJuxw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AuGko5F82OAnK54daS6bQ9eUfPse5+z65v2fbgOgpJq1KsqdDuckDHd8sTu+A3pFDrEkZcEbXGezmNktywSS1ahu7n3yTFLDH3YsfpqPshf+e+6hTifM/6PjFT01ERKBtSxOPR0yDpIosa6MnvNPTyLq/uq1hJefCaeoQvVzoG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=THe4PJ6a; arc=fail smtp.client-ip=52.103.13.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J56sfZ9FK+qSHxAvWUMo/oBRGeYPo0ICL5Usb5xPO3JgQejsgbXe2zMgA2fmDNOYLSc16P2C0M9oe1KZAJk/WvVWcbgZaWgzYb2r3hvUGLe0MG3XJlpsQZbW69JcTCUVpOBlnRaF0HIo/+K8AzDLpf2ZFc2ou4tabftFupCk8Am91wQQkQlMK/6JIO2yVyVGTABriYKh/CvIGp1F/wfPdvXUjZT8BCUSeHNYhYTrdNSxS8Wx/7PcSEoCy7nRfyuqDMOjGhhBEXCBI5f6F/FzASTYI59n+tQlFJ4Kx/nFlBy113SVFXzM4p7KoOLhsk/alTVdDay+7N04nuOooU85PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrJlh95MEHCuhbtDEUys/OuhKGrbwEffkNFB/S69evU=;
 b=EGtNQkOMVrpDaFXTexW36hPlEy3uFwdFaWKg7BfvCiEpcZYA0qX0sZ7lN9HRI8EY76XDVn0NZhtzxRFIh/SIMbbbEPt8VAVKuUGO9ol5Ec3xGdyazJ0xrJdNJhnW3aYFkJC++mscHHydThvPL3x+CTeaITrMK47pjMuf7/6QNArmTZUzzVSrSP21PFuVx3XEeQPUcAP3CIEIZHtLOF+KN6iWgIFK0XUVcDNOpHvgNC1ZSeORqN/EAw0RWRct/HYpM3g3OW635zjbj3EOkFaHG7tSuyDwaYZQwu/F6KJeyEkn6HMx6N1ntdFgu8qgGkYE5r7YdfW2M4XcqPuirO2S1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrJlh95MEHCuhbtDEUys/OuhKGrbwEffkNFB/S69evU=;
 b=THe4PJ6a9INzRqUoQ3EwlSIOdXqQAXg9yrwzMjoqi3cUyo35Q+BkvChqdNHwd3mIcxzbXTaiQ8g+UmUiUy8daCtc1r9VrOcsC3hDHBY4XbHL50GPFTWAaW8OMXht/Olmd+puPeFhXOsNNt34xRUkqz8bt4fzgO+DTDChRzwSwDvQyJ9UO6ZqzKi3AT3nN8p2U4Asq6M3Z9J+F5fCFyDclZMitQz2fs+1f6T8vvOvaZghYZCk3ITgv85BLqaIlc4gVbNHE1+kGY/3AO91BTELXkDqbEgXxkPyUbUSF+JeQNTbQMc0/RQLOqR7uLKUgm0nKt24rtBwoa4av/UOQFEXEQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9134.namprd02.prod.outlook.com (2603:10b6:208:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:00:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 18:00:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [RFC PATCH V2] x86/VMBus: Confidential VMBus for dynamic DMA
 buffer  transition
Thread-Topic: [RFC PATCH V2] x86/VMBus: Confidential VMBus for dynamic DMA
 buffer  transition
Thread-Index: AQHcmqlayGrM32xkUkCHLGwiJCUmL7V9wRSg
Date: Wed, 11 Feb 2026 18:00:29 +0000
Message-ID:
 <SN6PR02MB41577FB84EC73E48ABAC7D18D463A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260210162107.2270823-1-ltykernel@gmail.com>
In-Reply-To: <20260210162107.2270823-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9134:EE_
x-ms-office365-filtering-correlation-id: 9d6c028f-c1ff-40d6-26bb-08de69977192
x-ms-exchange-slblob-mailprops:
 ynsnEk/J89dW0L57jKMjYHPVlex4PDSlBNntqWF7wMKy84jrD3mIlt0mEpLuPOwenZ0ME1dJG/jc6gNO2zcLRTSZRIbbuXwfQODvblGxUDIJzv7Z5WIG7TqQZi7+AcQ9M0QA2vlNrV059bLnKznmxrW7Vc7qXSSs0wGaPhkFYpBG14dx7Bx7fSGv62tT56e3aZTu+cZVNiGkJBaqMsGXbEor8o2g9Kmn5fMwzkk02xqEWX+ASe0OvRhpTvT8IwQ7X183uKxWTxROR4GA1SuCBj6p7+SgWajiKEYEeWKsX0xkfrq/pQ1NKGrWEjS5Ti3MNpEF2X4oSt88wtusK4d45GzG+zRkuumDFp066/nxpk+vS0BGmltTEy9hkPLh7UyLGb2BN07BAc1KewsCrE5g1RLEYoFFDDKkz51Iw3yrAqIvjKh3YobIslWzgsjKff1nUhOQyLGDfAPbMUhyR2iqPA7z476lBzYtPkiPHTi860C+zYeIAeww/1fJ9sSxECqDMYwkKKCIt3qmAONwMF/QfC+Sx5pc6IuhdaQWz/405n7YZsnZgtdHieHH8gqX1UPVS13zNgvA39otjsLazG7hsdnlM+XgHhwUIQ5BeT5UYopIMFJgUb5SC9iWk6AHfVxsyhtWUE3lNhcSxFDH1RX+leiwYux8eZlS20As3/cbm7BxgFrbHoJqpdlJV3JX4iI1ZUKmR4wQcleAved1/GjIGoLQIMLscStSD6VVGM3uPna89bOjNo6r6bKCI73+Vz20RWLCLQfLGoCGWxtE4o32nB+KoBv6+iN56xB2X+8TzKl07ViRsHqD1Hdh1vBisVGuZ8eKagOTLryTD0cVIJPHNZKCtdtirCWTVjjty+xgsxC8MOKtTV7YamMH8IhYV6O0NuPZC0WmSK8jhrATEuM1Vw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|19110799012|8062599012|8060799015|51005399006|13091999003|31061999003|12121999013|10035399007|4302099013|3412199025|440099028|102099032|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0N7HAHfdg+R7Q+6RRoux7twC3QmJqy3uXwZYQm+Ci4Fw6JYehJdEKWf9EYa/?=
 =?us-ascii?Q?qbm7faxI73PWYxC4n/t7d62/UKWb5Zi9K5TCS82Itat4nJ23q/9hCRaUncmi?=
 =?us-ascii?Q?saEsaU/08XaS4hp5X8YgJxfPNNCdciiU43pC/r7DLBZUj4o/2s8iLbNOXVY/?=
 =?us-ascii?Q?FDecsW9pW5XO+/c/NIGHk0psBzi6qgFBcvq0vTdTqZt6XY5q+xTINgSOX//H?=
 =?us-ascii?Q?lPm6Q+DqQXfa+u38qK+2e7iswg5fXfEzUUCYE1l4ic+KCwKQutHNl5wnN469?=
 =?us-ascii?Q?1QyiajmQShAsINrhywUjD/b6VYBwO+XtzaSR3RJ5UDj4txrzUPCFLZ0O/2jd?=
 =?us-ascii?Q?UTNmbo1Un2Gj+j3q73MbH7Gy6B33JJW2Qkl23uDFDZURjuRITRmsKpWW8eD6?=
 =?us-ascii?Q?8F3U9idN37rymi11kIMPE4IpguSk0ZI3bu5KTQhxv2WxkVB8k6VLfaXTv1md?=
 =?us-ascii?Q?ov7FfaXeIYxNHyUWVdZF7U/HQmG+tZJCffOeL1jusw3dzwyDktacOE0uQnX1?=
 =?us-ascii?Q?kMkpohZIXZpO7MUxq5EKQSS5RGdOl1xdvs6qx/O9YM23cYynRBW7Kz+FMHpJ?=
 =?us-ascii?Q?vrawf1CzqYsSF0BpnuAq33hZSTanIvio0UFQCSj9Ihx0bWxq/ApnTghlEfvF?=
 =?us-ascii?Q?5OKViQ+N3kNDX6TcABDhQsv+J1S9/9YcFytJnTGsHg6373fc7lA9OHLlyFnH?=
 =?us-ascii?Q?SXW0G25VEhz+Sjy5q9Sfgyo0Ze2i5kFTHjkJPNDQNTWQpenPzXd/XBh6oK8B?=
 =?us-ascii?Q?eprTIiUF7qubFWfGyPy3ZkggF1alXZwKC1Xje/61Lp8Luo15als8/xPCSNLv?=
 =?us-ascii?Q?elOz3UgZrGB6V5F0ib21iR43FKkDhOPGDgAXWO4rdtaP0e6xrmmWZUD5t+S+?=
 =?us-ascii?Q?DnMHTLwVm7voaPAuZ0k8Bkb21czeNeUjymhFHjpyJkLTWj5IYpfshTKoD25/?=
 =?us-ascii?Q?/wJWMhl+fZbTmZDz5x07FhpZG9ppGNQQG+RQLZ1BVfipxQNBYDsZvKP7kLds?=
 =?us-ascii?Q?RR1O6LcFhwSvtYKBKpcwkNjWTrfRBiR/rUQ+qWfj8Q6cXFjn1WBBOCd/xP9V?=
 =?us-ascii?Q?kOZTyY6j6LjJlpIt/446iCYsA5IWK2Em20Plm9jrtf3cEH2oAyJAQHsDcxm4?=
 =?us-ascii?Q?8ym1mV+lRaeaAnGhfe+zr2aj1i71QeZJ3UipNVN456JjXy6lJYTtW4tjr5D4?=
 =?us-ascii?Q?GB7GJt92mbZI1/3o4g5hE5244x4ziFEa+PU2uG7IRDDNBuWsszOhr2DhRJPW?=
 =?us-ascii?Q?f7lk40IxQy0cufYqnCSL4J9L8aFaYYs7WvippR1p4x6nAx1ghY+fNilDyl+M?=
 =?us-ascii?Q?VoRZDL7GkCbiTnyMcr7xCvPS?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pQv7Y91rTQV5fwafi/eLg8bWJP4Le1kGuMCJKutoRaWunPmtq7OVyxfONqiE?=
 =?us-ascii?Q?WjUqyOqK5tYug/234Oc/LWPMe6DnirYTijJZnkkhT/ofC7uDvfyryWktjMbX?=
 =?us-ascii?Q?Kg3nCl7if4X8PacoPldcym26074q8Yf3vIWqVJ6seCL1BzCVW6kh96tpGDxd?=
 =?us-ascii?Q?9ULqaSUtaG+IbOqI+03aLhQvjy7FELapU+uaaQiPT4S0adywvkD01BqI6goU?=
 =?us-ascii?Q?w9S8aipIG84/BHkiuyq7E3Kdz6Ou7LhgbPHzTo89A+BK0RlvSotoptVjwKgz?=
 =?us-ascii?Q?JTmtz1Ewp5Ds7jGDiujQ6KaOV0Afuba1TdPdUaMg3oZ8oDT6QzKJ1mMtHyAe?=
 =?us-ascii?Q?fTgZ5RmTaA8IbLotgnULckm1+6HD2R76clzTXTuH+71xvMQoSQt0rCY+DZIU?=
 =?us-ascii?Q?+kEVtTkYnKkrtB0ThzNzfWAf0ilroojIvAkONNczWojqsEv6E8kjZ+GjWi4N?=
 =?us-ascii?Q?Cj85SU7JoVYudb5INm3bcEskxQG4M2dv3GvFw3vlGZ/miIXMkDaDvObnu27h?=
 =?us-ascii?Q?gYJyXzLa391aUxZmXwYDIbj+IMd58CMuT5sHbmrw7C01p162NoiAgg8N0x0l?=
 =?us-ascii?Q?CdFMdfjRyC14UseEIoigom6I0/Z9W/F2IPyBAm8eBuc7Gq8uUT1AvYVMI/Ze?=
 =?us-ascii?Q?2ZoI+3h4M93q3HqQAaXdlL+OR0go3HigVpS5zJX5lkH6BPLUpnu6w2NJfiz1?=
 =?us-ascii?Q?2BsGvfh9YHV+ey8goT76TWN5WJ29bLzNakg1SfKigmr1WbJzi6stynSDjTnT?=
 =?us-ascii?Q?qO5BF2eQjsSGvEOqkhMnwo1zpZXYQMvN0Ns+9S3SFbyXTJk9HyD+rH8+DLLT?=
 =?us-ascii?Q?Wqh1QugqMnrFDqepYyVXOVjRR3Tc+wao24EWOgI6Ku2jc4aoLqPF+CeV1EZ6?=
 =?us-ascii?Q?ZuJLkL5j/5uUdcWp/PlzrGIOcLgPlMGfq4QUQgQpJRIPgbvKNvtijuU05p9R?=
 =?us-ascii?Q?MJXp8OBYv/UM2UZ/rahoprcGPf/qwDYzgzR3XP94cVhMy1FnYHiJiSfs6gP0?=
 =?us-ascii?Q?B12bWJu91rB4pK7ibpFz+hRu5qZZf/oB0lDSLJnY69w6YHm03FDRR2GcrUiv?=
 =?us-ascii?Q?LFEgj277YEsbkPn0Wbj2K6zR9oa4kSoQroZp2Stx1CCIPaUjRQjOyeNqSbrV?=
 =?us-ascii?Q?/jtz8h9KD7KoL0JNROI+PNyAJNFzB7YZh4BOEj8GO0sa5BVNTwBGJzuaGCHc?=
 =?us-ascii?Q?fRSlRbi1PGyQgdHflBnmggOvOD00b7cHOUTK0VNaNMEuFS4G/UyqZMuQOHAV?=
 =?us-ascii?Q?8ELDakdnDMIAAXn34Rd28C6jx7rbVrgSZ9JKep22wCatk8EdhajLotHgvjIQ?=
 =?us-ascii?Q?7dSAL+yd6hzJhMGJl8r0+GdQBxQ/fijUJBwIy48DeGkA5McLwDolcIJ9s3aH?=
 =?us-ascii?Q?UyLvZ8W+pmff5i+m0TsBpzsJhGb+cJr4uOoNgq7uHJ/2LTwQ6ChLIRxbknSX?=
 =?us-ascii?Q?HIVGPg68vRaq8i0X7ngj+ImdOthAfxOi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6c028f-c1ff-40d6-26bb-08de69977192
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 18:00:29.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8783-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RSPAMD_URIBL_FAIL(0.00)[openvmm.dev:query timed out];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: 09642126C3A
X-Rspamd-Action: no action

From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, February 10, 2026 8:2=
1 AM
>=20
> Hyper-V provides Confidential VMBus to communicate between
> device model and device guest driver via encrypted/private
> memory in Confidential VM. The device model is in OpenHCL
> (https://openvmm.dev/guide/user_guide/openhcl.html) that
> plays the paravisor rule.
>=20
> For a VMBUS device, there are two communication methods to

s/VMBUS/VMBus/

> talk with Host/Hypervisor. 1) VMBus Ring buffer 2) dynamic
> DMA transition.

I'm not sure what "dynamic DMA transition" is. Maybe just
"DMA transfers"?  Also, do the same substitution further
down in this commit message.

> The Confidential VMBus Ring buffer has been
> upstreamed by Roman Kisel(commit 6802d8af).

It's customary to use 12 character commit IDs, which would be
6802d8af47d1 in this case.

>=20
> The dynamic DMA transition of VMBus device normally goes
> through DMA core and it uses SWIOTLB as bounce buffer in
> CVM

"CVM" is Microsoft-speak. The Linux terminology is "a CoCo VM".

> to communicate with Host/Hypervisor. The Confidential
> VMBus device may use private/encrypted memory to do DMA
> and so the device swiotlb(bounce buffer) isn't necessary.

The phrase "isn't necessary" does not capture the real issue
here. Saying "isn't necessary" makes it sound like this patch is
just avoids unnecessary work, so that it is a performance
improvement. But that's not the case.

The real issue is that swiotlb memory is decrypted. So bouncing
through the swiotlb exposes to the host what is supposed to be
confidential data passed on the Confidential VMBus. Disabling
the swiotlb bouncing in this case is a hard requirement to preserve
confidentially.

So I would reword the sentences as something like this:

The Confidential VMBus device can do DMA directly to
private/encrypted memory. Because the swiotlb is decrypted
memory, the DMA transfer must not be bounced through the
swiotlb, so as to preserve confidentiality. This is different from
the default for Linux CoCo VMs, so disable the VMBus device's
use of swiotlb.

> To disable device's swiotlb, set device->dma_io_tlb_mem
> to NULL in VMBus driver and is_swiotlb_force_bounce()
> always returns false.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since v1:
>        Use device.dma_io_tlb_mem to disable device bounce buffer
>=20
>  drivers/hv/vmbus_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index a53af6fe81a6..58dab8cc3fcb 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2133,11 +2133,15 @@ int vmbus_device_register(struct hv_device *child=
_device_obj)
>  	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
>  	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>=20
> +	device_initialize(&child_device_obj->device);
> +	if (child_device_obj->channel->co_external_memory)
> +		child_device_obj->device.dma_io_tlb_mem =3D NULL;
> +

Doing this as part of the VMBus bus driver makes sense. While directly
setting device.dma_io_tlb_mem to NULL should work, it would be better
to add a function to the swiotlb code to do this, and then call that functi=
on
here, passing the device as an argument. The need to disable swiotlb on a
device will likely arise in similar contexts (such as TDISP), and it would =
be
better to have a swiotlb function for that purpose. This use case may be
a bit ahead of the TDISP work, and having a swiotlb function in place will
help ensure that duplicate mechanisms aren't created as everything
comes together.

See my earlier comments in [1] about the key point in the commit message,
and about adding a swiotlb_dev_disable() function to the swiotlb code.

Michael

[1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157DAE6D8CC6BA11CA87298D=
4DCA@SN6PR02MB4157.namprd02.prod.outlook.com/

>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
>  	 * binding...which will eventually call vmbus_match() and vmbus_probe()
>  	 */
> -	ret =3D device_register(&child_device_obj->device);
> +	ret =3D device_add(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
>  		put_device(&child_device_obj->device);
> --
> 2.50.1

