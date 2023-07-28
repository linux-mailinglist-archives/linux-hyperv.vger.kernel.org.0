Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB100766238
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 05:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjG1DDE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jul 2023 23:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjG1DCs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jul 2023 23:02:48 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E913C30;
        Thu, 27 Jul 2023 20:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+9tdSH9G5Fq9kzKpXcxlvPM+WgBkhPbZfRorrvb067bitQ9HNvi/DYYnkg+rlWWtU/eMp5uSw/NKKbQf2FyBO5j0zd/QOGuXtOvEk+dmmdDRTjRCANOzz+zvfZVDzP15Olf81TSQQ34Unwp74TGfqJNoRWF0aNQJSlrX+N7sE3aTnMiTj/1W1O2ZQRWNJNW02Jpr3SyVzTHOIv1BTcmHMO1IemjtwSvQyOUOH6yVVUIsX9MRFp5c/HkQZw3NcuCObpK3M4mVZkTraZXSnMNZaHDSWEUG8FbwL7NMkP7MfNmKZaVcNWmIVJi+so59ZxkVNrA89J+8Urs+6mZUxslwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UXyMFo2kWHP66DhKiTFq2xGP+VjF2i+jHflzuqyopA=;
 b=I7QuNr3VgMdc2c1xK6vcmiTzUaTmlhJOoIIsKif6hRattlk8JBb/5kvuIciepvDR2Qohojf0i5UtAyHtZdKRblsEWzQ7OxLN1hqjaxJsK6LOxYhwluGp/GXfT0a45i7TauRYDBs90KYWtuYI77/skx4erf9EIjQOgPDxN3LLu/njVAuTTwqAvwuI8Jgcw9NwjAZyfkFYbiJpQg4DY+TJQ/0/srf5CNU4x4Mq2r7J+cmPBT6SJBK7+wz8hAkIWAfBMceknNN6Y4Ylx/kJSdrw45fMiAH3bc7ifyGoBgOQTknEJxK3awA/gqBZgQuY2x9b/14or+ghqc3tiH4wz43swg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UXyMFo2kWHP66DhKiTFq2xGP+VjF2i+jHflzuqyopA=;
 b=K350nAQZV7i/CIM8n1e8UFTWWri8NVQOWlnW/gn3zyM9J5GvkQ4uMisXs6LwNiXczK7Msx8LJOZSGoEG8zm3gkl8/MLwarW9brX2vaLDsOoO4rVZisjPFU1JX95lOwgI2Ek/r+2279qYJ+8I/tKLGNRYZ1EX3REVntGPUTDbQJc=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by DS7PR21MB3365.namprd21.prod.outlook.com (2603:10b6:8:81::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 03:02:17 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453%6]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 03:02:17 +0000
From:   Ajay Sharma <sharmaajay@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>,
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
Subject: RE: [EXTERNAL] [Patch v3 1/4] RDMA/mana_ib : Rename all mana_ib_dev
 type variables to mib_dev
Thread-Topic: [EXTERNAL] [Patch v3 1/4] RDMA/mana_ib : Rename all mana_ib_dev
 type variables to mib_dev
