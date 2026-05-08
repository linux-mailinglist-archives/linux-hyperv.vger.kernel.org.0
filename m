Return-Path: <linux-hyperv+bounces-10731-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA6NNvln/mmIqQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10731-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:47:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336AB4FC742
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D192301176D
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D238A713;
	Fri,  8 May 2026 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jH2LNa5U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022092.outbound.protection.outlook.com [40.93.195.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858E2D8376;
	Fri,  8 May 2026 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280438; cv=fail; b=tK5YfwdnNjr6tHMSb1X5p9Tg/pa0iNxUcNUhUwm/M8QYUENzpD/9JEtKfMSQxGLk3UrLRPIhpYLKoHyB+h2aAyHTOrzFGT6EggrtFSxM0qwpyPPmbsOKXjdVqm8jHSDZlNQ9ziAdJbnvXGAiAkwK2/HpYIhLFIVwPfeGw8LNGVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280438; c=relaxed/simple;
	bh=KOFjvFCfeS+3YegRpdEsH0XOWBrC5147pufYqNr4HHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzFMYUY2JrG+d5GNrJiSb2+6rX4w9SfWCTnHweMpSfUPDt8KKsBuVNMGBCmTTgTzllN6fLImvEfhmewlxmJ8ZeUh9cvmn9ja1V4SC/ehrHkekGPwGY+Wnkkk/Dn0PnRKwlL6TADZYsjYrcfec30+ZkwfUk8djAUWs53dhRsNvmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jH2LNa5U; arc=fail smtp.client-ip=40.93.195.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlQez1jr/Rz2TagfsA+FdaEnuKP2UYnXoc6LrVL2bpNRdmAl7N+tHb0JVBYSdz1amSu/Qk9uGXATzCElTH5pIczEeo6Oxk6W+DJtvr+nXmro7GQUSqj+Axoy1oYnh6eRE/mgyzk5+DmFPDiQjMaVODIwkBp4Mib/b58fnOoFjmsGn0ha2fTvKgbTISrmaTa5RmYqE6rQ4NfqiuDxlkr79T9DIuFhZV+7ZjGqJdKfC20F5uanu7Z5boKoRiA9VjzrzRDoA6ecX8H4yo4gmWRrI1cP87PTPAFV8/YVEueiAr6WDkGNYaHKOU5d70cZw33yeWYi8HxDuIKCsN2r/crVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nC4MzrjREqYJpnAivNDrnP2XvAwnMyNyye+XnQHbvA=;
 b=IzNC/W4oEyCM6Kb5/vPBz5TJ3ZqSYS9PfoJvSjVEx6P/2z1tGE7sxgSrVSlNokZK/XJuMjP72MFgv29yhiBRX7BttEN7EhrVXDBAAuCmC1lVrnJVtlt3+BYUN1HKQD4sc3AmWkyyLM2dRh/JprSw75KVMHL+iSaqY+Oa+RLicjHfnUV58mOFwayAU6KD2AmwLIucBWQMrq6Q5WRXPBbwMxSdowDMMAbkrVXwkxtMw3h4uZq3ZDEEZHlQ90ovv0yoSjh2iZYxG9BVobIY5Wf7t4Jj7nSmzrddSS84azUmDz3Ubug+vHHtGWJInpxQn22o9/Q4LXHAMyOezo6+dwgXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nC4MzrjREqYJpnAivNDrnP2XvAwnMyNyye+XnQHbvA=;
 b=jH2LNa5UJlJDib8nQTXy9tXW86GpBR1fvSIqxH52FlEfrWg9ecElC6H+nkWlwjC44X7Nbxae/atGpI9BWrhsbRdKAY15TqY5wqha0zYhQ7KNiQPhke0Ung5o//OKgaKkh/IZ0L4q71+xAy4yZ0QbfTA8orEY2WoNJBiMEXcmcQU=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6897.namprd21.prod.outlook.com (2603:10b6:806:4a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.3; Fri, 8 May
 2026 22:47:14 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%5]) with mapi id 15.21.0025.008; Fri, 8 May 2026
 22:47:14 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>, Paul Rosswurm <paulros@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Simon Horman
	<horms@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
 configure
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
 configure
Thread-Index: AQHc3zanDnHpDRX8iESldsM8tK6b87YEuBYAgAAAorA=
Date: Fri, 8 May 2026 22:47:14 +0000
Message-ID:
 <SA3PR21MB38676896F76FD9C27127DA87CA3D2@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260508220412.15138-1-haiyangz@linux.microsoft.com>
 <20260508223732.GA25113@bhelgaas>
