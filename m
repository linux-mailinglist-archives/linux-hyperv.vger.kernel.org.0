Return-Path: <linux-hyperv+bounces-2917-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787B965152
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 23:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4101F23E98
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFEF18C008;
	Thu, 29 Aug 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YA67oQmE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022080.outbound.protection.outlook.com [52.101.43.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188014A614;
	Thu, 29 Aug 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965209; cv=fail; b=APOSZQzMAkiSAJ+dMptPYN3d8gBXwrERch91DrriKlFUU+R5l1/sIJlJy0jzOiUs1mKlmPjfmDB/ihBdn3rtT3FhIr7p0FpVS4LiZ/AL5HMwcmrYNR27qo4Iiy9dGNsQoWWfRKysK5JstlwYDrMMA0irSlTYyKBeOK/bBdxigxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965209; c=relaxed/simple;
	bh=f27eXtFWYBAJbOcks5t/sh8WSX4sJ161JZU2SldPw8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SvhpKMySGv6cuX5+U5ByJClkl1BgDNaxNqDkuj3wasLFQTsJHTTj5FFQ0CsFOJRZ2wgkrWwDAc0UP1WXnL/1RRop7bN2/fJJC/mD/3ctb7Xh70agEqycsZm9vuooYBn9Q4ndhWgUKv5rWABR2U4DJsFlOKTs1+b4l5Zpm/qAyto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YA67oQmE; arc=fail smtp.client-ip=52.101.43.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7Jvn75LtC6PBlApd01JND6PTAb5wDESb+QaHCWZVnjdBwSAu88rnE5i1Wmhz6u6xjguxNgy9i8pufjVGgSeYZtX27hh/13yQNC0X7B1Jb7KvmYdusSCx2bgWySR2Ywyep81atvUHyUtkKqx9jkerkf6EKsmSopPL8vXOhmBkUct2RNrS26ht/S6PdOkPZ8LWZ8TNqwYa4aEr3/dFL1x0dOsafHtfusmhLhzm4k6f/TxHWBbmnmyojUoORgNTibnTg3Ya7pSS0UwtUEZsnZZ+koKXvGClARyiNMDHqP7T5QS2jReoVxJ2/cEbDNegdep3qwJu0K5EtCoX6sPaGedWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyQUp8m/Ann93ujmMas7TuVFYdEXwkPW+ttKcdhWay8=;
 b=pXY2D+euTCwkdQnLuMZJ/ekJ++oZ1rFiWizAHJIb+49wkCFF470zRHhzTm+jYJ0KP0ZMv9A7plcfN1TDO830lJqD5hboCwD/2NFSmdPVMaKKY3Ybg2F0N3q5COp8tt9MOWHXaNRR3nM8sv82nNk3cvUp0lIjCauBVdm7e7uf0UdZDevwsYYwcnlNb4Ady5K92oXV2IS9NGBoRV/A8qY3U8v9/lsLb+nI3vytg+rsi/aNZo2El1Oqd7tWeN5YYKmWaJxttbgxQg3FBp4XiiS6spBADn7tDoyNC0uW8xKEYFtojNhfzRBP0oE+IAFzQnetJbsyUm7DFdz7GPcAtP+D9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyQUp8m/Ann93ujmMas7TuVFYdEXwkPW+ttKcdhWay8=;
 b=YA67oQmEbfXPq89hBHMKH7pMgFy179qpvIX/hvLXS0eMGfFvB2C+Ds+1lXd9pZS/z29QSBMtrYv93wo0HV1GCHF+L1ONDhvdkPfSP4z3GdmJvRjsCDlMmCV+2rP65C5NL1uyvSjMr/FycPzR+JG04cFSY47ORtNobfixN9sBY30=
Received: from PH7PR21MB3260.namprd21.prod.outlook.com (2603:10b6:510:1d8::15)
 by CH4PR21MB4241.namprd21.prod.outlook.com (2603:10b6:610:231::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.7; Thu, 29 Aug
 2024 21:00:05 +0000
Received: from PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0]) by PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0%3]) with mapi id 15.20.7918.006; Thu, 29 Aug 2024
 21:00:05 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Long Li <longli@microsoft.com>, Simon Horman
	<horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>, Shradha
 Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Improve mana_set_channels() for low
 mem conditions
