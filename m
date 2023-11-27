Return-Path: <linux-hyperv+bounces-1065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7B7FA979
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 20:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424F12817BD
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4803D396;
	Mon, 27 Nov 2023 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GDbagUr6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D71BD4D;
	Mon, 27 Nov 2023 11:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ray5gNQ2Y1s6FzyTIIW8MeULHc+VUUdw9wIlyC6l2qjrJVKquxK/EuvUPMCmuZJk+bzG18rf3XhIDD/MWXqSJodlMzPF+2iVKs3DZRj9l1b5xlLQVJ/Vc3ICvO+Y0IX8y98umyb1t2wQoT3Ro171G+b74ak+6kRuLkPUYGC3Jry9C+25zcvd/PK2pmfw8QtrqocG1NrgFmbtdjVAOOfJTmlLl5j5pml8NiR6QqGdM/bkiE7xZQqkbPS8IL1nBtUX+ajY/AVG0Qeh7kNKIM5DjMorNf9nk+NP3rvqtxR/Wqrr+edV4RVc4JdxorGsnlozvzCTOK54MzInZlfp9lacrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdgBUKoTz4I7jZmDuInB/0vzCwb/FJ7uKb8PnW7hlh4=;
 b=frrF2iDh98ObeYMs57o3IPNJv0lWJBTe38ZEz78+z/q4ZiSoo+4NstQoiwqewv+k3SJMlrvLGaAzFx3kULP92EH3k8AIJFawdxAGwsrXQnrixKkleoxNybSEx6BV/aplWcE8rFFKBHUi+8HWcJD8c9dNLSnZMI5Gdkg103IxZmms9v5QLX/an6wGX3I9dPwuUr8vsB+IH6HT5EAvTm0g2eabc6H34VlbTBs7VGBevYfk68/xZvL9DHjmmDImOHvcmYJFImdeu4sqLgeSicI7drfn3jTB8V1tC0DMdtUBkojjDIFT06dGuuTgEntlRd+MdpB+m9XFcvnC3rUGVZj2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdgBUKoTz4I7jZmDuInB/0vzCwb/FJ7uKb8PnW7hlh4=;
 b=GDbagUr6Gq/IIfrf75R38O64bJpjdgm007ncdPfLpDFLmLTwcIYXwrsACzrkdcuD5DaioyrKfx55XPA2yXn0R0zxTD2ONfp5FJkacmZvMm1krEv4LN7uUn8ucIK3qOBq4ThD4aEImnIW7v8oGfXfKvbJIFEMIgYFHeCKolQxizE=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SJ1PR21MB3576.namprd21.prod.outlook.com (2603:10b6:a03:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.5; Mon, 27 Nov
 2023 19:00:24 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::3c1:f565:8d:2954%7]) with mapi id 15.20.7068.002; Mon, 27 Nov 2023
 19:00:22 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Ajay
 Sharma <sharmaajay@microsoft.com>, Dexuan Cui <decui@microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch v1 2/4] RDMA/mana_ib: create and process EQ events
Thread-Topic: [Patch v1 2/4] RDMA/mana_ib: create and process EQ events
Thread-Index: AQHaHbqcE/8yybp090GLgM5Yz7Lg2bCM3LsAgAGvpWA=
Date: Mon, 27 Nov 2023 19:00:21 +0000
Message-ID:
 <PH7PR21MB3263ECFFD2850220F3F55E29CEBDA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
 <1700709010-22042-3-git-send-email-longli@linuxonhyperv.com>
 <20231126171504.GC84723@kernel.org>
