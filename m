Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB05FCB97
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Oct 2022 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJLT2V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Oct 2022 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJLT2R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Oct 2022 15:28:17 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023027.outbound.protection.outlook.com [52.101.64.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886B4104533
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Oct 2022 12:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYKkgj9z5Q4dfpURcz4/nOiYYbfc3NYBvt0vVfYYlw1JewfMyF7MizEp++GORMUqCaym85f/GSABjeEfy7atm7/8X/vbySb89Kxr4zL5EqOh9IRD4u+TdGgLNuLiwmq5vIIKmTCihIRFfIsDkkrldHA0Gxfxt0KvuETzMvJSAngkilx1jYmpl0pmAvDQMI4OVcz7V1xR6DOoVo425Ak2ymWv87jrJ6QlEMfxCstKLot7FT64udBaZrJwgV1rnzWuTw8RXRFvIfeFPGImnB2l6Etxm1+ZTCrcr5NvYVUkp4LQsjpLsH6Ac/dW6+yXTnKT/p2LVjYfZnZQQrqmI2ynoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bP95H8SN7qPOEctTywfErjODP8sg6nfCIVgn4NlYfM=;
 b=BPvQTzeoAkWXgP3zc1jrhOj463t2dJnDXrfZGfOCLN5VeoNWx10d4ISZmF5h8wp5jtiX9tHaO2K2RG6XYbfbDtaghgnPbC981Lmjr5m+0zrZ538sIy8Kg/ZQ4/1z60zkW8X9gTSU49cs2vRlaR71RFM3Mkx9WceYrclkiIVaTVeZlMZNPaLI2eOJ5sBsWu+joT98L79dDword8wpKblU4whn84SfQERJAYRJOnWNtQqw2YtRhgS9Y5A5YGTCmteutEzutMpOmx7KRO+9Coo5tRNyjyrR8rPuN+0mfLqAHO1bVFpAwF3bCq/2SCVKyfQiXd5YFJqKj4r31fb4SPg1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bP95H8SN7qPOEctTywfErjODP8sg6nfCIVgn4NlYfM=;
 b=M3ODrZfZfMCCd7RgMZc8h1JWD1D5Sz5C8huwl1MWC8j2BGAzTagBEvR25KVT0Y2zL4NHsLxwnoiY0WZTRnRF9kp52xW9OpyDe8WE7vkzlXxLw6R6uAETJ1vaWLvO4L+RgwBHBMxtBGaFITa8RpHiPuq5gq5S2AnmUqVE3XfWiJ0=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by IA1PR21MB3474.namprd21.prod.outlook.com (2603:10b6:208:3e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Wed, 12 Oct
 2022 19:28:06 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::e19e:c7cf:1bf0:1a75]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::e19e:c7cf:1bf0:1a75%7]) with mapi id 15.20.5723.009; Wed, 12 Oct 2022
 19:28:05 +0000
From:   Long Li <longli@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [bug report] RDMA/mana_ib: Add a driver for Microsoft Azure
 Network Adapter
Thread-Topic: [bug report] RDMA/mana_ib: Add a driver for Microsoft Azure
 Network Adapter