Thread-Topic: [PATCH net-next] net: mana: Improve mana_set_channels() for low
 mem conditions
Thread-Index: AQHa+h4Zz3147dIpF0+H7Go6T/1OULI+pjoAgAALOCA=
Date: Thu, 29 Aug 2024 21:00:05 +0000
Message-ID:
 <PH7PR21MB32606D2D49A7F0837A29835DCA962@PH7PR21MB3260.namprd21.prod.outlook.com>
References:
 <1724941006-2500-1-git-send-email-shradhagupta@linux.microsoft.com>
 <d73d45af-e76e-4e87-8df1-0ed71e823abc@engleder-embedded.com>
In-Reply-To: <d73d45af-e76e-4e87-8df1-0ed71e823abc@engleder-embedded.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: shradhagupta@linux.microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d2eba1b-2456-4463-b5f6-f31fe12f0e37;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-29T20:34:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3260:EE_|CH4PR21MB4241:EE_
x-ms-office365-filtering-correlation-id: d3b65b00-840c-4c89-bf91-08dcc86d8eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1jteJ5tuvn/xALaGW2499bl+31Ivd8t18Th4WyIn1FS5eQG4Be6GjR/hRYBt?=
 =?us-ascii?Q?GKG+If3KdQ0LXfv9whUE6fir3yDUs1Jsvl6NAobJVoicyOBtQoSp6LW/dRM5?=
 =?us-ascii?Q?V74LhWYEvDayI51XA44e5mBQdF5L71H90lxHer/2RcXK7MS/NFbp0x8A8N36?=
 =?us-ascii?Q?qq4ZadNxiEkFDJc4WJ0SSwi63qa490LqcaAftnPIF1M8P3Qyx50JMOGLoDrx?=
 =?us-ascii?Q?97EBqLLWt0aBXFCWSu3ztfjdygWjJQq43MXmDDwGgaM96VTv4D9I/+Ym2auL?=
 =?us-ascii?Q?H7qBezu7dqGm3KnbmZpVjjZqhRKlfz91zaGtxLky4OaBcLKCaj+d8i1Zj8GB?=
 =?us-ascii?Q?fI94rMYmmlsYXrPqM0y5cel3JvjSgQZTdvsWs/3fxVHtHt1FqH2tJoe4h3fM?=
 =?us-ascii?Q?AbiX1ngXq1Ve6x+zebANQ0FXyvktgL3kUkiSJOZu3z4+rJCOyJzOG8K4DjFd?=
 =?us-ascii?Q?qrTGG5X4n8YJHmwZUR4x4wtN/AU1eBzX8cmg3p4jnD4Ad5RMZPj6lovv3/HQ?=
 =?us-ascii?Q?/LLXwu28heE9PePwO6rCBjeEy3GZQuv5N4J/eFk7NBhG1zVgRHVg1N+E65tW?=
 =?us-ascii?Q?LXbbUcsOPIbOEPwlPLuAZCPOHTwCYYqe1B7s7nOpGgSkyH+EPy/0/NEpizQ9?=
 =?us-ascii?Q?fX0YWP3xbqRBSe8XLgsVp99RZgEpY3US3kXrFa2Ceztqob+rnVL6FcYJqrcr?=
 =?us-ascii?Q?uorja7bA7I2zq/1URH00lpkcNdrh3PtAP7HHs+WeuGtCn1Y1k1XEZ15I57pi?=
 =?us-ascii?Q?T9GzzuOxKnGoIiTXjeh43WoQecX0Yu+eppPQf9n5u7KYxEBOZeHTVlPA3r03?=
 =?us-ascii?Q?q5AlUh7z6l53LrPazFcsVbks2/TU6EgqPZKG1Twu91ptinUlWxJ56mXZcn/g?=
 =?us-ascii?Q?hURC2gfGzcgKtCZZ+8uPJFs5yjDipy7SCm2+FQU3eZhDLJCA8i1oTJBtOISZ?=
 =?us-ascii?Q?kMM2Lj2IiH2T9McyLTAsCEn0wrKKj1ChI3OQzkm6mqqXVSG9NKNs4x5ikZft?=
 =?us-ascii?Q?G9DlVVn9FxLMqi/p5Nt+khWnW00eCn0XyQ7vw81n1f7okvSL59IRnWvbf02I?=
 =?us-ascii?Q?oqmii6lpqYm3dsfra9rjZPKzSc1ljhONBuecPgV4AE6cpbghxvyu/6H5xgFU?=
 =?us-ascii?Q?r1ZgElnTedGkVs8HauokDtV5sRJ/hdq4mbR9rtVpYHCuxkoYLa/xZwfb5nVl?=
 =?us-ascii?Q?uq3IwAclWyCjslgmQbjsiENI0gdaVfG3qF/fgYipL+PF+JRigZD9o3buiSCP?=
 =?us-ascii?Q?F0dvs4F7nV0rPKRKyvaKt0kKTa+Ntw7/NLlwl6CD8aD+y/lY4jYxM5XSz+2W?=
 =?us-ascii?Q?KlAFAKnfi9b0mmVxrZ1u4VRCPbnVRywIt61N5GB5BhnNFObmwwb3M3Ldrg9B?=
 =?us-ascii?Q?MzU2F/tcIlQ9UmNowW0wQXeGmc2168Yzd9Q9PD1byUGgP0wjVw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3260.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J18EevIfC1puHLgdYsSZxk0EQnBJz9lXV0GujnLvix5qd2McWuEWC+y/Xfpp?=
 =?us-ascii?Q?Zq/SIti03oqdMMJq4RCGsQF+EAQoirgGO4WxEbdjPVU4lkPc3OvNLWq/K5ws?=
 =?us-ascii?Q?RIkSxtcIYoP+/jfJJNix+eCIKZ6SDQvNnwImM0c2j7olj/mWDyxm9hMEg0Ji?=
 =?us-ascii?Q?/u+7MTijI82Erl3Yc8ErvmeMy47b6BIC26b2/XW0LsAhB5cEFwZFuBu9T6Fu?=
 =?us-ascii?Q?hzMlU+4hSWWTYSOl5CrWl6CkNbUn6XH+lO6KX2gCCu8PQk1a0WIyRw0YlfnS?=
 =?us-ascii?Q?Wmt8DuG+b+IYaCFT8SoifEMClQO2cVQK8CpzY5uBx7lWvN1pP1wMWvm9GXuB?=
 =?us-ascii?Q?CFKCHwWMM8WVj6YCm71lh9f71NIXqnxYkgniwf1+LYSBckV9joU/I0asZE0Q?=
 =?us-ascii?Q?9DboNohVAH/sHVJ9hLK0Qataa7yQM/RC9ny6TT5MMeU0BDQJoPJxx3czXx5d?=
 =?us-ascii?Q?Eofw3Ewu8XynEGhqn+HRmovwMEaVzR/dwkpzQ2CBffopYQrYvyDvGz+2K5R0?=
 =?us-ascii?Q?J8wImQN4ApKy9COaKxMDFvhsgTCKN1CiDLUUhYvMMbzQLVsDSz4hmKycLpMi?=
 =?us-ascii?Q?gM4FVifdzLHTHqq2Swp/7KDgZip9IgTMb+NXq3ZDYrbXJWZS4oOuoIcanbNF?=
 =?us-ascii?Q?ziKxQsEIX38J5TWt4+nlZEqUcMTkbIDzeZB0q1snFa5tYm58pejLVUwVdHFE?=
 =?us-ascii?Q?e9kFAtpGY5pN21TlTuMGaIbTW3dnl8o2jNyJtSulaTkHWx43zTAT62lEaNfa?=
 =?us-ascii?Q?QxihTfeZ/f9HiZTa0rXqh4/V70DPKQ/tudyyZShfEYfRSlB6Gg6QZwvcWSRb?=
 =?us-ascii?Q?VCcZKOT/1noescax6bNLouwfNWAHMrlxZuGizAH/ytgYC+/3wwfaQKcnusN4?=
 =?us-ascii?Q?mY0LsdTi3A2HqYpZVW2dC8C1mVHlm7ctFHk4PIXGSbF5i4P5mXOZ2PJUaBvL?=
 =?us-ascii?Q?3CfXaMzMwyJyxJsQaxupN155u4//VMLT7ufFJQfIf3dawtUWL2FW1g+/yjSL?=
 =?us-ascii?Q?vb5YAvUA1Hx8hgrnmroufBDpC4PG2sYLgMuGuPIGzyL+QnJb4w2volTUhptw?=
 =?us-ascii?Q?/I0WYI4AgTkBzHEEut03jNsHBHiEihoXie2o8tI6K3oUqrsuJiteiinQWgdo?=
 =?us-ascii?Q?5NvSw7gf4XOcJBxk/n2qrEh0CaXMZ44QdLaWC4jvHndcwvbrVj65Rolvw/xs?=
 =?us-ascii?Q?P+d7Lif1WfumB8AUXoNpr2nTx8Em9T2aAafVFLmLPoVj22kk8tTWpzVnceW3?=
 =?us-ascii?Q?wp/aBL4g98odwrkR4NNhC3R1Ub8VrQl4XIj9k1ol2fZ/j1f7eEVahlrI0kNu?=
 =?us-ascii?Q?wUDWBvnnXU2wI7605PMMIQDfz/VCPTkxStSZKL7TdKIHnc65RX+deKO57JbY?=
 =?us-ascii?Q?Nt7gC+gCafSD2AdDayK4bpemahPNE7q7n650p2/Sr+Ae0BOUi3nZ6oRxOfFr?=
 =?us-ascii?Q?69Vkrb2x2cJsXpFGilAKvdhgp3vaTWt9zmJ26LyhHgD5H4YcdSDv0MEaLTAi?=
 =?us-ascii?Q?Xuk253IFS2O3L58wWzaNRp7US6Hen+y4gpwnFa+oH51tFfOvopbcfPK8doiE?=
 =?us-ascii?Q?HQITpoOd8vpZarBRJDlIk2cDnYj3sd346wY0VCA5?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3260.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b65b00-840c-4c89-bf91-08dcc86d8eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 21:00:05.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kqu7BU6R5d464BMBv4Hb+QKQVsllIueSHRh+dysRPWDqV/TMsZ4udE2ysWSyVa42EKAHeHX/GE5minGw2E/DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR21MB4241



