Return-Path: <linux-hyperv+bounces-995-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C357F1D4B
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Nov 2023 20:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C4C282375
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Nov 2023 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6853456E;
	Mon, 20 Nov 2023 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W1Qcwm1C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2981BB;
	Mon, 20 Nov 2023 11:29:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY0kVeuvbvPqjZJl0aWrgYcI8VZ8YeJJgPUrc+1pJR/qT8qshh2k3PFv0j9JMn/o1QHBWd8Ji9XAzRDBOU5GJvYxMlJL5NjMsDWm0BC9j76g3yxR4+EeUaT4Y6pDXqRmpT5/fQnOpgmxoS+m08DT7grK/qVC1sEn/i+TToETPcJ+RRI0k68xjX4xAHeAu45tu+b000aw7UvBO543uA2sA7DiVQhMhhPoxpOAJh2IdXxSFYd8ESoHmOranu1lTtIOjQjgfoju++s58XDkAZufNRkhy+H98v9XyrcAywwv/vMFXR0/c3A5tLzDBEFUIgquPaR+PaPSvv8fRLAB8Z8p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/W1J0RwVLdhjh7g+exSUQ7fiYwaYbqAyLxlIu4Ts7o=;
 b=MKgwEdeb7OAn+UTK/b8CzrvRMoE9yBGZV9szK+KErB7gPzWjmA0OJRYLGosUkd2S/JRPoK35A2zA71RpOZuhBziuHafsCLcc9l1ZjsgwYxW/IRn/5a6D662QeQy2tNuo4Pdza0UVTk0oVYrFBmUyRL7dT6wcGK/zhVeUo8DT9RKQ5yno1I15/fdhfdwGmXUa8nDsrsh3xNQ098oR39Uhj5l+/KT7vwk5pyVhCX+j7u2i+JVDvOLnubq4zo69zhBA1r7D48G0DfyIJWQgACQXMIXrzYXUyJzcluUCtw0lS/egh+qi+Jm3xODNe+8Uv16pvp4lj945gca2bCDRoahnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/W1J0RwVLdhjh7g+exSUQ7fiYwaYbqAyLxlIu4Ts7o=;
 b=W1Qcwm1CQ+WGQuHCakBWxYAmVHPHbiEKM9WSlG7l8SR2QadNb+WKmDPGxKvLEzRLxEzm+qP/3uRC9cExnQ8Np9si+J2XeMBuRmxd/qc/bBxUcHXetbSKhdFR0Vivz2ydYadi4YZwy6dt/wMdruBZ6auePO/QzoXQI9faAfeqrhQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SN3PEPF00013E00.namprd21.prod.outlook.com (2603:10b6:82c:400:0:4:0:16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.2; Mon, 20 Nov
 2023 19:28:59 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c1de:d3e5:8e05:1e4a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c1de:d3e5:8e05:1e4a%2]) with mapi id 15.20.7046.009; Mon, 20 Nov 2023
 19:28:59 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	stephen <stephen@networkplumber.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Long Li <longli@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net,v5, 3/3] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Thread-Topic: [PATCH net,v5, 3/3] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Thread-Index: AQHaGwTlL5e+wt6IJ0GCvjHxzi6t5LCDmTaA
Date: Mon, 20 Nov 2023 19:28:59 +0000
Message-ID:
 <SA1PR21MB13356156EF05094FE9F9B02FBFB4A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
 <1700411023-14317-4-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1700411023-14317-4-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cd8d42f2-1b18-45a6-b153-e0894e1e1d85;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-20T19:27:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SN3PEPF00013E00:EE_
