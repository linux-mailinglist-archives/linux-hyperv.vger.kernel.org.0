Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECFD7677F3
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 23:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjG1V5E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 17:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjG1V5D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 17:57:03 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144272D54;
        Fri, 28 Jul 2023 14:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8Al1zfvIDxwrW2rdnOvKypVT+cfNFdgqN1jxApKGFsw6gkf+7ifv/3lNYbmVTR95ehlop54NdW5+koPdIWZ1usQwHX01uZ9FOUpI0718rio5QRokE9pAdDIlNLSioiqvA4nYxIQjRgfEeHxGm/3BOO8IsrZ1GI2aifezE2PXTh+75uh0b1SOX0vNx9bPc2AQ02jhaELjfFL9CfTHPGaNkghldZiBnmlfEYTEPXsT4C7wuuB2a5kSaE1PlQciTjR9+YrPqrsavOGuXj9NHLfFlSWrKmK35fAwMOGCi+16CHrYYVzZt4MW8T1CL/D6PUZyKV4416ZUrV/ZmdI1Ztlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMo79ntPug96zeolkCgQQ/lm5p0dEBW9bc1Ub5VkCrw=;
 b=F5oqztxkG3VTmHV2gOcbmZvN+dGjfgTgWbC2uFDenRMn20NBZI00RX6KP0YMXn+Q9CyqpH3eEMjnTz0VdVA6+ESMifaXvFVSccJraWsHu+RXyYF7KHijA/c30LkKhcrTlmoz6A1GcX/zGlCkA5n3JkPX2nN4OKNwKEoZ+LTTMWfpjAfbKAcYdYGOqBu++3Heta+6Ftpjl4D0QFoQHZ5En+o1sxii4U5te6muWkoSMIh1EEfBYGPn3ftHO9TxryqH7FEqsJbA4VNnMH8KWAlMro3qa62v7j/cpua/sW9TwOOAaHHY/fhNgGoz4+BGq2eAeVrjzjAg9021oPri6dElhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMo79ntPug96zeolkCgQQ/lm5p0dEBW9bc1Ub5VkCrw=;
 b=hTGG0/0t6aobWccTmYjzxa6qQC2D4RGtLH8D37xZzLSC0d3Uv4QhNZR1sn6/CUC1ke795x+u47AYbEBR4xhRNXsIyDSrnBS9MTrThmYaC3J/RCqvXuVzr2ApZtPrzdAaTRCkzm1uag4Qum8E7nE5uPK3t0cWeuT+9TvWKKhtAMA=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SN7PR21MB3887.namprd21.prod.outlook.com (2603:10b6:806:2eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.0; Fri, 28 Jul
 2023 21:56:57 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067%5]) with mapi id 15.20.6652.002; Fri, 28 Jul 2023
 21:56:57 +0000
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
Subject: RE: [Patch v3 3/4] RDMA/mana_ib : Create adapter and Add error eq
Thread-Topic: [Patch v3 3/4] RDMA/mana_ib : Create adapter and Add error eq
Thread-Index: AQHZv/z7buqhGnDZS0uS8/v2espHfq/PurTw
Date:   Fri, 28 Jul 2023 21:56:57 +0000
Message-ID: <PH7PR21MB326347A0E16F608B0243D9FBCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-4-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-4-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=93bc4f93-62aa-4e32-a572-a7156a8f3a4e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T21:49:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SN7PR21MB3887:EE_
x-ms-office365-filtering-correlation-id: 5a7f39fe-f29e-4159-3a13-08db8fb59052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JD+dzQow7HfVpt3pR0akd6G+fDhxNvGV+u7aW+G9oH8/jmWqZG8uaSjv3pXTCB61DBYHdKp5fs1LttDLwNV/uq2ag4hhONahdCl7o9H9qv3Zi2DqjXq2xX8CX6LjjHUUA9JAVqsdutWAk0SW+OFRzbp3SIeieeVzatBMWQ+X69LdDr0tVCGObCrRKlBIDR1QRHB95q9rMHCgCxLKA9ppfVpb4upxKdf3GtOI0t9zate+QJ1Tr6h2TRh4xpS04/k7CmsolpGRXENIfgkslfnAPj4kesqqHoEWLuCcWXPgZtvnD3hpfbYrzAKBcdtoNZ8f8x/ggKe62o+A+SFFPrGuHhBoemmUjCcndC1qtaE+I5Tf8kLUDsyg1IganUbZ7p7pEyqEH9g17CeMMAa4d4m2Ddta2y7Qb76M57wWQUaPg9aevRz4Q1EMEbQRLrk68b2JwY6Uz1fTzHqP7aUx4cgpIeicKuMxtYTwTiajbJp4lmOUgPSyfv5VxJAgq6CsG2PCKGnJtBa5UYuj52SnmyJymvbDZusbHQKiKd51y1CRKtyDy7xJDngMaxzh44Hgx72HZ6Wa3adroEkHU6L+VFIUeQzVbEn8+9vKtlSbjF/4cBpoLGx7fl/ziAbzjDdM4pZMRV0nSZrSo6LAqbgUNwFC5EPxHZznVfj3POhpVwvcpjs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(66899021)(478600001)(7696005)(10290500003)(71200400001)(110136005)(54906003)(9686003)(186003)(83380400001)(38070700005)(86362001)(33656002)(55016003)(30864003)(82950400001)(6506007)(2906002)(66946007)(8990500004)(107886003)(4326008)(76116006)(66556008)(38100700002)(66476007)(64756008)(82960400001)(8676002)(5660300002)(122000001)(316002)(41300700001)(7416002)(52536014)(66446008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+pw+XyYDoabnl/eOmDwYeIgu4nb4wUaFWEUcGs96ICu0xtilYs+8FDzEwtWN?=
 =?us-ascii?Q?JKCreauwxxFeM7IE40cor39tVEsQdgGW8lL55uhA3ypY9QH+jivXJsRvAKiM?=
 =?us-ascii?Q?YrhIC3ATSxGXgz0cMX5VU7lT/fZCKwhQhAFCyorT7Fngoq8lj4iC1L2nM9q0?=
 =?us-ascii?Q?G3pHu6zn4j7QKL1nUsT+UO62qSCSjk2pjA1g1dM8vzk70Y6/I8VWBLKSglud?=
 =?us-ascii?Q?dGepnJCh7rhoyCnJS6Y9RvxTZiBOH89WZVOshVBpWKfzQ538umzSl2z6Fc6W?=
 =?us-ascii?Q?fLJv/LPPQ/unzRN+kGuStF/JysDR8lBxIdmGnqvzEcuVTiVLJuhAmp2Xt4/4?=
 =?us-ascii?Q?ybQ4dVPFaC2osgUnSURk/u8YzUExAW9QCNd3V643IqUl8r2diF5vZHkwFQ5t?=
 =?us-ascii?Q?qK+B6VyaqQdPFdyj6KRxz+ufU+QR54CDqcTMIF7Kum5x0xtN1wHqhAj7xmlu?=
 =?us-ascii?Q?fItcTcuw/spJqNJEGI3kKzXeAhc5ptZ+dLLqujQnmgNsmRjxb7TiWMZmajQw?=
 =?us-ascii?Q?cEFj6AibKeMC02CG0suh7ANYwdus1RBfH6DNZkHoEb6w4Bt+GSSmmWJITJRd?=
 =?us-ascii?Q?DaWKsW7sIwKocB03fkZR7NgFj6TO3QcBIK9A7V4vIZnYlKlv1NZ4aK/HNUXF?=
 =?us-ascii?Q?IFIFGF9K3JHA/hiovfah4ZdArPh/k46cXJ24U91tgxHVCMQISLlAot0pmXgs?=
 =?us-ascii?Q?NXatQLvrC6cIsDJUnC0lMg5pUWvIlvmkAS4B2tcoD1jn2S67XDIM6XRZAwry?=
 =?us-ascii?Q?MtaeCBCxEV8osVVwAiHAiR/yDDS4TpOb3mcolwtO5zOrfKVSBMt7IO5IU9mt?=
 =?us-ascii?Q?4I7KvIcrYeCijGhhJuUw5zFVFHJqG51qFlbxoizAB5LoiBLaximOvCtm2/+v?=
 =?us-ascii?Q?fd5ro7IQBbJ1IRuyoGqHS1aGc4RcixkYFverlepphSrLa2xj8T6+HzbWR+Q0?=
 =?us-ascii?Q?Xbo1huCce4z5fZnzYIhz0CBHOKlTDVK1g3D2276hcV9XTeGUvQWTiddS4MmF?=
 =?us-ascii?Q?cik14jlvQhxLQ0OLCQGcb1e6g4e1WgX1AoZoAHt0nbXadvUn1kaLcUXx4++u?=
 =?us-ascii?Q?JpPiSHOjzHnZzuYvtpLlCfhWiLkNrxzJ7ciu62fVgzKq6Wuxjc1TnVbeKQZD?=
 =?us-ascii?Q?NuZ50cf8sovdlNcCX9vfeSBtpg5sMxPM5chVj+iWZSdzWwlXceMkSMz7nE/S?=
 =?us-ascii?Q?h/BzHI0RfSfpz5ijfGBgazwsIHy9/2pJsOE4oJcTd3K8IMYGHP1tUDDgWkhD?=
 =?us-ascii?Q?KcMdSQHEx1yVUV76i7Bn0gaY6M3Dkg3jXFhoV6J6q60GrmjuSl15CNR3qZo3?=
 =?us-ascii?Q?al+iVgnmcGPkVNIrc6wi4sh4MElkIAILA87gmc7oxdEgX9FXelZ2pUMyj5f2?=
 =?us-ascii?Q?uSLDsaFZA8cbG62DjgYiNcM3+3hj05fPAwS+ClzC56RyRpGqDehdIdsDR8nM?=
 =?us-ascii?Q?zRDEwTA1OS/dUTpSbN6zKOas/+xeeVkdT8yuYMwVNVUSEsQX3b8caFRA+5/a?=
 =?us-ascii?Q?5thCh3nhvOJzRXZn+23VuKXBOF3YNySs68Q4aXOt9O5Z/pr6kvcbtwryhgzw?=
 =?us-ascii?Q?kbT15a//ViRpZa2WKgEDLUunAorH4iiQE1BhW02uz4PhNmhERNMrIwSRM5fE?=
 =?us-ascii?Q?QjEh/28/Qr9OQxVeszN5XIoNG/iGjccBKrD11sweAVRa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7f39fe-f29e-4159-3a13-08db8fb59052
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 21:56:57.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMUP2uurOwThjfnCTPJpDssal3TKp8iRKISY//OGIUTkYvfyDqVLjz4h+BbEToiokHnLGS6aegBDBW+lNWmVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: [Patch v3 3/4] RDMA/mana_ib : Create adapter and Add error eq
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
> +		ibdev_err(&mib_dev->ib_dev, "Failed to destroy adapter
> err %d", err);
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
> +		ibdev_err(&mib_dev->ib_dev, "Failed to create adapter
> err %d",
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

Should we do something with the event?




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
> -		/* Per GDMA spec, rmb is necessary after checking
> owner_bits, before
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
> -		dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u,
> nMSI:%u",
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

The previous code used list_for_each_entry_rcu() for iterating eq, need to =
add rcu_synchronize()?




> +			break;
> +		}
> +	}
>=20
