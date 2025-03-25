Return-Path: <linux-hyperv+bounces-4702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F035A70AD1
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 20:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3292188B1AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D251FF7AA;
	Tue, 25 Mar 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dr0nhdA3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020098.outbound.protection.outlook.com [52.101.51.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7301FF5F4;
	Tue, 25 Mar 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932389; cv=fail; b=co5KSwElwvBGvezWciBmqgytjtc43C4b4gxxSlJsxvJoRwuWz8tS+DPJ4Ewb3nn+oWjj7XxVbT/bv+FeJiN2sqTFnAn0IcKo38HMMjX0OFTiEg+g40hCGa/tl1yU7L0TNuHCb8ojWyP7Uus8iKTWPWNqjJvSs/oMyqRdvpHAml0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932389; c=relaxed/simple;
	bh=/1/xJbMh8IFg3aAZH0lwpWcxmW/IrT7qCSslijvq0eU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LnyyzyAAomYc/fQdLVpPTKuWNoF6J1X/w6MwTV3yDvoba9Sif0xDbppEFEz8pVZj0XP/ZrYfNid1kyTyuy8Jrs4ce7Ah5/wDeD2kafBnbVXfwSu9I9em71YLuER7IH0ql0xbFq7ymhp284AHo+6TCiRJtPEvBryo+UeaCWMY/S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Dr0nhdA3; arc=fail smtp.client-ip=52.101.51.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clvb/qAMj+tRwlrwRbqlnDuyq0O/NqUfIo1dzEl+1Gdd7CYb88FPJg86P86a3q8iV4lNrsGnNgn1UhJyFBdbflRTeWVa+y/wjdzzCHM7xiVdawEzbrq6Nv1UmXqviBS/b5ghBv/RUGb7UDI3CFYZmrHI8w5QAdiipqiajZj+Xv3lmfwHaNyQxQXThZG+RkC7R1YG/0ArAxyFui+EgKY/U8WZrANa3dgeRW5+ISucNwo7cTf5WSvn655UP9e1KsDi4varWlbSKlhMY//BHX+vIKYgtP54F+quxlz7Azg1na2ovtUExo5ZU665xh5tdvv720vKqne/Mft/G4F6Satr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1/xJbMh8IFg3aAZH0lwpWcxmW/IrT7qCSslijvq0eU=;
 b=kKPzeIlMRuKUfVs5L2rtvQUzbrOlXjQxBfSTaLyLh4BofdSuR8X9Fc/WlXlvwyuDkZ2xfvm1excNANC/v4vViHqAk+c2rDQ847l6J6yqFeUjPeTjDS5nWpOJRZFYlSLvqgd9AYRoiKDOhTX7iEXpBBzxwFj2zgK5cTxvTakeRmTvbWi7N/AvRRkYvCdLtWT8zblBtysK8wwlugpXhtodrXNdj5bSbJGWEeYLHDupODStLp18IGAFHiLGnQCBfr2rb8B2v7EqTIz4z7UgKOSXKosfSvFc5xuL5tuh94blFm9qbbXvqmazbmO0IDmTXjcDsPz5IeItXAEtpyj0fmK7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1/xJbMh8IFg3aAZH0lwpWcxmW/IrT7qCSslijvq0eU=;
 b=Dr0nhdA3Eafwe5jfhyHJbHlLqyEb1h3jfoUoUG7qETaVsLR++MYfJ/BHSGJY3uEXXqdozB1swingA1DqGuGH2hm8vhjryjxkKrzs5xCs2fyFPE9MoBp1zrL0EBestcYd6HcBAng9q5JEbcMMx/Dc6/IbAU9DiSElRWDt0fJb3C4=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL4PR21MB4557.namprd21.prod.outlook.com (2603:10b6:208:585::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.24; Tue, 25 Mar
 2025 19:53:05 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684%5]) with mapi id 15.20.8583.023; Tue, 25 Mar 2025
 19:53:05 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "surenb@google.com" <surenb@google.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"erick.archer@outlook.com" <erick.archer@outlook.com>, "rosenp@gmail.com"
	<rosenp@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
 set_link_ksettings in ethtool for speed
Thread-Topic: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
 set_link_ksettings in ethtool for speed
Thread-Index: AQHbnai9kkA9WGlPSUyCoOvnIZFl4rOEIhUAgAAY2ICAAAdYwA==
Date: Tue, 25 Mar 2025 19:53:05 +0000
Message-ID:
 <MN0PR21MB3437DA2C43930B08036BB146CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
	<1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
	<fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
	<20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
 <20250325122135.14ffa389@kernel.org>
