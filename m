Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1885767790
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjG1VXx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjG1VXv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 17:23:51 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FB2115;
        Fri, 28 Jul 2023 14:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiYTIQT9sruD5auCIRiOdt8/lgRZSmi5Z29yV6qQw1K+kcANmnncsmkC8fNSsvHgzjcoSvpsKy2RKWGWum+n/HZso1hWg159qlmQ/+nkslcdC+I6o04ebgLWnse51CLYDDPochzXTeEmCgJoe6ZbzodYfdtZy73fy8bOOutBW8BLggtIJyZuTf3qTCpNzuy9F3lFYo4ubMgEZvrmR1cIGIODxOUWo6xt0F6rrZfzjT7NMOAjoGxu2h+afsvM62PJXLhhSvuqwmjUqH+YqhZCyxLW4UE+Q1s0A+F+UtlM49bfJ+CkaZmGuMrU6oRBGfEViwPZ3AMmyQqmkjPhypzn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/BVh7iQp/zRk3DHd01+yydNSboFMuLqr7+vZ0Tf7s4=;
 b=NE71/X53Go9HNkt616uZPeHLRZELY5EfpCwaOsWbFeyKxZBvENuHEhA4vHZQ6uKutotzvdsBj5AyZIvLyRboUY1Kg/P8BqPi/gVYuZtbMURFRDSMx9+jYxzprVrPXdorctPHqYMIqGf6KAnLENgtmEB1Foym8sIxpK2Zcj3iIZBrLgiXavHHAsL+V37vjQtZitFvi8O7/4TnI2BIXQM+j7Wxp6HroYfQ/yr9Q4OqqX0Q178CqbgeBsxGwTnIwSbWh3uyAzoOKTaTMj9G30i0WKcEqgvywuyzSbRM4Pgh0+yF3l9Uoq8NF9Q2rQHakkbyOdz3ZuYtCUH4Q3fN2k+WuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/BVh7iQp/zRk3DHd01+yydNSboFMuLqr7+vZ0Tf7s4=;
 b=CgkGPSeUL51RwAjjCZ8tt1uxuh5KEuG+VYNdQGTFPLPc5JmI7Zxe76R7w4Q8yYQR9SlxhqL+8XIedpu83GH1UkiibmL9j4qoDPRRe6amv1yeAOb0lveUleU6x/ySJeqiW43ZmKVU5ip8O7Npz+L2lcuFyTSo9zxrAK1acButj2o=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MW2PPF9BEBA00F2.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:2:0:e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.12; Fri, 28 Jul
 2023 21:23:43 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067%5]) with mapi id 15.20.6652.002; Fri, 28 Jul 2023
 21:23:42 +0000
From:   Long Li <longli@microsoft.com>
To:     "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: RE: [Patch v3 1/4] RDMA/mana_ib : Rename all mana_ib_dev type
 variables to mib_dev
Thread-Topic: [Patch v3 1/4] RDMA/mana_ib : Rename all mana_ib_dev type
 variables to mib_dev
