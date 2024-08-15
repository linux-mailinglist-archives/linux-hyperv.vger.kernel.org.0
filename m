Return-Path: <linux-hyperv+bounces-2777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B9953AD2
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 21:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862B328733B
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05C57CA7;
	Thu, 15 Aug 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FQnbFLDu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020090.outbound.protection.outlook.com [52.101.85.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84C34545;
	Thu, 15 Aug 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749837; cv=fail; b=N77jIYeFXHSZe7IIkcjUVFd7QKYLhnv8AI+6Ivqgyiup+Jb4GsFRxOiSjhE03H1U7vXoT+XOuPhIyfcGEn8rpb6jy7FfFSNuar9UDPiAh4k953GMlLq4zQVwm1QZhRsXZybK0y3Y+3C7KKXj7pOo7CVd1N8pWOABCDuiMJsxnW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749837; c=relaxed/simple;
	bh=yQgEYF4tTJLu+plGEyMlcv1dkjoVhsXDtYJRvfbfk9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SwdAYWkDPYyEJEPa0fERLuSrm6xGQdh6a0hD8bsaSoGmPKu4RWVXi9+CfGVllcDp4nHJZfVo3yjOM+//Y+c+T/8NP2Ta6ZJ2h2Dx1W3gRJAAt+ZlDXxrCd6lJqUqgMCWezyy9FSTlAA9AB7MbNViKkdgaP22V3Ks8lcOwqa5rto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FQnbFLDu; arc=fail smtp.client-ip=52.101.85.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXxXfu25JkAnfXNkW89TjaYUSYfDunCL4vTbqDi6PPRUhZOgNItPXXBZjsEppg5sxBELJg59hqej5y/W7M0o3CZJHuM7on4gmMTWAuJEku2yuWkQSUF/UIQi73j0X+eELRyEL+EVlSL7idmN+WzzLEHylKjI/nMlZ/z9bmaGRiyUeDRqhLHqYfJf0Mz+OfR6sY4udZIF2NPI5QhT97VVqNbb7OL3lMRdPTfMJjSmiYvaOgmH5DZB6C2pt7FBr6rmILfCp/DoQoGAO8PZVVB6ZnOAFMKcbQLiswoOru0/aYTpR2FMsQsyqUYA7Oc0a4wcAZVUH7pottnAHXyEZE8G2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUn1U/SBKqsioU4P8TAj1sWwIZPFzU8VurAyooCby8c=;
 b=Q8mUSQ7JKQtp+SFcqekRAsGFyPlHJXbaAIOOF9vzXKpG23drXnN5EdWXj7IYW5T/DJmLIg7B8yvjbWUAzrR2ITxoFXjYSG3oyDqHS93CNaIDA5Mk9800ecYgYy6UhT+Fdn5sCcI5KzAMSWm+FODrf/TO8cVrXfdfzOZaMx9eXKrwcjcxnetAuUgS8vTsrIS89m8YiPKsjLA1xfJOP5lFMMudMEFKcTDOHz2m2VroCjsPMMXymiQTdEZPdpnEGLtiS9QbFz4VbY2KpnR3qFPeHfs4kokPusL62/zeNnXJTlIlQGWEQoZ7Yq228YvM5p7Ta7CUgtVsqt1SNb7VncDU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUn1U/SBKqsioU4P8TAj1sWwIZPFzU8VurAyooCby8c=;
 b=FQnbFLDuIndr9lGHIY7U2LmlyoZtlEj7BLebRrB0yLpC3PDuVJbvzl90B5wGripOWsHroeVBjWCINvJEBWUxuDZ29OwKZmdXdfpAS9WFVwr4myRpE/6k+hLhmZcDftT7SfGRmqJPsEEJ795E0OjrbtDBPd+gMF4DSPfq2ikY6lg=
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::14e) by DS1PR21MB4379.namprd21.prod.outlook.com
 (2603:10b6:8:207::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Thu, 15 Aug
 2024 19:23:53 +0000
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::4257:4ca7:8dc8:8747]) by CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::4257:4ca7:8dc8:8747%7]) with mapi id 15.20.7897.009; Thu, 15 Aug 2024
 19:23:50 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Erni Sri Satya Vennela <ernis@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Topic: [PATCH v2] net: netvsc: Update default VMBus channels
