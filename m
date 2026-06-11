Return-Path: <linux-hyperv+bounces-11610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RXKmF+ABK2qd1AMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11610-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 20:43:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8FB6748B2
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 20:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=KJvdhnMz;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11610-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11610-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A53130363A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B04D2EC5;
	Thu, 11 Jun 2026 18:38:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023111.outbound.protection.outlook.com [40.107.201.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB5409E01;
	Thu, 11 Jun 2026 18:38:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203130; cv=fail; b=c6l6PYZJKWDeWYFIRUnLRgoCqAN1phC6Jx1ktrZ0VV/5nlqNqAHq24b8PgnnIUKAK5eIn3SN2AUcrcl9ckl0ElbqcuLrrls11u5PpSa+JtKEghcnE5y7G0bbXHY44b8FryymI6GvOXIWUYj47Uu6vEdpah89121O6PvYXzvrob4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203130; c=relaxed/simple;
	bh=neUF6C40ltTP2z8l8sjRXlENiVbaWR5WmyE9OaVCoBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdGIC+yxa4RJCBkF6GqN8Y4LEntjHdFhsJoBgm505pYOEYhhTKNMFfsw9XQhufkjPi2aKOTJnki2SHmB/WNFa/Bkt0D+o+4xx/ikVB76ZiT1gfjV9zam5bQ4dS2O2/1W8u2aeZaHAAUTN3uoODxcgKcY6ylPHQwfOg1xyDyWyS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KJvdhnMz; arc=fail smtp.client-ip=40.107.201.111
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogOTXJI03pTq+Kpqr5eiqOqGLWiCirkTIHMzU5aGSxA0ruWT67irEUmy8wR5ZK94O4wBJTy5Hg48kRlduunaLMKlM6nFiluoJWUOoxWMiWD9zcDr6Zbee9KG44DTBd+hTtBCxfOH73dpoDh11yNNL+7L0FgHCo2t1/HcyQj1Smk22vXoD14FL6N2FwpajhuLTggytiBvnAw7+6QQlSEJa5ZI0qb3UGhtFUbQtJveI09Wcn4Y4+sIT8RETzuKxFdXWEQmjegPgJrpucLsvc4SNp07Lex2qnk1o3wJATL+PJGdqbG4GtMCvhFtVm6+3GX0wnaVY/GiuBmgntiLj3rlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWGVqU4j4kKwh5yMfFFdoP3PH/zYZiyb2C/W0H8bAYE=;
 b=yoeNrRPgecRIrY8BTH45SY8Szv9RoijcvXnZo7+IT+di47P9UTPitAUD/QOn4/3ScbB/YoAVRZgJk5Sxsj+kvZGsYCcJ0vVMyWZZiIf+AIYVMLVjBenbbsaU7D8APFSIkLRx8OSBYg31cjLD73k42PfZXSOfPiYS4516j8jXt5j9tCh67eObLAhhZQMlpXn3ChH0hUWFYTnYSJff6+XMsB8nRnzbUKUDD323yBJSoIRXhFJFG0uscNif7igVQrQ0NJ3HJatzrqplyHPzc1hWjQq8/g/M/a9KV3Xm20jl9BXmZwkeTOGbi4mlSF3T0eMrwlplj6cGRDBh/zyb0pjMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWGVqU4j4kKwh5yMfFFdoP3PH/zYZiyb2C/W0H8bAYE=;
 b=KJvdhnMzHpYRFPC3URPYPdL85PkrfkCxGTb/uWwZwObT/jHOOzXNiOBZHd3tGtYnXdimSXvoaZkKFvvoxdPP2taUgj/9TJ/1Bk7E79MJshGXJHGtGTwxDh7QJBw9beCtgnfo9deqBzL+BjvNktHjGDaU8HOCOlse76RvIq8szJU=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6224.namprd21.prod.outlook.com (2603:10b6:806:4a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 18:38:45 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 18:38:44 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li
	<longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Add Interrupt
 Moderation support
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Add Interrupt
 Moderation support
Thread-Index: AQHc9Hvnc8R+OuuuVUezkHZXdfhMurY2RJmAgANw+dA=
Date: Thu, 11 Jun 2026 18:38:44 +0000
Message-ID:
 <SA3PR21MB3867834B58ABCAA272CA72A5CA1B2@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
 <dcd35c42-3aae-4ba2-bd84-4af08467b2fc@redhat.com>
In-Reply-To: <dcd35c42-3aae-4ba2-bd84-4af08467b2fc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42efeff9-93c6-41b7-a132-5e4072e2b716;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-11T18:22:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6224:EE_
x-ms-office365-filtering-correlation-id: 4059f281-46d4-4a49-db04-08dec7e8ab02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|38070700021|18002099003|22082099003|921020|4133799003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 fofhhVbaedyoHUOXSQSe2TlOLXsYj1XZNuhBZJGVCQIXMK0Oir3fnqrFQSdafRtuUCc293sCtIMW2gfkI++2ggA/NJbHs/zJGdT8cnqg3ZedzwQtv+UqenLI33Sqc/j235GrWNSivYpGPZ07jgZGd4sYRlyfUiTZ2hpGhDf8QNdG8C/KGh9jxCT5Zy6OmFkIurvNdQNMxOifPI+LwMRm9JqCC8CQrSu8mM2Rmbt4zxhMOrQL40C4G1G5Eu00BjCfvYPPpog7x/uH7OQuNEptEw7WZQ26PT6DgXv2jdfnBXR53bcEjrO5bfv4zXxqPSkCcr6wMlJFW/KTKXYeoTQb60Wu84DQVuBtewiS0EpbI0STCc+QnsVpMHFXEMFmvzjqkjkOSjJrrffcE/dSWYJ2VQoYQlHOyDSy4pr8yRZv5YrCPVOsPr+rCaZfWgOuPrNBc8v4es3IfgVG8+6h0V92bXAG6lZm1jkRqMcU34ke/iF8Y/lBT2BP4nwXCnzbhyQ9RZM4f6RN0tiftvGxRdnypGqdnlyRXWEj9qWA6us2omzspMNEyai3CqE5X9fOycuRQMmOIwAH/dgTYhJN4/YdiEWWjj4hn+tWYlu4pQiZRorp1RyvB4IadbFuUOSuFODtVyVAT0SQoe9Jpt2fwu0Wg69cZU+2OrraOOJ7zvjACZfqXN1/a/m35FjbzphH79kNi4HdKDblESJcpXGMMASscNMAv73KcQTmLvneGVf5170tk4KRKweyGtJ0gS34KdmGTvaGY8hQzfkAogfLZd5hIg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(38070700021)(18002099003)(22082099003)(921020)(4133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JiIyJElwFNbtwEL+Kfada0mW9LbwCf9sO9zKduCVAVc0QtSB9R6+dPYN0guo?=
 =?us-ascii?Q?mLdyIpRy11vZY7+QygnrRkg38iGlNcqbsayON/Zbb7OhFzUYk0eZZTeJR/lQ?=
 =?us-ascii?Q?4PodNCaF1DjQGQRdF5JOXnodEBwi8165Q7dtPyDKAcfEiAKjFKTKK2AMVJLa?=
 =?us-ascii?Q?vR4WU9XeqNX3wNMSa7Exd3xYKiVad1tsPp0/D/hA6jotQXJ6lxgSsU76YMI5?=
 =?us-ascii?Q?66SBfQFyS6DA+dxNspzCQhL5/7z4iz/jXkcRYEOxkzGPqwT4oqh8z0C6TkuF?=
 =?us-ascii?Q?eLLHb9eHIHhJcb7s0Ycvhlmn9nkBzFSXzTcVxPo4Dcb21u4XfNcRr7zJOH3H?=
 =?us-ascii?Q?s4hTZWiOY2Rg7OHsU7Bz8BH8ZjRej6YLymAI2e3GehBEDekyoC6JASlYd9mw?=
 =?us-ascii?Q?Ng+V9AqHtNFEPcnM146sPQJUpEQK/pYLRUXnk+Xtb6+jw6Mu1n7ZIRJvhvUy?=
 =?us-ascii?Q?tYS07SkvQrbCFzeSu3TjnzvTNGiRRvHF+AE8y9kV09gqNjG/MSgWul9enJhr?=
 =?us-ascii?Q?kIJyJdWaFQypsxoBuGnIctPNDrYkzft3UZ6eQJ2THHGCdM4pFULOzdbSuln6?=
 =?us-ascii?Q?BjSlqf3Xapjum8O/VTzf1JBcqCznaLZRfTrTF1omxNsC9zxD155vzcGK+OaW?=
 =?us-ascii?Q?SJyX0nNmkVu5EajLW0KpQaTTrk6HZ/aovlCPX7X+mspVkDoMs9fbDYfGLZZu?=
 =?us-ascii?Q?FiuDKPR1ZzIg+mjpt9yz3C3syPR9RrdEnXkW9GU5fcSJwOucmp+rKaSiX0mW?=
 =?us-ascii?Q?hCDTffvoR0BUSvco+gC+vHHV/YOTl1vXqZJjSrDfFamALX8ZZ5GqO9a385oi?=
 =?us-ascii?Q?6ICTUeatoWAqNN844rHr/GwWjTmeOqAAPtYiL8zzFzmloandkwayP/lkk33v?=
 =?us-ascii?Q?mVu4fCkNBuZLyndMjpA/AclXnBKxW6V8INNfH1t3zrll9ZFrqY32O5dtBIny?=
 =?us-ascii?Q?61sCRmv2jJbCbo0dHaKuQv3gQPubKq3W4qSjb8b1l9WvHT13TOb6V1IYsFUK?=
 =?us-ascii?Q?rZmhwYlms+yLWdDWXhOLPoeTuj9P6aiHGUAA6tCUSQawtUJR4n/Iq1U39Naz?=
 =?us-ascii?Q?d6F2h62jLqCQuYzvnGi2tvYMYBAlaXYpV1bg0BrWLaU35eJGpy+wOUysaAHK?=
 =?us-ascii?Q?d40vXAxTduqQOyZAEDgmE1QYQPHpdNrTHDNDl1+C9Lb2lQe8iihHRhMmNVln?=
 =?us-ascii?Q?mLsCGhQevuGhucB7tmIdM4o3ODTFzaoZmDjtN3rL4rsxA2sIbxIVGiOEGu66?=
 =?us-ascii?Q?ZLF+TjjRkc9WNWHRpNTsNopwYr2Fs/940xCLmg4ARJG+4TMFik5WY6OPcEta?=
 =?us-ascii?Q?ljE1xmLTBCIvmeUcMS8rq6m+Zmu+6Pw+n46NKgy0GrQAsOAGyoaAqh+cgz52?=
 =?us-ascii?Q?+ONX7Zth0F4SLvcYURfJAyqQhFRAMYSI7aauGpJXoTUMf1d/w9bwd/Wkvaga?=
 =?us-ascii?Q?mt74y2pkpMxu3U3dfyVlOC2Adt0jkn11ZBfdKXDuCu/AsoDt+Ggjho6Z67co?=
 =?us-ascii?Q?hQM+B2NHWJP2uaQVLjbUJqI/0izTjzvUCSdLuuHIc0oR20udqX/Mf9eXso4a?=
 =?us-ascii?Q?YPRvD7YST36CAGtQo5k46W4XaKbAGV3zeJQGioj2wJS6gAhSkBs39ogNnlFq?=
 =?us-ascii?Q?NWYN1VQH1UeNLru7mwzGe/HpRAG2VB5VGA+4yM5NfYv4753k6A9wKkD3mJ3m?=
 =?us-ascii?Q?eLioiE69rC91hxAbWGH3LsW1pu1iZdEpKs9x7OvatUnvgzoKx0+VLJdo1AaH?=
 =?us-ascii?Q?gkq3HyLgdw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4059f281-46d4-4a49-db04-08dec7e8ab02
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 18:38:44.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdr0qx0xZNlht66jO4Z+eGrrrSP2I6Sp8yAkQfZv79AqqrJL1cQ4poknwz9VQ4bV3tbCwx9wLDWMLi/HZX/aWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6224
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11610-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA8FB6748B2



> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Tuesday, June 9, 2026 9:49 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Konstantin Taranov <kotaranov@microsoft.com>;
> Simon Horman <horms@kernel.org>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Kees Cook <kees@kernel.org>; Breno
> Leitao <leitao@debian.org>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Add Interrupt
> Moderation support
>=20
> On 6/5/26 1:41 AM, Haiyang Zhang wrote:
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index db14357d3732..b1e0c444f414 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context
> *apc,
> >
> >  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
> >  			     sizeof(req), sizeof(resp));
> > +
> > +	req.hdr.req.msg_version =3D GDMA_MESSAGE_V3;
> > +	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
>=20
> Sashiko noted the above cold break initialization on older firmware:

Our firmware is forward compatible with newer message versions, so the=20
old firmware still properly handles this message, just the new feature=20
fields are ignored, and queue creation will be successful.
And if the DIM capability bit is zero from FW, driver will keep the DIM
feature to be off and unchangeable.


> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsashi=
ko.
> dev%2F%23%2Fpatchset%2F20260604234211.2056341-1-
> haiyangz%2540linux.microsoft.com&data=3D05%7C02%7Chaiyangz%40microsoft.co=
m%7
> C9cc8d2c7aa7f472ff8e308dec62def04%7C72f988bf86f141af91ab2d7cd011db47%7C1%=
7
> C0%7C639166097783522606%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsI=
l
> YiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C=
%
> 7C%7C&sdata=3DTB7q6EhtR6HJ02Q4f767sXUCmYZyGr3wH1Sz3vLPWfA%3D&reserved=3D0
>=20
> [...]
> > +static void mana_update_rx_dim(struct mana_cq *cq)
> > +{
> > +	struct mana_port_context *apc =3D netdev_priv(cq->rxq->ndev);
> > +	struct mana_rxq *rxq =3D cq->rxq;
> > +	struct dim_sample dim_sample =3D {};
>=20
> Minor nit: please fix the variable declaration order above. Other
> occurrences below.

Done in the new version.

>=20
> [...]
> > @@ -440,17 +474,94 @@ static int mana_set_coalesce(struct net_device
> *ndev,
> >  		return -EINVAL;
> >  	}
> >
> > -	saved_cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
> > +	if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
> > +	    ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
> > +		NL_SET_ERR_MSG_FMT(extack,
> > +				   "coalesce usecs must be <=3D %lu",
> > +				   MANA_INTR_MODR_USEC_MAX);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
> > +	    ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
> > +		NL_SET_ERR_MSG_FMT(extack,
> > +				   "coalesce frames must be <=3D %lu",
> > +				   MANA_INTR_MODR_COMP_MAX);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ec->rx_coalesce_usecs !=3D apc->intr_modr_rx_usec ||
> > +	    ec->rx_max_coalesced_frames !=3D apc->intr_modr_rx_comp ||
> > +	    ec->tx_coalesce_usecs !=3D apc->intr_modr_tx_usec ||
> > +	    ec->tx_max_coalesced_frames !=3D apc->intr_modr_tx_comp)
> > +		modr_changed =3D true;
> > +
> > +	saved.intr_modr_rx_usec =3D apc->intr_modr_rx_usec;
> > +	saved.intr_modr_rx_comp =3D apc->intr_modr_rx_comp;
> > +	saved.intr_modr_tx_usec =3D apc->intr_modr_tx_usec;
> > +	saved.intr_modr_tx_comp =3D apc->intr_modr_tx_comp;
> > +
> > +	apc->intr_modr_rx_usec =3D ec->rx_coalesce_usecs;
> > +	apc->intr_modr_rx_comp =3D ec->rx_max_coalesced_frames;
> > +	apc->intr_modr_tx_usec =3D ec->tx_coalesce_usecs;
> > +	apc->intr_modr_tx_comp =3D ec->tx_max_coalesced_frames;
> > +
> > +	if (!!ec->use_adaptive_rx_coalesce !=3D apc->rx_dim_enabled ||
> > +	    !!ec->use_adaptive_tx_coalesce !=3D apc->tx_dim_enabled)
> > +		dim_changed =3D true;
> > +
> > +	saved.rx_dim_enabled =3D apc->rx_dim_enabled;
> > +	saved.tx_dim_enabled =3D apc->tx_dim_enabled;
> > +	apc->rx_dim_enabled =3D !!ec->use_adaptive_rx_coalesce;
> > +	apc->tx_dim_enabled =3D !!ec->use_adaptive_tx_coalesce;
> > +
> > +	saved.cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
> >  	apc->cqe_coalescing_enable =3D
> >  		kernel_coal->rx_cqe_frames =3D=3D MANA_RXCOMP_OOB_NUM_PPI;
> >
> >  	if (!apc->port_is_up)
> >  		return 0;
> >
> > -	err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> > -	if (err)
> > -		apc->cqe_coalescing_enable =3D saved_cqe_coalescing_enable;
> > +	if (apc->cqe_coalescing_enable !=3D saved.cqe_coalescing_enable &&
> > +	    !modr_changed && !dim_changed) {
> > +		/* If only CQE coalescing setting is changed, we can just
> update
> > +		 * RSS configuration.
> > +		 */
> > +		err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> > +		if (err) {
> > +			netdev_err(ndev, "Change CQE coalescing failed: %d\n",
> > +				   err);
> > +			apc->cqe_coalescing_enable =3D
> > +				saved.cqe_coalescing_enable;
> > +			return err;
> > +		}
> > +		return 0;
> > +	}
> > +
> > +	if (modr_changed || dim_changed) {
> > +		err =3D mana_detach(ndev, false);
> > +		if (err) {
> > +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> > +			goto restore_modr;
> > +		}
> > +
> > +		err =3D mana_attach(ndev);
> > +		if (err) {
> > +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> > +			goto restore_modr;
> > +		}
>=20
> You should try hard to avoid this sequence: if mana_attach fails,
> mana_set_coalesce() will leave the NIC unexpectedly down.

I have updated the patch to use doorbell for this setting change without
re-attach, and will submit the new version soon.

Thanks,
- Haiyang