In-Reply-To: <20231126171504.GC84723@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8d0692c-b95c-4026-b431-c495eeba7fac;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-27T18:59:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SJ1PR21MB3576:EE_
x-ms-office365-filtering-correlation-id: 6a4ce887-8b87-4571-bec9-08dbef7b1b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 epBkAQckz08nULmJSIXr0LYZf0i9ZFekvUgol4GXuZjvHXTQo9gHygbwkaaQ0UFSiLVQwL4S+OWc/1gvEXIfZQ5uiPRZbby1xYLH0iOPtLXpuIU7xs+lMs3b/JCN5NR30gCmuXo5YjNbBctCbv0VdSfKkeUH768Jns5fV+hhxbZFePy1s4gTtAi5DNeF/log0RQ3d0Pk5iDX5WFpQwLwYjzWCksaFEbjq9MkWEr5HucUotGKYQoh5RSl5lspwchHBhuGcg4lANitKDDJ4f2DLTBG+YbGM1uK81blk1B3aeiTTahrZ8f2PP/ycDDpoeACC9OrR1uyViG2+iIs1uOSCQUqu9UJ7h6hjFPlMnYZBg3TP0DA8GSlo5SSzgc/GRn/9FJ3NDVTBJtPTzUIRqB0L4dUfBD/MfF+uVLNzc/2Etc9w/SnD5h6YtOUE8SDfLfwa+lLWsRnx1tTlwWsGr7mp0/kWoug9DS8X3SRTm63NwUYnJKuuesBDwDHAHtbK63IinDFv4ql0qHe6XOXqWtgeB58o4anK4mGmx4JcHtbOb82Bm0j2tL7Pq7wBmakwmxIwOEw1cpBjDlHhRmY1fwwBqqhfj375oh73b7olcH7uwNyq36h4IinfH9MXonW+M/uB74et0c2kj8cd6l3QJguXDPG3sQXXpHB/fwibO76DVg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(38100700002)(82950400001)(33656002)(86362001)(82960400001)(38070700009)(122000001)(41300700001)(66946007)(110136005)(64756008)(54906003)(316002)(66446008)(66476007)(66556008)(76116006)(8676002)(8936002)(4326008)(52536014)(55016003)(8990500004)(7416002)(5660300002)(4744005)(2906002)(9686003)(7696005)(6506007)(10290500003)(478600001)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4RqpWX+hHgcGcKYU+EFyCkmVDOXlbM2R6gLkguKs23SUOEjqR9ASry34/fJw?=
 =?us-ascii?Q?oU1ZQb3njc9YaxzIgnz4JnzpTHs3fo1Z91b+740AKFWXmyIjEPzRJuck0id7?=
 =?us-ascii?Q?b8RWR+1qFc/hS4O0Z4Beet7lAPzBqahUP2HYZ8tVvilNWYOcnrzfbYuoOju8?=
 =?us-ascii?Q?iy/LBpri/zGKoKZzfCXqZKB/CyAEz8sti7HICPk0rahRW5MxLrG2KDgLeepV?=
 =?us-ascii?Q?Rxgi+6lAcL7NZNJQW4MbkCE6kUb14gT3Dl9Lnag7TkObqbJKBMlb9bvDdpjK?=
 =?us-ascii?Q?GtmzKM//PLCIomkIW3oynW8W2iqISmQ7Hnm1qdS+NOr6mGYr3u46jzpPFRU2?=
 =?us-ascii?Q?WDcVgm94Y8mZzWP2EK4aF878RKSgd7QRBuufLP9WT032Tyzl/OlEHB0+yp0I?=
 =?us-ascii?Q?sAULAaR6qXHIaahw0CvB/47V6U+qiFeQHTTyk1Ovrsmv8EHfY/kU4KJinu7p?=
 =?us-ascii?Q?p7DYAc3S9yvTI75FLlwwkOUDBIM/mdpWB/oYmvQCBaI+aae8Vl46TMrjnAXE?=
 =?us-ascii?Q?Mu2OG2OgVeInJP5VtL65r+YMXUf7Wi7ABYFKxGmXk7+ZdVZjGz7Hek5da1C9?=
 =?us-ascii?Q?lAYjiTIgmkmTww47siy5TsuVS8sohOPRohQe/XNM//YNrqnLx/neKppgM4EK?=
 =?us-ascii?Q?cwKInzY/SIj8jJZNGtSMhCdjguDWDWxoVoCg5QmVsAC5SECNE2CWkX1qD4ZL?=
 =?us-ascii?Q?pOLOC+5HgGSX1BsA+3BHija7VfjMbqtDNWEcron17oEXYdGOJgLyjjgL8xya?=
 =?us-ascii?Q?SmfmQALNgw568mL+0W1yETYkK8pNQwdwaZm6NdXBoTqZGuekX/UHLlPCFB61?=
 =?us-ascii?Q?91lqdrepFaokgI/YrQSdGy49Hc+AgxLsNJNM0bIbrWnNR6v7/qShwLwm/wTS?=
 =?us-ascii?Q?sg+DQkByLMT7uvB5pDmVxSS22NNcrSNNyp5yYbbTJIijlG5hGGEIu7zTSZJc?=
 =?us-ascii?Q?1Cbv/YIa/5gzyrxbbkmhcZjdmAPO81Xw+C/KkEv/Lwql4xS93weN7hsPNhHR?=
 =?us-ascii?Q?WuoZ5OHQ+2Dtt+Spc4V1vuTiYllhMdI4gSz+Z0z1CYqib7ZyWja6YsiSBrk1?=
 =?us-ascii?Q?B1mqNNmtWKpObArNdPPrbzEUty/CCXdLowQiEHutCV1IJR5/fVAxbAxXgLQr?=
 =?us-ascii?Q?AnaSWeRCeOZsz3ToR6uPIU3T079QPIoufkF5tvupwjCC+WnDumPq0k9cvDDv?=
 =?us-ascii?Q?1Wk9ZSt28bB21dIX0pNv6E4oPCaXweqMxAMBGd86VPETNup/BAZqTFkw9jUo?=
 =?us-ascii?Q?w0sy0k0KjugSnsX+rPAj3Sha2m1G5q4CcmHFdSZqIQeIoWxZ3ESjYuJfRAfd?=
 =?us-ascii?Q?hGf9RLFdkW8u6EghLHwvyz91+OCllErqchrCJ17yTCu88XWenQwYq5wmJia0?=
 =?us-ascii?Q?2U7N3d7emvYOu/gWB6zdPDh/qvFArwuWnFOTnK4J/uVKQYPrT7byyNq4kAQt?=
 =?us-ascii?Q?uBDEe2xnt8//d/vmFDu08t5aJTkuK6wn9MQxNwtgX5qe/a9j9eAaiy2bvbfu?=
 =?us-ascii?Q?FC6kB9lryfBsAtfKyO6fGb3rseSITbwyWzb8gIX/db4CDks1JpsXCNgtIvmt?=
 =?us-ascii?Q?boDYKe9pOOLCymcbWi/OMCkLd2yqgv5nuxv2XyEk?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4ce887-8b87-4571-bec9-08dbef7b1b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 19:00:21.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bg+wEFra6TVapjXjGaQsV+i8C+QYgY0zzd5fptsE4J6zVFyzT1ZU+l1LF3oYdSzWayKTtSr438hxRHxjgehPSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3576