Thread-Index: AQHa7mtV2XlZOJGmCEaDVZjl//CytbIofgUAgAAuPuA=
Date: Thu, 15 Aug 2024 19:23:50 +0000
Message-ID:
 <CH2PPF910B3338DB4798D086CB50600C2FBCA802@CH2PPF910B3338D.namprd21.prod.outlook.com>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
 <20240815090856.7f8ec005@kernel.org>
In-Reply-To: <20240815090856.7f8ec005@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ernis@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e38ed5e1-3322-484e-bed7-11a66c599570;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-15T18:54:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF910B3338D:EE_|DS1PR21MB4379:EE_
x-ms-office365-filtering-correlation-id: bd4882f9-f7cc-413f-b481-08dcbd5fcb27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qfnxVuNt7h/nGo4KOl1ZRFc8+e7526UeRzzEF9C8FhBsffZps2TTqZNUNnBK?=
 =?us-ascii?Q?woj6x2Vxpa5iFeLqDR+iWL0dGN3P1xSp4m5S1kBg6TC3wc71p4g3DyVvSlnp?=
 =?us-ascii?Q?ST5041zvzdo4am9FGO2oFV+UdkSKotsmy7BfYONo8U7xPq4bzRztwNf1YDIM?=
 =?us-ascii?Q?yJ/pSgPUVAbuLJPrOpgwBCneSfjbTo15TNiViMZibVJ8YUQNkeBMIdpjHBD7?=
 =?us-ascii?Q?TF8m2lsmv80a7SLnHgS4JYReU+e63VMGCfY7N7wcDNwRu63MASDHCWLcqfz2?=
 =?us-ascii?Q?/P5XlIOnDcrzzG28L4Xrvy6cUB6O0qxCnYi7ARLTKwP/+n9cUMCOKrx0duwX?=
 =?us-ascii?Q?eSnqjE79TnUAlnly8MEd+bl8DpYkUMk2GkYDjPlDpqCWFEWOwC1jgbySrIHM?=
 =?us-ascii?Q?k9o79HI8N8KViIWVr/xvbWK7JJT60L1SJBtJ/4JrfCfWzElFb+Pn4/2iVHQ4?=
 =?us-ascii?Q?fyPESI/IQF4etDb9g63Vi1REY4EkZdmTYQdt0YoSxOCtTa61gr53U7FeMzUv?=
 =?us-ascii?Q?AY3B6ri3RfBQ9c4BY8cyyzq0l5Eu3A6nr+iCgQoCoZBwtT3y7U0U7WjuzEOo?=
 =?us-ascii?Q?xdsC0tpLMCZh+tSr7CSNZNIVc6+w5Cub7NZn7iB4XM1E1tjarZGJEmUQaCsq?=
 =?us-ascii?Q?P7dG69ohQlT+STE1oefYYmwhz1nO+8+YthXff9ex/Xo4G8UK87iUPbNEeBv9?=
 =?us-ascii?Q?wH4c7AL/YqUbu44PxmU5IilvjPAmn6ytppdxi9y2tz+TsQAK5lbUe1woUjbq?=
 =?us-ascii?Q?DuvL8ot+s82b5kBExkX6EGvoGmNIwSNfYcY7MmyL/Bdz80UhilDEjVt1uYv/?=
 =?us-ascii?Q?WckTSXqGm0KLPpzFRdegiT1azTTQqKa0SwbEAJrBe26XBA/zUzXpKPrzSk22?=
 =?us-ascii?Q?MZiYnLGBWnwT+P2r6ih2ESDYERQnF4XNAjE829awG8yYTVZg6lOtePfocViF?=
 =?us-ascii?Q?61Q57UiHF8G4UffWNoKADJ1YtSTcXzsb/AkIT+YmBo/WRg9CkqvpxzGS/HXy?=
 =?us-ascii?Q?1WvZNi6UnDCN+yJQ68eB6sBVvcYVUe834FfYMbbDbLiX9rvc3gZ4XtwyIaFp?=
 =?us-ascii?Q?vgncVNsmkc7GwEX33Ew6cnwANZji8+5coDlOwTF5RJJqZa8XPzNJXXZhgkvp?=
 =?us-ascii?Q?42NigqlDR4aDRSr4oOnErAFJm5o5zYK4beQo99bVmjJXkMmSHI5xDpq8dVPL?=
 =?us-ascii?Q?OuneDxbDDmyE6CGQS5hVUSrC2RUuGhhmPN3ZyhrH32jCgym/6Fpx00S9lnAo?=
 =?us-ascii?Q?ygAVwpTlhYjR17ZB+qZGBazjLG/QzeE4tE8gt8Nqzib6TUtJvbOmXp+2MJ34?=
 =?us-ascii?Q?+TQH/srYFncVYJXj/vxcyPYPgnLSRb9pUjBzFc9ibCUGJbTCh1sdHDk2qJx/?=
 =?us-ascii?Q?2typ+Vjn7NcDFHRGpmMHu3ncnGgy4HNrI+b7qhV4+wX8U2hVdw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF910B3338D.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YWbgnu2bcEHbLpdytnnXp89wWoBh2uskGUR4pQbsHHtJOlyZYZkpcjEWvSDw?=
 =?us-ascii?Q?6+xbk9y7tvL75sJfpnnn8nfT+h31WenScYnMphKmb0izloLffnKGpB8awM75?=
 =?us-ascii?Q?ouTQvpPSepcPJjV8ZZ/ir1ViI4INiCltbFLE9HpBvGN5RMroZtQYv+z9LmyH?=
 =?us-ascii?Q?hP0lw2fAOQ9jO2NqRWyk1yv33Yf8ShtY/Xv8Lp5hab3SnXLT0+YC8wAZQ13r?=
 =?us-ascii?Q?nXQi6yADT+JVrx9rSVKaAUtABIaGKdcWQQLmfk01TQy33ipM9pk/bpZNwdPb?=
 =?us-ascii?Q?3VTuGDHICB4LGabxXfjTzxtb3kGpbSeaRBXGL9ZKUsSsRRkyJgvWFbqhhIaD?=
 =?us-ascii?Q?RlnOL3RX8vZsJaweyCJvBeqkO0OUM8NsJqYLAXoFQKLVMnE9H/3lv+RD002g?=
 =?us-ascii?Q?FLbxRgxjUcsjaX3ypnepBFpGmO+6G5/Fdod9mfzKoqoNmSIvnumK880eOZiO?=
 =?us-ascii?Q?QzJujSbx+wx7adEU5yYuCFUOaT0LDHpgMuF2xSfeZZvIGnVs6r89ssWOhZl2?=
 =?us-ascii?Q?5/oSl6MIgBCNWIYldqWNgf9aMcbFOHqjztA6V21i5HwjPdbsbMUVpxC9UTb0?=
 =?us-ascii?Q?07J+3zKA/MVPNhfqGBfbWqmQyfYkq3h3zsAIY/NfSHTr3OpOYHoGsE8vp/Re?=
 =?us-ascii?Q?T5dMTiyZkSNrDdRsCVK9akwPCNr5JIt2dSM3ArJj4meh56B77W5ZzaapJ5pS?=
 =?us-ascii?Q?iJ0PbL/Ws/AX/qWeQmpUSXGLDreN0gBmskgInQ4qdMHoBNtT3NqI+Bkj4xxt?=
 =?us-ascii?Q?rtuERNMUW3E/r1h/2zmR3fjfmVywKvZCwFRjjHljN9mMsveIfLyEiXHh1NFx?=
 =?us-ascii?Q?yTwnIMFxGelKn4KXfCS9zabvYFtTn3JmwQ4Jy5t9iLaVB1uQH3MrRK7RwKkk?=
 =?us-ascii?Q?TXLgAAiCWI2QhsOMO1YvvfINMbDLOZfgvPrVij50adNX29BHPXg67/qkyBhT?=
 =?us-ascii?Q?dmhsy5FWE9UmG+SzLyoWRhg+rNgRu2GPctdm6mEfJ26iAwefMgGTmb0SgrRl?=
 =?us-ascii?Q?+oiKUBGGv03n9bardBmBIorXaUU1dg/MbIjRHe5O+sy+jidjsp0SJw44doAw?=
 =?us-ascii?Q?UOhdodUi/qmapZ2IKybFRMKnjFSv22ifS8o/kfMvCXqXZ2vCLQ4mLgD7GuUj?=
 =?us-ascii?Q?nIbzaywk9zMuJiYqErvbWj6bR6qCHDRRlH28Dqpm+4kPv7Jy/l7NzmG1MzsD?=
 =?us-ascii?Q?VL8u09QfD0HUVW7R9UoV+8LfQQuGz5xk8nQ06tZvtvLkgdonXhTKTWmGsdJP?=
 =?us-ascii?Q?jUWv8Z4U7IN4UUCSPOpRFyNf7Zes5TlLe++fOuNyWezIzRqb5Ii9dQegig31?=
 =?us-ascii?Q?/bf+g94jglNooFYDkNPD4F2JeoSSl20mjiAi10iYse4pAXces7YgODQdY3KC?=
 =?us-ascii?Q?MkRhSlwcb6nC8IiFStPaiuMmB1/JXTpTQsftl75i3BM4DSISD+LcMaJmM9bs?=
 =?us-ascii?Q?3XydK6fh6IAMdnVTSLTnU0tsT1YqPQPnr3X0AFaVi3Ow0Ix58MlllUBHaMHt?=
 =?us-ascii?Q?8aXGno7gYUNsqxrnest+m5pXRoPJxV3FL+JSGCOAKrnlPPmaMhwoL4zXk8+g?=
 =?us-ascii?Q?Ljwucf24mD3BrESWE6drfdsuy6qZcWE9nBTUzc+b?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF910B3338D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4882f9-f7cc-413f-b481-08dcbd5fcb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 19:23:50.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjASfmKWHXT3xbqJC4aJslY2a6wk0i3nhGDu95uzG/R6a2ddaAxU/V0B2AzzsLcIiUBAQ0D+8SZp1GHrl4ttCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4379



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, August 15, 2024 12:09 PM
> To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; Erni Sri Satya Vennela <ernis@microsoft.com=
>
> Subject: Re: [PATCH v2] net: netvsc: Update default VMBus channels
>=20
> On Wed, 14 Aug 2024 09:59:13 -0700 Erni Sri Satya Vennela wrote:
> > Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> > Linux netvsc from 8 to 16 to align with Azure Windows VM
> > and improve networking throughput.
> >
> > For VMs having less than 16 vCPUS, the channels depend
> > on number of vCPUs. Between 16 to 32 vCPUs, the channels
> > default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
> > set the channels to number of physical cores / 2 as a way
> > to optimize CPU resource utilization and scale for high-end
> > processors with many cores.
> > Maximum number of channels are by default set to 64.
> >
> > Based on this change the subchannel creation would change as follows:
> >
> > -------------------------------------------------------------
> > |No. of vCPU	|dev_info->num_chn	|subchannel created |
> > -------------------------------------------------------------
> > |  0-16		|	16		|	vCPU	    |
> > | >16 & <=3D32	|	16		|	16          |
> > | >32 & <=3D128	|	vCPU/2		|	vCPU/2      |
> > | >128		|	vCPU/2		|	64          |
> > -------------------------------------------------------------
> >
> > Performance tests showed significant improvement in throughput:
> > - 0.54% for 16 vCPUs
> > - 0.83% for 32 vCPUs
> > - 1.76% for 48 vCPUs
> > - 10.35% for 64 vCPUs
> > - 13.47% for 96 vCPUs
>=20
> Is there anything that needs clarifying in my feedback on v1?
>=20
> https://lore.kernel.org/all/20240807201857.445f9f95@kernel.org/
>=20
> Ignoring maintainer feedback is known to result in angry outbursts.