Thread-Index: AQHZv/z0jMfgryBY7USriyRhWvgpvq/Of8cA
Date:   Fri, 28 Jul 2023 03:02:17 +0000
Message-ID: <BY5PR21MB1394CE7DDF25FF182B03FC01D606A@BY5PR21MB1394.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-2-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-2-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3f8421a9-19ed-465e-a8a2-745105fc37e0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T03:02:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|DS7PR21MB3365:EE_
x-ms-office365-filtering-correlation-id: 63b33b79-51a0-4947-cc2c-08db8f170d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AxVazWyGBY4IbdPvn9RKTNpKMUyrDdMuQVwYa2OCVJDX9b99xIBtySWTYXfZZ2GEWHOy580/+/RXmJtaTT4V96Vj0cpLvmCDmx0HpHIhC21YLn9kmDIbHrGww16fNYfnL3l5I/Q+ArgRH7Yq8ED2CW1bEQGn6Ac0QOSV1DTaf4ODwvTSRZIWETx2nJ5tE5+1wNDz6DLvqIO5qEnlBG91oRGjF4l9LAcY2VLY9wC/5K2qPHB7CMDptZCbG9ZwB5Q4xLLbg7kxkVpl7sD60oYMhz8YBZ+WMr1tB+OshtmJWsoCbwfwKLd7D5vQadWHD6aHtScxgxmqW/zIgrvdWfiS9Saus6oiU5RpW9o5/aLSmT0g/1AJ2fU7iGnprg/adSWZCMQH4XeWHBim8l6cBhCW6z+J8OwUjD4aCXbBkQsuLwVw1w5tbpp8NwmYnO3EGaBL05UMSfYZ0K71GpkxIdDYpmESkwxXOvQXYxDhAa9/ps/GQTXloV8rIjsOvOahnGEvpMz84G24a2MMJkJ2dwlWyjFRWbQZRyVwgqymuQeJ6MMauC82FSv7crLZmuUg5F3osMSP/lcbB32Hg2K0kFj99nmGem11yI93bxc0nvFPgSbIzKT0IDSOsi5GTVJfQs2wbDet0Bl/9GcPQ3sSZfluX3j9v3cHzRhf4Q6fGQHCWWfm345MiRuuy3Cz1TEGfAdM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(7416002)(38070700005)(921005)(33656002)(30864003)(7696005)(55016003)(53546011)(6506007)(83380400001)(66446008)(64756008)(9686003)(66556008)(186003)(38100700002)(122000001)(107886003)(76116006)(2906002)(66946007)(66476007)(82950400001)(82960400001)(316002)(71200400001)(4326008)(5660300002)(8990500004)(41300700001)(66899021)(8676002)(86362001)(52536014)(54906003)(110136005)(478600001)(10290500003)(8936002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K2T2X7Kvg7CL1v09vTyGh08IDTZGJc9PtRICDGUuC8M58lfOvYZNf+j4zfF9?=
 =?us-ascii?Q?ycWegKrhom+PyEdCExuJN2YcdhCTveoxCoub8Q566JCPT8zsnN+npNNol5sk?=
 =?us-ascii?Q?H7VC5Ak3OWv95u+GGnSkLAEt5/b1Rz4fVQk8/2UFiv/GGUIM0J9PVVRRIy+m?=
 =?us-ascii?Q?JuJ67gVDhYV/FC1x9jglpQE6rB+XuW6cetbcig+5kIZSFwf56exL/DOMHl6E?=
 =?us-ascii?Q?izM2+xC7n+dnKsx+Pl8GVbDta89CyYZo2L/Uoj/nIkqIpf3oDQ2xEYZtVkqK?=
 =?us-ascii?Q?0doMJ9Yo7N5gURgoRxU3sNNM5UQWFEkP7xWxeSGhVGvSFDgRHC7hL+KQuTYy?=
 =?us-ascii?Q?GF8NKOrv5RumcbxS+cIDvkLhPhevGI0lV3C1nAbyY1g9KWzMkALCSsG2pLIo?=
 =?us-ascii?Q?4JCzPBHFyOJDvPv2A4RsnT8wIW/sYJfYhveA+BEkAqNWHy75OPYGPyBfng8Y?=
 =?us-ascii?Q?oS9JiBD+QlB3efuXh+Gk39e9XltanGApzvS7OvemrT1LoFvTTWlx1xNsT+w1?=
 =?us-ascii?Q?kORKKkPgkbBO0dU9XBYqrvQuZlP5j8Fd+0Gm8bHnsiFyLYIzwaaZXsQrSSZ2?=
 =?us-ascii?Q?Ded0P1OsZxKqEJffmDiWV4clttBOJ7y/kuKGVxgYH5rABm+ceQORRasg8Ckk?=
 =?us-ascii?Q?F6jj0LsV/aQWOrfjYiawsdBekPN9mp3LBxQm4GSATehhHWXtXiW4IHiVNkkl?=
 =?us-ascii?Q?8ls7ZS0BG4K+5EBJKpzGgn6QlaonP07ZA0e/8awl91mSrIB14A9wTlYzVpqP?=
 =?us-ascii?Q?Ha/74j15V7m4I8zZ8ad/EfNrnPfakyHDs8xmj+14PDZhJeigvN6T6jNgmq8Z?=
 =?us-ascii?Q?/NOUJHcEOa/xSC5ciGOWxp8Gtdriihuf2jnHhOZ8e9YDG9aMi8vTtxRlrily?=
 =?us-ascii?Q?dy6c0C2Js/0hiY9TkVIGI6DZqx2BEh48qLeL3b4XfazuYMlyuywz69lND8J0?=
 =?us-ascii?Q?aR+Q11arxcfsZZJk4OriycDg4F+KIlfisYAnuujDblkNCSBKeXLNikL1dXiw?=
 =?us-ascii?Q?w9zYxtnmPuroTWKNMRUmiO6ox4yAB1GrRRwRhjJEjeC6LFTrvNLCHV136ty9?=
 =?us-ascii?Q?2OiH2uKy2GpxLlwtRbKKpxmmxwI5IPvPXVpNSPhpdf1vF1UI0fW9lekEW9UI?=
 =?us-ascii?Q?dsbuZYCZiNFmyjxM5gco5NWzgplMbVfdzLOqqiet9/qZmeyxFDz/ddQUDakP?=
 =?us-ascii?Q?1sZKWI1mZveqnHI6Kdo6Hk6jFKBg9vzD9klM25KzIcAVNrWEHaOPV89u8bzp?=
 =?us-ascii?Q?2ae1TkjkGVcvygy+VMkk3BvPxdHGRE/eFO5++zruHppc0LhSwsVdNcxyL3Ge?=
 =?us-ascii?Q?N1xwyhRrT0zcrreP7F6Lq7ADwPpd/NyaGOoZG3frA8t9aEgCDrzlzwQaBrnq?=
 =?us-ascii?Q?YzFiN4eiKec4OykumK/zxYV+CK4TG9InHgFyWQyaHvVOS3qyF14gioOykJNw?=
 =?us-ascii?Q?ZrkDzA+tX/WY3Z1tvXsmyfJsSJHDhw7CiIoZ0dIWUsPvbp4reCKmq6bTj+Db?=
 =?us-ascii?Q?nrTAGx7GX7wr8f2+O7crnMflU/eQ049EZeLM8OZL8wi7Q9ss79P6Loz96JkN?=
 =?us-ascii?Q?8VaEykHajjh8FI0LIg0mut/N/4RN5QlkD/WykoaU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b33b79-51a0-4947-cc2c-08db8f170d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 03:02:17.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQuebuH+dwkV904VrJkJex1g50zXEdtAR0z0Vc8msAd0vL5AQqC47/K7vboGa+kJyNPurd6U3Mh+RWHEaiug4TPQXgz9tTCwXU0MMOedCbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

+Long

> -----Original Message-----
> From: sharmaajay@linuxonhyperv.com <sharmaajay@linuxonhyperv.com>
> Sent: Wednesday, July 26, 2023 3:08 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: linux-rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> <sharmaajay@microsoft.com>
> Subject: [EXTERNAL] [Patch v3 1/4] RDMA/mana_ib : Rename all mana_ib_dev
> type variables to mib_dev
>=20
> From: Ajay Sharma <sharmaajay@microsoft.com>
>=20
> This patch does not introduce any functional changes. It creates naming
> convention to distinguish especially when used in the same function.Renam=
ing
> all mana_ib_dev type variables to mib_dev to have clean separation betwee=
n
> eth dev and ibdev variables.
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
> @@ -11,10 +11,10 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t
> ib_cq_init_attr *attr,
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
> -	ibdev_dbg(&dev->ib_dev, "mdev=3D%p id=3D%d num_ports=3D%d\n", mdev,
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
> -void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
> +void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd
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
> -int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_=
pd
> *pd,
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
> +		ibdev_dbg(&mib_dev->ib_dev, "Failed to configure vPort
> %d\n",
> +			  err);
>  		return err;
>  	}
>=20
> @@ -65,7 +67,7 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32
> port, struct mana_ib_pd *pd,
>  	pd->tx_shortform_allowed =3D mpc->tx_shortform_allowed;
>  	pd->tx_vp_offset =3D mpc->tx_vp_offset;
>=20
> -	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id
> %x\n",
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
> @@ -93,7 +95,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udat=
a
> *udata)
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
>  			  "Failed to destroy pd_handle 0x%llx err %d status
> %u",
>  			  pd->pd_handle, err, resp.hdr.status);
>  		if (!err)
> @@ -204,14 +206,14 @@ int mana_ib_alloc_ucontext(struct ib_ucontext
> *ibcontext,
>  	struct mana_ib_ucontext *ucontext =3D
>  		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
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
>  		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
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
>  	ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
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
> @@ -273,14 +275,14 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev
> *dev,
>  	}
>=20
>  	*gdma_region =3D create_resp.dma_region_handle;
> -	ibdev_dbg(&dev->ib_dev, "Created DMA region handle 0x%llx\n",
> +	ibdev_dbg(&mib_dev->ib_dev, "Created DMA region handle 0x%llx\n",
>  		  *gdma_region);
>=20
>  	return 0;
>  }
>=20
>  static int
> -mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct gdma_context
> *gc,
> +mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev, struct
> +gdma_context *gc,
>  			  struct gdma_dma_region_add_pages_req *add_req,
>  			  unsigned int num_pages, u32 expected_status)  { @@
> -296,7 +298,7 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev *dev,
> struct gdma_context *gc,
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
> -	ibdev_dbg(&dev->ib_dev, "size_dma_region %lu num_pages_total
> %lu\n",
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
> 440,14 +443,14 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct
> vm_area_struct *vma)
>  	struct mana_ib_ucontext *mana_ucontext =3D
>  		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
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
> +void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd
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
>  			  "invalid param (GDMA_MR_TYPE) passed, type
> %d\n",
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
>  	struct mana_ib_pd *pd =3D container_of(ibpd, struct mana_ib_pd, ibpd);
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
>  		ibdev_dbg(ibdev, "Failed create dma region for user-mr, %d\n",
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
> +	mana_gd_destroy_dma_region(mib_dev->gdma_dev->gdma_context,
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
> -	ibdev_dbg(&dev->ib_dev, "ind table size %u\n", 1 << log_ind_tbl_size);
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
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> -	struct mana_ib_dev *mdev =3D
> +	struct mana_ib_dev *mib_dev =3D
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
>  	struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
>  	struct mana_ib_create_qp_rss_resp resp =3D {};
>  	struct mana_ib_create_qp_rss ucmd =3D {};
> -	struct gdma_dev *gd =3D mdev->gdma_dev;
> +	struct gdma_dev *gd =3D mib_dev->gdma_dev;
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
> -		ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating qp\n",
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
>  	struct mana_ib_pd *pd =3D container_of(ibpd, struct mana_ib_pd, ibpd);
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> -	struct mana_ib_dev *mdev =3D
> +	struct mana_ib_dev *mib_dev =3D
>  		container_of(ibpd->device, struct mana_ib_dev, ib_dev);
>  	struct mana_ib_cq *send_cq =3D
>  		container_of(attr->send_cq, struct mana_ib_cq, ibcq); @@ -
> 267,7 +267,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, stru=
ct
> ib_pd *ibpd,
>  		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
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
>  			  "Failed to copy from udata create qp-raw, %d\n", err);
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
> -	ibdev_dbg(&mdev->ib_dev, "port %u ndev %p mpc %p\n", port, ndev,
> mpc);
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
> +	ibdev_dbg(&mib_dev->ib_dev, "ucmd sq_buf_addr 0x%llx port %u\n",
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
>  			  "Failed to create dma region for create qp-raw,
> %d\n",
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
> @@ -435,9 +435,9 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp
> *qp,
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
> @@ -452,7 +452,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp
> *qp,
>  	for (i =3D 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
>  		ibwq =3D ind_tbl->ind_tbl[i];
>  		wq =3D container_of(ibwq, struct mana_ib_wq, ibwq);
> -		ibdev_dbg(&mdev->ib_dev, "destroying wq->rx_object %llu\n",
> +		ibdev_dbg(&mib_dev->ib_dev, "destroying wq->rx_object
> %llu\n",
>  			  wq->rx_object);
>  		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
>  	}
> @@ -462,9 +462,9 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp
> *qp,
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

