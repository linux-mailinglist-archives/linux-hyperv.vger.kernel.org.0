Return-Path: <linux-hyperv+bounces-9873-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGEJL8xOzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9873-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:58:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B96137E49A
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65F563050EFC
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D847CC69;
	Wed,  1 Apr 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="o6tWMH0j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012022.outbound.protection.outlook.com [52.103.10.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171103AEF5C;
	Wed,  1 Apr 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062559; cv=fail; b=dgKeyK/6oOMkhBPIvYwaFRDDWbN3TCMtX2GaSiRQBGFvYegCmSPqvY1CbCmiO3mSdbdaPQX5R+TXKlSMxG4ELyukOpFkHWu0t/LOvX8K8aOne7YLyIL91bizJKKUEYTRr2QqC+Gb2/zwsJS9z8mX1XJxuMnEeXkDIqV62vBSu4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062559; c=relaxed/simple;
	bh=PS7rozRtEtKXOrW+rH6z+33Er8AFvNxb8MbsUP25E8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wjt7t6pvrzmjX7kpzyaxVA0ct23fvQfogFDeY/LDZCmEiQOI1Q7gPGz0hOJsdT/XCAEXOb2VYvHDeXhtgC/dfRd9d/avrB43QVoS96QwDopb0rvpzV2qx3D7jHGS5PweQmgzUaBL6ieD2lhbHrBbxtGq5UdYPsF3JKLUi64TakQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=o6tWMH0j; arc=fail smtp.client-ip=52.103.10.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdxfzLFPWr2EgOzEey0cSXyDwqkQojY4L6IMX4PhM5IozobO5tIv/JPGF8YuUXwc5CwyJX/09guY+UeaMa8dc9Jkbo/kUBYlcG9wfcI1qMnfUypiXZJ5a5OApXZo7IajOm//nFQdZ+SJWH7uAQpv8D//nio3kY3ju3pTVaLEwlDz++KHigOmbZb9ZNfwqOVGGNAYSBsejmExwrSIscbzGkHFoumlt2MPbbbLfZIbgsILQJeup4DOgazTCd4ka0u7BVpMau04FUwNPx2WccEx7tZKvgkZxIGvb6q00/dJWORZkspYqJzyRqhXDG4nObcBm+PiyAKfNcHYIhLApHqVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/56vbd50/S2G5XwmM0gupmOEUC9e7pvBVjABTjG+4o=;
 b=eb5ujgAeBnxYZgY6flA9pXQjIp1ZnDlWX4gvvOK78eaiZXMwXWLOASIt/3AKzAAC1jnbyYFLtUAFwIEzYAGppEbBL0E9NpWLTHpt3f6Oi8/Pg0ZAZdMNxjz1eNV2s9hrH9u8VAXl2r1zegAmiNLr/onjdRSO7MlslAjJ9STmNhL+6JoWIMMwwWwLEM2dbiL/0F7x5AC5T8pA0SkiJQ17FbbsIaP2Ao+xQ07o4TsiELb9I/wvB2kFQP8O7iK70Ktr+3nMMFRdc4pHrFUbItP91KAqqV8v43Ak7aYYHsZDnxLnr6oUIIsq3MBuXl+34SaLXRqmVaWwuXX9KtE20h46sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/56vbd50/S2G5XwmM0gupmOEUC9e7pvBVjABTjG+4o=;
 b=o6tWMH0jykMR8KUN7Ru0W48iVSYZ9P4w5IqCZ+xAr2yp63kavnq48Bc47TaE/klBqbHdZWJ2ysOUSA9CWUIVLkJlzpgeOZNaKxrJ2dkp/+QnUHMAapSmE8J4Qzxgowfh6cDkCOduhaHzBbY6rsIAF1yFrc7ubvzDpgmhDOe41nyXVqyR9LTNfvNlgdPqbUrpSg7G2LaHOHuKyMEKkRhkm+K+GE4+lrfn1DTfj+JsJVCgP4keP3HUv2h0t90Kt2zKoQq/sYpKjZ9XACSmO/pK3gzz0pOaKoP9Jg3fzbxaffor57QAckRNXJjrLHj9+XgITD1dwILB4o6gsRgqSEHmEw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:55:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:55:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 03/11] Drivers: hv: Add support to setup percpu vmbus
 handler
