Return-Path: <linux-hyperv+bounces-8267-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D83D19C04
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 16:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB092300CA38
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA402E8DE3;
	Tue, 13 Jan 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Cf5hmJCa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023139.outbound.protection.outlook.com [40.93.196.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FA210F59;
	Tue, 13 Jan 2026 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316959; cv=fail; b=i7JKor9bP3Ppd0sMjE984nAWSMkkpjHo7dtsaGl/07oYzMl1enO1p5X8wHiCrmLkJhcj8lUbiHAxcp24V73FP6KM1dQADkA30/FyR7fG1V5J9DWSHYsLU90ImYoZ5oyb5sayi1QEbYM/O5oOb0MEft2DAMIDZEiSuByv96kHowA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316959; c=relaxed/simple;
	bh=GtNCLG9sIAvj8ipVa263jpKEqH2WzKPasTecKlpdIXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mBhSZzMni/v0pljj9ydPV7yNVLov9taMxJxGJVWxvJTagFRUPJb1NDkZM2UoUMIoNGI+3DGVm3AUzMZwZprHt93biT6oV5ouGqU00z66jkM5EL4OlXo4J6ZMwg7+V//JeGd5QZuhLAtydghZlFfY8HzeiAMOo3khK+9ZlPL0kJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Cf5hmJCa; arc=fail smtp.client-ip=40.93.196.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJC8we78m7lqv3+5/XLirgKw10yIBVl1BmvZdftj557EamDCCtHImlV2A1Uxjr1SaeVB/pHEvQ+/T2JvBI+8GcXB/3f5IXuU0LxO30kJ21FC8O9nH5DG15hssvvzZHmyk0tDSuzx6dm0XXnUmMHs902GUwAykqYBQk5oPf44SAOUJJES6Wz1F9wkSyctHUBD0RE4ObgkRSdcZq9J5v17LtIybvKrrVd3TDuv1eYNngvu4zoKz1hQDtaIew4OpLbC1h2jyHPQnTLF0maFbTPob+MxSAW8nKWv8lNSP/JYDg7xrkeRRVcfK+Ga67ky9fk1jIqsj9m42u7pO8Vs7OpVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUv/5YHuwsuaoe1vXlZIut2HoZN8FU8kxoKhgqWyQu8=;
 b=Aj5FA8oKDgeZBTsaAnR1sI8Z8lXmLQQvvKs9VRPBU3Y7B0hXxf0SHhu/1M03Og76Ep3LOwi62XSMJ9Oe4Cx2SoIVjcgopE65VOZVcQ6yq78ti+gYjXdzHosr4Be4tRxHvo7roCAv+LQLP1sS739HduelFaxO+4KLOJaQFOKZfEXH4ogPhbsBN2BHuGxHb6AwctmQ+pVCGY1+GkdX8miVpOIxEzOPyfjDrZAfGFFx+7ZmGHQlqKibQi6vCOoC5CzxQ0pJG8NOU96oV5BvTDbgwKQl+7z8zFqLL+YgcxxPdoZB7o8SbSvRqp/N4wmgaveO5dlcNfMvOTMrLVfdqjVbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUv/5YHuwsuaoe1vXlZIut2HoZN8FU8kxoKhgqWyQu8=;
 b=Cf5hmJCasiu2yKWW+kwh++jaHWJ6Y9IxOMLgClfZHxWce7b9S59xki7KHzYsE9pWVkvGAWsxHBwfhPKDUqxG1zt10VRh6nOHg9Le+XXGeIKPuL+nZgQqwWQKY4CBLQNJbtCsQd+bBVd2bW2UpHizGlVgWJpKi890t0koXd0Hz2I=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6825.namprd21.prod.outlook.com (2603:10b6:806:4a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Tue, 13 Jan
 2026 15:09:15 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9542.000; Tue, 13 Jan 2026
 15:09:15 +0000
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
Thread-Index: AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDA
Date: Tue, 13 Jan 2026 15:09:15 +0000
Message-ID:
 <SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260112172146.04b4a70f@kernel.org>
In-Reply-To: <20260112172146.04b4a70f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c47e728f-c9eb-47f5-a22f-72e8344ebfe3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-13T14:51:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6825:EE_
x-ms-office365-filtering-correlation-id: 114e0e0f-75bf-41f7-3d1f-08de52b5b76a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uaI2odR9srnNDksoVmwdOCMbPiyk2Ct2V+qfd4DEBQoT0SXLGKNYos57u+9u?=
 =?us-ascii?Q?4kI7co0TupCpBBbfotwa/LYykgg79NN8UxA+RiVND9g1Ugr6vBwjKYwkySTG?=
 =?us-ascii?Q?2cwJQ1MpbrbFdjIFzx0ziAZii2247IDRX2/7CUYDR+Wbzsm7XIbMh5W9dT0j?=
 =?us-ascii?Q?9gS8YZtUD9EBoRCIarS3MHuHZto5bWoJmIH2xoKyljvKJ6/KaMYo5zLQCsa8?=
 =?us-ascii?Q?oA5Vp4sqZNJhZRCzxNjkbDcJFykrVeiqzvDBTLQnZ1Iuy9wg2PjmuIJ1Qc4l?=
 =?us-ascii?Q?7+YB/XkXdLzaYg1GWhB/s6lf2odOsUnSq/inyNLxgxsvtZGmxPT9GdTYXOJ9?=
 =?us-ascii?Q?uJAMaY6foFOt5ipxztcDUO4IN3gmjkRF3v2tu4SXTMmSqOqjc2QiN/+ojI8N?=
 =?us-ascii?Q?aXRHI54anqR/0zmqtn5UZlWLVYqzIi8hvfaAUdQG5KOJ2ji7MK0x5SwEjrVP?=
 =?us-ascii?Q?02qLHMdgkMIP7Qk7HluPrU15NSyrGhq2khDDYgcqQgfQm5JfU10vCJXfuiHf?=
 =?us-ascii?Q?k48FfBJNH8eeOMGGnoAW4geDgDE2URcW3NuSRxgaCYG3nrUfknbkujLFMr6T?=
 =?us-ascii?Q?Bb8MoeLB/YQXDow0FX+qR4R0AMi83G0PODZx73x5xdJsuOyQGZq7wawYf1ZD?=
 =?us-ascii?Q?wEX/A8bJoqsqH8ypESTeJCi4e/Y5fXFRRfPsp0GadUUt67IJF2MdUzx+y+52?=
 =?us-ascii?Q?4cW8882esav9sqUnfjdlAJgba98KdUugepTqd/SXh7Mvptejy9CVqkVpws/U?=
 =?us-ascii?Q?oANgJFM3EAB6cXMoKYVpe6EQWsMiVQckvRQzsJi30TuwKi+ypJdNPQRHOHu3?=
 =?us-ascii?Q?pt0LMijPtrdIma5QRYPzLSjwr60dw8hWTeBLaj7f9xPSZlkUI+5O6yuspU3r?=
 =?us-ascii?Q?tDH/yQ+ZNCZUYJIbxjx07+ETduvEpTj9TXLj9CQ9piEnh9qAJqNFUWAMaw5H?=
 =?us-ascii?Q?hCmcGyaJ9LKQ7NaOLG2xJ17DsD5Tq8XIheoGKw70M83PfEwqEF3IXvfXE7DW?=
 =?us-ascii?Q?uz5qAv1Pxwcze32cgzXWrMVgH22ljAhePa0aSmv7ptAGejfo6MFHODPfGD1n?=
 =?us-ascii?Q?UqLrIOLbX+CUJ5qtfhDHscf9g39ZOplJgW+Sfv2u2s1QtvMnf464U2us29W4?=
 =?us-ascii?Q?psippnhjm15tNUhlRx2Fftooh2RaDvYfSMU4gjVLQOvPMH81UXayMErn35+i?=
 =?us-ascii?Q?sub+sBl6qPCbtre9QCKU1V86GCwdxR1jREaEShPwcdPw7MQxSnCv4OjcqiKL?=
 =?us-ascii?Q?7eOCLnz61HKbGupNXhjEKWRAyrYafpYYZOd71nbUN8SxycP4O9YjxKgt99P1?=
 =?us-ascii?Q?9lDsq0SWhv14gi7WWch0g+0bYpFhvcFay5x3jLJD0/kvaayFXvFrAzRu5irY?=
 =?us-ascii?Q?HEnkzhyiRQzjry9aPTsVRARouCU2rec7QdQeTQfcNG87yWcoYzgTQP+hHNtZ?=
 =?us-ascii?Q?BRgYkJc/TybIcGSnqzbWV0+gKeaORqg1pvwLqZO0E7YB3qASonzLFZmb1BxS?=
 =?us-ascii?Q?0H9f3R2PFa1iByQjrMgL+3bFsCl5Wh5DGIQS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2nhaR8Gex1wx+2rkuPRkZd8IgTOARAZrjgtNXmEInv8ovLxgZZT3AvazsJUh?=
 =?us-ascii?Q?HJDAAJ37vlEHN/pEOYJjuEU3QHqjNeE3Qi5OLIqt65EaVtSU90ZXyXWSSWHM?=
 =?us-ascii?Q?De252EhVv6xjfuBZXzwQCOPVp8rGb1aTzRU0j7GBQeL2ek9jcQBohG7kK5Ie?=
 =?us-ascii?Q?yTyTEcIdYYKIOl+vH+18RBlInQ8cP6JUmp5U6t+lIUhmpfjOBsDR6KtgCeM9?=
 =?us-ascii?Q?LjLIk6yBFLXixWPT94gSOPokEv/1ewCe4PFyfhegqdGwfeIkZvPTQD4z9KEI?=
 =?us-ascii?Q?e718E6Hg3aIpIfeypvdFhpK/ZfmSLFAvFsAmt98FabAZXd/be6YeQU7kMHQi?=
 =?us-ascii?Q?x0SRM+JLVtgCyMY/JKcCfWtEVXujHHonLfVo3kLlljdK5hAJJfPTKJ0HjC/W?=
 =?us-ascii?Q?wI9SOKppHjrVAI1ZzaOfIU6wpCyWT87DMnvZ1VQHep+rYnFNeaDQ5Wi/4Ryv?=
 =?us-ascii?Q?ac6pfd5q37L+LhwIO8h1NSg7ScHmT1jsgix8HRc6iFuOixGZwN8S2WVIubVo?=
 =?us-ascii?Q?2egc6dywozo6+satsWvZ0pDeF0VyS1MCE04HqOZNAdsBfuDrU6Wuse8bJxOt?=
 =?us-ascii?Q?4mqGeSQisSLoKOhONa6Fa2mpbpImQ/1EyEC+ztcimlFmjiGDslAL706/mye3?=
 =?us-ascii?Q?Fx608+sHMAblNchbN+Jx1YATfsJRhd6a3uyqDjn4o0PJezkZ/u7vYBn7z92B?=
 =?us-ascii?Q?Ft84dNtLO84EyytqFWvZBDx1OSrEmTHBPQWm/z1s4+o+hKE6DE0AWctt5va6?=
 =?us-ascii?Q?D3VETSRjcejcSOXCh0AH+ecJKRZK6BWzDmRPx11wgBxOxjkuguYzMFvCdfXb?=
 =?us-ascii?Q?TIzA/CntUJIhcF5IC7hFCRdIESA/4BmkUTEjCLebkL0oeFVUxI1kIbnaQEnL?=
 =?us-ascii?Q?AEZs2ZwBvuWYiC4j+/2hsuEvn7K8GKwv94GMPCvLMrPh2gs+hhXYAaafLAyC?=
 =?us-ascii?Q?cPa53Y9dHAcxQjrjMf5tR+fJRqIHzlH7bLVuBCMrY1wQ7GVc8AqOFP/a6OI7?=
 =?us-ascii?Q?i9kLuO+Hd70VqiuHiigE5Tu96b9FvuTBb7Slny7IErtUCfCwwWqMlhu8s4H5?=
 =?us-ascii?Q?qhXher92OjTrhRKSIBwVBvqiIcvcmqlj4JT4/LWgFWusQ9KujBElSdYFFqz4?=
 =?us-ascii?Q?iPsqZnbOk4y9tMCB/wanJbSUI/YAe7kIXtbp7JNr4x8UfxRlGPvftyltYec/?=
 =?us-ascii?Q?fp/hxjZgfbM8tHFKWMvYzYUJ3tgJ5wwnLEpt8Plin1FwCpTvqIKyDcF9JYrx?=
 =?us-ascii?Q?wOokMxv/oNRDrmjPWNcqRPnZEQ9lTkY1bZzabrV6uUYPusMbz0PruiA6MQsw?=
 =?us-ascii?Q?QKlyHNA/8a2dokcvJYt0MItFVf6UnJhrudShUyMX/yFaq0QS47v5tdCm+dsf?=
 =?us-ascii?Q?TuW4swfoC0TXNA9AINUi0t6GkBDMDC8o4SaSGwxRiu50P5jE8QCtUfFGZr1g?=
 =?us-ascii?Q?h1JDP+5zVh4Xr3C+fOq9oaZKQuEFHgbxAhDFgzU1KIg4+ShuVJIN7GaR2No+?=
 =?us-ascii?Q?CE7PCNv8/Dbx0I3g07MFncrdKuV2IgV3FKHMXDSBXKLCL8P3RVurtkP48if/?=
 =?us-ascii?Q?/42Ekmv3yp0WNS8d7Y7TCAWry4N6/XKxvH1IRLvicl+XpAGH/J5Aqgjiu7Du?=
 =?us-ascii?Q?eaKoM50QHiB3uf0NaeQFPrOlVR2/0H90uALHW3lyvO0qaDd+EVnrQqq/Hudx?=
 =?us-ascii?Q?RBoWCGpYPe+iRkaYYUWOXlBoskuBBpp+mZsGeaEtdsicQ/YstT5gnE5UO6Eh?=
 =?us-ascii?Q?Vl/+D2EThA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 114e0e0f-75bf-41f7-3d1f-08de52b5b76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 15:09:15.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKEs96HZCN6h1hTUuhg+cqXWAUA5Li0gP+qe0xQqa/CuwSJjPXvCfE773++sVWxVgkU7fqH9ANlZdtdBRBQVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6825



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, January 12, 2026 8:22 PM
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
> On Mon, 12 Jan 2026 21:01:59 +0000 Haiyang Zhang wrote:
> > > > Our NIC can have up to 4 RX packets on 1 CQE. To support this
> feature,
> > > > check and process the type CQE_RX_COALESCED_4. The default setting
> is
> > > > disabled, to avoid possible regression on latency.
> > > >
> > > > And add ethtool handler to switch this feature. To turn it on, run:
> > > >   ethtool -C <nic> rx-frames 4
> > > > To turn it off:
> > > >   ethtool -C <nic> rx-frames 1
> > >
> > > Exposing just rx frame count, and only two values is quite unusual.
> > > Please explain in more detail the coalescing logic of the device.
> > Our NIC device only supports coalescing on RX. And when it's disabled
> each
> > RX CQE indicates 1 RX packet; when enabled each RX CQE indicates up to =
4
> packets.
>=20
> I get that. What is the logic for combining 4 packets into a single
> completion? How does it work? Your commit message mentions "regression
> on latency" - what is the bound on that regression?

When we received CQE type CQE_RX_COALESCED_4, it's a coalesced CQE. And in =
the CQE
OOB, there is an array with 4 PPI elements, with each pkt's length:
oob->ppi[i].pkt_len.

So we read the related WQE and the DMA buffers for the RX pkt payloads, up =
to 4.
But, if the coalesced pkts <4, the pkt_len will be 0 after the last pkt, so=
 we
know when to stop reading the WQEs.

Thanks,
- Haiyang


