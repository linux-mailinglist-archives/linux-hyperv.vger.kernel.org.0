Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF2766240
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjG1DED (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jul 2023 23:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjG1DD5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jul 2023 23:03:57 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3A30DA;
        Thu, 27 Jul 2023 20:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD5bGrncXGwA2kx1MCuD6kWU/CCuCwfu2KwlP7PlOgHb+PfyYsm8mClwZGwHHBy5hytCFJz6yZIYB4sglO+WoAqvD4/k701DDJXtPcEQ7BgccPDyt40CLlCsHCWafZcUMqgSi/VVt6obOm0yTeCSDrOnoKipG3k1222AbuhCG5ad38Z+/FJoB0KNSB9b/+35LIZb5UNLjKbqfDb+kFo08YWgmoZU+BaC5eH7S732janPH/d1MDpds1kMtj2Ydi9tOuXGOMsX3s8g63x2LUuR9LvmkRdwz5GTp7lfEiFwrU+NCDXdx1gUWd1ynlFNfw4FWQZ0cFoGBXmwBVGkk+0O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY8BA9TSC+pt8a6PrE5LVR74jl3ivwPn36kRBGjmzqw=;
 b=mehQBSDbjEAQoOJ9ggdQdHDUjg6IDet4zILChZK0+bsPow4F+l8XxPujKByg/357QPtjzyxhJIYXVsOIurvx+tuG1RPJVw4JNIwZ3c4t8uTvJm2pJNNamgngGWlea4KXFhAbgw+fDmMs9CZj/xZ7KM9iv4zMcI4qL5r1eAC6e3y2uJBYzzndFI637noWoToBjAMxOSpdn4Xlu7/5pVMnKx4hg2W4G5IxIwbwk3SOYh0BZb9ujkC8RlA6gi+ElmHbQn3+B4aHmG1mfaoJAty+/Lp5RziYEwXCSG9qb9+YKSaZ69nfND7qvcuTyO9pz4AZIW0MERTBJGBPCuspnM2MgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY8BA9TSC+pt8a6PrE5LVR74jl3ivwPn36kRBGjmzqw=;
 b=fwUjCY7EUhCoFxhPxnKat53PUwKIU0iicX/mK4pk2/u9/BbRs4+vZSzsL8S91YJ+LsyyRI6x0bBSHFWJWj/Lb74BmbxpmjbO2lWy4Jcz/g/NT41wtJHaXnqeyGfoNe1gSmmITGVwJLqH6zTDu1boc7ApBLeXe0ngt+m6fETamn0=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by DS7PR21MB3365.namprd21.prod.outlook.com (2603:10b6:8:81::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 03:02:45 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453%6]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 03:02:45 +0000
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
Subject: RE: [EXTERNAL] [Patch v3 4/4] RDMA/mana_ib : Query adapter
 capabilities
Thread-Topic: [EXTERNAL] [Patch v3 4/4] RDMA/mana_ib : Query adapter
 capabilities
Thread-Index: AQHZv/z1m3LZYquD6kuyP+3sZKINjK/Of+7A
Date:   Fri, 28 Jul 2023 03:02:44 +0000
Message-ID: <BY5PR21MB1394DDA550A3FACD1931F48ED606A@BY5PR21MB1394.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-5-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-5-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=668531c7-f808-4369-b2c6-0799fd0c0a8c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T03:02:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|DS7PR21MB3365:EE_
x-ms-office365-filtering-correlation-id: 38a8ba2f-de47-4683-8539-08db8f171dcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AqeEV9p7/ZtDzWDakKdfAjhccUDFb4LootPg9ifP4zKLO33M8XOpvlL4AQz7KWL3nh2tNWSIEvCiDiu9hp4sT40/1TdDVxE0zwBBFe4VNRCe/5Hhwijt1Xh8pT9KNh70aUaUImA6ZUlbd6AFTqeiJdycEDVKz6GvFTOf3YddzgiAWGWbjHRYjCaAOfRvfJo8FYuomEPxyXPJCMBr6vpL2obV3K//h8Qp+0LCmwB2qsVkusq9BmOAWhH0A6isMqfRKC1wtke3AWeaAnptPSgTTFdP2605NSEjZBbl8HEVMJYGFlaHY0TVjmbza1HrKyFs9lFftXPJX4ilxIDJ6x08WqMfrkMZpp/oZVtyUNO6ht6dfwUsACwSIbzSKf39xNZqjCR6WkZi85Zvz9voEdzelH/k2wLTfDkh+/1cCPiZBOt3UYO2Nr+/y+yZ/s5lh5QVKDZrlDEqlyTPSTaY78/j8a5ZEsiXeD8V0ZfPKx/PEGLxbNxNDWc3mWLlb9QSgFxD46H7whsxCu0FyFT7B0t6LxtUs6xSjn7LEJ2AErUbF+K0hVKn5tdWhWD4uuk31Zt0mrHIYkhBYkcZ0Y593yl7kE6JK7PsBQ2TgJKzxek21Sg6F+9feevhzFqCUH++twxyMOjjhvD1gTk+OkYs7X2+JlU/BBYc93kNc7c0/ziK0TIgS7egVClRzNvsoZti4JU4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(7416002)(38070700005)(921005)(33656002)(7696005)(55016003)(53546011)(6506007)(83380400001)(66446008)(64756008)(9686003)(66556008)(186003)(38100700002)(122000001)(107886003)(76116006)(2906002)(66946007)(66476007)(82950400001)(82960400001)(316002)(71200400001)(4326008)(5660300002)(8990500004)(41300700001)(8676002)(86362001)(52536014)(54906003)(110136005)(478600001)(10290500003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7/SPJ2VoBlJXqxQzt0ecPW7fkPbDWVBdcC1UNif6S6TmHcX5V+zHU0U4DdCd?=
 =?us-ascii?Q?MGGtTXPUsiBcgrZYHc4U9Sj379+tUyAd7vqyIUosDARRbDmvpLZuQagZftSf?=
 =?us-ascii?Q?kUNt1GbjltjSVaSxkIXfSd9j9QNS4svxEBy/QyRN1kgnnEyrVsiwqKbdzdDt?=
 =?us-ascii?Q?KowcU30HogFvaNpU+BVMC7GUmxEbiXZi2V11y1YStAQaZUK2Db4yymg+3XFr?=
 =?us-ascii?Q?u5NIxEPfxCtv1TJJX5o3ge749SmeXuwsbITmn+jyRVJwwq4CpiGoHgrDiqyK?=
 =?us-ascii?Q?JW9qWAXPsBAR0ZaHuoWMhb/xa026QkRDBW8pUgjNSYnmrorUrtoTaJCGta7+?=
 =?us-ascii?Q?AUIhu29WF9AfMRWguuaKtFbZyjnd/6+8zCBpmlytCkn22i99KtkpN0xtib7a?=
 =?us-ascii?Q?5c/2FPP4PVUdKx3JuCKBwVOWUUL7ErZFaUoLKDzbXqLc+UbIn33FB4ca+xAQ?=
 =?us-ascii?Q?250HejhB5RWqHo0v9IzRT7IJUr4wZRmYw/GTicI8ZLHA4PrTmitRO2EtjqDO?=
 =?us-ascii?Q?RZLYmg5rvV7SJTskwuUMJ3EBhmI5Tnw/gjMmi0sqINzfC5sBYSw1o1zWWZBL?=
 =?us-ascii?Q?TEfZ0PAuO3RFB0Ir5maGasPP9F2uz8VrmuMlHYg4Ar0K9yKYLrWKLRX+ypne?=
 =?us-ascii?Q?RZQl1FIQr9pDRVfUTWqR2pxNEWOzJ0kiMGyDfvdm5OgUn+M1MXrOB2URiFcT?=
 =?us-ascii?Q?LHAS/WoIUqRZnqsbQEEfcJSJTmBatM1k5jtHdhtpC2uIyUCQs86o6zprEahr?=
 =?us-ascii?Q?x4TjRNE6pw5fR+EXhSh93oHGUOXtQthLQSpy2L3cf+AbrtAfjUxFLwLlJgdb?=
 =?us-ascii?Q?AtUQNZqkDhMQjk1pJb0KxN2SPc9wT0xBQhMRm2OkCokST3VpEj3InBTZ90zf?=
 =?us-ascii?Q?hfreAYHd/tIdwUJCube7vN0ErEwJpCcVP82tK39aGY1evohXnbb9+Myb5VeN?=
 =?us-ascii?Q?L14frTpjFqzxv4mvlfzohYonhbz4Rc106ZMRRp2TyKa2APhbXPw4cdc5D3Gw?=
 =?us-ascii?Q?snrLbVC1Pg/nybRn2A/GILr3s1e8OiU93ifm/ZNKj6tKWpNtiZGKU5xe6w+q?=
 =?us-ascii?Q?g+AIoOajfy4d5X5asOHqRGZ5msag+rXNEbHRW0hk/eQ9R0A83skJps1EkORI?=
 =?us-ascii?Q?1EYKYT1F7Tdhflu3D94WB56ywHWmKPdO3C6cJ3x4xvpgMnNGyoZ5yjgdwhlp?=
 =?us-ascii?Q?IxjGXeaR0S7w0R4YblFUS99LwXcs+i5zE7crQdLv26MHdco09Q74SdcHR/PI?=
 =?us-ascii?Q?SATyzx/y/TdlBZ87XNWMyz9I6jDv5gZpOVAH84BtWZlylAeSc6h0QQXfzcFd?=
 =?us-ascii?Q?cJndrusjGqGrgki+5TZ4arjBWUXGegg6ww1NsHOf4K40VNTfZUqY2rtEIaZ8?=
 =?us-ascii?Q?YKqCcMkXBhubBCBcy/Sr4EsSjHIroLpb0mn7SVbVAS2UOXsx2rhdmMrYQyGB?=
 =?us-ascii?Q?UlPnoAHelwdr/BdRN2xxZWl1lgigxPSTYE40jcXAX+MUeAn7Qbgdglj2JGx9?=
 =?us-ascii?Q?JvE4MJLrMg4DB0MPriYelrcXPQ0nigGdIjHcNesUvmwIN+zfaYda9+L9F3NJ?=
 =?us-ascii?Q?8FDKFqD7hN87GGnTsW+YyUQujie8GzBz9kk0FYbZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a8ba2f-de47-4683-8539-08db8f171dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 03:02:44.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwDsBfe1iTJQ+3d6nSnICAwuOH5CcwMO5qOdVUeYnZFXQbmk9b/sPfYcP090ZHnIkAJV96h3/6mRoKDT+euSHOSelcvEzf8x8pcQr9LRigA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3365
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
> Sent: Wednesday, July 26, 2023 3:08 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: linux-rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> <sharmaajay@microsoft.com>
> Subject: [EXTERNAL] [Patch v3 4/4] RDMA/mana_ib : Query adapter
> capabilities
>=20
> From: Ajay Sharma <sharmaajay@microsoft.com>
>=20
> Query the adapter capabilities to expose to other clients and VF. This ch=
ecks
> against the user supplied values and protects against overflows.
>=20
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  |  4 ++
>  drivers/infiniband/hw/mana/main.c    | 66 +++++++++++++++++++++++++---
>  drivers/infiniband/hw/mana/mana_ib.h | 53 +++++++++++++++++++++-
>  3 files changed, 115 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 4077e440657a..e15da43c73a0 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -97,6 +97,10 @@ static int mana_ib_probe(struct auxiliary_device *adev=
,
>  		goto free_error_eq;
>  	}
>=20
> +	ret =3D mana_ib_query_adapter_caps(mib_dev);
> +	if (ret)
> +		ibdev_dbg(&mib_dev->ib_dev, "Failed to get caps, use
> defaults");
> +
>  	ret =3D ib_register_device(&mib_dev->ib_dev, "mana_%d",
>  				 mdev->gdma_context->dev);
>  	if (ret)
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 1b1a8670d0fa..512815e1e64d 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -469,21 +469,27 @@ int mana_ib_get_port_immutable(struct ib_device
> *ibdev, u32 port_num,  int mana_ib_query_device(struct ib_device *ibdev,
> struct ib_device_attr *props,
>  			 struct ib_udata *uhw)
>  {
> +	struct mana_ib_dev *mib_dev =3D container_of(ibdev,
> +			struct mana_ib_dev, ib_dev);
> +
>  	props->max_qp =3D MANA_MAX_NUM_QUEUES;
>  	props->max_qp_wr =3D MAX_SEND_BUFFERS_PER_QUEUE;
> -
> -	/*
> -	 * max_cqe could be potentially much bigger.
> -	 * As this version of driver only support RAW QP, set it to the same
> -	 * value as max_qp_wr
> -	 */
>  	props->max_cqe =3D MAX_SEND_BUFFERS_PER_QUEUE;
> -
>  	props->max_mr_size =3D MANA_IB_MAX_MR_SIZE;
>  	props->max_mr =3D MANA_IB_MAX_MR;
>  	props->max_send_sge =3D MAX_TX_WQE_SGL_ENTRIES;
>  	props->max_recv_sge =3D MAX_RX_WQE_SGL_ENTRIES;
>=20
> +	/* If the Management SW is updated and supports adapter creation */
> +	if (mib_dev->adapter_handle) {
> +		props->max_qp =3D mib_dev->adapter_caps.max_qp_count;
> +		props->max_qp_wr =3D mib_dev-
> >adapter_caps.max_requester_sq_size;
> +		props->max_cqe =3D mib_dev-
> >adapter_caps.max_requester_sq_size;
> +		props->max_mr =3D mib_dev->adapter_caps.max_mr_count;
> +		props->max_send_sge =3D mib_dev-
> >adapter_caps.max_send_wqe_size;
> +		props->max_recv_sge =3D mib_dev-
> >adapter_caps.max_recv_wqe_size;
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -599,3 +605,49 @@ int mana_ib_create_error_eq(struct mana_ib_dev
> *mib_dev)
>=20
>  	return 0;
>  }
> +
> +static void assign_caps(struct mana_ib_adapter_caps *caps,
> +			struct mana_ib_query_adapter_caps_resp *resp) {
> +	caps->max_sq_id =3D resp->max_sq_id;
> +	caps->max_rq_id =3D resp->max_rq_id;
> +	caps->max_cq_id =3D resp->max_cq_id;
> +	caps->max_qp_count =3D resp->max_qp_count;
> +	caps->max_cq_count =3D resp->max_cq_count;
> +	caps->max_mr_count =3D resp->max_mr_count;
> +	caps->max_pd_count =3D resp->max_pd_count;
> +	caps->max_inbound_read_limit =3D resp->max_inbound_read_limit;
> +	caps->max_outbound_read_limit =3D resp->max_outbound_read_limit;
> +	caps->mw_count =3D resp->mw_count;
> +	caps->max_srq_count =3D resp->max_srq_count;
> +	caps->max_requester_sq_size =3D resp->max_requester_sq_size;
> +	caps->max_responder_sq_size =3D resp->max_responder_sq_size;
> +	caps->max_requester_rq_size =3D resp->max_requester_rq_size;
> +	caps->max_responder_rq_size =3D resp->max_responder_rq_size;
> +	caps->max_send_wqe_size =3D resp->max_send_wqe_size;
> +	caps->max_recv_wqe_size =3D resp->max_recv_wqe_size;
> +	caps->max_inline_data_size =3D resp->max_inline_data_size; }
> +
> +int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev) {
> +	struct mana_ib_query_adapter_caps_resp resp =3D {};
> +	struct mana_ib_query_adapter_caps_req req =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_GET_ADAPTER_CAP,
> sizeof(req),
> +			     sizeof(resp));
> +	req.hdr.resp.msg_version =3D
> MANA_IB__GET_ADAPTER_CAP_RESPONSE_V3;
> +	req.hdr.dev_id =3D mib_dev->gc->mana_ib.dev_id;
> +
> +	err =3D mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
> +				   sizeof(resp), &resp);
> +
> +	if (err) {
> +		ibdev_err(&mib_dev->ib_dev, "Failed to query adapter caps
> err %d", err);
> +		return err;
> +	}
> +
> +	assign_caps(&mib_dev->adapter_caps, &resp);
> +	return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 8a652bccd978..1044358230d3 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -20,19 +20,41 @@
>=20
>  /* MANA doesn't have any limit for MR size */
>  #define MANA_IB_MAX_MR_SIZE	U64_MAX
> -
> +#define MANA_IB__GET_ADAPTER_CAP_RESPONSE_V3 3
>  /*
>   * The hardware limit of number of MRs is greater than maximum number of
> MRs
>   * that can possibly represent in 24 bits
>   */
>  #define MANA_IB_MAX_MR		0xFFFFFFu
>=20
> +struct mana_ib_adapter_caps {
> +	u32 max_sq_id;
> +	u32 max_rq_id;
> +	u32 max_cq_id;
> +	u32 max_qp_count;
> +	u32 max_cq_count;
> +	u32 max_mr_count;
> +	u32 max_pd_count;
> +	u32 max_inbound_read_limit;
> +	u32 max_outbound_read_limit;
> +	u32 mw_count;
> +	u32 max_srq_count;
> +	u32 max_requester_sq_size;
> +	u32 max_responder_sq_size;
> +	u32 max_requester_rq_size;
> +	u32 max_responder_rq_size;
> +	u32 max_send_wqe_size;
> +	u32 max_recv_wqe_size;
> +	u32 max_inline_data_size;
> +};
> +
>  struct mana_ib_dev {
>  	struct ib_device ib_dev;
>  	struct gdma_dev *gdma_dev;
>  	struct gdma_context *gc;
>  	struct gdma_queue *fatal_err_eq;
>  	mana_handle_t adapter_handle;
> +	struct mana_ib_adapter_caps adapter_caps;
>  };
>=20
>  struct mana_ib_wq {
> @@ -96,6 +118,7 @@ struct mana_ib_rwq_ind_table {  };
>=20
>  enum mana_ib_command_code {
> +	MANA_IB_GET_ADAPTER_CAP =3D 0x30001,
>  	MANA_IB_CREATE_ADAPTER  =3D 0x30002,
>  	MANA_IB_DESTROY_ADAPTER =3D 0x30003,
>  };
> @@ -120,6 +143,32 @@ struct mana_ib_destroy_adapter_resp {
>  	struct gdma_resp_hdr hdr;
>  }; /* HW Data */
>=20
> +struct mana_ib_query_adapter_caps_req {
> +	struct gdma_req_hdr hdr;
> +}; /*HW Data */
> +
> +struct mana_ib_query_adapter_caps_resp {
> +	struct gdma_resp_hdr hdr;
> +	u32 max_sq_id;
> +	u32 max_rq_id;
> +	u32 max_cq_id;
> +	u32 max_qp_count;
> +	u32 max_cq_count;
> +	u32 max_mr_count;
> +	u32 max_pd_count;
> +	u32 max_inbound_read_limit;
> +	u32 max_outbound_read_limit;
> +	u32 mw_count;
> +	u32 max_srq_count;
> +	u32 max_requester_sq_size;
> +	u32 max_responder_sq_size;
> +	u32 max_requester_rq_size;
> +	u32 max_responder_rq_size;
> +	u32 max_send_wqe_size;
> +	u32 max_recv_wqe_size;
> +	u32 max_inline_data_size;
> +}; /* HW Data */
> +
>  int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
>  				 struct ib_umem *umem,
>  				 mana_handle_t *gdma_region);
> @@ -194,4 +243,6 @@ int mana_ib_create_adapter(struct mana_ib_dev
> *mib_dev);
>=20
>  int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev);
>=20
> +int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev);
> +
>  #endif
> --
> 2.25.1

