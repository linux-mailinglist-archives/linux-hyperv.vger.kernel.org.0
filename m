Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3B7678AE
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Jul 2023 00:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjG1Wwz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 18:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjG1Wwx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 18:52:53 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852D173F;
        Fri, 28 Jul 2023 15:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJnCoX7gc5oNmYLDnPfXp04/nIZqYeWQuSSyAbZccQ8AiQO54wYbu7GAMRpz/791S/LYX5Ybso6BeHVL1rtUCldhZOHW+lek+KgDgWSbXL95kXHsskqFhCjfq8M5gCYPd53eJDuAy5XH6rqwYCIIijh61Nc31J7eIX64ybcWHEipnNu/s1WyxzbjqZnisC+JuEp4ny1RZTQEf4/PU6ECaLg7OwRLiukrxDxnmjG9ekn/2Zeih2UUycptm6Cl7jNpHRb/SCskFf7HPY5utlbeW7cpDdO1eBgDGztXZWPDBRUIDTVjf9d8tPSayyygBuH23LS6x3HLnWjg+QZF/xhS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vozp/4Ki4SuwoXHxjhxYDrjB8r5bsAUy188LCAKSfno=;
 b=CHNH9254zrcJK3Eqvrs9n0sBZpV7Y4g7peyfMRsX+StuZPjpCE31FQhGsvAR8BP7lCaf6z5nD5RaGaKTBRFjNgz+Kc+p62b22MwZhxTYRjiKMa+3ilA16CP+ciQsCabwaZoC10cjhdnQieNw+mgfERyv44BkFN7XGLQLNSaAbwMXYm+QdxjgkVGaoGknR2xWR0t40vsKXQUXyZlzAPTwpAXkZyEPEEFNG8eRr9ieoork4mYA+z45luH+sbjYxzSrDAHxREG05NqTFQAYspJnwiwJI2Sx8jw6Sv47SgbtRLbeJPZi1JZUVjdFAiL2Myx0ksebLsph9tpki7+dwCEX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vozp/4Ki4SuwoXHxjhxYDrjB8r5bsAUy188LCAKSfno=;
 b=fEsflz+oJNwFysH3nGtJ/KvlXMwHsXIkd/UPGM4IgzeyqOJYlgY81t0aCaOqAYgDFRXuHhz83JIa/EidP+iwpWyzBVsrY3+NwYomu5OhTwJyMdXlehuXk7fQ43ok71jxSrhQj1T0uLQmMBd6LWLtuVCJzeJU888FZJDW5enRPrw=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MN2PR21MB1469.namprd21.prod.outlook.com (2603:10b6:208:203::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 22:52:49 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::dc6:5ee9:99d:8067%5]) with mapi id 15.20.6652.002; Fri, 28 Jul 2023
 22:52:48 +0000
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
Subject: RE: [Patch v3 4/4] RDMA/mana_ib : Query adapter capabilities
Thread-Topic: [Patch v3 4/4] RDMA/mana_ib : Query adapter capabilities
Thread-Index: AQHZv/z8OSFUQkUrH0yBZGVjygi/Xa/PvXcg
Date:   Fri, 28 Jul 2023 22:52:48 +0000
Message-ID: <PH7PR21MB3263014FF20892B142886FD2CE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690402104-29518-5-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-5-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3d99da01-1163-4608-9095-4756b3a30dc4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T21:59:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MN2PR21MB1469:EE_
x-ms-office365-filtering-correlation-id: 2e0ea8d2-1bbf-4c88-540a-08db8fbd5db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FB8ygf8SMYpz3E/N0xOpgxuMizZW6DjIDfZq7X7K9tVngYQVcPv/f1627286jK8o+ZvngvkwunNTsi6ekq8FRyG+7L1IFe5xyybxfno06KrHKRIzAIgyRpguFxn6IKXoyf1GgLeAFiKSud7FVrrGcrLT7cfTt1MMZRhGdSNMkHZYvlPRxsy6K2SGPXAp2uzKSab41iB6yGr8EAYPuQH2R0vcbrBKFKqOSCKuz3dYs/3T/oyQw2Q8kKjCEuOB4/MyjVjhjs9qTXygjwi/ae456hfGX9JjwpYy4kHotLxqh21QX+FH/S6I/xczqhQvaCA+g+dBgaXFKPrpp0NOPepOeLTN66MzRjA2A1A4p8OQRtSjrNVdegZ9KIr5b8UDnjOFaJnm0RFuHZ28fEbAHgRnzwKp411bCsjD/9bfwwZBXIvoiN8ODubJw0MhZurrrU02KwquA6VDUoPfkn+BvM/rOr1p6FpfuoJOshthppbR6ZygkYGHHe1TJBN8xwxsrE2QjomF5yFmgAMCi4n8+XnGS7PKnMrmeOOKhkmwRuFaNN+qUNZ9twWa0vOG8jhlgCjmO4AITMU7UIcGU82JHwjWqeUm4QEW/0jwXKUdRDYH/Q+g85qk0t5KalS/5q6vukGCfLcVPuMP+DyeoorkJQ4DsIM1SVy9OeqXijaT8Egt2/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(478600001)(9686003)(122000001)(107886003)(7696005)(83380400001)(33656002)(54906003)(8990500004)(6506007)(110136005)(71200400001)(2906002)(10290500003)(186003)(5660300002)(8936002)(55016003)(52536014)(38100700002)(66476007)(41300700001)(66556008)(316002)(82960400001)(66946007)(7416002)(4326008)(82950400001)(86362001)(66446008)(64756008)(76116006)(8676002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DcrDUxApXYWWFHFKj+aCfRLLfM8ptbgocuwdoXk46qJjlmABZhtU10uqyoRG?=
 =?us-ascii?Q?1Pfd0iFrTrmuU2sgnq4zacgzC1SAp8Q22Ml3JPlhVFgw9HM6N64urhBGg0Mc?=
 =?us-ascii?Q?FGupWS8Kc8Dfe/C6Y6hAEV3mJ1PEQeM3TB2Kyv1wXKJjKRiPwhgCwh8kB2SO?=
 =?us-ascii?Q?EpbCFPVgdTSHybqLuTjBHQ0dGf9fIJ+2KnyxDv0uWB6x26sXNOHeFGaruxhr?=
 =?us-ascii?Q?XbxxDHiEn9I1kvPl4aJqGCeEqD9OpESWJf915q9eHqTPSfmLoU8/iVyssW+g?=
 =?us-ascii?Q?JNgP1Spodww9uCAwRvFzAzxCE6xwbbw8TJQMsyiyA777tZgbkTXsARxu/AA9?=
 =?us-ascii?Q?w0V8tgnK2qlO/5rzfYjs6GiOXNnUeE/M3gTe+IAQ/ct6xu9pguW8xRt0OHkM?=
 =?us-ascii?Q?yTmVU4Pgz9mFB6hq9Qi4hhln07kacvf98wfR7ZSMDJJOgWBB+aDQy12XGcJc?=
 =?us-ascii?Q?6cq3vlhEa1KdvtLpB5W66yk9VszltjwanAgSoe9/pJlmgrhCDPxZWhlvvh0l?=
 =?us-ascii?Q?0txlPNtBnCHnvEqXYY7ueFuQdo2MecQfqdG7H7+GHqNwoAbhmOyHnk44PeR3?=
 =?us-ascii?Q?5+EMnMBrpBomQlmUwUoTKQMGFVbJtdfYc/ehCt2jqAecpOAOw1xCO++7b6fh?=
 =?us-ascii?Q?9ep1URZ/qTm8mYmTc694rBb0kKyAObYbzRl2uvz2RQh5nLP/XS/HVA4vpGPF?=
 =?us-ascii?Q?Fr9TNhFKGtLtvGLyLRvUL86EB8apRHv99SBh3kdBW+lrqCqZ8lNLfphEaMXM?=
 =?us-ascii?Q?9rFasN8ByTn+KpmysbL6pcjpgSmQxCBA0LWkD9f9yMXaMnKcccp9FBIPqckK?=
 =?us-ascii?Q?qgi5ZejLVXUiP9vDzdrMBDesYEh6N/XlmcqpIJ4KyR3BUJl3MTYQf4qq/hqc?=
 =?us-ascii?Q?aZ/R88W5JwyPFOaRP3MxjkVa7OKPDfgwCHBtz0ILR7ylJENhoP9dAChoC183?=
 =?us-ascii?Q?3M7+MDN13YdiXuXpuhiXp+PQjPjgq3aLgOUZNsVplT7CxcIAbSyiT3cPM6J/?=
 =?us-ascii?Q?FYzVos9xVV5W54Z6udPOW2A2OLdZDcs3f1LRXtrckLrnfftSK30Iqs3CflCV?=
 =?us-ascii?Q?Vkps4DUJC2KTBck9pXZChiDOppMRRjuIqP5c4TqCwmguJLyW+gvgQo/5ZLA/?=
 =?us-ascii?Q?cKTYdDLT/cenQN16d7l5M86tAL3QjFU774sfTK8tJVwYoe6Ii5JSYpLuhXZ0?=
 =?us-ascii?Q?J0jaQuskySc2IHNYobIUpQs4ryZg7aXpaBJEc0XKExGPC7jBcmyztPGHb22+?=
 =?us-ascii?Q?He8nzr/2c31vgC4U/RHryRje2iZPmIQof5hqiP0j2imETl/Hz3kdVNuZaTBF?=
 =?us-ascii?Q?OobecgriYnDGEOxBZY+bD9VoZFOyMJhLl9N+SUSUCuOADH5IfdiG4unsZFhq?=
 =?us-ascii?Q?KGSNTVoBkDr/H8RAPKnvamaIsWgmJOaOMFc+iyTeQ9nBnWgm/zxzUrkA3iIN?=
 =?us-ascii?Q?M6TRBnzXWvbcPydXvUYUTTXRloGqgNuBVApFy5YoF9F2dajXHt10WTlCZob8?=
 =?us-ascii?Q?kVWDmvwd1/A+OrzmB/jXCMmqC5/k8mAtdwdNii27WBgwsxpE9utMmVW/5XbO?=
 =?us-ascii?Q?Srs4SeUPSHdSSg+/3sT4/JlRwZWPY3Vv9xFt7iepauvqRkxJTdnXmV/Igj4W?=
 =?us-ascii?Q?VKBziN9PeXQ2I911IxTPcXbOY/tqjnWfZ6BRbNx6pm7z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0ea8d2-1bbf-4c88-540a-08db8fbd5db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 22:52:48.7019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SqSf/V7dOBQpWCCeLm3LjxeBrqdOriwJSPJpAp1dHjFtOVs16QVtriwNyuHy2w0EbwS2iR8ajJHpuSX9eIZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: [Patch v3 4/4] RDMA/mana_ib : Query adapter capabilities
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
>  drivers/infiniband/hw/mana/main.c    | 66 +++++++++++++++++++++++++-
> --
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

There is an ibdev_err() in mana_ib_query_adapter_caps(), how about merging =
this message with that?

And you can remove the return value of mana_ib_query_adapter_caps(), since =
it doesn't do something meaningful.

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

Does this mean mana_ib_query_adapter_caps() was a success?


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

This value is used in GDMA header of the request message? If so, define GDM=
A_MESSAGE_V3 in "include/net/mana/gdma.h".