Thread-Index: AQHZv/z3UBH7FQIeCU6DIT6EY/EjKa/PssSA
Date:   Fri, 28 Jul 2023 21:23:42 +0000
Message-ID: <PH7PR21MB326392A797DA90BA4A2EB35ECE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-2-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-2-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a43b0755-2bdd-4a6b-aa02-b8769866433c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T21:20:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MW2PPF9BEBA00F2:EE_
x-ms-office365-filtering-correlation-id: 6ecf3aaf-a6db-4a36-4011-08db8fb0eb33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQgCeIysa8SREAKuSvFtHlL30UpeoR/Ot9WMFdrROvqn3JqI7MEdk4O4dyZNbYl41oyLQZsH6sPaI5JXrEqbXryuTEFUpsC9EgVp+PUYukFvwB3DH/0/aIB5HuQzlLPZIweYwX0HDetP2CmY7ObLQOWkXcjsSwgXBL9jI/dJFmsnQm44zs1P88k20KsaiPFKmeZoZEk0QY4BqSYR5AFTuofgW11uSaI96ftVKg91HFWCAt6xdu4JZCH78zEbvJ9CsUKSPxSc9ytlGSpbCmrsCoguMsi81r3pWQfElnQHEpw9ABmXDj1xjvZD6yn6J7LK8L/F2TF4JUqD5UpHTVkleMsbReW3u6BDNOy/aOCopqrzGh0kBHzr2gxAg0G43jaTbGUCHpUbtmpoM3VTMqT3LEAkGi1F/l/6oAFGXj/406o4QiV+uT98F0poNqiszJhMgGpmbXMV/caoHTli2B3X995MLEuzbCSx6tLMF3NMc2Y3VmkCBEhlsiOZ12EwAMUolDnH+3zKHJ9qtm+iQU1p97CwLXD71v55ltJOq8HcqpNWiOUNR9YCz9NNsRxPFUdwylaHsdIl3VXVVtfWCNb+jlkV0WD9l7qDiwBNfmQ7Y7s7/SYhVAD34/PQlrkAoZcseckALJH2xTJKy53Ml4c8q43eLnDn/6LmWPJnkvZGbmk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(82950400001)(55016003)(82960400001)(66446008)(9686003)(478600001)(316002)(110136005)(7696005)(71200400001)(66946007)(8676002)(38100700002)(4326008)(66556008)(10290500003)(52536014)(5660300002)(64756008)(76116006)(54906003)(41300700001)(66476007)(8936002)(107886003)(83380400001)(6506007)(186003)(53546011)(122000001)(33656002)(2906002)(30864003)(7416002)(38070700005)(8990500004)(86362001)(66899021)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TGfFTf9NFpii7Z2JtCwYu1Gv4bwby5HeF8bNtZ3mawlLe7Knk0HfztHhsBKn?=
 =?us-ascii?Q?nB7GmG2tz3CrGNccs+wLb0Vz4n1WlfHWBT8cG+ZhqbuUgmMWy14kXXG5sX0t?=
 =?us-ascii?Q?6Ia4Ji1Luqh5nLQb3JajUC2F1M82OSXqlne5ODW+Vr1wanZSPZeYfnBoOI2e?=
 =?us-ascii?Q?FZDhXPwzVAqBs5Cz7pq3Xk9YzDCjPLJP/e6Da6NWdqtAsCbcW9hnSD8EoFZG?=
 =?us-ascii?Q?9InTszAYc9m+cRm8xAwknoJTKb+i2ko0ati56gmH+Ms6kzsUVas1HQ6EW9Tv?=
 =?us-ascii?Q?IBFUAR+MZcTyxCCN+8KBdB5QtWHqQeeezBohqdMrM2TuFUdlcffWRzdp7br+?=
 =?us-ascii?Q?xmnCB5Yj/NlSt4vVsY6LqQeO5PKFRicAgarq/YuIt7cSA72F2iE49kGyzf7b?=
 =?us-ascii?Q?xk7iqemrtPh9ywm3QCzLGNSBgYFyx7PchiN8qL8C0yUJ0xbifFQKy4FYtDar?=
 =?us-ascii?Q?65cFYPdRJYZtSEFU/68tqR2irxNOZ5Bp2rXEDJGgX/uhv4izO8eWEEvmO2rN?=
 =?us-ascii?Q?6HQyh87SznbiNn2FdFEX23kFbUQIM1NSElw5UMqXtEmK248B809mcaUmqAaM?=
 =?us-ascii?Q?+wQMFiSv625voMSTkhiMliGaapQ8mb4/aqb6MrPCTZi4dHEA40oqO3lVZ7Di?=
 =?us-ascii?Q?hzzK/0JCpqoMXP0EhI9qOBh9blRFjCMtxxnktgasrrRa20DLSc3PbztMJA8W?=
 =?us-ascii?Q?YjSw4JTTQOFCGSxgw+KqWmR+UNVuytKJXmkb+sMV0CdkTAPtD0AxYxC4U1f2?=
 =?us-ascii?Q?9+Gl0YeZ87wTRV7O8Ljpujs61O9xGH1WTf5GZpW9/fTmWsrxZywBvE/ZvMwB?=
 =?us-ascii?Q?ItUxbfuRB3X74MPuCQ19nfrQflSP2Uv6TU61KboLityRhf8b+dGvnwYcx49Z?=
 =?us-ascii?Q?iK5FY73Wjz9+yZ5gwDKMvEvu1SL32fDpmVqvUhQTGi4A+3F8HcrS1Uln+YMw?=
 =?us-ascii?Q?0xfVRVw+ZJoRHwmXHaArh4+JTGVGNaAZgWsICczDrRa9k8tKKKvCLGlG/Gyj?=
 =?us-ascii?Q?FkrFxVH9wk43zGzrOr/tn4TAOlkgyoU8CTOIfQVu3FBZKDrPqdjcONBw2/WB?=
 =?us-ascii?Q?JJLQ/gGUfUlc/syJ3at53z4/+ErFTp+1LLuIlkY2eQiRIDEVGEgKzLJ3c8XU?=
 =?us-ascii?Q?r8zputArD08GdHPngyUcUrH1i8hnC7+iW30f8PNOT2O+CERwsE3wLN6kpiNR?=
 =?us-ascii?Q?8MYBmEXOQR2fQdOwlytZp25s0x9ai/tdgig1GOKdCCWNGslYUN7Lx5Y4kBA7?=
 =?us-ascii?Q?wxPkhZoi9uk3Vu9h63N8UoLNqOlJQ0Vi4cW8/ZgnTK4LG0bvjx65Y7ZfmMlb?=
 =?us-ascii?Q?jZXhPak1sLitVOYRCuCB06ekn9J35Tyk8Z8t4eq4IMsbZagfv23tlFPBR+Jx?=
 =?us-ascii?Q?VB9FiclsmFymDieo+WQxa8KcQVZfSwgRwR4MxAXT/x01zkvgsJlQoK3Oxv1w?=
 =?us-ascii?Q?hk3wdMgsCg1QQOtzrIbcINzXktEdrGl8xrGiUVCVoX40FrPN4nWndyZN2afV?=
 =?us-ascii?Q?ttX2LtEUWY6OqmhSuRgsAcVKJRSeWLj+byJkxQbU1gaBulXRkRPHBL7fMOen?=
 =?us-ascii?Q?M1M39Bc455aB23RuM9QkEmpweNJYw7xEeLhZDuD0uoJpz5yuNj6LUOuUL3L/?=
 =?us-ascii?Q?c2CmNzbKqnt3gxCSGxJrCHE8ipvjWh4tNFzwgJ/GpT9V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecf3aaf-a6db-4a36-4011-08db8fb0eb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 21:23:42.5853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fg+5KEKuzcRqq4GSQI66D8uaNip6U3r3prD6rAuN48JqrcV+WwA/JE59FpQr1UqMnuQKg34Y3P6+bJ1juCZyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PPF9BEBA00F2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: sharmaajay@linuxonhyperv.com <sharmaajay@linuxonhyperv.com>
