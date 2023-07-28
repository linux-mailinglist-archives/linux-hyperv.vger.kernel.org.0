Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51C76623C
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 05:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjG1DDh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jul 2023 23:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjG1DDX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jul 2023 23:03:23 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DC2685;
        Thu, 27 Jul 2023 20:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlkrAXttV/S7O+Iz3rwIlM706HkCfcfJDAHN37WqqH/GlB0rpk/hclCAc2K53eJ/RVvqy+KbsrIDvYHyg/M3EQ6B9LRFMEc8mOJ4BSa+XNRdyBIM0HaboJ5txrjHLMpX5eXR7AdozK08QGXj+3rViAh+GLfSx7phGBqmWirIgvHSpLElam9fgPzwrM1OE3CLmmt7YeaEWCncK777QnlmD+KLeay77eBMRW+hp54oV+eJ3XyZZBx4mQRr6vDp7gP+T77MYU+2fWX5YhsrjcoOl0A4ObDLz1ZtfyXIMw5eJ1dePgGG/oD0GILFR3+noyUvOwrRU2jyr63UzOmk8uVVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj0NhXdDEYFqFV/dHZERaxPFUR5AaEtDNL84Eh4AnEI=;
 b=nAPQGjAO5E+GwOfrkinVGTH+zP2p4nPBCc1UdNMDX/+6XzD8Y+MsOVKMFjBgw3kz/R/L6wXnkr2T4KhepA6Ta+aNKgbXX2gZZanoer+8uDwoheOAhKwy5dkhQ7buMo6UoWl7pGQah819AuNYIkhSS7TRSc2zfhKY9crCETld7eVl1sFwnSd6SiWglhMjvCHj4IunBsiMQEGTKbheNXKd3HoQRt5gY/G4M5b1+jzf1ctcXsVreh/Vx8chQtolC+NcAJlcvzCfnuXFvha57yKF+SXhZY6lbsliobzlWpqEmT5pzNn6ighA2Rt67BIfZdGfUaJzx87/JRerWO8z/lOqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj0NhXdDEYFqFV/dHZERaxPFUR5AaEtDNL84Eh4AnEI=;
 b=Woo1KdjqBLYEFdKpGrwO6CF0voWBQVqgHBYiyXYuSXtTR380XqY3xg9TLSLdlO9wLZXkXRHsKmHAqOn446sziGlxVLraOTBkVNjk4PgneYvn08mPTFO9IWJFh6rILN1CE3/T9k/pcE2skWlXIQvMjPylnbXuvwP1o0CXOL4UIEM=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by DS7PR21MB3365.namprd21.prod.outlook.com (2603:10b6:8:81::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 03:02:32 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453%6]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 03:02:32 +0000
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
Subject: RE: [EXTERNAL] [Patch v3 3/4] RDMA/mana_ib : Create adapter and Add
 error eq
Thread-Topic: [EXTERNAL] [Patch v3 3/4] RDMA/mana_ib : Create adapter and Add
 error eq
