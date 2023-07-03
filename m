Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AF746019
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jul 2023 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGCPve (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Jul 2023 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCPvd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Jul 2023 11:51:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2124.outbound.protection.outlook.com [40.107.244.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6DC2;
        Mon,  3 Jul 2023 08:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMd6S1jjvHufR9Sad8Yz+NZXvN8LAP9WyJ9spbxhpMHiLxPB/23j/PMlswtPWiPeL3k1AHgiArpbQx8qDWw5Fh5omvcqBehKMfc0rDQXNx0koe5i4meyHyNUv5OSnDPY7Ss3sxGgSiwl9sIod9YeeeubwrVUC5ejg9qalYPtJLnrDFesGvf8SYPqe7k2VDYB2ihwQxYJArNKX0SXui8JNFNxvKBCQWV/sKgMJNn/4gWfwHdRUr0D5P7EpUPAGuW/zuDI796TGl39734zAbLELyJ6KfyrAMpmvdw0zi7L8s+gJMRIcS10EkJ4u4xNmpr2fjuUJQXaDCDAC1F/wjZ+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxLKuqzB8F3ZwItGN/CCzSImCLnYoPoXp8nFK1ZVaK0=;
 b=av6UWM+e93l6F0EcHxICwW44u5nqlPLDf5bhaq+PE2ksyvLMJ6QOmHrq9Q2i4My1iRM74uweudefXNyiqeGIxC8Zvgeh5ZJ+N0wM0CcYgMRtmaE5PrH2RCPOM+ojKr8v6HlK/PAtC/jzbgTrYL99CYzrA57mtYs8xl+4faYdPuirr8xetfXMGTc/qoxtj1iWpjzORhbWAv+mhLn9YEtd837kxwtPvDj3p+xJnI48Vwyd3kiLvF9PuQ6k4gfw5dRjvMnQw1tar4ciF3/+7t2PYKsyYmLS+420vJywmN+hjDl3KXVrwxmHrOdbQQk76iZ+ta6JYDP0QzQ+UEOwCEzFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxLKuqzB8F3ZwItGN/CCzSImCLnYoPoXp8nFK1ZVaK0=;
 b=e5Zd/I53k3pZt7xS35Qews8W2WHkM9VyQOkq9qFZDNiZjaWZpXuMNr+i8f6BBz9n5UOqnwiK8QpjKHuq4Nnl8hXxpwAxzedLw6abWPUUNzeYypudieg6KwZSXeqAyjps4hNAm/phDe4F5SNb1R99AIIQbk6+SS9Bv9EHNiDSHm8=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DM4PR21MB3682.namprd21.prod.outlook.com (2603:10b6:8:af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9; Mon, 3 Jul
 2023 15:51:28 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Mon, 3 Jul 2023
 15:51:28 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH V4 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Topic: [PATCH V4 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Index: AQHZrYtO9uZDC1JBBkmdomCootYeWK+oLtxg
Date:   Mon, 3 Jul 2023 15:51:28 +0000
Message-ID: <PH7PR21MB31166AAAE7225559D751F722CA29A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5f961a7e-ca82-4161-a6dd-538abc496366;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-03T15:42:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DM4PR21MB3682:EE_
x-ms-office365-filtering-correlation-id: 88375292-f5c5-433c-58ff-08db7bdd5d46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ylwkPHfIky+3RiEbfjij+bxL5rto0jxS/RX9uZhN/ogIicbRlo12j6m9IvzN3oYIbO6DdoGSM4m4TBuBOcyiHMX4H9LFmGN3qmQ6iICeKH+/W8iHqSWQXg+LvouAvDVpOdGs6bFERqHBm890Smll1ZrA71Wdu85TKgynpmhiSoNPa83oi9p3LJ3NmOgHjvTFnIseEvUdXE8nIAjCN3HRaCrU2fIOZtw7I8jaOyb51gqZk12hOtlEHeV+KbYJ1Pn3FXl9dEpBN7BpyevQh953pCN4AwcYdS1KzGCwPQ1nmUC/GpZoxk88izXVZLzh9Y8YFkZnQpKzjq1cBH1WLWrHqIxmg7z5a5arQGQ5auS8BcSwuWZyW5bIHXBW3scdHuJlZ3ppYp/WdAq7vngjNtXfP2PvxtMhL/PsE+I6A/7lAs+UxHOABycPlEn/4hRt1lpOf3pFYtruTHop3S1W28kLk0c2TfIDWw/zgzSVBGdw0qLiAI56z75xIVwoTnZZ47IzQ0ubaRTTHwlxfEaTAbE48SZ3mTqL3rSgN/AG6waoLo0TKwK4sWz5KGzbIqSA4MuPaJLysrxRRZckgHxLmc1P0P0WIxkQOk918wchTu7e5f+EXLIwxTv8i147ZWEJO9wae5J2UZPl9bXh9yLFB8EKHM2MPBPpZGVK/8id4YjEeLN46cRlsguf7HU5UX0x/ZjG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(82950400001)(82960400001)(53546011)(8990500004)(921005)(10290500003)(6506007)(316002)(66446008)(64756008)(38070700005)(76116006)(55016003)(66556008)(66476007)(4326008)(38100700002)(122000001)(66946007)(107886003)(83380400001)(66899021)(186003)(26005)(9686003)(478600001)(8936002)(54906003)(110136005)(8676002)(2906002)(71200400001)(5660300002)(7416002)(7696005)(41300700001)(86362001)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xvvBdowBc+b8qZTXkTEyPmRdd65aORxRZH8iy+ReGGbUT/8Eq5DBFjPYL6qp?=
 =?us-ascii?Q?xHKepeEkEplPVp9JPAym0p7QRgw3pGn2vsHmf8af7CkjNgH4vPreggPB5N2L?=
 =?us-ascii?Q?RtfvEXiO/5MpqFNlHs8G2C33Faz2ENiKjX5NEA406RYMZkOlTs2/YZkmfsVV?=
 =?us-ascii?Q?czUGF2OB+vDFnM3HH3z97q6V3GyHdS7lblMhpmvpzsFyO+f7OlPLRz0AO12C?=
 =?us-ascii?Q?73Elc9CXiT2HXcjbBWu38Fdn3wDl1y1tjhCEESvR2RzEVSsHYd/1iJaoY41F?=
 =?us-ascii?Q?pckAk/AeHq6BTDM3+rsHPTVpjUQ3qV2DkVbGwck+5zhVBfoV4htrkSUIYXte?=
 =?us-ascii?Q?K4oq+bpdyV1eMg93QmkhxnPGzKWeZjrz2VrLy17+lLdcimaRglP7iTgp+GwN?=
 =?us-ascii?Q?EUSPnQV8z00Cw4v6kdD4V6orDVu1f0LR3SdE5Demhaf4yG+ekgJVZ1EJY2SE?=
 =?us-ascii?Q?HY4kR3uY3jNdsteh2z296lHkIIXzAOzR4BVuIbWyUwGa6BC5BhNfM4Au5nQg?=
 =?us-ascii?Q?3/XwH7mx13aT7gaWb0tRmCRewi8YiyhW5XbEoRxP2A9V1uY8Ct1gwx/mr7UW?=
 =?us-ascii?Q?bXdJzPlmzEdLdESW3frRbGmj3OO/pKWifZp47XDVgi+rUzTOsjP25Jd4uGha?=
 =?us-ascii?Q?3T2370L2wvqcEdJVtZXtibjjo6OGMF1NZS52HBiF2e/Sjw+EsHubmG5h5oUH?=
 =?us-ascii?Q?zF3TP0yQOdaFAwC77CgCG9IFOcMH4jmm5UQr9fQZ30QTVcxdu5xziUGvUMgf?=
 =?us-ascii?Q?pcwEe28GM8Pc75Z5MZWF6BYBQrlWunrkR8RT23T3z4c3uLtL5EXqdg56HfJx?=
 =?us-ascii?Q?zhG6byErd5bfx5gDccKu7635/8PIwu3l3FFSdcdvXWsNac7Gyr9l/QQsxDfK?=
 =?us-ascii?Q?1RRChE0kW+40X25XbWZ+5HCOfhEKmCZ54qaLqQgvj8KINIa42BMLAw3zQ6a2?=
 =?us-ascii?Q?GubXxDKTR4zPl9IFVVICDMWTN1HajNzcgB6JfPdVg67tCtlE6oSGdEBnTLiD?=
 =?us-ascii?Q?H4KRnuxm32FEwOK/wA2GzoDFsHHc1N+2pk5Gc1D5HjoWU6o/TQBoJbd4rxrs?=
 =?us-ascii?Q?+PRr8MZ0lCx92IKnadWg8K7Fgyyv/vFG15iUcajZT8IDcI99HRc6iNrpOn8g?=
 =?us-ascii?Q?WRbLZbkZUlAn0wLZ3Gu6PAR0Qts1gZnogD1Ppx7c/av1O0Ga1JnL1HKX8323?=
 =?us-ascii?Q?vXJnKQIKqc1zWO6ekw53TPBrRkmrzWzO0SamC/4DtW0psS+Hjy795yyFeoH9?=
 =?us-ascii?Q?nnreB9iSCSxL9g+rN9y7ewh/KI0Kir8nb+S6TyfWarx96ejcFZvLbijINZ2f?=
 =?us-ascii?Q?0oz1SD7RxIfgyEYUYw+b4JIHIXNU2Ya5GX+t7qFAlJcdYB5T2r5smHTj3Y4A?=
 =?us-ascii?Q?XxshStKt28eRLeI4tXw01J6X5qWP5aBXjZcVVgPIhg79+eem90EyacVgiCud?=
 =?us-ascii?Q?Sy7LhxghwL/+3PmhaVSdJ4wf62ikUEUhGPrha5IOt+49QsHoKTgMnwfTd93r?=
 =?us-ascii?Q?hozRTWUbBIj/GiFxr4v9QpS2V2QdJEWQ3nhY3riQLQOPxZTcPp4fpiLYctZg?=
 =?us-ascii?Q?2WuyfST+pK+yy9DxcIphAjJj+7SWziV83TEFvcZn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88375292-f5c5-433c-58ff-08db7bdd5d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 15:51:28.5333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeaWYQ9jeb1oTRlAf58puQkiqIAksTyiaMIxGfuA+1SMMa/4ON8D2PPjLZ1GKe/1p2PUxAQ0HlQDoC/VaxC78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3682
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Monday, July 3, 2023 4:50 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
> tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: stable@vger.kernel.org; Souradeep Chakrabarti
> <schakrabarti@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>
> Subject: [PATCH V4 net] net: mana: Fix MANA VF unload when host is
> unresponsive
>=20
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>=20
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
>=20
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
>=20
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V3 -> V4:
> * Fixed the commit message to describe the context.
> * Removed the vf_unload_timeout, as it is not required.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 26 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a499e460594b..d26f1da70411 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2346,7 +2346,10 @@ static int mana_dealloc_queues(struct net_device
> *ndev)
>  {
>  	struct mana_port_context *apc =3D netdev_priv(ndev);
>  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
> +	unsigned long timeout;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
> +	struct mana_cq *cq;
>  	int i, err;
>=20
>  	if (apc->port_is_up)
> @@ -2363,15 +2366,32 @@ static int mana_dealloc_queues(struct net_device
> *ndev)
>  	 * to false, but it doesn't matter since mana_start_xmit() drops any
>  	 * new packets due to apc->port_is_up being false.
>  	 *
> -	 * Drain all the in-flight TX packets
> +	 * Drain all the in-flight TX packets.
> +	 * A timeout of 120 seconds for all the queues is used.
> +	 * This will break the while loop when h/w is not responding.
> +	 * This value of 120 has been decided here considering max
> +	 * number of queues.
>  	 */
> +
> +	timeout =3D jiffies + 120 * HZ;
>  	for (i =3D 0; i < apc->num_queues; i++) {
>  		txq =3D &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
>  			usleep_range(1000, 2000);
> +		}
>  	}
>=20
> +	for (i =3D 0; i < apc->num_queues; i++) {
> +		txq =3D &apc->tx_qp[i].txq;
> +		cq =3D &apc->tx_qp[i].tx_cq;
> +		while (atomic_read(&txq->pending_sends)) {
> +			skb =3D skb_dequeue(&txq->pending_skbs);
> +			mana_unmap_skb(skb, apc);
> +			napi_consume_skb(skb, cq->budget);

This is not in NAPI context, so it should be dev_consume_skb_any()

Thanks,
- Haiyang