> > @@ -505,14 +507,24 @@ static void mana_gd_deregiser_irq(struct
> gdma_queue *queue)
> >       if (WARN_ON(msix_index >=3D gc->num_msix_usable))
> >               return;
> >
> > +     spin_lock_irqsave(&r->lock, flags);
> > +
> >       gic =3D &gc->irq_contexts[msix_index];
> > -     gic->handler =3D NULL;
> > -     gic->arg =3D NULL;
> > +     list_for_each_rcu(p, &gic->eq_list) {
> > +             eq =3D list_entry(p, struct gdma_queue, entry);
>=20
> Hi Long Li,
>=20
> Sparse complains a bit about this construction:
>=20
>  .../gdma_main.c:513:9: error: incompatible types in comparison expressio=
n
> (different address spaces):
>  .../gdma_main.c:513:9:    struct list_head [noderef] __rcu *
>  .../gdma_main.c:513:9:    struct list_head *
>  .../gdma_main.c:513:9: error: incompatible types in comparison expressio=
n
> (different address spaces):
>  .../gdma_main.c:513:9:    struct list_head [noderef] __rcu *
>  .../gdma_main.c:513:9:    struct list_head *
>=20
> Perhaps using list_for_each_entry_rcu() is appropriate here.

Thank you, I will fix this.

Long

