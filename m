Return-Path: <linux-hyperv+bounces-11645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wHzqIQx4NWq7xAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11645-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 19:10:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE46A73E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 19:10:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=VEBvzWR9;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11645-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11645-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F888303B5A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC53C10A4;
	Fri, 19 Jun 2026 17:09:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020142.outbound.protection.outlook.com [40.93.198.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EBD378D6B;
	Fri, 19 Jun 2026 17:09:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888991; cv=fail; b=IhfhNMbPPChD5Fs13i+UYpo8hR4N2pqS6f+Vm9/SSwwmFiYN2RTiHOaIj+dfmxxWrkd12cb5i+XJ3+uup3Pkq9YOXf0AxzaWKeoR8Xq5ndmNvZEPAQjQP7DzCdPTyhBh7Yvm/pcnEnIHAIgemsGpT6igme+Q7V7xHhvvgFmnhVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888991; c=relaxed/simple;
	bh=lkucARzExiK8wPULVmNb1dkD/YQXBXzTdKjEJYtUkQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=it6KErzwxOV9om9psOu2SDp9m+M701RNZ4ocovZJbqtHCENcner7WpDE3WZkM57xcsEqw3zyT4o5sVfXhbnzQ1xAVrR/6/OemWywlPYJ3ZLvb8YZWSCt2yVgx1Uvy+vJOkmIfH5GFDIvWvCKZuzipoJBLv97yimtI+8N6AkfWQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VEBvzWR9; arc=fail smtp.client-ip=40.93.198.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlMPJnb0vIIBJH9e3d9DYdtAEukO5ggcyD9TYU9iZAHCwWsbaKQqNTMFY+bJ+l7xvp6dtwRK2JSqHG0DPtA6Z5akqD38j6WZHRCSKciIuUSZsfbuILlJ478fsPPcme8LXltBl2aqgRsvXprX/eWNrEC0uK542NxZbX9H37m2BkKmBo2dwZWxbSHYDOvf1Hl5FjwZdzbTe2P6wITmuJvdIXjBm/z4/HHRuQo+Rd2G0lJJdfO+3oC4m+WzFAFYiTet0fqbl7HhjFpqHrnkf+IvhWHqo/QENnc3pnjKssF8qE2K3TanGNFlQyyQ/wjoywBnpdgxIdhUrVGR7s2otMEZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SYByenU6xFHdWHB+oIwB4JN6j1McTef7XUhvK9Kz0g=;
 b=avSwOo+TEU+tQh1KxJbNUvTyV+ANtJaGRhOVeliAAqa1DXFjlhdlgadd5us4GXdInnicVV04Nge6rxkOA1zLOt3V9UIpfd3MBYU6GMYvszK+xatlk1mWbZMc/T0HjUBZN3ncOGD4ZhfhS6F1XH3eDUvS+vQNZ4CYudf4U1GU8PZxvHtPVOKokKB97N/up//Rjb4Aht6jaeeAHLRNF4mO4a3OwOJ/WaEdhCTcua0Dm/PY82iOX+3BRM5jnmbGHa35sks/RPpZ8wYjsJ3vzDAGNlLTq5thbPmtvpDLRcFnXeAO7+s7e6nu3/k3aWz9NEoTQ07Y+jxtcaG/zbAJ+m/EMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SYByenU6xFHdWHB+oIwB4JN6j1McTef7XUhvK9Kz0g=;
 b=VEBvzWR9EFNq1jM3A1jr77CM+Wjl0sKn6kOVF9mVRpf92Jx/Q3EWhfWMWNZ4u6wUgzep+2nwSgmcsUU+0XNG0voxeT7eheCAuXdY/IH5pXGz8J54/md0HRw2+J/LQO3fC5vVWuvDxOnpfCPKep/hZd4FHaE9rSzDJ7QyPynDtcw=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6227.namprd21.prod.outlook.com (2603:10b6:806:4aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.1; Fri, 19 Jun
 2026 17:09:47 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Fri, 19 Jun 2026
 17:09:47 +0000
From: Long Li <longli@microsoft.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>
CC: Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen
	<kaishen@linux.alibaba.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v2 2/2] RDMA/mana_ib: initialize err for empty
 send WR lists
Thread-Topic: [EXTERNAL] [PATCH v2 2/2] RDMA/mana_ib: initialize err for empty
 send WR lists
Thread-Index: AQHc/tl2rWHNd4X9KUi5L82kWLpWd7ZGHweA
Date: Fri, 19 Jun 2026 17:09:47 +0000
Message-ID:
 <SA1PR21MB6683A0681F5C4FAC2A820EBBCEE22@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260618041752.481193-1-ruoyuw560@gmail.com>
 <20260618041752.481193-2-ruoyuw560@gmail.com>
In-Reply-To: <20260618041752.481193-2-ruoyuw560@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=43c036b5-6e1a-4e62-bf53-d458b0925df2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-19T17:09:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6227:EE_
x-ms-office365-filtering-correlation-id: 98529f39-dd23-446b-742c-08dece2590d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 gAufnaMNCCTmVLRMX5kEH8kb7D+hmwZrqHjEXvWChtJJlAzg4Who48KANYiSlAlLDbBpeC+HCKyF/UzgtDmNiOo6rXIA3WuQ1Pz3baFJx6YTB9cxgx1DeA3QNhT52IXdur1mKv9Cfl3EmMJQa24Sm1pvrIe+GkZOXdcMHDIRjd35zgKIOtyQZ64brCejlfk2KIsR95nKonCg+QTHMv+6lgm1s+SJWsMza5IBscjWQUG3DloYRA8sPhnhzjgEIGCRI5PwuUcFVakShKNAvYo2ljf6lJjJwq97cBYlT26E9AqbLunVSQwQd9royEgpsgvjxaQVzKc4gfEkatIqMhSXV2Fgew7mYQ4swh1804qKV+TuU3nt46h0blpWfmzhLnkUMo1xmwffn4fqRdRG8gHEfY0YFH7iT98JTHCSFSs+ggm8AP6ZrcN1xun74YkJeJg96bg6Jov32zIukWUqgU1j0XCKdPJo5FQPkNgc5nnptS2EnEmlgGTFZqUcfo1QudN1JfBtbjKXwDW+r9HaLRiqqYSwfjx6MVozmBsYDZtDYMAccWgtXuUkwpbhKmbkkFgaJi5FkK99OCsARIwaH4+1Kf8h/IaSnirDzfcvF0UEhwohUXI2oucLRltz9MNPdMpOUypoAGRfcv1OFxScrO3bX2Q5PI/hCyUoBCg8YGruYcxV6JeN2kiTeb3FciVtSn2t2lvtw+iDx0fZKhMFgVq+71I6GP0r1B45Xf8moyQtKtk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FTyk3KBCrIvHKTkukGz7j+qChBGR2A2HHmOfGZtQWFK7zfwfmEJwnn/ORQUk?=
 =?us-ascii?Q?xcAzZD4kkSiOPGp22Ci7jbE1j+y/7KtFaNcc3pg4AUBWHz6FJ9QIpvITKFpy?=
 =?us-ascii?Q?9aR5hHC+qNqlzbwfR+GA9gDaNMp8KQUbJnUi7Ki3Si8uOQ28sVgsXSIf8Jpe?=
 =?us-ascii?Q?uzXx9dzkQsm/nCBJMN28rZaudsMOeEVVVCjEtt9GGmUSBsvaR3GFpj5iTpWi?=
 =?us-ascii?Q?iVnNcy+5BpB5JCz5sHHxB9c5LWgBcr9laKgJZQW5xyGxtn4QrBigmVUF59B7?=
 =?us-ascii?Q?EjvxXZ3mLLg9+rQc3znS/SB1Wh+VUurUmYgxJaG9Pdns8HBUpHrD1fpqJQsC?=
 =?us-ascii?Q?kLMbGcABpc4oFWPjyzlT+2y0zZ5xq2QeBr7Y20XkShydOYrvfSCGKnhpUNHZ?=
 =?us-ascii?Q?BxLsWSkpWBm5MEXvf6GYdrR3s+432EsVpOmwv0UWiPvXaQ18bZe8KAzqgnW1?=
 =?us-ascii?Q?EDCRRqUqSxNPm2etTLmthb51WIWlnbwEuYFqITOv1EpTCbbR8U7+Jjo3WH1C?=
 =?us-ascii?Q?d5MxJh2gzQ7ELBQxqnuyPof8AqVkIx48SE3h0KpPE1Y1LOk2OK8WxGsH7cl5?=
 =?us-ascii?Q?nK/w629/MuJukU7rlGnD6d460PuXPO+vQDLxFSPr2rwppPtlt8KPk9xm74D2?=
 =?us-ascii?Q?z2cYLrZ/J5gsl4hp0fzMRbj2MDUO1PY53img/8nXxaihLudC5sO6E1/RuplA?=
 =?us-ascii?Q?n1oPAqhfJuraY6GHZpdAT7R5R2QshMsmL3A+RufEmTLQezrKV6+3Eg2xSIBh?=
 =?us-ascii?Q?q6+HPQWmugugKvLHCW2qUIInL3UDaiY7cj4xyOtTHxG+RuETPOkccyjTPSi4?=
 =?us-ascii?Q?AgsBwGl6aezqN8G3nBCH0dMrFzmm8fUPqa7C60BdwPTSqhUd8axTzCdD2hik?=
 =?us-ascii?Q?Ok1ZrBSr1FpQaMROunPS3ozb0voxF5DUoPvRjalbwxDqk5ACIbPEBS0cGNk7?=
 =?us-ascii?Q?O4XNzc9OGER0X4OvY7tACxvnW+pJXRykGLcbXtSznSr31zfYWKUMk5eDAJo7?=
 =?us-ascii?Q?uoIozEHX9YwKpq1SP2zIMBPp1QIyC3NabM4mkS7KlUoF9fKiYeWJ1jghq1FK?=
 =?us-ascii?Q?9w40vvSlGHJqTM8JpXE0vS1Qe8LGKHGFwP80T9F/euf70SovVq4zlPobPG7F?=
 =?us-ascii?Q?CmG9FzgJ/9w/EH6zLchAs3UJxJ+gKkA+H5LnbVfpXL4igYYR4b62defNf3/J?=
 =?us-ascii?Q?1sZKjLWOmNKZXYFSk2cMDN8PxT8rV4gjBI6CrI/F5+St561qH94v3lHVbLi5?=
 =?us-ascii?Q?KX1FJbrR4PbTf/LWwEvIGibFL6eInEY5jmsuZfISWN+Gi0jjdSEuTdmV6TVg?=
 =?us-ascii?Q?quqGCB0h6p/xfQYSYWXdlubyArL3rbhWSs4qaW4+Rtt8qo5ICxjw/BYaHuaq?=
 =?us-ascii?Q?ESJcbcl6WG/NUfynvCAaOxZvfOwY9Q4brf1YmO7JWqEin2vSCJ8AqAJaddGr?=
 =?us-ascii?Q?rbiYIDTEwpMeHu3tjNCw1cAe1lSUtxZQTSVlDErKOc7JmjAbBWlHJyQlrVdi?=
 =?us-ascii?Q?Wkgd6kx0r3x9tqOIlwRBTOK0OvhUJIesu+TLWqzzLVovHB1zT+TGQbTK0UBb?=
 =?us-ascii?Q?nDr8T52dUxSc8nTTDdsZhOxgTeidgdMUQ7xe503kJBNzQcEJ7bQfx+CC+i8N?=
 =?us-ascii?Q?t6Uohgz1wDVGpWILwCi77rKwZ3Fiumep4jIuiSLnI6EixAOTh/WlEFp66Toc?=
 =?us-ascii?Q?I/W6gFGFfbFrJxaRbIFJeiL9bAt9kHqM0HslJP5ALb7X+f19?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98529f39-dd23-446b-742c-08dece2590d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 17:09:47.2174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWgHvcADwbnBiGNDW2ZwH2RXm/lro2vzl4ZAOHhDlesc7h+HGddzslDoydPwWnFp2VeZLZYtXfEamyNxmLxdpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6227
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11645-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:jgg@nvidia.com,m:leonro@nvidia.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:kotaranov@microsoft.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7EE46A73E5

> mana_ib_post_send() returns err after walking the send work request list.
> If the caller passes an empty list, the loop is skipped and err is not as=
signed.
>=20
> Initialize err to 0 so an empty send work request list returns success in=
stead of
> stack data.
>=20
> Fixes: c8017f5b4856 ("RDMA/mana_ib: UD/GSI work requests")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
> v2:
> - Split the erdma and mana_ib changes into separate patches.
> - Add a driver-specific Fixes tag.
>=20
>  drivers/infiniband/hw/mana/wr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/wr.c b/drivers/infiniband/hw/mana=
/wr.c
> index 1813567d3b16c..36a1d506f08f6 100644
> --- a/drivers/infiniband/hw/mana/wr.c
> +++ b/drivers/infiniband/hw/mana/wr.c
> @@ -144,7 +144,7 @@ static int mana_ib_post_send_ud(struct mana_ib_qp
> *qp, const struct ib_ud_wr *wr  int mana_ib_post_send(struct ib_qp *ibqp,
> const struct ib_send_wr *wr,
>                       const struct ib_send_wr **bad_wr)  {
> -       int err;
> +       int err =3D 0;
>         struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, i=
bqp);
>=20
>         for (; wr; wr =3D wr->next) {
> --
> 2.51.0

