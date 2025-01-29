Return-Path: <linux-hyperv+bounces-3802-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32BA22626
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 23:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C2B164F0C
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 22:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732C1ACEB5;
	Wed, 29 Jan 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iiJ4YwHE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023123.outbound.protection.outlook.com [40.93.201.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948418DF60;
	Wed, 29 Jan 2025 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738189360; cv=fail; b=XThmbXcmJ0gE5nOvztpsOywTR5IrVUb/dcj837ogeRrP//qfVtYSFagsYSE32EfMHphpbdsQaL2bn8R19L+emq7SB3poxf4tT9eWfd5QgU5aUI7XZKnQphGyQFC6yFv8SK8QTvgFdftNuhJ7upOO0i8D9D5sCx6RUD/jq+cYgB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738189360; c=relaxed/simple;
	bh=Kn0C+K/PZvMlCPagmNBNMEnSk45FL9Ik7Qt/WtCYm50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VS5ok8acrHZGlgz1QAkV38yK5BWaM0nTJJN6KLb3ijaW/+AnNaVrSXGdsfhQsVUUokr4om1e27QjScSRq58jFNrfZ3fzVcblXcMckuLyQau+EvyFLpNPKihnUcTMyp+svhR8WOKBPZwcNp+XwO09kiNz9FB8ArpFz3dqUJH/3G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iiJ4YwHE; arc=fail smtp.client-ip=40.93.201.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvH2JFLn16yZD7g2htG3tBNR+ktsV0q7CRaRCV++q3CJTA7hCBqQifJaGZG6oo3ZJUqZcwgxWwiykB4IlNcjMRqotfnQErMp+bMh/CAXk/pIO8nUtvTuazdy0R0p4ikUWYAxyxj/xJnkgXMjo8pLuw59tnxc1p24JmTd57ydv/RYUVeK3Tzh44c6ko4B6jPpiwG8E/sVcvhne3wkDscxwgtpg2g43yNTGHvFKtz+rQlb9A67orChm3hALBncz309UpEDrrPq2isMHEJLyKGn9zuG86vrXO4RtbJKckZWM/C6Bchy0z5jmsUQ6DHKOfKD9myi2yxULnfhcxlnhlt/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/mCL+7At2KmKzfpgPpJ1Asj01oOo9hLVRGItRcmUFI=;
 b=R87S4XkIhDJxohyqDYy6ojCp9hZaIB7q1x/teXPfbMj6RTtqzsGuOtZH7crIiCV4nRcOCbH+O4KivbUbm/8AZLGVin2QczZBgR7+ZVgM9OYjpDP+0SrZvr7T9BXVfdc/tswvTZLogsx66HjYNdRhqwfnBkCFtdcF4gbxZ4tg9vLj0MQwriN+Muqge6K0b8a4kqfJzPyajlzSyYyiY9nQNPdtx1S4ZzrbSBzhsneiQLStgINi4BOlrSQCXTE9CmxxUqai2MpLZX1EJaAnKLJ5Q5psYL4HQdUnEPWxvjyCBPOGVVzQprou/wlleYYD3M8ZV0VY7gBx4m1eKQBXX82BVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/mCL+7At2KmKzfpgPpJ1Asj01oOo9hLVRGItRcmUFI=;
 b=iiJ4YwHE/GGGNwvZ9F1yaAFKqDEPBXZbImOONTV/lgfPjVIUgx5vB/8lzqZq3VIKklUf2NxUtP8Spcnm4rESV8Nbv/e8tq0PVDM8+K8Xsx+cmGCk5iurcPiPJFnnh+21EMtQo45RSOUWCFIJToqr5G+OSB2LnNF3itNqrQ+HJkk=
Received: from LV8PR21MB4236.namprd21.prod.outlook.com (2603:10b6:408:263::19)
 by LV3PR21MB4190.namprd21.prod.outlook.com (2603:10b6:408:27a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.4; Wed, 29 Jan
 2025 22:22:35 +0000
Received: from LV8PR21MB4236.namprd21.prod.outlook.com
 ([fe80::4be9:20ef:887c:1a0c]) by LV8PR21MB4236.namprd21.prod.outlook.com
 ([fe80::4be9:20ef:887c:1a0c%5]) with mapi id 15.20.8422.001; Wed, 29 Jan 2025
 22:22:35 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Ajay
 Sharma <sharmaajay@microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Stephen
 Hemminger <stephen@networkplumber.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch net-next v2] hv_netvsc: Set device flags
 for properly indicating bonding in Hyper-V
Thread-Topic: [EXTERNAL] Re: [Patch net-next v2] hv_netvsc: Set device flags
 for properly indicating bonding in Hyper-V
Thread-Index: AQHbUCfZ0QtZYURs2ECCYf6zMtqJ27MtTXhA
Date: Wed, 29 Jan 2025 22:22:35 +0000
Message-ID:
 <LV8PR21MB4236726636CF9CA5E3EB6BE1CEEE2@LV8PR21MB4236.namprd21.prod.outlook.com>
References: <1734120361-26599-1-git-send-email-longli@linuxonhyperv.com>
 <20241216180300.23a54f27@kernel.org>
In-Reply-To: <20241216180300.23a54f27@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=80e8231f-b06f-4790-a25a-e70929f31f07;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-29T02:38:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR21MB4236:EE_|LV3PR21MB4190:EE_
x-ms-office365-filtering-correlation-id: d5f5d417-cfd3-4081-144d-08dd40b36ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TCgAIATPcE1hRxP3phgRtK1Dn4462QfdmngpgqbZqyIgxt/2K3ExjuHz2Z3N?=
 =?us-ascii?Q?jAVaP9HpI7NrOXmn4/FsSEaOs+CCC1xz0auZ/lVFgOzM7LCp30Yvwprdxh8R?=
 =?us-ascii?Q?elOE3toBySXZsqUntZNvZVW2g4840nRULypfYnBnROESM6JxBE6+K63DjvID?=
 =?us-ascii?Q?AaGzLmFNujKLJgUoI/P14eL2RXkqTe7uhk8+ujPSfhMRLE2O2C2dHVezIV7K?=
 =?us-ascii?Q?jgoFQyctzpqb0/OKP2UsfbTlpknG5Bf59Yq5YbZRcXjOWnW9RpqhcJx7NPGw?=
 =?us-ascii?Q?e3NE9j3uycWlkXkrgIK8SOnuoVynVroXTApfIl9XgpNxbq5c1WXEC4LOd35W?=
 =?us-ascii?Q?/uXoCuhAJXyXTHL9rYKbbci8UG9gZzQV/G1OMUrSQIztjphldEgDtpXFc2QE?=
 =?us-ascii?Q?k502J1gwW3arKpkw3KLXpWCXdFVVb0oEe2oaNoIAiaZWlZtknGVzTSo+oMw3?=
 =?us-ascii?Q?rKg4X1QlwAuwG5QQAxfssRxcYqnjLI+p9bO71frKHulEBSndxtAVX7Sbc04w?=
 =?us-ascii?Q?cGuSCItfb6OEWWQriG4UfehaYg1gqWXtQUD3MtKMPzpkulmcm6sMS2DTPetL?=
 =?us-ascii?Q?yTtQndpkgSU/0bchdYhwwnbJOCjuQ0fXb1zmd4aAqjS2/YEJ/28YfKHFSHaX?=
 =?us-ascii?Q?XQKY2B384HQ32LKP8LI0G1mkNxoBNXyvVqBScx90JV3alyQ4UDfd6V7XLVQZ?=
 =?us-ascii?Q?vfN6FBXuRUCsBdNcQ1Sq6nrYWH+OHA3fG6La/5Ugrf3dWhMLt4LGh4A2YUCN?=
 =?us-ascii?Q?bfPfizA9oV9/iDgM4t5mGAzVoNmnfJfSgl4saVAiMLXSeR6LgyR4O424wtEV?=
 =?us-ascii?Q?1eXSZLS69iXLXv+KVE7PcT1IhPMyI5XrahRoUfjhWStkEwBHF/0t4ItgEY5e?=
 =?us-ascii?Q?45C7VyDEiSE6AD6z3mxeGGZSELTrRjf2BM3hu9Q5Aq3axbAezADp2lKrQLSo?=
 =?us-ascii?Q?cGBk8Qnnpw5YwUcHsonh/fLEoStKGMTJoFqOJvs2KXbzOSg4ArQ8YHWIlXmj?=
 =?us-ascii?Q?spj0u/sY/KqG2MmKwM9BFcJCDzpYAG0xYQg+dgwLIeE/JOXd36tni/mCkcYg?=
 =?us-ascii?Q?IYF6ZepNy6/EG91pHCd3NEl1WUV60Zm46XQyEN9fVlAb9yjUn4ACtV/pprJd?=
 =?us-ascii?Q?y5KKbFshV3H1fGcmBSzPa/e0SADDi3xuKzX8E85HO47oVwlkrtrXNV43b0N6?=
 =?us-ascii?Q?UfHT6Ox5ifOPKUrUCpM++YTltWF2dVU4MYj8M4NXbFHl8HNUq7lPIr9dipiv?=
 =?us-ascii?Q?Z3829aeSukXQ+WZ4GfphDGP5/D/LSYcydiye56d2PHOdgtjwSqRwQuKG+VFP?=
 =?us-ascii?Q?/wY1sxeaCzTHeHVghz0NtguST1N1Nq1J05QP2MNTMQM5Pjb4LDD7YhRBznEd?=
 =?us-ascii?Q?qiV4BC90iaKka/RE6lUlzgBCQkgu8srj8Sbh6C5QGobomQkfCC4aIPDHETYO?=
 =?us-ascii?Q?Qm/ErDVtO99Dx/iOnJDYhxHGklcDjygm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR21MB4236.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?beR1NzQQPQyqpDKwEJK5QvQZ5xkekBcjhpvIkiG/fVnMMTiDQ4qk8Z5BDGg6?=
 =?us-ascii?Q?WBdFmGpX5Czsm6rc5S8En7+v5avG/lpDXUBJ4Ruc5u6ZozeCO6Umq5vMyunA?=
 =?us-ascii?Q?eIvirVY7Di2GtsFk7hNANibwHUyxIpG8vNf04jZ2FpIly0e2aCgooUAsmmZg?=
 =?us-ascii?Q?cD2ApliwsTUUxA5JRDD3nBJGtJCm3yRByYI/cJnJ4aaOKZsGnMMFcZZkz8Ll?=
 =?us-ascii?Q?lGFokz/IYMgQdz8lVguvxcoNwSSTXVBLDp7AnvUalI7n3CO1TyBC97XHzh0L?=
 =?us-ascii?Q?MpaxIxdOfLCrGUVz1LUhJgCFjrCAmRLeKoX+xeCiQy82aHXwWDQmozxwVvzc?=
 =?us-ascii?Q?l2cNDk8LbQKgBxBzqZP2lNWCy75pVSgRb6ik1eBTGTHR27I1SLUFXFXb3PYb?=
 =?us-ascii?Q?ysbM7CgmN3vqkKYvHmKn1KDcNACx8z5OEiKgedqt/FAzLFZGhTeZYKNUpMGK?=
 =?us-ascii?Q?q4ar++m9G7zfE/VGB+Qso7Ildl46gaVrfsGOcVuVrUoOh2lTuuPh5lEodjcH?=
 =?us-ascii?Q?RUnnVWo2IehRJupPCnweAyQG0p/CCtzkpacKglKGt10j7TeOye/oj/G5dyxM?=
 =?us-ascii?Q?gngyFMCWxz82aUho+U+6leRZt8zxY7PUCLc5nldNlM5f/ER2KBmx3WsGSnlQ?=
 =?us-ascii?Q?p+Hq4DGI3EVChQxurm5JF2dAN0IaNS2pmFbZWQY4Z77IMD0uNpr7ysli7REz?=
 =?us-ascii?Q?HYlYsGQ0pES0+NVXSnWt631nsZFy1TtkC+At2KeWvir52SPOHOmQ8AFhZlE1?=
 =?us-ascii?Q?eCzm8ntnUVO07VvQEZVvYRL2wU+IVgmBM2+Bm5EPqHEA+fCDFtpuYhs0Ovbj?=
 =?us-ascii?Q?ZF95hKOhEMU481y4FJ1TkE4EMagImLh+OJuvKM54oPCE4fMlsBXb9kKwVeUJ?=
 =?us-ascii?Q?ZjQ73ZccVx2N04LUWK3l0GXa++vLgA0gIq945iJrK7ifWdp1iaId0sKk9ly0?=
 =?us-ascii?Q?rbKNnF4RWn9dt7ZZlUt947t92XQIW5y+7oHDMY7IUS1RvO5mAaDsta+NybWt?=
 =?us-ascii?Q?umnqIS/vDGOFAZs625J6yUyRPevJzbizcFHYZUD8MZPDwjqLOafvh4Dam/6G?=
 =?us-ascii?Q?ZEGNyZzz67zzH3D6GKY9YvuyzJ0GDRrS4b2fDK5TDJkpokFMWZA8kVxJ48Jq?=
 =?us-ascii?Q?/aZ8U+HLDIfIZvB34vboYuJ5ErKKtxQnt9RJ6YBfC5CxI1LhsdABRXG+TiDe?=
 =?us-ascii?Q?tO6mimsO0RXulNc/+nWvEtOwDUG7BDjYhrLd1H5Ml3d/md/XLqZz9x2kRbwB?=
 =?us-ascii?Q?YyKfEZQpZIX0zGiA8yc4qRpcPv1jQGbDGVxpUANWaumZAAuUjRvnVay8f9Nm?=
 =?us-ascii?Q?LF049jUTTWyr3KHaEWoYxTkyGPYSirEYpsKmOyPq4/XzYhw8T2JP30MU1eSa?=
 =?us-ascii?Q?WoPQHBpzXyQgbQxbeNVG1qNKOD8zChdO/aig9G0XPKRn0WWUI+SWJGy0nMDq?=
 =?us-ascii?Q?lYOpCCXZSjeOzlGl7xMuNfIXGa7CiNImAwl2tGfGtNYVUT2ya5SXe/3ZYVVb?=
 =?us-ascii?Q?+OduyaqgP9UO4cS42byULS75NtRYTZILOogRfqfTw8ztyrk2lYnYzc0QkLST?=
 =?us-ascii?Q?0Vf8hrtRtbjmLA4OUjvTNyZrbB3PjwzXkDUURG9mz9RdO7esebahFUnoBAak?=
 =?us-ascii?Q?xymMvD8m5iSqU9ZiZrkZYt79JZteB3qSyHxK2HuzM7zh?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR21MB4236.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f5d417-cfd3-4081-144d-08dd40b36ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 22:22:35.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EYh0m/Rm2NQu6XYNvm53/eefxlnQRHnXVRTWcT3qSe1cyvVUbC937NF53MrrIP9JUrQG4litFJI6c8RWKivhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR21MB4190

> Subject: [EXTERNAL] Re: [Patch net-next v2] hv_netvsc: Set device flags f=
or
> properly indicating bonding in Hyper-V
>=20
> On Fri, 13 Dec 2024 12:06:01 -0800 longli@linuxonhyperv.com wrote:
> > Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> > IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> > in a master/slave bonded setup. RDMA uses those APIs extensively when
> > looking for master/slave devices. Netvsc's bonding setup with its
> > slave device falls into this category.
> >
> > Make hv_netvsc properly indicate bonding with its slave and change the
> > API to reflect this bonding setup.
>=20
> This is severely lacking in terms of safety analysis.

I'm sorry for the late reply.=20

The usage of netif_is_bond_slave() and netif_is_bond_master() are mostly in=
 device drivers that checks for bonding as configured from user-mode. The c=
heck is consistent with the netvsc bonding (bonding is done in kernel mode =
without any user-mode configuration). I don't see any security risk if netv=
sc is bonded and becomes a master device to the bonded slave device. Any th=
ose checks will return the same value as if the bonding is done from the us=
er-mode.=20

There are two places other than individual device driver that check for bon=
ded slave/master.
1. ./net/tls/tls_device.c and ./net/tls/tls_device_fallback.c: it checks fo=
r sending packets over a netdev for an SKB if that netdev is within the con=
text of TLS or the netdev is a bonded master. If netvsc uses this bonding f=
lag, the check will pass for netvsc netdev as if it is the bonded master. T=
his has the same effect of user-configured bonding devices. Please see poss=
ible security implications below.

2. drivers/infiniband/core/roce_gid_mgmt.c:: it checks of net device for ca=
ching their addresses for RoCE gid lookup. The code check for master/slave =
bonded devices and determined which of their addresses should be used in th=
e GID cache. If netvsc uses this bonding flag, it will be consistent with a=
ll the checks on identifying the correct addresses (master's, not slave's) =
for GIDs. This has the same effect of bonding configuration from user-mode.

One possible security problem is that the user-mode can assign different pe=
rmissions to different netdev (and expose to containers) and that the slave=
 device and netvsc may have different permissions. I want to point out this=
 is an invalid configuration when a slave device doesn't have the same perm=
ission of its parent netvsc. Because the slave device along can't function =
in the hyper-v environment when netvsc is present. It must bond to the netv=
sc for any outgoing/incoming packets to work. If a user wants to configure =
different permissions, it must assume the kernel will always bond netvsc wi=
th the slave device and they must use the same permissions (and for assigni=
ng to containers).

>=20
> > @@ -2204,6 +2204,10 @@ static int netvsc_vf_join(struct net_device
> *vf_netdev,
> >  		goto rx_handler_failed;
> >  	}
> >
> > +	vf_netdev->permanent_bond =3D 1;
> > +	ndev->permanent_bond =3D 1;
> > +	ndev->flags |=3D IFF_MASTER;
>=20
> > @@ -2484,7 +2488,15 @@ static int netvsc_unregister_vf(struct
> > net_device *vf_netdev)
> >
> >  	reinit_completion(&net_device_ctx->vf_add);
> >  	netdev_rx_handler_unregister(vf_netdev);
> > +
> > +	/* Unlink the slave device and clear flag */
> > +	vf_netdev->permanent_bond =3D 0;
> > +	ndev->permanent_bond =3D 0;
>=20
> > + *	@permanent_bond: device is permanently bonded to another device
>=20
> I think we have been taught a definition of the word "permanent"

Is it okay that it uses "kernel_bond" here? The reason is that netvsc is do=
ing unconditional bonding without any user configuration.

IMHO, using IFF_BONDING is the least disruptive way to express this relatio=
nship without adding new flags, given the behavior of netvsc bonding is ide=
ntical to that of the bonding driver, but without any configuration from us=
er-mode.

Thanks,
Long

