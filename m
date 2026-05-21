Return-Path: <linux-hyperv+bounces-11149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDI8LtF2D2pEMgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11149-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:19:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CC5AC164
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641F5300A10E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17E2BDC29;
	Thu, 21 May 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CFfy3KiJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011026.outbound.protection.outlook.com [52.103.14.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AA1FC7;
	Thu, 21 May 2026 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398278; cv=fail; b=kvKzD4QerXDMuSo0eosdXpAubJZfgEoUQgKG7xaywgYaKc6CjoRYcdql0c7cWPML0kWXz0E1u+brX7KYp7LzwAQR6tbqxMtxHFYpNfS6AFQw1LhK6AReK7XMK2oFprTdEPPjTHb3NpI2h+tvtNNB2OgbEDV39BRdROstQNKe4CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398278; c=relaxed/simple;
	bh=PZ9QGk4DFtV74HdEKxolMdSS3W0+AJszVBpz5uoBUgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QGc0aBFyKC5wxcfmQ3pVrQVdaAZyf4bX2WAId7FMFjnDqNJBmXFAvIjLPqmUpKSFOWnx3CRobYAktoVAjmyZ2ctwsqFfT7mRDzAWDyF7wolHImKrUUcUGQWhUGQmnFZqYsonqisLkhVFWNMTWLFGeLIrgZtgm1HFkk1HjaBC9/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CFfy3KiJ; arc=fail smtp.client-ip=52.103.14.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0f62vytwz40aC7MXci1XzoX0W3F1ptrbRq2V1KOm2uMgg6TdXotcYIbkEkb0EndaWaAbq4I2ethIJZkoxTOnwb7Iv24y/fKboJfV70UAI+hyECzjfxdzlsS19jBsVMLE9rF956VjEaUelguXNqwm9MO3BIFabTSWWePrYgSL9HO/cC0IoVOu/+0XydOsCcvW9DO0NlWfdwGBXbbME8zW7JXwbkORBOJYqT3rrkaCFrw0Fyw+bqmBEXT6+nesrHW43+C/xYQj8UA+PxfpCYxWuBN5sq0ZfhEBNNzWz/ssZ/AlOrQ0WnzjuCE7c6SMb5qIOLy0Oz0ZPhTvy92szJYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KB9sqsy2qD3wpq/LY4hCqbeFWChS1qBG1qjsVS820I=;
 b=TppsW+ilPD9TxAtonZLTCX0SIaWmKp9wuHY1PGQre6HMOnjO9GeEnnMWcVROXdrfSxYiSt4wBQ3VTQRtdcfaXLnc+PYqhr51O9LKe0w/x53Rm4PaXGi98ar6yjj2V7WXCJK6GALkFFZMLWakTwoKPGO+BNIv5TON3cjAMQK5kKMkCTviY/1sG9xkUDIbt+Ftursw6ybb3MeQP7RRSj+Gc30JZKewpr963sUuUa624ueLJjP6tTUWolJtySBWvyIUDana4IGIznzxyOjkv2DcEaMfmz1lqetDeY1ChMScZHe9woYcx3P/yAqLTUr2gNDzpP4UyTaSJoHIwacjFGPZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KB9sqsy2qD3wpq/LY4hCqbeFWChS1qBG1qjsVS820I=;
 b=CFfy3KiJ+yz8R+Iw/mn+GQdCLaktHUwJL5oZNtsowF6ZRcJJaQNq5SAMJF/IvsXxrNI8qxE2CvSY9l/JfaMcWFiPC15HW0iGuH5EP5MohMw6N7M4HSNL8mS09EK8IiSuBkbbiY/JCdVzlxhHEQwW1+X1OsAELmigiS/ZifKN/hjRae80evirL0ZJ4zc4VXep/H8HMAAkwClw2dsxPLWh/N8Vu/qZrUrXRVBR/ibceIFFCQIgNq3Kux8uum4ii/2PibNvhe0zUW3C0LIZKN+2MOvwu4BtWcwkmZQCWhvF18h3QFWlvrJRe6K577cjBNpxqumf/XEleGWTT23zh87htQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7760.namprd02.prod.outlook.com (2603:10b6:a03:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 21:17:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 21:17:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Arnd Bergmann <arnd@arndb.de>, Michael Kelley <mhklinux@outlook.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, Jork Loeser
	<jloeser@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hamzamahfooz@linux.microsoft.com" <hamzamahfooz@linux.microsoft.com>
Subject: RE: [PATCH 1/1] mshv: Add conditional VMBus dependency
Thread-Topic: [PATCH 1/1] mshv: Add conditional VMBus dependency
Thread-Index: AQG4jg1Jq/Gd2s2baPWUcHBZQDE2SrZhoQ2AgAARZDA=
Date: Thu, 21 May 2026 21:17:50 +0000
Message-ID:
 <SN6PR02MB4157ADD681997EF9BE9B27E7D40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260521164921.1995-1-mhklkml@zohomail.com>
 <b3c6144a-beb1-44ff-9a7d-bad61a1b3829@app.fastmail.com>
In-Reply-To: <b3c6144a-beb1-44ff-9a7d-bad61a1b3829@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7760:EE_
x-ms-office365-filtering-correlation-id: 96566132-a1d5-4070-4394-08deb77e6a21
x-ms-exchange-slblob-mailprops:
 laRBL560oLTZatMSWrhMZvsB0WULXGfYRGEiSQh2cyyvG0RtwiTDTXypQHSIJRETKti38XpKYq5wmy1iBL6Z0Wt7YJzKtqlsF0Ha43DYiGIH1UiOA++2mrP4JK5SOltSv3oXUhTfaprU8pZGyp2KDKvbTpGlD5ge/dgbp14sHtkHz7LsmSYYFIfiC+KupD8QBU67iiEXIEvFkPnmb2S9h1JY4HxiXZGV5/PyiLZT0tMyqKC8D9P/YYwBtvj3vnAHYk0RnYxa9ux2LlAOolJXlS+Ab1szrNZq1FYOnD5pN/INFUS7dRg6D8Lm/cPlHdIqK7jskHNVJV59imvXTt7xLXv+tgOTC8KwUrgVuNDHDMTUpy8YLH8lSM7Pp9mN8ABBkXAiu55Pvf79WhxuJ48i1hX4Q+trM+DKHk4pAnn4/ELuaNvdqfP6imBoEKDVzFwRf+Gov8StGN9MrAAptmz8yUR6nPcMkiOzC+Nlf4B83J28mRDLRIYW9LnFT13/mladdpti05JHN06oqbJ1rCUS45rvwrwd8r/oXrFe89f+zV8Qvf3gi2BBtFYosKl6QH0jwy9Xwk4Qa90xA45KcH6ogQjjQWe4cJxeDMXguFetZ0IHmzrYSga4RiGPENeLMgfnauvOJKKfWOynYrS9+92QPbHb7fGVehJnccXr7EPS+3r1xx10LYE7e+G20G4I330PhtJrCC1zyEO2hy9I12QW990eQ9HugBLuTUPkxsZZuSSPuth3kMpp7KqrVGdKtSaIX9SyMNT6l0jbVzAFa81ooWwm/b4KpzHu
x-microsoft-antispam:
 BCL:0;ARA:14566002|19101099003|51005399006|31061999003|37011999003|12121999013|13091999003|8060799015|15080799012|8062599012|19110799012|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KmtNnEf5DBKd1F8BNKYxoTPjaONyrB39Tt8dPsUSTMsSaVXKchiocSAJGGxB?=
 =?us-ascii?Q?NTm9J6LJbGBE5EV18GyMep4BPPFYYT+YSzNg5uhFl/DcC6SDrUR1qIw21Nn0?=
 =?us-ascii?Q?YuT9XkUOin5upBIrqmaKl4kuOY1kJTr9yGUv6onV39FrqqWvzK36Nq1d62GN?=
 =?us-ascii?Q?WIJwg8DbrdnFbdG5D+fagdNHluSHGs37671XA/RgL6JNR4Ss5W9e6Uwi7Rvh?=
 =?us-ascii?Q?1Ut6ZhexW5NXGErmqOKmtH201b0UxBDUdoX4tzky/mk4/NhzI9YZPCunppPU?=
 =?us-ascii?Q?VQJx9JUg3+GI0YnR2yAtcoq1TEpe7PHSsHCZhONXPjjUYQbdG4s0niKv9s+I?=
 =?us-ascii?Q?LutG4SJAVl1/MJdxQHUPl6MK929ogT0QqUEsMM1IdDJwSnTp2UeFi9hJT2jh?=
 =?us-ascii?Q?8bg9GX0/9gR7GPDm8Jk+4X4vdJYgeqmy9TpkBbx6lIrxyFc2eUgyax50ryhO?=
 =?us-ascii?Q?tKhm8vX/6YBeelcdp4kOWbdww450pMoeB6E66kEFstuxNbuCUIBxd2ygIG5D?=
 =?us-ascii?Q?cIM+7Ku6mdTJxhWaABS502Az/AKU5smFTVgg9P80/Ixl66bboSshl4yONWN1?=
 =?us-ascii?Q?z1JUE2r3+iLsnkP0l36thoDgOaPZKumu2ix52beDV122dhWFvXNfAaeF907L?=
 =?us-ascii?Q?f+Uy5DL0upsaO6+xtiOySMwNckpYY+ZHLnbjNfcqWQQG7a3c3KpDE0J+6tmN?=
 =?us-ascii?Q?sA2upFsqN479jjt1UrMvsD62GftkxMdUIEtj6V04OqMxwEnii077lC1ad2Dd?=
 =?us-ascii?Q?q+Qeo8aAL7otK06wRkly+Th9mOyqqtf0K62z/v+x7trrxZLdXx0EX2xZHiq5?=
 =?us-ascii?Q?wppO1YulFhpP2Qhn6LLeiThwzBo+wYrycKQ3wxbrfBnX8/f6g9ZH2zOejjen?=
 =?us-ascii?Q?KXggg7v615HAdcxgFIkZe0HOb8ioPADOW3xtlYtzVQWLh1UwXJT3LMHfZ/wH?=
 =?us-ascii?Q?DhtLm3+REXRdPYAwxsd1NsLvqs082Ja6NjyaMHBL3+SsMHaxNGsbj8gx/nHu?=
 =?us-ascii?Q?cHVf8oVtbuiqrNG20EWPn7AOLJWAzI/FnIf/B1osVCn3A4s4oiYuPiqThykW?=
 =?us-ascii?Q?lOrLzjpHdvsP2fdSDNhA2fu0/N6mS47opX/opMXfzPu0uukmmN7WaU8MMIF+?=
 =?us-ascii?Q?dk+04Wit0oQcR0sfvi2TXx6iXZfh7CXFeRwdf7wdDF0SYlLT7KhRA3Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OT765bteostBM+FIaTRx0UJpg/BUbDJtlSgvUbSN1Rr5dE4q5NxHST0nLFmR?=
 =?us-ascii?Q?znevqjtHD4+Vn/JixAMdteLobBlF8KCS/cE9eeZ2zlmHu5KkfAz0CVrtTxVF?=
 =?us-ascii?Q?KD80R4IEh4FkELd1w6Fnl1nzIQrN8MVSe/QcUsjgaXIWr8G04qzLxIVJs8dn?=
 =?us-ascii?Q?83tPRsY1j7AKF2bTyWtsfln8c1oe0psWYlt0i9gO/R2rTVaHQYaKGvfHUrGU?=
 =?us-ascii?Q?naF2svhfZ/rMrXW9FBc2on8/EJwVVdmmGT6C8zJSAHVryu9k/Pk3iMJovMMn?=
 =?us-ascii?Q?RaauI4hFJktWbQ9AR37552NxLYco4fJH/jtqTc5uc1xXpcD6ooa2bvhR8zWA?=
 =?us-ascii?Q?qlD+nGYZl3T8FswHOAHiqAFyOd8mRjxE+exGKLp0lvaPxX6SjOQ/j/tWI/XB?=
 =?us-ascii?Q?v87vIZb5ulKx8GBhaGqDIqnY3ckRzJqypkXoAay28/YXqq/r//A+9ohlT0F7?=
 =?us-ascii?Q?9N2Xe6qa2WRfITFidkTgWP6wjT2mSMuF+YvC0Z95cbOhejyO1vCRYMKOIm2K?=
 =?us-ascii?Q?h9L1gp6tuOAxO22NPyG5DVGp0l2QDJOjy5fv37/+scZ2VrIm02K+0q618TaJ?=
 =?us-ascii?Q?pS8JYj7cUBf8zILPUizhhxfYVI1V/zf+jqM9uxTMVZyFBWTQ2/O1McUEBiCy?=
 =?us-ascii?Q?PoJMirWMORKy7rR1FLhStNxyarG/QitoocqJJSgaSq2flwG/2o+vKBXTJeln?=
 =?us-ascii?Q?Ej1nqU4oChCGOGHFEH7rKLbIZhVsI4+/aCyGYR5ymMKPInYnt5DfVk8/Og2o?=
 =?us-ascii?Q?X463ou/8mOr2+gNsm4s+1qBp7mgFvWLiJCJ6AOLEcEXj41QrzoXh+qsKWWeh?=
 =?us-ascii?Q?HmQCqrufQW+TmLLI8OKGg8FxEcTcWVcFEWRKiRuw+JJ59be4S54h4xjIec2h?=
 =?us-ascii?Q?7+uHWLYIBdNJsmUkjfKsVxPymKPL5bOrnBc3XhQnNCH17s4qx1/ayez4Kk2r?=
 =?us-ascii?Q?ouZDvD3FIcL4k5HYVmy3cjbDkeYvW/RVVV/rYvuA86maji2I4zYUozkQrcZH?=
 =?us-ascii?Q?vOiYf8PzbzY+MzcT9ZIEWyMos+Gs2sbZzYU/kKaf2uDyQjAcQW3ZWhKrppJj?=
 =?us-ascii?Q?NQJHwW4PINWzqIly9gpRz6EuDKUuEY6AqjxV887fXIO8h3mRBgisCNWAG+MY?=
 =?us-ascii?Q?wO7dkK0wkEuSEwzC9FE899j0LTZfUL8iTV8bPMZ8Ad+W9nTyj/2EcfMwcm7e?=
 =?us-ascii?Q?nv+6rwgGX+OfYHLNFsjE/Zlud5zqShAYeLs1XI1LTlK5Vzw3uOSoJMWGXVVq?=
 =?us-ascii?Q?EeuHLU4wVk9j+oWX6I5RKK3Tm2B9Yvmz5GtrbSfYT5udaHV8tEEx+Ji4hsVi?=
 =?us-ascii?Q?x8muL+aEWbuDkhVuJUYraBNyBQVRxKyyBBiBpiaWRDQycPskDYthdv3WCDM2?=
 =?us-ascii?Q?OctlSt4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96566132-a1d5-4070-4394-08deb77e6a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 21:17:50.7220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7760
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11149-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[arndb.de,outlook.com,microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arndb.de:email,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: 181CC5AC164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de> Sent: Thursday, May 21, 2026 1:16 PM
>=20
> On Thu, May 21, 2026, at 18:49, Michael Kelley wrote:
> >
> > Existing code ensures that the VMBus driver loads first if it is
> > built-in. The VMBus driver uses subsys_initcall(), which is
> > initcall level 4. The MSHV root driver uses module_init(), which
> > becomes device_init() when built-in, and device_init() is
> > initcall level 6.
> >
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Closes: https://lore.kernel.org/all/20260520074044.923728-1-arnd@kernel=
.org/
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>=20
> Looks good to me, thanks for fixing it!
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> >  	/*
> >  	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
> >  	 * See hv_hyp_synic_enable_regs() for that initialization.
> >  	 */
> > -	bool vmbus_active =3D hv_vmbus_exists();
> > +#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
> > +	vmbus_active =3D hv_vmbus_exists();
> > +#endif
>=20
> I would usually write this as
>=20
>         if (IS_ENABLED(CONFIG_HYPERV_VMBUS))
>                   vmbus_active =3D hv_vmbus_exists();
>=20
> for readability, since the hv_vmbus_exists() declarations is still
> visible and the IS_ENABLED() check avoids the link failure.
>=20

I thought about doing that, but wasn't sure it would work. There
are nuances of #ifdef vs. #if IS_ENABLED() vs. if (IS_ENABLED())
that I haven't learned. :-(

I'll wait a few days to see if any comments come in from Jork
Jork or other MSFT folks, and then spin a v2 with your change
so the cleaner version is what goes upstream.

Thanks!

Michael

