Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6B773C62
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Aug 2023 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHHQFT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Aug 2023 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHHQDp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Aug 2023 12:03:45 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB710FB
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Aug 2023 08:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk+sIB71xLQsY5Y40PZHN/wevsjN67yPMaExitZ3zAMrEZqnVNWoCd2/8QhG5ib5+iffwRqCDp96TpO/5Nd+QSqMHq6fykQk90CAn2HZCqmsPTQ6AxGEDqSgiM4Ut2ZtqEPno7EoiRtg41yO65SSqrgGgxSvlJxybspVKa5rxr6ZjO2ber9dHAU5lYkbZ4O7gb8Vd2daBQlKAW3y8PaCIxdLg8Pn8rniF3IhvxUz/Dh4MLDcl7faMuOz7Q9ls5sHnbw+IkElO0GEwjVoxctvfWNXd6dboKZqkpRy+YZE2OoDxEKOSO7PMkQ8XHBVeX4rzV54ngaTFfSsNQTd/6ff3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+xVyg0LhKLq4Pqeb1J0gC2R+wCWn/VwZ7ZRdfXsf8w=;
 b=XWMlsdDyToK92bm3A9ZlsgF5ICf4NNY1sZwB+zl34xqsg2KaUWh7zV+/8poBlNKRFv9yULOVyiYWL2Yiw3U0dkchMyJI4rIKV5UealXTPRtpOAJP89PPZabJviQtp8RK4aADHkKRcwy3NFTSZDPY0QErTljYjAm+ACHeNY1AXsYWUA58G5N6voTobqkzUy/PTf8x8lTwEYLIRkMnkHYrqJ2w+0Hl3GYO8ZpSEqTdOW8OEUy7h0X/j6Dm0s2JEQwTILxbnHjjh9Y44KR69hxK0+oLJwSozh1CXxfsjVV4aIzuFqBOQ/EJve9YcwB0gzMsBTKB2zSxbm5vzcriFb7D6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+xVyg0LhKLq4Pqeb1J0gC2R+wCWn/VwZ7ZRdfXsf8w=;
 b=YcnKeLRa+2S+Flqf5GyvZkwX2B5EyKGeEVttv+AZNasFVyaoVvIaPZoQjGMAey4AMYQhKDpg1d8DAlwVVBvKxZbEkBDVBseWgNciQ7v2g3DoyQUdLcQ6zJ1dUE3EnvBFy3FEWAePmCbgot6AFzmXyPiFfEeg97KqAJHCqR3+cP4=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by LV2PR21MB3133.namprd21.prod.outlook.com (2603:10b6:408:179::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.0; Tue, 8 Aug
 2023 15:12:08 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b%7]) with mapi id 15.20.6699.004; Tue, 8 Aug 2023
 15:12:07 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [bug report] net: mana: Add page pool for RX buffers
