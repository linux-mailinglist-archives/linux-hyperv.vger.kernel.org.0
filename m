Return-Path: <linux-hyperv+bounces-11315-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLaPAwW9GGoumwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11315-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 00:09:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320F5FAC91
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 880AA300F139
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D3348C7C;
	Thu, 28 May 2026 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CWd2IM9B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022141.outbound.protection.outlook.com [40.107.209.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674923394D;
	Thu, 28 May 2026 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005963; cv=fail; b=PQACH5wKhUDrg04zw/wqUn0Xyoyz2KswOIoNnZ5moaEQ3+5+PmdE30qEy5ajbqDedpI0Yr/V0Rb8KmQ+LK35ZZL3gTmgvWz7Fjbsa94qTXw4jUWW/YWspY+HZ/wKgxL0mqo1j14FCrIcyH6fRvbmpJA9uk5eIt3/uOnGUar4egk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005963; c=relaxed/simple;
	bh=/J3csQj/H4+Dm/q6bHl9AIWV/CC2KxLJH/pDqH9jSoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+PBPBb7XwXWdjtmcW3FGbqUFIITP+E9nXrpfz/vIIppeLERAcyqxWw7xoSL7aGrlbFt8VQsJbsu8x9yPNWJriiMQkJKer0EbZdyQbquO5gSCg/03gDqMTQfVFf43MdJIAb7NBn8XNMrknIvv0SV1rn1FU9SAsBHRviL8bEP0J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CWd2IM9B; arc=fail smtp.client-ip=40.107.209.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufzaHf24XX+su7F2wMeuamRqED4W4lkTwAaxLWBA9CI6z6S8hqj9UYhiqTwsVu2oM1jFvztRGP7NjJjGPi8rnK9O3G1tqXIiXD94+qQbwir9nOVdF2ec7zfdchUIoUfPu6IxwPu9+vqskyI//ghZuYTOkgh4kN2/IGkmjc7yAsedqzTsMVxuw9nicFiX/nvG1f5gzgkSvV1gSaGKZ8WaKa5qdDCldci1Gw9JGSXHMK6ilWBsi4V6XtoUCceyUQ1q6y6ACTTKi9pmOkDMxdTQZ9XJvuBI269IO+B+2drlfHuGBoNJWkyoKJrgd29z9x3KPVp6/CDETvW8GRcUWEZWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pcj9i5DkQEAdOoNabaHXnYZO6NUxHwdW3REQx9Kc1ys=;
 b=DNBU2DGQelS5lgOadQ6Pzeubx8FK1GnK6/Z870gzf0AD5lp78hWbyb+yNzBsmdekQtp1+l6sCxbAB6qRg1auiCFEG/DhE1NcVCq5MmespEIxfO8/fT0OiWiHnCqCua62NjW9NWEZmdj8VhII9wGV5vPish8riv3i9G/xAn+lRxzeOkItoefFYJ5tWcSxR3ERO/iuLY8c+Dad29O7N++2HG+o4I65PyeQZglTC+BxAAebuiQo7x3HmjaxvEgWF+cYG1yQ8Ca0pG2Y+KM8hYQdby1NcY/7jLEgXczzjiSPOl1TydLPkhcsjtW5VfbGajVo/mqqEzSIyDND1uEyiWzbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pcj9i5DkQEAdOoNabaHXnYZO6NUxHwdW3REQx9Kc1ys=;
 b=CWd2IM9B/klGL0t3vseU9iu3Oq1XsTU2Ou2aTlmAQYxwIfDE3LBPFJdJV3m6O8kGwE0RDCZMFtaQDHEoQx69MAXp+b2qLc2bBVd+NBK4ou34q/JyqbxTbHc8/QupKiikXIyGO4wff7JLwQCeWr0tULhFjf2M6LXtMY3j1Mfrdgs=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6704.namprd21.prod.outlook.com (2603:10b6:806:4a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.1; Thu, 28 May 2026
 22:05:58 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0092.002; Thu, 28 May 2026
 22:05:58 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ
 and MSI-X management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ
 and MSI-X management
Thread-Index: AQHc6lhTyIkZh41VFEGbRGEZk/VnV7YivmWAgAFG0OA=
Date: Thu, 28 May 2026 22:05:58 +0000
Message-ID:
 <SA1PR21MB6683A7B2415BEAF17BD0EB4ECE092@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260523020258.1107742-1-longli@microsoft.com>
 <20260527192735.34a794cf@kernel.org>
In-Reply-To: <20260527192735.34a794cf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b6f8d270-dfd8-4186-906b-7ff7b9b59e84;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-28T21:57:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6704:EE_
x-ms-office365-filtering-correlation-id: 1e760b02-ca8c-4cb5-3bbf-08debd054c50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|4143699003|56012099006|11063799006|4133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 a439EvpCXJN8dBlaHZiuGW1cri5AkqG7Ca5+rth6mWi4XV4HeMAhEU0QNye40M5OB45k7Q8OVELYuoCOaaHTsZm4QkPuH8eXkn67YP8AzR/zgL3aJ0JoXBL5OoClEKFbUpTp3f+bIf9oUXvodgjdSG6PjRM3aIGKTlUx77SEudPxiB54dptJ11pVwFspviLx01KUKTz/rDwJZXQYevsfqa76cEPm+DJf4a4FqE26r+Y9Cis2oim45FrE1sIpKeEVyui+74MXw2hZB8gFAVXVvNK0awMaI1Pr7CdZWi4ZRUCjpMuVwkuK6G/91kN1GjaszY0c6+qvQtLP9BrVkTtGNNIL7Iun9RujMghyGoycALd3Y8cZ3WrQ6fd0CjS5JSReFx2grvxAqWm6h04OhZ4F19ZndI7yd5TH+Blu8dx1O8MWX8WEI8x3DZsYon3ryWdAydcEcDGXO8ETLaUWPKoCmc5FWHrhN6Y92OsQFLVhIRa6/pv5znWjqwFIJxlDmg91lt0Np+6u8dXvzH5ZjfK1yzJxGyGx+bQqax0R9UYKchbwEet9+uHZWMGg7l0zPaPVK54Y7ghVPO4F+WTMKqGxelnVLFLKYkZEmc1A/Zyoseeujq8GcKMDa0B47TlXvf5XHN/IY+KQbZbuTszDKcTRavkmfM/TWnmRwUqK8jy+I2Cngtyr04RBZtyil/fOAdXQJIL0B2O66F3gmw8OPtrroQWHKJwbdWU1yBGKsHxhN6r8FrAv27pKKIvIWi/euaYL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(4133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1oMhXwPc/Fm3aDSCr6fBF0q8cojNhBKLoPN/HIkOkUrVNaX4p0x9gP+PhwFv?=
 =?us-ascii?Q?vsgEzNSDrhAvC2XBzphVFETpQEHVnR8S06X4Qk6XV/XxCLknA9kGa2qH8MJN?=
 =?us-ascii?Q?4RSfW8vI84teS58vrPEZfLQep/PxiO1/U8YXKu9LLDX1z9poWzdF5UgoJkSb?=
 =?us-ascii?Q?iv7GMG2C6vUuARjzdZSryrSgBvXsU40XOlmQB4Vvz7ZhFtqGmSrK8fuEESps?=
 =?us-ascii?Q?9o5r3XokyojUwq6hcMggjT8dC6HEKr6L47urNfbPPAL44sNI6tnjoRE3DrNY?=
 =?us-ascii?Q?xUl/4VR3QJ1VRkeeAxAE8sCufkBGwZ8yDjO5FnDN3MbbCFyWTEFR3t7GN2fh?=
 =?us-ascii?Q?wXZ2WLBcT44uhU9TvB83shm1veyW94jdOnulLENrkfclhsiGIHpQ97EpFYNI?=
 =?us-ascii?Q?X1eHoOF9JzQF5PyyMwThvYpPB1BWL7oYKArDxxzFs+ObmI4g6iOD5+53Z5Ap?=
 =?us-ascii?Q?JyuW3gOGF/aK6bGqBYl90oHohbWOESd3M0Xv6R/VjCmLW9mAkDDKeaOlKu/V?=
 =?us-ascii?Q?v6RfP6jLyOvXNZRTXXJmGEsciLpNuRJoZK6EstKD7p0LPCUzqO4SD6mUPK6u?=
 =?us-ascii?Q?z0uixyTBmFdzhHTr1JW+1bZpRBJ77kSpUW4i0kB3I4nChdefsHKt6n2obApK?=
 =?us-ascii?Q?CCBgsVDXxFXTlb8KmaG+D00HFG+62ObnZkU+mAEG51m22cyzCxCaSVohcX8G?=
 =?us-ascii?Q?5JZFc13J3rQGPFhAJa9pFXqgn2Zjj/gNGPEdfwysv1Ru0fpydR+k0oGkIRqB?=
 =?us-ascii?Q?mgdkAxCaOPukEMvmUcRsr0h9M3vyq3vKoT14FFdwhB50ymFyB0U7Z3bZynmz?=
 =?us-ascii?Q?vMePCTmHfv35dit8zs3FvM+BDpKnLeh0cYku4w0BMihvKM2PsdH/tGbX/1Sm?=
 =?us-ascii?Q?T9wHdUMqd4QiIsypK2JGeHWOdu+UgN/cY9nFVgwCif0XaQ+6TONCq0ce6/0a?=
 =?us-ascii?Q?6evptsopV9MClz54g+k/tTjPHj6VjYed3mcrR3op7Sy0aa55AUxKKdkF1lE0?=
 =?us-ascii?Q?xqlPsA9Nie0DcAUyg2BMjQiZCiqbC2xtvfgvWP9i/2vypzd3p4MNbvFmNca0?=
 =?us-ascii?Q?/CTceQsVNSsnQORbzeF22OcZNgRT2mdsL1unwIqL6yK/XSGH7CoSwtm1e8M8?=
 =?us-ascii?Q?gnEtHWreZb9DgyUzJiH0HoMmJulI3q1IIrNfDKOGYqZpKx058j++9JjfDzGe?=
 =?us-ascii?Q?gLMeGlhHw8IdYrBRSGohxMrUOjyQupLgAj9qoS4sIomjMsi2dgsd7G9z5xSE?=
 =?us-ascii?Q?PR5t3SYZykPC/Jh77gb8cyN4A/jwUHwMycvUy4KNw7Pm9CtiQk0Tw7bDXGTb?=
 =?us-ascii?Q?9yLZEbhR0VbOIXmccPW2bEbNbBxnoTJH0gG2OQn3m8z2VU/RxRr2HPcVi8Aj?=
 =?us-ascii?Q?sSMVtvlWMzZsWPjGTrsFRxBkQpt+PE2Mp4QVmMB7iZeDDPx0huPTDTxOFs4y?=
 =?us-ascii?Q?vRXUQOp5tO4Qi4vWKB52D9XRgxTk1/spNm9gpSsx5LsPCBmMHC6cVPIlWn0K?=
 =?us-ascii?Q?83BPpPYzZgcEWqKbJqZll4jr3cgDRfcTT3aGBySFdrxZO0UReWLN3xEz/9+s?=
 =?us-ascii?Q?du4uCJd43ReabmGLFUNei3oSSY1j9csg+0YYCsw96lBp6SVKn/BVOV2Z7Wlz?=
 =?us-ascii?Q?RmHzGSMUHCV7DVjxCHMHP/yaXHS7Xa0sfW+NIkBF7ak83eYLJBlLrXwtoYdd?=
 =?us-ascii?Q?VmOcQ3KuHFLR3Yfd745SrQ4P/XJnrwimjF/F/X7uBo9q5biR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e760b02-ca8c-4cb5-3bbf-08debd054c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 22:05:58.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHJ6aO+6uONiEVB/GQoHGpV6rYrL4ZpcsfbKdcqvAhqtgWwi2DXX+5GwapkeNKub4nIXVA+Cayn6OTq2DolmIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6704
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11315-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:url,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 6320F5FAC91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, 22 May 2026 19:02:50 -0700 Long Li wrote:
> > The following changes since commit
> 95fab46aea57d6d7b76b319341acbefe8a9293c8:
> >
> >   Merge branch
> > 'net-convert-atm-xdp-af_iucv-l2tp_ppp-rxrpc-tipc-to-getsockopt_iter'
> > (2026-05-22 11:11:12 -0700)
> >
> > are available in the Git repository at:
> >
> >
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> >
> ub.com%2Flonglimsft%2Flinux.git&data=3D05%7C02%7Clongli%40microsoft.co
> m%
> >
> 7C36237239bb6949843c7508debc60af6c%7C72f988bf86f141af91ab2d7c
> d011db47%
> >
> 7C1%7C0%7C639155320616840917%7CUnknown%7CTWFpbGZsb3d8eyJF
> bXB0eU1hcGkiO
> >
> nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> fQ%
> >
> 3D%3D%7C0%7C%7C%7C&sdata=3D43aUwSeHYaOhd%2Bmd1lwfmCqmrAObg
> MWJoDRpKDhmCt8
> > %3D&reserved=3D0 tags/mana-eq-msi-v11
> >
> > for you to fetch changes up to
> a26d11135abba51e81ae8b9689e288718af95088:
> >
> >   RDMA/mana_ib: Allocate interrupt contexts on EQs (2026-05-22
> > 20:35:43 +0000)
>=20
> The branch is no good, it needs to be your patches applied on top of a co=
mmit
> already in Linus's tree. The current branch is on top of net-next, RDMA w=
ould
> have to pull in 100s of networking commits together with your changes.

Hi Jakub,

Thanks for looking into this. Since the RDMA patch (patch 6) depends on the=
 networking changes in patches 1-5, could this series go through net-next? =
I've verified that the tag pulls cleanly into the latest net-next.

Leon, Jason - could you provide an Acked-by for patch 6 ("RDMA/mana_ib: All=
ocate interrupt contexts on EQs") so it can be taken through the networking=
 tree?

Thanks,
Long