Thread-Index: AQHY3jGcKl5EAKnNekG2HcbqAAd5y64LJPYg
Date:   Wed, 12 Oct 2022 19:28:05 +0000
Message-ID: <PH7PR21MB32639BD5A0D7F8A2B2E883F9CE229@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <Y0arQIeN4aJC+yE4@kili>
In-Reply-To: <Y0arQIeN4aJC+yE4@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6635958f-8b95-4f7d-ac8b-92e31ef3c3ce;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-12T19:27:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|IA1PR21MB3474:EE_
x-ms-office365-filtering-correlation-id: 2558dcdc-a448-4d46-af30-08daac87e33b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2O6C3d94iB7WQy8mhYaQR2pwSKAXghbD1pDpmeKxCcTkiGGLZlOzNTcbVfwpnobKCIMYS0+VWZMoJT+csUDAh59qwLGsUUAViSvgZp8ykORwN4E7PjLbWoU3NW30OfNY43AN+qaGxUpCRiQBNiqxkKHG5Hy7pUS0qf/wv3SE/cNWfmgw+CLHdCjb9xKeyxo+wPegJGOapz5sHkcizWIWSpf8Wh8PqwRJUC1J9kvGWoTCf4BrIye3sisLTDrVW8B2RUaauTbBgevThBtQy2MPN+QcTzH2M/O/nkkfb+oRqCXO8dQOvrbyVqVAPPNsW/y++1hnmUnUPWk4PX0phQYR201hFZQCckD/qUHKeNtiRgTeT7F20OlSSc6YDrligOtxSSHLl4pEhdmyfluBswtaYU2Z7nZBJe8ly0l8oPJ/uE+JbbF7wfnq6xO0ZMRn7HGPH5MOIF1LKmQQjQDupNg6DjKc+UUMIGh1vMfQVAb3rj4irMDH/93ZcTvITKxSDR21ikXTnNqtPpL2nCyvDzTCyRW+mGfPsU24Wiy75L/MbflB+38vhVa7v3B9Dj9Um3PuG7EyYApP/V1zhwd/UL8HjpcA8J7Fa1YcVY7GQj2EAq8xksNX+lSimnP0DHfF1qLfS8k61/3k4SanIe4udzz1hcCsQ+SiHBDD3IVxQY6k9/Y6ftuhMJdRBvI8n3vVr/cBl7Hm3ITCNBSqlGWIE8mj40GCYDRp1qtFYM52MzQimC5fRb0MhLw0sSoH6M2fd4yI4DGAsq/4TPnnFdGzQTk1eLPQl1fB+7Od6t0iThJ3qI2mhq8bfB3U0UyV3cyE34p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(47530400004)(451199015)(316002)(55016003)(82960400001)(82950400001)(8990500004)(6916009)(8936002)(33656002)(186003)(122000001)(26005)(9686003)(52536014)(5660300002)(2906002)(8676002)(4326008)(66476007)(66446008)(64756008)(38100700002)(7696005)(76116006)(66946007)(6506007)(66556008)(41300700001)(71200400001)(38070700005)(83380400001)(86362001)(478600001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Svp6qNcdavUTFBMizJPYyTz6NWk7iMFlRdOfJArInyGHDhA7zR2ILvkR7PwM?=
 =?us-ascii?Q?vmwTBQ82HvhnEuyhmmEAcSpYjoIbeVIWbAb7Af7Nj61ZhRnji5M0RfmFk+2c?=
 =?us-ascii?Q?aI0sW+NZLG6V0WFxTauERF2EBh9FpYnXox8fBomtVV/5mucOjkgTKCwzzmLM?=
 =?us-ascii?Q?v8PKfvzYeH7hji1rOvAgLAs194SWiT7fL1WJf0CQulrWGlEKNodK/CV+PFNJ?=
 =?us-ascii?Q?69NThW36ysa4TJATJL0c05RpDvB+KBUAZNKSsKN4Y4x8Tz5ugDfoj6NwHJMV?=
 =?us-ascii?Q?gA9TxJZkokaGS71y1+pVWpezfyk0lUV//IEgyF+wVpgl2Px+vclzh8POvrKv?=
 =?us-ascii?Q?lna492/aHeXO77aEh0sRAyQcE500jUYcoZBj0WWlTV0A1Mp0QKkz0YK6NCF+?=
 =?us-ascii?Q?/1g5LtJnZW7pna4YoWni2xbtRbXsWJpwXoa46mSG/UfGeyjZ8IpuYumc1fA6?=
 =?us-ascii?Q?hIHOzp9v9M+2Xqk6KTeAtqtcjYWxF8Zy8JOSOtFGAvByRsLofs522iaI4Dlk?=
 =?us-ascii?Q?NXL+9t6ExxW9z7DDh3ZXIlFkXlCilcLQQ3dnMf5UcL8IrocNNh6rT1Emzdj8?=
 =?us-ascii?Q?Tz7a4pn/ReKXlWurhfeNfgTVa+7PF+t0ms/ZFodw+FzUluZ7SU7K7rU3oaRm?=
 =?us-ascii?Q?vpC8UDsP6nKZggSMzEO6QJsQXLRnIRylWWbZ6NwGXtFQ4hMGq/sdbkLCg0rB?=
 =?us-ascii?Q?LGhPXIlKrISv7X++CuEt7k7AuVpD9DVurfbOgvkX65KmFJmALfLCKur+TgYS?=
 =?us-ascii?Q?j+6a005yn1iXiy3/JqTrPJ+jud6zyVUzjAbFq98+q3EImXBce1/NRf81KZB9?=
 =?us-ascii?Q?AgV/RsEHNJc28/PMSLbDbVpYfyA4+TDIm1aPUGQW2p/9oSIocX5vUJY8tcep?=
 =?us-ascii?Q?jxnPCcZi8SC5i7KH1RtzGWJMGjyYZGoblAJe9IZ8KkeyBVTwLziwCUgcngdY?=
 =?us-ascii?Q?VlTgu7CU8cyTfRFzmnI467XpbNmS2AJOBrlesUmP70tXpZKKKWx0dFaZPYZ8?=
 =?us-ascii?Q?BXoz0VPd6a7dTrigOP7rUrT9ccISGa0YlQ3Jl3i/B93FRk+13a30KtOv0jld?=
 =?us-ascii?Q?RUj6hyIDXiifzCTxW5AL8DovbyKOzsrcfoArAhF+KKG6XdAauOyvxop25N+4?=
 =?us-ascii?Q?UtE1PiZrZi31dlyshQg3aekGH5uWTwK5JBVbJPvzkywX9jn7Ocm/mKtay5pF?=
 =?us-ascii?Q?vSev69YqOmmr/MLZVxLUPe323TMEqW3g7gCc27ie4MiuidjakLTqep6wOKzX?=
 =?us-ascii?Q?hOj3e7UnjS0GMu0cJ/tJ7X8vRlDmaQYGgtJ3XFwZrM+xQBsurxSBjKu2HTP4?=
 =?us-ascii?Q?OaO5ucjrjy8zBCoED7/kFFBgL+NbMMXLu4iH7bceyp9MSxSiYUJ9+HSAlMWa?=
 =?us-ascii?Q?4wjL5AFxEE+aN7bJ8xWItBWVCEpqKA8YNWfI0xJ99YJ6SILsHrR91ZsReCfK?=
 =?us-ascii?Q?TtMHjFNX8R6zcBerD6bw11pcKtxsRXphz/kOetoWGNufDyLquE7SYuJSzV1S?=
 =?us-ascii?Q?dpNctplApAaW9QqHOdX+VS7VEthEhpvA/NxtlKGvU+/5fCLJDPDcbC9DocBr?=
 =?us-ascii?Q?XiNUvR9pp3UbuO5kI+5iPMfJhE2R9+1xP6mMeI08?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2558dcdc-a448-4d46-af30-08daac87e33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 19:28:05.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKsHPA/Yfxp3SQ8XK4OIMsJsZHTByMi+tl9hu2XbzUq6NUgi7fnJXabr6+pazDDtLcqwQGcAUNYClD4/MCdBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3474
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: [bug report] RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter
>=20
> Hello Long Li,
>=20
> This is a semi-automatic email about new static checker warnings.
>=20
> The patch 6dce3468a04c: "RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter" from Sep 20, 2022, leads to the following Smatch
> complaint:
>=20
>     drivers/infiniband/hw/mana/qp.c:221 mana_ib_create_qp_rss()
>     warn: variable dereferenced before check 'udata' (see line 115)

Thank you, will fix this.

Long

>=20
> drivers/infiniband/hw/mana/qp.c
>    114
>    115		if (udata->inlen < sizeof(ucmd))
>                     ^^^^^^^^^^^^
> This code assumes "udata" is non-NULL
>=20
>    116			return -EINVAL;
>    117
>    118		ret =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd),
> udata->inlen));
>    119		if (ret) {
>    120			ibdev_dbg(&mdev->ib_dev,
>    121				  "Failed copy from udata for create rss-qp,
> err %d\n",
>    122				  ret);
>    123			return -EFAULT;
>    124		}
>    125
>    126		if (attr->cap.max_recv_wr >
> MAX_SEND_BUFFERS_PER_QUEUE) {
>    127			ibdev_dbg(&mdev->ib_dev,
>    128				  "Requested max_recv_wr %d exceeding
> limit.\n",
>    129				  attr->cap.max_recv_wr);
>    130			return -EINVAL;
>    131		}
>    132
>    133		if (attr->cap.max_recv_sge > MAX_RX_WQE_SGL_ENTRIES) {
>    134			ibdev_dbg(&mdev->ib_dev,
>    135				  "Requested max_recv_sge %d exceeding
> limit.\n",
>    136				  attr->cap.max_recv_sge);
>    137			return -EINVAL;
>    138		}
>    139
>    140		if (ucmd.rx_hash_function !=3D
> MANA_IB_RX_HASH_FUNC_TOEPLITZ) {
>    141			ibdev_dbg(&mdev->ib_dev,
>    142				  "RX Hash function is not supported, %d\n",
>    143				  ucmd.rx_hash_function);
>    144			return -EINVAL;
>    145		}
>    146
>    147		/* IB ports start with 1, MANA start with 0 */
>    148		port =3D ucmd.port;
>    149		if (port < 1 || port > mc->num_ports) {
>    150			ibdev_dbg(&mdev->ib_dev, "Invalid port %u in
> creating qp\n",
>    151				  port);
>    152			return -EINVAL;
>    153		}
>    154		ndev =3D mc->ports[port - 1];
>    155		mpc =3D netdev_priv(ndev);
>    156
>    157		ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d
> port %d\n",
>    158			  ucmd.rx_hash_function, port);
>    159
>    160		mana_ind_table =3D kzalloc(sizeof(mana_handle_t) *
>    161						 (1 << ind_tbl-
> >log_ind_tbl_size),
>    162					 GFP_KERNEL);
>    163		if (!mana_ind_table) {
>    164			ret =3D -ENOMEM;
>    165			goto fail;
>    166		}
>    167
>    168		qp->port =3D port;
>    169
>    170		for (i =3D 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
>    171			struct mana_obj_spec wq_spec =3D {};
>    172			struct mana_obj_spec cq_spec =3D {};
>    173
>    174			ibwq =3D ind_tbl->ind_tbl[i];
>    175			wq =3D container_of(ibwq, struct mana_ib_wq, ibwq);
>    176
>    177			ibcq =3D ibwq->cq;
>    178			cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
>    179
>    180			wq_spec.gdma_region =3D wq->gdma_region;
>    181			wq_spec.queue_size =3D wq->wq_buf_size;
>    182
>    183			cq_spec.gdma_region =3D cq->gdma_region;
>    184			cq_spec.queue_size =3D cq->cqe * COMP_ENTRY_SIZE;
>    185			cq_spec.modr_ctx_id =3D 0;
>    186			cq_spec.attached_eq =3D GDMA_CQ_NO_EQ;
>    187
>    188			ret =3D mana_create_wq_obj(mpc, mpc->port_handle,
> GDMA_RQ,
>    189						 &wq_spec, &cq_spec, &wq-
> >rx_object);
>    190			if (ret)
>    191				goto fail;
>    192
>    193			/* The GDMA regions are now owned by the WQ
> object */
>    194			wq->gdma_region =3D GDMA_INVALID_DMA_REGION;
>    195			cq->gdma_region =3D GDMA_INVALID_DMA_REGION;
>    196
>    197			wq->id =3D wq_spec.queue_index;
>    198			cq->id =3D cq_spec.queue_index;
>    199
>    200			ibdev_dbg(&mdev->ib_dev,
>    201				  "ret %d rx_object 0x%llx wq id %llu cq
> id %llu\n",
>    202				  ret, wq->rx_object, wq->id, cq->id);
>    203
>    204			resp.entries[i].cqid =3D cq->id;
>    205			resp.entries[i].wqid =3D wq->id;
>    206
>    207			mana_ind_table[i] =3D wq->rx_object;
>    208		}
>    209		resp.num_entries =3D i;
>    210
>    211		ret =3D mana_ib_cfg_vport_steering(mdev, ndev, wq-
> >rx_object,
>    212						 mana_ind_table,
>    213						 ind_tbl->log_ind_tbl_size,
>    214						 ucmd.rx_hash_key_len,
>    215						 ucmd.rx_hash_key);
>    216		if (ret)
>    217			goto fail;
>    218
>    219		kfree(mana_ind_table);
>    220
>    221		if (udata) {
>                     ^^^^^
> Can it be NULL?
>=20
>    222			ret =3D ib_copy_to_udata(udata, &resp, sizeof(resp));
>    223			if (ret) {
>=20
> regards,
> dan carpenter
