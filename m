Return-Path: <linux-hyperv+bounces-3396-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0CC9E42EA
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 19:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59D1168EB8
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1C15383D;
	Wed,  4 Dec 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eHjIiChX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020110.outbound.protection.outlook.com [52.101.51.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626D2907;
	Wed,  4 Dec 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335285; cv=fail; b=IxeKut+kq2Kh7ETP3PKf+sHr8mTdLY2Rv/20L/AoDjZP+zgzUWdFvK9ZOksePdRMZMPmiephNY5qeacxBHm91FXWQcne2QWXjhZzGalA8HvT/UJz+kg7Zobiw7wDNJK+fa8cGy7KEnw61JGsGle9lSLTKdcxAQrYronkLb8a5h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335285; c=relaxed/simple;
	bh=svIooBcHTM6yGz/sCdhZIOuikIegCOZW2E7QHnF3j88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJ1Lcw+ecPlac14JhiW6XdbtKpXnkLDlXJ8m4XgtY0U5Ir+/2fL1IDTGgYGw7qyFTd3+zu1/bDT85AIIfThXo03rpBZjh1+8RdI0lDUXa2sMWfhA7SZ6/P6fuNpQnm2KWhE0a4VW5T091WzcrBtHVSgQr1C4oQNyiQ7iYREgVwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=eHjIiChX; arc=fail smtp.client-ip=52.101.51.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHXoEAGJi9HXCcurt858lyHHmfhsUfQjjuzTOcndQkyyHHzzB+pd4ik9LQiN/r/eqDiDJqW0/BmZ9VECqkhzJpjURyrO2BHJxaykteIihCETdzmjGDZQtQNC3O1cDWseFSJ4umUC5x3Jk7rit4+00j2xPsCh+V06akk7F6QvyC7VRK7fQzF4PY2X4uoXIYq7ov9d0sTUoRh36Y72RdjJjH8Vtib1iZfGQ34UfTKrBm0fKeg2GTWK3hxAF/UmKYRHl4qVPz9+a4igu4j4s8QS7aITq8qqImWQPE8T9DGePUJIzNAuBJ6l7ObzUsQHnWFJgJGmUCjBWZhd9QQORdDrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svIooBcHTM6yGz/sCdhZIOuikIegCOZW2E7QHnF3j88=;
 b=mnH4FyjxBxce2WR8uz3ow/XgdadRwyAykA2w5pBZaLkVi997omxD2qmrAG6d/EvuTuoIfj12UXbwuaTiHw0cmCZoxkSKRMjwNinbrR28OQhHi6Cucb8QvRZmqt88JbvLO2DC7AnhcXFedxMm2vGK8YtMs0p08mc33IeA2wx+CO92zVrnknG7z4mYIDY3jjn212+OQ4UIrdC6koN3HGOyhnWwKqaZHC3cUnqWO5WzHjhc3+5IvWpZMm5T+jD8CaxWtEscItfldMXEjhTx5ABRTG7uvt4iHxB80FuGdyaIv/QEcMJbXZ6cws1sXZHMGVsX+l6Za5w6yHnUsK9/0c7Jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svIooBcHTM6yGz/sCdhZIOuikIegCOZW2E7QHnF3j88=;
 b=eHjIiChXo3gVkgYHV/iPI4PkZM4snHkhvmLeboJzmY3RGk9qasIybjultLk6lbvjge8Ht+ppG9zIi0Y/hy6W9wd+Qw0UXTtxTm1piOFbqqweeGcYhT92GbjC44VZEq98EB7Y5fA0T7IyiAXgAcNqbar36U5XkbOZej8OqWtiErM=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by MN0PR21MB3145.namprd21.prod.outlook.com (2603:10b6:208:379::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.7; Wed, 4 Dec
 2024 18:01:20 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8251.005; Wed, 4 Dec 2024
 18:01:20 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, Shradha Gupta <shradhagupta@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net :mana :Request a V2 response version for
 MANA_QUERY_GF_STAT
Thread-Topic: [PATCH net] net :mana :Request a V2 response version for
 MANA_QUERY_GF_STAT
Thread-Index: AQHbRhBDRuGJfFSClkeAWFoAUHpOk7LWYJIQ
Date: Wed, 4 Dec 2024 18:01:20 +0000
Message-ID:
 <MN0PR21MB3437D1C4146AE6238927FF69CA372@MN0PR21MB3437.namprd21.prod.outlook.com>
References:
 <1733291300-12593-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1733291300-12593-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e748be9b-8e5d-44ed-894d-9c9a49ba0434;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-12-04T18:00:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|MN0PR21MB3145:EE_
x-ms-office365-filtering-correlation-id: a733d79e-be4d-4e46-d7cb-08dd148da877
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CHsVQ0U8Xd3OJgRC6esry3409jxNgdJmIIQoDZepABwgjIKYImF71+zel4le?=
 =?us-ascii?Q?oM8ijjlPe9a1yAyFrSsQpz7edAaomF3p02jYiNXQsvQcPnu+gM1gRzQnAcEU?=
 =?us-ascii?Q?8tZSmdjBmfHKbrBG0gz4NfgRooV9WQTxuH7eL/AerHp4p6AxcrCv1Q9+IbZ1?=
 =?us-ascii?Q?VGbKPBmZfPYDLEgbgMoBzuxF7IPlJQHrKRAQXCAozqdLUwnwGLn3bO6OXpQB?=
 =?us-ascii?Q?Qr03H4E/sEjuCF2fmKB61TA0PgDiOal22I2lIEczhSBZYXD/aNbleJamn4po?=
 =?us-ascii?Q?hsoOx0LfYQIbxHRHT4O6inVEYfp/S+dFEFJPOi86JMoWecEUSYGoP25RAlKC?=
 =?us-ascii?Q?ZWcXcavGLSqeUAikmuIfkaAkRFa3YUVkrcd49bvU3Iw08T3woieGRM9awUiJ?=
 =?us-ascii?Q?owOYA5LsJ2ZX4Cb6AY4qED634b2mBBBrxuxLcktpJzpNoDsvOuNtcITtAnBR?=
 =?us-ascii?Q?LMBceRp2IWaJHEhfCVLk3jIXHF/0yx2jjYrkWF/OIhTe/GoN31bxC7gKQ7jh?=
 =?us-ascii?Q?HVNkFrxaa+PXd4iInEC70ONBjCROSuq5WpWNnvdFtJGeKyUq8Di5pbqjpQIN?=
 =?us-ascii?Q?QpHl5uGJADr9WIVYD1Oz4XeYt2YpWTgvrquDxEzjtqp6fj7L18D4TzuoXjA+?=
 =?us-ascii?Q?vvkorRArzVn4wmCnMiWOlXIUmqbfCCwjyaGuIXoC/u2MU2tLeAFqeB+AGi2c?=
 =?us-ascii?Q?hWIcZr52YD8dC5NtR4ogFA0aVIAkRKGwoAAN38xS1KNBnsmG4q/iADFtdNt2?=
 =?us-ascii?Q?k2F1BV/DMwE5bfVB1hn+Ectcd3f0KnllBuZClXerKZXq+n6Kq9pZOkZGhSol?=
 =?us-ascii?Q?OMpjZipKolyRpr62XyhsTcNqqw+RENdY09Lb1WqCvB9gQEcLP5at8N3BbP7x?=
 =?us-ascii?Q?QnPGl7NPXY2pa0ofUFq/pNQrU8in2S6x37KQzGlhU+rG85KHM8LYEDbmAVNR?=
 =?us-ascii?Q?moag9F4sWEEp1Ysb7qlHniTen7iUUmd0SExGTV6CYX2j78daYIwVazlp7rr1?=
 =?us-ascii?Q?Do2Mj5Nl5DE/FMpqsRAlp6FOhgSCla0wxZM+5C4N5agZNthLx9EPe3Qkf2gD?=
 =?us-ascii?Q?XmS9BML4Ek6jpQRs7gtoWiL16kto5BOaM2aSemPn4euhsl6d+T5A+7tyuMPS?=
 =?us-ascii?Q?T7Q7srRldvnS4Wg5XDzIKPOez8z7dHWA9G0jSt9Wm0dqQ1eG+Wp1yJ5ngSaw?=
 =?us-ascii?Q?GImI81BiFmHZZ19fdGPGF4nweP+m1eVvpjC0kVDkXkleqwmXxPlMCEA/kAxW?=
 =?us-ascii?Q?pLBM071ZkAkB6zFsOr2CA1oNlyUewYJ9u/WNP807HX50Ivu8/ubxIKq6U742?=
 =?us-ascii?Q?IsV8fee4MhOXaFahA3B5lBppeC0yMPXFNhT9CBizZSLN7PbUHtJyAoD78NgQ?=
 =?us-ascii?Q?7i3AVSBFQiy2ncvPcD5AdlrBRh2lJelyy+2E8gWUTCfdJPZEOg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tm7LBe/RxGVIPh6QNIsYx353wZB6gzvBt35n6oeYUTDk5vKtSoMw2NEgxOUx?=
 =?us-ascii?Q?pBXh9A3QCS68kOZ0SBpzGE3TBStVc4FiiHwToXKmcW8eztWeRkB0cy1p14PH?=
 =?us-ascii?Q?fEsQK5dAcVNABn5racYDHKXCjleB6Gy5aJfBUlOsvSzKO3+s5RppQbhX3jpP?=
 =?us-ascii?Q?nP4XnhBZZOGN1bv3DKNUPOrlMqE5gmJ74cqrtr49iyIoPW2fUmQUVufGep0a?=
 =?us-ascii?Q?4MW3uSzOIFjkvxetlkjh1aQML92IyPKudxNVGVeqLH8mAUm1+t4TK23RC7Uf?=
 =?us-ascii?Q?eFWdYTJQ/wjXB1vLBpd63f7SEL0u8BYHr/cvugGDzrerT2lOEvRdwpuV7xeB?=
 =?us-ascii?Q?M/xPqgbeZPjsSELBzxqwyyHBFQUqibF5ChB4i28+0J/eJHDTGHaf1GwDCyvW?=
 =?us-ascii?Q?Fc6KhZVdBPB+Ee4YEzPBpRh1annZmGrWZBmyEVJET7SXEUnCRABAvgmC/nVS?=
 =?us-ascii?Q?vhA0k0NE1eLvwvBRNTcaTYw1wKybA7HzCnYS+wJwEsMr4kXdrssJXUj4Cz50?=
 =?us-ascii?Q?yZU7DkXvpNjN2fPRfkW93dw78z1znk3bBJAcv0GRyXC6W7Gv0+CDcn/F889v?=
 =?us-ascii?Q?xXKH6jUmIxzK+3/MV3kXn16wAOqKZW4f1jwBcBOHqYCYU46TsOP7IesmiyO9?=
 =?us-ascii?Q?7Qg1G6loZf9eto/NQ+YQh1uZ6nAZQwDtFtWyrrObLHRTAO5n3XTWRJhqa3zi?=
 =?us-ascii?Q?GbbfqI3wXWDKQuoJu85Z2MuiMHyGoW5g025lTQ6QFHIHo17O/0qSQGsf6wQX?=
 =?us-ascii?Q?lKqUkPDknvg8+oGWNR0VdW7OyD0iITgh6M8rety+stVjiSlW5wiYHOvpA1vM?=
 =?us-ascii?Q?6jzWDb8qELTw8+Nn8RS1l3+qmPITUdE34BwvS2QwMk/G2DuttNJBQXwPnKMZ?=
 =?us-ascii?Q?WsaHyD0MT2UWRNceXllbidLfxycfTpoxtFtsKlZThQmNpNDlRQF5sXPlmP89?=
 =?us-ascii?Q?HGVPw3Jeo35JTB58EXGMXEnautgI59iah33JH536JrC6KGqxkeiZbHYBwRSP?=
 =?us-ascii?Q?SM/2UG9T0/MyUGlmZjnyV2nlzFv0jfR8HG7xo9B0BvwIrQvV8JPJx03tMKrc?=
 =?us-ascii?Q?wg6nHUQe3NuV8Qn/gmvLv5Saorxd/VaIw0VHSkSXdhiJMfDhBm+8otutoZ0o?=
 =?us-ascii?Q?AR1Ctl1OPRcLpl6G7Fuo9+UdQnv9u0D574kLlPoCzSzwmmBuu6+HWaD7XcWn?=
 =?us-ascii?Q?fMLjWJvfP9vHUCq6/WJ4yDSVHoGr1mBfP3/h6/ZfI9z9v9sZsd78eZW/ctuD?=
 =?us-ascii?Q?2vYcV+FGLDFq9ss6gWXe0rcwlBHUizKsBeGOXgwhIGsmHrCg8sya94Juhszg?=
 =?us-ascii?Q?B4NcnQB9dJsVYfI2YRgiM2tZhhMkpaoI6dU71XJvRIozLYmzeuDoVSEV8SZ/?=
 =?us-ascii?Q?/wVi0pBQnP89/6RqmH3BWgl67zVXBqmmIUsDcHTbmLbKnUWg2F0iSkBputFP?=
 =?us-ascii?Q?S0xr2s2QsI5AnaIMBlR0Z0XURYn+THUui99UNGyfN8zurnuI8MTRqw4x7rWq?=
 =?us-ascii?Q?r4Ub2BeyLqEAgPz2xrxL3HHN3WFKANWB2s2mjxIjX/YdMctBPwpgzbLCWhrf?=
 =?us-ascii?Q?JZPdfU5lwSdKWSh688ODtSa/U16GIxxKMHnWxKAC?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a733d79e-be4d-4e46-d7cb-08dd148da877
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 18:01:20.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbOI9LAISC18e671eOyTUYZxKdxZ2sHkaAlVltq3uSmioy+Fn1aYV4jU1ADhbv0UWEuoYHj0FSTWaLxhtIyP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3145



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Wednesday, December 4, 2024 12:48 AM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Long Li <longli@microsoft.com>; Konstantin
> Taranov <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; Shradha Gupta <shradhagupta@microsoft.com>;
> stable@vger.kernel.org
> Subject: [PATCH net] net :mana :Request a V2 response version for
> MANA_QUERY_GF_STAT
>=20
> The current requested response version(V1) for MANA_QUERY_GF_STAT query
> results in STATISTICS_FLAGS_TX_ERRORS_GDMA_ERROR value being set to
> 0 always.
> In order to get the correct value for this counter we request the respons=
e
> version to be V2.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e1df5202e879 ("net :mana :Add remaining GDMA stats for MANA to
> ethtool")
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks.