x-ms-office365-filtering-correlation-id: e1b9f599-45f6-49c1-0a2f-08dbe9fef1d4
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wtYQESJUsDtHLymgtlKRhPXkxtYE5rV/KF1N7ayz2JNQXVZYPL3ISq81iNJGQfNTra8a/67ZxuAXSO1Up8IQyDuqLg8xjO/zNQAu/hocRh57vgxpTQzBN3nuNVRHC/IBjPFoxEOk/KQ5YCNlfFpNmXB9GvR2Errc065ontVQhUObMTjhtDNA2ZHlkma6qMh+4Fw1mcym2pBYjP11EFfNATSyVtdcJYRcUCWkh7JZKLMAQjHcU6L7kkn+6ww6M8ER39veMQ3NMlpidM3mEFHO1ZfdufpM36IosAu+AB5UShaQSE5VCzBkGuFwkIgz+b2nDMRuJSkmRHjmapuHMClwR4izq/qjYxoWIpVAmuoHeTd40D+HyMp5fWaUKW1AdZOkJyEQ7leF/G2ipEU+SWkXBghkGjIOocQUdFvdrWGgG+KjfWASzM3CltgoKTTsasZx9IekOTQfKmsSW7BGVCjU6QUS7kCXUpd2oIsAnww+cOOIJtScf3dVJr6qY3OBn+0YFJ7adhCnmmJSvlEbwyWUq1tiK/LPH+mPiCWSnnmrKNZA1YHoFAy3yS5rL9Vu3hjXP2d0zCF3opnydTm542tcPoIcufevwuYcyYYFs/9dnFthD+ivMrJROBj6gYR8/msgT3a99m1bpL1zO70sD1emzA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(122000001)(82960400001)(52536014)(8990500004)(82950400001)(6506007)(9686003)(7696005)(33656002)(41300700001)(38100700002)(2906002)(478600001)(54906003)(66476007)(86362001)(71200400001)(110136005)(316002)(76116006)(66556008)(66946007)(66446008)(4744005)(8936002)(5660300002)(4326008)(8676002)(64756008)(10290500003)(7416002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XXsTvn3XTby7T1EmIjQ0H3qOZCctb26dI4AnLPLLQZ0nuldKnEqiek704/K6?=
 =?us-ascii?Q?NXgxvx+CRNgpB2qPSq/QzVFqVBi7XoTYiyyytHCgegghcxYlfaLJNMpAzcW4?=
 =?us-ascii?Q?8OUP1NgqZv4LE+RJwfaDdxbp+8erljssfb7ccyuxCqL3RXoGsr6OmNgG1xx4?=
 =?us-ascii?Q?3fiGBoZg4SEpY+HtTdiZh9tfnQyIt+s8kDbAfnfZuxzk2tZMHyObWokGhNUs?=
 =?us-ascii?Q?3pGwLNtpexhwfYvXmpgmHVkuEHDJRIbk86RyyOogKrO5wE90i+FpCW/BII/L?=
 =?us-ascii?Q?sAbKayE4JX+7Tn+Ou0rQAtfTZ1BhRkSGA1XuA7gCW+JMBGKPPVNL+/WBBSX4?=
 =?us-ascii?Q?F7QZKSiVBcVH8LojgGSOJBbivksmlA62g2VVs8vn8sexmAXI/eMMjd4oSSB6?=
 =?us-ascii?Q?z8LhVlHEi3Lkg7Q8ZH0+h5vYKXf1/LGEq6fBo7LuzenQ8PlEl2855+1QkrQb?=
 =?us-ascii?Q?lCjKtnu4iXHLFHqOAOb6mZ2HZ4DIf/zerNFODu25YEohkP7s7xcBBatJVDiU?=
 =?us-ascii?Q?XOBq05bYwYto9PeSRI2+rDRzVgM1iQm11W7mHnigdZd8iHWAtymIcIT2tqks?=
 =?us-ascii?Q?Jf2vGeZChmO9L9HbRUKNOe+tHuEWTR4R41qyTgY6nzdsx/zzWflMNz5iKo69?=
 =?us-ascii?Q?9JvS3n8UW4ibg86Fu7NbqvOr+0uzMzFvRm+NOsk6CLcuf9rZtopezMH0VyNP?=
 =?us-ascii?Q?PyTxrUskrVwq6CoHyBzJw+lD9cmwA2BMPBs0uuL1V6WFl3QMUM191OMxJD2+?=
 =?us-ascii?Q?+gfMwKZO5XNDN4IUOr3SMbcOUguYSeFHviEmLtlXTvtv0m7vqdhpKwqcqcfj?=
 =?us-ascii?Q?igCSGmdIlTTuCqxeKSFkl/IMw2u9lYvcRPnhy+7nuhtzjE49as8PnwGk4hDI?=
 =?us-ascii?Q?Zgiku1ge33fFgldwVrNTSq3B6Qen5vzTDUL6LM+NclCkbvHNkL27nIfTUyX4?=
 =?us-ascii?Q?pVMmRCufLDIndkp/VjPCWxfvXv6fTAMEGkG8Iu3wiZHsEJFpQATWSAvJxjIS?=
 =?us-ascii?Q?xEimFXsIebZoRJEII2nmPHyYRrYhENezBT9ysPq02h/wgxzj7LvVireJhrCj?=
 =?us-ascii?Q?tBdsub0vYJOJMikNxTATyaYC9QVN0jqu2P1qnKVAXmuZJzCTMEp5vgSa6RNi?=
 =?us-ascii?Q?K2Oge17CezjxjfGXRZuQg2Ld4YvWfW+gbBG5yvK72QE+YQHqqg14VlrfPtZf?=
 =?us-ascii?Q?KQKoEoS8QVxAlnc2HuL3Lv6MN3bGf6UmbgoErEWIo4tWcpvvVG/Ms31EZLMY?=
 =?us-ascii?Q?OZGx9sQzPI+p8GJQsafVSyUgZUcD+Dj8SDmN/o6wGBJ6tC189dUw1tzhhoFp?=
 =?us-ascii?Q?zM8kE302n2xCRoRvxwVmOlOSv0JhwmYBAvKtRJ5gYOZmLJ1zfF2g1Arrp71z?=
 =?us-ascii?Q?/W5eho2IO0kYer45zg3w3OL2NsKs0gPZUMU2vTeV19ihOdFvBMdlBIXbcRr9?=
 =?us-ascii?Q?/49ZIc58eBaooAJBaggYYO+CGzSujAtsq0ryGzeT1ctKvqUPJD5ZHetpszKr?=
 =?us-ascii?Q?FehgkFiaJgY1keM+YMUcaYtk/RAjHPv0gvU9F7hbyEM+lzOAkfyHqxwb6BN0?=
 =?us-ascii?Q?RhWXWa+VARUKyq1MmbkQk+0wacflba/nRc/d5Bioqp31KVRTujhsuCCzyi8M?=
 =?us-ascii?Q?Xzejcl9PxHOEWNMPb/K9sxk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b9f599-45f6-49c1-0a2f-08dbe9fef1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 19:28:59.0945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCmheX798N5yqUQQC8UmnBcS2qTBbmf+mZ8DL/icf79TecGOpsrW4dUJ8IyJfiJ5gLxhh6BiR/3vZP2AK46XVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013E00

> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang
> Zhang
> [...]
> From: Long Li <longli@microsoft.com>
>=20
> When a VF is being exposed form the kernel, it should be marked as
> "slave"
> before exposing to the user-mode. The VF is not usable without netvsc
> running as master. The user-mode should never see a VF without the
> "slave"
> flag.
>=20
> This commit moves the code of setting the slave flag to the time before
> VF is exposed to user-mode.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
> Signed-off-by: Long Li <longli@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v5:
> Change function name netvsc_prepare_slave() to
> netvsc_prepare_bonding().
> v4:
> Add comments in get_netvsc_byslot() explaining the need to check
> dev_addr
> v2:
> Use a new function to handle NETDEV_POST_INIT.

Acked-by: Dexuan Cui <decui@microsoft.com>

