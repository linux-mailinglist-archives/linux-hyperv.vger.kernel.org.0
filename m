Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46D95FA443
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Oct 2022 21:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJJTiL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Oct 2022 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJJTiK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Oct 2022 15:38:10 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021021.outbound.protection.outlook.com [52.101.52.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A21D74CC1
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Oct 2022 12:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSHMB4qHChcL/h6c1HCR/7kacrluSjG72LUHnfqa6YagfwY2jofswKmZ/bNFoSiCIQVj94VQxnrWtYbsOSRwPnVUKlw68BV74lUrhDL7yHDbWQ0gsL+ulTBGSMPMksmlqbNavccUjiHTnoi457kqk9dDtJAizxoSXtu3bRQRXgUAOn/vWqtLl+Qy2QrmAjiSUM0KNGnH0LScmIDpqfaI3A2pUqd1D71u1cVGTTHkVD8XS3ojH2cp7x5VCvzydL0xU45+3GBznh7bQ8L1/iD9KzXE/Ky0rbHhgAnKNFU6u9O6hNCV3pmA23PPS/KF3z+o6ODKfVsAuiBrQ0FTrA1dIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waLK5FSLcxJCbYvwoPBoQAUTK4clOYTWVr/2+kXybDs=;
 b=keR/JWQjxKWY73p17237vqopGxt/b9nP9J2gH6jFlwS0UKzgHm8SOPVnVupbZJBJXcIYeuU8a3kjWaJgy0cxejzV5Rp0wlKoEwLNHwogIN3JFqHf2UCXurWAfb6Y+7BkM+K/cDoXWSuHZjvv6ctRXeFBoiwfvuOwtqxRO2GJ2aiEKjaclUJg8sbejZo48GIfk/njdAryJtUSeI+tPeczDXCEVcMmW3ZlJq439B1Ml/oSOWNqSNJb0J3+SmXTH5o43oEWnK5RAIefzR0p+oeNAg24c98MBOGLh0Z2oLW0o/WjGa5qcUF3lA0hvgAtzXUY7Xe7Rw11z94X/hc/j9jveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waLK5FSLcxJCbYvwoPBoQAUTK4clOYTWVr/2+kXybDs=;
 b=QeH4Kk+93Jf7HxiLmyaadQi6aDMdgD3SpESyLyc6YGind4HPchRiIbibVSbBTIjwyVGvmpjD7ThmItBnXhs3ZsltsXKV+mUWRAxx/p42VywZNCuiOJFlQgOMkCskWcNCVjRLMVh22N17Tqp9LAUOQQtniivTa5ODUcVYB1bf2yo=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DM4PR21MB3320.namprd21.prod.outlook.com (2603:10b6:8:69::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Mon, 10 Oct
 2022 19:38:03 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::e19e:c7cf:1bf0:1a75]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::e19e:c7cf:1bf0:1a75%7]) with mapi id 15.20.5723.009; Mon, 10 Oct 2022
 19:38:03 +0000
From:   Long Li <longli@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [bug report] RDMA/mana_ib: Add a driver for Microsoft Azure
 Network Adapter
Thread-Topic: [bug report] RDMA/mana_ib: Add a driver for Microsoft Azure
 Network Adapter