In-Reply-To: <20260508223732.GA25113@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: paulros@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5cddbc71-fc09-4e0c-a9d1-8a9374a0c66d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-08T22:39:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6897:EE_
x-ms-office365-filtering-correlation-id: 285a6759-59de-4d0d-ee41-08dead53bf99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 1+Szs5EM56wCVaFcqFbM2IWuNIJN6lRzNsGB+XaomcYP54XhQQh1qJuuC2LI3TDoZG/4LYLT1rokmWUZPOwrX6ZSPaYCdKDVP9zHCsc2Gssa3EhNnTROyt5FvSjs+Aa5eNYl0qoespflmUsior9ftCqnI8BWA5DLqGb6HL87kOuVs5hzACgH+JVZXbMOCfexXiYa6+Fn8vINhmYLB9cI9U/1ibD6msIi2UBIZLRtSpnyWtdnvppS17hvCwL6luoOn1hZFBzbqsF4jOuBUWlS1BOJxacEb9UzZBnbig7axF4ukD3LorTHw0svKAnAdLMI9o79dx5Fuh5X1F6ckUpZxmZ6StX3UAkUIAxbi3og3fzcc6VnLxnro57MI5WHf2tUh0L0u8Xu1lmzhXcU4wKyi1cTVNumQH9SzcIBsfFvC0QFOK7ehpH68THfn9LageNxEmMPm1xCpDN2z5EqH1ofgjmXKETW0EPFCgstBzstdamcPk5Nn3GBKgKANektKvnNEMnHt8j7F9YCQN1gzVf/vjSy5RMiSWOwg3zvwEWnNKedwBae+zgcT2FMwzz1PrODNhhPdmPKTQsyrievung9Uur9Srhraq8/i9L8Xza/d0pJNsuvksbJU66jIt4R6Nf91TsBOGAzrQX99BtDVixp1jgulrdjyZoy5XYEJpjeqJr8wi5xTuriFACHhJ5jYzergdf1sitY1hMRH2qt/JkoeeTKF7cz1I3CulWJ8UHBTOZjYdcZyxlNoRRcCcv2mPjT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2vYomUWc8Qdsvtd1Et7yINiAgqYonvwKZuePj5A4TOB70k6Wzj4tks2bmdD0?=
 =?us-ascii?Q?PwmVtfqof6Ol6LlxMgvhwv3Z8iBEDrT5l0A0MLLKfh6o6qUrmCfuBsKocat8?=
 =?us-ascii?Q?JbwmyNDvkr75q2V4KWcMH5sXgj4AUvId0TVRIZkF8pxQHv7nVU2R5enKDxFd?=
 =?us-ascii?Q?4hktYyLJDIu6L63gVSUYuaAIJ1xpVZQnPcDVHDENeRAMHnKALkrb9MZJ0y+H?=
 =?us-ascii?Q?Iy4yCZz42Rm4fGfQwQvVl/ne43foFw3bYhCnxOtuO2LZv7sqO/yZ5xJMxZ8w?=
 =?us-ascii?Q?Slrqp251a1kdBTtiAkQDeZEO2w/tC02QGqqLygeBpEVibmtXR8cK+ogsMm9f?=
 =?us-ascii?Q?9xE1mlyCTvtJPxPfIMylAJjHQ+1BTo+H9EBh/+JQgvm+XAukLUtq3u7mKaDu?=
 =?us-ascii?Q?0zz6nRQxXE4ZpzXQw6/qIil8s0vt2prfDbkUTrRYkwteH/3OZonixPGZy6l0?=
 =?us-ascii?Q?cEO7+KZbonqIfG+6Ep/kaJDXoBdxujjgW+1Pe90ULygEt6W0WVoLBQzrgQ7G?=
 =?us-ascii?Q?rnW7pZ4JC5xG5t6Gf49Kc8pCHd2gEufS1F2o7tD+8RxITJNH0E7C9o9aK8xg?=
 =?us-ascii?Q?FhgBV9fL71oB1eK9OOPjPHKHlJk0WLvdJhqNHxMj6+O4kTyD5XNg3vRP8MLE?=
 =?us-ascii?Q?nmRyH1+PMbVovTwwJ8FF8pfqwXfE6bhI9QbggyhngspiSbJCuEWN72t1lkEK?=
 =?us-ascii?Q?i2A/nGIjmcHSEsay9uSdKD8C4iZ8ZNWImoehQ+iY3P7vDV8D1r4o5FCml/ma?=
 =?us-ascii?Q?NxB6V/jb9WaemQps6QOyNm7MdRJxEaXvMxA8vLkFXLFepcacnOyopkX3v3bQ?=
 =?us-ascii?Q?bsHgZCfV4D82qJG6tb210ZR5E7IcWlRTx1Kf+KGljyIkLYkotFVVst4XulhF?=
 =?us-ascii?Q?//0LEvttctK5eksS9qdqJ+25sarRZh5x2eJzSs6ZTZf5k/xh4eA3e5e1Sn4F?=
 =?us-ascii?Q?wuPVVKKjBV6U159aj9dI3fKy0XQWZpEa+Hn2x01RGu7HvONsNa+GzddTTGVF?=
 =?us-ascii?Q?+lEN3iFILmbu01wS4cTySePiEJjLwEjHRiXpYblKHbr42IMHU2TZoJxyJqyC?=
 =?us-ascii?Q?wqdRDyZsEYKIS1SwNrxDD6azQYeST/v2ROs+t6eHYR7PDH3xLkI9wBOLquST?=
 =?us-ascii?Q?wfSpt9Ajr5eC+btZIJiNSQckuI6yDRwnwO6yx9yl4WCSzdSxXCwIascMoxNo?=
 =?us-ascii?Q?gM8fr2l/BQln1azBb54YYEx6G7D84qAV1moW6jKEsJNT4EOqs0k5TstKuSdO?=
 =?us-ascii?Q?a0dXF9/sySKUEtXiyJTviEgm4T2mgYQCCVF2xXAO1c62S4gKqQ4N+pxbLGOC?=
 =?us-ascii?Q?fNLDjB8rfYMqkMaBHKGxnRnkR6Nob/r4uYogghWDsHKuGCENuWP0krGFLZoY?=
 =?us-ascii?Q?bnKSI0eiOsXWiT87wQJWKrxbndl0zl8M8xNT15fFoGiNPve/ZBStLySuio5j?=
 =?us-ascii?Q?CxVKAfqs0Xd1Wy/0cJJ/nZVjlJduqtxT6gJNBvkpsd/sTBnNW6TLGYITldhP?=
 =?us-ascii?Q?WtybzkgEKnNER7kxtp4Gd7QfPdLOoA8LhR4imA52r8RX74lPbFH2HyNO8WcW?=
 =?us-ascii?Q?+ogDZKDs/qZ0/D94DkyHiFrAyOOyEt2JSQ+rEhNSZkaKmDruJ+fLEV1kczr3?=
 =?us-ascii?Q?jNa5WN4HVk1yf9fIvPq1Rj7yxluTpary574VLeC/e30MyG8KvLY2nLGyO9iS?=
 =?us-ascii?Q?0jH2Ya9N8uPaSph2e6HxMIcKT5ROX8pg30b0Wbq0CXSfrqi1nKvDB9ZFhgl1?=
 =?us-ascii?Q?SXkyYMcDPg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 285a6759-59de-4d0d-ee41-08dead53bf99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 22:47:14.1009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVlT8ufnUhAoKuqPeSulq2tdpxuf9CxYOCiCu1xJ+pagnIWbiygGiGg/kJD0l/dbiPWtpYnMGXfdB1kPolEEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6897
