Return-Path: <linux-hyperv+bounces-8877-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD8TI1s9lWlpNgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8877-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 05:17:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D9B152F2D
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 05:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0D130263EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 04:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D41C2EB5CD;
	Wed, 18 Feb 2026 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cCvjrBzc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010023.outbound.protection.outlook.com [52.103.13.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913825B311;
	Wed, 18 Feb 2026 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388248; cv=fail; b=dCjk3a4JiT0tJVBGYmjmdBi9xMF1bAt0q94QgGlMw4qtJIaucz9nNfAknUFtI4EzQbcwMWzmfz4bU0VPkV5T0GkLkXg7ynn/h+YvYi4Ef4eSQNamNKrtE9ak9ERCfF91FLwqxnQ6iAny6r9IGF8+JP5IYUnDmZ/6A9SGp2S+JdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388248; c=relaxed/simple;
	bh=6XIMGy6R+3ub0zvueUcnz4NxqExw4PYxTUOtKatxDeg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SksnqaYagB9wVoyogjq2bG51xCFoy2KNsiwH9g7/Z5yy/FUat3XsGN1b0Ifp9xEAV3vl+FsmFs++avmvt7v7+3DvScyPRaCwyGSKe52RJKIrYNerQTxjvZ/SKoFHSpYEEZRDQN80wvOVAhpR565QI1/IwzvDc6nBuEXNbcOLHxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cCvjrBzc; arc=fail smtp.client-ip=52.103.13.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVyam5lYXsYEVi6XOv7279Tyv5qJqOApN4q+X/Dc6SeQ6yk5OwXFvppcgYvmUhGpr3/5s46dILmUMhrs809sXhnNPn/+15EWv4Wf4CqKOBlBtB/GjwUPUNU8QNwyH4hXVagkOr7D7Oe4cFGViFDhVYROgijLBFv06ZD5Po+aLfnlX8sr4az79ZrezUdb3uwtBO40oC1i89HjC4MxK8Oou/CBxtXrgWKYf7iUhTAwda3AfuggYpEwpu28wLKG3sd4ByhYc6Nv5dLkb5yxwugNgAIy8kA20v11NXiTcV1AKkLe8aAaIQyShWOngoKp3/Z/pSyZBlCJSqp3ottQabrmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAi3pUvl+fkdUJ9Fplc7F90OIR43a4gfwWiiOHUfR0M=;
 b=dXjfA90aGoeJE55ByyqAj+qC61rWIqa3plhCjrbq3+afybQIqlFg41KjBM8wRHXUhZSIVPjDb/w/vkT9F9XVmLFmGZSL+QidURXeJ08pdezrglxnD6ij8j2hX+SrOdoYK5UIfyCwPA+ArBp7hQsd5r4txlWmVpY/tyxIQQ3fxcTDj8qpLiscmv02lD3QJD+UmLXfWuTQX6a9GetiOZ736WXITvYNkktfeSf65Wx6sfVRy5BGJ3r2+fVV3wPFCBzkeXly2v27foBoAtCOFZ7U6NoQDRgxu9t2HJseGMyCxJseoudsN/yjbO7+gHs8eLBWiHLDRJB3SQGXNKPEfMj1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAi3pUvl+fkdUJ9Fplc7F90OIR43a4gfwWiiOHUfR0M=;
 b=cCvjrBzc/ADMD7HBktJfoSQdzgMlvh6yuD7mszZfPjllNeJhRO8j33lJHvWwHQa1wxXNdfg7UIHWU6tiltZ1blkjN7xxkO+PpC6ZAveTVwgM5stBHnUcDGIdM1/TOtrQLhrpVDIhC9K/dWUSwGZbnCN3Yc8SVnYgXhOYOZE03JZStYczq8oUjvbK2t0nPzT0inkFhKFqhKnF1sPrA5i99Dj88K0ujOCfGtDiOeD5eNJYPxC4XCzJV85HEXSmyBg/MwrPfh8pUI98NT0LVi2Ud9eYySclC4UJQYwEmelQj51sqYz0+tnSDDp5oddnS5XGzuztzb+H2mREanCKZXljcg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7740.namprd02.prod.outlook.com (2603:10b6:806:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Wed, 18 Feb
 2026 04:17:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 04:17:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] mshv: refactor synic init and cleanup
Thread-Topic: [PATCH v4 1/2] mshv: refactor synic init and cleanup
Thread-Index: AQKdvUB/9mf9o/Y3llQwVwTGdfX7SgJVi12hs+rsbzA=
Date: Wed, 18 Feb 2026 04:17:23 +0000
Message-ID:
 <SN6PR02MB415781511D0B2A10FB9BB365D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260211170728.3056226-1-anirudh@anirudhrb.com>
 <20260211170728.3056226-2-anirudh@anirudhrb.com>
In-Reply-To: <20260211170728.3056226-2-anirudh@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7740:EE_
x-ms-office365-filtering-correlation-id: 4c06fb49-fe3e-4573-4fe9-08de6ea49df3
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc6c3c4/rztiZGf6bH6e/ZChEcp0LjMD69nm+DBHPikj01V/K83GX1jOlS6CKXmVtGUGPbYHLLLsyMRH2m1c6iLCyhf7v+wV6RpYDd2w7ipDnmWsOJgxu7o+udCmsgWbFk6Yg4ymerb9RAWHgUHC9y41HG2ttlPTizkxgwZ+JRY30m1Ut3O02ge5eg2amEf1MlZXhSnZS0TRY0fgk8wVGJSyjLQR0F1arSj4NAdSSxmoepADgxwIhLnb855OgUgAchUwiyZEKpwLrcYabh46Qe7BEo4fg2XDXHbaqQTpz2+ibUhZFLas8lMQZgtlHXqV+Pc6pNi5JE/vELtob4lbZC+5K85aPl4Kic+VBI2AcnFO6In5QfqK5RjyU1aumgjH7gshMK7b1kkpsg5CxxLInXdUfaWuihnCJPLSAVp1MnSJBEZCwm41tEiJHMmCUGk47/cbuD6N8U4zfc/EqmZyCqXcmkcZLwGK1Tb5S6y0hgDTW70MoArx84Ww7hHUHrkStJAtUIN3+j/7rJltFfwe9u1qzO7be6INKjTh3YL5qr1E2CxZgLQslt09wewyyOyX0RhYC29V06TwGN4knZ7K26HUksDDbGJNK2yubqHdoT7Et7M+eVra22U7skArPFACS6ow78kKtDFqqubbsVKpinXanG3RxAWN4b+AQSYZ/ciqz9S03EUpLyLWkvs4WGZCjU1npduRQ4S7hsuO9wRWKQAcG7uWpu4fYHRWk4zIfke6sUB47421F2+
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|13091999003|15080799012|8060799015|41001999006|31061999003|8062599012|19110799012|461199028|40105399003|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6ubv5Bgp2LgdkOnA22S5aCgAi/Q+F5Pnd7um2suCXI1zHMjKyAWBkrkbOvvB?=
 =?us-ascii?Q?f5caYzdIZtIlPim8MHKUH14WvTMGs+yZEHeTM+AUDBN6f5f81AE1MiwEjoRp?=
 =?us-ascii?Q?6IqZ4DeML7HgcZmP1a6BAA+ZxoTVsgvhdXuhN/0/KCoNYMBXngvHcKRBd/aE?=
 =?us-ascii?Q?7EfFOKlwcQuWOChafMrP8gkXrVKbb8P+jTRAfBB02vr3pfVdcRDc4AlL4tnv?=
 =?us-ascii?Q?c6lNMDwZvr2sPGKPoeF1JMrRuEAh/nc0egEXUl1cHrEpWvBV7GiJNF9F2mL2?=
 =?us-ascii?Q?x7O9UA59PDVJ/RWiVGh/iVVZ25Clco3/GISRup+gibsxezrC9DI1ZiTwLQwF?=
 =?us-ascii?Q?eLqbvXghHOQahRy5xAIsIj8Fkqa2HG5AX2EZb2EhSRS+9ByZxKHCN3iei8t1?=
 =?us-ascii?Q?cc8hvy3fgG8391wyABRaqJI1s9Bn9vTcoHLbnZ8XR3a4XQ36U03EzFssuFg3?=
 =?us-ascii?Q?li9Xv7oxIj9X9UdpCHqIaJDUHLSHPrQPbmcRkRhY4c1PSdoOsCdCUCtSzW3M?=
 =?us-ascii?Q?JFIft7CNEiVgwBRIl9WHIfK/I8kfa6GDc8yASUuFjgmkw6dB5NrVu3abAq2W?=
 =?us-ascii?Q?QY6QRbdVJgDjoCrFVDxBY38nSynxy+KJNk8CYK2tHwXWfoibBsIRs+Y4yByS?=
 =?us-ascii?Q?biUpzz+vmWNxS1Eb2p2hczEFDXiTlpMOYwHcX0buGwMEHJXkbAblFcsi078W?=
 =?us-ascii?Q?uxU9HOI9P4fZe0QO1IOxLBPvESNikdzFAlYTIAjpFPy6RoODEGSIcqol4epH?=
 =?us-ascii?Q?5Qx0oSsv1cYkdtWZjKB2IjC33D8SPvHhvsXTbojtYNl8y9MTRsAFaZcTkxZd?=
 =?us-ascii?Q?tNB/H3HBZuMqF7JLe/Vs5q3+wgITEfPkCahNu/P4E8Smw5LVuNIxOy4klAOq?=
 =?us-ascii?Q?355MFhRA/MiN3fL+VqV3YjkDpH39VoYRP2st8V1pbKtWsBDMDTFmwC/nxfhl?=
 =?us-ascii?Q?s2eiAhVN7bn6PW/cEqi4mRqENBOfDvbX/ekH8yv/nD1xwCMJBVoswAoLWQe7?=
 =?us-ascii?Q?g0k0XmqTWn0qNRrScpKJJhPIFjvETLNQuI8GQ8gr3Uvso8+sK49Erg7yszrZ?=
 =?us-ascii?Q?uU1ZPjBUuDupF3ChMkRIAav6rj26SYV4qDm7JEKU6XcIYLavfnfQbdtogHeg?=
 =?us-ascii?Q?cTPJjvHBSrY2sFOeqgY5rNFpOsEsKWgvHu2cGDjkw5hEzOjrN7dEcJxZPid6?=
 =?us-ascii?Q?ZCeL9rQBOLYhDsK3NE4HrkL6/B7VeineKvMQwjhPkPzmsw8zY9uBbTS70f33?=
 =?us-ascii?Q?e+c0NuItKLCguQtrjLY0hGL4XeTM9IADThZzkgt4VQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KRDewVP4X6YIYtaJL/dWad/7IZjZUj1ct3uq3dpDD+DIsPqHODK5sM+nlgYq?=
 =?us-ascii?Q?vQraosCDs+2+z99O/DQw233EKl9uODHZOorqo2zFnS9yqLQgP6www6TXdoE5?=
 =?us-ascii?Q?M8xmfiONJ6vcxoUchtiEZQ17a9ZamWA6JzfnFEUMbzLya4E3hxFC3rBmOJAw?=
 =?us-ascii?Q?4JgiQWhT2C6CwRjCMYmiK8hJSjWH24J7QxFaUWgibBTZfD6Yk29RfR21k+oP?=
 =?us-ascii?Q?lwnb6cNQ54ii+Hzmibl5+EIZbXWxjKikGXqLppR+4VcLYolwngg1C/42j1PD?=
 =?us-ascii?Q?+HTkRxvMtCskIYmkDOpmXQIn8pDu68imrkJ12W9RIQL8K1OQb/BJlMkcFdpw?=
 =?us-ascii?Q?pGuYXd7jxUYNBdxo++FU0zrCWDwxdgOSLMDwNOtvgEK8sLRWJUdy2VDt7naF?=
 =?us-ascii?Q?7wjVdoxQWybWcJnEqECZdiBoLaH9h9hNTOAR3Kcz/5kJIunlrpQLsw7Yejre?=
 =?us-ascii?Q?VJF+u0h5U6vZeRTr1eG4c4Wq+9c4bRpnyVYLM7jqn7x5Jj9L8coWTUgUi+jn?=
 =?us-ascii?Q?TkSthGDGrLCa/UFqEJeGuOJHEu25a+RiSSkSaIIGdumciGUyAFVqBqtzI6ap?=
 =?us-ascii?Q?tHKozVxuQ7SKRUye3b9yeJyFGzEGJ2GWeRvXmj3lQdAbTo0W1i0DAtwStgBF?=
 =?us-ascii?Q?xs+U4UWtnTnf3yWQNyRajzsQw860DhpyfU4lfV7w7SBVcsaPwdQCYA0OdeZR?=
 =?us-ascii?Q?pszQzXaIhVRBp/wlumkeGRtZv0zUkGbp1ID3ybk44vLsFHiOLbdRaVBLccWa?=
 =?us-ascii?Q?0v3H70jDSYpIlzdPf9fGpmezO4m7GSUybd5s/56xUANr2W6p499d94rUXiQl?=
 =?us-ascii?Q?79P+kXwD4FuzvKoNSmFHclePW9bX/eIL91nSpJk7RiO451y2PedHTz7+e456?=
 =?us-ascii?Q?F0530cdcPMoO/HAZN3Fa5FaTlZ+qlXP4+BwgkaFcUeInGnkpWLApA9a0s60S?=
 =?us-ascii?Q?a0eXY7+2BBPd1wf5nAum7MSoxQAZ+chgxBkwVDiIJVtDdPONf+2Sab0XkjDc?=
 =?us-ascii?Q?nE3aDq5u+RwmbvpknHAdq4ZBCzo1BAGlTsiAvZt1Dnf7H7stvTLVW1fEMxf5?=
 =?us-ascii?Q?BA4woqtBEsnlomXPnPGkU9FAl/rxqd/Uf7pBAmnIg3AuZLD3xdKAIOBFA/eD?=
 =?us-ascii?Q?I7GdlCDxLo1k3xInnP/AKe7oLEH8oTUkvhgrmC/azzyu+ZCEKeT4fQb102Rr?=
 =?us-ascii?Q?9MzFyJQgO0/vgS6UjmZLUFzSZo4c7KnvtRJXK8cxkVANQXz8GQ82mt2mYZUn?=
 =?us-ascii?Q?PMOAIlp+AeUZ6a/e9acbz7gt9wEJOqjgkRgXiWWA5g3XsBdPD4sO2EgVVxM4?=
 =?us-ascii?Q?+y+ry80Bud+xz2rxObMLuMKkV9UyxH7w9PRz4v/4KjA8LM/OQin06pMqIHli?=
 =?us-ascii?Q?YTug3Qw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c06fb49-fe3e-4573-4fe9-08de6ea49df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 04:17:23.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8877-lists,linux-hyperv=lfdr.de];
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
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudhrb.com:email]
X-Rspamd-Queue-Id: 06D9B152F2D
X-Rspamd-Action: no action

