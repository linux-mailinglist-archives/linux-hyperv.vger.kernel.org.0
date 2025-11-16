Return-Path: <linux-hyperv+bounces-7615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1EAC61D9C
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 22:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E55134A2FA
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925C26FA4E;
	Sun, 16 Nov 2025 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TdOVby6j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022113.outbound.protection.outlook.com [40.107.200.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE94D531;
	Sun, 16 Nov 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763329089; cv=fail; b=qGfP++XZK4QBkaTz52FzZ+4/TFnDr4nu2Tp2jzz/1j+7+igp7R1SBFzZseQuQcS1BrJ6gAEr28Pw0ba5xB7aKHs7QIARdmejVwHbtcbTUCRZb4/BazfQRtDFTcjCDn5wRfeXh+DQ1/m3yBOZ9AMeeivaGDkJfM7Im0JuTVr7zFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763329089; c=relaxed/simple;
	bh=lkjSueA2hlXD8NsSdB4/zrh6nk+fDCt32onwyNXvsrs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uC25r9qHoBffkVMZPfDAPtru4lamKv72FeoY+gyfvo/7ikcAj2cZqAirJhVWTkkXXverXz/g2cvqQf6Ly8Fuy9vWSndI/ODI70EG/wFe/QrQ6g0o6/6L7mZE/z3Apra+L7ciqFwlZsgn2LrLzZSIKXpgwGccRK1kwkOPlkZkghY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=TdOVby6j; arc=fail smtp.client-ip=40.107.200.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW3vfVb4aBBxr+PhJmC1nHRbFLh1wSGXDaH8LP3Dcv11zOuGUD5gj8xWCXiWQsSDz7vM8AEVufKsoqZCzAvikVYVVrsLQjZr/hsNfDzCkC6bXqjuddKgEAU8DxW1JyUYbm4ja9Rg7aYThnaCUq/BsZd64WPEh0Hrzbo1iSCY1LttcFx3XJ+3uTXvn3nckoo7dhzzqcSnyiH+2guONDNp/44MzxV8LYXpoSANdBNkEqXT/cdUtFs89gYzm+RKh/XUZf/H3SPH4F6soSnRQAIp3dNlsyFaKlTKjTfarNJ2xWcKsfrkOBoL6HSK/HZTjrCYqbScvyQBglofjPJVfRq9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkjSueA2hlXD8NsSdB4/zrh6nk+fDCt32onwyNXvsrs=;
 b=VBkK5PFzdX1kW/xXNR9rFZx50oxUNOxmUxLNWUx4zBewhEJZF8KswRw5LJwwNW1tuS9pwCAK36RILu/LLsO7JpJGrsi3DDZ5iAiCVPtBettV3gjGVFtpnhc0vUgu1hZ6tijhcM+RdOb8xCrP7Cogf8B+2pD6do18/tzTJto1SM2DYIQEq8wbj54CRkRBcKh/CSJtqcexfJzG8h/GSlIYj+UAzGRJhn+WBhlg0twPyIEmg0wfkbwe/gjSimrNOVid00pPsUixGyVSulKUOricl1PPyd8/u2IatFYX8iYafmze9POrfKE0zaCppZNW2m5oINYBkPqBpia/0rq7x+ptkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkjSueA2hlXD8NsSdB4/zrh6nk+fDCt32onwyNXvsrs=;
 b=TdOVby6j8tVF1gpWjznweoyQI7e4gprKFAFH8wbl9BLzRgQJxmBxy4QQF5E3jlC6CR4Rmr3QTgWFxGBgSbZfGdS7i+nU5pa9FvJ0/BWv3ZLx1fWLm1HIyPFhhk9qafG1R1l+LXzQRAm+URzsidSRXt5Q54uKCRY8fyNlVMh1DdE=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6803.namprd21.prod.outlook.com (2603:10b6:806:4a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.7; Sun, 16 Nov
 2025 21:36:52 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9343.006; Sun, 16 Nov 2025
 21:36:52 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"sbhatta@marvell.com" <sbhatta@marvell.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Aditya Garg <gargaditya@microsoft.com>
Subject: RE: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
Thread-Topic: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
Thread-Index: AQHcVaxhCgySp+i1U022+t6JrKe9ubT11q7g
Date: Sun, 16 Nov 2025 21:36:52 +0000
Message-ID:
 <SA3PR21MB38678841F708F1B85DD1E216CAC8A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
 <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To:
 <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=86cc2f69-77dd-4df8-8ecb-dd3704ef347b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-16T21:36:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6803:EE_
x-ms-office365-filtering-correlation-id: 87c695f8-6fae-49e9-c506-08de255841c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y0+btaAYOcWmmcAA7BoMtPN5n7wvNKxlpjnhR0z8l3FDg/NZ9xYdB8Z5ZGhv?=
 =?us-ascii?Q?tc+5r+T3mA6bdcCrd80NCps6o0ZktvTGDODeCS41NTkuMzeeWLqUyXHET7/1?=
 =?us-ascii?Q?RH05Pa8KQU81Nr0BMR93lYXreU2kfNEKcpFLly3AlBUkl1tcFK869j0Tf38D?=
 =?us-ascii?Q?Mw4uyosUaBZuIbrw9Y9rYb4mk+k0tStHFvq+J2bd0Y1rhMW1OBhEKqedhhO2?=
 =?us-ascii?Q?DnjYhf0UrOqvaEF3csr4aktGbRCRqRtFxnI26+uK0NK6aezdb1wu/z3b5vhK?=
 =?us-ascii?Q?KtKO1DG7oM4r0ezuqHA27KHhqUOUL6Ayqw/3+NBYmozT/33LgaF1KvP8YIgF?=
 =?us-ascii?Q?oQ5bQpKRTWJQGNM3rCd3boy/GWYVF3E8pO3WxG0SYIkJLCCiiD8oqsHJfN1D?=
 =?us-ascii?Q?S+85Nqbv+KB1sOH3bruhWpZ0deXD7T9Zc82BJRPwIvZdF/4JLzxis+/CC4nR?=
 =?us-ascii?Q?Uq0bdVboBc8o9tNSgi76MGi8Q5ZI65kNv3r5uujIImb0g8aOB0r3OZnSJm/r?=
 =?us-ascii?Q?29r8PhkqjiRKSpH4FS0BhsfbdFrKxoErKwog8nXqe5CDNc5wL5WQ31/A6JkN?=
 =?us-ascii?Q?NtlPyEXBHs3Fiblo8AGFIVrfv2pUL35LlSrSwPxu9OjzqS+vEyX2JWOqRAZR?=
 =?us-ascii?Q?KgQnaZIasD9MnwWLECoRNNG6CcAyKZWSRlDGjgKOvUfOWwvOhktzfnB5obnY?=
 =?us-ascii?Q?cXpX8OrezWFNO+UdG5OMzKQnYMVMJ4h/LnUfMJBeTEsomCEtjv0gevZyS0Bl?=
 =?us-ascii?Q?6MXNYrb0cY/daAKNC8TOaOzuRpuNKjy3f/m6VeQrYATBWWcjDmSmcT+NXBlW?=
 =?us-ascii?Q?VmpEpsTWjvzQxHjzXe+T7SV3aUSW0vNFlfJruDhTFcrvA64vAfLbNVbhT0od?=
 =?us-ascii?Q?FLnKBdU5Jd/ZO7/AH+mNZUJrwqqjCe49TOrulXXuARIRCyqaQvULfmnecWgb?=
 =?us-ascii?Q?dNUs/ug7oSajVV0NDyv97PAr2+daf2UXiuqTpfsNy7WW3Zv9ED6k9L76ah97?=
 =?us-ascii?Q?7bSKTtnwJWdxJjANs6Rkx848VJMQRC09hPLvAlsFWEaS7z8LlbPRuUlhsuVy?=
 =?us-ascii?Q?yzfCHwHTkLyOkH+1EVkXp47jEZqwJg0Z3l+RRFZtFsXxQdzLkO3zJPJ2PB7s?=
 =?us-ascii?Q?JYLOA1LsANwVn0nRYaarg7juAL7rkRMlv7/C2JuvDr4lDLpa1FeGVYa4/kDB?=
 =?us-ascii?Q?35AI8C/yWBmuO6Nl2GbbiTVdfiYQzWuM059jckX1sksggs8V1OgpsgPnXjLb?=
 =?us-ascii?Q?iP0s8tjJy3k4RDucZcLw2vHwoaWWY4us75j6E/6p9wKxp9Xv5bBlm3Nv6o2h?=
 =?us-ascii?Q?pvETbUL09h3Us3IR3C2Ti5AVHlwTOYLO3FzkJ+j25JtIT9Qol8kHemdtdiiS?=
 =?us-ascii?Q?SNlTchyLPXKYVviYk+8BdT8pYaRCpeRJWabDPlI0GldZO5l7yfjtCTcxADaK?=
 =?us-ascii?Q?0uHXBImOXUCSKtm2xQzCmfhXEtAQrALcBblnJCWUuHRnLADcdmVxXDt/PiR2?=
 =?us-ascii?Q?sbiCKlkj+dfH0qpbNAk6VQ2ub/wxIuY2wDFNvUKYRcKmD8uW7ZKIsIl8Uw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+109KUV6L4BMTISWA7jXUMWbL+ZBt051ebNnnmtlKib0DE0V2y/eXJhmYygc?=
 =?us-ascii?Q?F/i3th3nSUwxl6lUNUtu+tNAb6kcc+FZf+ntfszAdiVVgA3vBBxjsextXZXs?=
 =?us-ascii?Q?4NC5IBAWUdVe3jXgj14cSTwYkk744rkbeQC9XGjTNjRagp2HxEJcp1wnICdG?=
 =?us-ascii?Q?J5qW7bzjmH1UjTfDPxo6knwZj+glGoDjYvsnmsv7PnMFdM0fWyWZK2S4ikmj?=
 =?us-ascii?Q?fVG+wHMsEIMEPrT9ON4QPSG9gYy+7a02CZSch7fEeUo4CfqGDOfPE4l6qQ8a?=
 =?us-ascii?Q?3K8jLe4zz3+4taBf7FMYSLZ2ssoFT475SEiuirw4ZbNbw5Zy0YVvCiR6F1Ne?=
 =?us-ascii?Q?UwuSO1ZAV8n5PntfniDkFXukqSHP1ZUFVtyZbL8F0HmQPH+KQ1qDuuQAXQ6P?=
 =?us-ascii?Q?uj3VTpcCytfSx5AueOWDndqr51AP80ml2erLwR3cu1AOdRa/QljG4AuiucWZ?=
 =?us-ascii?Q?tNuRdTmqdgBxvCHL97wHH9AzUZ1B0/hu1mIKIrGw+jylxlymfa6UHloQUUCA?=
 =?us-ascii?Q?GWTl2xffMiZLH9Cfr854Q0js+V91PY1LvwDAZ+tIj1bKrNOxVXuCk7C8vE5d?=
 =?us-ascii?Q?y9MB2EQp1uBs+y/e0X514XZXH47xqa/mULLmZ2aMGKHsSziFJpYHc+vbE3BM?=
 =?us-ascii?Q?7Jj+YpsrDBWlDdvoLk2+zjaAsHEg5Nb6QUY8mXG4Y7+UiXy33M0TUEJuGZp+?=
 =?us-ascii?Q?136NNyK/Pnc6yLC2GuXrpYhCghibIFSdUpuwq19EQh6K/jjKrhcjxgFoyWre?=
 =?us-ascii?Q?a2B5dFmgVtqMk0pgGDnVByhgyxAXExVEmodNtCIjm/Zk4T7MI/t2YELwatL9?=
 =?us-ascii?Q?6tP1+NVLfkb1leOlonj56QzHlQBqGrDk23yKH9BA0Psv7mz+hujWh/4zQ2Yg?=
 =?us-ascii?Q?tanu9wsmjO/7A9rdfd3ZSbVXm3JXD9BhTO+oUXng9DBEXs5RCnrv0AEyOzu9?=
 =?us-ascii?Q?Jx0tecNxUFG/YFpNQO6KhRg+xvWn2RnB3Yx2W/lPt/U4p9zw5yIya5X66Ic0?=
 =?us-ascii?Q?bYO4DPNpQMtf/0TuKQAgnBgkzJb2qDSXKPKrm3SnUGNZRL71YXnHOnooP8GB?=
 =?us-ascii?Q?OzEVps3HW2USy5q1SnBPdpvLUgKtsz9y+m9Vj0ywcfq5ZnVVkFh+E3WkFhwk?=
 =?us-ascii?Q?UTWijdQZ9ueebNVdNOtAscdCKTnCVUBKACaRtCQo1S4EH1hgTS06oubq5NCn?=
 =?us-ascii?Q?hrPDHMh501zXtKUK9rbX/drdd+kK2yXrim6LcoDFUiscl8/MKOpaNh/RrC86?=
 =?us-ascii?Q?4YLehtrTuJezEBq5SjZGhxDmodnbmIEhmAoYhRIDx4JrOEr8vAmtpp6XSqII?=
 =?us-ascii?Q?9d5JcQj8dq5vp6XyjwCkSED9r02bVDyRC5qgE88RW9VEludI4ospccY45aED?=
 =?us-ascii?Q?5gR3C5t67KrhHYQpFzAQPcOCgD6cAByEEvScRsvkFyvDPz/C5b9pqmgphTyJ?=
 =?us-ascii?Q?9Jl+Ar9IhGTFWWvaVjSFQJuoQnmb3ZB6HqIBuaAf8nxKMt3LHoDmvgVMmvVO?=
 =?us-ascii?Q?aCDtAVg33P7xj4Q27liO7OGyo60WC0mtq6WExgXl72r+uEiy1Ay4DVTCZvZo?=
 =?us-ascii?Q?9Ihbry0QRMhQamoqPERljFnoJutAfD4HjO3wC5oz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c695f8-6fae-49e9-c506-08de255841c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 21:36:52.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbfyV87XGlU5Ga5PrIoCtS0UoNvJ/KMIz/WMHxD9RAsSJnp4UBG5dCIpiayEo00MYzoU90Rnmbh3xjKlP/uWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6803



> -----Original Message-----
> From: Aditya Garg <gargaditya@linux.microsoft.com>
> Sent: Friday, November 14, 2025 4:17 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
> <longli@microsoft.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> horms@kernel.org; shradhagupta@linux.microsoft.com;
> ssengar@linux.microsoft.com; ernis@linux.microsoft.com;
> dipayanroy@linux.microsoft.com; Shiraz Saleem
> <shirazsaleem@microsoft.com>; leon@kernel.org; mlevitsk@redhat.com;
> yury.norov@gmail.com; sbhatta@marvell.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Aditya Garg <gargaditya@microsoft.com>
> Cc: Aditya Garg <gargaditya@linux.microsoft.com>
> Subject: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed
> hardware limit
>=20
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. Exceeding this limit can cause TX failures.
> Add ndo_features_check() callback to validate SKB layout before
> transmission. For GSO SKBs that would exceed the hardware SGE limit, clea=
r
> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
> exceed the SGE limit.
>=20
> Also, Add ethtool counter for SKBs linearized
>=20
> Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