Thread-Topic: [bug report] net: mana: Add page pool for RX buffers
Thread-Index: AQHZyb8XkSRZn0beJ0CwaD+fYgVbeK/gf44g
Date:   Tue, 8 Aug 2023 15:12:07 +0000
Message-ID: <PH7PR21MB3116FB9E14746215B1C9D4D4CA0DA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <72639c0d-9cf5-468e-ad6a-e36c25d63b02@moroto.mountain>
In-Reply-To: <72639c0d-9cf5-468e-ad6a-e36c25d63b02@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=84691aff-4267-4828-91a4-24309866884f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-08T15:03:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|LV2PR21MB3133:EE_
x-ms-office365-filtering-correlation-id: 595c4c7a-89c4-4004-25aa-08db9821d4ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYVz/kWzK/JJeJiSRk0EYYawFITX3jD/P1rBZK3JtK3WcMLtp6bHQ20iN8ODq//oo4K6oUCwcSU7b4yfYhFIh8gxSSZXr1x1GvmOZz7sNkSrXl0UsFOqaqsWCHDJ6FnANmJcNqAl0l3J/UDg4sJTrdJe/W31VcpHPu6kGzaMyCua/1Pr5LpqE0Hl430T7Kd7S6V25R8brzomwbXH/S1Hx1YgsHzw7WRnsMO2LtmYiRuUI+5yYfk5PKqXiIcItJCj4iv9ubyD7VUSiuoNfCS+Ncax7J3QuzVIX0hTE6CHwQxFCjtXewPYYIHu1uYo0u57dEJeYju6pZWHu/87B49Ak1WHUpW1rS33HgYpU95XM3ABUdAol3oEaG2daILdZCu7/VCp8epYITKOitUgbelZ0Efn5+Lvu+BQFokZus3yJvXfDDAiVLhcMxb/3+jd3ret9t93TTi75P9U/KPD6w8MACU/zboM6pvlfQ4/gzCR8CPQfciaMbnwY7/8mPtVcSYX7934PUvDL7p/PXO0HFUB3dpaRqtVpIy/vSokTp3wl/nhs3d9/XC9FGJw8AXzFT/935uKRhvl4903PQ4ThAKeRvBqgmXO7bqvrD4rGladukumPCqaXopW2hDDKLGxqDDzTZJpty4tGqkRVltPoNsi0hvCyZ9oVWdkYo2GPJiXPe3BJcFXgptdUla9NlmmxZZz86W+PTByCio6g6YkywTUcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(376002)(366004)(346002)(1800799003)(186006)(451199021)(966005)(9686003)(12101799016)(478600001)(76116006)(4326008)(6916009)(66446008)(66476007)(66946007)(66556008)(64756008)(10290500003)(7696005)(71200400001)(316002)(786003)(8936002)(8676002)(26005)(41300700001)(6506007)(53546011)(86362001)(55016003)(52536014)(5660300002)(2906002)(38070700005)(83380400001)(8990500004)(33656002)(82950400001)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CgJAICMk1vGf1AS3a2838FU4C/hp90Y81t+qj6Xp8VEt7ZUjEVD7YJPW8Yx9?=
 =?us-ascii?Q?cKKNFsOZHfgHvLBZ7mWefzV46qjHNXTkfd/WxS4grbIj4fKWixJruYPNEOvT?=
 =?us-ascii?Q?B8UBNb67i86xqhYy7GmEnoNu2ZOgCVkh3ZkalKf2sxi3e4+ZDKhK+eqR/NN/?=
 =?us-ascii?Q?XEqwgbxg+8/kWuhdgyWo2zR+wAzL6hM4qH26HnEQ9nZQM45+cO6JnT633U7b?=
 =?us-ascii?Q?ALOL84yJan/szWVfYMRif4Ce5HFLOBlj7ET3A58lFKCWhGgTb+O8RX1zrd3l?=
 =?us-ascii?Q?FtIDeXnL1MiI79g7k+4OQzyNm7cu+kzrPj5qJxaXc1W2/Qah06ZAv6y3R+x+?=
 =?us-ascii?Q?8dA8y8e5CgyYLOxLSmpl6p9/8pxyCZPF+8UmzodC+dg4fsFJWNWJEj2Nz7Qs?=
 =?us-ascii?Q?D3qSb62IwEPqr+e3lfjTi9G2qNHJnXbTZ9uEnS9pr25VBOvtwD5yhAaAffiV?=
 =?us-ascii?Q?0v+lHFNmN+3ov5Jg9S9zjU7IGDNM6W4YhXwBznrOGLwWKpYQLAzwYDMetGED?=
 =?us-ascii?Q?hxgaiMgl9lL9yK+cOz4edE/DaBhbzc+oiU8Y1AnnbiERCao5ceesj+RGH9vW?=
 =?us-ascii?Q?42WNr5p2M3Fjoj9MIQPtl8MNjds0e13gEKCaCHtdC4C73JQg0/bUXEjaBjob?=
 =?us-ascii?Q?LXioCTQG/zM7MRa1EkM0IJTUyxAXi8FCx9b8W7QC+u7jr2+SmAdtCR6oOn0w?=
 =?us-ascii?Q?9/VHbBP9tJ9vmcy89KjAcmbUbnF6jSI14mvwb1P47O4BQPV/bGQdAKTRvG2t?=
 =?us-ascii?Q?k6xwO/W7je8sMvUkg6TIr6So7AEwX2CEQ5ZSOeznGgWF2Ya6kDfs1EViXK8q?=
 =?us-ascii?Q?9Urk06YCEM4uUHYm/mMTRMiDVzL1nsAO6SVIA7YizBtjCIZaGekAjMGtrxkG?=
 =?us-ascii?Q?+CLKTiz8dMd44B921YuUZbUN7su26S7XFvHyY+qqmCvKq/m3T94rNOekyMql?=
 =?us-ascii?Q?OLRdkfo0pEgw8HZVDgfGC8Sg+c0BVFKvMWeUeG8/IllfCklCTR267NJeApvW?=
 =?us-ascii?Q?KpHl4VIObPeHB0gdVDHLCmjYNVp7GowVhE13BtfBIHhkZEyKgrs8MGt/X8CV?=
 =?us-ascii?Q?KNcVclhY/QO1cTCX/H4YKc9gHshof5J2+0L6AMwKdj4cQL20IWJcrFad9wgn?=
 =?us-ascii?Q?jhP+aTG6p6OXSHy0WFpySwgQtwadrm3nh6BV0bkSwVMXy8myNTvPUTIn7duL?=
 =?us-ascii?Q?f9EesCNOzti03KrQ+2LAO4/3xQCNfuTovhoXi12SdW/mleUQE8bN1WtLOAzB?=
 =?us-ascii?Q?uNhE+hbYNjBxw9a4FLM/aRaiSZY8ATKOULu3k3wZ01HHN/Mh0xe5X+cviky2?=
 =?us-ascii?Q?JN1OSLupfAlIQNgGFb09aWi8SgtT7qgdZU7eS4Uc8Hb1ivlHwnJghs4s0ie6?=
 =?us-ascii?Q?vKXTj58tJKoHzHf3kwTnH5Gm1dmGNSkYFh7hMcM0aUsEt+p4tKrDp7AvsNc+?=
 =?us-ascii?Q?9Z6OpEmRVSoPyBH1a0nsHK3AWySkX31zFFgNkFrHUdIkBzgHZ4wAFnQdEhUf?=
 =?us-ascii?Q?KgjZ43L9kqQz0UhBUQWIbVxqC/GoCRO9AcqdZf0fzq55CbRU7+KTIZBtomW7?=
 =?us-ascii?Q?WAqC4gaN5IX0k6L+a/A5KF8LwmMyz0u+5SOFtxLr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595c4c7a-89c4-4004-25aa-08db9821d4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 15:12:07.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOGCspwIa8zOHS2wdijwFhjGfs8lNdKImJEPloRm5PGZr2F10+7Zybj8vRQa9eMnOUU1EBnZG5g+sX+l6GvX4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, August 8, 2023 2:11 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Subject: [bug report] net: mana: Add page pool for RX buffers