In-Reply-To: <20250325122135.14ffa389@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c1fd6163-647b-4bc0-81fe-feeef0037a5c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-25T19:47:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL4PR21MB4557:EE_
x-ms-office365-filtering-correlation-id: 72b17fbf-3136-424b-67e1-08dd6bd6a886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AVACTZI1ZoqZEDyo7Wnrc96EnpaHzJCx7VAXvBWC5TwjNERm3G9pJebx6GA4?=
 =?us-ascii?Q?Vv0IpJpJBY1e8xqB8IyITE/eBUwrsggqceNMFpbmts546BNjWAdZPPzQQzp0?=
 =?us-ascii?Q?Y6mwbFEMc1Fb4zvQzOBNoKFc6m4uvgNvLFhuiYUrsWqw78PJz9v5hToUMylY?=
 =?us-ascii?Q?9PmpFRI6pSbhJaXS9+6b0voQdQhI1GrNbfc7fzH/QFqSdNdtmIOwYQL9vT75?=
 =?us-ascii?Q?nmIqsLR1NCDSf5oj9mOXSRbW4jCHf3qbwgCwp09uXSJjPhk/gWCn/Mym5jp8?=
 =?us-ascii?Q?kBijcJo+CSNjY7V3u0sWuWlDtVgyYdwxf4h28bjymKF7SGcRi+W+4DP1N6H6?=
 =?us-ascii?Q?jHNxZT5ezz7/AfOTK2jGfRIXxwTEvOxjeiSY/n9hjUcGjbDSq81ArWLI/8Ev?=
 =?us-ascii?Q?VKt4h4xTqWbPQR5byIv+7MxJR8xRczwfgQiJQOl6NADIIxPB0RLoDM7I8Dri?=
 =?us-ascii?Q?OefkXi7lfbcU0+uSOV0fZ0cNgrENTF0Xbmw36sDtsz6cLnoK18qX05SfLvYy?=
 =?us-ascii?Q?tmUcuOOqkFgaNlodgMhtcB1piL84lUpAdCsd+j9i8QcdeGrrQfV/wEcJ5NC4?=
 =?us-ascii?Q?BPQrWFefZEs3nSw2CuSn+aOBrI3ArM94qfes25O7xkfxAKj8g70/X3zoBPlX?=
 =?us-ascii?Q?368pDQAbVmaWtwljBtcQGuUeDHJOK+KRWiDqQu7lEScG6kVTfGNsAux7kUY2?=
 =?us-ascii?Q?5eFU0Wf9y1wjY3deldiNWYJ3m+AACqLHS5LK72LNDgaYLfvZNTFCN8UpBj1P?=
 =?us-ascii?Q?64C9+ls698vgm7c8P0oxMjHnGedy7t8uFZLtFHNYhBcNweBYQTVssrxI2RS7?=
 =?us-ascii?Q?bnagzhGg1XlgIBYOCjQQrSPc4piRtNVlb0P1H3fk32ak8cgOcPKFPjLXn4Vk?=
 =?us-ascii?Q?XPdRmURMn9fhuK6+talnZmszUZTchqkCQYFVu2crG26unJ3rp5N/e4sJcTI0?=
 =?us-ascii?Q?tWa9IKitSXf7IuvS8erMu9ZreplRhODYigWrBuv/afxOeVIdiBvJWN2sI5h8?=
 =?us-ascii?Q?DlF95GMCJXaJsdTAlVDMtU1fAMW9pN4Afo/SeEY1EvmJVpnHtfr33UUEbLDz?=
 =?us-ascii?Q?pZoGmbr16W4QZZ/lJdw2P57mGkmna08SfdPQ6Wlbf4HnfOaOorZTO0I9GgD4?=
 =?us-ascii?Q?DJCvLBuk9oDms7oIlu0WecWf+ckcVV1GotmgvuJiPXb9Ce4lhgx6PRlX0gL9?=
 =?us-ascii?Q?2RITonNrpkTb2LNBh9M97STYXkJPVhXwBjyqvo/De3YhqUI05zqjjfh0fdby?=
 =?us-ascii?Q?wiDRuqZDZ5esSoeVKTY74m+t5wDCZWC+9MAh2exySRjJIDRWD0OeFJhpWxCb?=
 =?us-ascii?Q?Ffxvrj/BngKXHKzZ/88mlx9rYTo29WXy/J8iRcEAgbcdwdfx2tEP+ZIp0/hF?=
 =?us-ascii?Q?Gk49efkmhWI5ev13OXDj8vm7B+XE/h4q0orM8IrgLQc579NM7s2w0X3fG/6y?=
 =?us-ascii?Q?pmIfyMHBHW6IRdAU9oGs4+s6C7P3D3LJhtBnDcHU4IIwqvTkSS38/g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f9OVZkaH9d0tQw+ROJ3w7CZdTBY9LR2Ky97T77380zX7nZvlbfVCgOTK+5nc?=
 =?us-ascii?Q?ip6w+RVPXY2e+zk8h/GD0hVdi96U0qIZzvzfCtjQwMdqpE4BKwazHhloQmb+?=
 =?us-ascii?Q?bM414T96n6DHdwzUTC848H8JfmJULPPI83+l1JbOLNYHIjJD4zIiyCQrEYdt?=
 =?us-ascii?Q?taeqB1wKqrM6J7y3whjarzJDOi03YkvtvE0eU8WGb+tX5vuZEd/03G9aswis?=
 =?us-ascii?Q?4uxE3foTn9iosFXwgx0XH+SBtEgFpIRT+AwTOQ7B03+osmnwsLDfKjgByZ2K?=
 =?us-ascii?Q?+3u7kogRBLU+23aiJEU0SIpE928lAyH4qxKHP0DBdxbQFecfAtgfADBhTeU5?=
 =?us-ascii?Q?22aOvyYCtelgmPQ4XQmScLybiotgHocNa5BAjB/+HZehdzXWK2La24acuHMl?=
 =?us-ascii?Q?YtWQw07cA0FjY4NjgZTceUnppOqnagNcN6vUFyF3Vr9iNMzJgEi1/nBv64jx?=
 =?us-ascii?Q?Bj0N6XxOtKw/0ita5mKHcDmk7admF3Ue8Ui+O4PTIHTBpMC/11R7I1lPJguC?=
 =?us-ascii?Q?nyY7rTbuFA6qRQvv3wWK+GXy3XrmH2QnVxICubp8Paq7mf1glGIKLlmYryuM?=
 =?us-ascii?Q?sglupejZ6BJOwAN3+tn0WtshJo2fhnrgC7dRiX8hyZw0vNOx7i34r/Zktx18?=
 =?us-ascii?Q?0+vJHBuXlSV0iX91a3qpiXUM+OfuyUvMD6+llCfuxqOuD1oiRIbMDnM+qgow?=
 =?us-ascii?Q?GlPevmkms/9h+E0pAlip1vIsQh9SIybMMRDVdq25Z+ROY2QFm12YOs5av3K3?=
 =?us-ascii?Q?1WMcZtgfpdlCYlqtutIDwTl7RvqP/l9zls+5LBruc4CR8zYxO8aqwwLNOjhD?=
 =?us-ascii?Q?kDXlD3fLXq2/IwWSObxY3x2BFmmYYnj9NO8wO/Q7P9cnvlOpZ72OAZA+9WZN?=
 =?us-ascii?Q?e38TQJMTE44B1s5w/0sBAYZe8NsEJX5dLd2Zj7Gcnr/S2GRti6k2INQxjEV+?=
 =?us-ascii?Q?SOjSbzXgfpmlDFaxN5IyrluYQKNUkYHDp+dt5pbahS3agMXktsb+lRDNi0U2?=
 =?us-ascii?Q?wYDzWWE2VNltMQ3mcFZkhKQSIS/9dNT62Y9/OAbMdWMTmByyFD/TXlu3kb2+?=
 =?us-ascii?Q?bx605tN0BXQJ/rkWlGuFISTRpONj/Tl+5Ba3YOPoH1Q+8nLL0o1ylxGG5ts8?=
 =?us-ascii?Q?zluv8d/XcrMOquxFde0Y96sW4LNbh953JI5qdB5zkDf642zIOYS5ltiuoHWy?=
 =?us-ascii?Q?THnqUHM/MjBKKc11Hx1MT0vMqKOj8GA/Mi2VwGM8iymPUibjSvq0sdqofrtN?=
 =?us-ascii?Q?xrENFO9kI/JCB6zJjaN43+lBZh469McMkARgLi3lfxC3G6RcPTibel+Auo1I?=
 =?us-ascii?Q?RpU3slqUMXbyPrRywvOalZcwOjWGABJks6WEi3ZUH21tttEfAzCtoe1ATyER?=
 =?us-ascii?Q?XZyN3dNnXtxcjDsvLt2FFmbNZwG2uEgSAYIQWh4UVGSzGEZPc60HmhPDM+bF?=
 =?us-ascii?Q?1kBvyWgTrnfPZTHBkgH9jwdTmo5AbZWUFOcOOsjsxgTLSCv1JXq2PDDz7zua?=
 =?us-ascii?Q?MDw8dqtBCTkcTxgw6p1+1q9o5ff5gMxtYrNQNM9PH635rpRQgkbE2iW93pbk?=
 =?us-ascii?Q?4FN06amiiVNfx0HVksXrlE5ricHhqBSY0ke5gUsx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b17fbf-3136-424b-67e1-08dd6bd6a886
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 19:53:05.0737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: driUTbT2tIxS2H6nifoIedRhHZIMrtNYMWOI1hpsFVxcRI4tquum8rRfwS6XTzdiGGsXnoo1QV6IGfxEuQ0w6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR21MB4557



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, March 25, 2025 3:22 PM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; Long Li <longli@microsoft.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org; brett.creeley@amd.com;
> surenb@google.com; schakrabarti@linux.microsoft.com;
> kent.overstreet@linux.dev; shradhagupta@linux.microsoft.com;
> erick.archer@outlook.com; rosenp@gmail.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
> set_link_ksettings in ethtool for speed
>=20
> On Tue, 25 Mar 2025 18:52:40 +0100 Andrew Lunn wrote:
> > Using TC would be more natural in this case. The user action is to
> > remove the TC filter and that should set it back to unlimited.
>=20
> better still - net shapers

Thank you, Andrew & Jakub:
Sure, there are many (better) ways to control/shape the traffic.

This patch is just to support the ethtool option for the speed.
And seems there is no option on ethtool to reset NIC to the default
speed?

- Haiyang




