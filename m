Return-Path: <linux-hyperv+bounces-9977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJxKIgBo0Gla7QYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9977-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 03:23:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E204B399750
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 03:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE45303C299
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 01:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B472236F7;
	Sat,  4 Apr 2026 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NnE9KZlB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013089.outbound.protection.outlook.com [52.103.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00B23D7FF
	for <linux-hyperv@vger.kernel.org>; Sat,  4 Apr 2026 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265766; cv=fail; b=ViZPYwFLHbG73gcjinixjcUFoTs4D/MtZJFJRlunzq7j2Cn+k9nP5GKOdqHOd8ppKh8xPmx/QGyr87uIwJ7wUMoFlIM6qHFl3FmraHub+IZAmXga30uAPoYXn42GAXDB7o+8PmeTHXkAQWEFXZ4EvKJ14JR98w1cNal2AoflyHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265766; c=relaxed/simple;
	bh=bWZTSy30lWkX2qPVeRk1sZq6KG/fnCiTiUEnJV8JrzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dxszawwkBmXHRAr2w0Vi/fWrE5hkLxRqErbc8FM5YHtMvPBKz0/X3Ty7TeDXxqopR56p4xzUfLSKheU3M42FJd5NR1lFnZxMYhWjjLyJqKL0YV3qI8tbhRSdKmkDVmeQV8jTVJdv3U5PS2cC4em1yfzo4oTtTef5+DsK3cEM8HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NnE9KZlB; arc=fail smtp.client-ip=52.103.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtuLShCcBr+4EKSGWKfmodO8TJKS7Y+hbMjGbeUBtPl/iJETvhljzCTwN0+1hTXhGaC4Xy8GBBJm2i9Mt1Awk6dovR4gag/wX5Ui55An0AiIEwzdS9rbIuwFPHRziKKvH1DrrCCQRwaCUgYG61Xcmt5KuC+vTLRDe69esDOMXEjHyoLAfLo/Zu2lRKoJ0ScuVn4VuDkL3kKZs4NfrIXU/Ta/1YO5R4USxsEkzGNEAyvmTb7RjcST62iYFhyyKuDQdjfx9+Oq3htZEMqo9oex59reApuzrMjYnhYudi4oaPctfEPbCMV2qMUzmtIliBRC0oCi6sBJ62BY9p1SLxS+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSwQSIX3Ie99CJ8bXX16XDQjm97zRfyo4J6AiEvCbXU=;
 b=Hls4p8c1FohsbFbAP5Djv0YSLoriYjSxn9Lho8/TUtkXIW3+jkOQ28xbvfpzfxwS3GV7x7A7oV4wQVQN6GKbzW1PVC+l1HHa1rc75GpIyEZe65zJ4OPzdq3GqvRdZEaErU7oatucqjhOYkXKZkgTfJyDo5r9jGpBKJ0g4gg6rxOuJrJH3k7hSitKFAOcBIr9OcVeGKNrYTJdK7xthjoBb6CBdyqlGCUzA59t9+A1XkzM+YCUSEiLZ7Hd49vOgl6o5ExnrAqRZWFlXwRL1w7hmR4eYtRvTzS5qqdSTQm5mtEHstG7Q5UjqoJHnW7wbiKC7rKSFb/tv1y3YOnkI/uNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSwQSIX3Ie99CJ8bXX16XDQjm97zRfyo4J6AiEvCbXU=;
 b=NnE9KZlBoyld6eW5z9jH/R7dCVFGd9vNPL6KutQTukzmulUq8EpAGPI/Xn7MVGNC22PTiQUO7yHGghn07T9s3Ni7vORngOtVjnERyCo3AUib2R0XGQWtf+7Cu68f5veV3Otoxr2gJ8TOnvhyb40OKG7f0857CsoAYAd4f6UJERVGYGlf39T1tSNs9/uD7PAjW5O9l/jPPVcH+t2xhrbtbEfvya2EBUkpU68jtSebu0wL63Mmx5wQeRG677m9j/t51myNqrfrx8KWMwEK8MtNwHW4eLtjlhjB7WdxVqKkg6o+ZgRqWQwm2yEakI8oznzSPO0W+g5M8XZ43w8I8/dRuQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7424.namprd02.prod.outlook.com (2603:10b6:a03:29b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Sat, 4 Apr
 2026 01:22:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Sat, 4 Apr 2026
 01:22:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH 2/2] hv: vmbus: Remove vmbus_irq_initialized
Thread-Topic: [PATCH 2/2] hv: vmbus: Remove vmbus_irq_initialized
Thread-Index: AQHcwepe3SDA66CVAUaVLXsWmdEsx7XOBerA
Date: Sat, 4 Apr 2026 01:22:42 +0000
Message-ID:
 <SN6PR02MB4157AA6E1CCBDF38DBF67FC2D45FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260401151517.1743555-1-bigeasy@linutronix.de>
 <20260401151517.1743555-3-bigeasy@linutronix.de>
In-Reply-To: <20260401151517.1743555-3-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7424:EE_
x-ms-office365-filtering-correlation-id: e0b9dbc0-ab0e-45c8-8879-08de91e8ab15
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc6c3c4/rztiZGf6bH6e/ZCzrvsnWuRYW9XMPuyPT5NZhBTL4yHN8vnHNFAtU3i7Tueoqyporpnwe5wYcHbpTpPS5Cxz5zJDBPOwQBE3qsWn92bxqMHDh7mlS8MymZ1GbUQvXZkQ3ta/vp97Q/LHzysgsbM5fvIq8jofCd8kR0fI0L7qAOALZdZfAKIuk7YTij7r0F0Dqyq4bPn1AlxbQbfUZK0P8br5uAtrv0VcAUvH65V+VTn39XsCCMI00mCvX+SkBqmyM6K+me1ubJszHoUEsO9Z9SZCqIRWFYG2g85v8Lwyc6g7nCyWSgkbB/4iVqIEKZO33PQ6JqXe7PcH57DTiA7jhkzcoGS1Y/CcN1j0XguCbKRvhRqtF+WCl39hQgg60F2CB35uq0foDgx16oSf3JR5/Ml1j1oBAl58OWGvdLaVr2Atgsab5I7Qhv4RDRJAdOWzmxPcUwgIqkaoeqEq6ED7o5L0x3dhnK/YAdHV37Up1XHdZPIGyXyQd+QBOmKbo1OZc8KlXz5QyRONiHdgqS2RZUNDZbtLqjD7svZlUH22Jj7dJFs0+/DL7A6tQEMOjyeo7AXzmB7PbNd1uwarsV7ba5J89iQ1N6Qu6d1MAWsVNkEX5dD5huRT1EQx2ZUrtJrtIvznS69u1Ynfo6lQwBy9Z8EhJaoOR1GG9gpTcbGnjuofS+OuNdvg5BlulUwnKQKK9+XZiMYLVLmjHGs0EpB/UEsNhOq//M2wA8cRW2WiNpCQMRn
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|51005399006|13091999003|37011999003|19110799012|461199028|31061999003|8060799015|8062599012|15080799012|40105399003|440099028|3412199025|26121999003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aIQtgLX9HGvmwDbFMdl0r/gFaftc7gGxBHw9F3/cV+CkJSff6EGJnDEYheud?=
 =?us-ascii?Q?IHhwu4sTxBOH1ZQig3UtiC17pDi4FpbiJ+T2CFwCFkwai3Z+HFz6FtJFvKKv?=
 =?us-ascii?Q?4SNY9b4AFipGGlQ9UBRe+/+fHBzp+t50zdV0QBn8ioq6QU0+b9+KeE7q4wlz?=
 =?us-ascii?Q?uLq/oRM2JhICp4xdP3X89ML5nxz8etiBqd4A33CZjYYMa4qyHMoWLiXr5CTN?=
 =?us-ascii?Q?qpfNvQYJ2D00xBtLh/mA90i3OkOVOM3i4SxFpsHHLkoQWLOhdGEFtU1S3Vuv?=
 =?us-ascii?Q?fmNAnKbc2gg5WvABw9kBDOsklUzlyKTWu2HnhjNRzgS2VLIepLyVmZuOSmM0?=
 =?us-ascii?Q?ACCQxDArGfMVMdqRd1eo/rVobDsffYVK4UV32qY60zLrGVJkn/lYkhE2N/63?=
 =?us-ascii?Q?oRZ8P6bRekqT7kodJJcwMc4OocNgOe6i10ZkgykmYLQJdINvL+bQ9p0joYpD?=
 =?us-ascii?Q?vwovfum8TLHnd7Gd9Exq/oLxDc0jI/eCEqB2QzPYrf+luY+m9I3BzgvgNoim?=
 =?us-ascii?Q?embVg+2wKHE4DpJeAPzCGD+jJwV8c2wdGU9Yrc3zIiVWMke48DqtLGPq3nNC?=
 =?us-ascii?Q?UWNAVz8hr4hlTba0B1qj3bOQ8j0ikMCBUnHm2GUZu/wppwZzOwjtD2A4ocq4?=
 =?us-ascii?Q?3Q454r62oF24SOIzmyX/AF8e+9BeXXLzCjTVneN8pcwB0nehDfRzPpW05uB7?=
 =?us-ascii?Q?oOY3uBELIBEKri0pSoLO8a85b3Gh3qSE4911eOJmTtDXD+ACvhR7T0XdMZAE?=
 =?us-ascii?Q?E1ds9BoU6LtoXW1RQwwxDRCj72a1Hbluq9sr7D+V55LCAbYf3HsBQmBBnzu6?=
 =?us-ascii?Q?M6oAOrIzFesGwiAr7rjpZ3btjb5B9AZEcNUWxoSnN13KvCF+3hqv3a8/A1kW?=
 =?us-ascii?Q?0+I5e6zm7jbhVfZa6HSor1PM35ClZm/RnPvBSxYeoA4h4U6KsaJ++qEMaD6m?=
 =?us-ascii?Q?MUFIbGAVn5f87WL+6MfDldB4DvezRf342e/ZBlXAwdAJZVnzjNHpvq+CrU3l?=
 =?us-ascii?Q?evFJl+1spmir3q2dkh+AkmEQl1Chq8EbEQ8slW1q20LauU8CfV/RugGPRRdD?=
 =?us-ascii?Q?JRQZrZp1?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LT5m9pTvzaZ1f34HOLihBxN0/cx5uJgwgVYt25iQHAJEVyLblZSOALtACx0r?=
 =?us-ascii?Q?dDfsk2C531we4XeAuY/Hx55QcPH4BPTZ9kDgGdRMw80Wo1LgOHmPMv9tdARs?=
 =?us-ascii?Q?9HkKFjsAMnFnNkJFBQaVOKESf5Qs5Op9+R11TzfC6zd9fdi7Qoh+x0UcUF2g?=
 =?us-ascii?Q?ocD6y0JQ5ds6TKTJRdT6QT0mDrkUF1PfHeulLksi8l3iFzXjemuJgf21vn9Z?=
 =?us-ascii?Q?mz2M1cxYjRY9tDR5x0nPjz++NK9zCHAZlzH8ypaiePXNUkbo0VEncRZ/TXcS?=
 =?us-ascii?Q?138nMUz/MpulE+rVeGDlJ1j5mZLx4pUu9P5CDUhyQLk9Nqn4c8WTuFQ/zrL7?=
 =?us-ascii?Q?DI1keo+GCLJRUlxM01IDzmJQEplwLEeJwre3UJT8TAc/jmGrUT8QJqYOpwLR?=
 =?us-ascii?Q?uCP8EHBIZRB++45SsQwAWmaLcscib/TxiQR+gk0ZynkVopLWNBDlywATcID0?=
 =?us-ascii?Q?1OIC/7qc0WWDBgz1cnb3WU6qsFBAlK01w0HwrX1IPojMxJJ2IRzHlJH5fRXC?=
 =?us-ascii?Q?3XtBq47GzrNBjLvA7mscZZGIdyJtJXkLCHncSajGaeWVAb2mbW+dyAh2p6Rk?=
 =?us-ascii?Q?bJwovXf25IMP3Rms0RVU3mJtknLkX8J/NBN0qzZ2FZ4ntJFzvuqyh7Kod9Cq?=
 =?us-ascii?Q?x7ijpj1vkVQJPMZWtbaentrd27VZRAwMT7vIJtP7dyVTYiDN810DP6L7VIIK?=
 =?us-ascii?Q?DldNDk3LmxYIGWkH993VtWIYo9qBK2iexLVla5OWaEvNOURMeoHI1T8DcaH3?=
 =?us-ascii?Q?ajqt8GwHMPusJmBll4YKFG9JsO9LzTOPhHwQOyg234msi6DgjJOdL3qVvgQg?=
 =?us-ascii?Q?p+i6xJ259OWcdM1PoktoYQwIlJjSerqCphlgITCK51uDG3VrJJI0cC7+vfp1?=
 =?us-ascii?Q?r9YRMZtFqzpNiiyRnR22ZRGbUbPMOgwdcMZvHygQLCPfwHbzEpcXBLbyYRk4?=
 =?us-ascii?Q?SeLhJVPXCxB+XW+OkuSusXWf8CRwEWZvTrvFFVfHxj67so5TpH/jrjaK6zsU?=
 =?us-ascii?Q?mxkH1tgCKVUbzcTip9hR61W0+wuZchsWK6m0T8E79jxMuG+c82N6jtxFIcCh?=
 =?us-ascii?Q?F8M29+h340HMUYknApsUI2w5BEqvv37OitInDhtrPgATuo6pLtfEBXExpWkj?=
 =?us-ascii?Q?zjSHss/fTrPtFSD3ls9Py+2M3imtA/NrY47aCxCv2sQGYDdqEo1mO+7B9Lfs?=
 =?us-ascii?Q?ZOlxrJ2ojkTB+whSO9p3Y/DQ3eWCnK4Ii2dfWg3xoaFsEMb/yHqbLqytxADF?=
 =?us-ascii?Q?SlmEt15AvtpS0PnH9J1Y0vjKRwJOMzhbxJkerinYp9tZvXNV4b2E1JlNPZqI?=
 =?us-ascii?Q?mRsDLtgfFEEHbhfJeXyrzMlwVN937XlazGlJtFUMlrsXpyQ3FLD7dV6HiUke?=
 =?us-ascii?Q?aY2ET5E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b9dbc0-ab0e-45c8-8879-08de91e8ab15
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2026 01:22:42.1518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7424
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9977-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,linutronix.de:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E204B399750
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> Sent: Wednesday, Ap=
ril 1, 2026 8:15 AM
>=20
> vmbus_irq_initialized is only true if the registration of the per-CPU
> threads succeeded. If it failed, the whole registration aborts and the
> vmbus_exit() path is never called.
>=20
> Remove vmbus_irq_initialized.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
But see comment about the patch Subject prefix from Patch 1 of this series.

> ---
>  drivers/hv/vmbus_drv.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e44275370ac2a..7417841cd1f70 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1392,8 +1392,6 @@ static void run_vmbus_irqd(unsigned int cpu)
>  	__vmbus_isr();
>  }
>=20
> -static bool vmbus_irq_initialized;
> -
>  static struct smp_hotplug_thread vmbus_irq_threads =3D {
>  	.store                  =3D &vmbus_irqd,
>  	.setup			=3D vmbus_irqd_setup,
> @@ -1513,11 +1511,10 @@ static int vmbus_bus_init(void)
>  	 * the VMbus interrupt handler.
>  	 */
>=20
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		ret =3D smpboot_register_percpu_thread(&vmbus_irq_threads);
>  		if (ret)
>  			goto err_kthread;
> -		vmbus_irq_initialized =3D true;
>  	}
>=20
>  	if (vmbus_irq =3D=3D -1) {
> @@ -1561,10 +1558,8 @@ static int vmbus_bus_init(void)
>  	else
>  		free_percpu_irq(vmbus_irq, &vmbus_evt);
>  err_setup:
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
> -		vmbus_irq_initialized =3D false;
> -	}
>  err_kthread:
>  	bus_unregister(&hv_bus);
>  	return ret;
> @@ -3033,10 +3028,9 @@ static void __exit vmbus_exit(void)
>  		hv_remove_vmbus_handler();
>  	else
>  		free_percpu_irq(vmbus_irq, &vmbus_evt);
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
> -		vmbus_irq_initialized =3D false;
> -	}
> +
>  	for_each_online_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> --
> 2.53.0


