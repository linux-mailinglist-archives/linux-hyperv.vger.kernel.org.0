Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92076622F
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 05:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjG1DCG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jul 2023 23:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjG1DCE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jul 2023 23:02:04 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66D2685;
        Thu, 27 Jul 2023 20:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhJKeMkCFLVt55Yggo1Iyqzs4KV0sM164JgBLdnMT5y5fQTrI9vmZxWNM+pG+L62OINY5UE3AMN2CIoLdQXcM9LW+Cv5JFD44RBV7RcpU4rPFotEvEMrEBtybbI2i2nB+JA7jSkUWwvPXrkdxDsHdGrLkClZuRhJKFK4fVeFwrb28fnqV0P5+TRc3ThrBYlylTaE2q6TVNXXrkVkdVrX2j9MxzGTZjzoj6mVdO5EhyM4WQwK+ZKMgJ0XKJ88PPZ8KPHT6JgBv9E9+FYrdC+kD+DOohvhG+Pv27Ieu8fu1nNOCXE0si4lOVtvBSO+tHIiQOx/9/MCwTWSB3M+tydn2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wax5sDGPDh+Fc+Dnm1EIohyH4lrGk7q6VrU5FHKNo3A=;
 b=nefDpk2/Hg69wOgKaQiNaLWc1gla10Vp1EOz8ndHDw9JKrUsJRqpQi/wiGt/Y1VsnD86UIJJM7M3cjIG22/WCBpG3xuuJVEANve2mULbUkdWepa2P8NEG1f/hiZK9fCRcJ8xHebqBARhjNT4i9fP8IXq25NfZbr+PTfqQqmCNrcfoarZKAGydnBBwTzce8ev2JepwDgcDc8rNI4MvU7by/xtn/8Hatcy3pJXkQpdV2Jg6ZbaJUvQRgn/5QNljAn1fta4BbivMo5T1jnGw0F37A/DjYk5gn4MKwQaDW0zA3KXW5NsDXIcWtOmwyW06mr69zXowiB8oQlcGvZtEtaNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wax5sDGPDh+Fc+Dnm1EIohyH4lrGk7q6VrU5FHKNo3A=;
 b=L6iKA4fEF/I5ira0rqC9KaQW1p3WeFV2asZzwWXx/Ghi97z8GHoBN6xM1zUJHt79DAze+/hirScOlBWQqcMl3/8NDc+0nScA+aEHSJYyi1ArlX6hYcwHyDywI20mKnPJK/o9EeUy9RMRB6g9V7d10IKlB+XQ76saFIDrEZ+6dQo=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by DS7PR21MB3365.namprd21.prod.outlook.com (2603:10b6:8:81::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 03:01:59 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453%6]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 03:01:59 +0000
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
Subject: RE: [EXTERNAL] [Patch v3 2/4] RDMA/mana_ib : Register Mana IB  device
 with Management SW
Thread-Topic: [EXTERNAL] [Patch v3 2/4] RDMA/mana_ib : Register Mana IB
  device with Management SW
