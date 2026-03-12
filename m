Return-Path: <linux-hyperv+bounces-9361-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOHcOSrrsmnAQwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9361-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 17:34:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A45275AB5
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6002D303121E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4D38F64B;
	Thu, 12 Mar 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LL4Vppqy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020121.outbound.protection.outlook.com [52.101.201.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297038F655;
	Thu, 12 Mar 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333286; cv=fail; b=PkV+bpRCTprn1VDpD8X7TqMTA5WuGkXnAVg5eix3BzuXB0U1N7BL8TmM7Xt+yHzNazZ4V+NZ8dc/WssJf6q5vASiMV8u65VrOl+8tNazIH4HVwReF48egodo1QLEiz60GduLhvA87C3SSZE6pjS/yBbRJ6BPoZj9L56kMLzOL8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333286; c=relaxed/simple;
	bh=e/IhYCl6qi00fKO/GSXU0TSIjvt0OmiLH1qCuulmuRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nVdkX5HAeAdgO5RtTfOLY3gJHbuy/yBbMhPUxrU/V8v+aO92bGHBMDSJbgkqZBJTEosRi/pInNNoIBfYD60svoWwJi1Pvb9g0NGow7D+SFfymtao5x6IEr+opIMVSreK4Mjs7XWMuWRcH2Q8ua3TJwF399Mce2QTeAFRvPbnJQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LL4Vppqy; arc=fail smtp.client-ip=52.101.201.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCw7ZhZaxACQVrwTAgihLq9r/MjhltHLTf/8p28mqYEkw+oy43s3g5ZSLldHZgC3sDaX7Kuw1M6M89rQM1cziMZsBtBaT2nAOleWteY9V+tYattwrO5+EaCHBh5J7fe/HmKVTOe6z5NVy8W491waVaVXnr8QGshF3fvyz/DduEc0sp64E8Hnc7+lBHdw7UOjzcanmEsROHMMFcZ5D0jz6UaToJffZT+BIQyaM9NOIvIQAlwjo/tLbFi+clJur+6oibvYbPlqG0fDyRuw+uQDnx/vjnZD6tttBaoR/NGwdEOrmfeYgslRdFUJK/JSYZKHKVJiUn7L02m6X5aBsFf1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNepfN2kCCEdrhV2LpQSSxlhtB9P/pMEtq5YTFDenkU=;
 b=NPScbLEkBJtk0BYSreMTbEC/1TLdB9b/9PJpryrftwAk8+mdbQfblaNS1mTRC9AZyEX3cVkH/pGSPnLiGGDBZCLfHdJ6VKD6CwvEbZ67koMQdSTlrR6Lu+rDKM8hvZ7MJVRvTbY+icLf8ds04GIcSVTbKo9q8sDUDIs02ZjkbWrWdiqooNBIgkcmukznuO+zIsCBfZ7kJuKfpMIBmGHdnVjCq1DmsEXpC7dxH4OLmC1nOzSRKvu7vJn/KhrV0S7UGUN9FXyQFRa68VYwYp0fAXTUMOGthXztLhwiM47A3uVD0n/WpQWbvwqR4c2J81Kr/Zzjt8gqakNantz3KI72vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNepfN2kCCEdrhV2LpQSSxlhtB9P/pMEtq5YTFDenkU=;
 b=LL4VppqyIVK6YLstVHhTKoXfzZ+a+k0OSINkYFwqNy5mCUvoW2qyz8biK3s2IF9IK5EURXCmEAOpIhJepkhTN925luv0/kqQdx+lf1dA8u8y/4wJJFV0GkTCAD8B7fXEqIOfnWzvzpZeyQ8o/ChUfAuJ9p8GE1K7lWuW55AM8dA=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by DM4PR21MB3057.namprd21.prod.outlook.com (2603:10b6:8:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 12 Mar
 2026 16:34:41 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9700.006; Thu, 12 Mar 2026
 16:34:41 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Simon Horman <horms@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Dipayaan Roy
	<dipayanroy@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, Kees Cook <kees@kernel.org>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Aditya Garg <gargaditya@linux.microsoft.com>, Breno
 Leitao <leitao@debian.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,V4, 3/3] net: mana: Add ethtool
 counters for RX CQEs in coalesced type
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,V4, 3/3] net: mana: Add ethtool
 counters for RX CQEs in coalesced type
Thread-Index: AQHcsAq02ZF6ukjrskyZCumOyafI0rWpoUaAgAF6wPA=
Date: Thu, 12 Mar 2026 16:34:40 +0000
Message-ID:
 <SA3PR21MB38670E62065B5A6EC172037FCA44A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260309212106.764156-1-haiyangz@linux.microsoft.com>
 <20260309212106.764156-4-haiyangz@linux.microsoft.com>
 <20260311175835.GV461701@kernel.org>