> -----Original Message-----
> From: Gerhard Engleder <gerhard@engleder-embedded.com>
> Sent: Thursday, August 29, 2024 3:54 PM
> To: Shradha Gupta <shradhagupta@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Long Li <longli@microsoft.com>; Simon Horman
> <horms@kernel.org>; Konstantin Taranov <kotaranov@microsoft.com>;
> Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; Pavan Chebbi <pavan.chebbi@broadcom.com>;
> Ahmed Zaki <ahmed.zaki@intel.com>; Colin Ian King
> <colin.i.king@gmail.com>; Shradha Gupta <shradhagupta@microsoft.com>
> Subject: Re: [PATCH net-next] net: mana: Improve mana_set_channels() for
> low mem conditions
>=20
> [Some people who received this message don't often get email from
> gerhard@engleder-embedded.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On 29.08.24 16:16, Shradha Gupta wrote:
> > The mana_set_channels() function requires detaching the mana
> > driver and reattaching it with changed channel values.
> > During this operation if the system is low on memory, the reattach
> > might fail, causing the network device being down.
> > To avoid this we pre-allocate buffers at the beginning of set
> operation,
> > to prevent complete network loss
> >
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >   .../ethernet/microsoft/mana/mana_ethtool.c    | 28 +++++++++++-------
> -
> >   1 file changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index d6a35fbda447..5077493fdfde 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > @@ -345,27 +345,31 @@ static int mana_set_channels(struct net_device
> *ndev,
> >       struct mana_port_context *apc =3D netdev_priv(ndev);
> >       unsigned int new_count =3D channels->combined_count;
> >       unsigned int old_count =3D apc->num_queues;
> > -     int err, err2;
> > +     int err;
> > +
> > +     apc->num_queues =3D new_count;
> > +     err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu);
> > +     apc->num_queues =3D old_count;
>=20
> Are you sure that temporary changing num_queues has no side effects on
> other num_queues users like mana_chn_setxdp()?
>=20

mana_chn_setxdp() is protected by rtnl_lock, which is OK. But I'm not sure
if all other users are protected. mana_get_stats64() seems not.

@Shradha Gupta You can add num_queues as an argument of mana_pre_alloc_rxbu=
fs()
to avoid changing apc->num_queues.

Thanks,
- Haiyang