Thread-Index: AQHZv/z0Rh8LmXkf2k2VPQG/L3Ge76/Of7Vw
Date:   Fri, 28 Jul 2023 03:01:59 +0000
Message-ID: <BY5PR21MB139477549C7FBACEE6E52436D606A@BY5PR21MB1394.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-3-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-3-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=98191c8f-e2dc-47fa-99fb-552d05d0fec8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T03:01:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|DS7PR21MB3365:EE_
x-ms-office365-filtering-correlation-id: 53534e4f-9a80-404e-501e-08db8f1702a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cu5aO1Gn72is4/cmzF9tzMPA5H+bxl1tZPlHxesgklbKVmNg/mRVKTydOly6nEOzvMOFKTwe+13vWGggn1J5qgSS1qbtcA4wfLNTjdiUmmhq+cim2gg+Wao0uMuNmDYximJ48Y2/nq26Qti4182fbvuNhfZvTjn4Z+luv0tXBJ6GpC3/SW/E98nhFjng+tA/GUrhLarcUlE0mfJxzqsB5T8qkNAwN8gxQgBemLDB6JLQsCoginx8zJ7+sh57ApOz1JeolKCnGSd9FBY1x97y3W7veFXLTH2stSAqQ8tR1iLg5fjI1kdvOtm9/DjL9FwNXxmewZKwUMl9h7/UWnzWmAw7jGdUq47kVQ/oXYPpFWHk7pSWXr0jU9UPocmVSjjAdSMErkdgf7WxHkgZq0UfgER4YDhs11rXXKh0xg1Y+r7JY8KMpg0VkfH09Z9pwaKdJtb4fWOqVkML0XqD3a0JXHOIuwwOcztLXGK1vvQF+OxqjnieNh8hyeAK6UWZ5tooL6G2wSBaa7wYQ7YeS9aqvKiKM/uwvt23ySTFrMG9w+ucGwfCiOnTLBeutUAJvc9WyxRmWEmJAslWxPbAeKhfo7yjUFUmVUojMer9dmucERPFPb4bdNiVJZSymINQxYBCAUpuBHFt1shsl/Gi0/SQMN3a9OpeY7CdYQ25EKR4fcXgd0JF43f3BtG0HMI1igUk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(7416002)(38070700005)(921005)(33656002)(30864003)(7696005)(55016003)(53546011)(6506007)(83380400001)(66446008)(64756008)(9686003)(66556008)(186003)(38100700002)(122000001)(107886003)(76116006)(2906002)(66946007)(66476007)(82950400001)(82960400001)(316002)(71200400001)(4326008)(5660300002)(8990500004)(41300700001)(66899021)(8676002)(86362001)(52536014)(54906003)(110136005)(478600001)(10290500003)(8936002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GGwV+tdsGyxX6k+lsLiOKu5GJ6UqvqxAi1OyuDhO+RvzUnXQZC/9co3h76Y1?=
 =?us-ascii?Q?qzQxYLF7KBhYnJY3FMK/FVhr4mhhpwByC612Ec2iu99n1Ap0ksrqTlh8Nm+7?=
 =?us-ascii?Q?uC6IYEJMWTKjpM+gXEhmlYVTPObS3/7orvad+/IN7A/5wNueqk7zII2p6e/K?=
 =?us-ascii?Q?BBkww/KDZoRl4Dy+YhXE6zPgNX1BdbLZ1xWoTyjOdgF5veThugiNPRzDUtjS?=
 =?us-ascii?Q?T1dSHB7WMCAVkx768vlic/mnKgPI+Za3PHOMexCrN3F8p+E+bkKWh0FWmGGh?=
 =?us-ascii?Q?x6PI+KGznGHTx2RCvMeL8X9WRf83udL0rzkdwZHwlrHD7cZYr855k6S/T7KV?=
 =?us-ascii?Q?RGcjh1mnEDSkoR5PW8gXgvmMrE63bM9VEqsS7FkB843vbPQbfwdMz281oAKy?=
 =?us-ascii?Q?jcGj6R9P8A0ZUHaRlJTgUjLefYVRTxZvkLBnvoK3j3CTGsNPOiG4GnxO0pz8?=
 =?us-ascii?Q?JyKXHFec5a1DrNeBQboyjZifovSej5QLGnXvpB/BE+jqTtWXgxxiatClI1YQ?=
 =?us-ascii?Q?RJ/28RdGWEaRF5pXCgp9MHSqJLDOdDR5QcrGIjKnsnTGtIBLwt0fg1LjQidJ?=
 =?us-ascii?Q?AaRJEmokrvJ8qbBkVKn72SUOxeDYWzB9h1ejnzWt772Z7dtJJxoM0B17T8Gk?=
 =?us-ascii?Q?8J7CBwZ73WQAAgLVqf6GRhk0ua8eOUiYc07YWBBxyMr5Lwmqci0YN0d/pGfB?=
 =?us-ascii?Q?Ld+z/KCHXZHLdJb0ZYrlzE/LVJEcc9zdvDxbiUc5KzVQjpo7GTKioIH3KEyD?=
 =?us-ascii?Q?nWXTVp/NcWYBc+tz5ElG3F35qOe+Qh0m4AWxSjrG04RErlv7zInV0urk0UGM?=
 =?us-ascii?Q?Lu/WVhX/SKXCjafPf7SRIfYEq4tcGCBVYDdz1bIM8GlkwUFLx0m9y7kATYZy?=
 =?us-ascii?Q?wmoDbxOwcZOUo0yWmWlthhWW4LlMakDwgy0PbfcipNapBx06SzUeAo4FdRto?=
 =?us-ascii?Q?R0HF79Kvtp4iTncwhpCFPqBrefXfJpV421WcrlI3n/r2DkIozWGxwJ7NgFTX?=
 =?us-ascii?Q?PZqDJgBpWApTgGCu/gqlQlhUzcAYiK49lVQOd7bVLXclwxpgCVCmpBam8TuL?=
 =?us-ascii?Q?Njm6wpPhQfcYTmzAr1mzUIX5XR4JZSpfHMS0UyR+xGI5UF3muSevHpNiEAro?=
 =?us-ascii?Q?fCSTODbW/YkSdVNekjhaa1za24+ExAUwWszrNerbbh9JkXpYwauoEe/ApqeO?=
 =?us-ascii?Q?NZMY9ypwZnM0iDu8OuYM1zN3VRefxlmmxy36u1G/EI81dTsR06hHfNwTk007?=
 =?us-ascii?Q?tseXOObsuvsplcyIwt24pg1BoQxNjJHp8y8nES90hlZY1XnaPgE6dc7vvcu4?=
 =?us-ascii?Q?DLTl+I07SKKNgbi16k5KM/gNWETPjAhKHyhQfaXw2hnzGfj+gv/DE+N7iK1c?=
 =?us-ascii?Q?ls5HQr3sOakuvBMnR6rAhup1GAaDn0PSWOdoeu+XLff7F9yGOvUJybxmgvV5?=
 =?us-ascii?Q?q1Ceb+Zg+DSkrG5thhbwqELHITH80KCVHPDZIyiRQWSVfV3GuXI85kLYJIYN?=
 =?us-ascii?Q?Hf9JQOqQd4rFMVefVoy0+QGBGnx2pl3KzY3go8MZFMKlb3DzgbzGs/JVxxJf?=
 =?us-ascii?Q?bkxI2jCxCzQbAuCkdHsGdSNAM49oE6FL+N5AuUrc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53534e4f-9a80-404e-501e-08db8f1702a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 03:01:59.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvR0RcTkU3oQmWD4AjGwVGmdM2DLR9SEySmLoH7Ot4hRRJex38UXnnv5U2960am5D1Fi8d7tEXlKY2eEsHh6mvXMYkMUrjVZdFlSb/2prDc=
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
> Subject: [EXTERNAL] [Patch v3 2/4] RDMA/mana_ib : Register Mana IB device
> with Management SW
>=20
> From: Ajay Sharma <sharmaajay@microsoft.com>
>=20
> Each of the MANA infiniband devices must be registered with the managemen=
t
> software to request services/resources.
> Register the Mana IB device with Management which would later help get an
> adapter handle.
>=20
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c           | 20 +++++--
>  drivers/infiniband/hw/mana/main.c             | 58 ++++++-------------
>  drivers/infiniband/hw/mana/mana_ib.h          |  1 +
>  drivers/infiniband/hw/mana/mr.c               | 17 ++----
>  drivers/infiniband/hw/mana/qp.c               | 10 ++--
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++
>  include/net/mana/gdma.h                       |  3 +
>  7 files changed, 55 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 083f27246ba8..ea4c8c8fc10d 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -78,22 +78,34 @@ static int mana_ib_probe(struct auxiliary_device
> *adev,
>  	mib_dev->ib_dev.num_comp_vectors =3D 1;
>  	mib_dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
>=20
> -	ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
> -				 mdev->gdma_context->dev);
> +	ret =3D mana_gd_register_device(&mib_dev->gc->mana_ib);
>  	if (ret) {
> -		ib_dealloc_device(&mib_dev->ib_dev);
> -		return ret;
> +		ibdev_err(&mib_dev->ib_dev, "Failed to register device, ret
> %d",
> +			  ret);
> +		goto free_ib_device;
>  	}
>=20
> +	ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
> +				 mdev->gdma_context->dev);
> +	if (ret)
> +		goto deregister_device;
> +
>  	dev_set_drvdata(&adev->dev, mib_dev);
>=20
>  	return 0;
> +
> +deregister_device:
> +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
> +free_ib_device:
> +	ib_dealloc_device(&mib_dev->ib_dev);
> +	return ret;
>  }
>=20
>  static void mana_ib_remove(struct auxiliary_device *adev)  {
>  	struct mana_ib_dev *mib_dev =3D dev_get_drvdata(&adev->dev);
>=20
> +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
>  	ib_unregister_device(&mib_dev->ib_dev);
>  	ib_dealloc_device(&mib_dev->ib_dev);
>  }
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 189e774cdab6..2c4e3c496644 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -8,7 +8,7 @@
>  void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd
> *pd,
>  			 u32 port)
>  {
> -	struct gdma_dev *gd =3D mib_dev->gdma_dev;
> +	struct gdma_dev *gd =3D &mib_dev->gc->mana;
>  	struct mana_port_context *mpc;
>  	struct net_device *ndev;
>  	struct mana_context *mc;
> @@ -32,7 +32,7 @@ int mana_ib_cfg_vport(struct mana_ib_dev *mib_dev,
> u32 port,
>  		      struct mana_ib_pd *pd,
>  		      u32 doorbell_id)
>  {
> -	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
> +	struct gdma_dev *mdev =3D &mib_dev->gc->mana;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
>  	struct net_device *ndev;
> @@ -81,17 +81,16 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  	struct gdma_create_pd_req req =3D {};
>  	enum gdma_pd_flags flags =3D 0;
>  	struct mana_ib_dev *mib_dev;
> -	struct gdma_dev *mdev;
> +
>  	int err;
>=20
>  	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	mdev =3D mib_dev->gdma_dev;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
>  			     sizeof(resp));
>=20
>  	req.flags =3D flags;
> -	err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
> +	err =3D mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
>  				   sizeof(resp), &resp);
>=20
>  	if (err || resp.hdr.status) {
> @@ -121,17 +120,15 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct
> ib_udata *udata)
>  	struct gdma_destory_pd_resp resp =3D {};
>  	struct gdma_destroy_pd_req req =3D {};
>  	struct mana_ib_dev *mib_dev;
> -	struct gdma_dev *mdev;
>  	int err;
>=20
>  	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	mdev =3D mib_dev->gdma_dev;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
>  			     sizeof(resp));
>=20
>  	req.pd_handle =3D pd->pd_handle;
> -	err =3D mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
> +	err =3D mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
>  				   sizeof(resp), &resp);
>=20
>  	if (err || resp.hdr.status) {
> @@ -207,17 +204,13 @@ int mana_ib_alloc_ucontext(struct ib_ucontext
> *ibcontext,
>  		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
>  	struct ib_device *ibdev =3D ibcontext->device;
>  	struct mana_ib_dev *mib_dev;
> -	struct gdma_context *gc;
> -	struct gdma_dev *dev;
>  	int doorbell_page;
>  	int ret;
>=20
>  	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	dev =3D mib_dev->gdma_dev;
> -	gc =3D dev->gdma_context;
>=20
>  	/* Allocate a doorbell page index */
> -	ret =3D mana_gd_allocate_doorbell_page(gc, &doorbell_page);
> +	ret =3D mana_gd_allocate_doorbell_page(mib_dev->gc,
> &doorbell_page);
>  	if (ret) {
>  		ibdev_dbg(ibdev, "Failed to allocate doorbell page %d\n", ret);
>  		return ret;
> @@ -236,20 +229,17 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)
>  		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
>  	struct ib_device *ibdev =3D ibcontext->device;
>  	struct mana_ib_dev *mib_dev;
> -	struct gdma_context *gc;
>  	int ret;
>=20
>  	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mib_dev->gdma_dev->gdma_context;
>=20
> -	ret =3D mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
> +	ret =3D mana_gd_destroy_doorbell_page(mib_dev->gc,
> +mana_ucontext->doorbell);
>  	if (ret)
>  		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
> }
>=20
>  static int
>  mana_ib_gd_first_dma_region(struct mana_ib_dev *mib_dev,
> -			    struct gdma_context *gc,
>  			    struct gdma_create_dma_region_req *create_req,
>  			    size_t num_pages, mana_handle_t *gdma_region,
>  			    u32 expected_status)
> @@ -262,7 +252,7 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev
> *mib_dev,
>  		struct_size(create_req, page_addr_list, num_pages);
>  	create_req->page_addr_list_len =3D num_pages;
>=20
> -	err =3D mana_gd_send_request(gc, create_req_msg_size, create_req,
> +	err =3D mana_gd_send_request(mib_dev->gc, create_req_msg_size,
> +create_req,
>  				   sizeof(create_resp), &create_resp);
>  	if (err || create_resp.hdr.status !=3D expected_status) {
>  		ibdev_dbg(&mib_dev->ib_dev,
> @@ -282,7 +272,7 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev
> *mib_dev,  }
>=20
>  static int
> -mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev, struct
> gdma_context *gc,
> +mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev,
>  			  struct gdma_dma_region_add_pages_req *add_req,
>  			  unsigned int num_pages, u32 expected_status)  { @@
> -295,7 +285,7 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev
> *mib_dev, struct gdma_context *gc,
>  			     add_req_msg_size, sizeof(add_resp));
>  	add_req->page_addr_list_len =3D num_pages;
>=20
> -	err =3D mana_gd_send_request(gc, add_req_msg_size, add_req,
> +	err =3D mana_gd_send_request(mib_dev->gc, add_req_msg_size,
> add_req,
>  				   sizeof(add_resp), &add_resp);
>  	if (err || add_resp.hdr.status !=3D expected_status) {
>  		ibdev_dbg(&mib_dev->ib_dev,
> @@ -323,18 +313,14 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *mib_dev,
>  	struct ib_block_iter biter;
>  	size_t max_pgs_add_cmd =3D 0;
>  	size_t max_pgs_create_cmd;
> -	struct gdma_context *gc;
>  	size_t num_pages_total;
> -	struct gdma_dev *mdev;
>  	unsigned long page_sz;
>  	unsigned int tail =3D 0;
>  	u64 *page_addr_list;
>  	void *request_buf;
>  	int err;
>=20
> -	mdev =3D mib_dev->gdma_dev;
> -	gc =3D mdev->gdma_context;
> -	hwc =3D gc->hwc.driver_data;
> +	hwc =3D mib_dev->gc->hwc.driver_data;
>=20
>  	/* Hardware requires dma region to align to chosen page size */
>  	page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0); @@ -
> 388,7 +374,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev
> *mib_dev,
>=20
>  		if (!num_pages_processed) {
>  			/* First create message */
> -			err =3D mana_ib_gd_first_dma_region(mib_dev, gc,
> create_req,
> +			err =3D mana_ib_gd_first_dma_region(mib_dev,
> create_req,
>  							  tail, gdma_region,
>  							  expected_status);
>  			if (err)
> @@ -403,7 +389,7 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *mib_dev,
>  			page_addr_list =3D add_req->page_addr_list;
>  		} else {
>  			/* Subsequent create messages */
> -			err =3D mana_ib_gd_add_dma_region(mib_dev, gc,
> add_req, tail,
> +			err =3D mana_ib_gd_add_dma_region(mib_dev,
> add_req, tail,
>  							expected_status);
>  			if (err)
>  				break;
> @@ -429,13 +415,9 @@ int mana_ib_gd_create_dma_region(struct
> mana_ib_dev *mib_dev,
>=20
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *mib_dev, u64
> gdma_region)  {
> -	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
> -	struct gdma_context *gc;
> -
> -	gc =3D mdev->gdma_context;
>  	ibdev_dbg(&mib_dev->ib_dev, "destroy dma region 0x%llx\n",
> gdma_region);
>=20
> -	return mana_gd_destroy_dma_region(gc, gdma_region);
> +	return mana_gd_destroy_dma_region(mib_dev->gc, gdma_region);
>  }
>=20
>  int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct
> *vma) @@ -444,13 +426,11 @@ int mana_ib_mmap(struct ib_ucontext
> *ibcontext, struct vm_area_struct *vma)
>  		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
>  	struct ib_device *ibdev =3D ibcontext->device;
>  	struct mana_ib_dev *mib_dev;
> -	struct gdma_context *gc;
>  	phys_addr_t pfn;
>  	pgprot_t prot;
>  	int ret;
>=20
>  	mib_dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mib_dev->gdma_dev->gdma_context;
>=20
>  	if (vma->vm_pgoff !=3D 0) {
>  		ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma-
> >vm_pgoff); @@ -458,18 +438,18 @@ int mana_ib_mmap(struct ib_ucontext
> *ibcontext, struct vm_area_struct *vma)
>  	}
>=20
>  	/* Map to the page indexed by ucontext->doorbell */
> -	pfn =3D (gc->phys_db_page_base +
> -	       gc->db_page_size * mana_ucontext->doorbell) >>
> +	pfn =3D (mib_dev->gc->phys_db_page_base +
> +	       mib_dev->gc->db_page_size * mana_ucontext->doorbell) >>
>  	      PAGE_SHIFT;
>  	prot =3D pgprot_writecombine(vma->vm_page_prot);
>=20
> -	ret =3D rdma_user_mmap_io(ibcontext, vma, pfn, gc->db_page_size,
> prot,
> -				NULL);
> +	ret =3D rdma_user_mmap_io(ibcontext, vma, pfn, mib_dev->gc-
> >db_page_size,
> +				prot, NULL);
>  	if (ret)
>  		ibdev_dbg(ibdev, "can't rdma_user_mmap_io ret %d\n", ret);
>  	else
>  		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %u, ret
> %d\n",
> -			  pfn, gc->db_page_size, ret);
> +			  pfn, mib_dev->gc->db_page_size, ret);
>=20
>  	return ret;
>  }
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index ee4efd0af278..3a2ba6b96f15 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -30,6 +30,7 @@
>  struct mana_ib_dev {
>  	struct ib_device ib_dev;
>  	struct gdma_dev *gdma_dev;
> +	struct gdma_context *gc;
>  };
>=20
>  struct mana_ib_wq {
> diff --git a/drivers/infiniband/hw/mana/mr.c
> b/drivers/infiniband/hw/mana/mr.c index f6a53906204d..3106d1bce837
> 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -29,13 +29,10 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> *mib_dev,
>  				struct mana_ib_mr *mr,
>  				struct gdma_create_mr_params *mr_params)
> {
> -	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
>  	struct gdma_create_mr_response resp =3D {};
>  	struct gdma_create_mr_request req =3D {};
> -	struct gdma_context *gc;
>  	int err;
>=20
> -	gc =3D mdev->gdma_context;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
>  			     sizeof(resp));
> @@ -56,7 +53,8 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> *mib_dev,
>  		return -EINVAL;
>  	}
>=20
> -	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> &resp);
> +	err =3D mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
> +				   sizeof(resp), &resp);
>=20
>  	if (err || resp.hdr.status) {
>  		ibdev_dbg(&mib_dev->ib_dev, "Failed to create mr %d, %u",
> err, @@ -77,22 +75,19 @@ static int mana_ib_gd_create_mr(struct
> mana_ib_dev *mib_dev,  static int mana_ib_gd_destroy_mr(struct
> mana_ib_dev *mib_dev, u64 mr_handle)  {
>  	struct gdma_destroy_mr_response resp =3D {};
> -	struct gdma_dev *mdev =3D mib_dev->gdma_dev;
>  	struct gdma_destroy_mr_request req =3D {};
> -	struct gdma_context *gc;
>  	int err;
>=20
> -	gc =3D mdev->gdma_context;
> -
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
>  			     sizeof(resp));
>=20
>  	req.mr_handle =3D mr_handle;
>=20
> -	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> &resp);
> +	err =3D mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
> +				   sizeof(resp), &resp);
>  	if (err || resp.hdr.status) {
> -		dev_err(gc->dev, "Failed to destroy MR: %d, 0x%x\n", err,
> -			resp.hdr.status);
> +		dev_err(mib_dev->gc->dev, "Failed to destroy MR: %d,
> 0x%x\n",
> +			err, resp.hdr.status);
>  		if (!err)
>  			err =3D -EPROTO;
>  		return err;
> diff --git a/drivers/infiniband/hw/mana/qp.c
> b/drivers/infiniband/hw/mana/qp.c index 2e3a57123ed7..874cfd794825
> 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -21,7 +21,7 @@ static int mana_ib_cfg_vport_steering(struct
> mana_ib_dev *mib_dev,
>  	u32 req_buf_size;
>  	int i, err;
>=20
> -	mdev =3D mib_dev->gdma_dev;
> +	mdev =3D &mib_dev->gc->mana;
>  	gc =3D mdev->gdma_context;
>=20
>  	req_buf_size =3D
> @@ -102,7 +102,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,
> struct ib_pd *pd,
>  	struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
>  	struct mana_ib_create_qp_rss_resp resp =3D {};
>  	struct mana_ib_create_qp_rss ucmd =3D {};
> -	struct gdma_dev *gd =3D mib_dev->gdma_dev;
> +	struct gdma_dev *gd =3D &mib_dev->gc->mana;
>  	mana_handle_t *mana_ind_table;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
> @@ -267,7 +267,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
>  					  ibucontext);
>  	struct mana_ib_create_qp_resp resp =3D {};
> -	struct gdma_dev *gd =3D mib_dev->gdma_dev;
> +	struct gdma_dev *gd =3D &mib_dev->gc->mana;
>  	struct mana_ib_create_qp ucmd =3D {};
>  	struct mana_obj_spec wq_spec =3D {};
>  	struct mana_obj_spec cq_spec =3D {};
> @@ -437,7 +437,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp
> *qp,  {
>  	struct mana_ib_dev *mib_dev =3D
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> -	struct gdma_dev *gd =3D mib_dev->gdma_dev;
> +	struct gdma_dev *gd =3D &mib_dev->gc->mana;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
>  	struct net_device *ndev;
> @@ -464,7 +464,7 @@ static int mana_ib_destroy_qp_raw(struct
> mana_ib_qp *qp, struct ib_udata *udata)  {
>  	struct mana_ib_dev *mib_dev =3D
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> -	struct gdma_dev *gd =3D mib_dev->gdma_dev;
> +	struct gdma_dev *gd =3D &mib_dev->gc->mana;
>  	struct ib_pd *ibpd =3D qp->ibqp.pd;
>  	struct mana_port_context *mpc;
>  	struct mana_context *mc;
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..9fa7a2d6c2b2 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -139,6 +139,9 @@ static int mana_gd_detect_devices(struct pci_dev
> *pdev)
>  		if (dev_type =3D=3D GDMA_DEVICE_MANA) {
>  			gc->mana.gdma_context =3D gc;
>  			gc->mana.dev_id =3D dev;
> +		} else if (dev_type =3D=3D GDMA_DEVICE_MANA_IB) {
> +			gc->mana_ib.dev_id =3D dev;
> +			gc->mana_ib.gdma_context =3D gc;
>  		}
>  	}
>=20
> @@ -940,6 +943,7 @@ int mana_gd_register_device(struct gdma_dev *gd)
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL(mana_gd_register_device);
>=20
>  int mana_gd_deregister_device(struct gdma_dev *gd)  { @@ -970,6 +974,7
> @@ int mana_gd_deregister_device(struct gdma_dev *gd)
>=20
>  	return err;
>  }
> +EXPORT_SYMBOL(mana_gd_deregister_device);
>=20
>  u32 mana_gd_wq_avail_space(struct gdma_queue *wq)  { diff --git
> a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 96c120160f15..e2b212dd722b 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -63,6 +63,7 @@ enum {
>  	GDMA_DEVICE_NONE	=3D 0,
>  	GDMA_DEVICE_HWC		=3D 1,
>  	GDMA_DEVICE_MANA	=3D 2,
> +	GDMA_DEVICE_MANA_IB	=3D 3,
>  };
>=20
>  struct gdma_resource {
> @@ -384,6 +385,8 @@ struct gdma_context {
>=20
>  	/* Azure network adapter */
>  	struct gdma_dev		mana;
> +	/* rdma device */
> +	struct gdma_dev		mana_ib;
>  };
>=20
>  #define MAX_NUM_GDMA_DEVICES	4
> --
> 2.25.1

