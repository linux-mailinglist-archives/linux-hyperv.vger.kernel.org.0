Return-Path: <linux-hyperv+bounces-11668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6gSTEENbPWr+1ggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11668-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:45:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3326C787C
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:45:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=C8Ahl59m;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11668-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11668-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5264303350E
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFD03E9C18;
	Thu, 25 Jun 2026 16:41:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012084.outbound.protection.outlook.com [52.103.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3225B09A;
	Thu, 25 Jun 2026 16:41:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405716; cv=fail; b=uKhx280DlFk/RIP0uyQw/LtawzRJGuW73FRUcro7XJVeLyuBB79IMY3IIHMM70y5CZmx7dZxp6ABtMSV6MUSzgDa/ODtUljaKifbRIhMc+WMl1gXViu/5OwZ5TGbFxaNOMPDAadConA7tX/vygm/cghfNEs4zg944QblAGGfxb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405716; c=relaxed/simple;
	bh=/N0OYjQKVCuy42+piWHsduNTTHetHXmr/5xDoTtuiOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qc1/PuKBMraETjKrIz5ZgGIv/qLKv/b5/4LafdlwAZ4m1FRs6UDcLgVBTQaT54vbeNgYE0yrwxPp2vGOaxBpJy/azW5Y2OWKjDAFufWNEVhSLJ3J+fPMYX/yDlp58XVX4SimcAVs/qkG6q1iECpPi794QfQKwlFJMYhT98+BMVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C8Ahl59m; arc=fail smtp.client-ip=52.103.20.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t04KJ0ZeokZGV5JyCKRDb0LCZfuOvEpIUyMQY2sviRK8rnQBiMufLvHhFvcQcdCrkgVxmn46Pf/gG5ZzmuOzEfliD/nNyAPpanQbnOc+G/x0noZXeiGVR6ytyvZEsQJvwVqGRIlrmZEOVpOpChscEBcU84tikMCGOB3sYI7QUH7cvgitGNJ4xH3ttlR+WJXQ3sWbLPnLW0HmKmYUou+/Fk9Kp6HNVc94Ok2YEgaUGKRJpSUoudeXCU+9Zuyqk5zeLOXLZVctsi/xPitoKqLqJi1IZYfRdAYmfa/DmbhcW7UyZhGHBFpxX666218PL+6wjKNGCikuBC2XxIcUanCZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJpB46xDBezyyndo375VkBq/TyxNTOFVeDABV9j8zuY=;
 b=BIqiPRLXx6ZeRmOo82l3T+FoL8WE7IhdSBwTS5iF+QnquHn58o+YjRv+Z7Hj3DDN0fttL4XXPEenJnetpVcTwNifmkCYCm1pVzqY/gnQ8S3IlM1Rc8GScTXLMqvjJ98YlZ1+d4A9X/0wd8vtwgOGdH9iSCh3WdE6bLA+iY6rZr08o1rryS0jqR1/+leSmZNecdThN4vIu5O5wnz3xLFdGRjU3m9gbRTgkFwl5oNERZIVK1qq4CPtu2KOfR7JdwzXsk96Z+4q0qt1Vl/NIY8S7t7NciXH5zZcu8mTe6IR7vO8/FEIAfPU3SXVvq6S8ZrtjiICseoWKDIDuAhwZvOstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJpB46xDBezyyndo375VkBq/TyxNTOFVeDABV9j8zuY=;
 b=C8Ahl59me0RmfKkv/pQ2JtLS5kGJFJMH8DpmUJLdbHrblJeBzuIvaki1nsk+fA10G8DfWm185N2FY0YgDt4IB1xdogmoU6hc+Z5cV2sT0rEIAsbXYFTNE6gzWNwgw3O8Acdoyu/XENTVsZXe+5Vk3UkKnaUdJAZgUaL62m9MAi67kItWojudkm8iCi69z8C/qXHjlbMNRxDZteVwPEZodySzRJnviU8zSDQjPtGsVreL+Y34UMFnF4wfJOPO1zudk7Obhzd5ZqCr/exT2vWEnxPRkithPu0indWovviBTcdgK7Q3ZQOO6sE4bDvIxhZTnFP5E9BcdSghv5Jh2y7+5g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8629.namprd02.prod.outlook.com (2603:10b6:510:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:41:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:41:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyperv: mshv: zero VTL hypercall input page
Thread-Topic: [PATCH] hyperv: mshv: zero VTL hypercall input page
Thread-Index: AQKE1u0qhqZr8xodokVX2fb1w430ZbT/zxaw
Date: Thu, 25 Jun 2026 16:41:51 +0000
Message-ID:
 <SN6PR02MB415746E6EDCF82DAFA8B1C49D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260624175703.9285-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260624175703.9285-1-alhouseenyousef@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8629:EE_
x-ms-office365-filtering-correlation-id: 1a77aa5b-5ace-49cb-7dfa-08ded2d8a8a7
x-ms-exchange-slblob-mailprops:
 hQngCdii+CaXRI1QpKWdRyX2ytSc3g6jGIt8nPNRsmSaAAVtE129CranIyBytfkqwt/uqNYVDhTMhXU5v2697XzwWXQm7VjsQP+tGxayxaTigVesHn5pLagcU0+XyvNdrb+axizQ8S3d7SVreIc/ywZEukd5OQzwUCDMutpqzk38Y0CQq9RFT+1CErCtrci9lvhuxkl8dvdQBoei3+fE5lbfzQDaF6LgR/3n3lihdml3ub6covsexQfMRe1MlLCUlpTnbibTrMFHhiboXgK3I1nMIT0BIua7yvZYiuhlGFdXqJOYrUn8aVHDmLkVzRUkwC5LhlYbWfhhgQ7mg9MrpgcNNt2aQze6fDdwK6UCxX3zXEk9lRYQwhuCqt6qetaQ1rLRBoCmyLFT/kG0XesEFEc5znf5RqawP/IINkV15s6g6+nXvII9aO5p3c5Mp3Pjr5y5g5LR6BI8YDRmjegO6HYP/cy+BwdlZMTJNotiqBKDS2g0dvUvEnh0Z73q47DLcoC07bzHXeYHNf9V0TNZ7LfcvQ3dllh7XIEvYq16pfIfxp2LB5xGP8LlQHCThehMh2I+hU2tk9/OgLQqYTbtP7MwpvZuqA2Xn/3Mx7tJiw0uFzUAquVSC3HXT9DE/Og0+aaLjRuksxCklfao1tKtpHWVyoX4cpFqqtVRnz3KO4RI+EjaMnK8LA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|19101099003|13091999003|31061999003|19110799012|8062599012|8060799015|15080799012|37011999003|25010399006|40105399003|12091999003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eqeDVdiyyi5h5I3TYdzJ7/zBPWN/GOxqsANcbXxFUUt04IbKHK6C8Fmj64ir?=
 =?us-ascii?Q?LIOyWPxzKcsjPjxQJyCCCFiF9etTKMOHU8ZBRS2jaADixXMz7BpgVwv7Lnpp?=
 =?us-ascii?Q?8ohNPIi1NHnqMGqCM1bURDhYeplMwrhvYs1rdWYSpYED4UtK+u9rFHjWXVCN?=
 =?us-ascii?Q?c9Vr7GQyt3qw1oya6fvgIbeiNbH+/ecS0O1XzjHP720KwvV4fmfjo2NsU2EG?=
 =?us-ascii?Q?icDs2PqNpKjq/UoQl+Z/OYlb9uZaicq5JXZ0eFhP/1zbaY4XIwTGlyc4arc4?=
 =?us-ascii?Q?n3BPnhoRlBcVrfwxZkRroHiW6ER4dkDiO/s7TgqXnsQyLN811Zsvsn597lSz?=
 =?us-ascii?Q?Lye/i/4DD5NsKytwlRZt8meXLDDiYloKq8biNUWLwMUNPp85gb3/EwaoKJJD?=
 =?us-ascii?Q?h7SXTKjO+A9VH5ymEilAaAlaXzUpThpYxwEQw21pOS+SbFRUsXTR0Pvk9syx?=
 =?us-ascii?Q?Ly/PV2KtdtU56zw3hAHm74TCiCdBaPpHWtFVJwoXDpByRpWuuKf/sAYXxemA?=
 =?us-ascii?Q?Xpk4IdlYAHxa/9YfRz2/tMwW6vq/jlz+GBQeUWeG3isCGmRFzlh3uWIZg4i6?=
 =?us-ascii?Q?JxFc6kRVB+vxPptxBkJ50Kny9ACr6iDvQMc7S/F9vzD5uZyIKNvVcIiSj5YF?=
 =?us-ascii?Q?0onZArrBYeNgQfbljeOj5ECAeXMni2QiJnHgijRo8atFUY4rY6AFxBN6DIZe?=
 =?us-ascii?Q?4GQCOZT3smhYJWzT1Z7inPGCNApSIIN5BfYOD5bptJYMsbjssCAyCOoudU2y?=
 =?us-ascii?Q?15EqCwXfRnByxFAIAac7Mh3KeEz1S2LQ+Kb9FYdREXMbzbvqPvJz/Z6bzgNF?=
 =?us-ascii?Q?+Q45Qrfj4PukoLrJwBtzfd4fkhxbJmqB/JcZ57SChWL88OIaWTLAQAlZYDOy?=
 =?us-ascii?Q?kZ/AIgIa8KuyxLZ6P6xBZxtVj8BdSNmKDPVJ8OeLvvp0QomEcajj2c6NMPZv?=
 =?us-ascii?Q?drYHL/jWRUMWr8bFUiLzx0Fgfo82TQ8spQORJrAGOTCfLG1KS9qDfxCWrBcg?=
 =?us-ascii?Q?GYPktENBsGINUaf/hId/XPLbkXeI/NiSqszmLKky4uhB18M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RcknJ456XQA5J9nmsp/DXLVgw6hZek8N8s/HPprEjydxvO68iIfSa5FVacRa?=
 =?us-ascii?Q?MsLaxbFkMtmj4MUPtUlyJDrGVL9WRCNQVIzklBbd9WE1ooPTD6bELPx/MlO5?=
 =?us-ascii?Q?elmhH4BUUG9aepSpPnebf3jp7jF6EQlrIWoMaa9NQvDIqFfxW2w6ZyK8M+SR?=
 =?us-ascii?Q?QadsIPKUMt7FErr4ksRUzWQYFXyOrraBnAtY7pFp6GN0d2gIv3iYwE0ot9+P?=
 =?us-ascii?Q?M3/7Yc6ltIBi6ac4xc4VF/2wU+7FwZwX5QuXUljmAQg5N6Eqgd3roLFBjpfi?=
 =?us-ascii?Q?g5mpfa2xbOSlmcE2Rlz6QkcbHc0aAgWYScLAew1nKuvCoz0/1Afz4RwRlUIN?=
 =?us-ascii?Q?lvSz3N9AnX631aWhvEm0w+TAWqxobpxshYQtuoQPatJqSYDwS74NAR+EpEz/?=
 =?us-ascii?Q?ltzpWTVqWk/b3o0oI35oyXjwqOESZYL38xsOKqEzNU6wdR+B/qlJ84IxOsA7?=
 =?us-ascii?Q?pZ3b94oJ6AvUZKk7b/us3PQMVg/jqM6/0p4rnQG3M29oHKN3YS0srPjzBerL?=
 =?us-ascii?Q?0bwQMMPmWqvegr+HF6FGSxFKmqMTHU8WRnnXu0xg+PM2W2vyUMrFQlGaRsos?=
 =?us-ascii?Q?mmAXABY5Ex9r1vtyFOqC5uKaTcufWVlzy9/iUs+2XhfbsRdG1iXuL//GkB/Z?=
 =?us-ascii?Q?3s7zIAhBnOAyZMrBVvfYWKcYXCgKdCSjnkmD17aw3Bgj1Dn3pmTzIWmDgxv9?=
 =?us-ascii?Q?p1TUB6klVGey7bQu2/FFv+8WubDH0HytDbV7VOLEbAlxbjrbVSk16OB/vleb?=
 =?us-ascii?Q?8SNHAQQhjrcoh+V/UWjzez+cn/PzgzZ+rLz3+f7PMNJNkGXhZwRhBTqFjAyf?=
 =?us-ascii?Q?EUNppu7EL0P63zHqB04LXGyJm9xIpAMCiDpD9ig4ApTerC6wLb3SqFl3yTow?=
 =?us-ascii?Q?GaZVveeMqgWRSrTUuujf5FPkuqrUXrWynusITV4qMgtpaQ+ksFL7baQs/ifS?=
 =?us-ascii?Q?FAD59ixiYJ04EJARmV7t5NEd+VHh5zNfqe/vbEb/PKR8ruuXOQgXZIjJJIev?=
 =?us-ascii?Q?NtgRzxsY7ghzqkJ9xvA2OO/vF5qLRWKu5W9E5WsxtMQiIUtWFLoZMRSDoGgm?=
 =?us-ascii?Q?Bitre8Qvmwx8eoFtHcpMDPa644hwLPsyH5DZHXlAbkqZPY/XrfFF9K1qnQz5?=
 =?us-ascii?Q?Sx10XaqceCY37vfJq6QvxOElqE9ABfFC2KjrDuMWuG0cvvleXKq6c5d4r+kD?=
 =?us-ascii?Q?34fb+c4MtZW7r5eg8ZLZkUiJE9bpbtooLImQVbLCaa1ydmv1ECQnsIFsk7Nz?=
 =?us-ascii?Q?6SzA7bpQWy0WuUXYJLaI/um6QsQYocDRVe39Eun0Gec7oIIL5fVk1ITDrewk?=
 =?us-ascii?Q?bFDocSzgTSwgFNIdl1aB7X+BsEM1slfnui5irHsmuaBgJBOhWvnNILuS6SZ/?=
 =?us-ascii?Q?X91lRtw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a77aa5b-5ace-49cb-7dfa-08ded2d8a8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 16:41:51.6899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8629
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11668-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F3326C787C

From: Yousef Alhouseen <alhouseenyousef@gmail.com> Sent: Wednesday, June 24=
, 2026 10:57 AM
> Subject: [PATCH] hyperv: mshv: zero VTL hypercall input page
>=20

Same comment here about the patch "Subject:" prefix.

> mshv_vtl_hvcall_call() copies only the user-provided input size.
>=20
> It then passes the page to hv_do_hypercall().
>=20
> For short inputs, stale bytes can remain in the bounce page.
>=20
> Those bytes can be consumed by the hypervisor.

It's unclear to me that there's really a problem here. In a
CoCo VM, the host hypervisor isn't trusted, so hypercall sites
must be careful to only expose intended data in the hypercall
input and output pages. But this code already doesn't support
CoCo VMs, as noted in the comment. So in the supported
scenario, the hypervisor has access to all of guest memory. Passing
stale bytes to the hypervisor vs. passing zeros really wouldn't matter.
And user space can already pass stale/garbage bytes to the hypervisor
if it wants to. This code doesn't try to validate the input data for
whatever hypercall user space is requesting to be made.

When support for CoCo VMs is added, this code will indeed
need to make sure not to allow garbage kernel data in the
hypercall input or output pages. But decrypting the pages
so the hypervisor can access them should take care of that
issue.

Michael

>=20
> Allocate the input page zeroed, matching the output page.
>=20
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/hv/mshv_vtl_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0365d207c..f2633148c 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -1146,7 +1146,7 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hvc=
all_fd *fd,
>  	 *
>  	 * TODO: Take care of this when CVM support is added.
>  	 */
> -	in =3D (void *)__get_free_page(GFP_KERNEL);
> +	in =3D (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>  	out =3D (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>  	if (!in || !out) {
>  		ret =3D -ENOMEM;
> --
> 2.54.0
>=20