Your suggestion on netif_get_num_default_rss_queues() is not ignored.
We discussed internally on the formula we used for the num_chn, and
chose a similar formula for higher number of vCPUs as in=20
netif_get_num_default_rss_queues().
For lower number of vCPUs, we use the same default as Windows guests,
because we don't want any potential regression.

So, the end result is a step function:
> > -------------------------------------------------------------
> > |No. of vCPU	|dev_info->num_chn	|subchannel created |
> > -------------------------------------------------------------
> > |  0-16		|	16			|	vCPU	      |
> > | >16 & <=3D32	|	16			|	16          |
> > | >32 & <=3D128	|	vCPU/2		|	vCPU/2      |
> > | >128		|	vCPU/2		|	64          |
> > -------------------------------------------------------------

@Erni Sri Satya Vennela
Next time, please reply to maintainer's emails to LKML, regarding
how you think of the suggestions.

Also, netif_get_num_default_rss_queues() uses #phys cores, which
is different from num_online_cpus().
You can try like below, in addition to your comparison test, see
if it's better than the patch v2.

	dev_info->num_chn =3D netif_get_num_default_rss_queues();
	if (dev_info->num_chn < VRSS_CHANNEL_DEFAULT)
		dev_info->num_chn =3D VRSS_CHANNEL_DEFAULT;

Thanks,
- Haiyang


