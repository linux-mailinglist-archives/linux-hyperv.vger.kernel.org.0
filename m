Return-Path: <linux-hyperv+bounces-9074-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LZGNjgfpWnd3wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9074-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 06:25:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74A1D3119
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 06:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78463014BF5
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9498830F819;
	Mon,  2 Mar 2026 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IpWiq8MV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010021.outbound.protection.outlook.com [52.103.7.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22230E835;
	Mon,  2 Mar 2026 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429109; cv=fail; b=FXc3VYYpw+dn5+3U4g1Zd2C1MAC0V3Ljzl23JmZf2XzSM0PDhGgVwhZpexhBQWots9nMIroFrR/uwujc+myjR4wuuay9W/t1PbgqgqyuumrtB05yj89/Vls+WgYXTK1y2WxDKQbjH/2Rp6w9UWoxJ2dZufEGSQDn71i/wZqn/VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429109; c=relaxed/simple;
	bh=4nGy4IKbIIBR+8GDhGibujW3j07QLoHUHrzWZSEi7wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=emWxv6J8PDoyeEQNhSJAd5Cav4FrTc2wIUDPLfG2bqNUnMjxlUaojMlBmZvkpeBbt8H/2IXonZOW3dr6aottnwxc7cZStT43q8OAMFHo484GcGg98AC5zWhsOaEuBlO3g9rRH5Be1UW6HsXWt3CtN+GAi72nqmm7Is429CpHR2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IpWiq8MV; arc=fail smtp.client-ip=52.103.7.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu+wgebJJ3JFqCKvOf89V7lA1fg6qQzQpu1Ql4ujnFfKytlLX6N9VLWIvqRhOsdeTgTTAj42uJzZPLRSlYzouaGMdFXE9bx55ocaGY4OZ2PhkmtDdQpk5qpOh3HjOeH5HTYmQv+JL7gHXWamYfXfz5RAMQWsGKPKuuonJqmnG0/wrmez413dtIU7azQ5TW1dSfplIxg3sYP24atsZ8MUdrpCGfvB6yd8EOk/zBiP/P7NCIJfOnuUeXDijYMDxvoMdbdh/7Tw4/mu0EEO6bIQR7wRZeasuASusZzKxT6fgc0O4hYoRmndW/aTWuGQWu2D7GfUCv+dUgt04dV9gLEzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nGy4IKbIIBR+8GDhGibujW3j07QLoHUHrzWZSEi7wo=;
 b=GBcUpEw3WfaHY+buZNnmGiTQrQMqT6AJfLQWbknuLJ4FkAYsW9/YS1wDYKK0bDNAPRqVMqVZyYYvseK4uUkENETodFKuHYG6Wn1aQBDWZck+lPAJ2EON+/9AbD0soxMKMV/XuDIMLCIkppBwkYeVcNi7jtkTPxgIb2NhRjB+Q/65xLQXp/WoyF7oVzRVbI6dHxnckaqP9D+/fXj31mWNArrXfM8ukDFrX8s2BgxmJqBPTLNvlK7i4BZlmavtwRQbnjGYiuHBpJS55lD4SToEDfX5CmQgL6hzDXlynSm+WFGoemf9ZS5JJ/EdRjiVDClCG6E8WMs15X9L1LjBCTczwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nGy4IKbIIBR+8GDhGibujW3j07QLoHUHrzWZSEi7wo=;
 b=IpWiq8MVu0End5zrefRXRoWtfTOScqLDIGMhQURtNas2uB6KXi8PFWcAsS3kipPkl0ivQni+nlBO/vwwECjrkEZW9fK0WR3liUezSkAnr93oReb+yUvul9r+PFpJVykXcobf5npOLnQFyoPo7tqAirLQHp8c21BYWxs74pivAROxOW/q9R5uoSBm541bswsb0tbTY9Bxo4QZi4Xv8MQb188qJVqgGGHBRH9tCnG2QA9s7AWBj/XkXuHGlgs8A51ORnMXMPUzPbJgPN440L4VzmnnSaht0WpLgfmmzB+G7qdVEQ3yWU6AMOp6XVpx6s1e2Ec5CPtdr3PJoSXNHTQutg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB10075.namprd02.prod.outlook.com (2603:10b6:a03:558::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 05:25:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 05:25:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>, "David Hildenbrand
 (Arm)" <david@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mst@redhat.com"
	<mst@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"jackmanb@google.com" <jackmanb@google.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/4] page_reporting: change
 PAGE_REPORTING_DEFAULT_ORDER to -1
Thread-Topic: [PATCH v1 4/4] page_reporting: change
 PAGE_REPORTING_DEFAULT_ORDER to -1
Thread-Index: AQFGgIBO18C3F0krVf2s8+cGYIzaEQIMGLpiAbdCcyAC3uHIlLaR8tSw
Date: Mon, 2 Mar 2026 05:25:02 +0000
Message-ID:
 <SN6PR02MB4157D37B3D254251F0135B04D47EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
 <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
In-Reply-To: <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB10075:EE_
x-ms-office365-filtering-correlation-id: 276bf160-a063-4fa4-b987-08de781c0e01
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15080799012|8060799015|8062599012|31061999003|8022599003|13091999003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 IKvi8gbC6N/zckSNikhG8NAj6lxU4Nfx+M5mDPyRA3a9XUO24xsBaOE6fsICXZgTGBq+Beq4+iIBkWLdIEJ0RCUVdneMj6SFJ+LOBhpFPt1tw7Mp5yKklYWYYJjDnAezvJo60S0yuApDaN6i38oxWVNfhF2uxxW150pK9x6LfTGzMYCfPGxS8o1Q3PsXpjGTyGxFGJN9vXEgD2glBkqL8Sb4Fq+B3BMJKdOWMLAT4aro0RXSfaVlxj/o7xT3xq/NjZA7qXkIxzuGpA157OzLhnSESNpHPBkPrIcQ0R7uDKepgeYqmQ/21qb3/wASsQKbYZs63xg5VWt+iyleSHPc711MmlzySmTEMXIVTlcIH7Oc835wzJ23FUp10Z4devERnOdhhE10LiigdXxShv4h7ofwX9vgcmm63OX6yuKdSD1dRyFkJXSTvjOg0W1AZNtslIbBvDkXjTYjNH6rXE9h4wTCzkSlJMK7GzF26JBqf47UmarGPUqV9QP9q7jZDtqyotRzhptzjwJctDQFaR41LQ4k1JczxqU6OZa9MJRlNx+5rD+3xamiKfHhGf98j9/ZpsQErgbY5kLRsJlO4PGjXO7PWOWZmdtMDnql3GKi0H1QS/a2ONe+URFfFdJvAc0aFeG3cItJ94bPB017VdFwPyyRJnGalP7/v2hyhCdIZxmNMdcyULvdnUxJbH/PKH9bjPG50ecHmCWOGAdSxEdYIIQxRSH0K7AAgpuM32FPYF9yTv0gyWMAFMKLqFiq93gD4lD5b70vDb6HehoNBwXdVHmWM6wIoqux8BaOcze0lRUr7YafZFUpDR7xRDD4mCVdLasjrS+QAGeYXTXy+nPRZRVdtMFq0o0m4yMypozCAOx2UxsLcwGhqjQ6Es/0EzraD1QkOKeq3kBfApSzQyKtGg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ry9tUnFpczVaTHo3QjVqbkRQVVpHNXh3SjVkdXZDTlI5WXBVYlJqa1VDbk9K?=
 =?utf-8?B?Syt3akM1K2hkMlBPT3hIWEJXTHAwdzZEalRIZ0RsbnZsdUpWRlhHK0Q2eURt?=
 =?utf-8?B?Q3NhSnhycVJyY25sbEJwK0hTZWNOa1R1S2FQWGNydkI0bEdCMEgwQzhZTWln?=
 =?utf-8?B?bnhCaGd6L3BvdVoxUER3TXc4NzJmLzVvQTNHTC8vU2tCZ3BWU3hicExFNW51?=
 =?utf-8?B?dmhsY1BxWVhEVXAwSkRLejZsbWVzMlVBUTlBdi9yNytyMVFHY2lZUnFaa3ZE?=
 =?utf-8?B?RGN6TUJsNzBrejVZS3BUMi9nT0l4VE1KOFR0Ykc0Z05MSFowcGl2S0pUNDZw?=
 =?utf-8?B?M0d4K3ZYYTJoVkxwb043eGZrQkNBKzY3NHh0MFl2MU5EM0Zqdm9pYkZQUWVE?=
 =?utf-8?B?UkNQeThxQmYrUlorTlpIWHNrQ3ZnemlqL2laZ2Q2QmpRdGxuZ283VHpTMU1S?=
 =?utf-8?B?RHU4K0lPTWowTmYvckRQRFdSMUN2SkVMcTF4Nnlac0h6QmJOcndic3kvMGhX?=
 =?utf-8?B?QllYYnhzM1o3QUhka0J5R3RlbEZFcGFQajh4alQ5ZUQzc0JLL3VyeWhicmpT?=
 =?utf-8?B?ZVlBMlZReWJXTUhDZVg0ejRDTXVBWXlZeFJPb09VaUJOZGNMdGN4QnhsOUhX?=
 =?utf-8?B?VzVxSXkvYU8rUm1ZTzZtbzdaVHByYXNydVNDL3NNNmVrTGtPTmRrcHpOd2ov?=
 =?utf-8?B?MmwyTmIwVkxiVjAyS0hnNHU0VTB3V0tzMjREZGJvSExRNVVvZUdMSlluYXhi?=
 =?utf-8?B?UkYzZEZxelVKaVJpcUxRVGNNLzZ2QlNuUG82YmQ3V0xYcGNDYjZ6RnBoczFV?=
 =?utf-8?B?Mk01YTNQYXF0U0c5VEdqdDA1cnpYZ0hJV214N1NmTkZxc2tNVVQ3M3NlMTZT?=
 =?utf-8?B?YUU1bDZXdGdtWTd5czBqTmU0cU50V0h5RlpMd050M1lRQmxHRDdzNFVWb2NC?=
 =?utf-8?B?MEI3UGsya0RpTFJwRytsYjQ3RFU2eGNwTEtUSmU0SDVnUkFOUGFjaXFLL01F?=
 =?utf-8?B?amtaUUdVaEExWlcra0dOUitucFVLdjRITm5sMTVsOHBqc25Hd1JkUkNaUzFI?=
 =?utf-8?B?ekVBQkcyVjRYUEdsM2VvV3lpdERDcDJ3bWRyK1d2ZzJqUUV3R3o3KzFDcHE2?=
 =?utf-8?B?Vmxza1h4eWZ4RXhtR1UyQkc0VEFJd2dhVTZiYnBZTXRrKzVHSy9XMkg0Tmc1?=
 =?utf-8?B?UjZDclM4cWxyQ0JjelRVUFhVYTZuc3FheExEYUkvRkZ4N3l2NWpaYytyYkcx?=
 =?utf-8?B?bEhZeFQxdU90WVBlYmxGMzRXZGZQdEtKMzFEUExYOU1tci9XdTI4K2VMNXZs?=
 =?utf-8?B?SnhRTEo4anJaZmFqWUR2SDU3S1JwbFJVU3FRU0RUY1NqZzFuemFMczhUUVlR?=
 =?utf-8?B?bXpBTFRaYzlBaUN2dHhXK2hFazVvYXFCbEdzdncvVitJWmZOa1dORzc3Tmwy?=
 =?utf-8?B?YjB1M2lmdTJBbW14SjJla2wvNS9XOW1xTkdXUWx5OHVaMExsenptMlRPdDJu?=
 =?utf-8?B?MFJlWnZTWC9yQnBtNnFESk9DcnVNRnV1MytJaklkaVZNWHAraDg5UmFGaWdS?=
 =?utf-8?B?dndoeG4xU0xJbDkrQU1oZTRhTUxkK3QzVllITTFnRmxBN0ZlVHIwa3BNRkhM?=
 =?utf-8?B?Tll2VHpKdmJyZjJCYXRJMnA0T1BqMmx6TGYzZURxUzZuemlVb0ZGeUZtMkE0?=
 =?utf-8?B?S3c5YjdidjFPSEV1QlZiNlg1Z2pPRC9pODZOL3VHSUZxdFEyUjNvak9uMkJu?=
 =?utf-8?B?MWthRFZBZUo5bjZ2YjJ5ZjhVT2RCSyt6a0xoR212TU0vQUZvU0lPMVVORUNV?=
 =?utf-8?Q?2pk3oyKKBU3JMcwwzsgXDw1y3L95KKJIkgvoc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 276bf160-a063-4fa4-b987-08de781c0e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 05:25:02.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10075
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9074-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 4F74A1D3119
X-Rspamd-Action: no action

RnJvbTogWXV2cmFqIFNha3NoaXRoIDx5dXZyYWouc2Frc2hpdGhAb3NzLnF1YWxjb21tLmNvbT4g
U2VudDogU3VuZGF5LCBNYXJjaCAxLCAyMDI2IDc6MzMgUE0NCj4gDQo+IE9uIEZyaSwgRmViIDI3
LCAyMDI2IGF0IDA5OjUwOjE1UE0gKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIChBcm0pIHdyb3Rl
Og0KPiA+IE9uIDIvMjcvMjYgMTU6MDYsIFl1dnJhaiBTYWtzaGl0aCB3cm90ZToNCj4gPiA+IFBB
R0VfUkVQT1JUSU5HX0RFRkFVTFRfT1JERVIgaXMgbm93IHNldCB0byB6ZXJvLiBUaGlzIG1lYW5z
LA0KPiA+ID4gcGFnZXMgb2Ygb3JkZXIgemVybyBjYW5ub3QgYmUgcmVwb3J0ZWQgdG8gYSBjbGll
bnQvZHJpdmVyIC0tIGFzIHplcm8NCj4gPiA+IGlzIHVzZWQgdG8gc2lnbmFsIGEgZmFsbGJhY2sg
dG8gTUFYX1BBR0VfT1JERVIuDQo+ID4gPg0KPiA+ID4gQ2hhbmdlIFBBR0VfUkVQT1JUSU5HX0RF
RkFVTFRfT1JERVIgdG8gKC0xKSwNCj4gPiA+IHNvIHRoYXQgemVybyBjYW4gYmUgdXNlZCBhcyBh
IHZhbGlkIG9yZGVyIHdpdGggd2hpY2ggcGFnZXMgY2FuDQo+ID4gPiBiZSByZXBvcnRlZC4NCj4g
PiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdXZyYWogU2Frc2hpdGggPHl1dnJhai5zYWtzaGl0
aEBvc3MucXVhbGNvbW0uY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC9wYWdl
X3JlcG9ydGluZy5oIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3BhZ2VfcmVwb3J0aW5nLmggYi9pbmNsdWRlL2xpbnV4L3BhZ2VfcmVwb3J0aW5nLmgNCj4gPiA+
IGluZGV4IGE3ZTNlMzBmMi4uM2ViM2UyNmQ4IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9wYWdlX3JlcG9ydGluZy5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BhZ2VfcmVw
b3J0aW5nLmgNCj4gPiA+IEBAIC03LDcgKzcsNyBAQA0KPiA+ID4NCj4gPiA+ICAvKiBUaGlzIHZh
bHVlIHNob3VsZCBhbHdheXMgYmUgYSBwb3dlciBvZiAyLCBzZWUgcGFnZV9yZXBvcnRpbmdfY3lj
bGUoKSAqLw0KPiA+ID4gICNkZWZpbmUgUEFHRV9SRVBPUlRJTkdfQ0FQQUNJVFkJCTMyDQo+ID4g
PiAtI2RlZmluZSBQQUdFX1JFUE9SVElOR19ERUZBVUxUX09SREVSCTANCj4gPiA+ICsjZGVmaW5l
IFBBR0VfUkVQT1JUSU5HX0RFRkFVTFRfT1JERVIJKC0xKQ0KPiA+DQo+ID4gTm8gbmVlZCBmb3Ig
dGhlICgpLg0KPiA+DQo+ID4gV29uZGVyaW5nIHdoZXRoZXIgd2Ugbm93IGFsc28gd2FudCB0byBk
byBpbiB0aGlzIHBhdGNoOg0KPiA+DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vcGFnZV9yZXBv
cnRpbmcuYyBiL21tL3BhZ2VfcmVwb3J0aW5nLmMNCj4gPiBpbmRleCBmMDA0MmQ1NzQzYWYuLmQ0
MzJhYWRmOWQwNyAxMDA2NDQNCj4gPiAtLS0gYS9tbS9wYWdlX3JlcG9ydGluZy5jDQo+ID4gKysr
IGIvbW0vcGFnZV9yZXBvcnRpbmcuYw0KPiA+IEBAIC0xMSw4ICsxMSw3IEBADQo+ID4gICNpbmNs
dWRlICJwYWdlX3JlcG9ydGluZy5oIg0KPiA+ICAjaW5jbHVkZSAiaW50ZXJuYWwuaCINCj4gPg0K
PiA+IC0vKiBJbml0aWFsaXplIHRvIGFuIHVuc3VwcG9ydGVkIHZhbHVlICovDQo+ID4gLXVuc2ln
bmVkIGludCBwYWdlX3JlcG9ydGluZ19vcmRlciA9IC0xOw0KPiA+ICt1bnNpZ25lZCBpbnQgcGFn
ZV9yZXBvcnRpbmdfb3JkZXIgPSBQQUdFX1JFUE9SVElOR19ERUZBVUxUX09SREVSOw0KPiA+DQo+
ID4gIHN0YXRpYyBpbnQgcGFnZV9vcmRlcl91cGRhdGVfbm90aWZ5KGNvbnN0IGNoYXIgKnZhbCwg
Y29uc3Qgc3RydWN0DQo+ID4ga2VybmVsX3BhcmFtICprcCkNCj4gPiAgew0KPiA+IEBAIC0zNjks
NyArMzY4LDcgQEAgaW50IHBhZ2VfcmVwb3J0aW5nX3JlZ2lzdGVyKHN0cnVjdA0KPiA+IHBhZ2Vf
cmVwb3J0aW5nX2Rldl9pbmZvICpwcmRldikNCj4gPiAgICAgICAgICAqIHBhZ2VibG9ja19vcmRl
ci4NCj4gPiAgICAgICAgICAqLw0KPiA+DQo+ID4gLSAgICAgICBpZiAocGFnZV9yZXBvcnRpbmdf
b3JkZXIgPT0gLTEpIHsNCj4gPiArICAgICAgIGlmIChwYWdlX3JlcG9ydGluZ19vcmRlciA9PSBQ
QUdFX1JFUE9SVElOR19ERUZBVUxUX09SREVSKSB7DQo+ID4NCj4gPg0KPiANCj4gU3VyZS4gTm93
IHRoYXQgSSB0aGluayBvZiBpdCwgZG9u4oCZdCB5b3UgdGhpbmsgdGhlIGZpcnN0IG5lc3RlZCBp
ZigpIHdpbGwNCj4gYWx3YXlzIGJlIGZhbHNlPyBhbmQgY2FuIGJlIGNvbXByZXNzZWQgZG93biB0
byBqdXN0IG9uZSBpZigpPw0KDQpJIGRvbid0IHRoaW5rIHdoYXQgeW91IHByb3Bvc2UgaXMgY29y
cmVjdC4gVGhlIHB1cnBvc2Ugb2YgdGVzdGluZw0KcGFnZV9yZXBvcnRpbmdfb3JkZXIgZm9yIC0x
IGlzIHRvIHNlZSBpZiBhIHBhZ2UgcmVwb3J0aW5nIG9yZGVyIGhhcw0KYmVlbiBzcGVjaWZpZWQg
b24gdGhlIGtlcm5lbCBib290IGxpbmUuIElmIGl0IGhhcyBiZWVuIHNwZWNpZmllZCwgdGhlbg0K
dGhlIHBhZ2UgcmVwb3J0aW5nIG9yZGVyIHNwZWNpZmllZCBpbiB0aGUgY2FsbCB0byBwYWdlX3Jl
cG9ydGluZ19yZWdpc3RlcigpDQpbZWl0aGVyIGEgc3BlY2lmaWMgdmFsdWUgb3IgdGhlIGRlZmF1
bHRdIGlzIGlnbm9yZWQgYW5kIHRoZSBrZXJuZWwgYm9vdA0KbGluZSB2YWx1ZSBwcmV2YWlscy4g
QnV0IGlmIHBhZ2VfcmVwb3J0aW5nX29yZGVyIGlzIC0xIGhlcmUsIHRoZW4NCm5vIGtlcm5lbCBi
b290IGxpbmUgdmFsdWUgd2FzIHNwZWNpZmllZCwgYW5kIHRoZSB2YWx1ZSBwYXNzZWQgdG8NCnBh
Z2VfcmVwb3J0aW5nX3JlZ2lzdGVyKCkgc2hvdWxkIHByZXZhaWwuDQoNCldpdGggdGhpcyBpbiBt
aW5kLCBzdWJzdGl0dXRpbmcgUEFHRV9SRVBPUlRJTkdfREVGQVVMVF9PUkRFUg0KZm9yIHRoZSAt
MSBpbiB0aGUgdGVzdCBkb2VzbuKAmXQgZXhhY3RseSBtYWtlIHNlbnNlIHRvIG1lLiBUaGUgLTEg
aW4gdGhlDQp0ZXN0IGRvZXNuJ3QgaGF2ZSBxdWl0ZSB0aGUgc2FtZSBtZWFuaW5nIGFzIHRoZSAt
MSBmb3INClBBR0VfUkVQT1JUSU5HX0RFRkFVTFRfT1JERVIuIFlvdSBjb3VsZCBldmVuIHVzZSAt
MiBmb3INCnRoZSBpbml0aWFsIHZhbHVlIG9mIHBhZ2VfcmVwb3J0aW5nX29yZGVyLCBhbmQgaGVy
ZSBpbiB0aGUgdGVzdCwgaW4NCm9yZGVyIHRvIG1ha2UgdGhhdCBkaXN0aW5jdGlvbiBvYnZpb3Vz
LiBPciB1c2UgYSBzZXBhcmF0ZSBzeW1ib2xpYw0KbmFtZSBsaWtlIFBBR0VfUkVQT1JUSU5HX09S
REVSX05PVF9TRVQuDQoNCk1pY2hhZWwgS2VsbGV5DQoNCj4gDQo+IC0gICAgICAgaWYgKHBhZ2Vf
cmVwb3J0aW5nX29yZGVyID09IFBBR0VfUkVQT1JUSU5HX0RFRkFVTFRfT1JERVIpIHsNCj4gLSAg
ICAgICAgICAgICAgIGlmIChwcmRldi0+b3JkZXIgIT0gUEFHRV9SRVBPUlRJTkdfREVGQVVMVF9P
UkRFUiAmJg0KPiAtICAgICAgICAgICAgICAgICAgICAgICBwcmRldi0+b3JkZXIgPD0gTUFYX1BB
R0VfT1JERVIpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHBhZ2VfcmVwb3J0aW5nX29yZGVy
ID0gcHJkZXYtPm9yZGVyOw0KPiAtICAgICAgICAgICAgICAgZWxzZQ0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICBwYWdlX3JlcG9ydGluZ19vcmRlciA9IHBhZ2VibG9ja19vcmRlcjsNCj4gLSAg
ICAgICB9DQo+ICsgICAgICAgcGFnZV9yZXBvcnRpbmdfb3JkZXIgPSBwYWdlYmxvY2tfb3JkZXI7
DQo+ICsNCj4gKyAgICAgICBpZiAocHJkZXYtPm9yZGVyICE9IFBBR0VfUkVQT1JUSU5HX0RFRkFV
TFRfT1JERVIgJiYNCj4gKyAgICAgICAgICAgICAgIHByZGV2LT5vcmRlciA8PSBNQVhfUEFHRV9P
UkRFUikNCj4gKyAgICAgICAgICAgICAgIHBhZ2VfcmVwb3J0aW5nX29yZGVyID0gcHJkZXYtPm9y
ZGVyOw0KPiANCj4gVGhhbmtzLA0KPiBZdXZyYWoNCj4gDQo+ID4NCj4gPiAoYW5kIHdvbmRlcmlu
ZyB3aGV0aGVyIHdlIHNob3VsZCBoYXZlIGNhbGxlZCBpdA0KPiA+IFBBR0VfUkVQT1JUSU5HX1VT
RV9ERUZBVUxUX09SREVSIHRvIG1ha2UgaXQgY2xlYXJlciB0aGF0IGl0IGlzIG5vdCBhbg0KPiA+
IGFjdHVhbCBvcmRlci4gTGVhdmluZyB0aGF0IHVwIHRvIHlvdSA6KSApDQo+ID4NCj4gPiAtLQ0K
PiA+IENoZWVycywNCj4gPg0KPiA+IERhdmlkDQoNCg==