Thread-Index: AQHZv/z0wWzPstwt7UasDoGWIClEfK/Of9ww
Date:   Fri, 28 Jul 2023 03:02:32 +0000
Message-ID: <BY5PR21MB1394976603EF14960CF7F7EAD606A@BY5PR21MB1394.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-4-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-4-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f72b14fb-1e4b-45c8-903b-a815a72b558b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T03:02:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|DS7PR21MB3365:EE_
x-ms-office365-filtering-correlation-id: 8939c7f5-4c8d-42e9-d0fe-08db8f17164b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRfngoQDgV0YPY7tq07J/PYBl3T2SACAv4OdsIoDorxgiS4/ckJ2hu6biywPhypqOiWCRb8d8I3pcBVR4FGh/A+QxVwfNd/q5ugmBHEF0RQow0whKS0zSbd6L2vv6gPHHvDUJQjAZkbeWolE7NgfwQSFHMeqg9ur+4d6ObCuFC062cVf75mL4sSLFdia3dRt28uBk3HPiyFmuEBz4BbtXxqNIUTbi5UbJJcIvZTm6ytlygYG87hlgaKTablkcgNV0Hyn8WNbA8crgbeEK8Favl/IbSHal9nehjs/9SLcQM+bChd0FD+iobLVTVXZqqvoclbgAl1QFzgZ5XiIPBzJhJUp1dDKzq3mPzwJEOy8dyjnfAaue6nkxmWm88Lkl1amoKICC5iJ0G7ENvaepiIl4B9WHc7lqyjlpHNqOInd0A+4Fh5bLEqs9YKtNIs2PN8WV/9APtbJFRRAuFL3AgdGdAVNVe1HO9Hh4eHNUgW+Li2HsHTxPjvczv4QHwwvATALbvuXEFrepjY5Qzgqk1QTrpAA4AmRsQJ1QClsnEEVcQ75YqqQAxZ9UmnMGB0KxPBFjJKV1PUCW1XT/in1oMOipkf2PNxjhrXoAowvxpGvve8L1dwkrTKVVZhCmedELkrsC+AA5EZjWoFZCdczvxq/bLHgItHEaAjQeKlKVoDVWkV7zWDAEWhKMFutMLVzahL4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(7416002)(38070700005)(921005)(33656002)(30864003)(7696005)(55016003)(53546011)(6506007)(83380400001)(66446008)(64756008)(9686003)(66556008)(186003)(38100700002)(122000001)(107886003)(76116006)(2906002)(66946007)(66476007)(82950400001)(82960400001)(316002)(71200400001)(4326008)(5660300002)(8990500004)(41300700001)(66899021)(8676002)(86362001)(52536014)(54906003)(110136005)(478600001)(10290500003)(8936002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6yLT5I5nmIrjKc8D+MfppL9XGUNXWY8qt7CnfxViCmK86tUjyq1gwkldHvIw?=
 =?us-ascii?Q?B1A6s7W8kCcb3BrHT5sQ8IFSopiKOtTZm2cR4hm55GUiDPoCJcjuwmvCwSvh?=
 =?us-ascii?Q?o+A2tfGnrYc6dy1CIjE09H1h00pPGkPWkelWOWTn0lBxsScfq24gnofR177H?=
 =?us-ascii?Q?43jh9IulZOP2bbwHNTADwDsUs09LsKk2tRfPQt/sFR5zQma1b5xLQIRcRnz0?=
 =?us-ascii?Q?HhVAsB4hkHvOPnt06rT/2wwln8cMFEFDajP02/T2y6cldw47pEavfza4ojR3?=
 =?us-ascii?Q?Spx4HDFy2ZXj/iZ1uB7thlevTN4sRL8M+hehhpjreG8PaSIglFAdAYEH1jQw?=
 =?us-ascii?Q?SWkkye/lYrAk+cPa46r6162Rt0uVU5zjcCT8qGRxmr0FWldcJSF2+YfsAy5h?=
 =?us-ascii?Q?oAbfuEZkqhKqVvV+SqGCEJq9l2cufbcpgqSPdFXX1I9zqmwdIw5bGk7sc7HT?=
 =?us-ascii?Q?fyFk4DSQ3E6RxL5eLpSkNPLmhyiRu2fcqcusoADa8emUYV+cxOVfijBLUgDw?=
 =?us-ascii?Q?hW9qgC9nDAGDHNI3k8HEtd1BOtMeXlzaq4AZjQOUxCbFtJyMiQzw8wp80osF?=
 =?us-ascii?Q?PCyz6lBXZNjH02mAqwsHGmRPzjN6kqBpLynzqFVGBPVww/KAlVExzSnyJual?=
 =?us-ascii?Q?VYzfXcs31pQ1BeuF8ZMpknhncV+iMZwVcfIb7YjJHnHjRe4ugSLG0lMoqtUa?=
 =?us-ascii?Q?kMaSNaOeNF2J9YbfjSo2Rt9UywC1w5OBLiGA81ZNWvPxeeR5OuDVUGT49loM?=
 =?us-ascii?Q?gZdCc/UyykuUW8pH7QpgRvfXmSRUiRaMLw9G8KJgLUfTtvTdg+ifE4EMqmZt?=
 =?us-ascii?Q?yekSKpo6L5mNB9uiTtRwkM/OYPPFsUrZ27UGeKGidYHXhr//FFd69tLE4ksf?=
 =?us-ascii?Q?deUZQz93G5GA/RUmL8/3UB3oA+sI2Pp44llkPcfDX4Hzd7vI5F87+/OsOEMS?=
 =?us-ascii?Q?rcSCR+EbG5k+j9QVU7K6YV09Vza1rXuuZruXARbVeeA9sG68nMPAuOf1+4Eu?=
 =?us-ascii?Q?GGgaK+JizP/Dm6Y/ll+sNyFOqhZNum2R2JGQPMbrriv3OCNBsDcwFFmh0UbB?=
 =?us-ascii?Q?deo0EcfpNTljIRRxsN5WSRnVKbnobFvtOeEIjDwiBn+RwPWnVlyg/LmoAkyC?=
 =?us-ascii?Q?6CFNyhtB0HD7waNJ5/T5bVC2V3amreCcvjd+2cz9IbVoigLcU4cwACBvdFiJ?=
 =?us-ascii?Q?usED0y2y0DWMrHFe6F756x9C659/aXgxsK7CF/1XtCcKl8WjSHbjXcO5wzi8?=
 =?us-ascii?Q?8L1QshAFZV7Bs2e6QW5gOru6FrSfuZ7Xm2lP5plRXNWf4dbUtf1p2QPC7zfd?=
 =?us-ascii?Q?1gcCuXT3/B9kljIKwUOcZtihjL2oSuwZo0CAgDJRblwtX7VO20xsaWMslbMi?=
 =?us-ascii?Q?EdI9fPKiK9WaN2Egpr+oC0kHVEvA6La59vX67/QCeCs870fgB8l3XyRjXsjP?=
 =?us-ascii?Q?TfiPptSQqFWBTL3YAaMCWZVmP4FnNRTp2UnWeHPyVYDhsZrJsvB2HQgJOjAA?=
 =?us-ascii?Q?yMSQdD7/f8MROdI4zWVREllCDdcBieSsMFEtGSTtaNi9VVB7Vz5Q8ip0J5LW?=
 =?us-ascii?Q?G97nepJm1AORMC45/T4aM3AeuaF30KRKn+YBY1nk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8939c7f5-4c8d-42e9-d0fe-08db8f17164b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 03:02:32.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nG+z7aaMx4CR5lop+KNkhNnDMyhSCSRyxAUCGqiIkH/DJR7ZGVonxia6T7J9GXMW4mgJ8weM2zpPg77xocMZQYaXFnS4dXz1l8NUs1VL/T8=
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
> Subject: [EXTERNAL] [Patch v3 3/4] RDMA/mana_ib : Create adapter and Add
> error eq
>=20
> From: Ajay Sharma <sharmaajay@microsoft.com>
>=20
> Create adapter object as nice container for VF resources.
> Add error eq needed for adapter creation and later used for notification =
from
> Management SW. The management software uses this channel to send
> messages or error notifications back to the Client.
>=20
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c           |  22 ++-
>  drivers/infiniband/hw/mana/main.c             |  95 ++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h          |  33 ++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 146 ++++++++++--------
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
>  include/net/mana/gdma.h                       |  13 +-
>  6 files changed, 242 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index ea4c8c8fc10d..4077e440657a 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -68,7 +68,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  	ibdev_dbg(&mib_dev->ib_dev, "mdev=3D%p id=3D%d num_ports=3D%d\n",
> mdev,
>  		  mdev->dev_id.as_uint32, mib_dev->ib_dev.phys_port_cnt);
>=20
> -	mib_dev->gdma_dev =3D mdev;
> +	mib_dev->gc =3D mdev->gdma_context;
>  	mib_dev->ib_dev.node_type =3D RDMA_NODE_IB_CA;
>=20
>  	/*
> @@ -85,15 +85,31 @@ static int mana_ib_probe(struct auxiliary_device
> *adev,
>  		goto free_ib_device;
>  	}
>=20
> +	ret =3D mana_ib_create_error_eq(mib_dev);
> +	if (ret) {
> +		ibdev_err(&mib_dev->ib_dev, "Failed to allocate err eq");
> +		goto deregister_device;
> +	}
> +
> +	ret =3D mana_ib_create_adapter(mib_dev);
> +	if (ret) {
> +		ibdev_err(&mib_dev->ib_dev, "Failed to create adapter");
> +		goto free_error_eq;
> +	}
> +
>  	ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
>  				 mdev->gdma_context->dev);
>  	if (ret)
> -		goto deregister_device;
> +		goto destroy_adapter;
>=20
>  	dev_set_drvdata(&adev->dev, mib_dev);
>=20
>  	return 0;
>=20
> +destroy_adapter:
> +	mana_ib_destroy_adapter(mib_dev);
> +free_error_eq:
> +	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
>  deregister_device:
>  	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
>  free_ib_device:
> @@ -105,6 +121,8 @@ static void mana_ib_remove(struct auxiliary_device
> *adev)  {
>  	struct mana_ib_dev *mib_dev =3D dev_get_drvdata(&adev->dev);
>=20
> +	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
> +	mana_ib_destroy_adapter(mib_dev);
>  	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
>  	ib_unregister_device(&mib_dev->ib_dev);
>  	ib_dealloc_device(&mib_dev->ib_dev);
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 2c4e3c496644..1b1a8670d0fa 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -504,3 +504,98 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32
> port, int index,  void mana_ib_disassociate_ucontext(struct ib_ucontext
> *ibcontext)  {  }
> +
> +int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev) {
> +	struct mana_ib_destroy_adapter_resp resp =3D {};
> +	struct mana_ib_destroy_adapter_req req =3D {};
> +	struct gdma_context *gc;
> +	int err;
> +
> +	gc =3D mib_dev->gc;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER,
> sizeof(req),
> +			     sizeof(resp));
> +	req.adapter =3D mib_dev->adapter_handle;
> +	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> +&resp);
> +
> +	if (err) {
> +		ibdev_err(&mib_dev->ib_dev, "Failed to destroy adapter err
> %d", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int mana_ib_create_adapter(struct mana_ib_dev *mib_dev) {
> +	struct mana_ib_create_adapter_resp resp =3D {};
> +	struct mana_ib_create_adapter_req req =3D {};
> +	struct gdma_context *gc;
> +	int err;
> +
> +	gc =3D mib_dev->gc;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER,
> sizeof(req),
> +			     sizeof(resp));
> +	req.notify_eq_id =3D mib_dev->fatal_err_eq->id;
> +	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> +&resp);
> +
> +	if (err) {
> +		ibdev_err(&mib_dev->ib_dev, "Failed to create adapter err
> %d",
> +			  err);
> +		return err;
> +	}
> +
> +	mib_dev->adapter_handle =3D resp.adapter;
> +
> +	return 0;
> +}
> +
> +static void mana_ib_soc_event_handler(void *ctx, struct gdma_queue
> *queue,
> +				      struct gdma_event *event)
> +{
> +	struct mana_ib_dev *mib_dev =3D (struct mana_ib_dev *)ctx;
> +
> +	switch (event->type) {
> +	case GDMA_EQE_SOC_EVENT_NOTIFICATION:
> +		ibdev_info(&mib_dev->ib_dev, "Received SOC Notification");
> +		break;
> +	case GDMA_EQE_SOC_EVENT_TEST:
> +		ibdev_info(&mib_dev->ib_dev, "Received SoC Test");
> +		break;
> +	default:
> +		ibdev_dbg(&mib_dev->ib_dev, "Received unsolicited evt %d",
> +			  event->type);
> +	}
> +}
> +
> +int mana_ib_create_error_eq(struct mana_ib_dev *mib_dev) {
> +	struct gdma_queue_spec spec =3D {};
> +	int err;
> +
> +	spec.type =3D GDMA_EQ;
> +	spec.monitor_avl_buf =3D false;
> +	spec.queue_size =3D EQ_SIZE;
> +	spec.eq.callback =3D mana_ib_soc_event_handler;
> +	spec.eq.context =3D mib_dev;
> +	spec.eq.log2_throttle_limit =3D LOG2_EQ_THROTTLE;
> +	spec.eq.msix_allocated =3D true;
> +	spec.eq.msix_index =3D 0;
> +	spec.doorbell =3D mib_dev->gc->mana_ib.doorbell;
> +	spec.pdid =3D mib_dev->gc->mana_ib.pdid;
> +
> +	err =3D mana_gd_create_mana_eq(&mib_dev->gc->mana_ib, &spec,
> +				     &mib_dev->fatal_err_eq);
> +	if (err)
> +		return err;
> +
> +	mib_dev->fatal_err_eq->eq.disable_needed =3D true;
> +
> +	return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 3a2ba6b96f15..8a652bccd978 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -31,6 +31,8 @@ struct mana_ib_dev {
>  	struct ib_device ib_dev;
>  	struct gdma_dev *gdma_dev;
>  	struct gdma_context *gc;
> +	struct gdma_queue *fatal_err_eq;
> +	mana_handle_t adapter_handle;
>  };
>=20
>  struct mana_ib_wq {
> @@ -93,6 +95,31 @@ struct mana_ib_rwq_ind_table {
>  	struct ib_rwq_ind_table ib_ind_table;
>  };
>=20
> +enum mana_ib_command_code {
> +	MANA_IB_CREATE_ADAPTER  =3D 0x30002,
> +	MANA_IB_DESTROY_ADAPTER =3D 0x30003,
> +};
> +
> +struct mana_ib_create_adapter_req {
> +	struct gdma_req_hdr hdr;
> +	u32 notify_eq_id;
> +	u32 reserved;
> +}; /*HW Data */
> +
> +struct mana_ib_create_adapter_resp {
> +	struct gdma_resp_hdr hdr;
> +	mana_handle_t adapter;
> +}; /* HW Data */
> +
> +struct mana_ib_destroy_adapter_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t adapter;
> +}; /*HW Data */
> +
> +struct mana_ib_destroy_adapter_resp {
> +	struct gdma_resp_hdr hdr;
> +}; /* HW Data */
> +
>  int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
>  				 struct ib_umem *umem,
>  				 mana_handle_t *gdma_region);
> @@ -161,4 +188,10 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32
> port, int index,
>=20
>  void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
>=20
> +int mana_ib_create_error_eq(struct mana_ib_dev *mib_dev);
> +
> +int mana_ib_create_adapter(struct mana_ib_dev *mib_dev);
> +
> +int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev);
> +
>  #endif
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 9fa7a2d6c2b2..55e194c9d84e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -185,7 +185,8 @@ void mana_gd_free_memory(struct gdma_mem_info
> *gmi)  }
>=20
>  static int mana_gd_create_hw_eq(struct gdma_context *gc,
> -				struct gdma_queue *queue)
> +				struct gdma_queue *queue,
> +				u32 doorbell, u32 pdid)
>  {
>  	struct gdma_create_queue_resp resp =3D {};
>  	struct gdma_create_queue_req req =3D {}; @@ -199,8 +200,8 @@ static
> int mana_gd_create_hw_eq(struct gdma_context *gc,
>=20
>  	req.hdr.dev_id =3D queue->gdma_dev->dev_id;
>  	req.type =3D queue->type;
> -	req.pdid =3D queue->gdma_dev->pdid;
> -	req.doolbell_id =3D queue->gdma_dev->doorbell;
> +	req.pdid =3D pdid;
> +	req.doolbell_id =3D doorbell;
>  	req.gdma_region =3D queue->mem_info.dma_region_handle;
>  	req.queue_size =3D queue->queue_size;
>  	req.log2_throttle_limit =3D queue->eq.log2_throttle_limit; @@ -371,53
> +372,51 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
>  	}
>  }
>=20
> -static void mana_gd_process_eq_events(void *arg)
> +static void mana_gd_process_eq_events(struct list_head *eq_list)
>  {
>  	u32 owner_bits, new_bits, old_bits;
>  	union gdma_eqe_info eqe_info;
>  	struct gdma_eqe *eq_eqe_ptr;
> -	struct gdma_queue *eq =3D arg;
> +	struct gdma_queue *eq;
>  	struct gdma_context *gc;
>  	struct gdma_eqe *eqe;
>  	u32 head, num_eqe;
>  	int i;
>=20
> -	gc =3D eq->gdma_dev->gdma_context;
> -
> -	num_eqe =3D eq->queue_size / GDMA_EQE_SIZE;
> -	eq_eqe_ptr =3D eq->queue_mem_ptr;
> -
> -	/* Process up to 5 EQEs at a time, and update the HW head. */
> -	for (i =3D 0; i < 5; i++) {
> -		eqe =3D &eq_eqe_ptr[eq->head % num_eqe];
> -		eqe_info.as_uint32 =3D eqe->eqe_info;
> -		owner_bits =3D eqe_info.owner_bits;
> -
> -		old_bits =3D (eq->head / num_eqe - 1) &
> GDMA_EQE_OWNER_MASK;
> -		/* No more entries */
> -		if (owner_bits =3D=3D old_bits)
> -			break;
> -
> -		new_bits =3D (eq->head / num_eqe) &
> GDMA_EQE_OWNER_MASK;
> -		if (owner_bits !=3D new_bits) {
> -			dev_err(gc->dev, "EQ %d: overflow detected\n", eq-
> >id);
> -			break;
> +	list_for_each_entry_rcu(eq, eq_list, entry) {
> +		gc =3D eq->gdma_dev->gdma_context;
> +
> +		num_eqe =3D eq->queue_size / GDMA_EQE_SIZE;
> +		eq_eqe_ptr =3D eq->queue_mem_ptr;
> +		/* Process up to 5 EQEs at a time, and update the HW head. */
> +		for (i =3D 0; i < 5; i++) {
> +			eqe =3D &eq_eqe_ptr[eq->head % num_eqe];
> +			eqe_info.as_uint32 =3D eqe->eqe_info;
> +			owner_bits =3D eqe_info.owner_bits;
> +
> +			old_bits =3D (eq->head / num_eqe - 1) &
> GDMA_EQE_OWNER_MASK;
> +			/* No more entries */
> +			if (owner_bits =3D=3D old_bits)
> +				break;
> +
> +			new_bits =3D (eq->head / num_eqe) &
> GDMA_EQE_OWNER_MASK;
> +			if (owner_bits !=3D new_bits) {
> +				dev_err(gc->dev, "EQ %d: overflow
> detected\n",
> +					eq->id);
> +				break;
> +			}
> +			/* Per GDMA spec, rmb is necessary after checking
> owner_bits, before
> +			 * reading eqe.
> +			 */
> +			rmb();
> +			mana_gd_process_eqe(eq);
> +			eq->head++;
>  		}
>=20
> -		/* Per GDMA spec, rmb is necessary after checking owner_bits,
> before
> -		 * reading eqe.
> -		 */
> -		rmb();
> -
> -		mana_gd_process_eqe(eq);
> -
> -		eq->head++;
> +		head =3D eq->head % (num_eqe << GDMA_EQE_OWNER_BITS);
> +		mana_gd_ring_doorbell(gc, eq->gdma_dev->doorbell, eq-
> >type,
> +				      eq->id, head, SET_ARM_BIT);
>  	}
> -
> -	head =3D eq->head % (num_eqe << GDMA_EQE_OWNER_BITS);
> -
> -	mana_gd_ring_doorbell(gc, eq->gdma_dev->doorbell, eq->type, eq-
> >id,
> -			      head, SET_ARM_BIT);
>  }
>=20
>  static int mana_gd_register_irq(struct gdma_queue *queue, @@ -435,44
> +434,47 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
>  	gc =3D gd->gdma_context;
>  	r =3D &gc->msix_resource;
>  	dev =3D gc->dev;
> +	msi_index =3D spec->eq.msix_index;
>=20
>  	spin_lock_irqsave(&r->lock, flags);
>=20
> -	msi_index =3D find_first_zero_bit(r->map, r->size);
> -	if (msi_index >=3D r->size || msi_index >=3D gc->num_msix_usable) {
> -		err =3D -ENOSPC;
> -	} else {
> -		bitmap_set(r->map, msi_index, 1);
> -		queue->eq.msix_index =3D msi_index;
> -	}
> -
> -	spin_unlock_irqrestore(&r->lock, flags);
> +	if (!spec->eq.msix_allocated) {
> +		msi_index =3D find_first_zero_bit(r->map, r->size);
>=20
> -	if (err) {
> -		dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
> -			err, msi_index, r->size, gc->num_msix_usable);
> +		if (msi_index >=3D r->size ||
> +		    msi_index >=3D gc->num_msix_usable)
> +			err =3D -ENOSPC;
> +		else
> +			bitmap_set(r->map, msi_index, 1);
>=20
> -		return err;
> +		if (err) {
> +			dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u,
> nMSI:%u",
> +				err, msi_index, r->size, gc->num_msix_usable);
> +				goto out;
> +		}
>  	}
>=20
> +	queue->eq.msix_index =3D msi_index;
>  	gic =3D &gc->irq_contexts[msi_index];
>=20
> -	WARN_ON(gic->handler || gic->arg);
> -
> -	gic->arg =3D queue;
> +	list_add_rcu(&queue->entry, &gic->eq_list);
>=20
>  	gic->handler =3D mana_gd_process_eq_events;
>=20
> -	return 0;
> +out:
> +	spin_unlock_irqrestore(&r->lock, flags);
> +	return err;
>  }
>=20
> -static void mana_gd_deregiser_irq(struct gdma_queue *queue)
> +static void mana_gd_deregister_irq(struct gdma_queue *queue)
>  {
>  	struct gdma_dev *gd =3D queue->gdma_dev;
>  	struct gdma_irq_context *gic;
>  	struct gdma_context *gc;
>  	struct gdma_resource *r;
>  	unsigned int msix_index;
> +	struct list_head *p, *n;
> +	struct gdma_queue *eq;
>  	unsigned long flags;
>=20
>  	gc =3D gd->gdma_context;
> @@ -483,14 +485,23 @@ static void mana_gd_deregiser_irq(struct
> gdma_queue *queue)
>  	if (WARN_ON(msix_index >=3D gc->num_msix_usable))
>  		return;
>=20
> +	spin_lock_irqsave(&r->lock, flags);
> +
>  	gic =3D &gc->irq_contexts[msix_index];
> -	gic->handler =3D NULL;
> -	gic->arg =3D NULL;
> +	list_for_each_safe(p, n, &gic->eq_list) {
> +		eq =3D list_entry(p, struct gdma_queue, entry);
> +		if (queue =3D=3D eq) {
> +			list_del(&eq->entry);
> +			break;
> +		}
> +	}
>=20
> -	spin_lock_irqsave(&r->lock, flags);
> -	bitmap_clear(r->map, msix_index, 1);
> -	spin_unlock_irqrestore(&r->lock, flags);
> +	if (list_empty(&gic->eq_list)) {
> +		gic->handler =3D NULL;
> +		bitmap_clear(r->map, msix_index, 1);
> +	}
>=20
> +	spin_unlock_irqrestore(&r->lock, flags);
>  	queue->eq.msix_index =3D INVALID_PCI_MSIX_INDEX;  }
>=20
> @@ -553,7 +564,7 @@ static void mana_gd_destroy_eq(struct gdma_context
> *gc, bool flush_evenets,
>  			dev_warn(gc->dev, "Failed to flush EQ: %d\n", err);
>  	}
>=20
> -	mana_gd_deregiser_irq(queue);
> +	mana_gd_deregister_irq(queue);
>=20
>  	if (queue->eq.disable_needed)
>  		mana_gd_disable_queue(queue);
> @@ -568,7 +579,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
>  	u32 log2_num_entries;
>  	int err;
>=20
> -	queue->eq.msix_index =3D INVALID_PCI_MSIX_INDEX;
> +	queue->eq.msix_index =3D spec->eq.msix_index;
>=20
>  	log2_num_entries =3D ilog2(queue->queue_size / GDMA_EQE_SIZE);
>=20
> @@ -590,7 +601,8 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
>  	queue->eq.log2_throttle_limit =3D spec->eq.log2_throttle_limit ?: 1;
>=20
>  	if (create_hwq) {
> -		err =3D mana_gd_create_hw_eq(gc, queue);
> +		err =3D mana_gd_create_hw_eq(gc, queue,
> +					   spec->doorbell, spec->pdid);
>  		if (err)
>  			goto out;
>=20
> @@ -800,6 +812,7 @@ int mana_gd_create_mana_eq(struct gdma_dev *gd,
>  	kfree(queue);
>  	return err;
>  }
> +EXPORT_SYMBOL(mana_gd_create_mana_eq);
>=20
>  int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
>  			      const struct gdma_queue_spec *spec, @@ -876,6
> +889,7 @@ void mana_gd_destroy_queue(struct gdma_context *gc, struct
> gdma_queue *queue)
>  	mana_gd_free_memory(gmi);
>  	kfree(queue);
>  }
> +EXPORT_SYMBOL(mana_gd_destroy_queue);
>=20
>  int mana_gd_verify_vf_version(struct pci_dev *pdev)  { @@ -1193,7 +1207,=
7
> @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
>  	struct gdma_irq_context *gic =3D arg;
>=20
>  	if (gic->handler)
> -		gic->handler(gic->arg);
> +		gic->handler(&gic->eq_list);
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -1246,7 +1260,7 @@ static int mana_gd_setup_irqs(struct pci_dev
> *pdev)
>  	for (i =3D 0; i < nvec; i++) {
>  		gic =3D &gc->irq_contexts[i];
>  		gic->handler =3D NULL;
> -		gic->arg =3D NULL;
> +		INIT_LIST_HEAD(&gic->eq_list);
>=20
>  		if (!i)
>  			snprintf(gic->name, MANA_IRQ_NAME_SZ,
> "mana_hwc@pci:%s", diff --git
> a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a499e460594b..d2ba7de8b512 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1167,6 +1167,9 @@ static int mana_create_eq(struct mana_context
> *ac)
>  	spec.eq.callback =3D NULL;
>  	spec.eq.context =3D ac->eqs;
>  	spec.eq.log2_throttle_limit =3D LOG2_EQ_THROTTLE;
> +	spec.eq.msix_allocated =3D false;
> +	spec.doorbell =3D gd->doorbell;
> +	spec.pdid =3D gd->pdid;
>=20
>  	for (i =3D 0; i < gc->max_num_queues; i++) {
>  		err =3D mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> e2b212dd722b..aee8e8fa1ea6 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -57,6 +57,10 @@ enum gdma_eqe_type {
>  	GDMA_EQE_HWC_INIT_EQ_ID_DB	=3D 129,
>  	GDMA_EQE_HWC_INIT_DATA		=3D 130,
>  	GDMA_EQE_HWC_INIT_DONE		=3D 131,
> +
> +	/* IB NiC  Events start at 176*/
> +	GDMA_EQE_SOC_EVENT_NOTIFICATION =3D 176,
> +	GDMA_EQE_SOC_EVENT_TEST,
>  };
>=20
>  enum {
> @@ -291,6 +295,7 @@ struct gdma_queue {
>=20
>  	u32 head;
>  	u32 tail;
> +	struct list_head entry;
>=20
>  	/* Extra fields specific to EQ/CQ. */
>  	union {
> @@ -318,6 +323,8 @@ struct gdma_queue_spec {
>  	enum gdma_queue_type type;
>  	bool monitor_avl_buf;
>  	unsigned int queue_size;
> +	u32 doorbell;
> +	u32 pdid;
>=20
>  	/* Extra fields specific to EQ/CQ. */
>  	union {
> @@ -326,6 +333,8 @@ struct gdma_queue_spec {
>  			void *context;
>=20
>  			unsigned long log2_throttle_limit;
> +			bool msix_allocated;
> +			unsigned int msix_index;
>  		} eq;
>=20
>  		struct {
> @@ -341,8 +350,8 @@ struct gdma_queue_spec {  #define
> MANA_IRQ_NAME_SZ 32
>=20
>  struct gdma_irq_context {
> -	void (*handler)(void *arg);
> -	void *arg;
> +	void (*handler)(struct list_head *arg);
> +	struct list_head eq_list;
>  	char name[MANA_IRQ_NAME_SZ];
>  };
>=20
> --
> 2.25.1

