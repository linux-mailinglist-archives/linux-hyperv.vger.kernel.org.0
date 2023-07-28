Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB74576779E
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 23:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjG1VdG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 17:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjG1VdF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 17:33:05 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7077144AF;
        Fri, 28 Jul 2023 14:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2zhUa9zsd+wrkawmAfUOrRvPDwRmiZdRhw25McQ5pvlnMBbcf2eb9lt+A+bExcaEVdZOwMt+XmGRKah6nQtUeydkERssZmmEklO8QLlegEw4Nyf4v9tJJDnRTB60LwlZSfZrWwcqBjMBOjWS0MQtTEkFnZMyUAPKj3iemknGoIybmD0vTQrpKVxwqV85EKB4n3yXriir0PoYNQXaA6vmf/0Vq4p/UmzP1ztbd8DoPLS/jamTdzisQLp2pZ9uRZeMtNP4vbigAUiBdq4Kb5MicO/aHbnJ23JKc61bQCh+Vc7+HNlE2W9G6n4C+uVxQJHFdXnPXnctMhcFrcpXQHmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3nRm9+EgHDpSf6v0l8FxozzMGO9ZJDmCAVOtYxovm0=;
 b=S+mjmEHZPIIvbPzyrmrlH3Ir6zZEIUZKXqK2O2jtd/5f7S7PMyh6yzzUSjd+Mu5C23ofnRu3jD/s8ASJiPPiKZiDrJELRcR6K482AqcQ7z6Y1zPZWRU7Z2hBvmCwtyujZILi1VFSXiAxEpooxemaqJ0wapw7yEPM06jStHdMNJBZvHTOGcSxV/tFcxsIy6fzGQAJVKxrYmqT5FnQBcpQQm95PaXL40XMy4vM5AKh+aLU0pP0C3rWTwUNXIRlZdwOl1DKdCWOcPl4EAxFFCohRY++3gIT14GmxQWyZq30L0BWdXEjdul2+gFBGyFtZ70MZPQMwzdRW6TMfAYFNqkbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3nRm9+EgHDpSf6v0l8FxozzMGO9ZJDmCAVOtYxovm0=;
 b=FRtYlEU4ebJ5oUtCHZfnDQ3CGFowt7AZsnkinrfPsF9yuOQxr0xH7P852GIvCz3wGYQ/VjRZpQY1JZdX6OWGoVgup2GKMeIhTYTX/WNdidAeqJYXqkiHZ/PqQFQ59c+equyYbM5v9X2cPcxgde0klNQvpnEGg/hnIpQ5EUe3Qdk=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Fri, 28 Jul
 2023 21:32:49 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067%5]) with mapi id 15.20.6652.002; Fri, 28 Jul 2023
 21:32:49 +0000
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
Subject: RE: [Patch v3 2/4] RDMA/mana_ib : Register Mana IB  device with
 Management SW
Thread-Topic: [Patch v3 2/4] RDMA/mana_ib : Register Mana IB  device with
 Management SW