Thread-Topic: [PATCH 03/11] Drivers: hv: Add support to setup percpu vmbus
 handler
Thread-Index: AQHctT5Hjs5rHz3eBUaZw+/VWpjENLXKhlFg
Date: Wed, 1 Apr 2026 16:55:55 +0000
Message-ID:
 <SN6PR02MB41570E0F113FE28CFC839476D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-4-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-4-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: 569c7f60-e15c-4ea1-6cd7-08de900f8a58
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6Sx+ZRCqilbxDKy9VOhGuGmkcbu31i/uIJ1tkVlc8WqRpWA7c1bcFL/geL4TZFSbZvkgl7tt5Dzm1bzAicix+MJ/5s0v3Lavh+ecFzg0eNlpxp2J2ytdiyII2KqoTm+mZTYh0n+XLJgN/XOxmmO6F8sWLPrCkdNxran03JOjRWjw5Y479aZKEX9yueqMqrJbQ0ghdQlwb4nW2EKg8Efh33AMJNUUXYWTmo79HXox45lEUg24SfqLvDlTxJVFSTdCoB3zaw3ZmXre5ksAvkpaBjEDINJpexhT7UUWCkwVJH+CZ0T0rUqEnms151ToZy1RKhvTS8iwoQePJjB4oAHp9lNfRlv5kTrWzqWGUtGUXkRuNWsKBZJUqLvQO7mDiRcPTA+0tvfaifmx03WlTGL7wi0EqyN7G2y/NDHQPuc0ayQIRcLlVJuzhfr4J42Y36S97KWDliWLQqqK5BdgOBUb+CVzYe/0ie9QRfMLbap3EWM/jNH64wWWLOTEj/5QZVBezgVJJfRK4VPM0Ehoz2EjNHOlFMwgwccPgUP4OYFGjrZy9xYtoVLjllBBJxM0p6OmmXoykuQx6z1cfz4w8MZrotbqkcVhiPJPacCz813i9FlYAfyMI+TkZrsZvTU9POgH2pyV1jEtTmyT2lZBBk2zHvEJZm6wvcbLLZ6Tgh0qEz2pdy3sQiuWGjn963VNrqAW+C+0xz8QvQSGRC1t+cGSBm1MBJupvCeBJRVY/FYJPDRyM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|37011999003|31061999003|461199028|41001999006|51005399006|15080799012|13091999003|440099028|3412199025|26121999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wPUhV66vaVe1MfsbCbgDj2TgXcOvFYQOQm0zZ2R/NLuDl4+QwYXDOHd7mp+j?=
 =?us-ascii?Q?963VfFgiScCCPbOBM0x+ysZm5IeC+btQflKuG/VlK/Z2GLGXHwjJRRJMtOTL?=
 =?us-ascii?Q?P4flzhUMP66XkRdJuo2La0FJYb91PIGM1V9C/ChwEzGLlfFAybVhtuZMEEZ8?=
 =?us-ascii?Q?u9IPBS9lPgbYwxTjjkO/0PZp54emEaUYwXwbfJjTs2jP6fr64itCUQz8mwo5?=
 =?us-ascii?Q?5QJio2Z99nBjDGzors12xGLEw+btVCPAec3rlVYO73ea3Z5F5Af4ie9p9t0+?=
 =?us-ascii?Q?cTbwaXvzqkHmqKWqBSLdl3j3wlP5j97FepsYXEicnTnHJTBXqXOvg52E5kxO?=
 =?us-ascii?Q?OlUfbpaHI9c6QsBpKzyoVkVku+umeCtLdwo8J+kbKnfsgDnsaut2WmcLUQO8?=
 =?us-ascii?Q?S3EphDwxhoP2ZKSGi0yWcNUhnVV9UzHI192Wyv7Cij94mg1eTTrI5O5soHmJ?=
 =?us-ascii?Q?v5PFkDkiFy5Ya/jvFjb7enDqIU/FHGV7McSPHQFvJrAk55820wc/xcyZSajs?=
 =?us-ascii?Q?fSBQIxFSYlP9rihUqzZivKx/iYsykpRXg2JNi4Rr/q0O6bJmx5gGSJlL9vrA?=
 =?us-ascii?Q?2Dh6A9v28xD0P/Q868m13Aphc5xYxVHpyqCJwh+QwM0pCguprPmB+ByhMsZZ?=
 =?us-ascii?Q?Ls2Mhyxtqks6xfWYOGFswKt49i+VxEEdOxz3+8/nNBGER678s0i+Av3dkT8t?=
 =?us-ascii?Q?Kf4SYqXchko9aUyVLVp1Msv199Of/bP1sGqK/ta9efLluhbrsyXyHAIFREkT?=
 =?us-ascii?Q?cp2JxODS8zzd0sv2wpsam3egvuEQiOjyDtYxxa85XrysLFlVIrAPBnVOO5iB?=
 =?us-ascii?Q?eZD2c1kT0WPhK+D9UlJXzqp+zgUk6emYO0NSl9p4wgoicdwaumhv1DBaKBy5?=
 =?us-ascii?Q?vMPInYrfAOWzIbQV009Zl7x8DBJMpinVJnkKsMZyDCBdZG6VDLq/s2VJ2qGW?=
 =?us-ascii?Q?4otKrboUgmSnc0m0ORH0TBdWmhFItQBL9Pk5cbkxTTZyD9H6SJVcP46izG4T?=
 =?us-ascii?Q?bzJl/0qtrmYRj1Fi468BAP27Y9aFgG98yMLOj0/fqmNtC8YxYTOYyoJqAGl6?=
 =?us-ascii?Q?qOfKsWQ1?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LE/BT6kgZwTo6xg/EZqkym4h5ZBirr0FGf8+qAQxOtvmiVRPzBNEB17kjgcE?=
 =?us-ascii?Q?Jvcw0pSsBhzVZ8Bz/nZdPb+6wxhHro7qPwK5pccVIPZHBRcahd5xZweRavGg?=
 =?us-ascii?Q?qYZVVG9tH3IqwaJwzpal8gBH9G+o5w5K3q2RpRHFjbDnyIqtevxuM7ltfccO?=
 =?us-ascii?Q?2/1bUigJSjm7Y9saj0fnMq5dFGdqP3RqbNM9BZ+Jri+5D38OLjdDHspc0h7n?=
 =?us-ascii?Q?Vf+NMZGAE8pvC8M70ZTSl0RNNsLyE7ci5OR/S6lzZq6JyzFDYR/UXQqOHGqA?=
 =?us-ascii?Q?v3ogfDtA6APJ1e+sxCrgEcwvi7vSYB7U85lAiX8jB+kxbc9zE+2qUdtEtQpP?=
 =?us-ascii?Q?28w8ugFdHm/F2fOZpx5f+u2AZfZ6jVFS/Ms6H2RLKA8Io7SD+UMM7ZpQVefh?=
 =?us-ascii?Q?YJ40xZEWHSyh9eLg6VyFmrEOVOea4GzR061/lxkAS6ZTHv5I2hlFOvBfyaRr?=
 =?us-ascii?Q?yIjLLmgvS66GuYi8OPZPHScVNNsKH8+t1l6Qi9PBoDSI3xrILN9LJ4x8MZII?=
 =?us-ascii?Q?z56H7BEp4gLGaGMiVnaAeyvnSL13vKDcR0SKqRtck+EJsbUvh/ehcCWaf3oZ?=
 =?us-ascii?Q?42HJe/StUtjCEYT+3+B5g6CmLkzJ6kedfg2wu3GeKxKw/NvHuefTv7ibVsb7?=
 =?us-ascii?Q?ASl8RPkdkLB49yxZoKUJxQQaSZe8iOHPKiwk4XIgTC0z8AnPEF/UDJfPzBPh?=
 =?us-ascii?Q?M5HEKlR9adET+Z9iN/PSek8PBnUDz8P7hrSRZTI0sAwtgNjlOQ7B3kJPCFrR?=
 =?us-ascii?Q?Xnc3tPa4GLj+erjFAWlik9LyA25wYEK/q0VyORRxENMintj1YxmKtdO4Bmhm?=
 =?us-ascii?Q?VLjy8L41ZzC21kBujS/7jWaBQ/3J2QnpIdcLMjNyu7YQd/fMLLmAQFmurFzJ?=
 =?us-ascii?Q?5Bc85Gsh+/QuyuJVBOc114FH/Cna/g05dTAenl/eC+xT3R3Z5/ZFOhTKncIz?=
 =?us-ascii?Q?nl7pNdb9Fsan6kcrf4S/4l6Xj1oNF+YCuJkCW7+NYybb5VhSLEZZl9q70r6J?=
 =?us-ascii?Q?dqSPlUkJeaL0JiqbEb3H7K+Qfad9DQ+3vEn7N6bZI9i2OTAD8C1Y5xvkgOE2?=
 =?us-ascii?Q?hHWibx8BxPTmNhYPCJAO5Kd8qWGPr72BssJ+4V4hMcsnlSJb5oH4QjnrNnUo?=
 =?us-ascii?Q?2zdfwVjRxDPaXljZYJlx7dXJDIdDSl+g9yxxettGEkvi1ZEMxpTwVroa6N9J?=
 =?us-ascii?Q?48nRSICHvQbWBrRE7qn7EWzEi9OqTr6nI8c7LRgn5fmdKhvMzbMNpr1pP+lp?=
 =?us-ascii?Q?X8sgZsca3OeaAXXzP5M6WWY9FzKb4J2/7L34C02z7ycaOYjTFKowN+ABxoFl?=
 =?us-ascii?Q?B3hL3sVwKBlAB4+Q7TZIH+qZNLdXKbW2DlrogZJX1KzbpoJd6XS7EiXQjwmH?=
 =?us-ascii?Q?ZSOnXzM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 569c7f60-e15c-4ea1-6cd7-08de900f8a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:55:55.2648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6701
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9873-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 5B96137E49A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> Add a wrapper function - hv_setup_percpu_vmbus_handler(), similar to
> hv_setup_vmbus_handler() to allow setting up custom per-cpu VMBus
> interrupt handler. This is required for arm64 support, to be added
> in MSHV_VTL driver, where per-cpu VMBus interrupt handler will be
> set to mshv_vtl_vmbus_isr() for VTL2 (Virtual Trust Level 2).

