Return-Path: <linux-hyperv+bounces-9116-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ5YBjETp2mfdQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9116-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 17:58:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 980981F4386
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 17:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45303300C271
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B663C2766;
	Tue,  3 Mar 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uFvWBDyS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010090.outbound.protection.outlook.com [52.103.10.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE133A874E;
	Tue,  3 Mar 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557082; cv=fail; b=XE6KFO26LTmv04yRcPgoONNlUqOdEK3IXfufX0nQkXepmLyg757DSPjhEEZIA9QVRmgZ0Fx3HO5E8hH1UD01w6u56lb0iO6GKysvGVZnsEiju3WwqwrJQugtfxpAW8e7bQxWlce6Hcado0pc9owyzD/b7fF6n/w0hVzVsmjjKPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557082; c=relaxed/simple;
	bh=h5hVWdLkN/gJKs7MkYTteg6Rn5JWUM1465J+wOPwKfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aTYVu1kTuv1235tZWcUGUkZh5L/yF1IMHPVY+hbuP7rpg5ZODAz4FDL6QXBSuWGR9CsgNym6USE6qUmm5Eis1YS8EZA+Ctjm7O0B0R6Gvxb/yyyYhtSvY3fv6HU/FeHoiUdZXFP71DjPZJb036eL79l6cLidfAXTOoTwLg6Dbyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uFvWBDyS; arc=fail smtp.client-ip=52.103.10.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RijlYDcKboulr6WUcZ2m8c2/saT6AIdmGoX1QzhzvJFH754Iwdc1013ZKoxTOVssEmMTBJkaI5KUy3ZnCGOKjpWl/gnlKIUFxE0f8DiU0O8vNaLKiD+UVOEPWKYONsjZojyrvkMhnRF4vkr7ICPZ4CTvimWVLnMjiWIzzS69i9KfyefOMOuEdRqKBhQeVkcSoFIYXQmP6ISnYIM2SfNEEqvj8Pj5sYp3VyWvJGpxr8EXlk/ywrvAz0BEFwKqgbIrTi8j8YeY+K2O8W0i6kBtUEHXjui9hGvUS/E9VMhrOSA7uTb6qKEUQMH4ngNNHA3Grkt4T90Sg9IFQO2wCkQNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG9rfJlMZT8S83bAaUsLcoD/DWlKr+ATNtHb+SznTX4=;
 b=eB6oQwWCSG0oBDHu6p6PnQ0g33RT+CkVV/7HW8q7VuBm3JTdsl7l594q1QP+eUv0CAIbyJIPO6viHGtKannaWDoq4E1znBOS9d//uhK5S8qKyBrKzkyrVA0EQVugXXLTntX6BmgIfB51Kd78OPVGAWg3QM2e7q0yChfe93NCU0KX+YpECNITw1oScCBwov/P+vdily7LllLDoPEy62u0HrTLd0FAGNZKlV77Nzhvgg0jn1bMvYkCL6MLj4akpp/jqoy7lWaUOVE7T4DMpl+2a/N3uPhs2lBl5kgzUd6Jlq/Yd9D8FNPkieOi6teZXV76Ycpehhbei+mGD9NbYsaKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG9rfJlMZT8S83bAaUsLcoD/DWlKr+ATNtHb+SznTX4=;
 b=uFvWBDySnm06TVz8QGBgpe/mxLqJ1n6DDhxv8ukqOHLz6CCsz0P0vw3xHKBAOyJzhUGyCnPEMznErTpozUcnYh2rGh9ZLNhWlbEmm1S+hY2mQZHpCRnsaHba8VCXasi8WHmET7N+C0rf7NI+op3YC23EySXwQfq9EUPdUXV7otSAxBBzEoeKKWH/PHa6y3r8P2q80x20DPP42RSSXRI3xrEpQl2TCqD3d7lC8TyptPYJDA1GkfjF78yU4M3K1k/OPrKNEfMcIYFIf2a4weFFfu+0x8hJ/pmi0xW5gJWctR7fL7PZJ0YGS05PXegwR0oRaNnVt/wyQNGDYqIS6/2sqA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7933.namprd02.prod.outlook.com (2603:10b6:408:161::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 3 Mar
 2026 16:57:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:57:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>, "mst@redhat.com"
	<mst@redhat.com>, "david@kernel.org" <david@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"ziy@nvidia.com" <ziy@nvidia.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v4 0/5] Allow order zero pages in page reporting
Thread-Topic: [PATCH v4 0/5] Allow order zero pages in page reporting
Thread-Index: AQImoy4NKM/f8j6ZuV279tn+xxicRbUJFwew
Date: Tue, 3 Mar 2026 16:57:53 +0000
Message-ID:
 <SN6PR02MB4157423B85EF905F9845FD03D47FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
In-Reply-To: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7933:EE_
x-ms-office365-filtering-correlation-id: 4490d53e-0c07-4bf9-ad1e-08de79460321
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SLqlfA4kpzLUbq6TAgUu4uyifTbl8Yf/exr6vu3Zg1fYnwnhihDimIM6KeTB/ZWLD8HTdC9B6tUvvpFDDk9RSWujsNCTKkjngpXgFNnIIfIqob1HEXDIiDe6i0KOe5Qtg51NopKMlpkv4S/ALLt2BpSAioFNAkKjWaplmff8O0utC+m8JRI4QojoV3GlZJZ9kX85ckN1168eU5KbilERfGsbk2VjxcE0TXL6dC0eGm1OJKRM7coBq/4U11ukiJz/yRl0tBstD0qf6GZ1ZW281jmUD8peR0I7hGu2lFd1fqWqBMqGQyTPDWCCmqr+49q7foMgJ/gxXHT84KbI1uLlHj9723OP5AJHmmcAQf79lQOtDB2Hg1PuFrjfYv2IwND0uV9JRAdrwTzHFKIbAVtGDduR6OYYmQJGMvns0n1xAE3APVaDhL1JfqaenvbbEPTfLRolQFoddtLYE7mOiAYOdePc1w7eBVzJ3yChW1rH75uL0JZi5/dgrLPaBeKvQ7AIMq+4awFeMylpdjNjefobuxQnHOmKia/QjvqaLSpw+k5wsyWXIQhjIw/WKXiY7FMTFiFQGggAzRVf83ORxKUdrQOrH7SJNx+8jbUTbd+PB2uSC/dXAwXCHRUjR4tiiNczakYE/RRjQJBHuLH4ij3KrPNfXHTAlvZdeWNNxBz5YJxLnxRrhgANlRhS7L2xNgeUs7jDD0/hiNk4Z6+CdDrbbKUMCEdfMmTmRamfWqJyWc6g=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|31061999003|13091999003|461199028|8062599012|51005399006|8060799015|41001999006|15080799012|40105399003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?awFHTAqoezPLM/zx08zM9PWgwa31S+NlsjRXnQpRPszy3dTSx3myVL8w2uKV?=
 =?us-ascii?Q?/WRg3/RyXN9Uvb5tEwz/kvGeuaM4ktENmkPYhvlXkxxOjZJ0I/jWAhDW4TZ/?=
 =?us-ascii?Q?gLX+hgy02AXdPcscTUPdUUVwCh96u9VvkLzdxcGJRYt2U7MGCBe9XctetSAE?=
 =?us-ascii?Q?KoOXKPz7tAnva4PHqrKqpxuKe+1vXqYXfqyIOQ/ujvnPyFJgPODt/PVzU64B?=
 =?us-ascii?Q?vESgtigEqN9JtOy0p+MXWi+/btF4v9lWPFAtfwwagoY30kQkYpGH9KNf061N?=
 =?us-ascii?Q?MtTv798jwX7Pgh/iCJzXdzTsxn4pKAKUQATHYj4i2PQ3LxRprcJGwzR5Kce7?=
 =?us-ascii?Q?a9Y4ewAhlGoKhe1syXpySF5x5Q2aJg0fLFJXvc5WRmQpDJOkkb5HhoVl5fA7?=
 =?us-ascii?Q?pMM3ynReAkWtQl/fa0NSiGQZag/b3IlNUrjB+H6cd/+kMIRXEb4HpfGzVPCX?=
 =?us-ascii?Q?FzgUjZCPuI0bKL08c4VENHls14IYSeCJKUGEbNsM8dxBPvkZtLg9gEW2rR/U?=
 =?us-ascii?Q?AfyNadW48o5hRHcCEE0PI+LIyM5n/p/Q7ocqLi0OMpnugTxNwhw8whO+jBVJ?=
 =?us-ascii?Q?EeVBn7T0tjYU8iDtbm+sciLa4+oJBlAxk1JHDHJ4xFa0D/jJSbEvo34w7Cz0?=
 =?us-ascii?Q?IM9TmtcjBtd4HRHFXduK/0QuWunsH/taPs91hfvhLxHRQ5BLPKwks40LMMKW?=
 =?us-ascii?Q?n481N0LQIt8bmz7g32XwdWBMBb29XExJahyvsGMG5tiuqCtTAZENeExBnojr?=
 =?us-ascii?Q?Gz2Q27Pc/xyQRf+5TpsaomVTbpuSCA9636GMD7F/gxDkNJg0FjTxxdqkLVvz?=
 =?us-ascii?Q?gk3Ijb9yhlIAvA+nt4QMRUk+LJro/KyLpSmzxHIkETLGi2wEuOpdT2ShqSS2?=
 =?us-ascii?Q?WyyJweelV/spLY2ZCtREj8wj/5Px9JAvP6y/MFNkt8E0xWW9hp/WmLtvNKfx?=
 =?us-ascii?Q?0T4MEyT/M/ak2rVX9R50S+uiA79K24nwHekO09f6S2ZEjkUqnAlSC1VgCBJR?=
 =?us-ascii?Q?+elc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jRXK+zu2cYd6BtkOT9FeUMGT9C0UEikTLmOZnlQedgKzsvvZS+fcndSi+VUP?=
 =?us-ascii?Q?AT6gKKtzJB5hhMPrY0mDwCHP5D4uTgjBmQuNda4dkZpsBRSKX8tJmRY7gLo/?=
 =?us-ascii?Q?cCcX8UEtbiLXlzH3lRXhsbsY3arqiGPeb6V2QgNQiE+WvjT39rjoxA+sz7P+?=
 =?us-ascii?Q?cXzx9HepVGuRH5PjLaH8QDO4NUcbh71drFRkrEmgP+bIOFAQtbWbq0KfX4j8?=
 =?us-ascii?Q?zpv4pibjxyzWWmMaF9ogHtNBeBlm33jBif5s0YtJrjvIJHG/Khd7D4yELiBp?=
 =?us-ascii?Q?eoARt+xQgdhVkGseEwLs6+qkFgJvQKm3LACz4AK/CCRAOGeK0NaqGC/g3Rsr?=
 =?us-ascii?Q?bR8d5LksNvcB0YE32wIa+IfjCOEXES0q16HDPXHAWQ3mJwzusIjqqF+B4QCd?=
 =?us-ascii?Q?ShgzD835kbglteqhjK7s8cA/hpMich8n8dalxVlkcAl+DagxcDzxa3275ZwF?=
 =?us-ascii?Q?I6Z+KJB7/AjCow+wY1YNQHUO2TDd25Xi10CMYW1E5Zwx14JgHlcQG5OLshQR?=
 =?us-ascii?Q?MkI8HfsFoAv4Q8ZbT4JmoXKJciQAnSvPylHSLlEB9GdWY2PSemVt9p0Md5gr?=
 =?us-ascii?Q?S/SlBa48o+9GT8WwgKsQ5ok4kpt6yIwfLVMIYkBON5zesN4YzKYZJehupoRS?=
 =?us-ascii?Q?vJq0HA/tiPIu83f+lEjDFu4K2fNnFV8vWDe4BZRy3IlFxs9a9dsir2E8R45Q?=
 =?us-ascii?Q?Ny4olqoRgvvRRsLcwkbS7qEo77FQJGHao9mC+wTT4EZ3Qv9rpwH4C6LGqwGw?=
 =?us-ascii?Q?GI/FCHpNFoHVU9A1BYwgC11/uGOMBOa6qcU5xRhV4LhUulNzg2ZMx/mCSlX+?=
 =?us-ascii?Q?X8FSQmsSnG6efqLW+64oazkr2QaG+zQtyCXO14t1f4Hr9L3ytnDiuu5WHEIU?=
 =?us-ascii?Q?G/TNKzMJLgAayBFCnH4J844h2+YZEJA1DL4eQYxuHq2qqd1Kt5np6r0yoHmg?=
 =?us-ascii?Q?kZyBasUccpdVj9ncV8skD9+Aej8syQ7kBJn01S6n93/wIdRSIZ6clnJ857YL?=
 =?us-ascii?Q?J6xkDnl++iJy7vbGYRpWpyAM2ecAvhZWb5pKwM7Z+CD+nuicDxyWM9dmgqZ+?=
 =?us-ascii?Q?5B9uQ6nZKzNBxTi1avBYX/2Fq4xcoWoclc7FD8RjpUUfO0rhgPXpKuLdYTnE?=
 =?us-ascii?Q?R3hbAKbOs5XqTEev5T03NKLt/v4T+QP7t4xYFEUwlRHCerkQJVeCr+91mKqZ?=
 =?us-ascii?Q?z/t0Q+4cHf8a++pm8U/t4K1kV0uIbx2Ozv9544uylVjFXbQanKwL6pl7wZ+C?=
 =?us-ascii?Q?1dyWRIeSsgCGGI1Y3dwfAoKhoqFdOgzWhi0m3RAHR0kmnqiIzqo/vI8GQDSE?=
 =?us-ascii?Q?FYha4p0mYGgJPh0fuDwN6+bDsfECFQ4QaYPYisM7q76Bjzv9VG7ETrFYUO0C?=
 =?us-ascii?Q?fIEUiYA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4490d53e-0c07-4bf9-ad1e-08de79460321
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 16:57:54.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7933
X-Rspamd-Queue-Id: 980981F4386
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9116-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,outlook.com:dkim,outlook.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com> Sent: Tuesday, Mar=
ch 3, 2026 3:30 AM
>=20
> Today, page reporting sets page_reporting_order in two ways:
>=20
> (1) page_reporting.page_reporting_order cmdline parameter
> (2) Driver can pass order while registering itself.
>=20
> In both cases, order zero is ignored by free page reporting
> because it is used to set page_reporting_order to a default
> value, like MAX_PAGE_ORDER.
>=20
> In some cases we might want page_reporting_order to be zero.
>=20
> For instance, when virtio-balloon runs inside a guest with
> tiny memory (say, 16MB), it might not be able to find a order 1 page
> (or in the worst case order MAX_PAGE_ORDER page) after some uptime.
> Page reporting should be able to return order zero pages back for
> optimal memory relinquishment.
>=20
> This patch changes the default fallback value from '0' to '-1' in
> all possible clients of free page reporting (hv_balloon and
> virtio-balloon) together with allowing '0' as a valid order in
> page_reporting_register().
>=20
> Changes in v1:
> - Introduce PAGE_REPORTING_DEFAULT_ORDER macro (initially set to 0).
> - Make use of new macro in drivers (hv_balloon and virtio-balloon)
>         working with page reporting.
> - Change PAGE_REPORTING_DEFAULT_ORDER to -1 as zero is a valid
>         page order that can be requested.
>=20
> Changes in v2:
> - Better naming. Replace PAGE_REPORTING_DEFAULT_ORDER with
>         PAGE_REPORTING_ORDER_UNSPECIFIED. This takes care of
>         the situation where page reporting order is not specified
>         in the commandline.
> - Minor commit message changes.
>=20
> Changes in v3:
> - Setting page_reporting_order's initial value to
> 	PAGE_REPORTING_ORDER_UNSPECIFIED moved to
> 	PATCH #5.
>=20
> Changes in v4:
> - Move PAGE_REPORTING_ORDER_UNSPECIFIED's usage with
> 	page_reporting_order to patch #5.
>=20
> Yuvraj Sakshith (5):
>   mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
>   virtio_balloon: set unspecified page reporting order
>   hv_balloon: set unspecified page reporting order
>   mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
>   mm/page_reporting: change page_reporting_order to
>     PAGE_REPORTING_ORDER_UNSPECIFIED
>=20
>  drivers/hv/hv_balloon.c         | 2 +-
>  drivers/virtio/virtio_balloon.c | 2 ++
>  include/linux/page_reporting.h  | 1 +
>  mm/page_reporting.c             | 7 ++++---
>  4 files changed, 8 insertions(+), 4 deletions(-)
>=20
> --
> 2.34.1
>=20

For the entire series,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


