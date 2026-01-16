Return-Path: <linux-hyperv+bounces-8334-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F20EAD3392C
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 17:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496203010FE5
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEF3933E7;
	Fri, 16 Jan 2026 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QK/A3gEE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021114.outbound.protection.outlook.com [40.93.194.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECB33BBAA;
	Fri, 16 Jan 2026 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581878; cv=fail; b=jxwLlLvni32S8KOg4mwUDjTOUIwu10v7GNSbfhwfQEBRODeNxa6TzBhYaZ+gzbPreehg3UtpmVmOBTjF7DMjFKUfT2R7wvGLf6PRxh8RQ//MtP1SU6wyDh09xugAXK0hkwnm1UfUsMTLFKPFSg8abEqFzskpt251n1IxoWtfX4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581878; c=relaxed/simple;
	bh=AsUhWbouZZG/Ypeah20Nbxb8Na1idiZt9hZ9uNgIHW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDSqNCVMnxzgzqteW4KCItrFglVjbdvsMOcJIqDT4TufCADv1mmKiSRsC0C9WnVFqaqv85CQIS7NzpN1dxF1UIWvq8UUHLTphp+8k1iw+MbwIocvbl/X9/lzUE9RaZ4zAoPGNuf3n1VCxiI3dDBMU2xVGTUOO/cdLwLV0SoqbZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QK/A3gEE; arc=fail smtp.client-ip=40.93.194.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yaeazrqfp8Bo6VCdKQVdsB3KLtJ5b9pINdbVyBWqTTCssd8/oJ6g0omOt3dEgOPs4ypcH1Yg2H8w50Kgczy85YXQbAoLFlR2sHIl8Ds0OJPG08B82bd6UiVmSD71z1VcdHuXKInHKj/WAWGoaV+n/uXhTWnwi36HsQh48xhkflh+1FlLBoZpbD1CLUHKDFFz2/clHf4BpEKXMJ/D1+av/5hH1KZHYY25Zk4cDo7tD8ZukIdiGdo/C/jIn9wQ/zM36TmHqc+2/dXPUGVNCdXefrmEG7CUlCWI9l646HyI/W08nPbPUUCAUVR4F1BERCQtuycjJ9ChD5G8WXEOu7qMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHYLJUHoGyBzZ5iOgZ5nVXqLpfKzt7b1QuLLjnMJ27Y=;
 b=T52LGKhYsMevtbn4fyejBzBIftPnz4m8lGHjUDvrIzxM34dTbABkFsUIOgDGGcyE/rs61uEjwF2/XsvgfGtE/STgLEny0lnrC8OvFYiVBAMyDDpY+AFpZzfBnG5YlxsfPv3YfdxnGZ7hajrQgS+hzIzrK5AVxuov7EzvLLNXy8EgtR1r4VUr0cZ7AdwJmmsgp9+zKJLbgCDiKiduBJi5d23jiEnsHfCn8LZbeHcP9m8a7xFIq1TH/DGNWMQSaC5c/t1w8q5nlyChl3CNNXvPAwmI9JCj1LqmPat/fNVGUAIywKX05ycVW+czlm2SG7ldBVjKimkJAujj/2pFTk0Kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHYLJUHoGyBzZ5iOgZ5nVXqLpfKzt7b1QuLLjnMJ27Y=;
 b=QK/A3gEEMWxsKgJSQ7ocpqpKCrSquANUBOeBOQ0Xy7JfFFNutwS8LBuaZXBydcHsFiwybKiYA8wuKIxbiFE9NMc1pKsy4cp04Bzus1Kr7YMImmLDNRsKmLuNBsu3+3/QTJSatx/vzrsenCeURwfxfU+wVc+FPL+j4DU530OsjCk=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6225.namprd21.prod.outlook.com (2603:10b6:806:4a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.3; Fri, 16 Jan
 2026 16:44:33 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 16:44:33 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Index:
 AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDAgAAFB6CAAKeVAIABIOnwgACOxQCAARoLgIAAbQoAgADxWmA=
Date: Fri, 16 Jan 2026 16:44:33 +0000
Message-ID:
 <SA3PR21MB3867B98BBA96FF3BA7F42F3FCA8DA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260114185450.58db5a6d@kernel.org>
	<SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260115181434.4494fe9f@kernel.org>
In-Reply-To: <20260115181434.4494fe9f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=40f04205-2a08-469e-87f6-beefcfa6eb72;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-16T16:38:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6225:EE_
x-ms-office365-filtering-correlation-id: 37c04353-1182-4618-426d-08de551e8710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aZoFH7gPoVzX1ZJav2ZvSmj+TPj8tKzFXer9LK4FP0KH8Ym3XNuDW+DriKcj?=
 =?us-ascii?Q?Z6nUKf+edvn00xS8I+RHBcu6ax9bgo5umqM+0Nt6/7S34g43TdkQa7PgPH3d?=
 =?us-ascii?Q?nsppbmQ2i9MKFZEWMgUBKVlNnyryJVxyK9EQCembB3B6CqO/MpSklkIgIogk?=
 =?us-ascii?Q?E8SV8RxlGL7Z4uCeoH43cup9UHOEw0+XDezh4bgFOjv+VRvsKXq+JGxYs/dU?=
 =?us-ascii?Q?7qrTuSo7G1siVdLuvesDjXOfOLv1adsyCy9xWxtScJHrp5Rs/nxrZ9d6hXjr?=
 =?us-ascii?Q?vrCggEJN3rvgh4Ij9xrQlQoNJ74XL4hPU7hapdLXzdNVsNtAQTWh/cYRgYsi?=
 =?us-ascii?Q?XVSExONM7LUHWtZd2f6RwAFr/GNWyFGcyFpaT0zdfWQolgxK9OU+/T9RFdLs?=
 =?us-ascii?Q?poEk33/BJE47p8MUOqtBBoaaconNUw5nycSUBfogEmxBT7XodPBRi9nVXOtz?=
 =?us-ascii?Q?G7MtNsDv1LYtv1hNBdQ9+ZRlPv2L2m+c08quKsszNgnX2GHlOef+XJaBiDYl?=
 =?us-ascii?Q?nYnLMg3rP91twi/alSOp4e4/sexd4C8JBo2fBDBCD0mENMO325hglgP3/dgs?=
 =?us-ascii?Q?pfxvWxpz6Kf8bVs7kSM50leZWFYzLrJJ0F0WwvSiba7PAsWo1vOtnkbB/md8?=
 =?us-ascii?Q?QGQpKimIY9/HX0YfOMtV/jbE3HxzYpl8bfc2sMeI60jT/4klpCXggMC9hW1B?=
 =?us-ascii?Q?H140Ry5iv+rLuZ41F7/cRLSTLOr9J8aC8zGyAugxih8A1NSRK8ccFRrUZdL5?=
 =?us-ascii?Q?uKwWJ/HQ+JFpKW5Xl275TzQitubo+hk6c3mUie6I/75eZrrd+muD0Ejthwhz?=
 =?us-ascii?Q?U/ww5GTAsOy0YfPApSclZQKiXHU2efpVsAI65S785Z9/mH4XriALEmdCSzdc?=
 =?us-ascii?Q?UzyRUgyNip9UUtGDJsSV7iCHpcZvSZHz9g6eRY2ht4mlMohhpaISzCX2DLpC?=
 =?us-ascii?Q?61YQdEcY+YAFK5pjwAv9yzSDKf9DEk33RRb+1xmTvNTKey3FWIPPwi5YbceJ?=
 =?us-ascii?Q?sNxIvLGtmSGHWheBOWMUDcvkmid3LUncJc2cGh9Pmdmo4receFV9Qf53laNy?=
 =?us-ascii?Q?2OfcUiUm4RE/EiRX7lr92hLCHU2469tox8wg4ANUa00kDmUbPtTZBWAxWj1s?=
 =?us-ascii?Q?XdpkLdPFJckIfKcbSFEgUl5dwcHKp1ggmauE+pedsFSgQsdDtebtahDfleDt?=
 =?us-ascii?Q?YGubG5O1lW075DiAPVzBO5NmgB7MBcLXcPjoA9yr/1plG36RGKDrj/xrtCpx?=
 =?us-ascii?Q?0kD4M8Ow8pIsm09pYE7djv87rQT0fFvSxcEbm1IutmSyfaXuIDLZZjealdAu?=
 =?us-ascii?Q?j2tpqPUlSlwWOC01iea5AsQy7tfPIgITV/aVocjx2kgxf+nCcImKSrwDLJw4?=
 =?us-ascii?Q?JldHu+fLuoXpCkffK0HLqWVILa/sF0ICWTTzDXIwJOZ+KAtRl/nPjj0m2r28?=
 =?us-ascii?Q?TV55Dpz9vlVih+L04fW0FhmY9g7d6wg5CV4pMlT7d8/jKA4rWkchl4Tz1Rvm?=
 =?us-ascii?Q?+NX80mHlzB0P8PzV+lgL7y7zTBbKTOfvDp46smAnssQr2jqGGk4LT7gBnxxL?=
 =?us-ascii?Q?uvyBNfahGr+/ofEla93sGIWNUOk6DX37HYeQsBZlkH/Ipe2sYcPVIZup83OQ?=
 =?us-ascii?Q?MHpY53eurrxblkQENIdkXrI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d+nSkG2e8av7yMHgAdJ852ZGuy++z33JpnK5tBwIG+tNHqUfFRhoRznhnMn6?=
 =?us-ascii?Q?N/QuXlxmAf7XhksIx53fuRib51qB92Lm9nMPCpFbuPzhWaLaJrpbx4UTM+HQ?=
 =?us-ascii?Q?+fvx05qe07+n16NVX79OAg64yiGrcdaJpZi/l/DcXe6uwYsLMTl+DBoERD/T?=
 =?us-ascii?Q?VDwcYErw4INNTel/0Zw7ZYOvWI4Sn9LJOPkZqXr89V4ZynWd7UirhkpolHFZ?=
 =?us-ascii?Q?+A8Pd5OpNlLUIQPvh3ZHK2VrYiXsJeRkSyO9E6gUqOm8683QcXbsvzhYducw?=
 =?us-ascii?Q?PFkN22eJJZDgmfBgNW9AA5LuVU0nWLxWidotSidqVJi0nPA9cPH+IATpSGgq?=
 =?us-ascii?Q?t8sh+U6HP9vHqn/7ddlMMWcswUnnp2Ak6SfBpIl91d4V2CfL0Z0Te/njiMB3?=
 =?us-ascii?Q?kLvOWTkJZy9ZpxV8sI1b9x/nr8xrGx9suDX1oFgci+dNHnmfl7TyrlEKqBrd?=
 =?us-ascii?Q?gvUbjTzvjZQgXCxmaWC7fFvMb3D32yPUqeFOlQ9IA7UihyMche8vWCIhC1oP?=
 =?us-ascii?Q?IeuWZiap7VqSuDZdJ4HH39cxWgbpCrSrlG9OehO2/KwKftsZ+88ubfaxvdEZ?=
 =?us-ascii?Q?6Tu6c/p3IdFi5kBPDzqikFW0L9jnVYIk6tmBWzvXKvvGdsE2e5ya9lcPnZKJ?=
 =?us-ascii?Q?EF8dmJAtyhrcxta1+gVoSn9Se5joTFcsd8Xg4x2vgakK3lOmkezqPUMytDvi?=
 =?us-ascii?Q?Dn0esLkhEbQaT7510YJXWKVn32f9g74cFMjz15P1YbD3KbzzzIYHzgiM3nWK?=
 =?us-ascii?Q?PaNeNYyk+9fEoOdCUnFl6oijsilO9hBhENIiRYB91iHujrTqarAU+4QpaIQt?=
 =?us-ascii?Q?PSGMTGwOhKsOofffUBjsQDunBP7WXm+uXdu1EG3tGJMUYX/0txW8zFqlFX2I?=
 =?us-ascii?Q?Eur9m/or+YCt77BA8kjOxpsBO/NcokM7P7d0O2FiOpcfqS7glIZJ8K5j7MRa?=
 =?us-ascii?Q?h/AfnLTxKnmrtTgv5bNjYGlhU6kOq6xwNNVF9Tq9l5PuIPrMAVFVAzfAPpcH?=
 =?us-ascii?Q?9N+xxtbjSHPcL4oPFI1FuZ2/6uJhjAclgd5JM9u7W+iGQycg/TN+zUl5jJnU?=
 =?us-ascii?Q?ZBzr8HuJbfn4cbOBrnmXH9GM8l8NMFzFW1Ymtjhwrj7bcw6mD/2xUrFBBPqO?=
 =?us-ascii?Q?egRINcXxGV8s9PRGa0CIjxjHUscRxbIu3h/3jA6yh5XAgCtkly9/Rv1v9wi3?=
 =?us-ascii?Q?aCipUCxnYBOfpf6mTx7rmGv8sNLeMoem2f8VFOd0Qt0TfvhDkz+dZ6uuwf1+?=
 =?us-ascii?Q?tipuWiTYt9AW5zRJHGEQusRDZWxWxithJ4CTdogbG7K3H1D8B3UDPjN5zQ5w?=
 =?us-ascii?Q?uPF9ZPWtOTDv6wmB8TMIhB1ZWO5XnnY24DpXBMx2aP2RT47K9bcy0lCqq1ZC?=
 =?us-ascii?Q?IuK0L3WqpE6kqmlves13lulmHk7xXOYW9Kt1DRYs9XD7Ss9dk/ZtVlhB5zJY?=
 =?us-ascii?Q?bAu2cPeC6+DWa/pAIjNBCxEh/w4qY0Je2sjM75iDsctMTWE+wMew98cv/BL7?=
 =?us-ascii?Q?UF87UN7+x3Z/IwZ2Mteo2ElyvDKNAWHZDMpWcJgSu165ezafY8Q2wSgSQkJN?=
 =?us-ascii?Q?zryHzg0L+BS0za/tmsGKAvCAnjE+UDUJczIgziHFZsi7pcpDk/AgNCuNBRpa?=
 =?us-ascii?Q?VACmH52h3yhxt+kuQZXNxpGHxTzyhih+SNo7x7jvUIzIJktKyVI2ITMvOjSE?=
 =?us-ascii?Q?k4K7V2vHVdL/y7RUybttTvE9sjbMMhp75T5MWQ3C0FBu7mzIry8nc6lp/TEA?=
 =?us-ascii?Q?aLAa+CWtRA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c04353-1182-4618-426d-08de551e8710
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 16:44:33.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqadLw/kOI3C8lxUW5da5wAWCaz2viejwmbyPTCpyOIWFDPKuA82n5STZwF+9OqGG6/hrgU1rWkGIQ8h9/7CEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6225



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, January 15, 2026 9:15 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Konstanti=
n
> Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>; Erni
> Sri Satya Vennela <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add
> support for coalesced RX packets on CQE
>=20
> On Thu, 15 Jan 2026 19:57:44 +0000 Haiyang Zhang wrote:
> > > > When coalescing is enabled, the device waits for packets which can
> > > > have the CQE coalesced with previous packet(s). That coalescing
> process
> > > > is finished (and a CQE written to the appropriate CQ) when the CQE
> is
> > > > filled with 4 pkts, or time expired, or other device specific logic
> is
> > > > satisfied.
> > >
> > > See, what I'm afraid is happening here is that you are enabling
> > > completion coalescing (how long the device keeps the CQE pending).
> > > Which is _not_ what rx_max_coalesced_frames controls for most NICs.
> > > For most NICs rx_max_coalesced_frames controls IRQ generation logic.
> > >
> > > The NIC first buffers up CQEs for typically single digit usecs, and
> > > then once CQE timer exipred and writeback happened it starts an IRQ
> > > coalescing timer. Once the IRQ coalescing timer expires IRQ is
> > > triggered, which schedules NAPI. (broad strokes, obviously many
> > > differences and optimizations exist)
> > >
> > > Is my guess correct? Are you controlling CQE coalescing>
> > >
> > > Can you control the timeout instead of the frame count?
> >
> > Our NIC's timeout value cannot be controlled by driver. Also, the
> > timeout may be changed in future NIC HW.
> >
> > So, I use the ethtool/rx-frames, which is either 1 or 4 on our
> > NIC, to switch the CQE coalescing feature on/off.
>=20
> I feel like this is not the first time I'm having a conversation with
> you where you are not answering my direct questions, not just one
> sliver. IDK why you're doing this, but being able to participate
> in  an email exchange is a bare minimum for participating upstream.
> Please consider this a warning.

Sure, let me try to reply again -- does this (see below) answer all=20
your questions? And, feel free to ask any further questions, we are=20
willing to collaborate with you and other upstream people at any time :)
=20
> The NIC first buffers up CQEs for typically single digit usecs, and
> then once CQE timer exipred and writeback happened it starts an IRQ
> coalescing timer. Once the IRQ coalescing timer expires IRQ is
> triggered, which schedules NAPI. (broad strokes, obviously many
> differences and optimizations exist)
> Is my guess correct? Are you controlling CQE coalescing?
=20
Yes, it's correct. And we are controlling "CQE coalescing".

>=20
> If I interpret your reply correctly you are indeed coalescing writeback.

Yes, we are coalescing CQE writeback.

> You need to add a new param to the uAPI.=20

Since this feature is not common to other NICs, can we use an=20
ethtool private flag instead?
When the flag is set, the CQE coalescing will be enabled and put=20
up to 4 pkts in a CQE.

> Please add both size and
> timeout. Expose the timeout as read only if your device doesn't support
> controlling it per queue.

Does the "size" mean the max pks per CQE (1 or 4)?
The timeout value is not even exposed to driver, and subject to change=20
in the future. Also the HW mechanism is proprietary... So, can we not=20
"expose" the timeout value in "ethtool -c" outputs, because it's not=20
available at driver level?

Thanks,
- Haiyang