Needing both hv_setup_vmbus_handler() and
hv_setup_percpu_vmbus_handler() seems unfortunate. Here's an
alternate approach to consider:

1. I think the x86 VMBus sysvec handler and the vmbus_percpu_isr()
functions could both use the same vmbus_handler global variable.
Looking at your changes in this patch set, hv_setup_vmbus_handler()
and hv_setup_percpu_vmbus_handler() are used together and always
set the same value.

2. So move the global variable vmbus_handler out from arch/x86
and into hv_common.c, and export it. The x86 sysvec handler can
still reference it, and vmbus_percpu_isr() in vmbus_drv.c can
also reference it.  No need to have vmbus_percpu_isr() under
arch/arm64 or have a stub in hv_common.c.

3. hv_setup_vmbus_handler() and hv_remove_vmbus_handler()
also move to hv_common.c.  The __weak stubs go away.

With these changes, only hv_setup_vmbus_handler() needs to
be called, and it works for both x86 with the sysvec handler and
for arm64 with vmbus_percpu_isr().

I haven't coded this up, so maybe there's some problematic detail,
but the idea seems like it would work. If it does work, some of my
comments below are no longer applicable.

>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c   | 13 +++++++++++++
>  drivers/hv/hv_common.c         | 11 +++++++++++
>  drivers/hv/vmbus_drv.c         |  7 +------
>  include/asm-generic/mshyperv.h |  3 +++
>  4 files changed, 28 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d7..d4494ceeaad0 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -134,3 +134,16 @@ bool hv_is_hyperv_initialized(void)
>  	return hyperv_initialized;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +static void (*vmbus_percpu_handler)(void);
> +void hv_setup_percpu_vmbus_handler(void (*handler)(void))
> +{
> +	vmbus_percpu_handler =3D handler;
> +}
> +
> +irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> +{
> +	if (vmbus_percpu_handler)
> +		vmbus_percpu_handler();
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index d1ebc0ebd08f..a5064f558bf6 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -759,6 +759,17 @@ void __weak hv_setup_vmbus_handler(void (*handler)(v=
oid))
>  }
>  EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
>=20
> +irqreturn_t __weak vmbus_percpu_isr(int irq, void *dev_id)
> +{
> +	return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_percpu_isr);
> +
> +void __weak hv_setup_percpu_vmbus_handler(void (*handler)(void))
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_setup_percpu_vmbus_handler);

