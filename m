Return-Path: <linux-hyperv+bounces-9290-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIkgHw9rsGmNjAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9290-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 20:03:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A6256CF3
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECDA1308889D
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54203CC9F3;
	Tue, 10 Mar 2026 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QykTzaZ3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022116.outbound.protection.outlook.com [52.101.43.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D2175A7C;
	Tue, 10 Mar 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169399; cv=fail; b=RWTbc9+3+WXyWZn5PEqqnPfg07tt3yQnTX9Rx4saHeicmk3J2/X8HYRBW2O1PCVc1TBahjXsu2lCOZLIwekQRkhIMqUUqhhHtgOBIkNFgtwXZa25JGB0WFHNYw3H4LZ+9tFuoMf2XIA87XmTeH8KRy7QR2pWAqUTMK/K/LScq5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169399; c=relaxed/simple;
	bh=vNrnb3DuFVd9CNPWTV7dUTagJRprQ5xdCwm89V5ykOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qtfjMwLJk/aIYwGwC64IJlEZEl63YLEoGMwqFk+An3DSPrMX8njdadsOStd/CXxdhsLjbNHwONb31AiQdPgshdl4N3aJW0N4Fvr6M1B2U+ehyOAAuvfCByXAY7fLKUUbObXPmn8p8vhu0cppgstouldkfiJp1SP6XFO8q/3ugcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QykTzaZ3; arc=fail smtp.client-ip=52.101.43.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0pNFrKM02pZrv0OHOQCrgTxqhAExs0A68YCCWD0IjyOgsy8Vg4ETkYBMl3oroeNNcA7DpJL34bakniAdl785AKMksh3jHvGIzV9+oA85wN0ZKvc/UHo8ys7rMmVMcOmJFnMK3lr+uBJ7cRaCYCyoeOjCeZICnIs7v8zNU592G2DO0AoltYJY89eQDZkaNFPCug3Fv7Q8fGijA/1Qqxws8bV1BhJQV8gTy0j9E2UwTz1f6EUsnURLCVQUJIN0FlBztC2ZQWKDU+ClC63EqQJOJYLKKj9MGXRKGdBS4i4T/iZYBksAflbdj84FIucDBIdr39zjJYe7ND2PaR9wBQcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMNLXOlrNm5OG6I2u2/c+tv9vJAABSZW1WL7GcBJVno=;
 b=aw3/OlWyNTaoZX5z3aSR3fm+ACI9N/SfV3vlytd48x4otYA2AVLreg1eWdpQncmluL1zkC7y6pUgpjMZ2bcDCu57PjiZX14XrNKm86gzCTvEsCf2ejmo0kInZYCUELduEs8k1qV75JMxjbBlwxOVt6PrRFEzCL8v+68XpWl6Joz2O2OTZCyXEfRrT9C2Y9nm+w2LmQ2KcYs08UDqueKFo8jerbNpJD9hCmHjZvqzbzbasyad3PX7hkEixAsXIiomaGsU7oB4MNhSfepXpcAcTSfCYzFcP85BCGgreR2G0NxKz98XyyVnancSpfawZPcGOULXUfoEc9/jlHb4GuP3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMNLXOlrNm5OG6I2u2/c+tv9vJAABSZW1WL7GcBJVno=;
 b=QykTzaZ39jTZOjDcdBBROBbFSa8ReQtyzOPuOG6BIvuPmmFwTcSXxvhWOQziccIU10WhV7oUC1zJm9Pyhlg3zt1Hx0pE/6yM9iRi+Vt3uOBACTEC9giMzoMPf24Y90l7WVDYnB4hhlg/lQhjakRP+skjUDgc+LH0dWSKdvywdeM=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6634.namprd21.prod.outlook.com (2603:10b6:806:4a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Tue, 10 Mar
 2026 19:03:15 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.000; Tue, 10 Mar 2026
 19:03:17 +0000
From: Long Li <longli@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "erick.archer@outlook.com"
	<erick.archer@outlook.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next,v3,4/6] net: mana: Use GIC functions to
 allocate global EQs
Thread-Topic: [EXTERNAL] Re: [net-next,v3,4/6] net: mana: Use GIC functions to
 allocate global EQs
Thread-Index: AQHcsJpdtsf42A2UPEW1zRReJvQ4+rWoH1lQ
Date: Tue, 10 Mar 2026 19:03:17 +0000
Message-ID:
 <SA1PR21MB66835CF1438075CCC68F9E4ACE46A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260306213302.544681-5-longli@microsoft.com>
 <20260310142931.237121-1-pabeni@redhat.com>
In-Reply-To: <20260310142931.237121-1-pabeni@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de43678c-cca3-42f3-a972-06318a0428c7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-10T19:01:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6634:EE_
x-ms-office365-filtering-correlation-id: 6247d9e7-f623-4473-a2a0-08de7ed7b0a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 6vrBWyg0JqqOy+crD0leBVqDKe2SApKsLRRwFHyuxZUPVBdkTpK1E5OejgUP4fzvSUFkcp7BusreFu3RLMO1skTnxqeWkJr9NbmgapR3wGOL6ZJp4XDsvSXTGL0H8940RciXVBZUZ19wiKAqmD/uTGCbADDrGPzmvTN6yBCWGtDJ6yMwjF8O3+IPlolBMiR7whOJQBmdfDLzz48fR8P/mcenEFxRBKFDqUSW/CWhCbKoHo/X1UNS9Nc0JFdPcgYt5s9Ze6cUhDJlvzbz5DnSJPHcyllHroaSiyQnGMhdDKlW2QmQq/bwOwfIqsz0Dl/APFOXz50mOA8OG9PgdSdXVENHlaFTQh05UUC1rXh0AulJpIFAhh/A8dLmR5PYdg2U+vsEAgbwLogFCFNph8u08Sgc13zw/0y6J2WPufGozcnJdphtU4HyibZJBKeYVw/NrxKqtmVEU49gOKdbVD68bfsXkRaBwodMRT1I2PppWv9GVx7LmZ5/t2diA2MPMHnn4d/Qhf0s1hgfmQpccJGHOZGjEp1MJewz4yi493CafMCdlRXu0MoF3BhuPJJwK6JURJCD7qZDCniTAffNZ28nMu/RB9XuInJ2bfOIPJNvub6C6fK5976UNnl3ekJf5I4HkZDICv9GFO7Umy7+/F0yU3IW3o78eOtfuvW76XoBWFcs4UkIqip3JOyyvznXTsT4p1XnXtXk5tutsvXIEvGOMZFKU6OUBXXi54No4M3YlNfVsX83kyLw83Px05Hag6gwQpZyHga0ezOFa3CZFtzNOMbGAEhIwyRIxOeHaaNUmds=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9u+uNAgFcvL6xTsNKOqMzIs8uODTIr1qHtkf8B4OP+9buQZVKbCpsCKo7GJL?=
 =?us-ascii?Q?lk0o0TqiNvc5toNnqTKu0cCux+w/+2QBHayO44oCnJXlyS5vgf99kCzODuC7?=
 =?us-ascii?Q?kqSP0yqUFn6SPB8cdAyEfBG/A7eFknWj/f/tMeYzULZWWwe37JNkgEP+wMLK?=
 =?us-ascii?Q?xk2jU+Ci+hBlxl0nNIo16/JgKR/T1QKfyCfdoPCk3ErvABx1wuOeLXcejzAD?=
 =?us-ascii?Q?XT/Wl8oCBugpz6cc1jMtkXNC0mnoLbpFPx9JmAM0AIAmC+HAKKcCLvM9fZes?=
 =?us-ascii?Q?jnXb4s+Cbzk0llzuhVNwPkgkr3zqAFff8b0b0EhHHpHx1ce+S7u0CH2tajXJ?=
 =?us-ascii?Q?GKRyVw4N3zAqBE20JmP9XuYpFo3Ym6cJnGkkiy/Y0qzvS06/Rkt04wD7XZgI?=
 =?us-ascii?Q?OQMI9WkjRjeJrwoct0luohl21FLDndK7reRVo2ahprZeKEFxVLwGxkC7phnf?=
 =?us-ascii?Q?d5IaaJgStC+ciDSQrDUQV2sQ6bX46N2n1m4Ud1LJl76VTOt0ILezwO6gj9GX?=
 =?us-ascii?Q?6vURmXvAh/Ki5GvdZgBDy9gLUuSIXzRoCUJ9xPjXQNPxExtVpT+v6wYgZKhQ?=
 =?us-ascii?Q?AY2VBPgRMCACwf+aWj4phCOAtecU7c1MIRlAve6AsHX/urXs+nmYAv9UBoHF?=
 =?us-ascii?Q?16T4GASCQF9/pTrFP4y5EIa7mKOwol6hawqbbjk0/79A/kPgOqqC3SXCD4z0?=
 =?us-ascii?Q?I5y7B+me1WUnZ5xMebGqILdyhUxkeFYq8FlY/xVvL9uVeozePAUGPM6QNRKC?=
 =?us-ascii?Q?b0S4ojzke7+6uyQQiIMamX+KRMtYG2fkrXe7GPE4CXQJPUNLLgV9me8rgZDa?=
 =?us-ascii?Q?UNEQn+9R1snHNcSonlqrEEee5+x8fJ5bQbNN8o9j0Eprm/fF5HG3fbtbmUHx?=
 =?us-ascii?Q?qUFPVr2YoBB5b2atjVqmcDouGFFFoy+6zk2ptKswF9A9AnLREMhy0tvinMr2?=
 =?us-ascii?Q?U+imXhxeuZ4ywX54Ob5KcIWE4nD2Z0RgFLsXv8UrjFTD54lFJqnvoNvkfJ5H?=
 =?us-ascii?Q?QjrMJd5g025J94NEjPVwVBKxuzYWuQlUdM1tqLIsNUIjjPga2+3pnpWieNQF?=
 =?us-ascii?Q?PGLhvn5mKHlp7a7qkNvVxb3905fNy8DFzpict5NI+O60zfxrQJ4enIeKWnXQ?=
 =?us-ascii?Q?0Q1E6EeS584vkkRWKoC9Z2IVLCI73ztMT/I5ZmDYI6sw+mU9eYVD6r3iP3RD?=
 =?us-ascii?Q?MOhQQYWwvuZXaz3/FwV/qSZ1XkgYPrE/BMDnlrxWBwQ7bV5yXUk/iSHNaede?=
 =?us-ascii?Q?rn4HZAKqyXVWNbCh+IED+O72i+Gsc5ckn7e1Gd09iSmA6KaPjNkfaYbXWcpK?=
 =?us-ascii?Q?InRkvkeJB0Vre2ZzkD7GlwmzSLEdOdSUTPdh4jW5S1LGaK39LU6gH50p1FyX?=
 =?us-ascii?Q?FMf08JGfiCbXj34RLx+7s5HiELzL/tUtkIRSalRKaK5VRR/Mz+C5jSzIUnrR?=
 =?us-ascii?Q?6+jmNJC6aj6FvykbfOt7E393ZxJT6yso92SgzVMY3ShihTWfgyyEbSyXvCaJ?=
 =?us-ascii?Q?cp82KO04KmWfwpithDe9CrPOYZqKraLjRtb4/bnRm0T61G7FSbZH6x3sCRFG?=
 =?us-ascii?Q?8Hk4DO0uHdFW/x8tAgDKmxBKngI21E4R5KV1Phh82QEwenbZpCZmevudVEY8?=
 =?us-ascii?Q?wMoqStK5mr7qukQEdL3uzKQ+Sb12e81BTOnQ3GOBBBAa80A7elzPHoEwpokg?=
 =?us-ascii?Q?A9x9rfv+gYrIjTpHxArInwefaFt+2loVDyV1bHoLonZF8iCw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6247d9e7-f623-4473-a2a0-08de7ed7b0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 19:03:17.9088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QHSL7wFPVBIA9CBELdfhbERKmWCnCwHIdAdFuoRwFp/E4lXC0LR27x4Ubr3hzM1X8VHaO+Mpo5a13KEaCag6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6634
X-Rspamd-Queue-Id: F06A6256CF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,outlook.com,kernel.org,vger.kernel.org,linux.microsoft.com,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-9290-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:url]
X-Rspamd-Action: no action

