Return-Path: <linux-hyperv+bounces-8483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPxPCb+rc2nOxwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8483-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:11:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DE78D4E
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19DA30541DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5C2BCF6C;
	Fri, 23 Jan 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M81nQFgx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012009.outbound.protection.outlook.com [52.103.14.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8F1A00F0;
	Fri, 23 Jan 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188158; cv=fail; b=IupBlXsUng6ZtyALhmRjMlQn6+s09e6ZCCE8/4aONe1AYMJ7YhV3yiuMwjmIJy5HVajrcwQZaM0Tx/4Qcv4b9rJS8X32KTNMGY0o8gkO6pb+gURqmz+CodUdfTqAyCHVuig8jSK/Gf3gwAlT77/1bmlYzYfgfSVJvB3owqsgazo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188158; c=relaxed/simple;
	bh=brP62pHm0r3IQg9kVJZvQv6Uys9ZMMVMUAwNMgvH6n4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BlO0edUDFXd5vziW/R2u1UWTpxuC5TuhMzly1zihTE7D33K8qZgIyvENyNnpX+TgjG1IN0+UELhwwEppeP56iytc5rEMGzDLC+0V409hVfznX/PSSHAc7IMcvs6xGaUo+0Wa0EelJujbO9t6bN+Bu9/cvBVEb+Npv3172cb+c1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M81nQFgx; arc=fail smtp.client-ip=52.103.14.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6RL718u6+K0T73r0xub22nzkW+dDlcgo9G8rrU5hHVF3LyzMxjTuHNqaAcbPmhpY+wR/FM0e/OU5zrTzo/AHtACo1uqzoFgt+LA/7LeSOE3qbbhHDi0+HxrAwTBosxAv4QPOXu1cC+qw3jvnq+LbhIBiIw4+uBJGwN63q6MDG0oB69wUghMgOKUBuF5xr91Ab6EupUCOe8fAf6PLLC8+uVPB4PWNDsgwfJwBlK2PUlS+4rrmsa3eOnqnb3XUpBvVgw/iXC1dvGSshudLP7YBKa5OzsxTp/UWr5JvS1Zf7RWaUuZDg5dPSvCDwSmx0HtQu0+87eZ/73rFxSIPs+Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZE68HVJytDGFnRQl46utj/UZCrePd56jTU2L5tgu8U=;
 b=UM4L19iC4jfeLfLeEy5rFk9afPs2M2Rsw53n/0TUXxJcVF1mssFxnKMQEZ4OOTgpWtruJLw1hoeFdaxwOv7Zw5k7VaUzM7zGDPzopGzAzkPf6OVRzKTtQDMMxtnxmQd9DvDV3+P9UsDpdD2Wty52U7oRPAACfG6BTpiaPD47zX+2XAiqjn7ZbmaYQsIMud6Dc9AfufGM39SnrE1VkEH/b059Hv+a+DUqq641vxQTg8z2AMVWyo+1cNqS0j0TpKgcJXaXGHUGvsXHVWrLkxTvlMehsId97qJmJDH7IDSZVnQeQubN0mvfXdwmHfhaeyQe1+SFmzZUs2Y1s1IkzxxHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZE68HVJytDGFnRQl46utj/UZCrePd56jTU2L5tgu8U=;
 b=M81nQFgxdGSI9/aH+s5XjiYZOK2dNls60sWHJ7iq3c7cFQMqCvwrsVNU8iqV8RUfmUAtx5eHTJF3PEK8rq9qO5rMD3exAA6j7AxXDhUXgY5MSm4ry7MXYNO+CJFskrgRnYUMY+gCGL/ujTWn+l/KK/zdJC1MErs3iSdXMNn/xeCpyVV8w8G2CjV6OqaJqp2F1w5mmwXIBC9kRmbnG7A69CG2ib8hOzl3ntOVBl6t9rXlFmr9rvJdwwfZrV1AWr2AVfUsG6VSWAC1PbS4qdnqzRac8glFAjW1nRmDdM6PpIu7ncAkwaE8KY6ZLDvxFPxbg4OluE+DARTRxu0IrTqBVg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8355.namprd02.prod.outlook.com (2603:10b6:a03:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 17:09:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 17:09:10 +0000
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
Subject: RE: [PATCH v4 6/7] mshv: Add data for printing stats page counters
Thread-Topic: [PATCH v4 6/7] mshv: Add data for printing stats page counters
Thread-Index: AQHcix9mx12lepGkcE2/p3HiI/apmLVfOm+Q
Date: Fri, 23 Jan 2026 17:09:10 +0000
Message-ID:
 <SN6PR02MB41572B2CC3494BE6BC737424D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-7-nunodasneves@linux.microsoft.com>
In-Reply-To: <20260121214623.76374-7-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8355:EE_
x-ms-office365-filtering-correlation-id: 08b4d5b5-f2be-4679-6690-08de5aa22026
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/trfHDBZ8L5v/xM+F3c7L1kUk74X094OwN4qXJm3FmYuBPm6HMPSeJMGwpSHEOnhhm7DbHEa7v8fAhELcI1XdB4zvGIr/mUdGbXJ7Pap+/xPSVS0JB690dKgoLaJ0jQnuHbKEBBl88bYRwH6qdXPfcYkHhZwLGyb1l7QrcrRBLOKEBlIWFN6zOW9Kn1FR3wOLWmJztkrWchuUW0K75c9tUrRE0eRvv5QL9p1OZznpMZPlAA3N3nPxiTStAELRSVugAFI4OTGJgxA2sslLTzz+HBQgT23lRvGXACiuJSi5KRppWtc4tw2YlmsZ4hHTDmpxOrxqr87P7tmnX74q4nvOgFvEX/IjNINyjxO1ACiHwNen+kup/YxJ1Pxi/E9Gqwnr9Lb+NkqlIfLk606586oBrX9U+PgTto2tREHZk1tNVe6zFHq8Z1U41t1f2NhAjnpFD+MxFZOCxI84wph9Ay6qv30ZLz196YCS7H7csV/oC3209xUqH5toDXzVIatdaNDL7CdOmPU6UDRhgiloFpKw7ZrsTwnM7dYjYbYsgCKOaO3pI+MlPpoA/aRfzok/nKRh2prOOsQbChfLVUp42aQAjvlZ04uEMDVkftTZ1GaqEaV4prcQIxcKzJZLwvj7COb23GugnMoxQjQVTtcEJvy4YZKPK+5LsNnXOLpzebDsvhl3ZY7uN71N1vJRFM6xUX/ZkhRVhmzvZidRzk3m5Oel7fwiZR1WJxEJLSzZBv9rd5E=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|461199028|51005399006|8060799015|8062599012|13091999003|19110799012|3412199025|440099028|40105399003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UmcmSaY87JpBHtu9zln6P6x3UqY1OJRjjy4XN8AVnEQbnrGkYfF3gt7YJPbi?=
 =?us-ascii?Q?sVMaws0RgvTffpqkXbL+mpQQtMWivmMv6Li4Oo64Hoq2tBzsvJpOXBDt9qDA?=
 =?us-ascii?Q?QWX93Zxiddx4VpWRFLJNsKLnxj5MqCDtms2uLq6DbtJ/ebKLD/Yszx5+kuwH?=
 =?us-ascii?Q?loPyQM3aP1rK+NhCZxJQnXJO1MkKhzaB3UiuTRFGGqrooTvHRni/Mly0r8gc?=
 =?us-ascii?Q?EWUC/q1mpyWVknwJdHA6SLiq5ZCOdxX4wTtTvkFn3xklsoOZA/Bv93ugKHps?=
 =?us-ascii?Q?D86AtCAYqpZBbZdglMWDTX1XHxPVYWi6QgKCzpXO48gKhNe5sPUp299wg8je?=
 =?us-ascii?Q?auRQplQLb6LDMHitWL0K/mwjsgfVkDU/TBSi3NAcjpRjxyRtjgZ671cMJMax?=
 =?us-ascii?Q?x3Cpoaqz1vS3C2r3flTxgHGJnz5S6sG2cpEvpEVy/ToVQWWLZftVZYZF5fXd?=
 =?us-ascii?Q?4fsRZep9u7b1MwTxm24eHJWc56NSlKiyYu1BOrOalj6FE5TB9j4ugXzw3+ZE?=
 =?us-ascii?Q?5l8koXVyvxuo2Uo/H6MIfJrCULDScbUKOWss7txWQSSDRxN2FPfFyi56GP/a?=
 =?us-ascii?Q?qOI23FZA+9ysiIm9RRXgNgfmjlC/EiFtNWdwhx1qzjsK70S0fhZjcgko6yBL?=
 =?us-ascii?Q?zrWbtnIF41NW1XzjqsXmUwk35CDFEe6mo8RU7ERP6rjT+vVw1YCKXCRM/5Z9?=
 =?us-ascii?Q?noIthZUywx2K5e6/qiCND2MAJOmJmSKVw9UuYcBDyW2q1mG5+qg5ggVWQcmk?=
 =?us-ascii?Q?brxJm+5WKtsHu6Z6MxdpIQF2ebVHCEJ+NkVY8lwbxNGUijKgltKf33PDlFEK?=
 =?us-ascii?Q?qBL7wqNvxUk6rdeOpYiiYIJWl/x9YI78rWlNWRNvphT5efSxx5Nu9vRhUiI+?=
 =?us-ascii?Q?Igip1Vcjfe5YTKA7C2itauCoSOPdoSq37sY7PIAA5+CtY7+nbIqk/rxWjIF4?=
 =?us-ascii?Q?QeERrQFMm41yj0cwlFzwVwADNBaOH4ejyvOSmZBlhAFpMyk8t+EIxQa6qLYj?=
 =?us-ascii?Q?kNs6rWHAIo3/jItT37suYon1hLBiTeoi21iRAra4euHkYxnGWrtdm7q32uNH?=
 =?us-ascii?Q?bByyirDGYrdfuNOuicgjwExs6edP/1PiW9B7tNUQivgT5Cl8loN2sRm8SpYB?=
 =?us-ascii?Q?6hy0P6LbdTvmb3DHx2glNjotsVcYdfGLgn8j+ozUfYUe3Y8Ugrtt3Iq0RUoY?=
 =?us-ascii?Q?4wWxwoiWR3NryxcJ39lPadvgnC+0QZrk7xVzjg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H/7Km0AoZn3w6W8XwXGjvPNEMsiwKhlofFX1Y0C9mBvtDRYbqBGmDg1JJN4S?=
 =?us-ascii?Q?ycUNApyA4pZbosFvaDZvUQ/phNaDdfEbpNuPenZosQcriVmNdpIFpjqRmBR1?=
 =?us-ascii?Q?M+Ot2DXUpeP3jLdsnobKACkBJIyOjKrCjXU4ioTNETNNNr3Q/UUCmSNx70Z/?=
 =?us-ascii?Q?asyOZSeDLV5ki2a8Au7ngVDxqUKGIuS0xQh/34S/1ve4wecmkNKoErYCMJgY?=
 =?us-ascii?Q?xcVd3YHotLNds+SpQmalLqUgdSO8jeM41hNyJ4I5YLJGSCI5f0aK0oBmOnWO?=
 =?us-ascii?Q?+2o9sOF9/0o0TqGFH4/mAOAoVugS75fRKa0rcc/r54qla/C3T6KREHbMV9Yt?=
 =?us-ascii?Q?/HtHuwrXGuBFdZWDTGXQdvtSSTb9ztfvDcFH/CL7iV9ZioyDsiRgfg5gRrJj?=
 =?us-ascii?Q?oJLHR4RRbbPRm26sHZ+7x4C6cdn0Nva8iVrkX0ChMQXqdy65NVvFLWDIFSeY?=
 =?us-ascii?Q?WRw60nxo/XYIdRh3je3lF8z9GWD8IuvIENdV/ococ59OfnxIdsG62Jp/KPps?=
 =?us-ascii?Q?qKiMmrBvJ5oOu0vX6pbjARxmrLJxxhQhC+FlJfwRjWI+eaQKRjy7Y0WqPwIX?=
 =?us-ascii?Q?IYyqgx1+2nRwo4w3nRWYW/wQW6m9DQeFvVbTylAdbb6W3Pf1lSxUWN2p5a38?=
 =?us-ascii?Q?e+vKWRtgJKOyf25TN9aPJtEaHjoWLQomfI83w6fsDNxHES/+gDc80vTO00J1?=
 =?us-ascii?Q?eus6XMQ/OqR2EH30XzMkzpmRmTvgg2SDJ/f0Ngl2eG9YqhlOmcZKJMeuLiWX?=
 =?us-ascii?Q?noWid65IZ5aqnbXaZMFqns/WZOOi1g1F3PjeZGvAF9vpioDJgVtjzxHbj+W1?=
 =?us-ascii?Q?h+ZiUUJkI3yqrKvfRUlPQRleYqlywhkW5gSp9buguzSnUUHlTNPwQpGZfJCu?=
 =?us-ascii?Q?f3tpekimY1qaJ5YYzOPepjZt9h5IEMDmxr0plyedReZrL/AAd5hrjNXzo+BF?=
 =?us-ascii?Q?UCipT7fElpDgq3s9NozKFwT4jxfyYi+eI27SkPJoPpa2ZI/eTuuJZHFsS0sH?=
 =?us-ascii?Q?Ibp0RnfBtXpoJSfnigWjXqFkBKkj804Ehrasyz077R3Ysk/vKaj4x8mnu0gB?=
 =?us-ascii?Q?KB7tpSHfjR9HWD34LSkKh6qpLuqQujynxAhbtV+Xb1dFb9rbl4uymRnTHMyl?=
 =?us-ascii?Q?V150cLUGruvbYsW7iQlxIdRvHHq7vxhAo762DNs91mkEVtrCaK0tYeq6DLhf?=
 =?us-ascii?Q?1/2z1ry4QY/GD3XbxdPLb+S8EzEPWgAQk2uzz6H4MDNW60gmB8QBLEkAz33j?=
 =?us-ascii?Q?Eu8in9JcOGTD7yZwll9gZWXI76j0skrEBzh2Rw7yGg3ixATLvz+8RIvBkwgR?=
 =?us-ascii?Q?5nelmKN14qOG0QNEAmfZi2Hukaz6W28/X+kQ/t0E9MO8AUcLXsG1a/d1QHyH?=
 =?us-ascii?Q?wd8EJ0Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b4d5b5-f2be-4679-6690-08de5aa22026
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 17:09:10.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8355
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8483-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim]
X-Rspamd-Queue-Id: 718DE78D4E
X-Rspamd-Action: no action

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Ja=
nuary 21, 2026 1:46 PM
>=20
> Introduce hv_counters.c, containing static data corresponding to
> HV_*_COUNTER enums in the hypervisor source. Defining the enum
> members as an array instead makes more sense, since it will be
> iterated over to print counter information to debugfs.

I would have expected the filename to be mshv_counters.c, so that the assoc=
iation
with the MS hypervisor is clear. And the file is inextricably linked to msh=
v_debugfs.c,
which of course has the "mshv_" prefix. Or is there some thinking I'm not a=
ware of
for using the "hv_" prefix?

Also, I see in Patch 7 of this series that hv_counters.c is #included as a =
.c file
in mshv_debugfs.c. Is there a reason for doing the #include instead of addi=
ng
hv_counters.c to the Makefile and building it on its own? You would need to
add a handful of extern statements to mshv_root.h so that the tables are
referenceable from mshv_debugfs.c. But that would seem to be the more
normal way of doing things.  #including a .c file is unusual.

See one more comment on the last line of this patch ...

>=20
> Include hypervisor, logical processor, partition, and virtual
> processor counters.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv_counters.c | 488 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 488 insertions(+)
>  create mode 100644 drivers/hv/hv_counters.c
>=20
> diff --git a/drivers/hv/hv_counters.c b/drivers/hv/hv_counters.c
> new file mode 100644
> index 000000000000..a8e07e72cc29
> --- /dev/null
> +++ b/drivers/hv/hv_counters.c
> @@ -0,0 +1,488 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, Microsoft Corporation.
> + *
> + * Data for printing stats page counters via debugfs.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +struct hv_counter_entry {
> +	char *name;
> +	int idx;
> +};
> +
> +/* HV_HYPERVISOR_COUNTER */
> +static struct hv_counter_entry hv_hypervisor_counters[] =3D {
> +	{ "HvLogicalProcessors", 1 },
> +	{ "HvPartitions", 2 },
> +	{ "HvTotalPages", 3 },
> +	{ "HvVirtualProcessors", 4 },
> +	{ "HvMonitoredNotifications", 5 },
> +	{ "HvModernStandbyEntries", 6 },
> +	{ "HvPlatformIdleTransitions", 7 },
> +	{ "HvHypervisorStartupCost", 8 },
> +
> +	{ "HvIOSpacePages", 10 },
> +	{ "HvNonEssentialPagesForDump", 11 },
> +	{ "HvSubsumedPages", 12 },
> +};
> +
> +/* HV_CPU_COUNTER */
> +static struct hv_counter_entry hv_lp_counters[] =3D {
> +	{ "LpGlobalTime", 1 },
> +	{ "LpTotalRunTime", 2 },
> +	{ "LpHypervisorRunTime", 3 },
> +	{ "LpHardwareInterrupts", 4 },
> +	{ "LpContextSwitches", 5 },
> +	{ "LpInterProcessorInterrupts", 6 },
> +	{ "LpSchedulerInterrupts", 7 },
> +	{ "LpTimerInterrupts", 8 },
> +	{ "LpInterProcessorInterruptsSent", 9 },
> +	{ "LpProcessorHalts", 10 },
> +	{ "LpMonitorTransitionCost", 11 },
> +	{ "LpContextSwitchTime", 12 },
> +	{ "LpC1TransitionsCount", 13 },
> +	{ "LpC1RunTime", 14 },
> +	{ "LpC2TransitionsCount", 15 },
> +	{ "LpC2RunTime", 16 },
> +	{ "LpC3TransitionsCount", 17 },
> +	{ "LpC3RunTime", 18 },
> +	{ "LpRootVpIndex", 19 },
> +	{ "LpIdleSequenceNumber", 20 },
> +	{ "LpGlobalTscCount", 21 },
> +	{ "LpActiveTscCount", 22 },
> +	{ "LpIdleAccumulation", 23 },
> +	{ "LpReferenceCycleCount0", 24 },
> +	{ "LpActualCycleCount0", 25 },
> +	{ "LpReferenceCycleCount1", 26 },
> +	{ "LpActualCycleCount1", 27 },
> +	{ "LpProximityDomainId", 28 },
> +	{ "LpPostedInterruptNotifications", 29 },
> +	{ "LpBranchPredictorFlushes", 30 },
> +#if IS_ENABLED(CONFIG_X86_64)
> +	{ "LpL1DataCacheFlushes", 31 },
> +	{ "LpImmediateL1DataCacheFlushes", 32 },
> +	{ "LpMbFlushes", 33 },
> +	{ "LpCounterRefreshSequenceNumber", 34 },
> +	{ "LpCounterRefreshReferenceTime", 35 },
> +	{ "LpIdleAccumulationSnapshot", 36 },
> +	{ "LpActiveTscCountSnapshot", 37 },
> +	{ "LpHwpRequestContextSwitches", 38 },
> +	{ "LpPlaceholder1", 39 },
> +	{ "LpPlaceholder2", 40 },
> +	{ "LpPlaceholder3", 41 },
> +	{ "LpPlaceholder4", 42 },
> +	{ "LpPlaceholder5", 43 },
> +	{ "LpPlaceholder6", 44 },
> +	{ "LpPlaceholder7", 45 },
> +	{ "LpPlaceholder8", 46 },
> +	{ "LpPlaceholder9", 47 },
> +	{ "LpSchLocalRunListSize", 48 },
> +	{ "LpReserveGroupId", 49 },
> +	{ "LpRunningPriority", 50 },
> +	{ "LpPerfmonInterruptCount", 51 },
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	{ "LpCounterRefreshSequenceNumber", 31 },
> +	{ "LpCounterRefreshReferenceTime", 32 },
> +	{ "LpIdleAccumulationSnapshot", 33 },
> +	{ "LpActiveTscCountSnapshot", 34 },
> +	{ "LpHwpRequestContextSwitches", 35 },
> +	{ "LpPlaceholder2", 36 },
> +	{ "LpPlaceholder3", 37 },
> +	{ "LpPlaceholder4", 38 },
> +	{ "LpPlaceholder5", 39 },
> +	{ "LpPlaceholder6", 40 },
> +	{ "LpPlaceholder7", 41 },
> +	{ "LpPlaceholder8", 42 },
> +	{ "LpPlaceholder9", 43 },
> +	{ "LpSchLocalRunListSize", 44 },
> +	{ "LpReserveGroupId", 45 },
> +	{ "LpRunningPriority", 46 },
> +#endif
> +};
> +
> +/* HV_PROCESS_COUNTER */
> +static struct hv_counter_entry hv_partition_counters[] =3D {
> +	{ "PtVirtualProcessors", 1 },
> +
> +	{ "PtTlbSize", 3 },
> +	{ "PtAddressSpaces", 4 },
> +	{ "PtDepositedPages", 5 },
> +	{ "PtGpaPages", 6 },
> +	{ "PtGpaSpaceModifications", 7 },
> +	{ "PtVirtualTlbFlushEntires", 8 },
> +	{ "PtRecommendedTlbSize", 9 },
> +	{ "PtGpaPages4K", 10 },
> +	{ "PtGpaPages2M", 11 },
> +	{ "PtGpaPages1G", 12 },
> +	{ "PtGpaPages512G", 13 },
> +	{ "PtDevicePages4K", 14 },
> +	{ "PtDevicePages2M", 15 },
> +	{ "PtDevicePages1G", 16 },
> +	{ "PtDevicePages512G", 17 },
> +	{ "PtAttachedDevices", 18 },
> +	{ "PtDeviceInterruptMappings", 19 },
> +	{ "PtIoTlbFlushes", 20 },
> +	{ "PtIoTlbFlushCost", 21 },
> +	{ "PtDeviceInterruptErrors", 22 },
> +	{ "PtDeviceDmaErrors", 23 },
> +	{ "PtDeviceInterruptThrottleEvents", 24 },
> +	{ "PtSkippedTimerTicks", 25 },
> +	{ "PtPartitionId", 26 },
> +#if IS_ENABLED(CONFIG_X86_64)
> +	{ "PtNestedTlbSize", 27 },
> +	{ "PtRecommendedNestedTlbSize", 28 },
> +	{ "PtNestedTlbFreeListSize", 29 },
> +	{ "PtNestedTlbTrimmedPages", 30 },
> +	{ "PtPagesShattered", 31 },
> +	{ "PtPagesRecombined", 32 },
> +	{ "PtHwpRequestValue", 33 },
> +	{ "PtAutoSuspendEnableTime", 34 },
> +	{ "PtAutoSuspendTriggerTime", 35 },
> +	{ "PtAutoSuspendDisableTime", 36 },
> +	{ "PtPlaceholder1", 37 },
> +	{ "PtPlaceholder2", 38 },
> +	{ "PtPlaceholder3", 39 },
> +	{ "PtPlaceholder4", 40 },
> +	{ "PtPlaceholder5", 41 },
> +	{ "PtPlaceholder6", 42 },
> +	{ "PtPlaceholder7", 43 },
> +	{ "PtPlaceholder8", 44 },
> +	{ "PtHypervisorStateTransferGeneration", 45 },
> +	{ "PtNumberofActiveChildPartitions", 46 },
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	{ "PtHwpRequestValue", 27 },
> +	{ "PtAutoSuspendEnableTime", 28 },
> +	{ "PtAutoSuspendTriggerTime", 29 },
> +	{ "PtAutoSuspendDisableTime", 30 },
> +	{ "PtPlaceholder1", 31 },
> +	{ "PtPlaceholder2", 32 },
> +	{ "PtPlaceholder3", 33 },
> +	{ "PtPlaceholder4", 34 },
> +	{ "PtPlaceholder5", 35 },
> +	{ "PtPlaceholder6", 36 },
> +	{ "PtPlaceholder7", 37 },
> +	{ "PtPlaceholder8", 38 },
> +	{ "PtHypervisorStateTransferGeneration", 39 },
> +	{ "PtNumberofActiveChildPartitions", 40 },
> +#endif
> +};
> +
> +/* HV_THREAD_COUNTER */
> +static struct hv_counter_entry hv_vp_counters[] =3D {
> +	{ "VpTotalRunTime", 1 },
> +	{ "VpHypervisorRunTime", 2 },
> +	{ "VpRemoteNodeRunTime", 3 },
> +	{ "VpNormalizedRunTime", 4 },
> +	{ "VpIdealCpu", 5 },
> +
> +	{ "VpHypercallsCount", 7 },
> +	{ "VpHypercallsTime", 8 },
> +#if IS_ENABLED(CONFIG_X86_64)
> +	{ "VpPageInvalidationsCount", 9 },
> +	{ "VpPageInvalidationsTime", 10 },
> +	{ "VpControlRegisterAccessesCount", 11 },
> +	{ "VpControlRegisterAccessesTime", 12 },
> +	{ "VpIoInstructionsCount", 13 },
> +	{ "VpIoInstructionsTime", 14 },
> +	{ "VpHltInstructionsCount", 15 },
> +	{ "VpHltInstructionsTime", 16 },
> +	{ "VpMwaitInstructionsCount", 17 },
> +	{ "VpMwaitInstructionsTime", 18 },
> +	{ "VpCpuidInstructionsCount", 19 },
> +	{ "VpCpuidInstructionsTime", 20 },
> +	{ "VpMsrAccessesCount", 21 },
> +	{ "VpMsrAccessesTime", 22 },
> +	{ "VpOtherInterceptsCount", 23 },
> +	{ "VpOtherInterceptsTime", 24 },
> +	{ "VpExternalInterruptsCount", 25 },
> +	{ "VpExternalInterruptsTime", 26 },
> +	{ "VpPendingInterruptsCount", 27 },
> +	{ "VpPendingInterruptsTime", 28 },
> +	{ "VpEmulatedInstructionsCount", 29 },
> +	{ "VpEmulatedInstructionsTime", 30 },
> +	{ "VpDebugRegisterAccessesCount", 31 },
> +	{ "VpDebugRegisterAccessesTime", 32 },
> +	{ "VpPageFaultInterceptsCount", 33 },
> +	{ "VpPageFaultInterceptsTime", 34 },
> +	{ "VpGuestPageTableMaps", 35 },
> +	{ "VpLargePageTlbFills", 36 },
> +	{ "VpSmallPageTlbFills", 37 },
> +	{ "VpReflectedGuestPageFaults", 38 },
> +	{ "VpApicMmioAccesses", 39 },
> +	{ "VpIoInterceptMessages", 40 },
> +	{ "VpMemoryInterceptMessages", 41 },
> +	{ "VpApicEoiAccesses", 42 },
> +	{ "VpOtherMessages", 43 },
> +	{ "VpPageTableAllocations", 44 },
> +	{ "VpLogicalProcessorMigrations", 45 },
> +	{ "VpAddressSpaceEvictions", 46 },
> +	{ "VpAddressSpaceSwitches", 47 },
> +	{ "VpAddressDomainFlushes", 48 },
> +	{ "VpAddressSpaceFlushes", 49 },
> +	{ "VpGlobalGvaRangeFlushes", 50 },
> +	{ "VpLocalGvaRangeFlushes", 51 },
> +	{ "VpPageTableEvictions", 52 },
> +	{ "VpPageTableReclamations", 53 },
> +	{ "VpPageTableResets", 54 },
> +	{ "VpPageTableValidations", 55 },
> +	{ "VpApicTprAccesses", 56 },
> +	{ "VpPageTableWriteIntercepts", 57 },
> +	{ "VpSyntheticInterrupts", 58 },
> +	{ "VpVirtualInterrupts", 59 },
> +	{ "VpApicIpisSent", 60 },
> +	{ "VpApicSelfIpisSent", 61 },
> +	{ "VpGpaSpaceHypercalls", 62 },
> +	{ "VpLogicalProcessorHypercalls", 63 },
> +	{ "VpLongSpinWaitHypercalls", 64 },
> +	{ "VpOtherHypercalls", 65 },
> +	{ "VpSyntheticInterruptHypercalls", 66 },
> +	{ "VpVirtualInterruptHypercalls", 67 },
> +	{ "VpVirtualMmuHypercalls", 68 },
> +	{ "VpVirtualProcessorHypercalls", 69 },
> +	{ "VpHardwareInterrupts", 70 },
> +	{ "VpNestedPageFaultInterceptsCount", 71 },
> +	{ "VpNestedPageFaultInterceptsTime", 72 },
> +	{ "VpPageScans", 73 },
> +	{ "VpLogicalProcessorDispatches", 74 },
> +	{ "VpWaitingForCpuTime", 75 },
> +	{ "VpExtendedHypercalls", 76 },
> +	{ "VpExtendedHypercallInterceptMessages", 77 },
> +	{ "VpMbecNestedPageTableSwitches", 78 },
> +	{ "VpOtherReflectedGuestExceptions", 79 },
> +	{ "VpGlobalIoTlbFlushes", 80 },
> +	{ "VpGlobalIoTlbFlushCost", 81 },
> +	{ "VpLocalIoTlbFlushes", 82 },
> +	{ "VpLocalIoTlbFlushCost", 83 },
> +	{ "VpHypercallsForwardedCount", 84 },
> +	{ "VpHypercallsForwardingTime", 85 },
> +	{ "VpPageInvalidationsForwardedCount", 86 },
> +	{ "VpPageInvalidationsForwardingTime", 87 },
> +	{ "VpControlRegisterAccessesForwardedCount", 88 },
> +	{ "VpControlRegisterAccessesForwardingTime", 89 },
> +	{ "VpIoInstructionsForwardedCount", 90 },
> +	{ "VpIoInstructionsForwardingTime", 91 },
> +	{ "VpHltInstructionsForwardedCount", 92 },
> +	{ "VpHltInstructionsForwardingTime", 93 },
> +	{ "VpMwaitInstructionsForwardedCount", 94 },
> +	{ "VpMwaitInstructionsForwardingTime", 95 },
> +	{ "VpCpuidInstructionsForwardedCount", 96 },
> +	{ "VpCpuidInstructionsForwardingTime", 97 },
> +	{ "VpMsrAccessesForwardedCount", 98 },
> +	{ "VpMsrAccessesForwardingTime", 99 },
> +	{ "VpOtherInterceptsForwardedCount", 100 },
> +	{ "VpOtherInterceptsForwardingTime", 101 },
> +	{ "VpExternalInterruptsForwardedCount", 102 },
> +	{ "VpExternalInterruptsForwardingTime", 103 },
> +	{ "VpPendingInterruptsForwardedCount", 104 },
> +	{ "VpPendingInterruptsForwardingTime", 105 },
> +	{ "VpEmulatedInstructionsForwardedCount", 106 },
> +	{ "VpEmulatedInstructionsForwardingTime", 107 },
> +	{ "VpDebugRegisterAccessesForwardedCount", 108 },
> +	{ "VpDebugRegisterAccessesForwardingTime", 109 },
> +	{ "VpPageFaultInterceptsForwardedCount", 110 },
> +	{ "VpPageFaultInterceptsForwardingTime", 111 },
> +	{ "VpVmclearEmulationCount", 112 },
> +	{ "VpVmclearEmulationTime", 113 },
> +	{ "VpVmptrldEmulationCount", 114 },
> +	{ "VpVmptrldEmulationTime", 115 },
> +	{ "VpVmptrstEmulationCount", 116 },
> +	{ "VpVmptrstEmulationTime", 117 },
> +	{ "VpVmreadEmulationCount", 118 },
> +	{ "VpVmreadEmulationTime", 119 },
> +	{ "VpVmwriteEmulationCount", 120 },
> +	{ "VpVmwriteEmulationTime", 121 },
> +	{ "VpVmxoffEmulationCount", 122 },
> +	{ "VpVmxoffEmulationTime", 123 },
> +	{ "VpVmxonEmulationCount", 124 },
> +	{ "VpVmxonEmulationTime", 125 },
> +	{ "VpNestedVMEntriesCount", 126 },
> +	{ "VpNestedVMEntriesTime", 127 },
> +	{ "VpNestedSLATSoftPageFaultsCount", 128 },
> +	{ "VpNestedSLATSoftPageFaultsTime", 129 },
> +	{ "VpNestedSLATHardPageFaultsCount", 130 },
> +	{ "VpNestedSLATHardPageFaultsTime", 131 },
> +	{ "VpInvEptAllContextEmulationCount", 132 },
> +	{ "VpInvEptAllContextEmulationTime", 133 },
> +	{ "VpInvEptSingleContextEmulationCount", 134 },
> +	{ "VpInvEptSingleContextEmulationTime", 135 },
> +	{ "VpInvVpidAllContextEmulationCount", 136 },
> +	{ "VpInvVpidAllContextEmulationTime", 137 },
> +	{ "VpInvVpidSingleContextEmulationCount", 138 },
> +	{ "VpInvVpidSingleContextEmulationTime", 139 },
> +	{ "VpInvVpidSingleAddressEmulationCount", 140 },
> +	{ "VpInvVpidSingleAddressEmulationTime", 141 },
> +	{ "VpNestedTlbPageTableReclamations", 142 },
> +	{ "VpNestedTlbPageTableEvictions", 143 },
> +	{ "VpFlushGuestPhysicalAddressSpaceHypercalls", 144 },
> +	{ "VpFlushGuestPhysicalAddressListHypercalls", 145 },
> +	{ "VpPostedInterruptNotifications", 146 },
> +	{ "VpPostedInterruptScans", 147 },
> +	{ "VpTotalCoreRunTime", 148 },
> +	{ "VpMaximumRunTime", 149 },
> +	{ "VpHwpRequestContextSwitches", 150 },
> +	{ "VpWaitingForCpuTimeBucket0", 151 },
> +	{ "VpWaitingForCpuTimeBucket1", 152 },
> +	{ "VpWaitingForCpuTimeBucket2", 153 },
> +	{ "VpWaitingForCpuTimeBucket3", 154 },
> +	{ "VpWaitingForCpuTimeBucket4", 155 },
> +	{ "VpWaitingForCpuTimeBucket5", 156 },
> +	{ "VpWaitingForCpuTimeBucket6", 157 },
> +	{ "VpVmloadEmulationCount", 158 },
> +	{ "VpVmloadEmulationTime", 159 },
> +	{ "VpVmsaveEmulationCount", 160 },
> +	{ "VpVmsaveEmulationTime", 161 },
> +	{ "VpGifInstructionEmulationCount", 162 },
> +	{ "VpGifInstructionEmulationTime", 163 },
> +	{ "VpEmulatedErrataSvmInstructions", 164 },
> +	{ "VpPlaceholder1", 165 },
> +	{ "VpPlaceholder2", 166 },
> +	{ "VpPlaceholder3", 167 },
> +	{ "VpPlaceholder4", 168 },
> +	{ "VpPlaceholder5", 169 },
> +	{ "VpPlaceholder6", 170 },
> +	{ "VpPlaceholder7", 171 },
> +	{ "VpPlaceholder8", 172 },
> +	{ "VpContentionTime", 173 },
> +	{ "VpWakeUpTime", 174 },
> +	{ "VpSchedulingPriority", 175 },
> +	{ "VpRdpmcInstructionsCount", 176 },
> +	{ "VpRdpmcInstructionsTime", 177 },
> +	{ "VpPerfmonPmuMsrAccessesCount", 178 },
> +	{ "VpPerfmonLbrMsrAccessesCount", 179 },
> +	{ "VpPerfmonIptMsrAccessesCount", 180 },
> +	{ "VpPerfmonInterruptCount", 181 },
> +	{ "VpVtl1DispatchCount", 182 },
> +	{ "VpVtl2DispatchCount", 183 },
> +	{ "VpVtl2DispatchBucket0", 184 },
> +	{ "VpVtl2DispatchBucket1", 185 },
> +	{ "VpVtl2DispatchBucket2", 186 },
> +	{ "VpVtl2DispatchBucket3", 187 },
> +	{ "VpVtl2DispatchBucket4", 188 },
> +	{ "VpVtl2DispatchBucket5", 189 },
> +	{ "VpVtl2DispatchBucket6", 190 },
> +	{ "VpVtl1RunTime", 191 },
> +	{ "VpVtl2RunTime", 192 },
> +	{ "VpIommuHypercalls", 193 },
> +	{ "VpCpuGroupHypercalls", 194 },
> +	{ "VpVsmHypercalls", 195 },
> +	{ "VpEventLogHypercalls", 196 },
> +	{ "VpDeviceDomainHypercalls", 197 },
> +	{ "VpDepositHypercalls", 198 },
> +	{ "VpSvmHypercalls", 199 },
> +	{ "VpBusLockAcquisitionCount", 200 },
> +	{ "VpLoadAvg", 201 },
> +	{ "VpRootDispatchThreadBlocked", 202 },
> +	{ "VpIdleCpuTime", 203 },
> +	{ "VpWaitingForCpuTimeBucket7", 204 },
> +	{ "VpWaitingForCpuTimeBucket8", 205 },
> +	{ "VpWaitingForCpuTimeBucket9", 206 },
> +	{ "VpWaitingForCpuTimeBucket10", 207 },
> +	{ "VpWaitingForCpuTimeBucket11", 208 },
> +	{ "VpWaitingForCpuTimeBucket12", 209 },
> +	{ "VpHierarchicalSuspendTime", 210 },
> +	{ "VpExpressSchedulingAttempts", 211 },
> +	{ "VpExpressSchedulingCount", 212 },
> +	{ "VpBusLockAcquisitionTime", 213 },
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	{ "VpSysRegAccessesCount", 9 },
> +	{ "VpSysRegAccessesTime", 10 },
> +	{ "VpSmcInstructionsCount", 11 },
> +	{ "VpSmcInstructionsTime", 12 },
> +	{ "VpOtherInterceptsCount", 13 },
> +	{ "VpOtherInterceptsTime", 14 },
> +	{ "VpExternalInterruptsCount", 15 },
> +	{ "VpExternalInterruptsTime", 16 },
> +	{ "VpPendingInterruptsCount", 17 },
> +	{ "VpPendingInterruptsTime", 18 },
> +	{ "VpGuestPageTableMaps", 19 },
> +	{ "VpLargePageTlbFills", 20 },
> +	{ "VpSmallPageTlbFills", 21 },
> +	{ "VpReflectedGuestPageFaults", 22 },
> +	{ "VpMemoryInterceptMessages", 23 },
> +	{ "VpOtherMessages", 24 },
> +	{ "VpLogicalProcessorMigrations", 25 },
> +	{ "VpAddressDomainFlushes", 26 },
> +	{ "VpAddressSpaceFlushes", 27 },
> +	{ "VpSyntheticInterrupts", 28 },
> +	{ "VpVirtualInterrupts", 29 },
> +	{ "VpApicSelfIpisSent", 30 },
> +	{ "VpGpaSpaceHypercalls", 31 },
> +	{ "VpLogicalProcessorHypercalls", 32 },
> +	{ "VpLongSpinWaitHypercalls", 33 },
> +	{ "VpOtherHypercalls", 34 },
> +	{ "VpSyntheticInterruptHypercalls", 35 },
> +	{ "VpVirtualInterruptHypercalls", 36 },
> +	{ "VpVirtualMmuHypercalls", 37 },
> +	{ "VpVirtualProcessorHypercalls", 38 },
> +	{ "VpHardwareInterrupts", 39 },
> +	{ "VpNestedPageFaultInterceptsCount", 40 },
> +	{ "VpNestedPageFaultInterceptsTime", 41 },
> +	{ "VpLogicalProcessorDispatches", 42 },
> +	{ "VpWaitingForCpuTime", 43 },
> +	{ "VpExtendedHypercalls", 44 },
> +	{ "VpExtendedHypercallInterceptMessages", 45 },
> +	{ "VpMbecNestedPageTableSwitches", 46 },
> +	{ "VpOtherReflectedGuestExceptions", 47 },
> +	{ "VpGlobalIoTlbFlushes", 48 },
> +	{ "VpGlobalIoTlbFlushCost", 49 },
> +	{ "VpLocalIoTlbFlushes", 50 },
> +	{ "VpLocalIoTlbFlushCost", 51 },
> +	{ "VpFlushGuestPhysicalAddressSpaceHypercalls", 52 },
> +	{ "VpFlushGuestPhysicalAddressListHypercalls", 53 },
> +	{ "VpPostedInterruptNotifications", 54 },
> +	{ "VpPostedInterruptScans", 55 },
> +	{ "VpTotalCoreRunTime", 56 },
> +	{ "VpMaximumRunTime", 57 },
> +	{ "VpWaitingForCpuTimeBucket0", 58 },
> +	{ "VpWaitingForCpuTimeBucket1", 59 },
> +	{ "VpWaitingForCpuTimeBucket2", 60 },
> +	{ "VpWaitingForCpuTimeBucket3", 61 },
> +	{ "VpWaitingForCpuTimeBucket4", 62 },
> +	{ "VpWaitingForCpuTimeBucket5", 63 },
> +	{ "VpWaitingForCpuTimeBucket6", 64 },
> +	{ "VpHwpRequestContextSwitches", 65 },
> +	{ "VpPlaceholder2", 66 },
> +	{ "VpPlaceholder3", 67 },
> +	{ "VpPlaceholder4", 68 },
> +	{ "VpPlaceholder5", 69 },
> +	{ "VpPlaceholder6", 70 },
> +	{ "VpPlaceholder7", 71 },
> +	{ "VpPlaceholder8", 72 },
> +	{ "VpContentionTime", 73 },
> +	{ "VpWakeUpTime", 74 },
> +	{ "VpSchedulingPriority", 75 },
> +	{ "VpVtl1DispatchCount", 76 },
> +	{ "VpVtl2DispatchCount", 77 },
> +	{ "VpVtl2DispatchBucket0", 78 },
> +	{ "VpVtl2DispatchBucket1", 79 },
> +	{ "VpVtl2DispatchBucket2", 80 },
> +	{ "VpVtl2DispatchBucket3", 81 },
> +	{ "VpVtl2DispatchBucket4", 82 },
> +	{ "VpVtl2DispatchBucket5", 83 },
> +	{ "VpVtl2DispatchBucket6", 84 },
> +	{ "VpVtl1RunTime", 85 },
> +	{ "VpVtl2RunTime", 86 },
> +	{ "VpIommuHypercalls", 87 },
> +	{ "VpCpuGroupHypercalls", 88 },
> +	{ "VpVsmHypercalls", 89 },
> +	{ "VpEventLogHypercalls", 90 },
> +	{ "VpDeviceDomainHypercalls", 91 },
> +	{ "VpDepositHypercalls", 92 },
> +	{ "VpSvmHypercalls", 93 },
> +	{ "VpLoadAvg", 94 },
> +	{ "VpRootDispatchThreadBlocked", 95 },
> +	{ "VpIdleCpuTime", 96 },
> +	{ "VpWaitingForCpuTimeBucket7", 97 },
> +	{ "VpWaitingForCpuTimeBucket8", 98 },
> +	{ "VpWaitingForCpuTimeBucket9", 99 },
> +	{ "VpWaitingForCpuTimeBucket10", 100 },
> +	{ "VpWaitingForCpuTimeBucket11", 101 },
> +	{ "VpWaitingForCpuTimeBucket12", 102 },
> +	{ "VpHierarchicalSuspendTime", 103 },
> +	{ "VpExpressSchedulingAttempts", 104 },
> +	{ "VpExpressSchedulingCount", 105 },
> +#endif
> +};
> +

The patch puts a blank line at the end of the new hv_counters.c file. When =
using
"git am" to apply this patch, I get this warning:

.git/rebase-apply/patch:499: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Line 499 is that blank line at the end of the new file. If I modify the pat=
ch to remove
the adding of the blank line, "git am" will apply the patch with no warning=
. This
should probably be fixed.

Michael