Thread-Index: AQHY3Jbdh/3dspAImE+N1LJgxQYyBq4IBlvw
Date:   Mon, 10 Oct 2022 19:38:03 +0000
Message-ID: <PH7PR21MB326396C961B6CA6FDAB36296CE209@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <Y0P6GI5RWHpaPmQP@kili>
In-Reply-To: <Y0P6GI5RWHpaPmQP@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=25744acd-79ae-406b-80bf-f23fbe5e6e4e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-10T19:37:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DM4PR21MB3320:EE_
x-ms-office365-filtering-correlation-id: 4efeb4dd-14cf-45de-9b5e-08daaaf6f27a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BdQBoubAbwTFL738iukZ/jOBI711T3IygvalP3FXzgw3AHVnZ5pDoWWUjbTQPnNe8NvtjIMRmP3/EYjQtaJMt3UUh6ZBq3VrwNwRLzsKMNF0D3OHDp0WZX/jfn8HlC6ChlqyG3SYC51MWuNc7/1VdFgpwma9bqBIZNaYrDPNLNytp3w24qayI5Px5I8VbL8oKvVIptavuKX4Jm1YFiHAPBdp27/QCOceOR4uAeKTpgdJ7y7tyq7kTmggC6VHqdyPX6APa0W9lY9YLjJ4QQgCCDLhXXc1mikHgIXD6TqiPfylPinRQs/rkVCSUMjbvcXzyaAK2Pi+w3eNhAHbyFN5+/zrVn1+2XGRW2AlgXs+J5e8Sw8Zb8qkkkx4UIyD9YxR1jl3DEZ4PjflmtNUxKV3b1ZCRQUWxJo4Q+dblAWSzrHtJN7GkUFYxM+NIr6Z5ZrD3grd4p8yby5mUQPG9tQEBeAyDMvun5TR5uwlDSYS2fADbNW0ULffI9P19PryHZN6kF0Wb1Yw08TT+DU+nKoYE0c/kRTOTto7blVFEEhf8ZWpuVjcs+JL5ojdolHUAh+UwgocFURmbEtqfoS1YGc6Kmscwr3Ictn8WsqoP7dCXC3XVOoser8sUSTVwGEhlV6aM51TUXlJBu7GTO4c5sFFH2ylgMdtGMcj3yrZ3yLMQK06VhfGPJeldxfauyvXb5b2uio73ecKw9QSW9MK1x2IDArPorbQnwKq2GMfOBocAT6gGUrnu3JyQeWC8TNbBEK/prp6oXNiR1X+7H7gLgpII3qezsJEM98HPldjKIWYNsFTSivhRbPqMcannyCYIxaw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(47530400004)(451199015)(8990500004)(2906002)(82950400001)(82960400001)(38100700002)(86362001)(10290500003)(6506007)(7696005)(26005)(38070700005)(71200400001)(6916009)(9686003)(33656002)(52536014)(55016003)(5660300002)(122000001)(8936002)(76116006)(186003)(316002)(66946007)(8676002)(66556008)(66476007)(478600001)(41300700001)(83380400001)(66446008)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vOQ+8Xg5vX7taFor5C+FJw/8IPZAY8RCxtob2iAex1QIKlgDv8RaOeZdC4qA?=
 =?us-ascii?Q?nNGpC7NhT+9C+l4llSWfOmv8Q8h7esIK9QDgxEnfmA6Vzf6yMFgFeKq8ALZe?=
 =?us-ascii?Q?49XGid7Rx1JVLwDbQjsiDb0zhWh66uWl642nNPhOiafokFT+BBLhTaSb5jie?=
 =?us-ascii?Q?h1O1ETKLPgd0rUmAEonisyaoZEGEz418mFv9D3x25ghXKG0EQxNCHE/+qiDT?=
 =?us-ascii?Q?firCGHufG9ejYD67kZdvD1GxIVgYGPRuHSVZaKjbuqJZQ7BFs/8R3BHaC25v?=
 =?us-ascii?Q?mOGRECkkFZ9Prwzul90HwReGroSeWjuBHYR5gkmfIDVSHSmaUZXpU7PLxnBD?=
 =?us-ascii?Q?gbT/C/vdZzDI3QJDDcOIbyJ8cS3EK/VCTeFpgUvsssbhRsN+XYYUB24Kz0qH?=
 =?us-ascii?Q?khp4YIfqJc6nMmcUgCSk1LO+uSKXgxvheBi8fcjV9sfJ/NNe0YuUuh/Rrn5B?=
 =?us-ascii?Q?OKxwkbGHoHQ55hlPYc7AbIMFo7JR45MqgNtLXNHpJBdynoTx5ydpiZ+E0sIw?=
 =?us-ascii?Q?zj6aa/n5xPxGK6Pf5lFsymbtvyfRvB9Imur8hzVZZL4f1XjrZwY2yfZtnvhK?=
 =?us-ascii?Q?hDVbFGChCWXcA/Crbfyd4IbQTuOewrY3dC5fcWabrrEoZqaGUICgJDqjYGyA?=
 =?us-ascii?Q?m7ATREugSXb2yvdE9caRYv/LTwd0xCmEf4DkrkGoQF5NkDR0k6uwNag2bMqZ?=
 =?us-ascii?Q?Ug4VhiuNQkhMSl9yAS0JqU6KXIfS0HX5S7U/9kPN6cvyYufIfXxRRztWO3mY?=
 =?us-ascii?Q?Dq6M/jJwRFWM5U5X0IqMqD1kHrZOTlmAuHGuBQIZ00KK6bdqhDAkcrDt4Max?=
 =?us-ascii?Q?usmkHeen2gWImqXnHkshqSxvwV5i2R6irB9jw6Wwk0WkkoMEiCp5VfiTTrk1?=
 =?us-ascii?Q?4pE7OpGGUysH7Vc9HIRW9F78ReH36i0Cjh7PeZYYYurBrE6lG592VGCt976t?=
 =?us-ascii?Q?qrqRBhRRGjiCwDPCKFlj85w54xuBxuj5CJ4cXQd2wD4FoEjFQwAp2tICXiBW?=
 =?us-ascii?Q?2MHpU2NBc1oLdgqATcv08Yk4k+eFSM60BfaQLxAKtkTPIMUJovPVpnKdRx9i?=
 =?us-ascii?Q?oeB6kZ5ibaikcc7BfcOh/aK1AMePbZ4kYQ0QM1DC9HO/+CWwhbZee7hg/uRv?=
 =?us-ascii?Q?zeYCU8PmXjeBIh2JmkWWfIzGRtL0qRYskbaFC7YmzqnU0qo52HPY4EQCnYWO?=
 =?us-ascii?Q?OqcxQdQ0Xc7AcNaSXO+KGFnUha1URJtRN/WNkcaQ89W5asMnYYf/NuG6Wb5Y?=
 =?us-ascii?Q?ojT5kDyuZF2Ld6Zpl1DJ5DwDrYykPoTT0Eivpy5Aan0EnWlAxtJuqav2htGF?=
 =?us-ascii?Q?t37w04hEv9bMQA7/JtXPonyYa3ARbN4T/x8x5xojhqpedvtyuMyOM3yRAu0v?=
 =?us-ascii?Q?KmNX+6p8cSMHY/DXdSi5eF6Y0AKDNGxvx0Rob4T50Db3Yn4fIhDYYGtBSvAq?=
 =?us-ascii?Q?RPnAIjOsxYKNnAf1BEdnEQd/QKPWqMYrXJGw6kBeQCL3LQLUfO3e6NpnFAlu?=
 =?us-ascii?Q?QdXijOC5zX21em3O3dkNupYO1Tai5xOA3sBb0fMV3gTMQC+xKMidPyAXywup?=
 =?us-ascii?Q?8n3ckrlD1TapiSDGa3blRaMP7A+JMW8Je33QTfzK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efeb4dd-14cf-45de-9b5e-08daaaf6f27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 19:38:03.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODMHTLi1PMZ2cBs6zqHltD4ZSe9Xa0u1m+tDOkuRQSeX/5ugC8ny4Cs9Pdnqvgd1ErCceSsjXqJz61uUt/oXNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3320
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
> The patch 6dce3468a04c: "RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter" from Sep 20, 2022, leads to the following Smatch static
> checker warning:
>=20
> 	drivers/infiniband/hw/mana/qp.c:240 mana_ib_create_qp_rss()
> 	warn: 'mana_ind_table' was already freed.
>=20
> drivers/infiniband/hw/mana/qp.c
>     91 static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd =
*pd,
>     92                                  struct ib_qp_init_attr *attr,
>     93                                  struct ib_udata *udata)
>     94 {
>     95         struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_i=
b_qp,
> ibqp);
>     96         struct mana_ib_dev *mdev =3D
>     97                 container_of(pd->device, struct mana_ib_dev, ib_de=
v);
>     98         struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
>     99         struct mana_ib_create_qp_rss_resp resp =3D {};
>     100         struct mana_ib_create_qp_rss ucmd =3D {};
>     101         struct gdma_dev *gd =3D mdev->gdma_dev;
>     102         mana_handle_t *mana_ind_table;
>     103         struct mana_port_context *mpc;
>     104         struct mana_context *mc;
>     105         struct net_device *ndev;
>     106         struct mana_ib_cq *cq;
>     107         struct mana_ib_wq *wq;
>     108         struct ib_cq *ibcq;
>     109         struct ib_wq *ibwq;
>     110         int i =3D 0, ret;
>     111         u32 port;
>     112
>     113         mc =3D gd->driver_data;
>     114
>     115         if (udata->inlen < sizeof(ucmd))
>     116                 return -EINVAL;
>     117
>     118         ret =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd)=
,
> udata->inlen));
>     119         if (ret) {
>     120                 ibdev_dbg(&mdev->ib_dev,
>     121                           "Failed copy from udata for create rss-=
qp, err %d\n",
>     122                           ret);
>     123                 return -EFAULT;
>     124         }
>     125
>     126         if (attr->cap.max_recv_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
>     127                 ibdev_dbg(&mdev->ib_dev,
>     128                           "Requested max_recv_wr %d exceeding lim=
it.\n",
>     129                           attr->cap.max_recv_wr);
>     130                 return -EINVAL;
>     131         }
>     132
>     133         if (attr->cap.max_recv_sge > MAX_RX_WQE_SGL_ENTRIES) {
>     134                 ibdev_dbg(&mdev->ib_dev,
>     135                           "Requested max_recv_sge %d exceeding li=
mit.\n",
>     136                           attr->cap.max_recv_sge);
>     137                 return -EINVAL;
>     138         }
>     139
>     140         if (ucmd.rx_hash_function !=3D
> MANA_IB_RX_HASH_FUNC_TOEPLITZ) {
>     141                 ibdev_dbg(&mdev->ib_dev,
>     142                           "RX Hash function is not supported, %d\=
n",
>     143                           ucmd.rx_hash_function);
>     144                 return -EINVAL;
>     145         }
>     146
>     147         /* IB ports start with 1, MANA start with 0 */
>     148         port =3D ucmd.port;
>     149         if (port < 1 || port > mc->num_ports) {
>     150                 ibdev_dbg(&mdev->ib_dev, "Invalid port %u in crea=
ting qp\n",
>     151                           port);
>     152                 return -EINVAL;
>     153         }
>     154         ndev =3D mc->ports[port - 1];
>     155         mpc =3D netdev_priv(ndev);
>     156
>     157         ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d port %d\n",
>     158                   ucmd.rx_hash_function, port);
>     159
>     160         mana_ind_table =3D kzalloc(sizeof(mana_handle_t) *
>     161                                          (1 << ind_tbl->log_ind_t=
bl_size),
>     162                                  GFP_KERNEL);
>     163         if (!mana_ind_table) {
>     164                 ret =3D -ENOMEM;
>     165                 goto fail;
>     166         }
>     167
>     168         qp->port =3D port;
>     169
>     170         for (i =3D 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) =
{
>     171                 struct mana_obj_spec wq_spec =3D {};
>     172                 struct mana_obj_spec cq_spec =3D {};
>     173
>     174                 ibwq =3D ind_tbl->ind_tbl[i];
>     175                 wq =3D container_of(ibwq, struct mana_ib_wq, ibwq=
);
>     176
>     177                 ibcq =3D ibwq->cq;
>     178                 cq =3D container_of(ibcq, struct mana_ib_cq, ibcq=
);
>     179
>     180                 wq_spec.gdma_region =3D wq->gdma_region;
>     181                 wq_spec.queue_size =3D wq->wq_buf_size;
>     182
>     183                 cq_spec.gdma_region =3D cq->gdma_region;
>     184                 cq_spec.queue_size =3D cq->cqe * COMP_ENTRY_SIZE;
>     185                 cq_spec.modr_ctx_id =3D 0;
>     186                 cq_spec.attached_eq =3D GDMA_CQ_NO_EQ;
>     187
>     188                 ret =3D mana_create_wq_obj(mpc, mpc->port_handle,
> GDMA_RQ,
>     189                                          &wq_spec, &cq_spec, &wq-=
>rx_object);
>     190                 if (ret)
>     191                         goto fail;
>     192
>     193                 /* The GDMA regions are now owned by the WQ objec=
t */
>     194                 wq->gdma_region =3D GDMA_INVALID_DMA_REGION;
>     195                 cq->gdma_region =3D GDMA_INVALID_DMA_REGION;
>     196
>     197                 wq->id =3D wq_spec.queue_index;
>     198                 cq->id =3D cq_spec.queue_index;
>     199
>     200                 ibdev_dbg(&mdev->ib_dev,
>     201                           "ret %d rx_object 0x%llx wq id %llu cq =
id %llu\n",
>     202                           ret, wq->rx_object, wq->id, cq->id);
>     203
>     204                 resp.entries[i].cqid =3D cq->id;
>     205                 resp.entries[i].wqid =3D wq->id;
>     206
>     207                 mana_ind_table[i] =3D wq->rx_object;
>     208         }
>     209         resp.num_entries =3D i;
>     210
>     211         ret =3D mana_ib_cfg_vport_steering(mdev, ndev, wq->rx_obj=
ect,
>     212                                          mana_ind_table,
>     213                                          ind_tbl->log_ind_tbl_siz=
e,
>     214                                          ucmd.rx_hash_key_len,
>     215                                          ucmd.rx_hash_key);
>     216         if (ret)
>     217                 goto fail;
>     218
>     219         kfree(mana_ind_table);
>=20
> Freed here.
>=20
>     220
>     221         if (udata) {
>     222                 ret =3D ib_copy_to_udata(udata, &resp, sizeof(res=
p));
>     223                 if (ret) {
>     224                         ibdev_dbg(&mdev->ib_dev,
>     225                                   "Failed to copy to udata create=
 rss-qp, %d\n",
>     226                                   ret);
>     227                         goto fail;
>=20
> Goto.
>=20
>     228                 }
>     229         }
>     230
>     231         return 0;
>     232
>     233 fail:
>     234         while (i-- > 0) {
>     235                 ibwq =3D ind_tbl->ind_tbl[i];
>     236                 wq =3D container_of(ibwq, struct mana_ib_wq, ibwq=
);
>     237                 mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
>     238         }
>     239
> --> 240         kfree(mana_ind_table);
>=20
> Double freed.
>=20
>     241
>     242         return ret;
>     243 }
>=20
> regards,
> dan carpenter

Thank you, will fix this.

Long