X-Rspamd-Queue-Id: 336AB4FC742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10731-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, May 8, 2026 6:38 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Bjorn Helgaa=
s
> <bhelgaas@google.com>; Simon Horman <horms@kernel.org>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
> configure
>=20
> On Fri, May 08, 2026 at 03:04:06PM -0700, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Add callback function for the pci_driver, sriov_configure.
> >
> > Also disable VF autoprobe when it runs as PF driver on bare metal,
> > since the hardware side may not have the VF ready immediately.
> >
> > Export pci_vf_drivers_autoprobe() so the driver can toggle the VF
> > autoprobe flag.
>=20
> Technically pci_vf_drivers_autoprobe() doesn't *toggle* the autoprobe
> flag.  That would mean setting it to the opposite of its current
> value.
>=20
> Here I would say "so the driver can prevent autoprobing of the VFs",
> which is the intent.
Thanks, I will change the wording.

>=20
> Out of curiosity, how do the VFs eventually get probed?  I guess
> there's some other mechanism that tells you when they're ready, and
> you manually use sysfs 'sriov_drivers_autoprobe' to enable probing,
> then bind drivers to them via sysfs?
We have a user program talking to the Azure backplane to get that informati=
on.
@Paul Rosswurm, do you have more details?


> The prevention of autoprobing sounds like a critical part of this
> change; might be worth saying something in the subject, because "add
> sriov configure" doesn't include much information.
How about "Add handler for sriov configure with VF autoprobe off"?

Thanks,
- Haiyang

