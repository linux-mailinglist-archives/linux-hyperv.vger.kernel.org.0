Return-Path: <linux-hyperv+bounces-1505-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E88475D5
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCBA29616E
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4A14A4C9;
	Fri,  2 Feb 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QaZZ2fPf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022011.outbound.protection.outlook.com [52.101.51.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259C1487C7;
	Fri,  2 Feb 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893821; cv=fail; b=P0c+FJKFE2VV22sIy2gxF+jFjqv1jx0U5NfE5Out0PCggLZ9024oRToyG1lzjBGJNeGYTnaHCMeJ604WoY8mdM+WDcyLfxALr+cTUPVAIjgpOWsolbgizuSPRpTpkPFyK9U1na3fKOQyim8dbI9ThKC3nBadne6IMKnWwQ/t+XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893821; c=relaxed/simple;
	bh=rIJRM3gAxvlzSGwbve5Wj62nwGdtZN8wPO19e7nEwRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7Hp+5S1HQBrYksuHFY4cjS6A/2wv4BLJiHbXa62ilJIzmUVTeYSRB7AVwbOW5G/XKFDvlIG6ICby/pLe7sWeJs2yvGWvT5owYmWVSGupHZjpEosWV5NebB3ZVYtw7DYlmez9Ke33IYy/Fo/LtV39cBT65QGqPmHRxJw67ycXj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QaZZ2fPf; arc=fail smtp.client-ip=52.101.51.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbWTlxPIKUHiQZNEXa1B5GtR7JY42Zjku0EyiQxIIQnGMIzNpQlWOc+5aqN+8xOW2QQ6UZlk3po5fr0m3j3RTfS6yilaGNycmUYkAc2h7VNpiAp8H5RPFBd7yreTsN32kGoh9uoxLulmw/I0AUdK+1C8OSTNB1jnLF95YqchmB6IQhtzjcZneB0M1Axv45T18YcYOGebg3zJx0S4gQRHLhbZOXCTy9eYMWP/Os8hXRrQlYYVTtDnAFlXVIOQfUyGyib7kAqtsQfznogBbjQK/v8IeRCt+XwmqOQ2DjE8v0Ng0WccztPib0ap3YIiXHsu4HvPC4XIEMGEn9yXb26NZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIJRM3gAxvlzSGwbve5Wj62nwGdtZN8wPO19e7nEwRM=;
 b=JFkaab8If5xVVPkbzbbkcoaZ51ggXd6A0Rc/b+earMx/Kfw3zAviGajk/TINif7nEGT4yUisbWt/HfpmUIgNlcH3GIWJNnjD8DYxK/VB8g6xzeR5jNb1iqaBh1i+0FtqyDTMI0mJuJxgrQIR/sDlSN6tY+xVXhEk5q15+Rq89tbcZByRvmdccD5PWIAq441OjdE18OGdTeMQIcNlhFco1GoRRuh8gNI/sj/j720UpOFv6j11vpFOQASEvCREEHXt20tEpntcxpBQ/B0fzFNkGphkMSF+wpo+QMagUR93472e2Hgwin+Y2pjXhCHlxpVpr1wDb9fg4MZDQokQDLySgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIJRM3gAxvlzSGwbve5Wj62nwGdtZN8wPO19e7nEwRM=;
 b=QaZZ2fPf1eVhe3wRFY5WGB4KJPEOFsC7zG2GsfQTinQ3fYeffRI5QkIJQ7r0tmQxyjxIbSMu+tBcVoczRvW0LQf+xQC2OpxiiotAe8GqBv1mC5MHyg2usWnceATUN4y2kktRkrXxYuQdVq2mY5AQj+5w7c3GPyTirJI11EmNJGU=
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 (2603:10b6:2c:400:0:3:0:10) by SA0PR21MB3037.namprd21.prod.outlook.com
 (2603:10b6:806:153::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Fri, 2 Feb
 2024 17:10:16 +0000
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45]) by DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45%8]) with mapi id 15.20.7249.015; Fri, 2 Feb 2024
 17:10:16 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v2] hv_netvsc: Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH net,v2] hv_netvsc: Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaVZH7WuFbrao0LEa0mVe/g5V3DLD3SdnQ