>=20
> [You don't often get email from dan.carpenter@linaro.org. Learn why this =
is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Hello Haiyang Zhang,
>=20
> The patch b1d13f7a3b53: "net: mana: Add page pool for RX buffers"
> from Aug 4, 2023 (linux-next), leads to the following Smatch static
> checker warning:
>=20
>         drivers/net/ethernet/microsoft/mana/mana_en.c:1651
> mana_process_rx_cqe()
>         error: uninitialized symbol 'old_fp'.
>=20
> drivers/net/ethernet/microsoft/mana/mana_en.c
>     1592 static void mana_process_rx_cqe(struct mana_rxq *rxq, struct
> mana_cq *cq,
>     1593                                 struct gdma_comp *cqe)
>     1594 {
>     1595         struct mana_rxcomp_oob *oob =3D (struct mana_rxcomp_oob
> *)cqe->cqe_data;
>     1596         struct gdma_context *gc =3D rxq->gdma_rq->gdma_dev-
> >gdma_context;
>     1597         struct net_device *ndev =3D rxq->ndev;
>     1598         struct mana_recv_buf_oob *rxbuf_oob;
>     1599         struct mana_port_context *apc;
>     1600         struct device *dev =3D gc->dev;
>     1601         void *old_buf =3D NULL;
>     1602         u32 curr, pktlen;
>     1603         bool old_fp;
>     1604
>     1605         apc =3D netdev_priv(ndev);
>     1606
>     1607         switch (oob->cqe_hdr.cqe_type) {
>     1608         case CQE_RX_OKAY:
>     1609                 break;
>     1610
>     1611         case CQE_RX_TRUNCATED:
>     1612                 ++ndev->stats.rx_dropped;
>     1613                 rxbuf_oob =3D &rxq->rx_oobs[rxq->buf_index];
>     1614                 netdev_warn_once(ndev, "Dropped a truncated pack=
et\n");
>     1615                 goto drop;
>     1616
>     1617         case CQE_RX_COALESCED_4:
>     1618                 netdev_err(ndev, "RX coalescing is unsupported\n=
");
>     1619                 apc->eth_stats.rx_coalesced_err++;
>     1620                 return;
>     1621
>     1622         case CQE_RX_OBJECT_FENCE:
>     1623                 complete(&rxq->fence_event);
>     1624                 return;
>     1625
>     1626         default:
>     1627                 netdev_err(ndev, "Unknown RX CQE type =3D %d\n",
>     1628                            oob->cqe_hdr.cqe_type);
>     1629                 apc->eth_stats.rx_cqe_unknown_type++;
>     1630                 return;
>     1631         }
>     1632
>     1633         pktlen =3D oob->ppi[0].pkt_len;
>     1634
>     1635         if (pktlen =3D=3D 0) {
>     1636                 /* data packets should never have packetlength o=
f zero */
>     1637                 netdev_err(ndev, "RX pkt len=3D0, rq=3D%u, cq=3D=
%u,
> rxobj=3D0x%llx\n",
>     1638                            rxq->gdma_id, cq->gdma_id, rxq->rxobj=
);
>     1639                 return;
>     1640         }
>     1641
>     1642         curr =3D rxq->buf_index;
>     1643         rxbuf_oob =3D &rxq->rx_oobs[curr];
>     1644         WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu !=3D 1);
>     1645
>     1646         mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_f=
p);
>=20
> If mana_get_rxfrag() fails then mana_refill_rx_oob() doesn't set *old_fp.
>=20
>=20
>     1647
>     1648         /* Unsuccessful refill will have old_buf =3D=3D NULL.
>     1649          * In this case, mana_rx_skb() will drop the packet.
>     1650          */
> --> 1651         mana_rx_skb(old_buf, old_fp, oob, rxq);
>     1652
>     1653 drop:
>     1654         mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob-
> >wqe_inf.wqe_size_in_bu);
>     1655
>     1656         mana_post_pkt_rxq(rxq);
>     1657 }
>=20
> regards,
> dan carpenter

Yes -- If mana_get_rxfrag() fails then mana_refill_rx_oob() doesn't set *ol=
d_fp.
But in this case, the old_buf remains NULL, and the following code will dro=
p the
packet without accessing the old_fp/from_pool.

Do I have to initialize it, or just add a code comment explaining like abov=
e?

static void mana_rx_skb(void *buf_va, bool from_pool,
                        struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq)
{
        struct mana_stats_rx *rx_stats =3D &rxq->stats;
        struct net_device *ndev =3D rxq->ndev;
        uint pkt_len =3D cqe->ppi[0].pkt_len;
        u16 rxq_idx =3D rxq->rxq_idx;
        struct napi_struct *napi;
        struct xdp_buff xdp =3D {};
        struct sk_buff *skb;
        u32 hash_value;
        u32 act;

        rxq->rx_cq.work_done++;
        napi =3D &rxq->rx_cq.napi;

        if (!buf_va) {
                ++ndev->stats.rx_dropped;
                return;
        }

Thanks,
- Haiyang
