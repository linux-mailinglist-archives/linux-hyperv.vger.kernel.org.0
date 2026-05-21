Return-Path: <linux-hyperv+bounces-11137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NvWM0JPD2orJAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11137-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:30:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3435D5AB0ED
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6B23178C1B
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FE39BFF4;
	Thu, 21 May 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HFhJN2Uw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013067.outbound.protection.outlook.com [52.103.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A8360ECA;
	Thu, 21 May 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383948; cv=fail; b=bBRq1HIZs5gU98B8sKLKyByfF7UJ0Fy07HtfXRsZii83uq38kqzND1jWq2ZzaldN28vzdAlx4oC5J20UnJ3CrT+7CACbfHrgGVV857G/O1+wHxjL+H3qf4/dYGSOwcdHR1XPLL/iYrL3KnT0c3aHVe1zZQc0sD+SnyJM5p7GreU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383948; c=relaxed/simple;
	bh=hYtzkNX1Z16+5sir2LGAQowoMvLlYGwTNGme6Cm/TXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAJnFSpOazZpT2w2NUo5Ja48eAcuOJKhGoKQABEZ6JK2jOvkNdTWk1pafspRqiacY/GGaBRBf+/ChBiYgxVsFGs6GtbHpwgM28rz/DyUkNzk4ymNZWNnKjgYuqblM6AP8UdmYwW96DAd8waAq95fjV/wWD7KSWceevPo5A42fMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HFhJN2Uw; arc=fail smtp.client-ip=52.103.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7wBJS6AKXKoPtVj7Y7UTBJUhjiy+ibH+Xn2EZvb2I5o9zlOBqRANUFlGS4iTwfNMJILBVMRS9n/NMSEvgsfmqtIqSoQHr7XjgJ4s1bdtw+iPCalOAHyoPjts0q4lkWmSj6UJGapsvhBOrs2a1vPzNVch8fnTuTeRqPZtqfbqi/zCnet9IVAK4PCc04CRWhWupK2YcU1Ew+i+7VRdolqGba8o1RVmr1hbYNrN/0HZe16zGIiZi/TxnkwR5md973ho2xvRn9XJPF/ev65InQhvbdc/GR/heaoU/8v7qNSFquXxkh5J6W69wWzyvtwRDWB9dudtJVlM3nw0Get3owFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ypENyYp7QHoZaRZpMdt2X/LsakFgKUb3XLbJKPohns=;
 b=i3TOz9rhK5AGt82rBvHkI1o72eA+3LXnTRzEmjONkGDCpoqMxcl720m83SBCdRJn2q5irET+7WBzUIAxKHaOZE71ZiajE5QCm5I3ablayEmBYM7b7hQWr9xTStBcBHNkTRDqujc6duqRp1dQg3t4L8hQaOCQgaiMJxHSDcCy2pshBYRKU/c1FzdlC8SiMxbG7n1YF624qUFWCh6hNPVlNb2h0bK/RO0SZJn10yCMfeiUtVFZ7+CPqBLuD4eINDQxqVDdPxqfEkXnVexwRPA0oGrQusk5IPughF/azTwyp/wdpwne25jcW3Jb+YfGszFjshTVZFuT4mkb0Ok1YbNCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ypENyYp7QHoZaRZpMdt2X/LsakFgKUb3XLbJKPohns=;
 b=HFhJN2Uw56oBus+P4a5V/ssgMzFipiRRQP9jj9PgdJTx89flK+SL4HCshKunHeWeXPr/1EM3MGgWemYogCnONwNOgPBrlC9vVO4Zu1ceEWG++Qw9blKLRWq7K4vHBRzkBjG7LTsTUtBbqKaT4VdbYa7S2ne84DsgEQLtzhapRQ1kqwT5tsGLWxXnb9ccGW4w2igVl0knE6NqJbO2nRmZm1zMubLXuSUas3N2fQfal5OCez2mxLkd/nNjiY6aZ8bcg2OROh23phelQYPgA+l1WBhx+YtuxaGH4cwZznRS7m5EcCJR91o7iY3LFgRshBWuOcyPWND5Bnnrhr0vYr5EqQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6814.namprd02.prod.outlook.com (2603:10b6:208:199::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 17:19:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 17:19:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: RE: [PATCH v3 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Topic: [PATCH v3 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Index: AQHc5816N8UGGzrbNEC1JOxCe/0MVrYYvDsw
Date: Thu, 21 May 2026 17:19:04 +0000
Message-ID:
 <SN6PR02MB4157BBE2E29FE5B21B51FF19D40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1779221339.git.me@berkoc.com>
 <e6e63276cca2901641ab39029e4fd3d621b1ee92.1779221799.git.me@berkoc.com>
In-Reply-To:
 <e6e63276cca2901641ab39029e4fd3d621b1ee92.1779221799.git.me@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6814:EE_
x-ms-office365-filtering-correlation-id: cfd6db04-207f-4c77-2c03-08deb75d0ee4
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|15080799012|8060799015|12121999013|13091999003|19110799012|31061999003|41001999006|51005399006|37011999003|19101099003|2604032031799003|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/AsZQESDEeEVMZl0jZbWEZeVmiJnwTU8gZMUUgaQqdyG4jNju4sQBHUS0wfw?=
 =?us-ascii?Q?wWk0VCDk7PZknve472Gtkrjq1QlSirR9FxD73MmoVx7AXooKYGnmtMt7V3zG?=
 =?us-ascii?Q?sPEJg70s8IiwPnkZqYumLkOfaDnh1UY8F68NW+Vmnjf4Emdfi3PKIHeA6ySt?=
 =?us-ascii?Q?d5JsBnlNydKEl0pjAV//LTnelnY+uunM6xptF5ouNthUACr+9S41zzTzR9wT?=
 =?us-ascii?Q?qx31Biow4Cz/9M7Iq29NTBaOEwJHScgc2NzqtvVf27/sry8UX5dXZHpVoWsk?=
 =?us-ascii?Q?paPUpKBMZ3qpxSUGHrVG1gnmt4OOJrWzVWGBmOJUG5Za5DBc8gPGfPRUGDX+?=
 =?us-ascii?Q?jhHNYQ3kDh0kmkYN1tXM41vTstR60K4GJLHPdTSe4OZHwOu8KFUclsyhE3B4?=
 =?us-ascii?Q?fNH0U6iJEaxWdkABxDb8TjPODzrcqwF68HW1pKMDdrA5djxeB6IgzKosVj0w?=
 =?us-ascii?Q?cREIOalxDSJ3YvpvqkO5c7wrikB9IjxKgvk/p3wCvpJ3UaAQUgXZ7SDoCOhp?=
 =?us-ascii?Q?NtdVbQL4uHJ/+wSog7f2i3E6Xrfvm6JB8iz0UdA+S04dCXHkNFwK9yVh94US?=
 =?us-ascii?Q?ILn4ReqlTZfw0mOGzdRDjv7ljJzIU5w2VIjDR8rEk5yBU/Bel/4zQCAkC4j3?=
 =?us-ascii?Q?521uSQm567e7GCEizR56699uKjOcveBjpdcMkJhGwCqAl9IztRXpQXsO3dOB?=
 =?us-ascii?Q?IkOzhFjxE9CGVq/oQKc8kvbLi8AXF6uETd/18KPrCMoTjQojL6n61d+WPXOq?=
 =?us-ascii?Q?spnvwMumKgdci7hYXyvgTrcauf/wqiTcSwe6tf2UrYEKduRGV3gdbFxL4L4+?=
 =?us-ascii?Q?m1pfZMUFLCCJLNxKo/AG+qNCIjlKlBbhZ4UyvmWhU/jLK65E+hYEIk5ztMkr?=
 =?us-ascii?Q?+OkuwHnGLMds+a+AA3FpD+iljvNxPdYEbKx87XvEsRPIsuk4TKtImaU4pZZQ?=
 =?us-ascii?Q?cyw++niPCSCukcfPTUPpf/mOqEtfMzapk7jF/JUO2ASgPgfVzJpahxPlZXwh?=
 =?us-ascii?Q?r4oiCnS1HqS9SHGEU8dWu/47/kVj3PNlNZOu7GsJBrH5YPKjsaoi52/k9gaf?=
 =?us-ascii?Q?Quk8VtOfjbQve3bjvxeWNQLw7p4TDeGvt8Ls1w93fRV23GJyeIf6JcQxymTq?=
 =?us-ascii?Q?3wyMs2hWq95/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hu7f8C5Lv+4g57sfH91b8PRNby5dJS3b1qJuBwRPqg80e5VboNmIUp2yWtJL?=
 =?us-ascii?Q?0QL7Egi7BKultZ8aU4LsVsnS8zB4vKLBb5frcY+hf4nXTzzm6UbQGcoKX0fO?=
 =?us-ascii?Q?p8/6ZjGgGTahhbtrUp624rSrGlIXleS4PU47lOi0+t+zhO2l+ALdVkthzfDS?=
 =?us-ascii?Q?rOCP+DZ9ZWnRYzuSpOYsa7f9+eQPfuS72W+xF4uhkGhQMRz8j4sNOD9Uw5dg?=
 =?us-ascii?Q?r0WNpLY5ljYhBq0wcB65wNNlD7twkZ7Ia+i6SwKQrKsYo0vaWK2+Y30/JOY8?=
 =?us-ascii?Q?zsc9f9KHobAuMD9meiJ0Ia73b5Xi8W0/7/kkSo85rt6+O5NeVNb4CvVpeBSE?=
 =?us-ascii?Q?OqqZf1R9B/yv/wo97IAmR91ihRUiVVT05BX+YGwJlHJIP318VZgcCfXKxEIv?=
 =?us-ascii?Q?GpZ75D9HYFgNmuFzX2eLPTtlfPfvV1S+6+SwCiQ1+ocoTe0BiHMn/RYpC9sw?=
 =?us-ascii?Q?SiT2RM9YNuatMTp7mA86OxcNIx6gM+9+xBofsrLuMEL/V6A6uVkKg5GYvq/m?=
 =?us-ascii?Q?aB9y+pLpcywbsmrw81kSdsbQc5KeCusARSEiIZwCQXkq8T4/hiIcPlT6QUlE?=
 =?us-ascii?Q?Xy5q7c7LV8YTxjNgy9GMiHkkl8zIYHILMKWtGihQVOIXZoTLVObX2Xv01l0U?=
 =?us-ascii?Q?aoLM1t8uLD4VYRH1xuFIOgfUOgs5DnufzLmyM+BDBeJ5+kZRMlER36labCYx?=
 =?us-ascii?Q?UY5AjACXveGpXKIq6BqsNRvK+n2fkvYycT/ZTFS4wSSoGWvyH/y2mdC/+4FR?=
 =?us-ascii?Q?0eyoDCahY2jNfesdt93/gAgcgQAcfBJ8G5MMtA9eJ3k4hP9OFNc33JT0KvJZ?=
 =?us-ascii?Q?Ww6lCnDRUiLlYmrJQ9Nb2Ap9PEImhtje4zWtiv1V/v5427+dfnmkFyqa1864?=
 =?us-ascii?Q?xwzB/2ufdq8bxW0mikl3hAlou8DzQvWw867UXDRCi5CEN8estki0MQv7EnCl?=
 =?us-ascii?Q?N9WD6yyixFSGu8mNyHA+f7u65FtOFNpmR949x8vDpZfPJDYwc8IkdqsQhxHq?=
 =?us-ascii?Q?q9h+y6BcO2R8bfsmMp43ZQxdgo3XEf3ft0aUiH/EGKWHMNWylgSo8wLQpJWx?=
 =?us-ascii?Q?7t2RSefHWebvxLyAKfseBIDHImLztN4QKUTWgPfP8Yb6QfWfgyZiDRncA6YP?=
 =?us-ascii?Q?yYW8SbI9T0+YjGymepZJzehbHukeNaaoy+xXugInclKmLIWF+zesi9Tstoyc?=
 =?us-ascii?Q?PVrfF/PgWVP0ZacXLuYPg69vT+Y/MBEH5A9Yji0V2m47hVGN6W+UfPGiQAs7?=
 =?us-ascii?Q?DZbLn0zEHUfvW+kqGaRCE72KP/1t5loliwRbL8AQUPWcGbDSRSaOxJ71GSkD?=
 =?us-ascii?Q?i3FPeGSdz5+ofPCVhysfz+Ei1eJr7AF5TvQMcSCV2YXhfhdJxvIYkFNaiDf8?=
 =?us-ascii?Q?R4Mx7SA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd6db04-207f-4c77-2c03-08deb75d0ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 17:19:04.2340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6814
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11137-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,berkoc.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3435D5AB0ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Berkant Koc <me@berkoc.com> Sent: Tuesday, May 19, 2026 1:09 PM
>=20
> hyperv_receive_sub() reads msg->vid_hdr.type and dispatches into one
> of four message-type branches without knowing how many bytes the host
> wrote into hv->recv_buf. The completion path then runs
> memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE), so the consumer
> that wakes on wait_for_completion_timeout() can read up to 16 KiB of
> residue from a prior message as if it were the response payload.
>=20
> Pass bytes_recvd into hyperv_receive_sub() and reject any packet that
> does not cover the pipe + synthvid header. For each of the three
> completion-driving types (SYNTHVID_VERSION_RESPONSE,
> SYNTHVID_RESOLUTION_RESPONSE, SYNTHVID_VRAM_LOCATION_ACK) also
> require the type-specific payload before memcpy/complete, and apply
> the same rule to SYNTHVID_FEATURE_CHANGE before reading is_dirt_needed.
> The memcpy then uses bytes_recvd, which is bounded by
> VMBUS_MAX_PACKET_SIZE through the call to vmbus_recvpacket().
>=20
> Rejected packets are reported via drm_err_ratelimited() rather than
> silently dropped, matching the CoCo-hardened pattern in
> hv_kvp_onchannelcallback().

We discussed several issues with this patch in the feedback
from Sashiko. But see one more issue below.

>=20
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo device")
> Cc: stable@vger.kernel.org # 5.14+
> Signed-off-by: Berkant Koc <me@berkoc.com>
> Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 42 +++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index c3d0ff229..12d3feb4f 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -420,26 +420,62 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	return 0;
>  }
>=20
> -static void hyperv_receive_sub(struct hv_device *hdev)
> +static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
>  	struct hyperv_drm_device *hv =3D hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg;
> +	size_t hdr_size;
>=20
>  	if (!hv)
>  		return;
>=20
> +	hdr_size =3D sizeof(struct pipe_msg_hdr) +
> +		   sizeof(struct synthvid_msg_hdr);
> +	if (bytes_recvd < hdr_size) {
> +		drm_err_ratelimited(&hv->dev,
> +				    "synthvid packet too small for header: %u\n",
> +				    bytes_recvd);
> +		return;
> +	}
> +
>  	msg =3D (struct synthvid_msg *)hv->recv_buf;
>=20
>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
> -		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
> +		size_t need =3D hdr_size;
> +
> +		switch (msg->vid_hdr.type) {
> +		case SYNTHVID_VERSION_RESPONSE:
> +			need +=3D sizeof(struct synthvid_version_resp);
> +			break;
> +		case SYNTHVID_RESOLUTION_RESPONSE:
> +			need +=3D sizeof(struct synthvid_supported_resolution_resp);

I'm concerned that this might be too aggressive.  The last element
of struct synthvid_supported_resolution_resp is an array, and there's
a count in the message describing how many elements of the array
are populated. But Hyper-V may not (and probably doesn't) include
unpopulated elements in the response message.  So "need" is likely
calculated as too large. Are you able to test this in a Hyper-V VM to
confirm?

I think you'll find it necessary to first check that enough bytes
have arrived to read the "resolution_count" field, and then use
that value to calculate "need".  There are several other places
in hardened VMBus drivers that use that same two-level
technique. It's a pain, but there's not really any alternative.

Michael

> +			break;
> +		case SYNTHVID_VRAM_LOCATION_ACK:
> +			need +=3D sizeof(struct synthvid_vram_location_ack);
> +			break;
> +		}
> +		if (bytes_recvd < need) {
> +			drm_err_ratelimited(&hv->dev,
> +					    "synthvid packet too small for type %u: %u < %zu\n",
> +					    msg->vid_hdr.type, bytes_recvd, need);
> +			return;
> +		}
> +		memcpy(hv->init_buf, msg, bytes_recvd);
>  		complete(&hv->wait);
>  		return;
>  	}
>=20
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_FEATURE_CHANGE) {
> +		if (bytes_recvd < hdr_size +
> +		    sizeof(struct synthvid_feature_change)) {
> +			drm_err_ratelimited(&hv->dev,
> +					    "synthvid feature change packet too small: %u\n",
> +					    bytes_recvd);
> +			return;
> +		}
>  		hv->dirt_needed =3D msg->feature_chg.is_dirt_needed;
>  		if (hv->dirt_needed)
>  			hyperv_hide_hw_ptr(hv->hdev);
> @@ -466,7 +502,7 @@ static void hyperv_receive(void *ctx)
>  				       &bytes_recvd, &req_id);
>  		if (bytes_recvd > 0 &&
>  		    recv_buf->pipe_hdr.type =3D=3D PIPE_MSG_DATA)
> -			hyperv_receive_sub(hdev);
> +			hyperv_receive_sub(hdev, bytes_recvd);
>  	} while (bytes_recvd > 0 && ret =3D=3D 0);
>  }
>=20
> --
> 2.47.3
>=20


