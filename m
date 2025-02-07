Return-Path: <linux-hyperv+bounces-3858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE5A2CFE2
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 22:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9A2162600
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2025 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D391CAA8A;
	Fri,  7 Feb 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SEdJOMZ5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022090.outbound.protection.outlook.com [40.93.195.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2E1A254C;
	Fri,  7 Feb 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964369; cv=fail; b=A0PanDNMkeFSy2mfpQ0GbC45Ib7RxEuOJMKDP4o0p9sxUsuuPrlRBwBd04GSi9qTnAX1G7yFOnyBzKrRNxZjoF/hXCyq4J0lvH3oe3gz0ZZa/EEkZc/yr7r/E2gqnFlBp6MVkn0JgXpWu9RNCjjbci86nOjQHIKk7rtXE3s5etQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964369; c=relaxed/simple;
	bh=O5jXLgHr48jR+63oS+a5miz+DFhJQR9zgBscvwsHLU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j7VQYy/FuRed6PcVzRmuNnxIZwLVSyTVDRSFTr9M/ngmHg1rzNwPbVcfuL7Dt5nGDVu1/XYPU93axh3Z5ox5OWIEafTt5xtmuVPGrRsNhh3bX+RqoTseSdih265lmF/jM1Hl/JcW71oco9PnOnKR3IGapEg9lsUPdnd/0zvwgC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SEdJOMZ5; arc=fail smtp.client-ip=40.93.195.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCnDyT0GGgq6sTMA8YZHxWCbLQpwBNkow/XrHKo5k6kBQbeInc585uln6Jp/PJwJ6mzfK8cc88CxPZw2/0aYfFcFy59tnJLexhOZJAhLHUK+r1TUq0AFt/HZr87LmzDX4WVEoWq0UPgWoOH++eWsHWXMLoap1VpZa3sJdpNodhLMwWDXPwJ3XKwl/DbZ8aue3bIOSYG3IQZhBD1YNW0jzs048TIU8mm3ZFcc4e8S5K98hxcghhC/gw6cX5hVXVGpfQsWiJ/BtXbzdF53bJP6yzsl5R1lCrqUfS+ogS7f7EddZS/obs2yiKJ34Cic+9tdhJu4tYfqY2OA1tioPl868A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inGyJ0m5Gskuxn04UF5DS6I3CSeQYJSaMVYFLjMcIWU=;
 b=kzDMhESWolWt4Y9UlBxvX/ImvLsM9bwzQpt46TsZ4BdsRk/fkNx5uTwDShZk1eEmlYLV/Ilg3H/8X7fPCG5gAuMAdQj2Fn/HObG4QVA4JBH/L88fCj0GAeHNdT9BWGRrhtihdV10KZtcGCaVE2LfK+3JNI8lorOkKvMK73cHs+BnPsdfMCyFfYXb7Z3FRBUyIzH5OHWyA6UtbdFnFennfU7GiHAa9E6wXyG3JuB/aFlJwkmCvYW2dsIE0SLKKHubzGLL6Dl42WOofdcthkQkJPqmgD5aQgtAB98CGU0K5a8GBDEedINT31QGxkfwUTnk73hMo5ozYPhRdRsZA691Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inGyJ0m5Gskuxn04UF5DS6I3CSeQYJSaMVYFLjMcIWU=;
 b=SEdJOMZ5KG5jL9MfpqHXzL99BGr188g+AeqtvQLgTToKNrAhyErZI8AYeEqPteB4Mw3B0kht52/FqBxDciLScihVbbltnaBAc6fk5b/8Q2Bfa2xxU8xfMhStKgZiIBU0Qj3j0WbB67RpFiGqY8hp8lzRNJORf2bRHl1ZhwXV1yc=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN7PR21MB3954.namprd21.prod.outlook.com (2603:10b6:806:2dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Fri, 7 Feb
 2025 21:39:25 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%3]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 21:39:25 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Parav Pandit <parav@nvidia.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>, "open list:Hyper-V/Azure CORE AND
 DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct
 device into ib
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct
 device into ib
Thread-Index:
 AQHaxupwGAu99WXsuk6CZeFbpa7lGLHZiusAgAA3HoCAADQIAIDnyovQgAdWm4CAAEchAIADHbcwgADpCICAcF490A==
Date: Fri, 7 Feb 2025 21:39:25 +0000
Message-ID:
 <SA6PR21MB423134BE13A241A0822D8178CEF12@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
 <CY8PR12MB719506ED60DBD124D3784CB6DC2E2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241125201036.GK160612@unreal>
 <CH3PR21MB4398E0C57E7B6BC73B1A8F04CE282@CH3PR21MB4398.namprd21.prod.outlook.com>
 <20241128093947.GG1245331@unreal>
In-Reply-To: <20241128093947.GG1245331@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=68c35758-c6a9-4196-8e07-a782dd468301;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-07T21:38:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN7PR21MB3954:EE_
x-ms-office365-filtering-correlation-id: 71ebbe31-895a-4350-9c72-08dd47bfe4b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Pc2yCNJoXWteOynXuq3pW7fIQxtmA2Pu2R+iikZdrSkvh5TW1fXeeI6Kf2Q9?=
 =?us-ascii?Q?Nr6ZlZJciPhOaRMTxptkio2Hwl+1ZQPkiLPwyWwViTpkJ0YGNzXJn47jc7xQ?=
 =?us-ascii?Q?KU8OYmWgmxZMvOuNJ0BWnAj/cD29ilhjRE/b47hwL5hLxtcx0QdD1riI8jOe?=
 =?us-ascii?Q?nkRfMP4UGVMOqtDnruHa1mJ/X6kzyAnPZPukkuYpzcwNEpK9QDbwceEx9WJI?=
 =?us-ascii?Q?iXirVdKbUh40C8QYszQ6fT9l/Rl9d6BzsmLXE6a7+kDd6WtrU31OjcVWPNYp?=
 =?us-ascii?Q?UVGfLFywQgyhc2vxIapY1+guJVQuI3J1Km3fR7Qd7aIo/leI6PB7OR0FFKJ2?=
 =?us-ascii?Q?VJTfYOdJOh3iy/3AIcrbojev5EYgnhxxzLmO+JlDWoNjY3weQNO6LUZDSaJV?=
 =?us-ascii?Q?SeaSDWspVwP6gdXB+Gs0bnVE/zKC18IAcdREw8HcOdAx9jux6JwZU6sPm/Qn?=
 =?us-ascii?Q?XLaAUoe1pZVoy5aZ7Ltip9autok+2OkTJszcsAxgkWVsv+Ml5jUTBZBotSB1?=
 =?us-ascii?Q?YVXKTUQZsZ6iEz/Q8QaoG5UgUJRuzteoFEzfxkcckTxOyLqtQMXACsbJesEH?=
 =?us-ascii?Q?mlDy3y4kCjuvVIFZitBzC1TcCk6/7ZY+pQ4+YeRY7LEoRDKnOXGCoq481pLo?=
 =?us-ascii?Q?oI4zdtvy+DmPyRgdZjRC/rGWDvjyGWnyQO3uTLBilExVYrqKaZQ5ZXbERHuJ?=
 =?us-ascii?Q?XicE8WacYjxnJ6KbXn63qFKME3w30qGehgyIa+T3ETqGspJdYRI4/+XVbPhb?=
 =?us-ascii?Q?XFPPtyfhfIpbbU9VISPIBJXTDLK3TRR0wmEYS/Nnx3IVb5iEZcDCIbKxuJXP?=
 =?us-ascii?Q?GWtRLVFlDhE4glK20GSZsYF5jvwWUQjcbRrFH8Uxq0qT24lMzyooyq1LToOS?=
 =?us-ascii?Q?xsF+BEy21WjqAYSjiWKr9Xzf/ksVZXVeV6RUIEHkyH8tC0g+K/YBdKvwJrhv?=
 =?us-ascii?Q?QA2NyBsws16upcPm9MFacyvE7AUn2+63izwfbGWmJAl+LuhRlnEO5z65KsFY?=
 =?us-ascii?Q?fzL52CV5geKZLPXPMbdezxd1ip2WQ8S6WLuB0a5NLjoQf2C4YjxryCp9f6g9?=
 =?us-ascii?Q?ws9UtljXJ7KAPNdzaTReJ2PN6H9eATtSBinKDFzeuBPpJ022B4SuQQUHg3XS?=
 =?us-ascii?Q?95/HzgeWezSMoKOmujPVxf7vrhLvh5Uupz8ZQ6e1ZOrh6cv/d420WpLef23k?=
 =?us-ascii?Q?p/SH5GrsOSAvEUn3/l6vvhxLyZgNX+ytPPhQSP3wgmSQtrQvG6PD8uNq130L?=
 =?us-ascii?Q?/KhfgOHBn7qvjporcpURNQHpjD9s1+Yq6EvAj8PLXH9q6VfAvlDQvrfMuXXe?=
 =?us-ascii?Q?BoeWaXuRdaD2h6IwTjUWEXTqm5noNzvlYDYLQPs8IdBrkMoFf0ZMFjvv0zDZ?=
 =?us-ascii?Q?mILYGjkdH4rdPM/ltQkCvx4hhz0PGKeSwIHTWGkLy5xvJSW0LsCwRtxZJgi2?=
 =?us-ascii?Q?UEwNb2epxxD3LE+68ve4bkw+zE9WdkZA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ntObXej6sXpEbDLieX+pMEolRoXn1rKPRiHfoZD5Tw9HdeVFw+MMK1XaZkat?=
 =?us-ascii?Q?QVEaeea5d3AhOtK89e2cIu/16ogZ3yr7udOjmTKWWQ5M1CYUPQVKp3LbNVvs?=
 =?us-ascii?Q?k7Afj1v4p6XXp3x6YTjZOw++9thpqPQaKLQ4nSvjMw1lbBK+4qeaNlj8MW8b?=
 =?us-ascii?Q?0d4rgL3IK3EAuYDSMB1C43jfbkj20MTp28ye8bQalynmdmUYf661w1n9bu5Q?=
 =?us-ascii?Q?wLN/vzmB+dO2nEPNCq7l/HGa1RXj3kqMyFJkXPjnVnTaqS3v4B8+IYD9qSOE?=
 =?us-ascii?Q?Tw5uQhy2/U2QZNPttlpjxKiG/vI243SlIVr84b8D16kEkcLSrEzDxZXlVtmi?=
 =?us-ascii?Q?9L94q3P5zTjKwtipvj145+AKBbz8/YThdn3WEv6zbSIPOr4urAC/WA5NNL0/?=
 =?us-ascii?Q?n4V5SYWMVSid5NhQcvUjXZ+85r4RIMG3uHcErxE4HxSLrngwQMhs7icjjjNw?=
 =?us-ascii?Q?wMMOI5wkFIhb7q1RcTVoc1RyPD4iJLEei/u/iCrHkrSZzm+r6UdVL85fej1v?=
 =?us-ascii?Q?Qandh0SewO/hcPio0AdJia7N4Goy5f3Xm0+bNXAFCcrF3XKWWeBpsDbfJdJz?=
 =?us-ascii?Q?ubyh19e3Eq/Sw+sLUEbv22QipzzXtF0ric8W4ID90CrPqYLfa1ASApa1gU92?=
 =?us-ascii?Q?fhFrUGj6jVn8tlT40PXS3R5coN2Gf4Co5QXM1LeU+dT8QeobJURY0Z4aDM6C?=
 =?us-ascii?Q?EV48ElkfTHXEQ6rgvgO/mGkazeEZIsVygqdXqtubAsptg7u/aPDbWKFZwf9R?=
 =?us-ascii?Q?o9N6Wzglk0dAI21AkSmpdYPJdgjUy34dyysGszsOfehKzneLs0U7Q3q6NiQB?=
 =?us-ascii?Q?Gk0ORDDU9M5h0JCozWqGDO2jiu2QAAN2kasoDb9Jse/WZ/zjF1tnymtQpvo/?=
 =?us-ascii?Q?ylSLx0wY1cVEJboLEDWXxjRlltBWUOCMD4wWbG4ZDcRBCyJCj0aNVBTCis7k?=
 =?us-ascii?Q?jc4NhIPjV/kAIcUOWQWlmck79X+NkgxOsL3tKC4bz1GZCLt6HxzJFYkjQQHu?=
 =?us-ascii?Q?SWPWoilGhxYer9oADebwnwh3c97jrDE45Kw/op/alh5IBzisIU9ybrFn5Kkl?=
 =?us-ascii?Q?TtPzeS/uenYEbDB1XOsBR9hQMx46rXJ+72iUrTV9pdWFpb4pF85/KP64EWUQ?=
 =?us-ascii?Q?Jl3upY7g8o5eIgfl5C1+MabIfQ57odV1YKgDACqF+4kTppk8XJU8rAMr4Ax6?=
 =?us-ascii?Q?ae1HlmDpVVdpHjjkLvu6trH3oayKcoSwr4gHD2f/UAErcG3Z5W3efFU6vuUK?=
 =?us-ascii?Q?7bobpnBukLFMwdndlYeaCFmd6MOotMWdEXH8MRvUdVdzgrD2h62RFQ6YHLU5?=
 =?us-ascii?Q?9bx0DFNHM+O7wqqvmkrrtpUtBb9o5oN7KfWsOhqUQbsYRuX7iHrDa2TyTJvu?=
 =?us-ascii?Q?KmM2W19L3jTgYhbMZA+QlaFIQ9R8QDDUkipgWtTH+IPkg2qGJh/0qdiTYGF9?=
 =?us-ascii?Q?fJfS+k2/Jb97rD9YzwJUFGKCmQXKolMPvCtxXf9ufNShuXz5kVHqvo54lWfB?=
 =?us-ascii?Q?VhFzluzEzxKyxTYNyEwRhZEwj8+zxqb9La9F4PGudBss3OJE5BDJq231mTNr?=
 =?us-ascii?Q?mcDWx6KI9oqukl3FV24j6I8mFb5WkD1UrRuBRPiAmwaS4nwFH73mTsmrocWU?=
 =?us-ascii?Q?9prMI4lx2JHYuuMpb3HOJZnEj4c4A9y1tV2AATddXnbx?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ebbe31-895a-4350-9c72-08dd47bfe4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 21:39:25.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUckvj80GMw9gW+CRsqYtNwGeaSQklwD2IxHWFNrLkDdzJH658hi6P/MXb8r6hHMyY3mqsVipRNUQ3fun4aWkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3954

> On Wed, Nov 27, 2024 at 07:46:39PM +0000, Long Li wrote:
> >
> > > > > I think Konstantin's suggestion makes sense, how about we do
> > > > > this (don't need to define netdev_is_slave(dev)):
> > > > >
> > > > > --- a/drivers/infiniband/core/roce_gid_mgmt.c
> > > > > +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> > > > > @@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct
> > > > > ib_device *ib_dev, u32 port,
> > > > >         res =3D ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
> > > > >                (is_eth_active_slave_of_bonding_rcu(rdma_ndev, rea=
l_dev) &
> > > > >                 REQUIRED_BOND_STATES)) ||
> > > > > -              real_dev =3D=3D rdma_ndev);
> > > > > +              (real_dev =3D=3D rdma_ndev &&
> > > > > + !netif_is_bond_slave(rdma_ndev)));
> > > > >
> > > > >         rcu_read_unlock();
> > > > >         return res;
> > > > >
> > > > >
> > > > > is_eth_port_of_netdev_filter() should not return true if this
> > > > > netdev is a bonded slave. In this case, only use the address of i=
ts bonded
> master.
> > > > >
> > > > Right. This change makes sense to me.
> > > > I don't have a setup presently to verify it to ensure I didn't miss=
 a corner
> case.
> > > > Leon,
> > > > Can you or others please test the regression once with the formal p=
atch?
> > >
> > > Sure, once Long will send the patch, I'll make sure that it is tested=
.
> > >
> > > Thanks
> > >
> >
> > I posted patches for discussion.
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flinux-rdma%2F1732736619-19941-1-git-send-email-longli%40
> >
> linuxonhyperv.com%2FT%2F%23t&data=3D05%7C02%7Clongli%40microsoft.com%7
> C4
> >
> 20bac91521e414ff34c08dd0f909cf6%7C72f988bf86f141af91ab2d7cd011db47%7
> C1
> >
> %7C0%7C638683835975667120%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1h
> cGkiOnRy
> >
> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D
> %
> >
> 3D%7C0%7C%7C%7C&sdata=3D7vTTi%2FilkYdEKNG1qwpgYYDriOPPUF%2Bp8Zh91
> 60CEVE%
> > 3D&reserved=3D0
>=20
> Please resend these patches as series with cover letter and don't embed e=
xtra
> patch (the one which is not numbered) into the series.
>=20
> Thanks

Sorry for the late relay. I have done some more testing and sent those patc=
hes in a series with a cover letter.

Please review the series.

Thanks,
Long