From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Wednesday, February =
11, 2026 9:07 AM
>=20
> Rename mshv_synic_init() to mshv_synic_cpu_init() and
> mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
> these functions handle per-cpu synic setup and teardown.
>=20
> Use mshv_synic_init/cleanup() to perform init/cleanup that is not per-cpu=
.
> Move all the synic related setup from mshv_parent_partition_init.
>=20
> Move the reboot notifier to mshv_synic.c because it currently only
> operates on the synic cpuhp state.
>=20
> Move out synic_pages from the global mshv_root since it's use is now

s/it's/its/

> completely local to mshv_synic.c.
>=20
> This is in preparation for the next patch which will add more stuff to
> mshv_synic_init().
>=20
> No functional change.
>=20
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_root.h      |  5 ++-
>  drivers/hv/mshv_root_main.c | 59 +++++-------------------------
>  drivers/hv/mshv_synic.c     | 71 +++++++++++++++++++++++++++++++++----
>  3 files changed, 75 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 3c1d88b36741..26e0320c8097 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -183,7 +183,6 @@ struct hv_synic_pages {
>  };
>=20
>  struct mshv_root {
> -	struct hv_synic_pages __percpu *synic_pages;
>  	spinlock_t pt_ht_lock;
>  	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
>  	struct hv_partition_property_vmm_capabilities vmm_caps;
> @@ -242,8 +241,8 @@ int mshv_register_doorbell(u64 partition_id, doorbell=
_cb_t doorbell_cb,
>  void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
>=20
>  void mshv_isr(void);
> -int mshv_synic_init(unsigned int cpu);
> -int mshv_synic_cleanup(unsigned int cpu);
> +int mshv_synic_init(struct device *dev);
> +void mshv_synic_cleanup(void);
>=20
>  static inline bool mshv_partition_encrypted(struct mshv_partition *parti=
tion)
>  {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 681b58154d5e..7c1666456e78 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2035,7 +2035,6 @@ mshv_dev_release(struct inode *inode, struct file *=
filp)
>  	return 0;
>  }
>=20
> -static int mshv_cpuhp_online;
>  static int mshv_root_sched_online;
>=20
>  static const char *scheduler_type_to_string(enum hv_scheduler_type type)
> @@ -2198,40 +2197,14 @@ root_scheduler_deinit(void)
>  	free_percpu(root_scheduler_output);
>  }
>=20
> -static int mshv_reboot_notify(struct notifier_block *nb,
> -			      unsigned long code, void *unused)
> -{
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -	return 0;
> -}
> -
> -struct notifier_block mshv_reboot_nb =3D {
> -	.notifier_call =3D mshv_reboot_notify,
> -};
> -
>  static void mshv_root_partition_exit(void)
>  {
> -	unregister_reboot_notifier(&mshv_reboot_nb);
>  	root_scheduler_deinit();
>  }
>=20
>  static int __init mshv_root_partition_init(struct device *dev)
>  {
> -	int err;
> -
> -	err =3D root_scheduler_init(dev);
> -	if (err)
> -		return err;
> -
> -	err =3D register_reboot_notifier(&mshv_reboot_nb);
> -	if (err)
> -		goto root_sched_deinit;
> -
> -	return 0;
> -
> -root_sched_deinit:
> -	root_scheduler_deinit();
> -	return err;
> +	return root_scheduler_init(dev);
>  }
>=20
>  static void mshv_init_vmm_caps(struct device *dev)
> @@ -2276,31 +2249,18 @@ static int __init mshv_parent_partition_init(void=
)
>  			MSHV_HV_MAX_VERSION);
>  	}
>=20
> -	mshv_root.synic_pages =3D alloc_percpu(struct hv_synic_pages);
> -	if (!mshv_root.synic_pages) {
> -		dev_err(dev, "Failed to allocate percpu synic page\n");
> -		ret =3D -ENOMEM;
> +	ret =3D mshv_synic_init(dev);
> +	if (ret)
>  		goto device_deregister;
> -	}
> -
> -	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> -				mshv_synic_init,
> -				mshv_synic_cleanup);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> -		goto free_synic_pages;
> -	}
> -
> -	mshv_cpuhp_online =3D ret;
>=20
>  	ret =3D mshv_retrieve_scheduler_type(dev);
>  	if (ret)
> -		goto remove_cpu_state;
> +		goto synic_cleanup;
>=20
>  	if (hv_root_partition())
>  		ret =3D mshv_root_partition_init(dev);
>  	if (ret)
> -		goto remove_cpu_state;
> +		goto synic_cleanup;
>=20
>  	mshv_init_vmm_caps(dev);
>=20
> @@ -2318,10 +2278,8 @@ static int __init mshv_parent_partition_init(void)
>  exit_partition:
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
> -remove_cpu_state:
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -free_synic_pages:
> -	free_percpu(mshv_root.synic_pages);
> +synic_cleanup:
> +	mshv_synic_cleanup();
>  device_deregister:
>  	misc_deregister(&mshv_dev);
>  	return ret;
> @@ -2335,8 +2293,7 @@ static void __exit mshv_parent_partition_exit(void)
>  	mshv_irqfd_wq_cleanup();
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -	free_percpu(mshv_root.synic_pages);
> +	mshv_synic_cleanup();
>  }
>=20
>  module_init(mshv_parent_partition_init);
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index f8b0337cdc82..074e37c48876 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -12,11 +12,16 @@
>  #include <linux/mm.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/reboot.h>
>  #include <asm/mshyperv.h>
>=20
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>=20
> +static int synic_cpuhp_online;
> +static struct hv_synic_pages __percpu *synic_pages;
> +
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
>  	struct hv_synic_event_ring_page **event_ring_page;
> @@ -26,7 +31,7 @@ static u32 synic_event_ring_get_queued_port(u32 sint_in=
dex)
>  	u32 message;
>  	u8 tail;
>=20
> -	spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	spages =3D this_cpu_ptr(synic_pages);
>  	event_ring_page =3D &spages->synic_event_ring_page;
>  	synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>=20
> @@ -393,7 +398,7 @@ mshv_intercept_isr(struct hv_message *msg)
>=20
>  void mshv_isr(void)
>  {
> -	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_message *msg;
>  	bool handled;
> @@ -446,7 +451,7 @@ void mshv_isr(void)
>  	}
>  }
>=20
> -int mshv_synic_init(unsigned int cpu)
> +static int mshv_synic_cpu_init(unsigned int cpu)
>  {
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> @@ -455,7 +460,7 @@ int mshv_synic_init(unsigned int cpu)
>  	union hv_synic_sint sint;
>  #endif
>  	union hv_synic_scontrol sctrl;
> -	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  			&spages->synic_event_flags_page;
> @@ -542,14 +547,14 @@ int mshv_synic_init(unsigned int cpu)
>  	return -EFAULT;
>  }
>=20
> -int mshv_synic_cleanup(unsigned int cpu)
> +static int mshv_synic_cpu_exit(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
>  	union hv_synic_scontrol sctrl;
> -	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  		&spages->synic_event_flags_page;
> @@ -663,3 +668,57 @@ mshv_unregister_doorbell(u64 partition_id, int doorb=
ell_portid)
>=20
>  	mshv_portid_free(doorbell_portid);
>  }
> +
> +static int mshv_synic_reboot_notify(struct notifier_block *nb,
> +			      unsigned long code, void *unused)
> +{
> +	if (!hv_root_partition())
> +		return 0;

I'm curious as to why the synic is cleaned up only for the root partition,
but not for L1VH parents. L1VH parents *do* cleanup their synic in
mshv_parent_partition_exit(). I probably don't understand all the
vagaries of L1VH parents ....

> +
> +	cpuhp_remove_state(synic_cpuhp_online);
> +	return 0;
> +}
> +
> +static struct notifier_block mshv_synic_reboot_nb =3D {
> +	.notifier_call =3D mshv_synic_reboot_notify,
> +};
> +
> +int __init mshv_synic_init(struct device *dev)
> +{
> +	int ret =3D 0;
> +
> +	synic_pages =3D alloc_percpu(struct hv_synic_pages);
> +	if (!synic_pages) {
> +		dev_err(dev, "Failed to allocate percpu synic page\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> +				mshv_synic_cpu_init,
> +				mshv_synic_cpu_exit);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> +		goto free_synic_pages;
> +	}
> +
> +	synic_cpuhp_online =3D ret;
> +
> +	ret =3D register_reboot_notifier(&mshv_synic_reboot_nb);
> +	if (ret)
> +		goto remove_cpuhp_state;
> +
> +	return 0;
> +
> +remove_cpuhp_state:
> +	cpuhp_remove_state(synic_cpuhp_online);
> +free_synic_pages:
> +	free_percpu(synic_pages);
> +	return ret;
> +}
> +
> +void mshv_synic_cleanup(void)
> +{
> +	unregister_reboot_notifier(&mshv_synic_reboot_nb);
> +	cpuhp_remove_state(synic_cpuhp_online);
> +	free_percpu(synic_pages);
> +}
> --
> 2.34.1
>=20