You've implemented hv_setup_percpu_vmbus_handler() following
the pattern of hv_setup_vmbus_handler(), which is reasonable.
But that turns out to be unnecessarily complicated. The existing
hv_setup_vmbus_handler() has a portion in
arch/x86/kernel/cpu/mshyperv.c as a special case because it uses a
hard-coded interrupt vector on x86/x64, and has its own custom
sysvec code. And there's a need for a __weak stub in hv_common.c
so that vmbus_drv.c will compile on arm64.

But hv_setup_percpu_vmbus_handler() does not have the same
requirements. It could be implemented entirely in vmbus_drv.c,
with no code under arch/x86 or arch/arm64, and no __weak stub
in hv_common.c.  vmbus_drv.c would just need to
EXPORT_SYMBOL_FOR_MODULES, like it already does with vmbus_isr.
I didn't code it up, but I think that approach would be simpler with
fewer piece-parts scattered all over. If so, it would be worth
breaking the symmetry with hv_setup_vmbus_handler().

> +
>  void __weak hv_remove_vmbus_handler(void)
>  {
>  }
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc4fc1951ae1..f99d4f2d3862 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1413,12 +1413,6 @@ void vmbus_isr(void)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
>=20
> -static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> -{
> -	vmbus_isr();
> -	return IRQ_HANDLED;
> -}
> -
>  static void vmbus_percpu_work(struct work_struct *work)
>  {
>  	unsigned int cpu =3D smp_processor_id();
> @@ -1520,6 +1514,7 @@ static int vmbus_bus_init(void)
>  	if (vmbus_irq =3D=3D -1) {
>  		hv_setup_vmbus_handler(vmbus_isr);
>  	} else {
> +		hv_setup_percpu_vmbus_handler(vmbus_isr);
>  		ret =3D request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
>  				"Hyper-V VMbus", &vmbus_evt);
>  		if (ret) {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 108f135d4fd9..b147a12085e4 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -22,6 +22,7 @@
>  #include <linux/bitops.h>
>  #include <acpi/acpi_numa.h>
>  #include <linux/cpumask.h>
> +#include <linux/interrupt.h>
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
>  #include <hyperv/hvhdk.h>
> @@ -179,6 +180,8 @@ static inline u64 hv_generate_guest_id(u64 kernel_ver=
sion)
>=20
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>=20
> +irqreturn_t vmbus_percpu_isr(int irq, void *dev_id);
> +void hv_setup_percpu_vmbus_handler(void (*handler)(void));
>  void hv_setup_vmbus_handler(void (*handler)(void));
>  void hv_remove_vmbus_handler(void);
>  void hv_setup_stimer0_handler(void (*handler)(void));
> --
> 2.43.0
>=20