> Sent: Wednesday, July 26, 2023 1:08 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: linux-rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> <sharmaajay@microsoft.com>
> Subject: [Patch v3 1/4] RDMA/mana_ib : Rename all mana_ib_dev type
> variables to mib_dev
>=20
> From: Ajay Sharma <sharmaajay@microsoft.com>
>=20
> This patch does not introduce any functional changes. It creates naming
> convention to distinguish especially when used in the same
> function.Renaming all mana_ib_dev type variables to mib_dev to have clean
> separation between eth dev and ibdev variables.
>=20
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c      | 12 ++--
>  drivers/infiniband/hw/mana/device.c  | 34 +++++------
>  drivers/infiniband/hw/mana/main.c    | 87 ++++++++++++++--------------
>  drivers/infiniband/hw/mana/mana_ib.h |  9 +--
>  drivers/infiniband/hw/mana/mr.c      | 29 +++++-----
>  drivers/infiniband/hw/mana/qp.c      | 82 +++++++++++++-------------
>  drivers/infiniband/hw/mana/wq.c      | 21 +++----
>  7 files changed, 140 insertions(+), 134 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index d141cab8a1e6..1aed4e6360ba
> 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -11,10 +11,10 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const
> struct ib_cq_init_attr *attr,
>  	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_create_cq ucmd =3D {};
> -	struct mana_ib_dev *mdev;
> +	struct mana_ib_dev *mib_dev;
>  	int err;
>=20
> -	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
>  	if (udata->inlen < sizeof(ucmd))
>  		return -EINVAL;
> @@ -41,7 +41,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		return err;
>  	}
>=20
> -	err =3D mana_ib_gd_create_dma_region(mdev, cq->umem, &cq-
> >gdma_region);
> +	err =3D mana_ib_gd_create_dma_region(mib_dev, cq->umem,
> +&cq->gdma_region);
>  	if (err) {
>  		ibdev_dbg(ibdev,
>  			  "Failed to create dma region for create cq, %d\n",
> @@ -68,11 +68,11 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct
> ib_udata *udata)  {
>  	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
>  	struct ib_device *ibdev =3D ibcq->device;
> -	struct mana_ib_dev *mdev;
> +	struct mana_ib_dev *mib_dev;
>=20
> -	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
> -	mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
> +	mana_ib_gd_destroy_dma_region(mib_dev, cq->gdma_region);
>  	ib_umem_release(cq->umem);
>=20
>  	return 0;
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index d4541b8707e4..083f27246ba8 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -51,51 +51,51 @@ static int mana_ib_probe(struct auxiliary_device
> *adev,  {
>  	struct mana_adev *madev =3D container_of(adev, struct mana_adev,
> adev);
>  	struct gdma_dev *mdev =3D madev->mdev;
> +	struct mana_ib_dev *mib_dev;
>  	struct mana_context *mc;
> -	struct mana_ib_dev *dev;
>  	int ret;
>=20
>  	mc =3D mdev->driver_data;
>=20
> -	dev =3D ib_alloc_device(mana_ib_dev, ib_dev);
> -	if (!dev)
> +	mib_dev =3D ib_alloc_device(mana_ib_dev, ib_dev);
> +	if (!mib_dev)
>  		return -ENOMEM;
>=20
> -	ib_set_device_ops(&dev->ib_dev, &mana_ib_dev_ops);
> +	ib_set_device_ops(&mib_dev->ib_dev, &mana_ib_dev_ops);
>=20
> -	dev->ib_dev.phys_port_cnt =3D mc->num_ports;
> +	mib_dev->ib_dev.phys_port_cnt =3D mc->num_ports;
>=20
> -	ibdev_dbg(&dev->ib_dev, "mdev=3D%p id=3D%d num_ports=3D%d\n",
> mdev,
> -		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
> +	ibdev_dbg(&mib_dev->ib_dev, "mdev=3D%p id=3D%d num_ports=3D%d\n",
> mdev,
> +		  mdev->dev_id.as_uint32, mib_dev->ib_dev.phys_port_cnt);
>=20
> -	dev->gdma_dev =3D mdev;
> -	dev->ib_dev.node_type =3D RDMA_NODE_IB_CA;
> +	mib_dev->gdma_dev =3D mdev;
> +	mib_dev->ib_dev.node_type =3D RDMA_NODE_IB_CA;
>=20
>  	/*
>  	 * num_comp_vectors needs to set to the max MSIX index
>  	 * when interrupts and event queues are implemented
>  	 */
> -	dev->ib_dev.num_comp_vectors =3D 1;
> -	dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
> +	mib_dev->ib_dev.num_comp_vectors =3D 1;
> +	mib_dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
>=20
> -	ret =3D ib_register_device(&dev->ib_dev, "mana_%d",
> +	ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
>  				 mdev->gdma_context->dev);
>  	if (ret) {
> -		ib_dealloc_device(&dev->ib_dev);
> +		ib_dealloc_device(&mib_dev->ib_dev);
>  		return ret;
>  	}
>=20
> -	dev_set_drvdata(&adev->dev, dev);
> +	dev_set_drvdata(&adev->dev, mib_dev);
>=20
>  	return 0;
>  }
>=20
>  static void mana_ib_remove(struct auxiliary_device *adev)  {
> -	struct mana_ib_dev *dev =3D dev_get_drvdata(&adev->dev);
> +	struct mana_ib_dev *mib_dev =3D dev_get_drvdata(&adev->dev);
>=20
> -	ib_unregister_device(&dev->ib_dev);
> -	ib_dealloc_device(&dev->ib_dev);
> +	ib_unregister_device(&mib_dev->ib_dev);
> +	ib_dealloc_device(&mib_dev->ib_dev);
>  }
>=20
>  static const struct auxiliary_device_id mana_id_table[] =3D { diff --git
> a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 7be4c3adb4e2..189e774cdab6 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -5,10 +5,10 @@
>=20
>  #include "mana_ib.h"
>=20
> -void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd
> *pd,
> +void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct
> mana_ib_pd
> +*pd,
>  			 u32 port)
>  {
> -	struct gdma_dev *gd =3D dev->gdma_dev;
> +	struct gdma_dev *gd =3D mib_dev->gdma_dev;
>  	struct mana_port_context *mpc;
>  	struct net_device *ndev;
>  	struct mana_context *mc;
> @@ -28,10 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev,
> struct mana_ib_pd *pd,
>  	mutex_unlock(&pd->vport_mutex);
>  }
>=20
> -int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct
> mana_ib_pd *pd,
> +int mana_ib_cfg_vport(struct mana_ib_dev *mib_dev, u32 port,
> +		      struct mana_ib_pd *pd,
>  		      u32 doorbell_id)
>  {
> -	struct gdma_dev *mdev =3D dev->gdma_dev;
> +	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
>  	struct net_device *ndev;
> @@ -45,7 +46,7 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32
> port, struct mana_ib_pd *pd,
>=20
>  	pd->vport_use_count++;
>  	if (pd->vport_use_count > 1) {
> -		ibdev_dbg(&dev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Skip as this PD is already configured vport\n");
>  		mutex_unlock(&pd->vport_mutex);
>  		return 0;
> @@ -56,7 +57,8 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32
> port, struct mana_ib_pd *pd,
>  		pd->vport_use_count--;
>  		mutex_unlock(&pd->vport_mutex);
>=20
> -		ibdev_dbg(&dev->ib_dev, "Failed to configure vPort %d\n",
> err);
> +		ibdev_dbg(&mib_dev->ib_dev, "Failed to configure
> vPort %d\n",
> +			  err);
>  		return err;
>  	}
>=20
> @@ -65,7 +67,7 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32
> port, struct mana_ib_pd *pd,
>  	pd->tx_shortform_allowed =3D mpc->tx_shortform_allowed;
>  	pd->tx_vp_offset =3D mpc->tx_vp_offset;
>=20
> -	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x
> doorbell_id %x\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "vport handle %llx pdid %x doorbell_id
> +%x\n",
>  		  mpc->port_handle, pd->pdn, doorbell_id);
>=20
>  	return 0;
> @@ -78,12 +80,12 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  	struct gdma_create_pd_resp resp =3D {};
>  	struct gdma_create_pd_req req =3D {};
>  	enum gdma_pd_flags flags =3D 0;
> -	struct mana_ib_dev *dev;
> +	struct mana_ib_dev *mib_dev;
>  	struct gdma_dev *mdev;
>  	int err;
>=20
> -	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	mdev =3D dev->gdma_dev;
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	mdev =3D mib_dev->gdma_dev;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
>  			     sizeof(resp));
> @@ -93,7 +95,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  				   sizeof(resp), &resp);
>=20
>  	if (err || resp.hdr.status) {
> -		ibdev_dbg(&dev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to get pd_id err %d status %u\n", err,
>  			  resp.hdr.status);
>  		if (!err)
> @@ -104,7 +106,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>=20
>  	pd->pd_handle =3D resp.pd_handle;
>  	pd->pdn =3D resp.pd_id;
> -	ibdev_dbg(&dev->ib_dev, "pd_handle 0x%llx pd_id %d\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "pd_handle 0x%llx pd_id %d\n",
>  		  pd->pd_handle, pd->pdn);
>=20
>  	mutex_init(&pd->vport_mutex);
> @@ -118,12 +120,12 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  	struct ib_device *ibdev =3D ibpd->device;
>  	struct gdma_destory_pd_resp resp =3D {};
>  	struct gdma_destroy_pd_req req =3D {};
> -	struct mana_ib_dev *dev;
> +	struct mana_ib_dev *mib_dev;
>  	struct gdma_dev *mdev;
>  	int err;
>=20
> -	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	mdev =3D dev->gdma_dev;
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	mdev =3D mib_dev->gdma_dev;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
>  			     sizeof(resp));
> @@ -133,7 +135,7 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  				   sizeof(resp), &resp);
>=20
>  	if (err || resp.hdr.status) {
> -		ibdev_dbg(&dev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to destroy pd_handle 0x%llx err %d
> status %u",
>  			  pd->pd_handle, err, resp.hdr.status);
>  		if (!err)
> @@ -204,14 +206,14 @@ int mana_ib_alloc_ucontext(struct ib_ucontext
> *ibcontext,
>  	struct mana_ib_ucontext *ucontext =3D
>  		container_of(ibcontext, struct mana_ib_ucontext,
> ibucontext);
>  	struct ib_device *ibdev =3D ibcontext->device;
> -	struct mana_ib_dev *mdev;
> +	struct mana_ib_dev *mib_dev;
>  	struct gdma_context *gc;
>  	struct gdma_dev *dev;
>  	int doorbell_page;
>  	int ret;
>=20
> -	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	dev =3D mdev->gdma_dev;
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	dev =3D mib_dev->gdma_dev;
>  	gc =3D dev->gdma_context;
>=20
>  	/* Allocate a doorbell page index */
> @@ -233,12 +235,12 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)
>  	struct mana_ib_ucontext *mana_ucontext =3D
>  		container_of(ibcontext, struct mana_ib_ucontext,
> ibucontext);
>  	struct ib_device *ibdev =3D ibcontext->device;
> -	struct mana_ib_dev *mdev;
> +	struct mana_ib_dev *mib_dev;
>  	struct gdma_context *gc;
>  	int ret;
>=20
> -	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev->gdma_dev->gdma_context;
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	gc =3D mib_dev->gdma_dev->gdma_context;
>=20
>  	ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext-
> >doorbell);
>  	if (ret)
> @@ -246,7 +248,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)  }
>=20
>  static int
> -mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
> +mana_ib_gd_first_dma_region(struct mana_ib_dev *mib_dev,
>  			    struct gdma_context *gc,
>  			    struct gdma_create_dma_region_req *create_req,
>  			    size_t num_pages, mana_handle_t *gdma_region,
> @@ -263,7 +265,7 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev
> *dev,
>  	err =3D mana_gd_send_request(gc, create_req_msg_size, create_req,
>  				   sizeof(create_resp), &create_resp);
>  	if (err || create_resp.hdr.status !=3D expected_status) {
> -		ibdev_dbg(&dev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to create DMA region: %d, 0x%x\n",
>  			  err, create_resp.hdr.status);
>  		if (!err)
> @@ -273,14 +275,14 @@ mana_ib_gd_first_dma_region(struct
> mana_ib_dev *dev,
>  	}
>=20
>  	*gdma_region =3D create_resp.dma_region_handle;
> -	ibdev_dbg(&dev->ib_dev, "Created DMA region handle 0x%llx\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "Created DMA region handle
> 0x%llx\n",
>  		  *gdma_region);
>=20
>  	return 0;
>  }
>=20
>  static int
> -mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct
> gdma_context *gc,
> +mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev, struct
> +gdma_context *gc,
>  			  struct gdma_dma_region_add_pages_req *add_req,
>  			  unsigned int num_pages, u32 expected_status)
> { @@ -296,7 +298,7 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev
> *dev, struct gdma_context *gc,
>  	err =3D mana_gd_send_request(gc, add_req_msg_size, add_req,
>  				   sizeof(add_resp), &add_resp);
>  	if (err || add_resp.hdr.status !=3D expected_status) {
> -		ibdev_dbg(&dev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to create DMA region: %d, 0x%x\n",
>  			  err, add_resp.hdr.status);
>=20
> @@ -309,7 +311,8 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev
> *dev, struct gdma_context *gc,
>  	return 0;
>  }
>=20
> -int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct
> ib_umem *umem,
> +int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
> +				 struct ib_umem *umem,
>  				 mana_handle_t *gdma_region)
>  {
>  	struct gdma_dma_region_add_pages_req *add_req =3D NULL; @@ -
> 329,14 +332,14 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev
> *dev, struct ib_umem *umem,
>  	void *request_buf;
>  	int err;
>=20
> -	mdev =3D dev->gdma_dev;
> +	mdev =3D mib_dev->gdma_dev;
>  	gc =3D mdev->gdma_context;
>  	hwc =3D gc->hwc.driver_data;
>=20
>  	/* Hardware requires dma region to align to chosen page size */
>  	page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
>  	if (!page_sz) {
> -		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
> +		ibdev_dbg(&mib_dev->ib_dev, "failed to find page size.\n");
>  		return -ENOMEM;
>  	}
>  	num_pages_total =3D ib_umem_num_dma_blocks(umem, page_sz);
> @@ -362,13 +365,13 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
>  	create_req->gdma_page_type =3D order_base_2(page_sz) - PAGE_SHIFT;
>  	create_req->page_count =3D num_pages_total;
>=20
> -	ibdev_dbg(&dev->ib_dev, "size_dma_region %lu
> num_pages_total %lu\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "size_dma_region %lu
> num_pages_total
> +%lu\n",
>  		  umem->length, num_pages_total);
>=20
> -	ibdev_dbg(&dev->ib_dev, "page_sz %lu offset_in_page %u\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "page_sz %lu offset_in_page %u\n",
>  		  page_sz, create_req->offset_in_page);
>=20
> -	ibdev_dbg(&dev->ib_dev, "num_pages_to_handle %lu,
> gdma_page_type %u",
> +	ibdev_dbg(&mib_dev->ib_dev, "num_pages_to_handle %lu,
> gdma_page_type
> +%u",
>  		  num_pages_to_handle, create_req->gdma_page_type);
>=20
>  	page_addr_list =3D create_req->page_addr_list; @@ -385,7 +388,7 @@
> int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct
> ib_umem *umem,
>=20
>  		if (!num_pages_processed) {
>  			/* First create message */
> -			err =3D mana_ib_gd_first_dma_region(dev, gc,
> create_req,
> +			err =3D mana_ib_gd_first_dma_region(mib_dev, gc,
> create_req,
>  							  tail, gdma_region,
>  							  expected_status);
>  			if (err)
> @@ -400,7 +403,7 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
>  			page_addr_list =3D add_req->page_addr_list;
>  		} else {
>  			/* Subsequent create messages */
> -			err =3D mana_ib_gd_add_dma_region(dev, gc, add_req,
> tail,
> +			err =3D mana_ib_gd_add_dma_region(mib_dev, gc,
> add_req, tail,
>  							expected_status);
>  			if (err)
>  				break;
> @@ -417,20 +420,20 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *dev, struct ib_umem *umem,
>  	}
>=20
>  	if (err)
> -		mana_ib_gd_destroy_dma_region(dev, *gdma_region);
> +		mana_ib_gd_destroy_dma_region(mib_dev, *gdma_region);
>=20
>  out:
>  	kfree(request_buf);
>  	return err;
>  }
>=20
> -int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64
> gdma_region)
> +int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *mib_dev, u64
> +gdma_region)
>  {
> -	struct gdma_dev *mdev =3D dev->gdma_dev;
> +	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
>  	struct gdma_context *gc;
>=20
>  	gc =3D mdev->gdma_context;
> -	ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n",
> gdma_region);
> +	ibdev_dbg(&mib_dev->ib_dev, "destroy dma region 0x%llx\n",
> +gdma_region);
>=20
>  	return mana_gd_destroy_dma_region(gc, gdma_region);  } @@ -
> 440,14 +443,14 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext,
> struct vm_area_struct *vma)
>  	struct mana_ib_ucontext *mana_ucontext =3D
>  		container_of(ibcontext, struct mana_ib_ucontext,
> ibucontext);
>  	struct ib_device *ibdev =3D ibcontext->device;
> -	struct mana_ib_dev *mdev;
> +	struct mana_ib_dev *mib_dev;
>  	struct gdma_context *gc;
>  	phys_addr_t pfn;
>  	pgprot_t prot;
>  	int ret;
>=20
> -	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev->gdma_dev->gdma_context;
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	gc =3D mib_dev->gdma_dev->gdma_context;
>=20
>  	if (vma->vm_pgoff !=3D 0) {
>  		ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma-
> >vm_pgoff); diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 502cc8672eef..ee4efd0af278 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -92,10 +92,11 @@ struct mana_ib_rwq_ind_table {
>  	struct ib_rwq_ind_table ib_ind_table;
>  };
>=20
> -int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct
> ib_umem *umem,
> +int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
> +				 struct ib_umem *umem,
>  				 mana_handle_t *gdma_region);
>=20
> -int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
> +int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *mib_dev,
>  				  mana_handle_t gdma_region);
>=20
>  struct ib_wq *mana_ib_create_wq(struct ib_pd *pd, @@ -129,9 +130,9 @@
> int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>=20
>  int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
>=20
> -int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port_id,
> +int mana_ib_cfg_vport(struct mana_ib_dev *mib_dev, u32 port_id,
>  		      struct mana_ib_pd *pd, u32 doorbell_id); -void
> mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
> +void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct
> mana_ib_pd
> +*pd,
>  			 u32 port);
>=20
>  int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *=
attr,
> diff --git a/drivers/infiniband/hw/mana/mr.c
> b/drivers/infiniband/hw/mana/mr.c index 351207c60eb6..f6a53906204d
> 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -25,12 +25,13 @@ mana_ib_verbs_to_gdma_access_flags(int
> access_flags)
>  	return flags;
>  }
>=20
> -static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct
> mana_ib_mr *mr,
> +static int mana_ib_gd_create_mr(struct mana_ib_dev *mib_dev,
> +				struct mana_ib_mr *mr,
>  				struct gdma_create_mr_params *mr_params)
> {
> +	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
>  	struct gdma_create_mr_response resp =3D {};
>  	struct gdma_create_mr_request req =3D {};
> -	struct gdma_dev *mdev =3D dev->gdma_dev;
>  	struct gdma_context *gc;
>  	int err;
>=20
> @@ -49,7 +50,7 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> *dev, struct mana_ib_mr *mr,
>  		break;
>=20
>  	default:
> -		ibdev_dbg(&dev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "invalid param (GDMA_MR_TYPE) passed,
> type %d\n",
>  			  req.mr_type);
>  		return -EINVAL;
> @@ -58,7 +59,7 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> *dev, struct mana_ib_mr *mr,
>  	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> &resp);
>=20
>  	if (err || resp.hdr.status) {
> -		ibdev_dbg(&dev->ib_dev, "Failed to create mr %d, %u", err,
> +		ibdev_dbg(&mib_dev->ib_dev, "Failed to create mr %d, %u",
> err,
>  			  resp.hdr.status);
>  		if (!err)
>  			err =3D -EPROTO;
> @@ -73,11 +74,11 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> *dev, struct mana_ib_mr *mr,
>  	return 0;
>  }
>=20
> -static int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
> +static int mana_ib_gd_destroy_mr(struct mana_ib_dev *mib_dev, u64
> +mr_handle)
>  {
>  	struct gdma_destroy_mr_response resp =3D {};
> +	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
>  	struct gdma_destroy_mr_request req =3D {};
> -	struct gdma_dev *mdev =3D dev->gdma_dev;
>  	struct gdma_context *gc;
>  	int err;
>=20
> @@ -107,12 +108,12 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  	struct mana_ib_pd *pd =3D container_of(ibpd, struct mana_ib_pd,
> ibpd);
>  	struct gdma_create_mr_params mr_params =3D {};
>  	struct ib_device *ibdev =3D ibpd->device;
> -	struct mana_ib_dev *dev;
> +	struct mana_ib_dev *mib_dev;
>  	struct mana_ib_mr *mr;
>  	u64 dma_region_handle;
>  	int err;
>=20
> -	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
>  	ibdev_dbg(ibdev,
>  		  "start 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
> @@ -133,7 +134,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  		goto err_free;
>  	}
>=20
> -	err =3D mana_ib_gd_create_dma_region(dev, mr->umem,
> &dma_region_handle);
> +	err =3D mana_ib_gd_create_dma_region(mib_dev, mr->umem,
> +&dma_region_handle);
>  	if (err) {
>  		ibdev_dbg(ibdev, "Failed create dma region for user-
> mr, %d\n",
>  			  err);
> @@ -151,7 +152,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  	mr_params.gva.access_flags =3D
>  		mana_ib_verbs_to_gdma_access_flags(access_flags);
>=20
> -	err =3D mana_ib_gd_create_mr(dev, mr, &mr_params);
> +	err =3D mana_ib_gd_create_mr(mib_dev, mr, &mr_params);
>  	if (err)
>  		goto err_dma_region;
>=20
> @@ -164,7 +165,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  	return &mr->ibmr;
>=20
>  err_dma_region:
> -	mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
> +	mana_gd_destroy_dma_region(mib_dev->gdma_dev-
> >gdma_context,
>  				   dma_region_handle);
>=20
>  err_umem:
> @@ -179,12 +180,12 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct
> ib_udata *udata)  {
>  	struct mana_ib_mr *mr =3D container_of(ibmr, struct mana_ib_mr,
> ibmr);
>  	struct ib_device *ibdev =3D ibmr->device;
> -	struct mana_ib_dev *dev;
> +	struct mana_ib_dev *mib_dev;
>  	int err;
>=20
> -	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
>=20
> -	err =3D mana_ib_gd_destroy_mr(dev, mr->mr_handle);
> +	err =3D mana_ib_gd_destroy_mr(mib_dev, mr->mr_handle);
>  	if (err)
>  		return err;
>=20
> diff --git a/drivers/infiniband/hw/mana/qp.c
> b/drivers/infiniband/hw/mana/qp.c index 4b3b5b274e84..2e3a57123ed7
> 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -5,7 +5,7 @@
>=20
>  #include "mana_ib.h"
>=20
> -static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
> +static int mana_ib_cfg_vport_steering(struct mana_ib_dev *mib_dev,
>  				      struct net_device *ndev,
>  				      mana_handle_t default_rxobj,
>  				      mana_handle_t ind_table[],
> @@ -21,7 +21,7 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *dev,
>  	u32 req_buf_size;
>  	int i, err;
>=20
> -	mdev =3D dev->gdma_dev;
> +	mdev =3D mib_dev->gdma_dev;
>  	gc =3D mdev->gdma_context;
>=20
>  	req_buf_size =3D
> @@ -55,10 +55,10 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *dev,
>  	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
>  	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
>  	 */
> -	ibdev_dbg(&dev->ib_dev, "ind table size %u\n", 1 <<
> log_ind_tbl_size);
> +	ibdev_dbg(&mib_dev->ib_dev, "ind table size %u\n", 1 <<
> +log_ind_tbl_size);
>  	for (i =3D 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
>  		req_indir_tab[i] =3D ind_table[i % (1 << log_ind_tbl_size)];
> -		ibdev_dbg(&dev->ib_dev, "index %u handle 0x%llx\n", i,
> +		ibdev_dbg(&mib_dev->ib_dev, "index %u handle 0x%llx\n", i,
>  			  req_indir_tab[i]);
>  	}
>=20
> @@ -68,7 +68,7 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *dev,
>  	else
>  		netdev_rss_key_fill(req->hashkey, MANA_HASH_KEY_SIZE);
>=20
> -	ibdev_dbg(&dev->ib_dev, "vport handle %llu default_rxobj 0x%llx\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "vport handle %llu default_rxobj
> +0x%llx\n",
>  		  req->vport, default_rxobj);
>=20
>  	err =3D mana_gd_send_request(gc, req_buf_size, req, sizeof(resp),
> &resp); @@ -97,12 +97,12 @@ static int mana_ib_create_qp_rss(struct ib_qp
> *ibqp, struct ib_pd *pd,
>  				 struct ib_udata *udata)
>  {
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp,
> ibqp);
> -	struct mana_ib_dev *mdev =3D
> +	struct mana_ib_dev *mib_dev =3D
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
>  	struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
>  	struct mana_ib_create_qp_rss_resp resp =3D {};
>  	struct mana_ib_create_qp_rss ucmd =3D {};
> -	struct gdma_dev *gd =3D mdev->gdma_dev;
> +	struct gdma_dev *gd =3D mib_dev->gdma_dev;

Need to follow the "reverse tree" style along with the rest of driver.

>  	mana_handle_t *mana_ind_table;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
> @@ -123,21 +123,21 @@ static int mana_ib_create_qp_rss(struct ib_qp
> *ibqp, struct ib_pd *pd,
>=20
>  	ret =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
>  	if (ret) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed copy from udata for create rss-qp, err %d\n",
>  			  ret);
>  		return ret;
>  	}
>=20
>  	if (attr->cap.max_recv_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Requested max_recv_wr %d exceeding limit\n",
>  			  attr->cap.max_recv_wr);
>  		return -EINVAL;
>  	}
>=20
>  	if (attr->cap.max_recv_sge > MAX_RX_WQE_SGL_ENTRIES) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Requested max_recv_sge %d exceeding limit\n",
>  			  attr->cap.max_recv_sge);
>  		return -EINVAL;
> @@ -145,14 +145,14 @@ static int mana_ib_create_qp_rss(struct ib_qp
> *ibqp, struct ib_pd *pd,
>=20
>  	ind_tbl_size =3D 1 << ind_tbl->log_ind_tbl_size;
>  	if (ind_tbl_size > MANA_INDIRECT_TABLE_SIZE) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Indirect table size %d exceeding limit\n",
>  			  ind_tbl_size);
>  		return -EINVAL;
>  	}
>=20
>  	if (ucmd.rx_hash_function !=3D MANA_IB_RX_HASH_FUNC_TOEPLITZ) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "RX Hash function is not supported, %d\n",
>  			  ucmd.rx_hash_function);
>  		return -EINVAL;
> @@ -161,14 +161,14 @@ static int mana_ib_create_qp_rss(struct ib_qp
> *ibqp, struct ib_pd *pd,
>  	/* IB ports start with 1, MANA start with 0 */
>  	port =3D ucmd.port;
>  	if (port < 1 || port > mc->num_ports) {
> -		ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating
> qp\n",
> +		ibdev_dbg(&mib_dev->ib_dev, "Invalid port %u in creating
> qp\n",
>  			  port);
>  		return -EINVAL;
>  	}
>  	ndev =3D mc->ports[port - 1];
>  	mpc =3D netdev_priv(ndev);
>=20
> -	ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d port %d\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "rx_hash_function %d port %d\n",
>  		  ucmd.rx_hash_function, port);
>=20
>  	mana_ind_table =3D kcalloc(ind_tbl_size, sizeof(mana_handle_t), @@ -
> 210,7 +210,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, stru=
ct
> ib_pd *pd,
>  		wq->id =3D wq_spec.queue_index;
>  		cq->id =3D cq_spec.queue_index;
>=20
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
>  			  ret, wq->rx_object, wq->id, cq->id);
>=20
> @@ -221,7 +221,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,
> struct ib_pd *pd,
>  	}
>  	resp.num_entries =3D i;
>=20
> -	ret =3D mana_ib_cfg_vport_steering(mdev, ndev, wq->rx_object,
> +	ret =3D mana_ib_cfg_vport_steering(mib_dev, ndev, wq->rx_object,
>  					 mana_ind_table,
>  					 ind_tbl->log_ind_tbl_size,
>  					 ucmd.rx_hash_key_len,
> @@ -231,7 +231,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,
> struct ib_pd *pd,
>=20
>  	ret =3D ib_copy_to_udata(udata, &resp, sizeof(resp));
>  	if (ret) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to copy to udata create rss-qp, %d\n",
>  			  ret);
>  		goto fail;
> @@ -259,7 +259,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,  {
>  	struct mana_ib_pd *pd =3D container_of(ibpd, struct mana_ib_pd,
> ibpd);
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp,
> ibqp);
> -	struct mana_ib_dev *mdev =3D
> +	struct mana_ib_dev *mib_dev =3D
>  		container_of(ibpd->device, struct mana_ib_dev, ib_dev);
>  	struct mana_ib_cq *send_cq =3D
>  		container_of(attr->send_cq, struct mana_ib_cq, ibcq); @@ -
> 267,7 +267,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  		rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
>  					  ibucontext);
>  	struct mana_ib_create_qp_resp resp =3D {};
> -	struct gdma_dev *gd =3D mdev->gdma_dev;
> +	struct gdma_dev *gd =3D mib_dev->gdma_dev;
>  	struct mana_ib_create_qp ucmd =3D {};
>  	struct mana_obj_spec wq_spec =3D {};
>  	struct mana_obj_spec cq_spec =3D {};
> @@ -285,7 +285,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>=20
>  	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
>  	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to copy from udata create qp-raw, %d\n",
> err);
>  		return err;
>  	}
> @@ -296,14 +296,14 @@ static int mana_ib_create_qp_raw(struct ib_qp
> *ibqp, struct ib_pd *ibpd,
>  		return -EINVAL;
>=20
>  	if (attr->cap.max_send_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Requested max_send_wr %d exceeding limit\n",
>  			  attr->cap.max_send_wr);
>  		return -EINVAL;
>  	}
>=20
>  	if (attr->cap.max_send_sge > MAX_TX_WQE_SGL_ENTRIES) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Requested max_send_sge %d exceeding limit\n",
>  			  attr->cap.max_send_sge);
>  		return -EINVAL;
> @@ -311,38 +311,38 @@ static int mana_ib_create_qp_raw(struct ib_qp
> *ibqp, struct ib_pd *ibpd,
>=20
>  	ndev =3D mc->ports[port - 1];
>  	mpc =3D netdev_priv(ndev);
> -	ibdev_dbg(&mdev->ib_dev, "port %u ndev %p mpc %p\n", port,
> ndev, mpc);
> +	ibdev_dbg(&mib_dev->ib_dev, "port %u ndev %p mpc %p\n", port,
> ndev,
> +mpc);
>=20
> -	err =3D mana_ib_cfg_vport(mdev, port - 1, pd, mana_ucontext-
> >doorbell);
> +	err =3D mana_ib_cfg_vport(mib_dev, port - 1, pd,
> +mana_ucontext->doorbell);
>  	if (err)
>  		return -ENODEV;
>=20
>  	qp->port =3D port;
>=20
> -	ibdev_dbg(&mdev->ib_dev, "ucmd sq_buf_addr 0x%llx port %u\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "ucmd sq_buf_addr 0x%llx
> port %u\n",
>  		  ucmd.sq_buf_addr, ucmd.port);
>=20
>  	umem =3D ib_umem_get(ibpd->device, ucmd.sq_buf_addr,
> ucmd.sq_buf_size,
>  			   IB_ACCESS_LOCAL_WRITE);
>  	if (IS_ERR(umem)) {
>  		err =3D PTR_ERR(umem);
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to get umem for create qp-raw, err %d\n",
>  			  err);
>  		goto err_free_vport;
>  	}
>  	qp->sq_umem =3D umem;
>=20
> -	err =3D mana_ib_gd_create_dma_region(mdev, qp->sq_umem,
> +	err =3D mana_ib_gd_create_dma_region(mib_dev, qp->sq_umem,
>  					   &qp->sq_gdma_region);
>  	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to create dma region for create qp-
> raw, %d\n",
>  			  err);
>  		goto err_release_umem;
>  	}
>=20
> -	ibdev_dbg(&mdev->ib_dev,
> +	ibdev_dbg(&mib_dev->ib_dev,
>  		  "mana_ib_gd_create_dma_region ret %d gdma_region
> 0x%llx\n",
>  		  err, qp->sq_gdma_region);
>=20
> @@ -358,7 +358,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	err =3D mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ,
> &wq_spec,
>  				 &cq_spec, &qp->tx_object);
>  	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to create wq for create raw-qp, err %d\n",
>  			  err);
>  		goto err_destroy_dma_region;
> @@ -371,7 +371,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	qp->sq_id =3D wq_spec.queue_index;
>  	send_cq->id =3D cq_spec.queue_index;
>=20
> -	ibdev_dbg(&mdev->ib_dev,
> +	ibdev_dbg(&mib_dev->ib_dev,
>  		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
>  		  qp->tx_object, qp->sq_id, send_cq->id);
>=20
> @@ -381,7 +381,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>=20
>  	err =3D ib_copy_to_udata(udata, &resp, sizeof(resp));
>  	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed copy udata for create qp-raw, %d\n",
>  			  err);
>  		goto err_destroy_wq_obj;
> @@ -393,13 +393,13 @@ static int mana_ib_create_qp_raw(struct ib_qp
> *ibqp, struct ib_pd *ibpd,
>  	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
>=20
>  err_destroy_dma_region:
> -	mana_ib_gd_destroy_dma_region(mdev, qp->sq_gdma_region);
> +	mana_ib_gd_destroy_dma_region(mib_dev, qp->sq_gdma_region);
>=20
>  err_release_umem:
>  	ib_umem_release(umem);
>=20
>  err_free_vport:
> -	mana_ib_uncfg_vport(mdev, pd, port - 1);
> +	mana_ib_uncfg_vport(mib_dev, pd, port - 1);
>=20
>  	return err;
>  }
> @@ -435,9 +435,9 @@ static int mana_ib_destroy_qp_rss(struct
> mana_ib_qp *qp,
>  				  struct ib_rwq_ind_table *ind_tbl,
>  				  struct ib_udata *udata)
>  {
> -	struct mana_ib_dev *mdev =3D
> +	struct mana_ib_dev *mib_dev =3D
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> -	struct gdma_dev *gd =3D mdev->gdma_dev;
> +	struct gdma_dev *gd =3D mib_dev->gdma_dev;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
>  	struct net_device *ndev;
> @@ -452,7 +452,7 @@ static int mana_ib_destroy_qp_rss(struct
> mana_ib_qp *qp,
>  	for (i =3D 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
>  		ibwq =3D ind_tbl->ind_tbl[i];
>  		wq =3D container_of(ibwq, struct mana_ib_wq, ibwq);
> -		ibdev_dbg(&mdev->ib_dev, "destroying wq-
> >rx_object %llu\n",
> +		ibdev_dbg(&mib_dev->ib_dev, "destroying wq-
> >rx_object %llu\n",
>  			  wq->rx_object);
>  		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
>  	}
> @@ -462,9 +462,9 @@ static int mana_ib_destroy_qp_rss(struct
> mana_ib_qp *qp,
>=20
>  static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata
> *udata)  {
> -	struct mana_ib_dev *mdev =3D
> +	struct mana_ib_dev *mib_dev =3D
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> -	struct gdma_dev *gd =3D mdev->gdma_dev;
> +	struct gdma_dev *gd =3D mib_dev->gdma_dev;
>  	struct ib_pd *ibpd =3D qp->ibqp.pd;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
> @@ -479,11 +479,11 @@ static int mana_ib_destroy_qp_raw(struct
> mana_ib_qp *qp, struct ib_udata *udata)
>  	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
>=20
>  	if (qp->sq_umem) {
> -		mana_ib_gd_destroy_dma_region(mdev, qp-
> >sq_gdma_region);
> +		mana_ib_gd_destroy_dma_region(mib_dev, qp-
> >sq_gdma_region);
>  		ib_umem_release(qp->sq_umem);
>  	}
>=20
> -	mana_ib_uncfg_vport(mdev, pd, qp->port - 1);
> +	mana_ib_uncfg_vport(mib_dev, pd, qp->port - 1);
>=20
>  	return 0;
>  }
> diff --git a/drivers/infiniband/hw/mana/wq.c
> b/drivers/infiniband/hw/mana/wq.c index 372d361510e0..56bc2b8b6690
> 100644
> --- a/drivers/infiniband/hw/mana/wq.c
> +++ b/drivers/infiniband/hw/mana/wq.c
> @@ -9,7 +9,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>  				struct ib_wq_init_attr *init_attr,
>  				struct ib_udata *udata)
>  {
> -	struct mana_ib_dev *mdev =3D
> +	struct mana_ib_dev *mib_dev =3D
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
>  	struct mana_ib_create_wq ucmd =3D {};
>  	struct mana_ib_wq *wq;
> @@ -21,7 +21,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>=20
>  	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
>  	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to copy from udata for create wq, %d\n", err);
>  		return ERR_PTR(err);
>  	}
> @@ -30,13 +30,14 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>  	if (!wq)
>  		return ERR_PTR(-ENOMEM);
>=20
> -	ibdev_dbg(&mdev->ib_dev, "ucmd wq_buf_addr 0x%llx\n",
> ucmd.wq_buf_addr);
> +	ibdev_dbg(&mib_dev->ib_dev, "ucmd wq_buf_addr 0x%llx\n",
> +		  ucmd.wq_buf_addr);
>=20
>  	umem =3D ib_umem_get(pd->device, ucmd.wq_buf_addr,
> ucmd.wq_buf_size,
>  			   IB_ACCESS_LOCAL_WRITE);
>  	if (IS_ERR(umem)) {
>  		err =3D PTR_ERR(umem);
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to get umem for create wq, err %d\n", err);
>  		goto err_free_wq;
>  	}
> @@ -46,15 +47,15 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>  	wq->wq_buf_size =3D ucmd.wq_buf_size;
>  	wq->rx_object =3D INVALID_MANA_HANDLE;
>=20
> -	err =3D mana_ib_gd_create_dma_region(mdev, wq->umem, &wq-
> >gdma_region);
> +	err =3D mana_ib_gd_create_dma_region(mib_dev, wq->umem,
> +&wq->gdma_region);
>  	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> +		ibdev_dbg(&mib_dev->ib_dev,
>  			  "Failed to create dma region for create wq, %d\n",
>  			  err);
>  		goto err_release_umem;
>  	}
>=20
> -	ibdev_dbg(&mdev->ib_dev,
> +	ibdev_dbg(&mib_dev->ib_dev,
>  		  "mana_ib_gd_create_dma_region ret %d gdma_region
> 0x%llx\n",
>  		  err, wq->gdma_region);
>=20
> @@ -82,11 +83,11 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct
> ib_udata *udata)  {
>  	struct mana_ib_wq *wq =3D container_of(ibwq, struct mana_ib_wq,
> ibwq);
>  	struct ib_device *ib_dev =3D ibwq->device;
> -	struct mana_ib_dev *mdev;
> +	struct mana_ib_dev *mib_dev;
>=20
> -	mdev =3D container_of(ib_dev, struct mana_ib_dev, ib_dev);
> +	mib_dev =3D container_of(ib_dev, struct mana_ib_dev, ib_dev);
>=20
> -	mana_ib_gd_destroy_dma_region(mdev, wq->gdma_region);
> +	mana_ib_gd_destroy_dma_region(mib_dev, wq->gdma_region);
>  	ib_umem_release(wq->umem);
>=20
>  	kfree(wq);
> --
> 2.25.1

