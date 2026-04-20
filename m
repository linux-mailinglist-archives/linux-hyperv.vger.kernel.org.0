Return-Path: <linux-hyperv+bounces-10206-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNNdD/m25WkonQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10206-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 07:17:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24355426D32
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 07:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10EFC30028C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 05:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409F254B18;
	Mon, 20 Apr 2026 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oFB9Oo8P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010015.outbound.protection.outlook.com [52.103.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315E214204;
	Mon, 20 Apr 2026 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662259; cv=fail; b=Z9m7P91dWele1hqvUURp+Op2JhHuKCtdTjzgigx8XhQo5EUVsMJKj0t+L9xFhdWnHvcLuCR5037v6ALM74z4pygA27GhODIPHOq8HhsA+87+l7TkLPBcPw9R0Exog2O9WGYCB16ODoTpKMqZb/4RYfcBigmMFb/Xb/3mvibeARs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662259; c=relaxed/simple;
	bh=CV41YN+XnYvZnJVXsNY2ETacFgES4O8Mn+dZ3aYV+IQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4O3qHWEL1VKHQyMg3IXxDRF7RvcNg5Eoogwnxgb5JPK9kGFRHu79YFqy2pEdueO61mQGHLxW7Onxgfbe6KxWuy+Gjbu96GY6hm5LaVJ8SlJCW8jHWePc0onz64/xMQpc/rBpqzNydANtqM3Bd7bY6V7jGzV9YmFxmU8ONgrZ50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oFB9Oo8P; arc=fail smtp.client-ip=52.103.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0Dney5euUTJ/sIoutyJ4+M8HPeYkuaK1Vo6+6msKGAzfEIEA1ZdbzSgU4SxRE1dH1FOf/PGVohJUTvrnvRqc8O+jnL/aYre+i4dUtn+cXtqsfzlDU+FaMMXcPHNGoz74JjY9sgWpmGV9HioR8lPXzptPff/947bVgc9oDe6SZE3YOiYbgJcpucj35+UUQ3Rc6n9tc0V2pDCS+xP0QIAOc1JtknE4BLz5CwC3ZkTB0Pr1XkqYyxOtKd16k5F9mKAuSwVkGkIc25aRNkrg0m+Ouw/ds6LNdkpdSqT3S9oDCp6dzwWXRA9jvQ0OhfrxhNjU9uivSjS9wR+5YTNY8hgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV41YN+XnYvZnJVXsNY2ETacFgES4O8Mn+dZ3aYV+IQ=;
 b=MFFgbpWNh0GTb4gdOTKIQaDkQg47x08Y9DGaiOBadiwV7V0TS3rdGk1xjJ+Pf7aj+7kNZpo8SnS8Sc+TYVJESVThgqG0GPwuaNeVBYH2HwMXJ5QLOmqfbdSZxWm9TpEYvntm991neTNxett8zik1WGD1sTBTNtTFhaU4Z/rKatq6DdUEfivO3jlNOvBQuuYy712W04g86W2NemaJeJafGatY/3eVW2K937ta8NKuSz/BGN4lsgW1vXGQwxzYrOlve6GPelLa56HG8f0bCrEXaMWyIvF3n8bv/B7+QhQxAiTGC0kI5lZ6wBQP1a4PXlhNwIYXATY1nhW0XkMhzHIPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV41YN+XnYvZnJVXsNY2ETacFgES4O8Mn+dZ3aYV+IQ=;
 b=oFB9Oo8PkcDksKemTSKqxdTwpu7ZWuqD1gTzg2JIq150wamh2WXTQob+aPHpUKtt0tbsGr7hWNVyMJ3wCLjTdowUag6Im708+hTgSXd6omxFx4iKTdqkBgjfkfYtANlsn7/ffwvW58AEk7hxMz7OGL3QUV2QB+t26MteFtYvzqkF6i6807p3RbZPLhoJjD9Q+AX0EYNOyGelDLcGrA0r3VLlvUnzO/EG3rFNVsou8JiJO+8Tuesd4HsbCk6BIdquD38Q1rHTcja04adI9OkoQZ/yYaFH7IuMJH3oGbe4kb5ivhhzNLU4bbMAfkNYzDY3FmuaeSVWnDX9LGuxisERBA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB8668.ausprd01.prod.outlook.com (2603:10c6:10:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:17:32 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:17:32 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "vdso@mailbox.org" <vdso@mailbox.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>, Mukesh Rathor
	<mrathor@linux.microsoft.com>, Muminul Islam <muislam@microsoft.com>, Praveen
 K Paladugu <prapal@linux.microsoft.com>, Jinank Jain
	<jinankjain@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Thread-Topic: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Thread-Index:
 AQHcvpRNbg/7iVrB0UyyX/rVQKTUD7XMcrMAgAs+NQCAAbOYgIADYYUAgACehQCACig7gA==
Date: Mon, 20 Apr 2026 05:17:32 +0000
Message-ID: <187B9D74-7D45-403B-BBB1-3B89634517B4@outlook.com>
References:
 <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <ac76zlXjXhPVkA6f@skinsburskii.localdomain>
 <89730D18-D9A3-4A18-87DD-E7A51625FF69@outlook.com>
 <319614096.43465.1775883935863@app.mailbox.org>
 <19EDB8B0-A6F4-460F-8ABA-E9D3E239511B@outlook.com>
 <1644495552.14476.1776103846016@app.mailbox.org>
In-Reply-To: <1644495552.14476.1776103846016@app.mailbox.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY0PR01MB8668:EE_
x-ms-office365-filtering-correlation-id: 5ab2a3f7-0187-480f-f5b8-08de9e9c201f
x-microsoft-antispam:
 BCL:0;ARA:14566002|24121999003|22091999003|51005399006|461199028|8062599012|19110799012|8060799015|15080799012|31061999003|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JnMMcqgvLZ2x5sABgd+h/MsCi7/UEIsUUVkab6UEO1eCn8aOKjtxDGy1cbFo?=
 =?us-ascii?Q?RLpnVqsNxsEzTA08eCfZaLSWK6vxppfVL6VmR4iul4IsrxW2L49Y9DWR6L65?=
 =?us-ascii?Q?bB8wBG+iZ3Aornc4U7GxndstfDsVmDqpzoSk/QXW1KfexpzbMHkHceReRd1n?=
 =?us-ascii?Q?THnBFSiE8ePUj2UMbgv06URsjydKZS8oTGs7KAGFDeipt0qqgjg1uJErM53u?=
 =?us-ascii?Q?5NUnBqAgHQHK9K+zOxBkzE34CmkFefxP85S92vggzuQaNQOrErhZCDN9z6QE?=
 =?us-ascii?Q?uu3GT6zurjoscDH2j3oR9+D/BHYfLzSWYHrp8i24qvmFGrO8bPoMjmAfc7dt?=
 =?us-ascii?Q?t93QzcDC1JD6DoK+7LLXBStKC97UVcBJH4phTq59fJOFNPdIGp3UuQYKXqyt?=
 =?us-ascii?Q?eQxg9JL4LTa9gJ0WwWQEcvVvd/aayz/JuyyZTAWhotLz7EwNzQSk9InUfnms?=
 =?us-ascii?Q?57Tlqjm8eslbKWCo9hNyWe/cZwUz885xfgZcAEd7MjPOwx52oKM9Vv8FXoLY?=
 =?us-ascii?Q?QJwSVqSb9oY39RU4A+vuiiZvwurpsB8mDYgA0yo9pl0FRTwXO7tFy97XTe4R?=
 =?us-ascii?Q?gTPd1XgQ6QQ5ymECER60G+1WiwKAPZvzXK0F3RduclAi9WVqFaHqgGIPtuZq?=
 =?us-ascii?Q?qu52BAcE2tPUYdvSCM4bSWFlN1IJ0Laughujl8lp1VzAVF7UeRlC6swgs0TM?=
 =?us-ascii?Q?TXBbBqxqYxhhNibIMoqHQD+kRLES/zcp63l9khfZrZ7oRaw9cIFNbepd+apo?=
 =?us-ascii?Q?AbUqMpB41K10TZRMUf2BhRnRSoknnRWgKULvPgZoQ8BW5GPeNgMkUp95Dt2n?=
 =?us-ascii?Q?Y50bZv6mObujv176dKchYWZg0OsN/MmS5//fKKgN0/Q5x5MzLKJuMFFQsteI?=
 =?us-ascii?Q?TahrWgiilApjoMF6kTTMt7YzsCiNDDb6NG+HL8WOpjrRzp/6TSWN+EFNGsh4?=
 =?us-ascii?Q?8BPFC6Zud0BzIL9KWaRMXUYiAhe8XIoVRf1ZyvhYQt0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aAwLpOzy1MA1QHtuYQO/OjxTONwMzWycm3OATM3EkZiabg5I8FEU4Q5zQrrl?=
 =?us-ascii?Q?3E53v/vyWHcL33yzvSY/sAZBGP7KhCMzQ7j2ms0XknOQrIMPUsgFBGbwbVvq?=
 =?us-ascii?Q?11Kw4kkl/YjNCGl8c80NAa6UXVdgCY+jCKwl5lHCFZmdx9mr+2s7OWW//8sk?=
 =?us-ascii?Q?JhdC/+qzFNQLKcaiJZVbqT5LvKx6q7CEIKDuXs8JwJCz7KGTDu/zpich86GA?=
 =?us-ascii?Q?57X07GE1Bh5VJ42dvPIR+9/Jn5aqwpz84jO+T4cS3zkhFj7O/7W04qo2w8q4?=
 =?us-ascii?Q?m1W1u5sSpmFuRBTqdTpgd3jaxr67Rako9AZyF3LV3OVkC2WT2++lVZu/ZSX7?=
 =?us-ascii?Q?3h32pkzKoTGxqspzIYRnfkANGrdv3og4l21hSnCNb9gr0t0hHDxGyqwruIdn?=
 =?us-ascii?Q?XEjqRrM2Nu0p4mxxS5tgoYSi8qglAAHTIyTqxNzoDRhwoqrfp7JoDPLFPHVf?=
 =?us-ascii?Q?8CLc3BSsPuT+36tbpRHdP1xD4mCuya/Lbewdm0NCU9gtd7+SC5rPnQCambaE?=
 =?us-ascii?Q?8ZB2/GPeGnYzkO6tUTg5l3ibf2YE/g6S7DjsoWeIR1HGXqeLW+fxeIvH8uR1?=
 =?us-ascii?Q?whwK5IYdo+z+22ifpZxtTtWaxLuwAg1nQlOg615bnvvJpBXmAb56HQkqWEJR?=
 =?us-ascii?Q?tOfEsn89F1koZRPRFn0NdNQfsAWgxsTTiUTtq05XihgYLWQv2ZzHlKpLXZck?=
 =?us-ascii?Q?jin5A5RmN95qwuNJ16tVf9QKKwRn9UyRl19iWzwbIs7iJY1BmkLrTP8fKxcF?=
 =?us-ascii?Q?kq4W0RMwE5SCidDOH8PFTPgF2UFW5pOzpLlzbb1GgSRSUG51KHhxJBc353sX?=
 =?us-ascii?Q?hz9IIiiUktrmBhkDQy0pjfV84a+HGlUGwD5mZRQAPC7YMTTNQsv8107KaZFM?=
 =?us-ascii?Q?ekVtXJs6cm+fZGjWojOqPGyn8PHaAeKg+HBO7C4c2intsxcs47afOJgkamm7?=
 =?us-ascii?Q?/W5TnYsWrGbRPNSHQUup9mvfIB9yc9tfESgfIsVgP6T++ygnWsXVY7B1Nj2L?=
 =?us-ascii?Q?zxlu/kHk22tM+fJ7/SgHhKC2e3jCTt4M2jcD2bRse69ehNmgmf3a0FTHkRu5?=
 =?us-ascii?Q?ExXgFhTpBHcaNM/xeyAHKAKlTmIzjDbPcGvp2ILbkQWfJQ+wAM5f6jBKdwWm?=
 =?us-ascii?Q?F9V9LfNdnUu2EFtNCZoDltM7YlZVGVi5ieNcFHmLrEG4FcILiyu8NZi+pc5y?=
 =?us-ascii?Q?iiUnzNnJwYTEpXckYpf4kCz56OY3WY9cLM/2Notjf+X3CMtieJFonO84XL5U?=
 =?us-ascii?Q?c3MupcgThxTDH3CQzjajceHAq4JcCxo3pu8Vlxczj0GMa8+17JwAoCVSPzpQ?=
 =?us-ascii?Q?avmLAkjV3x6sJ4d8xvgSp0HjpmZ78C3LNmo+ejZvdLduQdKTkeUfVQUXksuu?=
 =?us-ascii?Q?Tbbq1bhscXtrgfcCcEkfTujImKH8BZNP31MLHVUWQakFc0siww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AB821A2754A6842AECCDD56B7BD20E7@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab2a3f7-0187-480f-f5b8-08de9e9c201f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 05:17:32.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB8668
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10206-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[mailbox.org,microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: 24355426D32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stanislav,

Gentle ping on this. Does this approach work for you?

Thanks,
Junrui Luo