In-Reply-To: <20260311175835.GV461701@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=21960a51-9238-44a9-a34a-716b4b14c26d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-12T16:34:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|DM4PR21MB3057:EE_
x-ms-office365-filtering-correlation-id: 569d2e6c-d74d-4d6f-0948-08de80554293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 3DtN/3qh1kK93ViHhho76RY4tQuSvaWwsCExdmUzzoyyQ6yRliyaCXHoK84p1hSNV4QpPfc4NtQvDnjDrp8oRW+f0TgD79LTvEEMm4wfiuwDxBE20YaHe7Pag3npx6VSG8WAMlS40CGkB227omGcsyyPXYaOLsg/m5XPwvD2l1L4pd0uyPyCsY2VzgNSPPd1KhhY7HUtP26LURqL4JjzB21XOstAXecPQW4XMBwP06ARsM6Xyr8d+rV1p7n7q0K7E6YdEoyoVv1a24LwCAGndHHGEMcFEcNOZaBzf2a2FkbRSYv8RkABsACKk6QeN3LulKo3zlKesDNZ0KbHJjUdNVEtE+sOvF5MRkhP8Uxdk6SbBQep2rA9+lL66kOGhUVBn3JCwpN399J70N9rD4cm72rIrDJQXpGM2wcJ+lAYxP0gouXQ9WV1rsEtfLnLrcU8ZjCFOdOAgm06Zt/pzXpKhzPs9fIbc1F7Q6ehHziBo9C6dGrc0XPmVYjmdwY/0+3kyzNB/zo1OmohIhpyhMfnSy2hkM1AQ4AWlL/erM9raHT8YSQy2K81FXo0QioFL3D2QK/8bZKA34IeL6Em/E4hjkVD9R/VGU/WIWcnr0u7zo6u+HIzXL1mDHTLaqukGAaRd9zZFO1ZZtfdcw8lvvxO7y38i4vitQOQgFz15dkx2T8GUwlLQ4ywbZWRp5UnfZx7ugbC3toyWynuNmDYcwoyoUN9aD9BbDufhpaqz9b/hqx6bmickxH85iA2Za+MOdtImDqC+BLlkE/Q8yyA8rPi2bXYjxMHN+pezPSJsQ96uAI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vnsMC1IwHoE0Ydt/I3gkMcGrrG0VsqUOeYKZVi2e70VPw+txq+FbRvmJ/hGI?=
 =?us-ascii?Q?mxFiY4jO7R9MBsy46o+g2X4gRV71ly8ktO7Xsvwmml1kHr9QiYvM/8TApDE/?=
 =?us-ascii?Q?8eed4bKOeGRytENO0KoQ9k5cJPVwjenpuOqIH7SM54kuX7PjsHM41ids2sw8?=
 =?us-ascii?Q?AoqlT/uxcAhpsG0+npF4N/68JdTZXrJFmpHBiCD58ROjfWrB1lU2q455ZDTu?=
 =?us-ascii?Q?N8IcRjKWpoHgdVGJ2C0c6m0yXDWEOI9REN0LEu1L9CNVKsXtBSBFrmGbAp63?=
 =?us-ascii?Q?+A/ajXYM6KzNtV9RE+WuczKGhtoQ4JL1IdbJWpDQrMfoj/M3qKbKsqqWkPxF?=
 =?us-ascii?Q?696G1FT2rVla9tfrq4Qf5+Szlxxu7+yYdGIdk5sihIjEOF4J6QaDfsTSIQvr?=
 =?us-ascii?Q?Nu0IALeXY7VF9SZqiep3sU3dmFP2spz8w66rIfhhGspC6epKTGj2CC5+lXeP?=
 =?us-ascii?Q?19QV7w1ZwOpXfsMh0ydNmLNpBjxi7l+ydppM1F++OiIolzr8D9ucjZNYH2vP?=
 =?us-ascii?Q?EH8FNHo+lJY1G5GNtd7bUBSCDiewgwuZXRxr2VsvBC9O81E8Qfjuyuz0bi8K?=
 =?us-ascii?Q?K8ARuRlHAm7q2XN9S6qd6864agzeIhtjVJmkyyntx1b+U2kCYVoCIni+npRf?=
 =?us-ascii?Q?Ze2X+/cqt35o2D3hK5VRhKKNhpulBxLeVtn674nhkzy4MC1BEvudVoNQ/gdP?=
 =?us-ascii?Q?OkQG//hxTWyCxU/+OCIqeAwj59GF839hZEKNfVJ0wv3LoreZ051uNrct/Ilc?=
 =?us-ascii?Q?QVEymjl/j35mQuvqnulj5/ojHHpxx94tb4ahasC2Y41MH1O9vpYhN7sBIKYz?=
 =?us-ascii?Q?2obA6OhSKw9dmICIutqiclUagTMghyTjKgb9pJ8oClvl37+F2fnUxiqi28Bi?=
 =?us-ascii?Q?UXSM+ratooDQM5I4E4JkR77GXJmF3FM26TlO+sCIblu0WVwmwGRkG/ruSaw2?=
 =?us-ascii?Q?4e7BwBa/iFbpzRC8scSZE440MmQJ6U/Svi4gmHDY7P8FHX0ddCK8arcl+EVY?=
 =?us-ascii?Q?Pz8O4mmYytRNFGrNiBsiaV0lKLBeK4YEMApo5Il/UCGMTaOeFhXjJPl36SVD?=
 =?us-ascii?Q?xdwr5eazTNBbhvTZkgcht1ayPoXWyQIlXR5vKL+rnJciTqVwpMrv27PAyxMy?=
 =?us-ascii?Q?HSqUwj96fg/O/++Gtv2crc+GtWZs7tsk+viSlReGEU3EJ3yjoRzR+0SXezep?=
 =?us-ascii?Q?NquekR18JlZD1TuyqEu/sY7nOuyWBbYLm/kmX4GM2JV1QihIq0m1MtRmWJyQ?=
 =?us-ascii?Q?V/g/eYHWB4jgo6rfDa5AT5JfUQlPVFla3i3PDDoT7MFQ2/LY/bQWGHqzj8K7?=
 =?us-ascii?Q?zCoguJnIl0xiNyNuR5kHH+cmHWPW2kqEWjxZqWG/4EeFc6ZYMsyi6JFI7JqH?=
 =?us-ascii?Q?bSiY0WczMRYFAi/M2LnMSdo7mPG09tzFuSdW935fdR6nGff6pNegKjw0UWM5?=
 =?us-ascii?Q?rq68FeBDeU9zaye6iDvZL6szhHH946Cq1ZyGPLAzdhJQnP9+y+QUzxEZZEtB?=
 =?us-ascii?Q?RPaxONnO7loUC48HDXwon2fmVY8mqbHbuc02Kb6THa5sdSXUV6P09V2VucbY?=
 =?us-ascii?Q?bFYqaaaQqRHI1cYHTnyuCigoC/10E14EQ8BLRHxO+ho2EkWBQdFNlnPYykcs?=
 =?us-ascii?Q?Cxh6bFPv5Y0MKR7/pny9vubQVaZpNdPBN6DX09Dym1oUhIOQ9U+bfzkx2bm9?=
 =?us-ascii?Q?kR9VonGR/Gwzu6j02BqHvCSh3X8GRvmSFowBGYn0q9giDm8WhLTyHAlWA+Ch?=
 =?us-ascii?Q?kUFa2b1PdQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 569d2e6c-d74d-4d6f-0948-08de80554293
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 16:34:41.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjaWIX9En/OOjvNfn/4n6tfsJiS4ynWAi5aUHAk6ZYAQWZT0YOfayWahpBcq9zoT3ni1b5SVUSKBSR472A7+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3057
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9361-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 88A45275AB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Wednesday, March 11, 2026 1:59 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Konstantin
> Taranov <kotaranov@microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; Kees Cook <kees@kernel.org>; Subbaraya
> Sundeep <sbhatta@marvell.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Breno Leitao <leitao@debian.org>; linux=
-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Paul Rosswurm
> <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next,V4, 3/3] net: mana: Add ethtool
> counters for RX CQEs in coalesced type
>=20
> On Mon, Mar 09, 2026 at 02:20:45PM -0700, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > For RX CQEs with type CQE_RX_COALESCED_4, to measure the coalescing
> > efficiency, add counters to count how many contains 2, 3, 4 packets
> > respectively.
> > Also, add a counter for the error case of first packet with length =3D=
=3D 0.
> >
> > Reviewed-by: Long Li <longli@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 21 ++++++++++++++++++-
> >  .../ethernet/microsoft/mana/mana_ethtool.c    | 15 +++++++++++--
> >  include/net/mana/mana.h                       |  9 +++++---
> >  3 files changed, 39 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index fa30046dcd3d..85f7a56d0d90 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -2148,11 +2148,23 @@ static void mana_process_rx_cqe(struct mana_rxq
> *rxq, struct mana_cq *cq,
> >  		old_buf =3D NULL;
> >  		pktlen =3D oob->ppi[i].pkt_len;
> >  		if (pktlen =3D=3D 0) {
> > -			if (i =3D=3D 0)
> > +			/* Collect coalesced CQE count based on packets
> processed.
> > +			 * Coalesced CQEs have at least 2 packets, so index is i
> - 2.
> > +			 */
> > +			if (i > 1) {
> > +				u64_stats_update_begin(&rxq->stats.syncp);
> > +				rxq->stats.coalesced_cqe[i - 2]++;
> > +				u64_stats_update_end(&rxq->stats.syncp);
> > +			} else if (i =3D=3D 0) {
> > +				/* Error case stat */
> > +				u64_stats_update_begin(&rxq->stats.syncp);
> > +				rxq->stats.pkt_len0_err++;
> > +				u64_stats_update_end(&rxq->stats.syncp);
> >  				netdev_err_once(
> >  					ndev,
> >  					"RX pkt len=3D0, rq=3D%u, cq=3D%u,
> rxobj=3D0x%llx\n",
> >  					rxq->gdma_id, cq->gdma_id, rxq->rxobj);
> > +			}
> >  			break;
>=20
> Hi Haiyang Zhang,
>=20
> As there is a break here, can the accounting logic above be move out of
> the
> loop, and merged with the "Coalesced CQE with all 4 packets" accounting
> logic that is already there?
>=20
> As is, accounting seems split between and slightly duplicated in two
> locations.

Will do.

Thanks,
- Haiyang