Thread-Index: AQHZv/z4U3bFTnzDP0+RuBTs+7DTAq/PtChQ
Date:   Fri, 28 Jul 2023 21:32:49 +0000
Message-ID: <PH7PR21MB3263BFD40B705C57591CAE05CE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-3-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-3-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=696af537-bb05-4e8f-8166-c8ca7637e8e1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T21:25:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MW4PR21MB1956:EE_
x-ms-office365-filtering-correlation-id: 6382b109-07f1-4c55-e5e5-08db8fb230f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCPOz/6q+cIHvlWnY5GHCC7irhWbHwYzHhtITcl98M6CTR0LLwfdN2A6sX4sW1wiqIvA6h1huwKfgwBczwX8U38/EgA2pmui6VpTxGnL4u8Ur2SMMm52WaLMJdfPy2P3kteYKXU/E+8iQNQ/Ekx/fUos+EuAvV2hcSeADg8atx+/cE2GauHGuDeTT0AabqGELFdb0SnC/8MxxKFYECIOj53jzQuSgHi9daAmTaM1QwisXdUU1/h1oMed22KPSmk8bW+3BDdWpwHfklfUyBJZHDsZczostlnnDRHFMWXYHSi2wea4R8z6vubpTZV6b0Lg6DMYWfA745Sujvl3TsafX6TRUp0XqEPbwqNHA1Do08FtokwcGOLPItiH48nfPCi0IhFXICBBjVZrKsO2hIN14TxkRgxe7Dv0hY36Fyei7GteKzeZZOsqcH3HtE9LdZprhRynm67GdoABombd8/abtv/4MXtweQ64p+4FqHrZzfiqA/kFo2R/3pJlTTyAiXHQiw5ypzUvAB7BQTYlBIdJ+QLAxhD2pA7M3EBIENQqQ8EDiKmbQILD24XRjdAoC0UC34d1hw9WayhzbAfez+ACfCmaBCY2/fE0ApOQTn+RquDx2SRuiThuu6Jx25hPcKmoOD8dG+uo0J7H63PlCQF2nzPts7+ZuW9DF+ymz13//W8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(33656002)(122000001)(5660300002)(38070700005)(86362001)(52536014)(64756008)(7416002)(71200400001)(9686003)(478600001)(41300700001)(8936002)(107886003)(7696005)(10290500003)(8676002)(82950400001)(38100700002)(82960400001)(186003)(55016003)(66446008)(83380400001)(6506007)(66946007)(66556008)(76116006)(316002)(4326008)(966005)(8990500004)(66476007)(2906002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QOgsuoKP5jpBfZw0mgmhE3yjWqKCp3UWjdaLzshzLI6JKg5L1XdbroZyQleh?=
 =?us-ascii?Q?pkmE8kv+AKeqkt+FqXFtE1aCzyqmc50R4R0wCcNOWB6+sPwXits1mCs9m+mQ?=
 =?us-ascii?Q?hBu4ffvng1CH4OjHd0jTL4S4bOfE21vb5zMxrEla6eULOf+HjG6b09mBavgf?=
 =?us-ascii?Q?U1LWLBniCSl8DGaUT10VR8P0Agou+0+ObPN6b/ApIvBL9wo7oq3BEMwA8Lmf?=
 =?us-ascii?Q?7x1M5dQTukURHdBnHTT/oy0tEdkFFDGW3Xxfx5VrTZ9EnsgFhu21543oDsqj?=
 =?us-ascii?Q?RblM0O7egvAvVBKii+hVBXjRlCWpEm+9j5SL02ELj3W7sWp8p8326k4yUgI3?=
 =?us-ascii?Q?TnUNI5Z6SfEwjNlPQo+A9gYotfKlu4rfnsHW9R7xW7zxm3SMz9ajGPQKcmaW?=
 =?us-ascii?Q?lzfRnxMH+xMWx4TXvjf+W6L4mlUVIkOahJ1NN3Vo1VRzfI92Ji0JdcXy2VCw?=
 =?us-ascii?Q?iR0+bim464jjGAsGerclEdKURyaKmzLi84rFQB8HHS/llTbJt2Sd4fzu1APA?=
 =?us-ascii?Q?OEL4OoFTW14u9L1pmgBcQ/MEptgWT05TyRtTfojBelrPtdsj8CK2tsy0Hm/8?=
 =?us-ascii?Q?drbSZzaYxPlPq3QqbOL8NjtFllly4/IOoDs5d449NXn5kdA/A7MiQwbHrGjO?=
 =?us-ascii?Q?3BcOEwXS71ZrgKTUMk5YEsDSM7N284W4rk7D6iKc+zp2FZwfWZTfNkpBnPMK?=
 =?us-ascii?Q?kDBSLLau2tm46JAAfmfb078jqkAaMj5/nd1LPigWLPNR4+8UgAB1rfZ4Q99b?=
 =?us-ascii?Q?/3SxqdpJcSXM24/EMopcdZLtILPRc7EnQaYayTYwNv11WvAvJo/FcIWhyHqe?=
 =?us-ascii?Q?D9OD8IjubUBXAT22AKO+xW5TwILTpgniuzc/jY8islneilNpzsilQb90UjEj?=
 =?us-ascii?Q?ajBJPhzdye4+Q44//hr/b7VDQoNzeJq9FKzizfpcK/q/9HGrKkjaEJKZrZ38?=
 =?us-ascii?Q?HWJlf/TgOuwXQjeRPsusCdOigXJITGZCgQM4Rmyk/rHOfI5OpSGO1gFwHaT+?=
 =?us-ascii?Q?czI5G25ZtURJIgUpjieXIMTbyonbIPbKqw1IkhYpnstZgSzoUIyE3DX5AJov?=
 =?us-ascii?Q?8qAeLGrQ2Vz5AFdxIjqGWGAQPINyS80WoGjlZyeoWi2SvPc8kuQ0ebgXQWby?=
 =?us-ascii?Q?bfO3M0tCoMcqqHKXFqKEi6ztByCl790g4rsBMQGJjc7h8G9kbBhBztBZJ+SF?=
 =?us-ascii?Q?3pxxozSP4mRhtci7XggnNglMRxdZwLACvZnJwEcZub8F/bBGhBKKyKUbivZe?=
 =?us-ascii?Q?5gK8FjYb3PClWhG7g1KuCkFvyUAf3xbKDzGbz+J/H6Fa8deFD6QH76jWokal?=
 =?us-ascii?Q?AJoyoMzKT46OwHZcpUPSX47v7+vcbcN7JWtBMjcOF14rswftDMRJ6RBi9rJq?=
 =?us-ascii?Q?PlEcRFq2YNb3s8mNWQU/qz+sqJ/D6ec8LGdM6ka3Pf9lPuAXWBczmqHGBfNA?=
 =?us-ascii?Q?eqoIWs0EcSw/5bgAesSH5RNRndGRLgsRwIcE9rjGFrZV/UiLm2aFOkJXJbzT?=
 =?us-ascii?Q?zgadRzZkQ6bjSTBAVUftQoGMZTp7JE80M872eoUhUQgVECNQndESbrxJ1BrI?=
 =?us-ascii?Q?PkD9KvoMqvC+DEKRpFc5apUxq+fWWWms9P8LdUYyc+vuebqRbz6GA44x6yh5?=
 =?us-ascii?Q?Qk4plEGzeAO/VXds6tWmM63rs2XP4/hEFOd9khz8Lk2Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6382b109-07f1-4c55-e5e5-08db8fb230f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 21:32:49.0681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSWMEU7/Iuvt44YK83Qr0NOa491Qz5kPfR7FA6GxMTAoYXuQZI2DB3z4GBGwU1jqQeafsTt1swXDzUucpONnoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: [Patch v3 2/4] RDMA/mana_ib : Register Mana IB device with
> Management SW
>=20
> [Some people who received this message don't often get email from
> sharmaajay@linuxonhyperv.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Ajay Sharma <sharmaajay@microsoft.com>
>=20
> Each of the MANA infiniband devices must be registered with the
> management software to request services/resources.
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
>         mib_dev->ib_dev.num_comp_vectors =3D 1;
>         mib_dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
>=20
> -       ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
> -                                mdev->gdma_context->dev);
> +       ret =3D mana_gd_register_device(&mib_dev->gc->mana_ib);

Is this device implemented on all existing Azure hosts? If not, it will bre=
ak existing VMs.

Long