> Subject: [EXTERNAL] Re: [net-next,v3,4/6] net: mana: Use GIC functions to
> allocate global EQs
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fnetde=
v-
> ai.bots.linux.dev%2Fai-
> local.html&data=3D05%7C02%7Clongli%40microsoft.com%7Cb43e1b10bd564c760
> a4d08de7eb17c82%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6390
> 87497958656662%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWU
> sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%
> 7C0%7C%7C%7C&sdata=3Dr63AcJ7Cd3APZSSpl4SPBcGxSdosinxkIurfTp9yZmc%3D&
> reserved=3D0
> ---
> net: mana: Use GIC functions to allocate global EQs
>=20
> Replace the GDMA global interrupt setup code with the new GIC allocation =
and
> release functions for managing interrupt contexts.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index c43fd8089e77..bdc9dc437fb7 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>=20
> [ ... ]
>=20
> > @@ -2052,26 +1998,17 @@ static int mana_gd_setup_remaining_irqs(struct
> > pci_dev *pdev)  static void mana_gd_remove_irqs(struct pci_dev *pdev)
> > {
> >  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> > -	struct gdma_irq_context *gic;
> >  	int irq, i;
> >
> >  	if (gc->max_num_msix < 1)
> >  		return;
> >
> > -	for (i =3D 0; i < gc->max_num_msix; i++) {
> > -		irq =3D pci_irq_vector(pdev, i);
> > -		if (irq < 0)
> > -			continue;
> > -
> > -		gic =3D xa_load(&gc->irq_contexts, i);
> > -		if (WARN_ON(!gic))
> > -			continue;
> > -
> > +	for (i =3D 0; i < (gc->msi_sharing ? gc->max_num_msix : 1); i++) {
>                                                                ^^^ Does t=
his loop condition leak GIC
> references when msi_sharing is false?
>=20
> When msi_sharing is false, the loop only releases the GIC at index 0.
> However, mana_gd_setup_dyn_irqs allocates GICs at indices 1 through nvec:
>=20
> drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_setup_dyn_irqs()
> {
>     for (i =3D 1; i <=3D nvec; i++) {
>         gic =3D mana_gd_get_gic(gc, false, &i);
>         ...
>     }
> }
>=20
> Each mana_gd_get_gic call initializes the GIC with refcount=3D1. These GI=
Cs at
> indices 1..nvec are never released because mana_gd_remove_irqs only proce=
sses
> index 0 when msi_sharing is false.
>=20
> The old code iterated over all gc->max_num_msix entries unconditionally:
>=20
>     for (i =3D 0; i < gc->max_num_msix; i++) {
>         ...
>         gic =3D xa_load(&gc->irq_contexts, i);
>         ...
>         free_irq(irq, gic);
>         xa_erase(&gc->irq_contexts, i);
>         kfree(gic);
>     }
>=20
> This ensured every allocated GIC was freed. The new code with the conditi=
onal
> loop breaks this, resulting in:
>=20
> 1. Leaked IRQ handlers - request_irq without matching free_irq for indice=
s
>    1..nvec
> 2. Leaked gdma_irq_context memory - the GIC structures are never freed 3.
> Leaked xarray entries - the entries remain in gc->irq_contexts
>=20
> Additionally, pci_free_irq_vectors is called immediately after the loop, =
which
> attempts to tear down MSI-X vectors while IRQ handlers at indices 1..nvec=
 are
> still registered. Can this trigger warnings or use-after-free if an inter=
rupt fires
> during teardown?
>=20
> The next commit in the series (4475f13983ab "net: mana: Allocate interrup=
t
> context for each EQ when creating vPort") adds per-EQ get/put of GICs, bu=
t the
> EQ teardown only drops the EQ's reference (refcount goes from 2 to 1). Th=
e base
> reference from mana_gd_setup_dyn_irqs remains unreleased.

Thank you, I'm sending v4 to fix this.

Long