Date: Fri, 2 Feb 2024 17:10:16 +0000
Message-ID:
 <DS1PEPF00012A5F37D341C0E2B95E6A22E8CA422@DS1PEPF00012A5F.namprd21.prod.outlook.com>
References:
 <1706848838-24848-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1706848838-24848-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=247e505e-131e-47e6-b3b1-ebf3b19c0afd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-02T17:08:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PEPF00012A5F:EE_|SA0PR21MB3037:EE_
x-ms-office365-filtering-correlation-id: 8d2fd269-ab19-434b-1551-08dc2411d3c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZYgAMiNGZ7VK6wwRNf8VuRdAB7Vd8n87P8i+CKBfYjxN0SYt5mtJVj1T7+xnaqydD4VGTH2rRSQ1Y8S3pTTrfMA4L7YsqlMIlvkqx5fFAm8IQ9/4karvn3ySalQzMssxli7Er1gRlu2PM1hdIj7JH8ZAJz6GHzoiQk/Q2k2ySUdp59yirHuGv/StLGCCpddQaWfgFcigxn3Reb6CK1hpcs8tXmmZLElj7ldrQxmJSQYRed5JGk91DRxan3b5DrRQOXxvnn49ykpQTjn2d+H0FBbJw8Xd1H8+1iSudZCPUjRz6e/7Q106EtPnVglraQLNAqZReJeTtUqpE6aBR9Ae2zztX9gUwQlM7nJG6GZDgZSfl4bFrTJ0CKusEenkc0IPgixR/4rogtJ37Lf5Z4UHztqZyRFZoxAmpfX9q4UI7tVHmadLH4o9nRqpfcwLizwplkaVUwZl1NLVNnYsiVAD7DO36k3Ffax7DMqWPwYs1ajgvsAnADr6Cd8SHwW/mIwYxllDgVQ7OJivz/F5N/y461gj/ZLHV5JMbBXHRSjG2IZZrC15C9ASffPKmkfxECViMHG/xAurYGvcrKsKhjNd9+8xWD/2+4sYBooNQZql218Rr+ijZhiqnDeLxFqwAIw03twa3LdBzUNebD5GZ8LYYA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PEPF00012A5F.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(26005)(921011)(55016003)(38070700009)(8990500004)(10290500003)(478600001)(9686003)(71200400001)(6506007)(7696005)(83380400001)(316002)(82960400001)(38100700002)(82950400001)(122000001)(53546011)(7416002)(86362001)(2906002)(5660300002)(33656002)(66556008)(64756008)(66476007)(66446008)(66946007)(54906003)(76116006)(110136005)(8676002)(52536014)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ad204KuiX+qDkwfmSm3qI4ibj6MZAMwc58cjrTO+G3w9udQarQYc5wRPPxn?=
 =?us-ascii?Q?X1E9QoFA4oULe+vI94jS0OQhU3UBzirgaOjEDAdf5DNYyQEsTjg78tmfuFsU?=
 =?us-ascii?Q?5MB/gXPDF5A2UMP9/YaOtAZX7KUKVxds8n/W0x55HymbvbzrPj+EveKZa0dp?=
 =?us-ascii?Q?nOpkoC9HhHZr5KyiW5SPQkdED/2na4BUAqfWb+JgTSBmXxSk2gF8a8H9CK9t?=
 =?us-ascii?Q?KRRhCW/FuWabxvYO7Asj+eboURILyTrcs+mS2Yy0yB+Jw0NPt77NopifyYJ0?=
 =?us-ascii?Q?KNRuP5ksrBOqWFVEbHmKnzAM0gLLXvcb7t8GyMXuuap1AJQ22okoqnUuEsSw?=
 =?us-ascii?Q?w3N6hJBt3aY4bM9F6TpAqBsBeFGm2tcJY26cGlzdTa+dd6bcvO3WqXRz7L0t?=
 =?us-ascii?Q?qGrk5Af4C/g6rXDKpx16T3iFOPfoVGAxoQ1JA9uEx09wjaT3wKC/SDWsGU6c?=
 =?us-ascii?Q?MXJzQD4Ho4fE1+QXv07UuROEBhXPIxsoE/w8fzOjwASVnFoLlDS0Dm4ryuSP?=
 =?us-ascii?Q?rKrkObcEteLIye6uSovV8MikWgX/MMZaeRWwO6GtIVaLfcLGuGdm/G8oVYPz?=
 =?us-ascii?Q?uzKr1CS4DalhhUpRSHQhqfD/BGi1GV+nwfVB/OE6O0ZuR2n95JXmC8Ss1pkq?=
 =?us-ascii?Q?RwOyKroVzwICGZhXf5MVoFfh/2HJrCPxLoeO+VBbsLPCg2dpkPgqHWGir1QU?=
 =?us-ascii?Q?hf2vyfZCi4CJWGdw2UpGe6GmqsUbQkHY+zOSXvxmAkEGhAs3PdwDTFWbwy2r?=
 =?us-ascii?Q?UrDxMUsfYz6+IlY+eavnBSF81vwM/4G78LIPTbUeRIKwqTxPfm82Qp0UczT3?=
 =?us-ascii?Q?40Nx3bvT/uJ1GAXWC5vNN7Oq5jgf3PHCXS676GVdoRhMhqSS9OqnYm/dRoTE?=
 =?us-ascii?Q?Ga6cXRigsosUC5cyEps4QrcTV7zqN/ekPhS70BrvE9GfZdU2Ovqljy76/e7d?=
 =?us-ascii?Q?uelYjppHVTSTSn2MCEny3r2sEExZmUDw8kfGXvs9rmQyejVGTO3pGXNCiMFO?=
 =?us-ascii?Q?FO6SCB435xBQ/0oq889t770kK63Dx3HaWT91+wGGbQeWXb+c0kn8s+iCMhZF?=
 =?us-ascii?Q?b/H7eg/SBQ/smOxeVsPeiFqteI/X7rctRKN5C15Ki23gAtji1jJ6ewi0KtXh?=
 =?us-ascii?Q?mhd2uF+2gODIERTtB9z6k1/DxRM+5K2tVyUGkdLl23dXcaKPdWUNnZjjE/nR?=
 =?us-ascii?Q?Dy3cpzwezd3uj52laBRWR3GGp0201Y4PRduL72V30A0M+Z2cJ/AfsLdsQQb4?=
 =?us-ascii?Q?NfB3lxW3dNRgL3VrWmeYisOrHDfEsVjlOMLRhgUiukmuuhYkxl8H7xcerup7?=
 =?us-ascii?Q?+Sn2TdjnqEroxgBGZ4+1IzRS4BeU0/ZvMk71o2qTBwdd7/Amg6miCctGYfdQ?=
 =?us-ascii?Q?5dQP2hOrLuOVZhxhzU65ai5fwMzfUPVJfv9z2LPhH0Zo2nIQj4yztepPZqXn?=
 =?us-ascii?Q?86Mm/n2ROqp5/1o/f89h2Nkr73360+5yJDW6qAQW+Y5WE0mwEd72rL3c9mmZ?=
 =?us-ascii?Q?T/sPRAqhRTRNYZYsje3heaopOse+Pyn/g4aJJbfMYsE8J914c4gJsGvwkgZ0?=
 =?us-ascii?Q?xD3LUlZ/Ss/PBiIvA2KFy3x5WNvlSbloZrOcODnI?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00012A5F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2fd269-ab19-434b-1551-08dc2411d3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 17:10:16.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/EhXDPMBW4NBFAzJ7uN+/BfRJi0vXOeqsRyIZuTK+RZifAQqYElVoSMTTFrvGIjsbu4CoJ1Pfbqd16WzjX8Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB3037



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Thursday, February 1, 2024 11:41 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Wojciech Drewek <wojciech.drewek@intel.com>;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@microsoft.com>; stable@vger.kernel.org
> Subject: [PATCH net,v2] hv_netvsc: Register VF in netvsc_probe if
> NET_DEVICE_REGISTER missed
>=20
> If hv_netvsc driver is unloaded and reloaded, the NET_DEVICE_REGISTER
> handler cannot perform VF register successfully as the register call
> is received before netvsc_probe is finished. This is because we
> register register_netdevice_notifier() very early( even before
> vmbus_driver_register()).
> To fix this, we try to register each such matching VF( if it is visible
> as a netdevice) at the end of netvsc_probe.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 85520856466e ("hv_netvsc: Fix race of register_netdevice_notifier
> and VF register")
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>




